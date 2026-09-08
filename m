Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB852379E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865216; cv=none; b=RUoTqL/Z8Jc8xmXxUHx+bv37jR7eSVLYbf00GIR0ZUkE6AOV7eUTeltzIm1ykTpnc664G0TxzYUsLXAZU9aK7g2hhh9Ic7NPjICmVr6r6VONt8az/LlIZLhrfGzSzw5dmTk7xmgzP3+Zk7r5WLJhxLLIIb+/2I7CyFDUDqxO7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865216; c=relaxed/simple;
	bh=y9Gr4AywwMVYDnuywxdASoBv1xZ0f0lO8p7SQzvuLRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9RnEzj1pTzyFH2+yp7avFCL/+gnzOJkUm2fsERqlaCiWcpYXS4UUUvwGtvOPjU4aZdaRbuuHsr9CffwWmKWZB8iUQVh+w/ZLbnXsX2bC2JfRW9aCV2xaBr6nGwimaJrVOgpTpHMqMl+xkdoExFgmGN5SoqixbWomWx+Lg/P1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCPhik24; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCPhik24"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so383460a91.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865213; x=1789470013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aiaBPjiI7pIKbuKui3KX3gQd9H7z3U0hyAR/GzHBHQo=;
        b=BCPhik24nDLqKBt/0/dtT+P0u4nKKobr1IrYzo2U6OwieMGwIv5cA63b6wz9aZDThG
         hLwApMlQb41Hi9RlheUNIVK6PeTYhH2t0L0pU44jrjK5vU4w1BHaizC4ch/HBsJYE9xf
         zOqokZPX6lCdCEgum1QPBXvojXBMXhlI0veICco0w30CNUt/0jiyny/TLayScTFzRRW5
         lSmemoiBEGIoAilGs+knsfr3vg+/J5+rokqmUzeTEzbpksakjl89eAlIuT7iXdAgxBkI
         sRvDtBjGK4cUPKECyqQ9RSlxyUSUX5+lYEuKQ4Ct7Zt5TfNr72i+xsr0CElSfPyWeXzD
         r8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865213; x=1789470013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiaBPjiI7pIKbuKui3KX3gQd9H7z3U0hyAR/GzHBHQo=;
        b=Ul4yz1LdN3qyYfpU87BEmuxt6pSeat6GdgB2/TRWScbzWUB9I30XTkPzGzyUek6qli
         V7QwS0SxmrRxrthiktV2Ob9OXtNDIox1sRd941DY0FKpRtEsfnoiFr3E+EjWb6jK9BdF
         i6r1FL2RPu9+5woYeUoWPlflPo5a6KkkUmH7y+9nTPapA1CyJK0i0/DkJ+xh1/PzyBEH
         EXpqEd0jpk7wUQJlEuyuIKPX15hN0iRMJYfDICs5q+7HSkHYtKv28HYAHMko8zlAFkJj
         sR9uPaytGcc9tk897ZMT3uD8ab6AzjnGp/1sleJyIh63uNZZVYhoJhB+FMH8q4KsqzdF
         PSZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzon6bVW4rngdhXGiju/b0dCSQVvJfD0ArgCW3EwLInpnlRU87xkX9Ltd2nqhMknuUqveWmyeA=@vger.kernel.org
X-Gm-Message-State: AFuF++kH+nRIcGtibXl5L5j7ZzGnr0pV5vtLCZ+L/5qVPHnC+a60xbc/
	g+Bfz6zGJjoNaUjBcrx5C0J9wb7dgNlgFdhOq6GJGUddUA0VCqBxrVQ=
X-Gm-Gg: AYBFou1K3IdwvGveRedS0ToQy1bPd3aKbZXMSTVLiBNnIplpc2Kh/GCxnCNBHxNCvQC
	1rHLgt6YmSpJ3RQsMCjrVZ8uiUtsxtXHb+yacfsRfqXVogizsPYfhoKIlj6ls+OHp1bTaTAdrwy
	sXlqgO8BxT+ByhLbVPLpDBe5kGTEOtZrsWb+KpOvPPBcjbMH0Z//pRGh5rjazdd5MDSL0AM4uW9
	2xzhm+thkApqOQjWQ11rQbLKm1PpKdlj+poJB1Jp503yXQhmCfk14OmIkSs3q1nuJy0+OCQ8Wfr
	ZAp6ZZtzwcaaKZrpVmpBvSAoeuqEmQC0vqa81vF8QcHGMSkoB60+BmYta6EXp4Y2Ln39YUsaIS+
	E78NfHWrq91F7n62Xaa64Jqi8TR5M8ifrpHGwztrqi1+88dyhAh4iBIvkD87abkiSZUMGQV72+w
	qSpKu1y0Y7g5pu58TS6TogFbcfDkwN8TgLPYIc2dVqYNWrclacUqxysCy3FQ/xrWQm8FrHtbGu9
	S295SmnpDW0GvtA
X-Received: by 2002:a17:90a:f945:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39b8bd31191mr5493595a91.6.1788865213271;
        Tue, 08 Sep 2026 04:00:13 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:11 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	daniel@makrotopia.org,
	o.rempel@pengutronix.de,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/3] net: phy: dp83867: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:57 +0900
Message-ID: <20260908105959.70453-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
bit in the modes mask when a LED node carries the 'active-high'
property. dp83867 was not part of that series.

dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() returns it. A device tree marking
a DP83867 LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
unbound, so phy_attach_direct() falls back to the genphy driver: the PHY
comes up without its DP83867 configuration and loses the RGMII internal
delay setup.

Active high is what the function programs when no polarity mode is
requested at all, so the initial value of polarity already satisfies the
request and only the case label is missing.

Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/net/phy/dp83867.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..61a941aa02d9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1150,6 +1150,9 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			polarity = 0;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			polarity = DP83867_LED_POLARITY(index);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

