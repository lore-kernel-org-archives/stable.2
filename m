Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076117;
	b=0u7hh8MASMZUY53FpdmkPJ4gy2ons86WY6aCc3uyhFoXCCs2dJFBciV/PrHEeYfhSK8a
	 FBrEmYgh2r/4nJh6zmOEBpqV7EVLSADrDDV6b4A9uCbw6EgoMjztdxM/P0qqRwjzYk2cw
	 E5f2Lm+3Bki9auSL7YVUex0mYchUXs9dSR3U1u52gpr+gehSuSZpoacJLfpDqXk6K6Ee+
	 5VldXdmfA8oU1IRgsAffmy25p1upUTdMEKo9OnJD8mW44R2oR1TVE7iUjvyMQgzLNUXLp
	 dgnQNPp5SWNmk3lBznvleYndyxheP+kFQ6pv5p9ZrvNAQNAzm02ss2Z/EGFXyPWO/hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SbD58ugfokxPZmAa+sr28GhjcGo78uQBy/eh0bnkppE=;
	b=D24Xb17Ig4OC+i2562eIcPKHthP68RazLF/CBXgLPrVQdB1JZlNOfibu9zsvvgTFf45D
	 STUwYTWbAElnM3j+wiD6Vxtsh00kh2M8eYxPhr9vzEcT/JmmiST2XmAWq+q/Yu4+6j4xg
	 08zdOLmYgWfaOAU96ygRcAId4DRlfXqxAAGvSqWaH+rDKqRcIVDkz0m6lwEdxGMMpECkw
	 dIYBRKnDmvtSFRGDhbLHZBRkFxNLv40CnOxgC2Twtp2pDNnW7xOJjImiks+1bHHwZ9KBn
	 OMg47cViD6qw/tox1g9PbZQ+yhjZmNJURiDEcOG+Mk7EpDw8bAU3IWIwHlyq+2GUfmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=PQDADLkm;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2560A6F6B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD2560A6F6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=PQDADLkm
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a41f145599so134852f8f.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1795076115; x=1795680915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SbD58ugfokxPZmAa+sr28GhjcGo78uQBy/eh0bnkppE=;
        b=PQDADLkmig1UB0qWSA/TIcTTyx7AJJGYESq4GRUMdjB/1kdiF0oN1HGPu0uelP8Geq
         xiyRIuSQzsvselPCmQy+aeRzgWjdmALrKfqv+U/+66B+kz19UrievEb71WpVFv/KGpop
         bDgk5rg8KztJ1MwBkWmrtKsOsYmpuhP93GAooPSrWLk876SJRpU5ntBkoq8Z63UFpm7n
         C0H6PF7eNDPfPBNkm3sPvT30yX9xJc3hsvoFar05aQstrEkfBXshjSlEBPGV2D1Jiv/L
         Z2zZaCErRkAECTHe9JUCpy+JZzEue+M24D5VZwwcPPnD+hP6EzpMcY3AGzMFe9MgXR3h
         CjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076115; x=1795680915;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SbD58ugfokxPZmAa+sr28GhjcGo78uQBy/eh0bnkppE=;
        b=WwpnAu5YZNqmMHNi7PSjKEJP/oN2SXVai3/m/jAt5BW1edqsZQ/ZZ2tTf70T93hfPw
         JlVODifXz/9jwN/QUkKjsYvMxoJssgPgg9AzGRAwPdBn+SLl9JzzhE8qBrAOcHbOCwYp
         nKUU4PuicLfNf9lQMvr3GaMGxGPJ60KWz/yUeJocoPRdYFf+X1owJJAX16MRvaZq6qvr
         McPHjibpTIb7N1QAB+pD0q81YSj7+NLcQlLU4SLAmMfyfUO8ifD50U82s0Gi18oS4g5l
         sncF2zsAz0z/Xq20K6fIxkC/ZX3d7kQpsOmmgeyFIvV1y0iP/30UDf3+Y2dXhA5RhhnW
         X3qg==
