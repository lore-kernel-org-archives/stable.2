Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795248860;
	b=BkToZXYNUFdmeAWafmKTJyFoJCqllC5YB8iNSjyoDGyVcwak8TkAPvYu/7ahKVfgXtWz
	 xgKVHH6La2fQT3QjcUaNjZehnCsczHOpNaf8ktHdZk2JHWSVN7sIGbrQDhfMw5HstzFGY
	 LvQ7aiqD4PXVdmCx5mvF0Qw7+lQ4WDin1HvVd9TzO3UxGMXwzqHmhy2GmLtUsMYkbJW4i
	 pG3Gqy4kC/2XlD7/WOVMpOjvBC3YYJYNxuklouGVsehJSTDdk1LdR8sNdD/DV4kLIDsdy
	 0opPal5oiPaHyKEynBfaB+9ohYQQ2nkl+LRm4eMGA1afSjuxxteOYclAPa4enr43QVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795248860;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G8kM3IXtzBlumi5aSFxeLf8NDbduYmaDZ2j3BGuqdWM=;
	b=yq1CNCcvdAhtqv5ifeibUPrCh66Zy4+AWdGmAS0G7QQaoO6568+altvGB9V1tbnCc2AD
	 AHqAjZOM7EzzSg+0MDdZWxwFsACFHtlqZzsuDpXZEsJH2K+vMGL0lgnaqTRrd7ggWWU+s
	 +/GfxfaWbeuPIGPGH1y3M0FClTB6D9SLxAzuj35PnFPMl7fZ9wzV33j7NwlIHHFnJ3U12
	 xl8dIb7iwjuCic60FKxcAuU4rbFNIS58eVr6whoesKf0SE4JHXV97OAiRiZrpXB3rs70v
	 hoDa3tjBoD6gSfwOWyy8CWhuCKNLzQEbUJW5BtZ9K+uwFcd9Mn4gp7cxmh+EqdhUkzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nbd.name;
	spf=pass smtp.mailfrom=nbd.name;
	dkim=pass header.d=nbd.name header.i=@nbd.name header.a=rsa-sha256 header.s=20160729 header.b=i1Z7SAYu;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBB606A320;
	Sat, 21 Nov 2026 08:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DDBB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=nbd.name header.i=@nbd.name header.a=rsa-sha256 header.s=20160729 header.b=i1Z7SAYu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G8kM3IXtzBlumi5aSFxeLf8NDbduYmaDZ2j3BGuqdWM=; b=i1Z7SAYuObv8aNbiUEG9UYOdnJ
	9sj2/Rl4wxb9fKIKkCnvpB0Y9iHiB/o+iHeemDW/SGxSZvU7O9GkGeOgpOVrufLE8CwMTAeWtL/MQ
	J1uRRpfTi4FN2eFvlsFhWjMphCEnMk2d6Y/Q5XYiO8MCA/P6jJz0FkzjJXbzScc6Mjho=;
Received: from p54a4360c.dip0.t-ipconnect.de ([84.164.54.12] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1xUgEb-006LOx-0N;
	Sat, 21 Nov 2026 09:14:09 +0100
Message-ID: <a89222e1-8795-4c89-907d-38ebeb49e2a9@nbd.name>
Date: Sat, 21 Nov 2026 09:14:08 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mt76: connac: correct rate power limit logic
To: Shiji Yang <yangshiji66@outlook.com>, linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <OSCPR01MB15019FDE88A442FBC74081EAABC782@OSCPR01MB15019.jpnprd01.prod.outlook.com>
 <OSCPR01MB150191A858729F9D98B404F6ABC782@OSCPR01MB15019.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <OSCPR01MB150191A858729F9D98B404F6ABC782@OSCPR01MB15019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.26 05:40, Shiji Yang wrote:
> When mac80211 sets the power to 0, it does not make sense to change
> the tx power to the maximum value. The original purpose should be to
> limit the tx power to not exceed the hardware limit.
> 
> Fixes: 8225816d2974 ("mt76: mt7921: limit txpower according to userlevel power")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
I think in some cases (e.g. on mt792x), hw->conf.power_level is always 
0, so this might cause regressions there.

- Felix
