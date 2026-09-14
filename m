Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD96486433;
	Mon, 14 Sep 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409049; cv=none; b=CwjtfRH3ur2hJcfx6Bb4EeCOVoHdWkROlotte/03gqNvl+3uhtEEFpyRzs9STqqkknOEQFDqansJ3JJ557+mAsvgYeUY9vNenLNIZhraDJ8vVnVP7Ey+xoYtryOpMTG8PpgywBJxFH2ymSyX5OsjpJTGzcgNu9RB4KsaJoNSk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409049; c=relaxed/simple;
	bh=ZUnyJvSfvQf/+1qB1TzF9Mo2CZ07AJi/g0lVpvGkQ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwlc6OiIQpwWCTvSA6ra2nHyv4jxUMRTDREjMPmFVICpB8ar57fXPcr+B5jtEWFcXvy4uWWq2uu6tmaob2jW+VdrPjQueXsSUAOjnnVfI4uYZLtFSqbJUhHVenwP78rrU/q/+xc+vCgrU2CmxLsAs2Zpkw7uNdsWnfb8zKEyjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=GLx9D2Gd; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="GLx9D2Gd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789409043; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KoqZItCTin+6stOEbAOp7G8XLkIXJ9u/snZJG1JONh0=;
	b=GLx9D2Gd+80Sf2zdV5htgldO3yDOcZYfJxp3bfxk7c6ZJu+mzbQ/py6Q9Q0/c01fyGaD91zxahqBb3YhKBmZhotlDMhDcsCZno/yLRH4UWLlWCiIyB2Q+8W9yjEQ6CudisWhnvOKh5t1wMDGKnYew6XEaSG0T2bHTcXJ+OVtOi8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04477426|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0082244-0.000528985-0.991247;FP=10884422329824779518|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jDU33YF_1789409024;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jDU33YF_1789409024 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 02:04:02 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: jason.wessel@windriver.com,
	danielt@kernel.org,
	dianders@chromium.org
Cc: kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kgdb: Fix buffer overflow in the 'm' packet handler
Date: Tue, 15 Sep 2026 02:03:44 +0800
Message-ID: <20260914180344.15485-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gdb_cmd_memread() passes the length of the 'm' packet straight to
kgdb_mem2hex(), which hex-encodes the reply into
remcom_out_buffer[BUFMAX] without checking that the reply fits. A
client on the KGDB I/O console can ask for a read of any size, and
the hex encoding runs off the end of the buffer. kgdb_mem2hex() takes
that length as an int count, so 2^31 truncates to a negative value
and copy_from_kernel_nofault() is handed buf + count as its
destination.

On x86 BUFMAX is 1024, so a read of 512 bytes overruns by the single
byte that terminates the hex string:

  BUG: KASAN: global-out-of-bounds in kgdb_mem2hex+0x1dd/0x230
  Write of size 1 at addr ffffffff87651780 by task sh/1
  ...
  The buggy address belongs to the variable:
   remcom_out_buffer+0x400/0x420

Bounds check the length before the hex encoding:

		if (length > (BUFMAX - 1) / 2) {
			error_packet(remcom_out_buffer, -EINVAL);
			return;
		}

gdbstub_msg_write() already bounds the count it hex-encodes
against BUFMAX. Reads over the limit never returned valid data,
so an error reply loses nothing.

Fixes: dc7d55270521 ("kgdb: core")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

The scanner is a taint-style review of the packet handlers in
kernel/debug/gdbstub.c. write_mem_msg() ('M' and 'X' packets) trusts
the same length field and looks like the same class of problem; I can
send that separately if there is interest.

Reproducer: attach to a kgdboc console and send an 'm' packet with a
length above (BUFMAX - 1) / 2, e.g. "m<addr>,200" on x86. Before this
change the hex encoding runs off the end of remcom_out_buffer; after
it the stub answers E22 and the guest resumes.

Both cases were run on 704340f1cd0d (v7.3-rc4): x86_64 defconfig plus
CONFIG_KASAN_GENERIC, gcc 13.2.0, QEMU under TCG. The two kernels are
built from byte-identical .config files and differ only by this patch.

Two details of the setup are not obvious. CONFIG_KGDB_KDB has to be
off: dbg_kdb_mode starts at 1, so with kdb built in a sysrq-g break
lands in kdb_stub() and the packet is never parsed.

A minimal over-the-limit length reproduces better than a large one.
copy_from_kernel_nofault() copies through raw asm accessors that KASAN
does not instrument, so length = 0x10000 writes 64 KiB past the buffer
with no report at all and the kernel simply stops answering. length =
0x200 keeps that copy inside the buffer, which leaves the terminating
store as the only out-of-bounds access and gives the report above.

 kernel/debug/gdbstub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e271a43..5774292 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -563,6 +563,14 @@ static void gdb_cmd_memread(struct kgdb_state *ks)
 
 	if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
 					kgdb_hex2long(&ptr, &length) > 0) {
+		/*
+		 * The hex-encoded reply needs 2 * length + 1 bytes
+		 * in remcom_out_buffer[BUFMAX].
+		 */
+		if (length > (BUFMAX - 1) / 2) {
+			error_packet(remcom_out_buffer, -EINVAL);
+			return;
+		}
 		err = kgdb_mem2hex((char *)addr, remcom_out_buffer, length);
 		if (!err)
 			error_packet(remcom_out_buffer, -EINVAL);
-- 
2.50.1 (Apple Git-155)

