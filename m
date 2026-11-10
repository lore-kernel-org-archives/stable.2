Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320792;
	b=2PFRnQ0oa5aH2kKiGTQHnn/RzijmX4uaK+sZTsKxzSPHLcfcxDJ5rNFM+bL5idTlfJB2
	 uXNNF6UMbXX/YSQaaO8ckUce8z3nQ506mXYy1buo9Jkpz5sDLisAGmQ1JvBKpx7nwxGR0
	 hBivCBhCxecWvY71bu98++JOrUXq+B+8e721N3gin0/k2QPB1AGa+2682ViD7Q0zm3Yzt
	 StqeKGM2mlZVvlevSg9qA+zHEVTMnVnkMqfxnt8cMFy/GIgQkuzMPpwaEepW9+IR81l+k
	 5EdzTM+wUXjWaa1LCr0Gb2GtiRHopXnrRw2Alhr/E4PaDIyR6m6iW9isjq2nA3bYh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=18KOO2bVoMUNpygSZjOCWeE7CRYjSBs6lMoMXn3MMRw=;
	b=39a7JHrRsWYSFdKX8uRoiQEULZGiQal40opWqzsdcw5DEFnFqvW2fvegwK4hCzZUmpOP
	 z8Y0Sr9WFK70P02Xq2Z0VIWkGcjkJsBYKLwqVZqUxJTTXuXRmtz7rxPMdPvBJ2rEFAilf
	 8c8KGxGQ3N7JFnqxdPsMmUnoQcabPPTk597v7hH2t8oTh30j3sHyfegflM1eXfnX8sYYM
	 o3erWvPKX2nXGmGPX1lifoNlGDXh30f4G1Z029Kbe4VX2AU4/EaNC4FN9qq+6TJmXazsB
	 65IC+5aOU804bgP0DS00828SWzemUeZanotaLfT3LG/MDnuusXszpDY/OORlsmjhFZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO6Igvhx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5061606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO6Igvhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB931F0089F;
	Tue, 10 Nov 2026 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320791;
	bh=18KOO2bVoMUNpygSZjOCWeE7CRYjSBs6lMoMXn3MMRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WO6Igvhxuv2ODA0j8pZMuR3LyWkOCrNm3jfZBcvYTHY7Gn0WfJxSdUWqjU+qs3dBj
	 QM2SzyOJi+9m720vxAXUSuoP1IT1LAAfRz5Z+qcswFpYS7iCBFAR5GpzJ0WjTOElgt
	 SZzynrg33QmwWkEZbF6++JIraAThwZX9WJtZ5xNN5/ypq4D6e/qta7A+lXlhM+6/UR
	 oKN6Vk3nkQlesUNyNDG7cbROli4QNLxUOBN7t8aT/eaBvZq8F4ViSxwTPKv2EU/iJn
	 lTUeTfuRyg8z5AUJyUAiFYe12qFvrTVWZuoNkpgbIqoWcOvujTrx+OSgjwTqF6Xxyp
	 vR7DM51ggYW7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] vfio/pci: Restore 8-byte ioeventfd support
Date: Tue, 10 Nov 2026 09:26:29 -0500
Message-ID: <20261110142619.1881323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050755-failed-6.18-b30b52c2fb82@kernel.org>
References: <20261107050755-failed-6.18-b30b52c2fb82@kernel.org>
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

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit b30b52c2fb82e6d38ee2845a4d85e8254b44f3d8 ]

Commit b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef
ioread64") inadvertently converted a conditional 8-byte rejection
into an unconditional one.

Originally, 'count == 8' was rejected only if iowrite64 was undefined
(#ifndef iowrite64). When iowrite64 became globally available via generic
fallbacks, this rejection became dead code, allowing 8-byte ioeventfds.
However, b44a06bd28f2 removed the #ifndef wrappers but left the nested
'if (count == 8) return -EINVAL;' intact, breaking all 8-byte
registrations.

Drop the unconditional check to restore 8-byte ioeventfd support,
matching the original intent.

Fixes: b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef ioread64")
Cc: stable@vger.kernel.org
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/r/20260922040013.2188-1-lirongqing@baidu.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
[ sashal: Adjusted context to retain vfio_pci_core_setup_barmap() instead of vfio_pci_core_get_iomap(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 25380b7dfe18a..8338708b99c1e 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -449,9 +449,6 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
-	if (count == 8)
-		return -EINVAL;
-
 	ret = vfio_pci_core_setup_barmap(vdev, bar);
 	if (ret)
 		return ret;
-- 
2.53.0

