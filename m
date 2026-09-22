Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710B2E6CB8;
	Tue, 22 Sep 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092156; cv=none; b=K8VLrLWK1+opdOGYRTP25bVLd38uJaABTg5/8lLFi0E1xdR4Oa1ohbQ1yVAiiABUvR2baFPhNMZj66/UcdKaROMKDZXGr38/O31unj3zRObjmUC+NQ4wFlQyCN7jwUyvCh2xW9wKHAm+AP5yOsnB3WNU5YwbvmkCNiULiElb8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092156; c=relaxed/simple;
	bh=m9MzsfBhY2+fdPnGx77j+tlrSCT/JbHFCOAFN90ErJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9wZZmIM2TV/A7QKQb0E9IJ4lN/6qp0J9zY4wMS+HlJcRpNK/AwGgzDXhH2tnUCjqqjzfpHU7fXC+Pz51J1nTjX5+Jg4/l2tV1+01OKd9pu1jds3rk5lswYKLclUr457pCCA/8AENcsjmBnO/3Y6bxNw4DntrHeYa+6Tun6I/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=lm8dznlC; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="lm8dznlC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790092149; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xzX3oI+nIvhLqrrsstw3vJ/BC6DIPbs/7ONFCx7bqz0=;
	b=lm8dznlCLAApVm3d6svtBv+vUWhrBYOEUcSvHAVYZ+xzqM7mQweiw4HDGQJrg4UclD3dN4SolQmPtCgrF28PVMbfp25/b8ie/KuN2H7Z2rocjHcpW9B721vmpB2KrJicwCqEQa6wzklz0kk7QRpyVDickh2lzDXIZbS81IZLDj8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00786389-0.000226249-0.99191;FP=15315377223126031482|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jKA4tlN_1790092147;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jKA4tlN_1790092147 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 23:49:08 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: jason.wessel@windriver.com,
	danielt@kernel.org,
	dianders@chromium.org
Cc: kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
Date: Tue, 22 Sep 2026 23:49:07 +0800
Message-ID: <20260922154907.90535-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_mem_msg() passes the length claimed by an 'M' or 'X' packet directly
to kgdb_hex2mem() or kgdb_ebin2mem(). A malformed packet can claim more
data than was actually received, causing the decoders to read past
remcom_in_buffer.

Record the received payload length in get_packet() and use it to bound
the decoders. 'M' carries two hex characters per byte, while 'X' carries
one byte per output byte except that a 0x7d escape consumes an additional
input byte. Pass the packet end to kgdb_ebin2mem() so both reads are
checked against the received data.

Keep zero-length 'X' packets valid, as GDB uses them to probe binary
download support.

Fixes: dc7d55270521 ("kgdb: core")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Changes in v2:
  - Bound the decode by the bytes actually received instead of a fixed
    divisor. get_packet() now returns the received count and
    write_mem_msg() uses it as the end of the payload.
  - Split the 'M' and 'X' bounds. 'X' is no longer capped at BUFMAX / 2,
    so a valid binary write between BUFMAX / 2 and BUFMAX - header is
    accepted again; v1 rejected it with E22, and GDB aborts a write
    that gets E22 rather than falling back to 'M'.
  - Give kgdb_ebin2mem() a buf_end argument and check it before both
    reads in the loop, so a 0x7d escape cannot read past the received
    data.
  - v1: https://lore.kernel.org/all/20260916080306.13395-1-fangxy@xiaopeng.com/

Write-side sibling of the 'm' memread overflow in gdb_cmd_memread()
(remcom_out_buffer); both handlers trust the same unvalidated length
field. The read-side fix was posted separately:
https://lore.kernel.org/all/20260914180344.15485-1-fangxy@xiaopeng.com/

Reproducer ('M', x86 BUFMAX=1024): send "M<addr>,200:4142434445464748"
on a kgdboc console. The stub decodes 2 * 512 bytes from an 8-byte
payload, so the in-place hex conversion runs off remcom_in_buffer.
Unpatched: KASAN global-out-of-bounds read in kgdb_hex2mem at
remcom_in_buffer+0x415/0x420, guest panics. Patched: $E22, guest
resumes. A minimal over-claim reproduces best: a huge length smashes
past the buffer through the uninstrumented copy in
copy_to_kernel_nofault() with no report at all.

