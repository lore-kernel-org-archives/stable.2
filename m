Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01E48C406;
	Fri, 11 Sep 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134999; cv=none; b=O7Yu2qqQDGtJGkf3+04YMJ9rxql+jYaZZebUXPNnvgZfmESGxU5UQ+LNLImosj/GcGJlkW68RHr6eTis1vdaIpsGj23C40EqikBeN9rMPA3FLg6XneEPkLPCN4xYdeKzZOguW3t3miR6GOqYSIuLWYZzevuSoMuhGZroD+UD7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134999; c=relaxed/simple;
	bh=YliyGa1zgtLzCslNtNy69+u4K26DzRw41YQWRHAfEEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ntA/SKUhE90JI/H/Ekhhxbdbg5v4OWihWUVO9slgqAfjuAGgsUWR7+bRYZhr0vI4cEE+WgGAqVf64vy3XluOwLHMXFam5XJSUBqx9PrN7oFRRQbhDosVVc0iVqLLO89RrrOy/AXsf8rSA3xqw1rQIDoDBo5SEsHaQoyrw00XjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U7BpDuNl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U7BpDuNl"
Received: from [192.168.1.182] (93-46-82-201.ip106.fastwebnet.it [93.46.82.201])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F19D363C;
	Fri, 11 Sep 2026 15:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789134890;
	bh=YliyGa1zgtLzCslNtNy69+u4K26DzRw41YQWRHAfEEw=;
	h=From:Date:Subject:To:Cc:From;
	b=U7BpDuNlhRVM0K60TlVEkGHyUbgbrDvi+M2vv00ER96hmSlZKuOR5ahjEvqX6kIlS
	 LTFB5zkcol9L9eqmTEwO8k7rnpZi+jOwI38zDOg0yK1jZ3vFyzgE0+0A89uVzbPdUK
	 PiTpniUwFqBdC99PCv/AKUPAepWs6fbLXYOszp4Q=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Fri, 11 Sep 2026 15:56:19 +0200
Subject: [PATCH] media: rkisp1: Fix Bayer demosaicing bypass
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-imx8mp-demosaicing-bypass-v1-1-5568a7a560a6@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTuQBCmtVxEXyWSsIyQNGZVK6
 d0b6/It/l9BuQorXLoVKn9EZc4N9tQBPXyeGCU2gzOuN6O1KGkZUsHIaVYvJHnC8C1eFUNwwzm
 ORL430PpS+S7L8b7e/tZ3eDK9fkPYth0U3IppfQAAAA==
X-Change-ID: 20260911-imx8mp-demosaicing-bypass-bb284d9cca60
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=YliyGa1zgtLzCslNtNy69+u4K26DzRw41YQWRHAfEEw=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBqpAiLYotbsXztTLtL3Y62JssWfvgaG33MhwjZL
 p3pkjDgG7qJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaqQIiwAKCRByNAaPFqFW
 PGW8EACrl1v7ZaaUem+zDs0hBnvGm+Aruh7c2kHnj93EfLP8sJtTLacTiNEpSxNUVh+NSaCFkO5
 BHbyY2t9ZFGU4elfVaZpRJ9JIJhbwLIzWMi8G1u0WdzHWCTMng1BAsFOK3yNvPAhUJZDWOUrW5j
 uyLg08dcqwKncwZ3ccum73AQjGbsLyr9JFGokaffyL2lT56Z1OYpVlPGS0rUhS8hEgNwc39m/LV
 yJFw1EfnFr/iOGpzvAdqd1KcQ1KjxplJYc/9bAzjnIkgRv+XQfSJhxrQbSCj1q/wQZt2CzzfIGK
 tAqxuKpSh1lO+rC+hhuBHozhkE+umrV78uJZecWDFD3v3NSD/BPtwSxn02DPcc8FZ7DF17xiiae
 LeqLxDrDOgIRmT6EaOK2xYBVqbzNM+79pptMjO0+UoacZBzeiS+M39R2/QMi76fO0OkkYyZG85i
 xa5AVgV8SD+9AALGz6FsCLs7Wr2nO54na+GQNfQzHrN1TQeNAHThpABERscv5aoVC/orAOxq6dF
 9169VFrI6JviDuhULO2DSxazz9sawqnVBhwFtZqex9Uh3HRJSaX8kaXBe6mCzqZUjznTHUUFmR2
 Z9SN6JYwQJawNbF4DfjXh1hT7y0OS9C8KQFwGX5mfvc434ZBH3/DzdhyIA+z+2NU4HTR3zs02AP
 d9s7Ox7ApK9bVFg==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

The RKISP1_CIF_ISP_DEMOSAIC_BYPASS bit, when set, bypasses the
demosaicing block on the RkISP1 ISP.

The current implementation however clears the bit when demosaicing
have to be bypassed and sets it when demosaicing has to be enabled,
effectively inverting the bypass bit handling logic.

Fix this by setting the bypass bit when disabling the demosaicing block,
and by clearing it instead when demosaicing has to be performed.

The issue never manifested itself as libcamera hasn't an algorithm
to control Bayer demosaicing bypass yet.

Fixes: 6c53a7b68c5d ("media: rkisp1: Implement extensible params support")
Cc: stable@vger.kernel.org
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
media: rkisp1: Fix demosaicing bypass
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
index 042b759eba62..496381962f1b 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
@@ -1854,8 +1854,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
 	const struct rkisp1_ext_params_bdm_config *bdm = &block->bdm;
 
 	if (bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_DISABLE) {
-		rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
-					RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
+		rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
+				      RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
 		return;
 	}
 
@@ -1863,8 +1863,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
 
 	if ((bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_ENABLE) &&
 	    !(params->enabled_blocks & BIT(bdm->header.type)))
-		rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
-				      RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
+		rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
+					RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
 }
 
 static void

---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260911-imx8mp-demosaicing-bypass-bb284d9cca60

Best regards,
--  
Jacopo Mondi <jacopo.mondi@ideasonboard.com>

