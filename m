Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10F28FFF6
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031280; cv=none; b=UHBITkC0vd3/fkYi8xHUb9jn4v67B2sDI65LR4/5HFhuoNZ/dVV1f2vfkGacypjQ5QQmmL/piuEFSDSb2IB7fZZti+8+G8KAAV0UX4UwxfhI80UC/fOq0ugfXomkJ2lB0L6bnBR4WwwRgXMBxpgIp3woiq5mUt/EkyFKoFRbwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031280; c=relaxed/simple;
	bh=2Ma9GnRZ1pfxKss3kXTKJt7xWTgrbB9CuG2Ct5tdYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH5bK41xFV/838qZFQdXz1TVmk3LUOLj5ncoq5znWeI7W2iVIpvWIpSPqFfoQlR9hj8VPPeA9kkHW7u5rwsjYtheFjuhCxyVJBGUgTJLKFXq8PC6kBbvJH0dlUYFxxYzvvtDkYJTDDSuwGIlyU2urS8mjTuBPpli1OMoU8VBtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=lqotXW+b; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="lqotXW+b"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so911534a12.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031279; x=1792636079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vF71tENdAwcc/5EFA5/ur+3tYq0jtuBokrygU53hPlU=;
        b=lqotXW+b8ql0AMAIGsgKIIL3rLJU96oLz43C6snCIhd1Bj6U8lseqBA+yNCw+2Gjk3
         SFSLrWViSGyFk4Jw3AfJSWHZObXsBB2CmqdyCZmkBpm5ssGcyHPYP3RGi7peggR398Yt
         Qgx5We7NuOhe8nFszxxc5Bd0+X3MvPt5xOz0easkfV4ZAQbeBejcuL3Gva4Lt4oZPf0R
         LD0Mvvqie6YwtSf88jW8bdjcNJmm4tZGzifiyuSl1RtCvTL407E5RGBh10EEKT9mmuEs
         Q2H4lyyrAuPKcUl8xlXPjZ+n/2uDVFmbnCu9RVK0FygxriDN8NCaFePD5iGerRFIW9AS
         4sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031279; x=1792636079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vF71tENdAwcc/5EFA5/ur+3tYq0jtuBokrygU53hPlU=;
        b=iV35p+2UY+j0ypSXOBQKTyihqxq1ThYCb6ooI3AFul0Dp2vUPRTxeOiTtlWBtsTo9e
         IUTtkjS0UUkY4INibiKRmWOLjvqi8ZoJzEeRAMzpknSBoDpyu8hyZUc4UXi0SF/G51/P
         LjxF69GaA564LOzOIFVAEOdBkWCDZPwWafyJ8b7lSkXA2l3CMCtarW910yZVzfpqm5Zy
         UKZy1tfzjD+l4e44yCDFcOyZHQj0jgLxC0iVR7h8booixTzr3meqtb92BpVqQOqU7vO8
         l6v9vGNHHrUP0mkme41WPCG1965m7dJhRJBhyYZh0jY7axqdegebLT/UHCmZmIxeL5Mn
         XOyg==
X-Forwarded-Encrypted: i=1; AKwUvBxMQ1wI8NdMzKjnS01ZmsEcvS7f5bi13cHbKRHANBHCutbd5hcVZe84AlDGy4iGSryOdNQnEoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8C2yGEsJSYrCMgsmuVtiEEw5b7p3gf9lp8E7xzENQtzDA+GHo
	kPKyDwYL6/K3hqL1di++0PK+Km9GKvgG+J+MnU16+6riLEVoolzfxWVKOWoKsNWRI5ymw7dr8Hf
	0Eplx
X-Gm-Gg: AYBFou0vQgqSVXbvbMe7B6UfS5lZ4TDlX6LQc0WzRyb2pZCT5fCbXfEDpCWuuywydbT
	EZ21PfkZ1FK+Kc7pBZ7kncfpFrzVXWzjh7SLhagz6wya0pbkCKvkMTvEHBgTaRQg0mRnhnM4ek1
	491WkQa5vVm21xBCZ1CthqO9roTByA7xkyOIvmE09Oww3NyT4kSnP1/h2fgxmv9qezerRYyDIzV
	/kHsKBPzyPPffINiClKlp7tvSemCWG2ygtOm9jS4jO02GoZvpsJ+GelXSiPbevDiW+CtpEwB68x
	/jhNXWoI6qyb5CU7XapCTp9XRRYUU2BDKLFDyIJxhqnuPlT4qRM7rh2BBpGdTMyutvoX1mUFYzi
	HTbxLUoOvFHdKbkOEx7X8c2wv5Q+VppF0CAyp3rCmkhVnFIvo4bBKRq7dVcbkngwo4Umvh5pyA1
	e5Dyq+XxTqE74i0lQWN/q0zWgs8bscZl1JoDnht4xHAS9Dhzpxz6oi5WRYw5fflgMORzOwWLWkb
	gfvmQ==
X-Received: by 2002:a17:90b:17c2:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ac5c873a51mr4065265a91.51.1792031278688;
        Wed, 14 Oct 2026 19:27:58 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:27:58 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 7/8] scsi: mvumi: fix the DMA address rebuilt in mvumi_delete_internal_cmd()
Date: Thu, 15 Oct 2026 11:27:27 +0900
Message-ID: <20261015022728.3936714-8-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
References: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_internal_cmd_sgl() splits the address of the internal command's data
buffer across two u32 fields, lower_32_bits() in baseaddr_l and
upper_32_bits() in baseaddr_h.  mvumi_delete_internal_cmd() puts it back
together with

	phy_addr = (dma_addr_t) m_sg->baseaddr_l |
		(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);

but baseaddr_h is a u32, so both shifts happen in 32-bit arithmetic and the
result is zero.  Every byte of the upper half is dropped, and on a 64-bit
host whose DMA mask let the buffer land above 4G, dma_free_coherent() is
handed an address that is not the one it returned.

Shift in u64 and cast once.  Where dma_addr_t is 32 bits the cast truncates
to what lower_32_bits() stored, and upper_32_bits() stored zero, so the
result is unchanged there.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 2410d2aa147d9..bd1a8c1d54aeb 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -295,8 +295,8 @@ static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
 			m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
 			sgd_getsz(mhba, m_sg, size);
 
-			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
-				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
+			phy_addr = (dma_addr_t)(((u64)m_sg->baseaddr_h << 32) |
+						m_sg->baseaddr_l);
 
 			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
 								phy_addr);
-- 
2.43.0

