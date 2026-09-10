Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064103AD515
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084479; cv=none; b=kLXfTFPxfIjdgLzsUvSiIoJcwYeYZjrHOaFOMHP8g/hVrjQ4uKCWRIK0phY6WL6JvSqBx9XQH6sC0/oi0sxfQHnJShws/JsOOz/p9W1+nanrEsTIVAplE2GGbMfMgeKH/xDonnHRTdro5FrL8YZDMnt+4eEA0VZ+XHR5JuJITq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084479; c=relaxed/simple;
	bh=xtwXIZOGEy5UPVOOx7FUe2g9BLc+qYFqk68bmhTQ99M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7mtp0BRx5QtUIeN82DeF7hujC8Ft1fhYtPCynpjCLW/8Bgz+TEF5JJa4bH07eHgZsEfcPKOkN//WJ+/e7KYC3IRA5BRhgA1rLrudYyUHcevuNun5ost95E+RZ8P8UMoNx0gYMzLEFwpGrn/PIZfPhbmBaKAUaQ20nPahh7CTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQvwkXwN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQvwkXwN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5302b692c8eso4571871cf.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084477; x=1789689277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=FQvwkXwNsIqteS+yvvXaKi0hGm5Mqa9IylVV+EQu1/0z20/7B6PIIVSVKbMkpj/WzD
         lGrEHRAPfUoacDPgF08Ou10KOEN2+cO2BKx5gRt2HVD7pwyidXBxrhqv9/Cw8gHjUPvm
         DYoj4QxEU63TsyP3LTnulEXxa+Z1IAtzADzDOw/pCYNirM2JTkbD9114fEIGKSRkVYzA
         zCO4kvFnloFTmLSXZrlWUa249wb1HWjhWfn4q7sZlLkMFDdphkXATqqJpLLeTVtiT5ei
         znpHKIhoob0lZRqh0Qp90okSWacnUUhAB7GvAaUnfuimzDuovabSZouF8EEYtQwXAb6U
         NWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084477; x=1789689277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=g3n/UBbDvUuxN2F65p2xbqc5LkZYvrrU8VJsWcIKKjO2dbkAnbudIgaNXLcjxiDGOd
         mfLx1VAEPQopVJXh9CB6UOTLktjmjyb2rWCW3E3oCQTDjcbJ1ct6p4xormGOFKoitCMp
         5U7qgKrQjEfNusNG1BTcnNWeq3KNjT5mJTw4afhbVPrgQxGF4Mj5ISgx4LmJwilT3UGz
         NkkiTf0F6vuMk4ScB0YERdb5yqxhE2gzzJdFpEA1li32EGsYMfwk3LCZQuHB+7mbbGIW
         DRqU2BUJKss1BrsYMocXDdHy8LU1z/e3c3OEXhLoLBTv32t6Ni4dFzzHPL7k/5kFJfTf
         esQA==
X-Forwarded-Encrypted: i=1; AKwUvBwRY+nzAMtvidbR8YP/Nf4ckXdYUKFNwFA0LtWeFnrkmTNfiWqgxsvQ/d0cejb0ZRmH4AsUZpY=@vger.kernel.org
X-Gm-Message-State: AFuF++k1nAlswp7lom91QjvgkoHvu8Y0jFGdavjxDt69hiYCBCu1mlvQ
	sl4Zml/sYLtb8Qe2is1oZeNh3fI0AYGcAM3wKSi/dF2t4YQfirNXqNg=
X-Gm-Gg: AYBFou00xAcGXae7iKXrWq9NK/l5W5WTaTrzBdz8vfdGPlD20DhpmAFQDuobaNyxlE0
	vmhIptL83LG9TxFiiq1fQzf3s5qZ0DctlT0LfaQ4ExkP9HvkSUqLK9bDvgTieuNSptJRPt4LaHv
	xUoESDfaa8ScvMk0JGhzt5B6nBYwSLnKK0JTHqj53N2NpLWdR2K+dxyyc6iLOwLirdr5bPdpaZX
	EQkOJ0Bid+E1zQkuxDxIPkEv0X/H73ST/0xP8RGgu2W0OxSWB+DSIVzZy/Yh9n3KeifuboNL7PN
	sq4cDyfZz+XKBdCrgaPbKtrlP/YYzinOzJ3/7Yrolm5NDHdgV+0AInIuvYcspWgRSIjzBwLQmP1
	aUCQAa5EbCxakddndSuUSkVzm5DxuWq5MhxW0Rs2mdMUen/hXkSixn1YllnQ0e1UuZEPLjpEH73
	MumOSnrOJF2dlTrzEPAlldQox7wqpHsU4XzQpkil+lS+zOGreL/BzDXsY7p4HDrzcXNzvYjXi5d
	pMkZeFw22ztu9jsHFe0ncynPHoKuzIh1ZkUz7f7yVZz2zUisSIxLozGan90seLgpkjGAu84xPRn
	Hu4AuP/TQ+z4QF+iipzmcJbdTEZJNvtnIc4=
X-Received: by 2002:a05:622a:1389:b0:530:b2e4:d5a2 with SMTP id d75a77b69052e-530c87a548amr28704191cf.61.1789084476627;
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/4] net: wan: fsl_ucc_hdlc: allocate suspend backup before quiescing
Date: Thu, 10 Sep 2026 19:54:28 -0400
Message-ID: <e83f6d9871c4110959ca234f618b3878d5c4f648.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uhdlc_suspend() detaches the netdev and disables NAPI before allocating
the parameter RAM backup. If that allocation fails, suspend returns
-ENOMEM with the interface still running but NAPI disabled. The PM core
does not call resume after a failed suspend, so a later close attempts to
disable NAPI again and can wait indefinitely.

Allocate the backup before changing the runtime state. An allocation
failure then leaves the interface attached and NAPI enabled.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 82796452e54a2..596f4ef053636 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -888,6 +888,10 @@ static int uhdlc_suspend(struct device *dev)
 	if (!netif_running(priv->ndev))
 		return 0;
 
+	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
+	if (!priv->ucc_pram_bak)
+		return -ENOMEM;
+
 	netif_device_detach(priv->ndev);
 	napi_disable(&priv->napi);
 
@@ -897,10 +901,6 @@ static int uhdlc_suspend(struct device *dev)
 	priv->gumr = ioread32be(&uf_regs->gumr);
 	priv->guemr = ioread8(&uf_regs->guemr);
 
-	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
-	if (!priv->ucc_pram_bak)
-		return -ENOMEM;
-
 	/* backup HDLC parameter */
 	memcpy_fromio(priv->ucc_pram_bak, priv->ucc_pram,
 		      sizeof(struct ucc_hdlc_param));
-- 
2.47.1
