Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343693;
	b=rjA1/L1SR3L5c7QIYVzu4NV7A6rx5VvWauTxUrDXM48tHBiR9TvyzudxUSCgQFTie53z
	 NbtRtMh2sn0oCnbaTqEi9qlk3g2bbAhcAemZ7OtEVtM6ldeKHqZmrRt/D/KCxtBo7akGh
	 QcxurfUPBkl/dnRqKrRmxWOG2JKm+aWW25l47U5iZqb2uwy3bsNprqydHyU7eMpDdzieD
	 wRGVFVGPIIvEIHuMTCKexNoQEGM+VRe/csvOxatjLL/49lRFag9w+3StdgPorqyNL9HFT
	 8wO7hkGO2Nj8+QstelAY9AdFX64c1AAuq3CQLRl4elPbop8zIAu+QvA8PLpa63EIX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ERZzekx3nx793oOziPzux9SofEMMi/wA+sDnZfF5fd8=;
	b=ckSdCacx2RIzy8UD5hzrm7oKivP3a86NuCqFXi/e5yYZ/LFOMfCwv3uTtuI12Zdumtmh
	 1ROkWdWHEOQrDX68hUmK5xoLoZr55V4cN105008o3fTo8tes2Jl+6ETcnWNnC4HUB3P9k
	 NdIgBwc6jgnVpGbw41qs/K4vXS0A5+XntBGd6d/Pmd+eLbRINSGO3f68KcqBVR1FVi7yO
	 GowhrH9B6dqiH+DXTC0U4L2KnsRvwFpx9A6dS3SZG4p83Rk94+6aiOlM9yanlufJu8M5w
	 Q7z3++J1eA839UInuN8Av/ATpTUd7zXP0cxZ9CGfcNcTkvme2aQUmX187EtfQnSeDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5mlUWsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036B606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5mlUWsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F81F0089F;
	Tue, 10 Nov 2026 20:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343692;
	bh=ERZzekx3nx793oOziPzux9SofEMMi/wA+sDnZfF5fd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5mlUWsIq5Pdh8DCm11DzpE81j8WauQR4wU2LC1/COPULqxScm+DrR2oOiOAWrT+I
	 uJruojtjHUrrMbZDJ9bfE+ezypYNxMx9JjoBrCzezod4P0loXg74YBFos1zeOSgnpx
	 tvr81OXiySj44bkuOvFQhJ+bu3Hl3/mcoRDn1JZkmE+4Vju6LLfJzazyw+WkuejMpA
	 yNOi5jjuACD/Gl+EEeMqbDVKCYvfaLc2Z+ehz5Ff2tyOoQLSiP1xCIUJEEellnTuKW
	 5XuLD9kS/huswHcIwtb1V5Ilhs3YClV/7tX0ftqMJ48VIiqRQQiW0BolT94C6OL0mt
	 eWDcWzZBUj8uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: ufs: bsg: Clear the reply buffer before use
Date: Tue, 10 Nov 2026 15:48:10 -0500
Message-ID: <20261110204746.3837834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062818-failed-5.10-2e63ac76cc08@kernel.org>
References: <20261107062818-failed-5.10-2e63ac76cc08@kernel.org>
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

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 2e63ac76cc08ea376ba61fef52f7b7849e35024d ]

The reply buffer is allocated once per tag and reused. Requests that
complete with a positive status do not fill all of it, so user space
receives bytes from an earlier request on the same tag.

Clear the whole reply buffer on entry to ufs_bsg_request().

Fixes: 95e34bf930ea ("scsi: ufs-bsg: Add support for raw upiu in ufs_bsg_request()")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adjusted context for the existing error check and pm_runtime_get_sync() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index a7e1b011202bd..4b2d4169073c7 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -95,7 +95,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 	if (ret)
 		goto out;
 
-	bsg_reply->reply_payload_rcv_len = 0;
+	memset(job->reply, 0, job->reply_len);
 
 	pm_runtime_get_sync(hba->dev);
 
-- 
2.53.0

