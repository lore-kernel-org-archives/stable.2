Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855103;
	b=NVXtn/BYrUHqHg+UDn6q4FdZ143LyziXE+xECFe4LKDtKVl+sLhJNMgVRQXO8R1oc7yd
	 e+YRHFkjlJEBO0aH5u+U7Rsji/OE8cUCcwjuXojfluiSV833RxqCIvo33oYwT+mcAtV7R
	 3/pYWpSDlFsZVf6wf6IPdXh8hVYzI0KKconYsuV1TgEH9l5kIYtXo8S8dEv2TdJUNIDz/
	 +xKVEfOIKKZzaknVb2jrXbgFlI5uucOqe5sfNX+aGlXZkBCR2ees/N9zu2H7TysO9+gmz
	 /5lnxphquySHChLZwt77b0cWeRfdogPjHlR9VcmprQSt910cvMair0nvrXxE56FdvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855103;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=AG7lrMTMdTpXJhWWHRqMPbdBjQM52sNir2Uelum3Q8s=;
	b=liXqNGW1JA7TdCsLHrKfOqyctxM1RN6F7IMXaqYpCbiJ0JvXw6BGSNcUDbpHDOHzAAPb
	 wHWV/tkO3h7yMVDEifJx6FL1lLhQUkuSwfnJ/GIeT7NZT1ajWNxO6L8INOavPMtRNDKOP
	 HbpmxFHTFMDKD9I38hfsusPy0kQo7HIz96wv4lmrXC8Wy7xnana19T871gnL/uxdysmTY
	 UIn7nQ8vphueUAHSqRYlfCoT/VyoShPitKU3FSgaynAQ6Si/46k2zbNu+H58IPdITRU5b
	 NyB5MerG/PdizIFjdqQR0Pw+kRQQqnoLg8Z6BT5M+IiH4jVjFx2gXwpGZJ+Vd/Fj5Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Zsp22sJH;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB262606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB262606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Zsp22sJH
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1571356a12.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855102; x=1795459902;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AG7lrMTMdTpXJhWWHRqMPbdBjQM52sNir2Uelum3Q8s=;
        b=hM1JoIK2T15yd6kmTJ3mI4FshsBuh/dHYebq56v0dToN/1kvEGxqI8KIHTL8+PR4/Y
         mKO3y2D31Cy7G7XosF5Xoc1iTNbv1ZCjyNfN6RLPqo4p8xtA0iRCBnzXdMAagD2tckxR
         VXEM77kx/0vPwlmUolhU1rvwYyjQX6wXEUq03wFpzNbhAHw2C97AyJCkxmZVbYIJP5AD
         P4QKfA/4msfRbeHgZ63OO+gFrFBDOjsI3GMlDcxdaHq55i1ZpGOF1/BGqlW2ehCvOKuD
         NlBff/G+wf2BqqN2t6TAfnYUzQlfPVTJF6BKuympyLKfgSwgUK2yivDA97z5hBDNH0i1
         +tFw==
X-Forwarded-Encrypted: i=1; AL+hErHM+dk81SYWDghz7O5sq1+sXB7QE6gQFvwhIYwN2e6/urrDxMU4gDK3TbzN1xj+2z4yvQkRMws=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j+0/g2hTYBVOpcmB3ZrL0203Tgmw0tUsZphyIREGwR1AbNGE+
	wwlZxkY06ijtlPPAY2xbw/sHqfRIiiQQbCGHwjDPeREd4PNDfSgDMeUiKbBBLkVhe/dR5GqgTWT
	PssLrQX03CunsYqwyscgGV80AiMWU7lCI0PGOyPczwNEulD5CeQCrnEA/m6MewoCHjFRATj2oti
	AUd1VUAt0FdKNGuR4qmUOQKCTONqKf9R9flTzUN02kjIR45TNRMXCboKWIN9kLEtoMNCvZVoOv1
	xBT/FCZCbvRFMTU
X-Gm-Gg: AZFdTZfzO3349NG/gwC0jemBYrtcK6ZpItOXFSd2a+ttJAU8c5BfE4tIlhMitoUAwfi
	e1lXVVpiatB+q1XiG6W4bTOsSk2+dHHqeJCo6XLtVte7gOnWF3PHbIcgeb4EwDxteUGTl/ygXxy
	fA2X88bFHYlCP6X63yGlJLp/hluRQElSiZiNmSs/+T8IhHNgeQ2OuXS91uWhVyobRNAht9Auk/v
	/2IiBzv9GihSspbo9JdNyFEiZjYwGOLX8KcSLT3DfxwlCenvABSdG8VAWaSuua0L2B0eKJ9eisX
	AMRYEDto1gyBB21x8pY3d24L0teddmH+EmLmOPLkmH1GZ02b1+LandLcWkIUxrvwkJO4J3+w1TB
	TC6bAMO8o7Jqvl2hrHBIbjDYtxTVr8NB9sDCZPu095FGGdggYRZnOMOEn6Z2PJ/uWmpD7rbhSgz
	liGURev27TC5aeSdYA3//8OzraEPIn3pUx+uWP8dpD/LI=
X-Received: by 2002:a17:90b:52c5:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b1b0b5d61cmr11851768a91.51.1794855101803;
        Mon, 16 Nov 2026 10:51:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b2654977sm4835642a91.1.2026.11.16.10.51.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 10:51:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91e8badc80fso52729526d6.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794855100; x=1795459900; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AG7lrMTMdTpXJhWWHRqMPbdBjQM52sNir2Uelum3Q8s=;
        b=Zsp22sJH/vM6ZhuPtP1WiBHF8Oa5HKrOqSq8731aOZiQWwRZioeb83XYMhTo7CQ2vR
         4qFJy9ZRRyXeTaORJ4kSyKVZdjzyIdrIhUoinuirgT4kpmrKJ3ZBVSJxwOCZ7k9R3kzX
         RwxkGRdjMLN/mBs5AJkAdfXKUUcTGo4v9F/ts=
X-Forwarded-Encrypted: i=1; AL+hErFHJorCy55xttmMjsjckWdHLY1mrjPAnkrpcEuikogwFoh1mch/AdaAVQWb/IitxnNvBUyEjJc=@vger.kernel.org
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id af79cd13be357-9494bd2cae9mr1794631785a.81.1794855100586;
        Mon, 16 Nov 2026 10:51:40 -0800 (PST)
X-Received: by 2002:a05:620a:7082:b0:93f:3219:835f with SMTP id af79cd13be357-9494bd2cae9mr1794628685a.81.1794855100164;
        Mon, 16 Nov 2026 10:51:40 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm905381685a.18.2026.11.16.10.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 10:51:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 10:52:57 -0800
Message-Id: <DMWV25PKBWPA.O0T67JFNRN9W@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: <dri-devel@lists.freedesktop.org>,
 <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
 <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
 <CABQX2QNoumTwtyYwPSGJ+jCfcFgfMue9ESNH+ch7_GmU_JT57w@mail.gmail.com>
In-Reply-To: <CABQX2QNoumTwtyYwPSGJ+jCfcFgfMue9ESNH+ch7_GmU_JT57w@mail.gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Aah, I see, thanks.

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

