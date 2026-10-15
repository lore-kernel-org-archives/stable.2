Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B02F6188
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025875; cv=none; b=d3evKBVJW1BVTzecW4HZp8NcvqjnbhnrazbRFJ+U/0FfLuAuolF0Vy6mbbgKcsZJP86LVwgv92OIQw9m+Bdn0ahw+5omN1zpQwZjmN7iKHLIAu+dD1SK1dzJ17qbhApDHIPFwyuXVypKAhVRR9m14YbQIzuJsSMi42RFqHRcGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025875; c=relaxed/simple;
	bh=2Ma9GnRZ1pfxKss3kXTKJt7xWTgrbB9CuG2Ct5tdYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWCWYDFnYvLbW/WkqQY2ZFeLefxGq1mjtNN7jwrNLQUv27tblBR8T06oKAUnWEgRmvhRid5elctcodqhRfGDPyCqmUxbImjJqxLDZw7Euey99ZIMCqL2XvdOd2joPY18YhWZndipHtvmjJ6E3+aOQ7r30q3td0U0ALCn+N2ylDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=SotAyp8Y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="SotAyp8Y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so956007a91.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025873; x=1792630673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vF71tENdAwcc/5EFA5/ur+3tYq0jtuBokrygU53hPlU=;
        b=SotAyp8Y52320RhY7JRNVnL5jD+Wb6ofMBdBCkKYgl//1reWVVtUukYi/R4M559RJ4
         MFaLidxe+nCp46cPAh2kyLUVbmN2eTpAqNWs3vJbq3Cj6KP5ykg6cWOBcHWc31tNuCNU
         xMdH9YYBptYu1kdfOjOvHXmBB0UPkeXrTCc+8iaKmK5ujCF8gTjjJhx2tGI6jsZOhLkp
         VT/+AzrjYnyzfndG1oQMVbZdNB90ABv5XwdDezh2YRBC8PJ3SOWO0Qr71YVPeJBA7+fK
         5iQhfqc1jIo3gfwuHkpy1zKq7sQ0R9LiOhbXd7w4vrelmy2woj64hNEi6vVkvq8oK0L3
         7oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025873; x=1792630673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vF71tENdAwcc/5EFA5/ur+3tYq0jtuBokrygU53hPlU=;
        b=UV3bnZ1Uw4Hg+0pS084LEB6SX30KocKOl1e9/jgihPuW9c84wA8d5YvMgLI58Jp0W9
         ieQkPLM0rieNYG6DequAheza7bHKbzSLb0yNZfVjpkttPUkMttMYz6eTFOwWjRpF/MSE
         YULRSutrpB+9t9zKEHdk+BwtvNjRw5rqA+0I3GVxLk5dXwyjwOclExjKhLrCEB8JIrhj
         lPPNtj3sHxwuKpWq1tH28MKa63paDeaftFhaee0lSx0UOpq1XbFpKBIJ8k3lj4OEnX+e
         hzp1uS92zg+pj4Bp5sga8LtnZP8+h4AKP61nrf6Jjpdp8z/AZGTGxuIhTu0APAL12GL6
         cpCg==
X-Forwarded-Encrypted: i=1; AKwUvBx/TR71K8TUSz7rFJqFF7gU2z6KW1w4XTL+QyZRanvdFcmvhL5pfn95RhUjyLWnErEj88Us0nU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLk5Blt77QU+Pl3rSRDAKSRGXofqu0peH38k1hgX5+2v1sWBWJ
	SlDwgTF32DWvd8R5ssnw6ogXtieg6EHREROW2dYAOxPx5iAT0CHnBWR0SiSZhe66LtM=
X-Gm-Gg: AYBFou0JmjBkePvNo/iN0NbOAWzzUS5ydbSFTHkIYDQJXtDtzZvW3+90A88+EO8Ewkt
	I4QqOGOAMPXTDcjPasLLRq+VN9LpIJ/bj+L18p/MO+Z15liRVh4L0adljsjxkEN/CEdCD2llopP
	3r/oLzDPqEDRJAgvOUTskRbQxtcobTCUvMpCwf6VXMLfpCOIsqQkFCcN88e9fxiv8hzD4YBm0wT
	x1eq/3pdzExL/PH2MysZXVCUUI9FG7arXb6NL6plvqO3auCicJ1Vp7PzrIf3b082nBe5AwC+UFE
	eG3yN8TNWkxGqb3BsIAL+qlSH4pWg4BY4B/FgwD21CB1jaZ+xVIaR5y8BfuRH3Wm08lEkK1WHEY
	Kunj/4KXjQOfDlw2cnBrIF+Rz1bMMi+1/42QulCr6uDOg8C4ygK9prRf62Yy2lwhS/sYmqjY+Y8
	LBhQUhbeULvzBk4GM2FpHOiXPoheBK6HlrsOtgeD3gEjv+HyKYsGzIvpbRR2MOaxCYxY8mfscu8
	h/IpQ==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ab3a9a8d8dmr16519426a91.25.1792025873377;
        Wed, 14 Oct 2026 17:57:53 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:53 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 7/7] scsi: mvumi: fix the DMA address rebuilt in mvumi_delete_internal_cmd()
Date: Thu, 15 Oct 2026 09:57:17 +0900
Message-ID: <20261015005717.3719956-8-yhlee@isslab.korea.ac.kr>
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

