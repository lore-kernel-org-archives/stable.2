Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1E3A380F
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392290; cv=none; b=GF1R8/tVri7rcLf7ljUlINX0rrWr/ajP0lyTvhZ6RlBUCHvrY0Uep1uVinSOnKQ7/EorBgzkYldNFFkp6UKjxDjmiCRWa2kzzVonzk4/LItVyzpPycZWnboM1W1B5nq1oTCTr1Koen5ucjejhwzEaWWbObc2zCoC7SnNg3KyHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392290; c=relaxed/simple;
	bh=jyRNjYIpRPZnGIShpD6aY/YuoYpc1xXghFay8M24Nnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCpy2AWaa44734Ob5b5b/kjcBtm2n1s/vMT4n2fxcXzXnDDaqYlEgqbWK/5NxYQTN2+xODnOjM44UQyxNZfCdMH5fdfwfV89yjV9wUocNE+VfrK4yfqtotKiejpW9JzDr9y4AF6LOpdLMbAKG2GakFOHZuGjb/+nkObcspOSN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYL/1i7G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYL/1i7G"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d01663d816so15978415ad.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392288; x=1787997088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3DjOJK7xDoaF8DBdXDTvBpCyBMM9nbKuBHTtDt30EA0=;
        b=jYL/1i7GgkTuhQey8fJvaDkGeyOeqNuooxq9U5Jec/3fE9L+9N49IMtQGnQs1LOShr
         lnyZlK9AuUHZ70WCLcQGAyeII63D8DibRyIRHDPfRarzjEmLxjDwt03uAr6/wJ2nlDaT
         fHryxrL39BrxnSnoRrHorfr+RtmCq8qefezOI+EUvLannKHj85o2WrNd1wevr/32Rl9/
         GUrbfiTb6zsdUPD33PicnwlxuLaZJ88D7QOL9hWXD1nrQtabdS4MRpap1awrqcmdiFZv
         m40GGrUFwl3be7KmiH3dLY4T2efs9eRJmeMt2bI6klqn012/vB6htTzICB8Qy8wvRRkj
         YXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392288; x=1787997088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3DjOJK7xDoaF8DBdXDTvBpCyBMM9nbKuBHTtDt30EA0=;
        b=i59IrjnunYHghHJ7sFrSsnFewnkTzi1c4bFOhGjWiXXhRaKv59eSN5mxpL9WbAoXK2
         YmUOwBL7EC7dTyJfCFVvPuSGXXCdqJ4K1WMcI04PMKKTeucJElZmkDa9LkUYlI4TAJUo
         GFjcUYfn+m07mJC/n7vPGCwzbszvW+gmEjem9OU2s3bLALoOm3kkj3IAMcrfO9BNjSEm
         RQv9p+IPE/xYAwYB2WFmpPo6ZagN9Vbg8/U8HE/pr9zRNS03qizhEkEtnSVxZwDg5LCU
         xdl4671rxxx5Y3NMLrbF3NswY3z6EP/IcGRFsFAnEawppQ6/chul/Ojfs3rONiK0SmFp
         CCcw==
X-Forwarded-Encrypted: i=1; AHgh+Rpv4kBheMljBMmdIBNdp6wtPQAMXDM391LgmgHV0JOcLrW1oXA9CGU/tRrwPgisoH2PyybBWP0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjp2LiHRA/rdr5P9ivIQzUTa56Zu3iQMqXS08xog8TA46MJ24x
	GxiIdLtfu9If/EvQTtV3WCfXxm2kPaHU1OJFj9FKYndQh75grOX8SRMx
