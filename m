Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AE44CAE6;
	Wed, 16 Sep 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545806; cv=none; b=LfU5HhvaWkqwkBe3lHk3jQr+/saUFnziKD7cqAYEkIwdYgQ7Fb+A9xDxPP3YyY/fJ3URF8ZeBLJWxCaBW9X7YUPDhRpB6R7dAw226oZ7N/RYXJplpLrN+QsHsDQgCbfFx/vTMsrF98NStm/UuQbMW0Fv4zfdNdbBiFZ45oDkXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545806; c=relaxed/simple;
	bh=HqUvY0ZRxu7yr/271rlZhwEy6ylM0oF7i+iuJuYq4kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcHkmU9s49PriHI6Vq52RrcAG5WSbQWMo39VC1j4pLW5DqMlzn5CJfn3ayZx/DwvwRecMdv2+mVPKgzdTcvDbNh0Z1IlB/6mxoK+s4WzE/9BcVtt5w8nbBaYQOWNfgShyeNTM3ejdydQ9ZOs1XKXmkKtqpI/S8AOEwsRma1+4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=K93T+V+t; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="K93T+V+t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789545789; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=piWT4Fdm8qXDNU3x92GE1Ob7uadSEs7T0wVRUiAk+HM=;
	b=K93T+V+t4gZFMaLgJ/r/lWtCIRpEQ88ZWvuU6d785hIZnRo/OQV3Lgz6Y7d2WGp6JvebIMREG3dx+u1ZLZI6miVLyxhpIsotSb4MQr65Oj4r/42iSZu/UNY4TWysacCQA43/U4nncbT27HnWKH/7rqMcGEab1zn0P8ZiIQ9+qJk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04598084|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00790162-0.000227329-0.991871;FP=4936357443640301694|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jErWOVc_1789545787;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jErWOVc_1789545787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 16:03:08 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: jason.wessel@windriver.com,
	danielt@kernel.org,
	dianders@chromium.org
Cc: kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
Date: Wed, 16 Sep 2026 16:03:06 +0800
Message-ID: <20260916080306.13395-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_mem_msg() passes the length of an 'M' or 'X' packet straight to
kgdb_hex2mem() or kgdb_ebin2mem(). Both decode the payload in place at a
pointer into remcom_in_buffer[BUFMAX], and neither checks that the length
fits. A client on the KGDB I/O console can claim any length, regardless of
how much payload it actually sent, so the decode runs off the end of the
buffer and then copies the decoded bytes to the address the client chose.

On x86 BUFMAX is 1024, so a write that claims 512 bytes overruns
remcom_in_buffer during the in-place hex decode:

  BUG: KASAN: global-out-of-bounds in kgdb_hex2mem+0x131/0x160
  Read of size 1 at addr ffffffff87651bb5 by task sh/1
  ...
  kgdb_hex2mem+0x131/0x160
  write_mem_msg+0x308/0x3e0
  gdb_serial_stub+0xd8b/0x3490
  ...
  The buggy address belongs to the variable:
   remcom_in_buffer+0x415/0x420

Bounds check the length against the space left in the input buffer:

		if (length > (BUFMAX - (ptr - remcom_in_buffer)) / 2)
			return -EINVAL;

gdb_cmd_memwrite() and gdb_cmd_binwrite() already turn a non-zero return
into an error reply, and a write over the limit never decoded valid data,
so an error reply loses nothing.

Fixes: dc7d55270521 ("kgdb: core")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

This is the write-side sibling of the 'm' memread overflow in
gdb_cmd_memread() (remcom_out_buffer); both handlers trust the same
unvalidated length field. The read-side fix was posted separately
(<20260914180344.15485-1-fangxy@xiaopeng.com>).

Reproducer: attach to a kgdboc console and send an 'M' packet whose length
is above the (BUFMAX - header) / 2 limit but whose payload is short, e.g.
"M<addr>,200:4142434445464748" on x86. The stub decodes 2 * 512 bytes at
ptr regardless of the 8 bytes sent, so the in-place hex conversion runs off
remcom_in_buffer[1024]. Before this change KASAN reports a
global-out-of-bounds read in kgdb_hex2mem and the guest dies; after it the
stub answers E22 and the guest resumes.

The 'X' (binary) path through kgdb_ebin2mem() needs the same / 2 divisor,
not a looser one. It decodes in place at ptr and reads a second input byte
for every 0x7d escape marker it sees, so a claimed length of N bytes reads
up to 2 * N bytes at ptr, exactly like the hex path. Giving 'X' a divisor
of 1 would let an escaped payload run off remcom_in_buffer, which is the
overflow this patch removes.

Both cases were run on 704340f1cd0d (v7.3-rc4): x86_64 defconfig plus
CONFIG_KASAN_GENERIC, gcc 13.2.0, QEMU under TCG. The two kernels are built
from byte-identical .config files and differ only by this patch.

CONFIG_KGDB_KDB has to be off: dbg_kdb_mode starts at 1, so with kdb built
in a sysrq-g break lands in kdb_stub() and the packet is never parsed.

A minimal over-the-limit length reproduces better than a large one. The
trailing copy_to_kernel_nofault() copies through raw asm accessors that
KASAN does not instrument, so a huge length smashes .bss past the buffer
with no report and the kernel simply stops answering. length = 0x200 keeps
the in-place decode just past remcom_in_buffer[1024], which gives the
report above.

TCG note: an unrelated early-boot "wild-memory-access in _raw_spin_lock"
sometimes fires under TCG + KASAN during identify_cpu and reboots the guest
before it reaches the break-in. That is not this bug; re-running the boot
clears it and the packet then lands as described.

 kernel/debug/gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e271a43..a67ca1a 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -373,6 +373,12 @@ static int write_mem_msg(int binary)
 
 	if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ',' &&
 	    kgdb_hex2long(&ptr, &length) > 0 && *(ptr++) == ':') {
+		/*
+		 * The in-place decode touches 2 * length bytes at ptr,
+		 * inside remcom_in_buffer[BUFMAX].
+		 */
+		if (length > (BUFMAX - (ptr - remcom_in_buffer)) / 2)
+			return -EINVAL;
 		if (binary)
 			err = kgdb_ebin2mem(ptr, (char *)addr, length);
 		else
-- 
2.50.1 (Apple Git-155)

