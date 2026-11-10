Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333055;
	b=vNuhUHmRt/pM+EK7/9fdYCMQLFAJ/xXqB7dJFNsd4hDKzQBs/K9bW19CwMsljRNWVBVq
	 PN9IngaOVaCHOfVDbbKf6fymkoowzr+maSdEyEes4gHNHIP4x26JYZWn3qJOJgpqQrE9d
	 JOvRhR4pLd/rxlQQTFRxvo1X4u0/wc3GkOWrX3/zR6uX3ssVeLw3PsexvumklX1eGZEuu
	 QxaAW8dNSYO7k0kTQrl+H2ihBIm0LNO5CR0pgPgf91B+hli7JGaXmYvoVuvMt9l3EPB3Y
	 wn/6L12l4xMaXivcCN3qJVR04CJj3S2b6orNl7dZZ6GW/4N2lXoAIfsvEaCLyPJBC0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c7amDBoMQbActMJWOKlW5YoNv1ou3s4T4w9mL468W3I=;
	b=xDIC5KMvUhP8Q1PGglA5kjDnB7qC8VMNIB8ohxZFAjILJEamEkD90t0Nb8pKuCQtdC0D
	 O0XAuaM+Z/h6oSvrdIopk+pawN/yXNA9tmiUZFlIq11EjZZyby4UJOk7WJlpWaGX/ih6e
	 4m3NeLcH83hk5rrl0w4dN8//G3XaHv6tvU57cE2XJ6WS/a5279uwdnWvX7Mk0poV6//DY
	 jkrZmFQ2MLMlI2FmTA0uh6O3P31Ike5r484Ih+mNKtdLxFaNqVdaVAgQNsRBZNEIV7+1r
	 TEmIzv2sH2tMbZPCuUFxFGQu9Bu8HC3wB15PxWz/cwkGCDR8gSSKJ7YRliEBf7YQmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVZRpXQP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231EB606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVZRpXQP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC4F1F0089F;
	Tue, 10 Nov 2026 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333054;
	bh=c7amDBoMQbActMJWOKlW5YoNv1ou3s4T4w9mL468W3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVZRpXQPeYRdA8wt+l8A9yk7Zob0iG36z8Qkt0Fv3zwuyDkzSN77NdWG60ZdXM33O
	 OSwavsMiuaTNQlwKGDZHYn6sOf4IGqxGsdKREe1WH2DsmK14EFK5fC5PL6sGGi4n7b
	 y1lbFw9eNrJsfOJBbWFCZ/i18ron522GGlBvgE3XyO1AmQWgGgqBxXDYDqGQx/h8SV
	 fpm2YrvMpkUfIwZEStsFU/QOzuU+c7PpOIefX7LoBjdKmJGF3xU5U5AIJxNQa18Pu6
	 q4vZOfr1WR4dRJXicWStl278R+E2RpXGj1sNspZEvcymU/TMOLw4lsQosy79InLSwZ
	 BPsy/GNvtXClg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 12:50:52 -0500
Message-ID: <20261110175019.3009625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054750-failed-6.1-8710af6a3520@kernel.org>
References: <20261107054750-failed-6.1-8710af6a3520@kernel.org>
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
[ sashal: adjusted error-path context to place arch_phys_wc_del() before the existing iounmap() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 5fa6a43b58dc6..2df25bf2f2601 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1417,6 +1417,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
-- 
2.53.0

