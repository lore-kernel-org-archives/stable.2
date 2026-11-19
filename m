Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109947;
	b=ku1oyLO3araFIabvnBtF6AhqdadxdnXi+rWrXJfWqw/sQJVOLqEnxRgSVAGRa9vCg2ZH
	 XT+LPDrRQGQz48DVNF5eHqOUh3ng5d8oEltm6GF/MEwjSrb69gfExCdEeDCOCl5yqYE5P
	 EiOm5vmJ9iTS616QQw44dQQVU4S1r5tfVrdwS86uMux5QX7Q42KCb5l0acWBltbedgyOM
	 ambM3+FgvytgE3JyGTtsMJHnNVN4k/lhm8lQddL0mGx/1jYFXvsR6TJX5qdV3CGNCr3X4
	 BCdwGxPOyIXfGLyRoixX3sxabGqIIPflzveQgZ6IYrQT+hiZEDrQbV5Z61/2l4QSijQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109947;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0TILs+L8YUYYLcEOvhAeVCE2W40wEM5uGIGYDCh/BEo=;
	b=BYs+F1+r3kXgRx3FmwSLSVHe1CMUJzIgx9CVO12Jo3o+o+lasozjq/rG6sIeVA5vbX8K
	 1xxEeRn9EWvYwvs3kLx/gDOujgyrUkGIRRUOqdUGZCJ0bDq+5epMwoqoINV9KpIbXe1Gi
	 nbfVhCbB2DXjmfBUBos2gikyzXVCvnp36kDYJeJCA2U7m3a6q87wSvMdyAxEhdCLxoMpa
	 KH0zFV1FA+aNHwcZrDkORCl/9WpDQ2d5alKavG4h3lJU/NNbYowjgVrAwQ0wby3KvAd1U
	 Q5DxlMaLz3+FlUzx7uKI9+uQk3qnDUHscqJDPxHtjyGtiISichpC43wXQqehosIxWIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Fo1dsEKx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3FIcCDve;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9610606A320;
	Thu, 19 Nov 2026 17:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9610606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Fo1dsEKx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3FIcCDve
ARC-Seal: i=1; a=rsa-sha256; t=1795109932; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gMPqudQQdhVll4Y8efJK43woPkD8c0z+wK8cSxZklb0ve9XzaNqt7y2aah4IuumAmG
    BlDpMkiFuJCvtKe1rAyQo6JmMRP3bXBwNYWWuQjerkrUrcTHYfLrwwKXzU5VZZJGtgDL
    cPnczmx+oB31pdSr4tz8WhvVqxxza0MMVWAPeo+u8xsr3LvAjIFtc1jMzgohODaWC/sw
    wdB4K98Y7bqkWFK2ORAvwJIp40vWOzK5EzRcKUlP62YarkTYIyjmY3l+PSLvVZgjDRWK
    RGMB0YS2Aq7mTSK8NKFtAAa7C9R5dIZxR0sE7jXt/iWMlQfe8UweJi2w7WCQIGyYHi8f
    rEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795109932;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0TILs+L8YUYYLcEOvhAeVCE2W40wEM5uGIGYDCh/BEo=;
    b=lwmci6thl1paR2qZsO2EDNIEpZ9QJCMRhtoSLHV61LdGJFkCcwp9N8Bi2Dv1u4DOWY
    f9FpLe/Nu3X/zysvr/1/1jxYNU4ivVTNSpnha21RiPyU5TXSbBYtTMVidxBA5++OyyKS
    DSXzlqwQISqlawhJ2pYM2aYgfPTJ18MtoxKfTOo+vdV0l0gdHySylGT0uxl9sQxtUqry
    zX4+VNv7UPRdBPmel8OIv9xyP5C89oU8qA3tKDu/Uz4GEdVdIpUG5tuqLmC+XdJIZsNF
    cLuJuOEkHifZSaCMDZ7ssNi77aNtrXWBylJjJsVqAM8HpG/9TmplZLHFKYuF2ZKgijue
    Bt8w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795109932;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0TILs+L8YUYYLcEOvhAeVCE2W40wEM5uGIGYDCh/BEo=;
    b=Fo1dsEKxjT7bm+WVTWhI/F1XiNxMnfbXM/guhkbTzCtkIircCY8GEJipEPnUhzxFWm
    Qdtdgnlv0GwguD9uQ3DfkVkxB4PI6FmfFih8DaiA/949531pIn+m6Qh/VnZVQ/8J7BoT
    4gvzLruIQM1lFp83ue0inQRHLyqW/ruT6+568vKsjdh3l2vTYxwcLpEY5Xs8ZaNYLygX
    hMAeG6ULTIovn6NyvVQR9lDgmm2b326p1gxvZgYCCF47YQNn6E1Pgwo1gXndBt/jkRug
    LLmppujw6wmp5VJfz68b/5BkaCs8jNaW30NaoPJOkdBpd2KVEaKMcrA5UbCqvWOpd/gY
    /57A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795109932;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0TILs+L8YUYYLcEOvhAeVCE2W40wEM5uGIGYDCh/BEo=;
    b=3FIcCDve7E31bFENqx1TkJDqQ6UjM9FM/HvjOydRBEp7Lor7q4Qj2Tizsu6PyHZGx8
    KHVp7SyeYxM4ECBAJmBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJHcpMxe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 18:38:51 +0100 (CET)
Message-ID: <cc743574-09da-4bbf-af2f-7fa670c02fbb@hartkopp.net>
Date: Thu, 19 Nov 2026 18:38:51 +0100
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
Subject: Re: [PATCH net 06/11] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de
References: <20261117220818.1142581-7-mkl@pengutronix.de>
 <179504035916.3136.12986898667697830880@kernel.org>
 <ef111405-f753-4a99-b56f-881aaa177339@hartkopp.net>
Content-Language: en-US
In-Reply-To: <ef111405-f753-4a99-b56f-881aaa177339@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.11.26 08:53, Oliver Hartkopp wrote:
> On 18.11.26 23:19, netdev-bot+sashiko@kernel.org wrote:

> To also cover invalid consecutive frames
> I will send a separate patch, which moves the length checks in front
> of hrtimer_cancel(), as suggested.

As we missed the net-PR for -rc4 I'll re-spin this patch to address the 
open Sashiko remarks.

pw-bot: cr

