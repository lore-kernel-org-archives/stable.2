Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051027;
	b=LQNCcKb7cOI/eCYjr342cD3gbGWJFP3Mq5gN16RI/Cwyoj1LKRNiH+3tLGsR89OLTDSU
	 ikjQhe5N34S3neMQwZJuKgkXDlfz5Kuv+fFb7q2xAFRE2HWaZnmkY6XzhW51prSmeXbP2
	 lgNUq3Nq2sYGjRZTk28/6DXry0xFPYeWWYV+/rGZNAi8zDVz/1JckpvGMe9E1Bstdv3t0
	 EbDUiNpye87h3HNAbuc7RUo85ekozqtGtQZdEOC38+OLIyALqiEvcwjV6uQerLj8z4gav
	 g+9wwSNN4Uv7YUbCe8LYC3zGC6pkL/jZlT2+75H625Dpp8oUb3MWYDloAJpqX3vj88w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=le0m1RJyrBoAG2OxANBsbamxumKmaYQ8v50PUDb/9DI=;
	b=xSdyUCiI2Hs8b94t4ihz2fHPGFACoXy52nbor375Sogm8nmJu1Nmv5VLv5VYY+9wPtj1
	 bDRo1nDxupGKmx95oHbwf74JSammSNiF9bVEzRuhR4cBb3jfd33ZR2DgtPPnDhiTWUWHO
	 bEPSZZ2lt20hsvJzBJFKb9EbUrV9rQqVgSdIK9MRtMZgKBaI9CQVBQQexAEX6SrzVD0Z9
	 LJWULP+HMBH2ZEpIXImu9g0jz5QFrSKNTZ2ky5fkYnXeKxcqSC6Y8V3P9QO7hWQlt8w9/
	 WkEq4FZ2xB72kJRTcKo0l+UAHRLUXljUPT5upck9nObqGdRyGle6WDC+PujO31Y3i/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yrc+vOQu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yrc+vOQu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27041F0089F;
	Sat,  7 Nov 2026 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051027;
	bh=le0m1RJyrBoAG2OxANBsbamxumKmaYQ8v50PUDb/9DI=;
	h=From:To:Cc:Subject:Date;
	b=Yrc+vOQuRYGx8f3q1B92qpn0I7T+d29gIE3UAuseRzYenMYyARG5pbmNCbyhou7wp
	 kItZGFZq8J6h1PKbt0hkBanzxVuXmxMjg2OUms5gsgDOzzRKzXNzwSOAAPY0DxJiby
	 nmorrjLUspItAMhsCS0P95mua/b4Dibb/c0C6dlZAEu60qTajJInPrgl3i7OiSqgnr
	 jM7QAXOTAkQwHlDGAHrX+XlJOJDFmk6aiSiIpQHxvfsm/W6yw8akdc6zHGrVu+Zti5
	 10DgwDR3kkvXA65SdHETDnuDMy71GqHJKivMawkmHpymrQKb8JO6UmAS+TSsbj0nNA
	 1H/DxIeVekLbg==
From: Sasha Levin <sashal@kernel.org>
To: fangxy@xiaopeng.com,
	daniel@riscstar.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:25 -0500
Message-ID: <20261107063025-failed-5.10-13962ef7021e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 13962ef7021ef2531a4f6650eca87c363e6c9c32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063025-failed-5.10-13962ef7021e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 13962ef7021ef2531a4f6650eca87c363e6c9c32 Mon Sep 17 00:00:00 2001
From: Fang Xieyan <fangxy@xiaopeng.com>
Date: Tue, 22 Sep 2026 23:49:07 +0800
Subject: [PATCH] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers

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
Link: https://lore.kernel.org/r/20260922154907.90535-1-fangxy@xiaopeng.com
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
 kernel/debug/gdbstub.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 5774292c93aec..4102e2e68d806 100644
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
@@ -993,7 +1024,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
 		/* Clear the out buffer. */
 		memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
 
-		get_packet(remcom_in_buffer);
+		remcom_in_len = get_packet(remcom_in_buffer);
 
 		switch (remcom_in_buffer[0]) {
 		case '?': /* gdbserial status */
-- 
2.53.0




