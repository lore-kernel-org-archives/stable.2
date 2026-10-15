Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A52F7ACE
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025861; cv=none; b=S6rRUNs62eoSEk5oRL4e1ilMAb1/k8QmklMjsLgrssTItGdyY1YCDfcOo3DbDLElBldGNqemJGuKl/hccvlDZEgC7VsbeFdsUoqhNLQNl5exv6loWUJ81H67Ab7yPMpGLjpdxetG2Ke26uianANyh7VvEBiSXKl9ZuEEO1HmvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025861; c=relaxed/simple;
	bh=/0Th4cc1vO+E41gV5mMuaLCXH78VA1Yl6fBR7oSaQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5rf+GqXPSeea0+17I/kaOuBhCQ3oDxZI/d1LsbIlcPuI1VwjWPX6nXI04vgCsBFpmKTEj3KKyVj1LSzBeu3dYnxjy1BYh3M4PLb+VB1+3Id3o4x+qWERnVUueHhPmsPllzoSA70vGTXYbKf62dXvNF28i2PqifRdAsnaA6ijg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=pN14vnkI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="pN14vnkI"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso1906969a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025859; x=1792630659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=pN14vnkIn9NmNKpDqxieNNImyfDsD153xPhz3zwmVumiS+qtVjsKzaZKYK3vb0I+rx
         2OoR4Bloi/0aNltond5q0JqVdQ9mPDk+ZFFsnCCk02N8pgOT/aMQV5WMhPQy1qQgwKNj
         LJ2HPH2AC+JjuFIaMeBDXFAIaBFT2mWtYfujFgJkEKDkFv1/HNOzGVKi/7BFwRobu8EW
         Lkeecd7Yiq8P1mNrA+TzuF4XNfuCyC6liIOIEwpw37dHa7Gj8IdXPBsfaCx1p6P9dr/A
         xdqfjw6vY+gVJRZ38W1bZwU4dCPQuMS6nmZ+XQt6PAuwIXiW6Wefn2cQ2DDBoc5ZpJ2F
         wIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025859; x=1792630659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=PngH/O0F9vZfPu5jWAE4+7wCT6ywCkBd3oT/U6fWZhpbXBLEn+ls6wyqhX4/xxxkCd
         W25coT12XiRqpIdENoNPSOxhLMJ6wQ6gt9F3xQEcr3h56vCtFaDKxOeLrSwNQFrPy9fp
         c4LgWbvP2csj7v/I/GJLlSnYR8w282QFB9yNpBsjuHMHiGHdBPuwK9lirYgnsewUmb+a
         JQMJZZgn4mR4PSnXQxiM4RgI1IAE5+uGa4MjAksWXzOGd/cFOz9rxU7oXSEDl3X+HdbD
         /IS1jjh4l1ZBOCDOsNWEZWsulOqg1hZUdSyz+LEGqh62xb7HigLXB45pDPUmMYoopRne
         GfeQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8wEJjdB03ag4Y38kZ4sfIeQ4CxBocuoOrayD3PPRBZ6ECpjUJ8aPhirRnhiTvRHkIWCqBXF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn4X9ykO2b12Z8PqheodVS+m2rQXskrPxK3WsY1LlL9UywHu5+
	P+AXLO6h8uvtBQbkE3NrDREgL4zgDhi6QpA8F7VUDz20WV8Ry20E9Mj2oGB3TBCUoBv7g3T8Du3
	wXQIN
X-Gm-Gg: AYBFou1J3XE7EeGnu81uOdv2gBkd6IXKxkC28cywPr0hMQrCaq5VwMbVCaIvw2Ajnxs
	CKc9R2wHrDWasI6U5W7yKzUXya8cWPVIFFt/5agGzSLIx+ocsFbYQP3lah5aSDquR8Tz0ovzvI5
	/jK2azS9Y2o0CpAYUtuHyIMaOofyW+/2dEJKgdd5cuW7sUIPVnRoXsFdiMkK5chwJgcW6InRIHh
	Zaii+gbIJEzuw7QK65WkdbZYgIeMTV8J7jRnQ5zpJ/LgPcRPEz4pQ7xcCkfeLldSifwBXudZ1Wn
	2k9BWsh9nLKOpCUDAGvWouKGOXUJ8EUq5II8C+Qs8xRQGPKrtgt68lQJ/Q14onPEDwCZE/ulFz0
	F49lvUd2KG62MCo54qfti9Ns6FTBlEEJpydatG7Ilrb3AG9L+/3JvFjQS6MpMJGtWwBTBuJyFMt
	m+s8Gs8jQQMu/9tQkPaocvv30Uvw3ik37hYpQlWjtR0NNan/bc/pgDHWqKnVb/rXGoOnxGb8IE2
	EFj7Q==
X-Received: by 2002:a17:90b:4a8f:b0:3a0:becb:914a with SMTP id 98e67ed59e1d1-3ab3a359f4bmr15112664a91.3.1792025858605;
        Wed, 14 Oct 2026 17:57:38 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:38 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 2/7] scsi: mvumi: reject an out-of-range handshake frame length
Date: Thu, 15 Oct 2026 09:57:12 +0900
Message-ID: <20261015005717.3719956-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
References: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_hs_process_page() checksums and parses a handshake page using
frame_length from the page header, a u16 the firmware fills in, without
checking it against the HSP_MAX_SIZE buffer the page lives in.
mvumi_calculate_checksum() then walks frame_length bytes of frame_content
with an unsigned char loop counter, so a frame_length of 256 or more never
terminates and the probe path hangs; values between the buffer size and
255 read past the page.

Reject a frame_length that does not fit the handshake buffer before using
it.

Read frame_length once into a local and use it for both the bound check
and the checksum, so the device cannot change the value in the DMA page
between the two, and use READ_ONCE() so the single fetch is guaranteed
rather than left to the compiler.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 38a92f8c25f5b..2378b676a7a78 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1039,9 +1039,15 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 {
 	struct mvumi_hs_page1 *hs_page1;
 	unsigned char page_checksum;
+	u16 frame_length = READ_ONCE(hs_header->frame_length);
 
-	page_checksum = mvumi_calculate_checksum(hs_header,
-						hs_header->frame_length);
+	if (frame_length > HSP_MAX_SIZE - sizeof(struct mvumi_hs_header)) {
+		dev_err(&mhba->pdev->dev, "invalid handshake frame length %d\n",
+			frame_length);
+		return -1;
+	}
+
+	page_checksum = mvumi_calculate_checksum(hs_header, frame_length);
 	if (page_checksum != hs_header->checksum) {
 		dev_err(&mhba->pdev->dev, "checksum error\n");
 		return -1;
-- 
2.43.0