X-Forwarded-Encrypted: i=1; AL+hErH6G6HD0Nc3mMgr+9N3Jtu734949OKFSIa0lZ2brooXGqZt+w8TB9sSdcCLbzJuk9KjRgRHGZg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XBMzU7VQ1jJc7ZRUjvSsObuyu9e7MTFGvQ3CRYYjPmLkNqWFP
	q7vxN5K6ukMFM9DVKWoWmQCCfit8N1TZqygT0+pa0vENtJsqRs2yuSEdeeyuF3Bw5h5YPsut6Vu
	gCkrWGnw=
X-Gm-Gg: AZFdTZdJECzhILFYxLSeuJWUzEpEFO8jIU8SNBZa5hHToXninSWEqgpyLPpp6jL59V/
	VuNusV4aH+FkoY6kTH28A7X9AYc0K4sFyWmPKgwNvE3Fx1Y1W6HY7Zb87+jRQ4IlE7aE8haY57k
	xW2AiSg9SMLSngWRrDBHxsucfsUjX2Tjbsmzrn6B4yXTHSPVhlU54jcxTFpjWbz9lttjfvVJE3P
	OaRQy90m08aKZSd+fb2H1j2J3RAJZvWQ6PcWTLBej+PZnjNAY8N27odU7rDhQkwILmOeTBha3fD
	5wbKeGrp8p+Is3kfPAHnZzCn4q/7sP2JDR9ffqMB2n4wU3gWCRqUCQHX0PuuOTJ92d04xs+XB+r
	fjkTnsRzyhGBtqq07MaV/UN6OYweMlDFbo1Iqct0pQyfVvwo+8+TqfQa7Ll5crkf1BudE9O+Jrq
	opf5DJxsy7oHn3Ozdd/xFtSV5fza5QfOzbPZJy+aDecTpdL5D0RWdRIVWmR7+XmtdNzsu2YHm+l
	wnvPiBYapOsLjLUCIcjBa5dT9CddDrmEegpu87GH/0T44VjTuBgVfeTGeWAb5VkSyYnZAsgfui1
	ZRdrSxa3KHCcjDS6dMZYHu8OERp6cdYsxL8oyPcOMuQ6efXmTQgIAQ9QVvYcgQmQphDhmDf4xID
	oKF9is8ctbL7LILb3dkqRsH3tsZ8=
X-Received: by 2002:a5d:64c8:0:b0:48d:f4e6:7b2 with SMTP id ffacd0b85a97d-4a63aa7f7edmr11571422f8f.3.1795076115084;
        Thu, 19 Nov 2026 00:15:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65100bf42sm8710432f8f.1.2026.11.19.00.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 00:15:14 -0800 (PST)
Message-ID: <5681e42c-f8f6-4993-a8f8-78be39776a86@6wind.com>
Date: Thu, 19 Nov 2026 09:15:13 +0100
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
Subject: Re: [PATCH net v2] net: zero the tail of ha->addr when allocating
 address list entries
To: Henry Martin <bsdhenrymartin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Yuyang Huang <sigefriedhyy@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Daniel Machon <daniel.machon@microchip.com>
References: <20261119040153.158372-1-bsdhenrymartin@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261119040153.158372-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 19/11/2026 à 05:01, Henry Martin a écrit :
> __hw_addr_create() allocates entries with kmalloc() and initializes only
> addr_len bytes of ha->addr.  The dump paths emit each entry using the
> current dev->addr_len, so an entry that was created with a smaller
> addr_len is dumped with uninitialized tail bytes.
> 
> dev->addr_len can grow after the entry was created: tun's TUNSETLINK
> changes a device from ARPHRD_NONE (addr_len 0) to ARPHRD_IP6GRE
> (addr_len 16).  On v7.4-rc3, with 64 entries armed on a down tun device
> and the link type then set to ARPHRD_IP6GRE, RTM_GETMULTICAST returned
> 16 bytes per entry of which 37 were non-zero and 21 started with a
> kernel heap pointer (e.g. 0xffff8188_04857ee0); /proc/net/dev_mcast
> exposed the same bytes.  This discloses stale heap contents to readers
> of those interfaces.
> 
> Allocate with kzalloc(), so the tail is always zeroed and a dump can
> only emit bytes that were written or zeroed at creation.  This also
> makes the explicit ha->sync_cnt = 0 initialization redundant.
> 
> Cc: stable@vger.kernel.org
> Fixes: a748ee242681 ("net: move address list functions to a separate file")
> Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