'X' cases (patched kernel answers shown; x86, same harness):
  - over-claim "X<addr>,400:" with an 8-byte body: $E22. Unpatched this
    splats in write_mem_msg (kgdb_ebin2mem inlined) at
    remcom_in_buffer+0x400/0x420 and the guest dies.
  - well-formed 900-byte write "X<addr>,384:": $OK, accepted again.
    This is the packet v1 wrongly rejected; the write lands on
    init_task, so the harness asserts $OK without resuming the guest.
  - lone trailing escape "X<addr>,40:": $E22.
  - zero-length "X0,0:": $OK (GDB's binary-download probe).

Built and run on 704340f1cd0d (9 commits past v7.3-rc3), x86_64
defconfig + CONFIG_KASAN_GENERIC, gcc 13.2.0, QEMU under TCG; the
before/after kernels are built from byte-identical .config files and
differ only by this patch. CONFIG_KGDB_KDB has to be off so the packet
is parsed by the gdb stub rather than kdb. An unrelated early-boot
"wild-memory-access in _raw_spin_lock" TCG+KASAN flake can reboot the
guest before the break-in; re-running the boot clears it.

 kernel/debug/gdbstub.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e271a43..0293524 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -43,6 +43,8 @@
 /* Our I/O buffers. */
 static char			remcom_in_buffer[BUFMAX];
 static char			remcom_out_buffer[BUFMAX];
+/* Payload bytes get_packet() stored in remcom_in_buffer, excluding the NUL. */
+static int			remcom_in_len;
 static int			gdbstub_use_prev_in_buf;
 static int			gdbstub_prev_in_buf_pos;
 
@@ -87,7 +89,7 @@ static int gdbstub_read_wait(void)
 }
 #endif
 /* scan for the sequence $<data>#<checksum> */
-static void get_packet(char *buffer)
+static int get_packet(char *buffer)
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
@@ -135,6 +137,8 @@ static void get_packet(char *buffer)
 		}
 		buffer[count] = 0;
 	} while (checksum != xmitcsum);
+
+	return count;
 }
 
 /*
@@ -321,16 +325,26 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
  * Copy the binary array pointed to by buf into mem.  Fix $, #, and
  * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
  * The input buf is overwritten with the result to write to mem.
+ *
+ * buf_end points one past the last byte received for this packet. Each
+ * 0x7d escape consumes a second input byte, so decoding count bytes can
+ * read up to 2 * count input bytes; stop at buf_end rather than running
+ * off the end of remcom_in_buffer.
  */
-static int kgdb_ebin2mem(char *buf, char *mem, int count)
+static int kgdb_ebin2mem(char *buf, char *mem, int count, char *buf_end)
 {
 	int size = 0;
 	char *c = buf;
 
 	while (count-- > 0) {
+		if (buf >= buf_end)
+			return -EINVAL;
 		c[size] = *buf++;
-		if (c[size] == 0x7d)
+		if (c[size] == 0x7d) {
+			if (buf >= buf_end)
+				return -EINVAL;
 			c[size] = *buf++ ^ 0x20;
+		}
 		size++;
 	}
 
@@ -367,16 +381,33 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 static int write_mem_msg(int binary)
 {
 	char *ptr = &remcom_in_buffer[1];
+	char *buf_end = &remcom_in_buffer[remcom_in_len];
 	unsigned long addr;
 	unsigned long length;
 	int err;
 
 	if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ',' &&
 	    kgdb_hex2long(&ptr, &length) > 0 && *(ptr++) == ':') {
-		if (binary)
-			err = kgdb_ebin2mem(ptr, (char *)addr, length);
-		else
+		/*
+		 * Trust only the bytes actually received, not length: the
+		 * client can claim more payload than it sent. 'M' decodes two
+		 * hex chars per byte in place, so it needs 2 * length bytes at
+		 * ptr; 'X' decodes one byte per byte, and kgdb_ebin2mem() bounds
+		 * its extra 0x7d-escape reads against buf_end itself.
+		 */
+		if (ptr >= buf_end)
+			return -EINVAL;
+
+		if (binary) {
+			if (length > (unsigned long)(buf_end - ptr))
+				return -EINVAL;
+			err = kgdb_ebin2mem(ptr, (char *)addr, length, buf_end);
+		} else {
+			if (length > (unsigned long)(buf_end - ptr) / 2)
+				return -EINVAL;
 			err = kgdb_hex2mem(ptr, (char *)addr, length);
+		}
+
 		if (err)
 			return err;
 		if (CACHE_FLUSH_IS_SAFE)
@@ -985,7 +1016,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
 		/* Clear the out buffer. */
 		memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
 
-		get_packet(remcom_in_buffer);
+		remcom_in_len = get_packet(remcom_in_buffer);
 
 		switch (remcom_in_buffer[0]) {
 		case '?': /* gdbserial status */
-- 
2.50.1 (Apple Git-155)

