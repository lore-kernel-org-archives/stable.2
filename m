Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704603;
	b=QYHop3VCU+94x/FOttTyN3FdMrF7srk2965MzWfP37nbi7MuuCDtvBjdQhgSKTmG+kXo
	 m+iRXpu8LtjLW993DQOMvRySYToMmg3TLTbCrih8tLMwzUweLUlIgsZUv520RJUaiGiVI
	 x4xMgNK9Jl/YGBVsXDMunb+qbOd4cKlH8z4IGfDaMyPyWmNtwwdnNOBXFO3xKFxkbycqr
	 rphc4z2jv7fKPWPV49kchwXmPCEhBB6C/oPeWF0OFsOis3+Kpjes+Sf6yrIolMRCwFzfd
	 IiCRZPVFKvfg4wRSZaE2m0XxPw84QK/vlv9CBmWLE9tgv8eqG/ONo6TNpYAUcz+Agrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zVJJ2NognD1d7d4h1wb/i78OMNjXv23NJUlU7dGwRhI=;
	b=3t8E+atcgYsgjyP2G8b2L3MjEtxBVcgC44F1aJLp5l6h8hUGNtVKPpC8eau43TG/lKUi
	 Swko5fyjJo2JrDtZBWGYWGcNw5HxOStYXM6te0jdPk2/IPXSozuNUdv+1Uq21tbQybqq3
	 RzfN3NKcwOjmZwUaUe209bRrr6O+QoqfJMU2oPM4h18paI+7xHMfemzHKG1adxG+2pw6N
	 /8Hro8QhpjtYXsULQgWMvwdoaDHzZnhSpGc0Izp3IQu6P+am9VtRKAPbxXv6rMxzFem7g
	 pVY9JyIPHLEA/4ehMtUl283Lu6vxbdxJ86N6SLxNpeySqD7n32TcYCpVfFO0BGyaRmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0wih8F7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387F606C556;
	Tue,  3 Nov 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0wih8F7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171AF1F00A15;
	Tue,  3 Nov 2026 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704603;
	bh=zVJJ2NognD1d7d4h1wb/i78OMNjXv23NJUlU7dGwRhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0wih8F7C0k+SvJJpg2XSwEMtfaq32mt2NPxLBFsr+7FkU2+1uzNWpvrzThpgwaCr
	 vzudhq3J4o+4toNuJFbO1Jr70Sor+PxArTUti0PCEU1P1GtcQS3INSpPYgyDxXKRjw
	 W6ZM0ebIlwHG9dGqpHQjt2GVEHAWR2fcark90/Ne3ZOfeWHy0mdQMS8HNOeLM+XFJD
	 l1JT1kMH9XXEE+51vjBubClW2Lf6Ji07Iap47yQ9pih2GoZJokSKPpejlwpc48gxX1
	 c5Uqi1zv/MaMCnLmbGRzNwX9XtIZKlHLDeyKnJcKhUZLW/uQSWXExPpbCvSuJ9xmyO
	 ZER5L9sNuW7oA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250_exar: check priv->gpio properly
Date: Tue,  3 Nov 2026 12:16:37 +0100
Message-ID: <28c09cf858795491f66667781bf79fb6a603f159.1793704520.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
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

priv->gpio is set by platform_device_register_full(), which returns
error-encoded pointers on failure, not NULL. Sashiko reported:

> Does __xr17v35x_register_gpio() return an ERR_PTR if
> platform_device_register_full() fails?
>
> If it does, we might be storing an error pointer directly into
> priv->gpio in xr17v35x_register_gpio() without validating it with
> IS_ERR(). Because the error is ignored, the device probe
> successfully continues.

Before commit 1145d1a0703f ("serial: 8250_exar: use
platform_device_register_full()"), __xr17v35x_register_gpio()
returned NULL on any failure (platform_device_alloc(),
device_add_software_node() or platform_device_add() failing were all
turned into a NULL return). The plain truthy check in
xr17v35x_unregister_gpio() matched that convention. That commit
switched registration to platform_device_register_full(), which
reports failure as an ERR_PTR() instead of NULL, but the unregister
check was never updated to match. As a result, a failed registration
left an error pointer in priv->gpio, and unbind would tear it down as
if it were a real platform_device, dereferencing the encoded error
value in device_remove_software_node() and
platform_device_unregister().

Use IS_ERR_OR_NULL() instead, so both the unset (non-EXAR vendor,
priv->gpio never assigned) and failed-registration (ERR_PTR) cases
are skipped.

Fixes: 1145d1a0703f ("serial: 8250_exar: use platform_device_register_full()")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Link: https://lore.kernel.org/all/sashiko-outbox-170895@kernel.org/
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 57847c5bd2fc..b1e20fd4cfd2 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1181,7 +1181,7 @@ static int xr17v35x_register_gpio(struct exar8250 *priv, struct pci_dev *pcidev,
 
 static void xr17v35x_unregister_gpio(struct exar8250 *priv)
 {
-	if (priv->gpio) {
+	if (!IS_ERR_OR_NULL(priv->gpio)) {
 		__xr17v35x_unregister_gpio(priv->gpio);
 		priv->gpio = NULL;
 	}
-- 
2.56.0

