Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719005;
	b=aS4QwfC0LsKf4U1Ym082d3uBZTNfefTtQS5cezLF1ekcMfmz+t1Go1T3DPygDIBmU4Eh
	 BbV6yGhggXYnE1DI+KQ1TDFrUDfNLOQW2Xp2iFK6QDOzXfg79XfC2d2uwt4uDjcfFo2LZ
	 aIAYbMapw9YQEaMkR9Z7UO9OU0wYvk1yQpKxDCsjcsIXGin+TEvIxS+qvH3LWihi907ge
	 obgkmM0wtWGrE/VXuJ8lWU6RE3NkOQjv02cikW1dFFuVaFdnwZ47EpYNYdpRlDa4Flt23
	 xnlGsUoB1VYJ9oYQDDxTrnlojjGazfetIH/0L8lhAPvEKkC8TzZgV+jkLOex3ouZ74A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gfPxzvGbjfgSQvoL77PRVd/vbCfWjlqSS+zdaWVTesE=;
	b=AgceOM2w/+oWMAoY28ovBM0cxY8abos2hi4lLNPqCjA82JHe02PKeR+cpzn1Q0rYSVU7
	 CcieorAEdLIDVkZ/UV+E/ui3eyV0ST2IPbUISr3ZYyuOcCJi2xS7ezsoHTrlp2yZ7VaRV
	 oQEmnphUd5iFgUuJSz6RG8nYRcWOkf8krAqaJXQwnEsu4vJcK96Z1uWplpx7CRnO+DAAF
	 zbEw3hxydXo9KlycrelmEYMmdHxbYEuPH5aIRcDIemEOZgQIQrqOLmxLyj70bgP1A9ujU
	 ipX7zSUnO4pcWsetkuaEBeg+D+fBW5SLySUOvkv8jO7NGuM+/Uj5oXyqjFdIO9dqQgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGede8XJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C9606A7BA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGede8XJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D71F000C1;
	Tue,  3 Nov 2026 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719005;
	bh=gfPxzvGbjfgSQvoL77PRVd/vbCfWjlqSS+zdaWVTesE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TGede8XJ1SMUgJLQRS+Ru7mtlsV0mnVpAwqrmuYj2tie0RXbzP2sGp+Kf31Ugz4Ka
	 gXFlD2mKd95f0FDYyeZbYRhEZQne3tBpJa0IU/AfZQGV0u99IJZe6h0pa0dfOPsD5G
	 DorkcW00EIb+COC20Ra35SCyq9FYEBiXK0FnR3ZjHbxTrTHdjxJsPFcilzE4LEPANh
	 9+2Pmy87kfhrR7PJc5SZ2iCJsjtgBq1pcnpo7CoVhkIu2HnAnMuQQCB1A7DmTSBMTP
	 c1fUB8MTyzWq5YQUjOO6hJhG2zPwZJMbm7yBEb3Y0PBiUsSeA9vK+pMkzx8i8+DG5W
	 gK9sRrkjuCm5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Wang <vulab@iscas.ac.cn>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls
Date: Tue,  3 Nov 2026 10:16:42 -0500
Message-ID: <20261103151629.233835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110359-varsity-prefix-2813@gregkh>
References: <2026110359-varsity-prefix-2813@gregkh>
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
index 2134342c2c97d..1de26785c3032 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -593,7 +593,6 @@ static int lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
-		flush_workqueue(pchip->irqthread);
 		destroy_workqueue(pchip->irqthread);
 	}
 	return 0;
-- 
2.53.0

