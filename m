Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF931E833
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771156; cv=none; b=pxxsZPTG7ztzMglNU458XYNlZ0OVuzUCR2BhK0+61xU8llh4g27aqupzyOlyYmVR7alF6FTO53GHHEna2DeuQ+R8FWiAurkqhvM5umayEB1is5Y+q5RD56naWtewHkRxRCYfMhlQw9k+ixW5UoiSjQUqKYxNPDMJ0AeHQnObOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771156; c=relaxed/simple;
	bh=wdR1rT3MAyiu3Ea1dt4T0QwSz8nrbGqxl69q9c/1IZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKlng3uNwVJomdDEi6k/siDnmWGO+W466MfXOUGn/6WQCQso1y00qmNflJwn+lQPcSjg43zEE4+9SglnmYkUDIzkWKlWkD5hUm93z3mJX6Zzli9kBjvqmtepMLIQMexIdEDWr+/vQ5R5fANyEcwuHIUsEaol/7jKLpmjjt59YK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Aptl3T9b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Aptl3T9b"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a7629453so740355e9.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781771152; x=1782375952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OWAZjUn2QY8Ah9cygHd5UGQrkIY9ghZ+KP/7AwdG/lU=;
        b=Aptl3T9bTFoOuu83CfuTSnmeOPXffRrcGWQMEQQ1Yz6fqi9Rp5H/ovYsK/jvl+shEB
         nMVF11BD1oQMUG2OW/OBkS1NiTcOLuX4XuIi4ZkXnvMzOUfSZ5J1/A4n1VZp1C7UavMG
         H6zlmMxlWjwWJDZt6OouqYp+DghIH4RrHgrT63p3RorA6K0TPX9bw17T/KcDG599NVs3
         eD+KZfHXQ4FtF5ml9FaR7BbywPWesoa9juoEF+PTZIUZoEsWJYGHK/c2dzsnJpnUOdBC
         S+CgYYqlDAxdpOzFyarpuuXx1nnG/IidkWMQqAQ1jIULKbxmRDTKNmEUdl7fyH8lgdGS
         n0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771152; x=1782375952;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWAZjUn2QY8Ah9cygHd5UGQrkIY9ghZ+KP/7AwdG/lU=;
        b=f3vYElt22PrwVlBpSOr6uC9jMGz62j5Z9wyFOJMZSRztSXCtkbt02P/yWc8youwfij
         Xvz8KXkQwZ841iQ/bzbg/JT/JvEeS1SnAVrOI4tUhQJSByw515eoF0GEqAPsyynUum3U
         JRJ3Rjl/JUxc8hca3Xtns8eIPYPrUo6TX0kcJhfQTN+PbpsiGdLzXQ6+KBnZrnqv3Mn5
         9j6GKxqTr9cH85XiF5fYUfYnnzEjaJr0s6/moa5DGpji0x9ScgYi5FEaiCY7EINhGpYn
         SD05g34unzmlBAYE+tE6i1DRwaFi5vKLUfJUdbdpoLUFyw0JX2Yyn8Xa2Ta3ORdy2zLj
         r5tg==
X-Forwarded-Encrypted: i=1; AFNElJ+yFflz9zj1EEiQDiej1P0ZY2KpriZp/VidkTAuzgaGXAHWtLc6AQPxt7AiCqmfRgV73E/EArs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GxnpuuiPuwQnsE94/Ca2fxLxHyziGr9iERtmXD0VbOfLePCJ
	/nqLEOYbCHTaXDeOneqON4UCuyH5+XHSALi4cZTI5LhyM4+1bMCJu/Kq21eV+EpOE0Y=
X-Gm-Gg: Acq92OFs+kQVaHdZIZFe5Tppao2EetL4HR1BUIoh1ETZiUZgA/EorHzCDPyopnKm2BU
	NRzuOhnHAYuQNLOyz7I73NCUeB0c34fKWPh6vagjrR392GPC4zr29Yi2csrQOlabxyQudGBm0Gl
	bYKFhhpSOwsVx8ZVjF2gHmBDdvh8UZdD4WgQXD62cEl0MeB9IoMX9l6ktRjSl+JKprijjxFxLDy
	g803ARS6vx8yzSCpKUZJa/nMNCpuLHvXKdR5iiUC71m9MIvj/w8W3i6EwhwIvyL626nLxwww0rD
	5gU/YGb4Ml67r8g2FV8A7Y9dRMp5Y58zXVxIUdAvtJESDiZKqaNmVW8erZzd6c3hz9ZjdSMLtNS
	luuSEPG5gl+rz1EkpL8VRmdRYbpL/qrG4yWn1giy2sZ7lDEDHJy8n4wqy3rnkZ0MQ8oLGPZBxsQ
	A4qBjlePXVpweY06DrSwq1uH+RPLMw0nXt7qPtqQgC9Lf7X0iC31XSe6Z55VzdEIPl8g==
X-Received: by 2002:a05:600c:4fd4:b0:490:e190:38f8 with SMTP id 5b1f17b1804b1-49238261a6fmr19061935e9.5.1781771152048;
        Thu, 18 Jun 2026 01:25:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm210641635e9.0.2026.06.18.01.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:25:51 -0700 (PDT)
Message-ID: <a744f766-8b70-46c5-8548-0259c373aadd@6wind.com>
Date: Thu, 18 Jun 2026 10:25:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns
 for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Xiao Liang <shaw.leon@gmail.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/06/2026 à 09:08, Maoyi Xie a écrit :
> ipip6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
> 
> Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed. sit was the one tunnel type not covered
> by the recent series that added this check to the other changelink()
> handlers.
> 
> Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
> Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tju@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
