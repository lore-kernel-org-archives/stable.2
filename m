Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F2264D9;
	Thu,  8 Oct 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791420482; cv=none; b=O/3Ls0yUTBFQcGb5WDHv9Kmhrd2OPhljdzr7ze5pJgAGohpA+9lFPTOYjl713s984Nf+RxUPbO87LhKsZ6YJhhCQpuPuRDgkRoP6v5zHhDSaqVKmN/514GsWPGW2moYlDjPweigDpin778pifxoZZK03HJdQxSU9w67UlAWeNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791420482; c=relaxed/simple;
	bh=3qecFCTNOtMF/6J6b9IogFOPnuThkUfV0zbWRshIEYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie6RvZJv0AASFT2CVrV+z8jRocohUfAHBIohV4JAUL2gSlIr+e08LWx4T4S6XQV/zUmY9gIpdJ/TNYGWKhkonOW3oQCEEQBIVWB+oJWM9r+mS6T1503nPa3jdEOgCeu9zSyLZ7IirKaOF1k5X3LIr9dRb61fm8wP4TfsMyCfgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pTM1AwZN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pTM1AwZN"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6980lfRwB053744, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791420461; bh=iH0ImTPLWRVowfA8e0nCPafktKF6MvkpYnllTerShB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pTM1AwZNVvZ7qr7Tc+fP25uiyRFoBILOAngo+BGKbwdrqqzWbX6zX/JvKPaRcz0+B
	 wmKcxxAIOPc1EP26+yM8Z4FZAOtGZP4lZC138VzsXgOyHTeOSpIKnVgfq0MGcxYKxo
	 LP78wQ2zr1Lo7MrqNnE8FoS731qonTsNTWXG2RYKtCP970wCtwPFPj8eSVtXaww599
	 cPWBtlG6MyxrHdddNu+VQ69xjmMoQQ4HPIgHdgbHcToX0DIfp98WHs5EIT8aBvGZN7
	 CYNGOUb97LkhbFEyaZpKrm2zpUmkOi5DJrOhYpqtk5ymJE2YXa3egedT6QRK78WFNS
	 T8KhycqGxROLQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6980lfRwB053744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 08:47:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:47:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:47:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 8 Oct 2026 08:47:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>, Timlee
	<timlee@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>
Subject: RE: [PATCH wireless v2 1/2] wifi: rtw89: fix IE length passed to
 cfg80211_find_ie() in 6 GHz probe
Thread-Topic: [PATCH wireless v2 1/2] wifi: rtw89: fix IE length passed to
 cfg80211_find_ie() in 6 GHz probe
Thread-Index: AQHdVndZILhA+Kbh2E6eJpKr5vPk4bbyz9rw
Date: Thu, 8 Oct 2026 00:47:41 +0000
Message-ID: <f9336ee25ea04f418f63700f2e1a090a@realtek.com>
References: <20261007161721.261452-1-tristmd@gmail.com>
 <20261007161721.261452-2-tristmd@gmail.com>
In-Reply-To: <20261007161721.261452-2-tristmd@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Tristan Madani <tristmd@gmail.com> wrote:
> @@ -2582,7 +2583,10 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct=
 rtw89_dev *rtwdev,
>                 return;
>         }
>=20
> -       ssid_ie =3D cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
> +       if (skb->len < hdr_len)
> +               return;
> +
> +       ssid_ie =3D cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len - hdr_l=
en);
>=20
>         list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
>                 if (ether_addr_equal(info->bssid, mgmt->bssid)) {

The use of cfg80211_find_ie() was removed by [1].
Please use https://github.com/pkshih/rtw.git as codebase.

[1] https://lore.kernel.org/all/20260909070004.35353-5-pkshih@realtek.com/


