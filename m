Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333479;
	b=Chr3MSSjXWMemOYzJTZqWpfBN3hPj1igQVLc6vFLtza1jrQhy11dXAIcvKXLGqowLuIi
	 zcRXIaPCSTH4xIWNFiVeec6SU82HeLksn2x0TI1BTBcb9t+4iR4LwLiPZ1ChGQE2u/xgG
	 adqWYHHbaFWJebhm8imKf+TceQ2QCR/5XlyVITxn5E4Du846M0Y1pZR3e53z2YvLA/pBt
	 xICIhXsCb1+6wJvWhC2fgk6dsZZLb586FhjI8v1v0urDG/hJIsPsDOjHmPWvLACs/35TH
	 DCcSs+KFDavNABJhCwe4dVS2D66V+0SBsZowLf/bgB4pu8zxanIovExwSqkU5OOq1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O5FhjOi+Yd3491xLMtHiab4DuEfff7n6NthzSzUKDV8=;
	b=b2TsVe/W1xKp9Zl9JPlmkVmhKVkBzEWshwv9GxZVpRhsxwcLWVkbEMhiJsBxfc/JbAG9
	 vae4ZuMwHwnQTNmyMFO4kkK+Cu75gfOLdbzlwSbJinGZFDj7yZPVrdU0z1MnlTTlVleeN
	 ZZ+me0raLjKE9Pr2xUe/Uxl8vSL89YPObPmnt0qnL3KEIW5uk/gSgOpuJIrN6gCY97QAC
	 I1/XUfvT/w+p7k6H0IPf0/gZ5nRu5cWz5aVikYqhZqd4Apo+DzzvwPpRMvQgZHRSNv+Z1
	 jM2MquGyYZ7wbXJfYOGXOlZ57bSpbZ3RFpVIAXpX03hoPK1pBoocogodkw4374LpV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuNrjR2X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FE606A202
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuNrjR2X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADDD1F0089F;
	Tue, 10 Nov 2026 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333478;
	bh=O5FhjOi+Yd3491xLMtHiab4DuEfff7n6NthzSzUKDV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuNrjR2X31v4ULtQcjcZ+lhGylmuJsHGdzb3qAgLAU4/iDaDe8XAECDdyJ8EhKfb3
	 5Xnej9sLf6Ci5+cFA9T122dZ7X6Qdb+Q4ApIOvXZ0WQucLxiBqM81JWy7vvtrwhIsD
	 7ZbDWPWvpT7UlDTy7A2IgWmNWXeOHD5HIfwlhwY8VikSMDjxqOQ0RROoPV5J5qUnG2
	 iTOUFnERZAA9rXv9f3f9eiQXC3teBJBcBJNL1pQDgLax0gvr2ypmfmyo7J2RGSpAEa
	 za5co2EZmdT04FKtyzX9+w7sxEdZ7vCk6jpBgR3tXc5DdzxVgYXUx/1GAyuqiolRv3
	 ljWmpkrdQ/gLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 12:57:56 -0500
Message-ID: <20261110175729.3076553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060512-failed-5.15-8710af6a3520@kernel.org>
References: <20261107060512-failed-5.15-8710af6a3520@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 8710af6a35201a6d01b5af8f7e4bad29cc40467f ]

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: adjusted error-path context to account for the existing iounmap(info->screen_base) call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index ecf07b598453e..05d3d1fcd81d7 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1408,6 +1408,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
-- 
2.53.0

