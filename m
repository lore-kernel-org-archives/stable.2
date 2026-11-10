Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331971;
	b=ezhShBWBKjb0cuP2R+0Tq9MPyEQGWOl6ujj5J3sgKtv3yeMAh6PK02tvj1nKUO1qzycL
	 Mx1EpovA853p90gYClkGCUnUgzzLfzpH3/mNaOlvDL4SaRtuDSbwa9Ut/YC92h3OVePmD
	 7uox6BDmS403W28uyu642MNxtdNCeFZ7d+lqYId48WbRXc3UvA3yIzew0wJIAIBFCm0hL
	 MFUIGA4m2mUWviBytSSvrk9TsPL+5/xbqiZxuJYTbluFmPdiCNWjc33mjjO7KAM76KJNE
	 rzeayTyfZ8o946m70t03cYIeeUn5yjBihW2n1hvHhR4HpbZPB/G6PfPU6wSGqSnYndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I/luCiaSCVMEME0/OzS2BscHD8dCk7xIPmKkJUVyeZM=;
	b=gX0t/7DCCSBILLkHi6VfzsyI3rN4uknHFXVRD/KDLYUbGFbupl05fFjmRmxJuaN/Nm88
	 XjKBHgU1j23pOCGcQN++t32SqtLLuuYagciaqW/Tb9Xv7DHa+JO99l0rR4GcIV7cyhGS0
	 WR1VxFYfuiGX2Xt9dN+HlvPbPsoPutH5hEmphKC2MWoZlOT4ZdptcgDHG6ujY0a0bbLpt
	 3ADdU1Ku9HbK4LRujqsd6uEAj72bDyXE5fUYE4QW2mpVQNqLevmlxfTud5Xj3HhH81F5q
	 MHq26fxb/uBTbwbxQR8aUbG9eM+F6Zkz660idvaI2d894343Kb4vY8UeHD1/+Tb+KhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vqh9EwJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6D606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vqh9EwJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD861F008A2;
	Tue, 10 Nov 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331970;
	bh=I/luCiaSCVMEME0/OzS2BscHD8dCk7xIPmKkJUVyeZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vqh9EwJqwI1SSPkai2qYbrUA+wecuVV1zPedDN1QSAkziClrY5AEBF6XUbXVHx3N4
	 wf1Dk6hc2rUeSS67Xuazz3UcOM1e6rCuQ707mKlI9Ho/GjA4DT7oytgLL/JBFwYCVt
	 FGM4Llsvwwqdz0Ks87U4eVRMKQ/fGYq2jN+e9zbSMQaB+SOKzMzgR6OMq9KGLRg6sB
	 SOC7kQt746S6qOGrz6pPxwKo1MFCwxbBkXzK71WoVYXOwZqtp2W6r6I0c7dyWI4XHU
	 Hvu7UsLrWA3zFfQvDfnpwMGJRjhGH9uWStrMU79Ysv/tsIBehmI12V/rlb8/KOJHju
	 U3/w0MCYb/kSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 12:32:48 -0500
Message-ID: <20261110173235.2968169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110173235.2968169-1-sashal@kernel.org>
References: <20261107052149-failed-6.12-8710af6a3520@kernel.org>
 <20261110173235.2968169-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index d298ba71ee0e3..bd4a6dd573dd4 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1419,6 +1419,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.53.0

