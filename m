Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819872;
	b=b3SchAc3kFefSM/VA5xUwypZlPMiSCYP7TpsMEtGr07bDz+qXoaELP0e1pjQZ2UdZsXW
	 hqHyZRySj5lRlUl+mcmpb0RP7BEa6mANP0agYi+HeG29k4xy2Hvy2AeKibo6xZof989uO
	 itLDt4gOSgDZzo7bBY9JhaxWOPRAdbC/8pva7zhjSb00MFte6h0/5uxenPJVnAUeCKb6Y
	 2RQVdNb5uYiBwux2M3IxMmVEnHoyTJ1Gkxa9V3x9zS3c9AKF6606yY0aXCA70suLn1GS5
	 dsFtZPqWXR9StbkZk6zf5upukGZI1u+mJC5jV4O2wTnyy9TDwRjFFNpuUFXTJScwiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WyPsK1iObrDROZAGJ0P1ZBjLWJj9SOCV8oqzrE6Bv9Y=;
	b=fenO73eAl1Zvte4+Fc2CfBrtswfIlUEkjLhErYtgFe5ETT+tor4e3egaojog6kpJaBbD
	 tM4GQcHyWo/izin13bXpZcPPoYOTNEYUQ96OSEFk5DUR76XzzOZIPObSC0bSC/ryKyOTo
	 jCO72W8rO+Gz32rveoND4L7EbFY9/KGjOFCBC48zlEu05Bj3PmHyd/uRxLiUdIbvWurN4
	 m0mJKMHBi37hGDyKMm6Ren17cNcOAKgPi86qlBrk/b7haA4qRgZa6MFnj+HxSgYRyJkUh
	 4BkltmscRbPSmb0SonVY6RGp3VQGNu+PNNDVcAQ3veaAmJP/7F1LjDWcLZTSOEazEHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=XHJL8met;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB11606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=XHJL8met
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb76bb36c7so96235e9.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794819870; x=1795424670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WyPsK1iObrDROZAGJ0P1ZBjLWJj9SOCV8oqzrE6Bv9Y=;
        b=XHJL8metE6vh0GlQjKnJHCFZZ9z6Lxjc+BBbYYp5w7ESej30ltDmvr2FydmuA+ZvRu
         s559RPBEhiNjyJP0RbryivsvgdcKgUi6FT1NFwTrynpqvHnnnAbK9NaaNVqEIdwAXE39
         4yI/bQhxd1IrUU9PHK81XwOyLpz1jSJARFnxnxla9NlrCTM/W0bTUxQOktLuugi4HIJQ
         RPT0cz7fq4K/4FGEHS3zWZdi2j5MvAZ5wdTo6/lP+qNLY7BvH8mj+ipVKXw+VsYpAXyM
         OMdMWrMCQbcR1tGx0GCVoSYm7RCrx3k4Cf0C/k8chEx12ZJic6P9bhXmJI0jCQPCNN/m
         r6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794819870; x=1795424670;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WyPsK1iObrDROZAGJ0P1ZBjLWJj9SOCV8oqzrE6Bv9Y=;
        b=fKqxZLKBXB7lRRUreEPIahnBfdIksgqUo5K4eMYPMnYByNRJpMekqktI1DLsZm9PYA
         fLAC47MPEq8b2nzXhp+d+mO+5r/0PWY923NqtSiHqfi93elAoL1bveCW0hJ1/yKbvsfg
         0b8Af5MhlK6hkd/9XOzXXpsrlUl/Yy2fzlyp1nXEYL8Annus5mUG0XxxvoYkbVxVXIpo
         SWD/jElQdLHYKt+H1qprBKN1Y1xvtRjuCelxvlL/Y8sf8kj5g0ZT8kOl6rfvO5pwWcj4
         2PTvL2REAhPxMYhVtUE4O+cv5hFUrwWhkhD3LdbUFT2vcsAoSJRZ+yXbNbSYIfbf+Srj
         8p2g==
X-Forwarded-Encrypted: i=1; AL+hErG5DVNgzvyNMVAn6Ec0XEIZF2ibdRhVOy7M6Oa6M+B5mZ1+qKY/KjqTKn1i8vzDmdveRjWHYnc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/end8vWkab9N+7RQJUTnRn8PvyAQPVlT/CEpsfeZrrpJdM6cAG
	oARA1iwQYh6QI1ENOXmlaVLVQMg8vv0gG4lZS1kQHittlz/BliGchpn6TX9t9mpSwXM=
X-Gm-Gg: AYBFou3yc7Q0vuueubytMi3CVS1jZBIqwE07ji4TADE1OIdAjPKBOfZRjwefhnHZGDq
	NwVXDgwpT434DBxEhVgFIWJ+6L9dljwiateWjzwYw0bMOe2W+GcfDIDzC4D48nlLKuTPxsyrq0y
	WsffvKKz0EugEt+7MaEU/NHqtAjnfdclbVWgKad4POuiVaE0TTSo9OiYD3wpSSS+3KBvywOdRgU
	ldwfhZvoyqO02X/q3QclzFbA53LFkyVQIc20B4Y8zCH3rAWsNxlPjZwAwkpxQzG8yleH+E3Xgo5
	pl1roTSQKXkMxfPtenKovgVX/AUTjKxtB/Xf0cfEygpGAEkukbt3Ya5LZq1S9w+2vGZDzagEIat
	d/ake+mzMBPExJu4DJO3fZFWfzcQzbHc1koFvUZcSZrFAdlQTgTHu3UiUTZhf0bbbLleq0lpZFO
	WvAUY4ycY4NFpA/Uu3L4ojdCdw3vMUEPE6tweYdaVmhpozs3GItq9qcb2nTd1nheMYSCtpbIEqa
	jzi5b2H+zU1+B+09MjpC4BHT0pVtO7hPYoGkkcg+dCy0nxDOgcjnpp3Vq7WmZVYrJrk3VkbwoY/
	f1DwpD9gqqq986o+ZBOo+tsZBQKBfl/xY9OowP6hTVDVgievVo1HxNDWEYwhe3mHQgJ8HSRAKpo
	Ykf4ZbA==
X-Received: by 2002:a05:600c:6c4e:b0:4bb:68ed:a356 with SMTP id 5b1f17b1804b1-4bb68eda491mr65161595e9.1.1794819869714;
        Mon, 16 Nov 2026 01:04:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c81a63b1csm20157980f8f.4.2026.11.16.01.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 01:04:29 -0800 (PST)
Message-ID: <e45eaa64-08e6-4ad4-845e-f844150f3542@6wind.com>
Date: Mon, 16 Nov 2026 10:04:28 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net: fix uninitialized heap leak in multicast address
 dumps
To: Henry Martin <bsdhenrymartin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Yuyang Huang <sigefriedhyy@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 16/11/2026 à 03:40, Henry Martin a écrit :
> __hw_addr_create() allocates entries with kmalloc() and initializes
> only addr_len bytes of ha->addr. Dump paths emit entries using the
> current dev->addr_len, which can grow after the entry was created:
> tun's TUNSETLINK changes a device from ARPHRD_NONE (addr_len 0) to
> ARPHRD_IP6GRE (addr_len 16). Both the RTM_GETMULTICAST dump and
> /proc/net/dev_mcast then emit up to 16 bytes of never-written slab
> memory per entry.
> 
> This discloses leftover kernel heap contents to anyone reading those
> interfaces.
> 
> Zero the tail of ha->addr at creation time, so dumps can only emit
> initialized bytes.
> 
> Cc: stable@vger.kernel.org
> Fixes: a748ee242681 ("net: move address list functions to a separate file")
> Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
