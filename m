Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184599;
	b=pb/uJxofBSCzjoVFaRGxau3NgUgbE1GD3e++yAdiVPlPdwe91Yt+ZQGoQjdNJ86hX5h1
	 aGUpNwVQzCCIKxtWNhbHfy2+A7PTW8Hiq1fcVH321IeYbaubGRn3Y75+SK9dL1txvrD0p
	 jsB2xrSUkCd7Mp9soLtnPBpisl3whjauA5VU6Y3M9JTP2kl6yt+VWVZuVMRUjdfhef9Ss
	 Il2E39brXPQdZSwG1FMKZHxkOQ6DwUNHIvvj2PKxq6CmU6+ysvqPKmj3mwo6sHB+PmmOf
	 qvwj35lddDky4l4Yfbn2O6bNQZf81QdoLCUxdP2Io+gJOIwwHSKYCCIKgvPtLa6IDBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184599;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qdWUUq41d3eFaVJdHQ/J8Yy+6VasiGv6t9mZQQCSKgA=;
	b=3Xcb3SPtxcUl7NVsyW90icgbAza1IYndaplB+2N3XUMfKfOMX8NkKgY0UwEcK2EiZaxz
	 KdhPX099f71flgclDbBCM7E0vLzKBGbI1H0Fb7wit2CXMnDHDgG2owrxtAdTdMbUnsNPU
	 NMuPJABtWG/D0wN8WfARe19I57nPbCfbJycAcKx3FdRKPI+Buc5FoxXLIBM+maiHRkzfH
	 eKWKIiJ3l/1k+6VeB5HJZk3UIEx59RMP/gYVkJqWdbuu+zxtLn2oV7E9/toihCNvf6Rd9
	 CH51hLReQuo3Jx1/svbU4nDu3Hh9mHlTGShd34VdUeuIzEQbcr6VXKGeUNkDlWg4Tfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ek5ZKLbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C828606A320;
	Fri, 20 Nov 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ek5ZKLbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F821F000C4;
	Fri, 20 Nov 2026 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184598;
	bh=qdWUUq41d3eFaVJdHQ/J8Yy+6VasiGv6t9mZQQCSKgA=;
	h=From:Date:Subject:To:Cc;
	b=Ek5ZKLbIdKNnA6dtvZzCkPaGO5m+ZVrC6QSglzMCSEuiocLls5dfLIs7Pkw0hRVZL
	 clp1QF7KdxRdZeLC4c4qUw8iVisMCSDO7EjAPLhnD9pSG6uf7oBEBMOmfzwu3RPB4q
	 xNJh05A9qKxMY5gkZpqTgiD3xo2fBSymiek+KaxthG4VZZ5XcFayOBmSKZ5BJpkpWU
	 Te+xYlp9WVmr6pf0GjzGYzPEdzISSVsmvAN/BcyDUlIRJ8N3cprB7/sBL1odyUAwBl
	 W5WSHTiEJ3p7brHdKJrAEjfhfqDAKzhpqFRbFJJaPfAxr9VQ0nyQtIGD/tT+MPEHII
	 jEa1VjURDqEkQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Fri, 20 Nov 2026 15:23:14 +0100
Subject: [PATCH v2] usb: musb: fix use-after-free in musb_remove()
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
Message-Id: <20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org>
X-B4-Tracking: v=1; b=H4sIANFXAGsC/1XMTQ6CMBCG4auQWTumLVh/Vt7DuGjLFKpSzBSIC
 eHuFt3o8p3M98yQiAMlOBUzME0hhT7mUJsCXGtiQxjq3KCE0lIqgWOyOBqPPrzQ+8pZ0q6SYgd
 58WTK5492uX47jfZGbliJ9cNz3+HQMpkfVez/1EmiRGvKUh+OtXCmPN+JIz22PTewLG/MWkcNs
 wAAAA==
X-Change-ID: 20261120-usb-uaf-fix-ff4cbe6c4105
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795184597; l=1771;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=ImBZOGSy/3es4iqt+RSHnVd4JCTQumrfoYp6xlA9bTc=;
 b=/4jq0RnBeAgt2JHQskYjjDPiMpKtKieJRF8CE4NCdb4F5nuUkcrRvtheTh2f1B5qg9+atiKHn
 WPecZ1ZGIjqBjmSRdnowyXlAZ8/KZs6bK7ztLm61DyN+jRtw7mFacdl
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

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
Changes in v2:
- Rebased on usb-linus branch
- Link to v1: https://lore.kernel.org/linux-usb/20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index eb29ae47697c..1715ff1dd424 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2651,6 +2651,7 @@ static void musb_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 
+	usb_phy_shutdown(musb->xceiv);
 	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
@@ -2659,7 +2660,6 @@ static void musb_remove(struct platform_device *pdev)
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-	usb_phy_shutdown(musb->xceiv);
 	musb_free(musb);
 	device_init_wakeup(dev, 0);
 }

---
base-commit: 81fbc49e54cd8a8d10677878cc98a76d44797ea8
change-id: 20261120-usb-uaf-fix-ff4cbe6c4105

Best regards,
--  
Joshua Crofts <crofts@kernel.org>

