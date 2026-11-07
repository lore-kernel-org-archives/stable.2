Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051982;
	b=DvZi1zk4/dqPjdF0iaef8fzou4Y+fLX2u3BBe6ciHNaTGeYFIZ1XevKanGhZztOCbIRF
	 NqMLQDzkQunlidjiVnUxhKVYY47BDQt0A6A8JQECH8xVr0PSMVRSTS+S/yIsK1bNXGg7X
	 E/TF7Q5Eut7pofV/78E7vEjP8fwqUAz83sDhgzgO8x/rzXe9+fZkN3smURpeaeoFagFt5
	 Lg4VELJdwx+WC+yt4lWkAIuMj8N3YV3ajCQ9Qrfjqmc/ffmAgvokQsLAIilO+bDbmbAxg
	 Z7oqDwTinhX85nPHI9P1PcDajrivJu58INPb78LycFSdspudiJI8CQqL8GBZRvMV3Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051982;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FoJpIHfSpIS3/QYPEruscC9y+4202qKtdIhXLO5zKSA=;
	b=0vhH6hgfs8ahWLWJpfZQNaeW/YUJdg38lV1z6m3M8bAcfEAGABjNqLU/lU7pk9iskpko
	 fCVQqxDPKvuECkImKyC+d9GMUl1QIlCsMMcg+9rXHQYoUMYPjOxLKl7qG7hNTjWr2GxXF
	 V4q3CWlYlhyfGS5fMDSyRkTY/aJ+kOEaRcRJLDOamJzFkXuoi6bqxRUcdcfyWl2szkArz
	 F+qF1mhTo0y52aO+7e2TWWJUzHcJqYpJK/L9ZEtdH0mEq8raYkwdhR0xYuFFqnKB7sj4A
	 cADYSn3emiJeJ3n1hOpHToG/LL5D/rszuqjQNnlmXe6wMKvGMZo77hDYMymvfstTQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABM1ogIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2E606A32C;
	Sat,  7 Nov 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABM1ogIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38671F0089F;
	Sat,  7 Nov 2026 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051981;
	bh=FoJpIHfSpIS3/QYPEruscC9y+4202qKtdIhXLO5zKSA=;
	h=From:Date:Subject:To:Cc;
	b=ABM1ogIwHoJH4tlmYdvw/HNk9Rn52561lHHTh94v4JqT5rUldqtHYFib8hOQTbEyx
	 ilYBcxsq10EIvt6F5IurAyoW0O0sDegt97SJytOIaVB4w7lmsEowk4rr2JB4tl6Mit
	 ybVjAKZDg5+nPxBF0PlN0fmVvTWNCvYaDBKyKF36C85fNi0JWVG19dV7NJuBfyU3tm
	 1uVzfsgmrmUOqK0hTVkBR+wtAzG/2n6bjALXJKYdEwuP4mNgQyyTtDz9WjXhKsPS88
	 J9iWx+hBtb5QidLBFKkLWZPekPxT+rgccFW8yJDINZ1pGr/ju2ONjUB5y2TIjFyBCj
	 yyWs5C0eULoaA==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 07 Nov 2026 12:46:17 +0100
Subject: [PATCH] usb: musb: fix use-after-free in musb_remove()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNz3dLiJN3SxDTdtMwK3aTUlOQUy+QUizSTJCWgjoKiVKAw2LTo2Np
 aANzquTtdAAAA
X-Change-ID: 20261107-usb-uaf-fix-bedcd9cd8f4b
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794051978; l=1609;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=2+tNpPgT1lqjQ5iUv0JrjGxDk64BEhMvUdMRlfsw508=;
 b=u/mh4bkq/FHjK94y4JBivQ4v9qjz2EJW1RiFslAjV0ssIO7GUlU25SwHOBWbxi17DIeGZES8k
 WUwbjf84ktDCirh2AmI5Vp3x8g9m8qPetvgWaplxC4skJqKqYjWLyqc
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
before usb_phy_shutdown() is called, causing a use-after-free bug.

Reorder the function so that usb_phy_shutdown() is called before
musb_platform_exit(), the same way as musb_init_controller() does in the
error path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d180c2b9-0006-4638-a22b-13df8c201235
Fixes: 39cee200c23e ("usb: musb: core: call init and shutdown for the usb phy")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 73ac25f53698..8e52246de948 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2642,6 +2642,7 @@ static void musb_remove(struct platform_device *pdev)
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+	usb_phy_shutdown(musb->xceiv);
 	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
@@ -2650,7 +2651,6 @@ static void musb_remove(struct platform_device *pdev)
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-	usb_phy_shutdown(musb->xceiv);
 	musb_free(musb);
 	device_init_wakeup(dev, 0);
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-usb-uaf-fix-bedcd9cd8f4b

Best regards,
-- 
Joshua Crofts