X-Gm-Gg: AR+sD10On2ieyhrEZ8DcZ1Sp6FsPLEL2HSRT89aImKlbFft93DZpRFhqLUa4q/jtjjJ
	YiCrppovD3ONV0ZnNplSjUDCGrMSdziXUADSkRbwARuzqov3dQcfqjGgMevY7sw33qeUIkrIGQQ
	DLHywA9dgfni5kll2vdOQ1TpOr1Fd0ldaL6WSDHEgsQTNLKMl08N1Oh6Hcq74+Y61ETqh+pRXsL
	Rwdw+eogeeY5t3XI0d/110cYYsiUpxUaJxj61egcNsSEVJRhAhFk1O8seductEaygQxnF5I3sND
	4r3hVbXwPPHokqNtliJM/2PJxWcFvyWSP8hLbx7oaKnr0q2hzuXit1izmHgE5HjL/Rb55BZibWk
	kTmy+evEm+HE/MXQ/U+k8fNaFXV+uF+MdBq9ZyRx9bM45dwLGlUcjfpIZq/YUqoKUlAWcR+To4a
	TfJnRB2TwiHp570mB5R8lhjqwD0XbVkx2ROfGPkW5up4XFFEhCKZarL0Ae0NNKQLLPoGwBHlurd
	LvUZFRjhinyqVxPNOYwgqOJg3cBzWtlwXOrvWtZV0eQYI/Hdh+imsqEPDi+zi7efjlAS1xeDOV5
	Zccp3GGS9q1zOOVslnnz0aHa6cSqZEW4h2np8Pn7Z2M7kVo3hGdbVCxqaZNVGmViyyeAiCKwUIh
	ntHBFNF+xE5fNcRvk0vLF6crPM1uJBsVMpxEJ1V0uo87nq7YWKD/lPncNvQ==
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d64add1daamr229443285ad.4.1787392288034;
        Sat, 22 Aug 2026 02:51:28 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm5244881eec.17.2026.08.22.02.51.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:51:27 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] soc: apple: rtkit: bound syslog copies to the shared buffer
Date: Sat, 22 Aug 2026 15:36:21 +0545
Message-ID: <20260822095121.53451-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apple_rtkit_syslog_rx_log() copies a log entry out of the coprocessor
shared-memory ring using an index and layout that the coprocessor
itself chose (SYSLOG_INIT n_entries / msg_size, plus the 8-bit idx in
the LOG message). Those values are never checked against
syslog_buffer.size, so a compromised or buggy RTKit firmware can make
the kernel memcpy_fromio()/memcpy() past the DMA mapping.

SYSLOG_INIT also accepted msg_size == 0. kzalloc(0) returns
ZERO_SIZE_PTR, which is non-NULL, and strnlen(..., msg_size - 1) then
wraps to SIZE_MAX.

Treat n_entries as a count (reject idx >= n_entries), reject a zero
message size, and refuse shared-memory copies that do not fit in the
buffer. Rate-limit the new OOB warning so a coprocessor cannot flood
the kernel log.

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/soc/apple/rtkit.c | 73 ++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index a3fdac8f6f06..63b85d082a7a 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -348,14 +348,28 @@ static void apple_rtkit_free_buffer(struct apple_rtkit *rtk,
 	bfr->is_mapped = false;
 }
 
-static void apple_rtkit_memcpy(struct apple_rtkit *rtk, void *dst,
-			       struct apple_rtkit_shmem *bfr, size_t offset,
-			       size_t len)
+static bool apple_rtkit_shmem_ok(struct apple_rtkit_shmem *bfr, size_t offset,
+				 size_t len)
 {
+	return offset <= bfr->size && len <= bfr->size - offset;
+}
+
+static int apple_rtkit_memcpy(struct apple_rtkit *rtk, void *dst,
+			      struct apple_rtkit_shmem *bfr, size_t offset,
+			      size_t len)
+{
+	if (!apple_rtkit_shmem_ok(bfr, offset, len)) {
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: shared-memory copy out of bounds (off 0x%zx len 0x%zx size 0x%zx)\n",
+				     offset, len, bfr->size);
+		return -EINVAL;
+	}
+
 	if (bfr->iomem)
 		memcpy_fromio(dst, bfr->iomem + offset, len);
 	else
 		memcpy(dst, bfr->buffer + offset, len);
