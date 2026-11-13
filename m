Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552772;
	b=UHd+iFU8mZRmLdQxcat9U2yLAEQxQnJPpgObgy8K81mi8frPY52D/5X+Ch0wnEggu45B
	 RCRRFOMgiJDBjU6+Kuvvb0GGuBTJ9hNbG/pPwnJdtQYiXElR+fOy2UHwfjxfRXOS3Rggo
	 ScQl5U/sxmTl7sMEYpifq4pjKzdYb/HA5XjY/7ADO4eIAKtczzLFJggHnxwzR9NBk1jrv
	 TPsBioC4UCQhvqnMZbqrWapLp/e+PDVtB8MInHB9HGJNXOQKSqLbmFM7fGVCxbyuXCaB2
	 Z5med8yCj8R4tcwbKDoGk2Gc2zK2FomieK8HmYb+XktkMfDv6uonI0A8xlxNwUBc0kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552772;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=WQW+v9O1HGQ8o2pXDEOIzEzJj5a39LNknvT0vu9u25c=;
	b=rxRFIl2qC6CzbW0eYlDsc87J0kmjxujB/s4LKqjprW7rdixWR6rGUuy1fAP6Vvpzosmc
	 z7kiLU0pXPYy0r5n8OnvjYRDeGxcqN26G+JutJ56GAJGKgrJu8kKHIlK8lb/YSw4jnt9Z
	 3qum0JbGju/vl1agiKFkss+D4q1rlYpCBhD3pPkO6NAdGiLUCpDh3p5/DYdKvcejQhT+t
	 56zWZemWKwoPqCXbCtDS7a4OsOp+TAyZu0EdAderk5yie4po6ky1GU3oQ8pE1moywXGZ6
	 UOBNz2+QUNFW99iYpgx0ELAYc/TvCnjASOURVKumBeXtcRlBvpkzZ/OxdKJ1fpkA61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=uiC+UYed;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737C606A31C;
	Fri, 13 Nov 2026 06:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0737C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=uiC+UYed
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AD6qNC51539959, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794552743; bh=WQW+v9O1HGQ8o2pXDEOIzEzJj5a39LNknvT0vu9u25c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uiC+UYed3+UHZ9JAC9sQ8XWYu9kYOV1QioK9O68nW06t3TJrA1Pl+KwKBqCk51GNR
	 NQqgtnLBww+ItVA4p1Cu6u9cbdcbtGo8S+XGmmP+vklr40CqANIk1W/rX7QlGUT1ML
	 P6xB6CMXSHn/lVK8wC496qR8Nf0RUrmSiono+m8uC1oFQ/fxUN0z8YQKItPADZE7ns
	 sMvhJK2vtdJ65k2q6BU77Z0/n+dA3W6xL39KspLMfoKIgAGELlCiZPoEYFJgAAacQ7
	 FPiuA4LaadvN0+3/ta7L3Z2uTxdZtN/yKGv2OjwdlvDdmifLWlVn4PQhtXHgE5wez4
	 bh9fsYUfT8Ywg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AD6qNC51539959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Nov 2026 14:52:23 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 14:52:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 14:52:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8%9]) with mapi id
 15.02.2562.056; Fri, 13 Nov 2026 14:52:23 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, Ping-Ke Shih
	<pkshih@realtek.com>, "luka.gejak@linux.dev" <luka.gejak@linux.dev>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and
 start failure
Thread-Topic: [PATCH v5 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop
 and start failure
Thread-Index: AQHdcqo3L5nzYrwr1UGT1rk58sg+cbcrixbw
Date: Fri, 13 Nov 2026 06:52:23 +0000
Message-ID: <ee602061ce314b5a9741094b7b93836e@realtek.com>
References: <20261112131401.236433-1-skalpesh942@gmail.com>
 <20261112131401.236433-2-skalpesh942@gmail.com>
In-Reply-To: <20261112131401.236433-2-skalpesh942@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Kalpesh Solanki <skalpesh942@gmail.com> wrote:
>=20
> When mac80211 stops or suspends the device without WoWLAN,
> drv_reconfig_complete() is never invoked with
> IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was in flight
> during this transition, RTW_FLAG_RESTARTING remains set permanently,
> blocking all subsequent firmware recoveries until the module is reloaded.
>=20

In this case, I saw you clear RTW_FLAG_RESTARTING in rtw_ops_stop.
However, the reconfig flow might not have even run at that moment.

How about clearing RTW_FLAG_RESTARTING when driver gets
IEEE80211_RECONFIG_TYPE_SUSPEND?

>=20
> Similarly, if rtw_core_start() fails during drv_start() in a recovery
> restart, local->started remains false. When mac80211 cleans up via
> cfg80211_shutdown_all_interfaces(), drv_stop() returns early without
> calling rtw_ops_stop(), leaving RTW_FLAG_RESTARTING set permanently on
> hardware that failed to recover.
>=20
> Clear RTW_FLAG_RESTARTING in rtw_ops_stop(), as well as in
> rtw_ops_start() when rtw_core_start() returns an error, ensuring the
> driver always exits the restarting state on error or teardown.
>=20
> Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/mac80211.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c
> b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index 5e40cf06a9e..ffd86f08185 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -57,6 +57,8 @@ static int rtw_ops_start(struct ieee80211_hw *hw)
>=20
>         mutex_lock(&rtwdev->mutex);
>         ret =3D rtw_core_start(rtwdev);
> +       if (ret)
> +               clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
>         mutex_unlock(&rtwdev->mutex);
>=20
>         return ret;
> @@ -67,6 +69,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, bool
> suspend)
>         struct rtw_dev *rtwdev =3D hw->priv;
>=20
>         mutex_lock(&rtwdev->mutex);
> +       clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
>         rtw_core_stop(rtwdev);
>         mutex_unlock(&rtwdev->mutex);
>  }
> --
> 2.53.0
>=20

