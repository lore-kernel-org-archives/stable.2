Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425729;
	b=3ZxIJW6hgpAVpsLUhAs/BlzjsGFq2JdUK0i7P+Y7urHiWPElzflZaX7XlBVq4oGvdp4r
	 XY6FL36kc+5cKAbHCoEUItEYOxFIM4zcC97GFG6ur6HaqFdp343B+sUDv9U5oBwniX2oR
	 QgGNadjjXFYNuYWHs4fklilBxO3064y4pCYUqOF7F73226343ahXO/67JVfgjqpZJS0iT
	 hCbf2LB9ofwdnmMpLMX0VNVCxhdp8NmnEvCuF81H49wH1WHcQsh0TYF8bf8suRdQMzNn7
	 SLm++lK8GSE6suHfPvGHyxra/pV599OX9oNvwMVdRKo8Doc0BSYc+ww4In5e7CM4H9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TnCNQDW8+1M1njhmtvhhSgtBlgBuT2fR1fEfs0KtKqQ=;
	b=raPv3htjKodHHmep1t5SfQAjpITKDynbLisqQEM5pkVILVz7sMm5NqZ1zkjsLJo0+bjp
	 d13utg4Ccw75cPRf3uZtW8SlaNl8KvmuffrnDZgA5k2pTtRAii9WXwFDebIttOsEEfQsz
	 OoLyYJsj1Oscv/6h2U0eYnsHkghdJRlljTtDaqkqLpOC34MXKjlCNWuysdqE4rv8Okhtb
	 ZcaaCCh/VY08YafupyNNHknyUvIU4oz9Xq50Cj0XBioMu/Fo4JroTjJmiK53Nauv/N8nz
	 3Mn2cFIgW8JgKbVzIVygRc4ntD7M2vdZrdyU4yzro0s0zp3okB3jl5DvgtjwkuvxENw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYNwe25M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYNwe25M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457331F00A06;
	Wed, 11 Nov 2026 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425729;
	bh=TnCNQDW8+1M1njhmtvhhSgtBlgBuT2fR1fEfs0KtKqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYNwe25M/jTVHlmk8z2UR0kmyHNTyhkxm69pu25JdXhgNfGPq2Gft8IxXfPS3vxnf
	 NrwBz1bGy0Lxrjp4R8RiVCci+USPuBP3QfZLRlybiMORLNccJRWtVOPw7uX7VX0eT7
	 sesP+d8RhzdrnIjjgEyL1oNq69s8Z1qJonwbSjN9lvHdr/xnVxHXiq2sq3wmqKgneU
	 fn7Qioj++3NTQ8ku/8vrP1Cr7HPM8mApVrJ+bGhT2vtjEPaqYvm4pIbQSIM3R6K5Pz
	 XsZNwhl537Qos+WE+wPdWYsYD2zNG2W3uZLGK0SOW/lDoj+REFTMYPlUOGXUa+kEO/
	 YJ4aVj+d1U0hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fang Xieyan <fangxy@xiaopeng.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
Date: Wed, 11 Nov 2026 14:35:27 -0500
Message-ID: <20261111193515.3990968-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111193515.3990968-1-sashal@kernel.org>
References: <20261107063025-failed-5.10-13962ef7021e@kernel.org>
 <20261111193515.3990968-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fang Xieyan <fangxy@xiaopeng.com>

[ Upstream commit 13962ef7021ef2531a4f6650eca87c363e6c9c32 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/gdbstub.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 45f6e39d29db4..68a532ced844f 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -44,6 +44,8 @@
 /* Our I/O buffers. */
 static char			remcom_in_buffer[BUFMAX];
 static char			remcom_out_buffer[BUFMAX];
+/* Payload bytes get_packet() stored in remcom_in_buffer, excluding the NUL. */
+static int			remcom_in_len;
 static int			gdbstub_use_prev_in_buf;
 static int			gdbstub_prev_in_buf_pos;
 
@@ -88,7 +90,7 @@ static int gdbstub_read_wait(void)
 }
 #endif
 /* scan for the sequence $<data>#<checksum> */
-static void get_packet(char *buffer)
+static int get_packet(char *buffer)
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
@@ -136,6 +138,8 @@ static void get_packet(char *buffer)
 		}
 		buffer[count] = 0;
 	} while (checksum != xmitcsum);
+
+	return count;
 }
 
 /*
@@ -322,16 +326,26 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
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
 
@@ -368,16 +382,33 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
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
@@ -994,7 +1025,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
 		/* Clear the out buffer. */
 		memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
 
-		get_packet(remcom_in_buffer);
+		remcom_in_len = get_packet(remcom_in_buffer);
 
 		switch (remcom_in_buffer[0]) {
 		case '?': /* gdbserial status */
-- 
2.53.0