+	return 0;
 }
 
 static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
@@ -384,9 +398,10 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
 	 */
 	bfr = kzalloc(rtk->crashlog_buffer.size, GFP_KERNEL);
 	if (bfr) {
-		apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
-				   rtk->crashlog_buffer.size);
-		apple_rtkit_crashlog_dump(rtk, bfr, rtk->crashlog_buffer.size);
+		if (!apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
+					rtk->crashlog_buffer.size))
+			apple_rtkit_crashlog_dump(rtk, bfr,
+						  rtk->crashlog_buffer.size);
 	} else {
 		dev_err(rtk->dev,
 			"RTKit: Couldn't allocate crashlog shadow buffer\n");
@@ -422,10 +437,29 @@ static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
 
 static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
 {
-	rtk->syslog_n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
-	rtk->syslog_msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
+	size_t n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
+	size_t msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
 
-	rtk->syslog_msg_buffer = kzalloc(rtk->syslog_msg_size, GFP_KERNEL);
+	kfree(rtk->syslog_msg_buffer);
+	rtk->syslog_msg_buffer = NULL;
+	rtk->syslog_n_entries = 0;
+	rtk->syslog_msg_size = 0;
+
+	/*
+	 * msg_size == 0 would make kzalloc() return ZERO_SIZE_PTR (non-NULL)
+	 * and later strnlen(..., msg_size - 1) wrap to SIZE_MAX.
+	 */
+	if (!msg_size) {
+		dev_warn(rtk->dev, "RTKit: syslog msg_size is zero\n");
+		return;
+	}
+
+	rtk->syslog_msg_buffer = kzalloc(msg_size, GFP_KERNEL);
+	if (!rtk->syslog_msg_buffer)
+		return;
+
+	rtk->syslog_n_entries = n_entries;
+	rtk->syslog_msg_size = msg_size;
 
 	dev_dbg(rtk->dev,
 		"RTKit: syslog initialized: entries: %zd, msg_size: %zd\n",
@@ -441,10 +475,11 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 {
 	u8 idx = msg & 0xff;
 	char log_context[24];
-	size_t entry_size = 0x20 + rtk->syslog_msg_size;
+	size_t entry_size;
+	size_t offset;
 	int msglen;
 
-	if (!rtk->syslog_msg_buffer) {
+	if (!rtk->syslog_msg_buffer || !rtk->syslog_msg_size) {
 		dev_warn(
 			rtk->dev,
 			"RTKit: received syslog message but no syslog_msg_buffer\n");
@@ -462,17 +497,21 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 			"RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
 		goto done;
 	}
-	if (idx > rtk->syslog_n_entries) {
+	if (idx >= rtk->syslog_n_entries) {
 		dev_warn(rtk->dev, "RTKit: syslog index %d out of range\n",
 			 idx);
 		goto done;
 	}
 
-	apple_rtkit_memcpy(rtk, log_context, &rtk->syslog_buffer,
-			   idx * entry_size + 8, sizeof(log_context));
-	apple_rtkit_memcpy(rtk, rtk->syslog_msg_buffer, &rtk->syslog_buffer,
-			   idx * entry_size + 8 + sizeof(log_context),
-			   rtk->syslog_msg_size);
+	entry_size = 0x20 + rtk->syslog_msg_size;
+	offset = (size_t)idx * entry_size + 8;
+	if (apple_rtkit_memcpy(rtk, log_context, &rtk->syslog_buffer, offset,
+			       sizeof(log_context)))
+		goto done;
+	if (apple_rtkit_memcpy(rtk, rtk->syslog_msg_buffer, &rtk->syslog_buffer,
+			       offset + sizeof(log_context),
+			       rtk->syslog_msg_size))
+		goto done;
 
 	log_context[sizeof(log_context) - 1] = 0;
 
-- 
2.51.2

