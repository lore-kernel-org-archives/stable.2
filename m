Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C1353A6B
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002223; cv=none; b=UzpR79eG96PYhE31xWJQxkLHN79mKaaNPWPmdKsUOx65oa10NjPz+yKihsBgflLqpytxVfy9iiNg513fDEp1N35gH/4dukw7+G7MF1jaSiliwdWCiJBsgipn9fb+GOMO6LDH6o2JEMw4NUzf/UE9Rf0BLErrcVa4fo3ZMXTGq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002223; c=relaxed/simple;
	bh=+zOGPOWYYp3mtciY4HcVIIxjyTC9dPPH8Oh+OEDd3Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFEqBUUW+RcbaAgu0uRaWe25Le/nS9F0EQmd1ZBtgth6OwJPbCd+wblFgjPOHuOYD7+2CespOCns92+qUi7sfZV2WGGD0Cc4jKxSTYBSw+iGa77cJ4nE+AsAqPsSJDZjBWnzemfetkO53eGyw1nRCFY9Aa1xs/9v8Ad79sVWa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5svpgsh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5svpgsh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso26376555e9.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002220; x=1787607020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjofeyvckE+h5b1Kd3kTyp8/0NYwS43KnFfuXKj6AwM=;
        b=V5svpgshtoX5MkrnC8UG0gjG6PY0aohr3AJjCDeIzXTfI4oNImEk3+Su5RsZzmtakm
         +xY+FGKBWGQ8LG0m+J8HOLjvcVBXc2lRXTiKMLUdfbq8t55J1bnxF23Oiazx9h4GENNY
         OFAtyrY5D2mKqnSxZN1+tCawbxQT53PjXF4chb0Zhson9T/kfBOlz4RejYGyUpkhXs+d
         qPXy/V6absXX/qzNakEr5WEsUOi4BlTQ3ZrU1EPTWVuBAbGvCGlpdTAybRzFwA00wiHk
         qZ8RcCfyGgPVqLdyHvFoWEp36b8NwUkV0xriObc+GISM+9V33Oeeny65N253VSx7auTV
         QIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002220; x=1787607020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjofeyvckE+h5b1Kd3kTyp8/0NYwS43KnFfuXKj6AwM=;
        b=dm2a396WLBfKiv+SgYKRzHqnZxHtd3D1KpcmNNmqMwVVcQ5fXuvIkV8YAEYs51S/ga
         4LIzVyO9bjiyQBpt5AMkzoq/gSySsayJen9swsWfvHZvVvmedZIomvxs2rYcYjP0WBSv
         l/9yaiJaGBhqg+XbbOe2Ohys/FUV0sDMKZfXPxHc89T6n+pJQf9qymPhInNWTJ+wZ8eR
         YmI5pYxcA/MMwQ5UUb3Xf+5Pm0vMSzQhvT1WB8sF4AWzr+X93g5B6fodRiquEyv1pWoq
         rgzt4zfQBOcbEhLWX3p9gxhAxELgbWQnAQ92eFfJe8CcIQm754q66X1J/3H/C9QpEU2b
         sIlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXA0oqVED0eYYub7/StIhUjetqpQ6KniVHtB3BoK/a4ZUpu7kFDZhycTKMivvjrkSWoDaWY40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0N6/W6ThPVt7QRLM5RvoIILTlzauIx/MJJTCmHw5I6EpmXmo9
	H4ekrUrVdGhQocuOO+dY8YX/Fp6i116TsQAfspc8IfkD9wIF/q+Fd4qd
X-Gm-Gg: AR+sD12CQhnlUaWjOf35ae1RcxsvsXC9+TLoTKFlsj08YJcW+HgcHucauwtNDQgm/lv
	65iGO8ARTy6Jkcdi7i3kUnfNkFc8YfqO9gJWtC/bHscCfifCB2gzp7ucol8Cp+VJ+VKJeY5Bvu+
	lqFEn/aukymx14abjMNuxVPgxhqDa/KnekYpFIgC4q6hDwcST29NgEwmHfLyjJeyTCVvuLVIjaW
	n46b9g0Goj7lcQrHYh86LTNWNs8/cdN40GtD6kJVAGIeeg8+m079RFRmaYC1b5YjANKOn3YCuFS
	fSuGxxnymJEqn3U9Uc5i8A37d7ymNj2S8NrJCLsyiEvbVY4T9+LKzq+gQaJKUPVRhcopAJzsvqg
	XyLVxejJOGrcao0iUeaiInAtt2rSINF+pk3YQvE94ijtLkvYv5ICrG/azf5abCUiM9r8Wl8oaQn
	jyoJ8ofIi2l+oDIrD+CfHJ3F5zHO+alXCILAq/KD35ro0PpaFJO/aB40ANROLKj+j5XykgK9bEe
	b3rpnyDIlpr28zHR0REWckgjaZZSmSgacDpPmFp/LG3oQ6J
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499879426e9mr360090035e9.8.1787002220485;
        Mon, 17 Aug 2026 14:30:20 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-21-27-15.retail.telecomitalia.it. [87.21.27.15])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm107808495e9.8.2026.08.17.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:30:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: phylink: correctly validate returned PCS in phylink_inband_caps
Date: Mon, 17 Aug 2026 23:30:03 +0200
Message-ID: <20260817213009.13924-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In phylink_inband_caps(), the PCS returned by mac_select_pcs is only
checked if NULL but mac_select_pcs can also return an error pointer.

This can cause a kernel panic as phylink_pcs_inband_caps() only checks
if passed PCS is not NULL and directly dereference ops from the phylink_pcs
struct.

Use the IS_ERR_OR_NULL macro to address both case where the returned
PCS can be NULL or an error pointer and prevent a kernel panic.

Cc: stable@vger.kernel.org
Fixes: df874f9e52c3 ("net: phylink: add pcs_inband_caps() method")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e956902fb..3ec3bb439109 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -964,7 +964,7 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 		return 0;
 
 	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
-	if (!pcs)
+	if (IS_ERR_OR_NULL(pcs))
 		return 0;
 
 	return phylink_pcs_inband_caps(pcs, interface);
-- 
2.53.0

