Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9E538D8D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991176; cv=none; b=AbJKBxe27bRjLNyyWjBtk/HM2vgBiUKrGvPDYTOF11TqJZ/4++h9VDt/SOi8aDS8mxCMg8Pfxc9GkPaE0ZESjIaVSCyAuLgXF/2Dcdl0Z+ZF/ZDeVy+kLSTf5YKjL6AtGvUlhhNnJLsrdRCXJIt5DZgHwSQJv0woNwfAw2tPhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991176; c=relaxed/simple;
	bh=/0Th4cc1vO+E41gV5mMuaLCXH78VA1Yl6fBR7oSaQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI+OFaITIeuYe21Nicwt1SV+S/4/WDzSeVBEDnCFB44PtwyYMoWwmKf4e+pPCQ2btMAxXAXi2iqeOi3XgLxsjszkQTrYD0LCs6aKBgq2BH4xayj50vtu4SBO66GfZJDy/nY+1clImnbfYfdCHi4bWXE1E4WyIOcxgbeerEZiPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=W5QP5ZNC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="W5QP5ZNC"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so94980a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991174; x=1792595974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=W5QP5ZNCg5HOM970gA/cmUW+rdLt4vu7m0zwC9EJnguKn57fl5HlqMRxS5OCDkjev9
         Hts/E4D3UMK/2mOboKdTJfHWgJHqunfUzgVaqOKjeMcxsCaFqLSiTR/zob1btQD+3zII
         m+oV2XfupFtergDCqatrkeL3PGYh74XE98VbAjy7Q6LhRA2qkb5hzLGegs9IqTAZu1fv
         IBH8NRwJZ3arxzilRDkQ9nm/SuGt9AY0+rgglNYYYhuxIROUxLoVJh/hWGr7vAS/YE5E
         axknfccnrZmOLC4gCoWUlMV2zWowO74Nd6TuCYn24F5y+/+lI5KxKjdlyOCPAA0JR1or
         pE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991174; x=1792595974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPVBPUAW/BeX8HkZROCJHuR0r1MMomkKnirbqP6fatU=;
        b=DlkhwBm7BBa1gPhSDJoJy0tTEhXl30hj6TBC+73V0jHsSfIv+bfFgUR57A8y4JeSAW
         Uta1rN3zGCqQx7tDt1/U8LdNzwVl7X8BLcu0fI0ZXWMcQpfSfF6OLSl3QZnvKfk9nvJu
         jealfu+ueFZ/FkanHMaws5MhfAqNjUGieOrQOAmpaf2erOb27T+Hqc8Cmyt0oT12EWDi
         DQfPlEbuaaFasGbNVMzpadPdMVpbvPwonwccTqZ49MD8QsZVNa/b4CKTn75iVHlk1yzG
         B2INuxPtYWSAPaHCItIc9TWu8algH9p7jFgBJjDNR/4mCKuUo4LnEFvcawJwnWUs5fCJ
         DncQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiNcGgltVV9eTLTNFQ79Iojnj/NeZZKHjuND/9X2UyQnlKXxA9Q6pu19+j6sqSJIx0oN/5SVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYITAdHRarWISklbjVWvYhGQLqAcV9f/+k3vj3brJXyR6pmyQl8h
	5Ospc8t2Tlh6CaJ9/YYCI2lDZ0fcv/+JEpkEHsvrz4hrlTHUsEHWtvqJnXzqfRDnUaMgatAl1Kx
	WOfSD
X-Gm-Gg: AYBFou055ITJS9lKlIFu0cPkrltR5ToJkIJmTm56gAuWBJnP1nwMhPvmFfxOdMqYlVW
	fye6axdRvz0yerz7c78D8aDJXowDGnohj7XWCJxfHBQXKkqTk+1+zOp+QEYTnXOWdPIPJB2xE2e
	/BqK1kLXnwOEEGbn66fFz/wJpS+Y6+wu8Jh9QyqBl9BtCarBeqXqVUbXyA25SLTgY23qI1F5PTU
	miOIgDyI+in2UPPxbwSRQmkW5YmJOhcPRm5Zh3m5Grl964h2gm35B4/fz7KzwU5jXKRyg4SaswI
	PfRtUzBvL5iFzEE9C1u0lzqVnaF4M28/fkvkFfIdfI4zqV40lmzOsj/hqYPnNXBPUz4GqRYv9jz
	3h1s8mRx3aAmogrHYmz+3EbG7F1b7Bdvjn7JbsgIAQtJ7aEy2CwyMkR5qF4Gm3IgcaqrIPxzk8g
	m01ULizybuwcDQQgpr3Qw3+X30fFBAumiwKekluorjdAiLOkMBegdef3OoYmOKEMivJrFA2mYew
	3dTVskcZtlTC3Wj45as
X-Received: by 2002:a17:90a:d17:b0:3ab:b764:826e with SMTP id 98e67ed59e1d1-3abb7649dc3mr6448099a91.63.1791991173860;
        Wed, 14 Oct 2026 08:19:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac8d40e7f3sm622450a91.5.2026.10.14.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:19:33 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 2/6] scsi: mvumi: reject an out-of-range handshake frame length
Date: Thu, 15 Oct 2026 00:19:10 +0900
Message-ID: <20261014151914.3632701-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
References: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
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

