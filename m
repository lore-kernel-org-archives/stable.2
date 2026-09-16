Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CE3876B8;
	Wed, 16 Sep 2026 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571891; cv=none; b=fG8gBF2lWCBvYqzKoq6jRz1vW0+dqsNPo5GthkgA9xlNTd7y4yTYzz3UCByl4quhhgcQk3KiYml9GpUjVPhH4CckoDJQ3Kddf2E/O9XV+DaWAY1Gb5z4PTqSTB0nf+pWWQBfx7XquRPRxJA6+IsAAX7OLaGvVBWhHsCCxRP6gPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571891; c=relaxed/simple;
	bh=MNllaWs4NKlPsGCBsJvdYfAYKbs2Di5P3yh0L73BqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTsX0VNdghsOTn5ift4uue//XbTZ5C6yUFLgDCpPVygEx9vThVCNcDyiw/ylALPToN1asxpwuQY/tEP+M5oQVmfSSiG/J7oXkFEumLlqbDpe2R/vNnQMCRefmEFdc1sDwm1xKAJQ9A7D1YzjNQ39dPQgmxuljYRzEhpD+zH5HRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=QZwcorNz; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="QZwcorNz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789571876; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dh2KdX53HxMnPh9VZw4i391Trb+WLmCiZOva80G9K6s=;
	b=QZwcorNzS5X1H0CaYWdSca/WCFJuc07MMWB8jr5IWXOqx2gfECz0fKrnLrvD/0k7L/mg6msuzqNEaB6b0Hgb4rBg27t1w4KbEXZ/pn1PbtO/aZfFc6Uc8b+oq6vtmXrk9KTOQpbs7KfqtnE/1A/DNxjDKc1YTbvYIXjYW0Glj3Y=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05100505|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0011901-0.0002448-0.998565;FP=14314196981793757438|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jFCC89n_1789571874;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jFCC89n_1789571874 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 23:17:55 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: jason.wessel@windriver.com,
	danielt@kernel.org,
	dianders@chromium.org
Cc: kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kgdb: Fix buffer overflow in the qRcmd packet handler
Date: Wed, 16 Sep 2026 23:17:53 +0800
Message-ID: <20260916151753.6722-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gdb_cmd_query() decodes the hex payload of a qRcmd packet (the GDB
"monitor" command passthrough to kdb) into remcom_out_buffer and hands
it to kdb_parse(). It sizes the decode with strlen() of the payload:

	int len = strlen(remcom_in_buffer + 6);
	...
	kgdb_hex2mem(remcom_in_buffer + 6,
		     remcom_out_buffer, len);
	len = len / 2;

kgdb_hex2mem() takes count as the number of bytes to produce and
decodes them in place at buf, reading and writing 2 * count bytes
there. len here is the hex character count, twice the decoded size,
so the decode runs over 2 * len bytes at remcom_in_buffer + 6, off
the end of the buffer. On x86 BUFMAX is 1024, so a 256-byte monitor
command (512 hex characters) overruns remcom_in_buffer during the
in-place decode:

  BUG: KASAN: global-out-of-bounds in kgdb_hex2mem+0x131/0x160
  Read of size 1 at addr ffffffff8765ef05 by task sh/1
  ...
  kgdb_hex2mem+0x131/0x160
  gdb_serial_stub+0x16d4/0x3170
  kgdb_cpu_enter+0xb68/0x1520
  ...
  The buggy address belongs to the variable:
   remcom_in_buffer+0x405/0x420

Halve len before the call so kgdb_hex2mem() gets the decoded byte count.
It then reads the len hex characters already in remcom_in_buffer and
writes len / 2 bytes, all inside the buffer, and remcom_out_buffer holds
the same command as before.

Fixes: a0de055cf613 ("kgdb: gdb "monitor" -> kdb passthrough")
Cc: stable@vger.kernel.org
Suggested-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/all/CAD=FV=V1-gNZ8yTsC+D8inePWv=A+9H09hWJojQf5NRpcNvK+Q@mail.gmail.com/
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

This is the third in a family of unvalidated-length decodes in the kgdb
gdbstub; the 'm' memread and 'M'/'X' memwrite fixes were sent separately.
Unlike those two, there is no attacker-claimed length field here. len is
the real hex-character count bounded by get_packet(), so the only defect
is passing the hex length instead of half of it to kgdb_hex2mem().
Halving it is sufficient; no separate bounds check is needed.

Reproducer: attach to a kgdboc console, break in, run kdb's "kgdb"
command to switch to gdb mode, then send a qRcmd packet with an even
hex payload of 510 or more characters, e.g. "qRcmd," + "41"*256 on x86.
Before the fix, KASAN reports a global-out-of-bounds read in
kgdb_hex2mem(): the decode runs to remcom_in_buffer+0x405, past
BUFMAX=0x400, and the guest dies. After the fix the decode stays
in-bounds, the command reaches kdb_parse() and the handler answers OK.
The patched run does print kdb_parse()'s own "command buffer overflow,
command ignored" for a 256-byte command; that is kdb's length limit on
the decoded string, not this bug.

Tested on mainline 704340f1cd0d (git describe v7.3-rc3-9-g704340f1cd0d):
x86_64 defconfig plus CONFIG_KGDB_KDB and CONFIG_KASAN_GENERIC, gcc
13.2.0, QEMU under TCG. Both kernels were built from byte-identical
.config files and differ only by this patch.

 kernel/debug/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e271a43..41e344e 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -778,9 +778,9 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 				strscpy(remcom_out_buffer, "E01");
 				break;
 			}
+			len = len / 2;
 			kgdb_hex2mem(remcom_in_buffer + 6,
 				     remcom_out_buffer, len);
-			len = len / 2;
 			remcom_out_buffer[len++] = 0;
 
 			kdb_common_init_state(ks);
-- 
2.50.1 (Apple Git-155)

