Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717930;
	b=pt7V4g2n6tWEThGi2Uw+oZYiOsuFgrnhv+6OgJLoAf2pO/EHvWZwVK5qATo5Tkg55DZZ
	 SQh+hDW/Ck27+LVa2PQUlbx75Ev5v3fJAatGGmHedwM/BhpMj6t4VCAFBtuIJyVR6T/ns
	 sajtYrPAO3wb0z9W6qImG5z8uRgqHmONiiCkSvA1d9N4E7WgutjK2fx/S5XHMDL5lQ9IH
	 pp0nlZCFiM6edt/z5+7GFdtlL8WmMIwzZiGMFPnnNJwUh6nMfJ3Z4J9nk0vL8MmrO5lOE
	 1qnv71JrevdPcRxtIqFzP9fkOkmZLlIrUxvFm/rVyst9Kf9kNMPiHseEXJwPJg0u4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717930;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jhA+KhnYbwlhSg3VV9oRTAj1urYJAymDkZ67JJGR3aA=;
	b=nXB8Ra5UnEnZ5jFIvhxB+q2V0FdXLDPyRkDF3OVjMj5xKDxXOdJPIFnWRW6Z3HVHrFxq
	 Zogb2N8af/QPdJgHekd90IH0ueb0KcFTyF32ZevfHAfYut3dOvaShYqkzy+/Dt1qkHUOO
	 KMy82xn/++TYGxCYWTISUU0QcUyHy22K3rwAtQgjsEwgr2wLszuRr7BB2JVrorF4csUEz
	 3fHI3Ll5f5BRRV1rvYIoiEWLSiFyJXE//XojWZ/p0sZnyb/JV3DsJpKSTaqOaFRqcRgtJ
	 IvGKyLU5FfBfx12YikJiKhZ40fXIn5A68CI5oce6UswLXvyhK1zt8aYv5R0FjR8CIuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aI2zJN8F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF1606B257
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aI2zJN8F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E091F00A23;
	Tue,  3 Nov 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717929;
	bh=jhA+KhnYbwlhSg3VV9oRTAj1urYJAymDkZ67JJGR3aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aI2zJN8F/GswGXpuz9oBA1YzOSbzUajShsNzGA5Ap6meezlGgkIGmcpnLxnHgLySX
	 Bqm5yiJsXdZxWR3EGutcrMCmIbKiLXe0KjvNwE5cObBBuVvC4lT5xs6uEnaLmhMDV2
	 alDtK3jC117aJ4rQ5nEEbARXqo5dNiVNS+YVpF3HOj4hHggbkvfSGMxtHkksuq+p9I
	 +dIzuH/KGThMa1nJsrAtVdgzrLd/QNLALvNIMc3FklD0LClpnCNomABCZQv2uUfGgq
	 d/04X+kM9du202cnoITueg25srqZln43u3c4yt8506qiV8NP4gkhNktgHEgs83wHqq
	 YUx9MFYgG+pFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Wang <vulab@iscas.ac.cn>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls
Date: Tue,  3 Nov 2026 09:58:46 -0500
Message-ID: <20261103145824.4109030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110358-afar-payable-c2d6@gregkh>
References: <2026110358-afar-payable-c2d6@gregkh>
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

From: Xu Wang <vulab@iscas.ac.cn>

[ Upstream commit adc122011125682932ef279d717153670feedde4 ]

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: 2cf184caab8b ("backlight: lm3630a: Cancel delayed work before destroying workqueue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index a15102bf21365..0886bbce25e54 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -589,7 +589,6 @@ static int lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
-		flush_workqueue(pchip->irqthread);
 		destroy_workqueue(pchip->irqthread);
 	}
 	return 0;
-- 
2.53.0

