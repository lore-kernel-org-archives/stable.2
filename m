Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCB49158B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588527; cv=none; b=mv4Us5M1vtZewyXYYvT/ZCN9/8y/kc65m4c4wXOomOjLMs7cIe0K7G5ZeGlYbIuoah65jjBhgMpY60+8abe98+H5V8UIwPJBbVj6q+qxtyZlr9asIuNoud4zVz9q9IOm3Q+ZO50ucGEtkyZ5PUOyy4OuZFFzq3ak7pD185oBvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588527; c=relaxed/simple;
	bh=h0g2cSklYj+E8R4yu0B0K9XX41R3rWf4QX9cI+EMJpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI+loh+QhHEYCXTQ3AbCHFmdqPaPfU4kvZABmN8u/jGvwHk5q7SYnruPhGqzwnyKttPdhQDdRErOo9NaIKnkVZLIo3OCMeA1nAWivlvgqi5xcC16lSG0+0GghkHp9VijcmB95sBUXQ+QreiurK6DBIhkQcEqr3GSh2/6JdoNTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSCzZJ8I; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSCzZJ8I"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so1530125e9.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790588523; x=1791193323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jK0+4urBdoRm24BPDR63lzQtxeAkYMsHmBmlA17MxT8=;
        b=TSCzZJ8ItIRInkzo6x6UAZw1KeCgliKJQXRJfHjwSb9Tdx3+QQmdUflLjEDQpXALRf
         OGpnh0S9EqgXiMhbsICR+K7ZpZ0tJavqaGuaonmCn7IzrjyykwkuavU45fpTIRFqgq8U
         P4RlNzUJYmOVeZmn5IF6Nd9kSWWkHKQ4NaUUjdifWugqHgcLwCSkdMtKwvBV/JloaS7W
         gRkexk5yaVN+6ZM+bw8pauFSfr0qvfVpdX3BtREN8JmGUtfajaf+irhi3MQS+ovMRZ6z
         d538oF1vx3xi/Vy3nAv2NhQkiehFvGa5KBNfAzL3Yq+a/gPfv3ucdL8rb8C5zI8MNeaw
         FtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588523; x=1791193323;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jK0+4urBdoRm24BPDR63lzQtxeAkYMsHmBmlA17MxT8=;
        b=ihvLEl0E1qKGXbsQd/EyB0mSek2ZSbYtYuhLKIFxBK9pmdKsaNRNOAXSBT11i5dZDR
         GnfUh5A5AQzKYSrOxXOT41QyHeWXdLgE1wwwUrf2YaN8Aje2kZCMOW4IFCSV8bUd32hL
         VIg9tkmdyM0wzq/HorqNE3VNPzJzit7mBbTpNG75XM7E7c3dXw+RlbaywFbJ7tuT/Omx
         0TEKtUrwD23NFsDXFiQYWiy5Cy7bAr2ZIeYTnJ2JB7Tk579s1W0/v4/z+hIqOnQNwqGu
         ReeAKA1R6Hw97nqUydxqI4o/ZRsJT/x0OL+me0a3nsy9xZBCX+eCogpg8oz4yOoKBaaI
         ylUA==
X-Forwarded-Encrypted: i=1; AKwUvBzi1GKVkAaSofa+rgvRL0U5SyA57e069zryJ1u89ryAbneKrOGixpzY+ZVxPesaYjXzTILvj3c=@vger.kernel.org
X-Gm-Message-State: AFuF++meoMVgrhUfc8W1eGacMAd8kKuVRTgL0bRpe/bdVTlHCNVBMcWC
	7fajqJAl0HZVCTmj2z+xPyZ3BXhhIhj65LwpAoJAF2mv93qaC2vwdLct
X-Gm-Gg: AYBFou170gCWd+fC95RIgNPhv0e4i8v52gsz02/NIt0Y/Fq8VHQh1qydqzOEaaXpB4T
	PExMAIi6l3fE76FXO60vYKsyEo8gWaTc7Fo+vgqRQWXAU12Z6bMSsK+5ikpW23rojY1oXGL7pMB
	OGUf0eEfcQge+gvqg3fVqlQfSAvK02x5l3r5Ya0F0e6zlDeUh0+lIoF+a1UN1K8F27B1eP35uwb
	5SYX6SbmSw+j7HkNGbT1ixIZaqVnFvRZVI/nzRIzTVkSXNn372X0XTAO6p3vo9RUR0UvRZ1YK2u
	2Lo1Bmbz2et+yk1uq01Syf8DgZH+OGfvI79tx0fVclF3o3FCJjo4OYBdNS88hc7jtXnBrnq2lSs
	Fzg+tR/9vxWLd9B76uoWEUKm9pomxZnftVa/tCCvTGu85QvQmm8hZitRmhsXYlGcVNscwJm3llH
	uF11+2enq1/RWv3arTJ+LcU4L/JCpeflX+P6v6jD6KWCGg/y3xsd9JwhPIAhwPnveQWUkDO9RZe
	Ohc8YsLHGexRTA1KAOazdKfhRGU27Vy7nOHtlqtmmGbjh5GUfZ5LCi2myquHIHNoXSWWNEJJ/if
	YuSPEg1ujPLGb7VHv67teOgYI/4ux0y91Gne+rKwKYsn2vdBQcoEaBdJPfJDhVaMyTRIDfBhK/W
	ut+JqKr+kCLhfqt7dRg==
X-Received: by 2002:a05:600c:548e:b0:49c:f9b8:bae0 with SMTP id 5b1f17b1804b1-49fede023d8mr167183535e9.2.1790588523350;
        Mon, 28 Sep 2026 02:42:03 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5d04:affc:2501:4248:c28:faa9? (dynamic-2a02-3100-5d04-affc-2501-4248-0c28-faa9.310.pool.telefonica.de. [2a02:3100:5d04:affc:2501:4248:c28:faa9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm37984144f8f.8.2026.09.28.02.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:42:02 -0700 (PDT)
Message-ID: <52f4d7a6-6bbe-41fb-863c-5c71644e20d4@gmail.com>
Date: Mon, 28 Sep 2026 11:42:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
 <20260925082954.MYDugnDU@linutronix.de>
 <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>
 <20260928063824.0E3LO1vu@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260928063824.0E3LO1vu@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> So veth. The test suite is using veth I don't remember that it was (is)
> a problem there. But then there is no TCP.
> Wouldn't it be also a problem if you attach veth interface to a bridge
> and that large TCP skb would have to leave the bridge via a physical
> port?

When a bridge forwards a GSO skb from veth to a physical port, the
outgoing TX path handles segmentation. validate_xmit_skb() checks
whether software segmentation is needed. The networking core performs
software segmentation as needed and can use hardware segmentation
offload when available for that skb.

The software HSR/PRP path needs to split the GSO skb earlier. Each
segment needs its own sequence number and HSR tag or PRP trailer.
We add these before calling dev_queue_xmit() on the lower device.
The normal TX segmentation code cannot create these per-frame
HSR/PRP fields for us.

TCP is the case I reproduced, but this is not limited to TCP. UDP
GSO skbs can also pass through veth without being segmented.
Passing normal PROFINET RT or GOOSE frames through veth does not
make them GSO skbs. Patch 3 skips segmentation for these frames.
They still follow the normal HSR/PRP forwarding path.

> This does not sound like it is limited to hsr. I think it deserves a
> helper similar to skb_linearize().

Patch 3 already uses the common __skb_gso_segment() helper, then
passes each segment through normal HSR/PRP forwarding. Do you mean
a new common wrapper around this helper?

-- 
Xin
