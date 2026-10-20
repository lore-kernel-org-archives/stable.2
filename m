Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514577;
	b=wPrLcj8fA8aOjgSqOlAvipxZFtMxXn5tZfxUXLkUA7ze8SjYGKS4CclaNy+UhIJVOo1l
	 QWXigRoNbz8uRxhNZlUmm/Nkcomgv6M4FmJzadJNmPhjSsZ+xU/ReV3XsOr5QXa/ulufY
	 mQycD+b0WmeVBK3ouT2jeUkn7uLKyeEYXOLd40GSgv6GoMPJa8PXrxrZHeyKLe9M+PfBd
	 /RZ0bdDiOgdXcbYoI6qoVq7Rr3Kq5xY3zkyGm4S+85+nGmndDDHk82q60mVKW+WdpoIGo
	 1e1wqdTzOuvb7yFE7TSuod6mJ1hzvyUAJmXhntRu3es2B3DnLryl0PVGy+9VdaZNnJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YbI3E9wpo32mpl8w38bTVPHTLpJsQclRJaeIGMppCCY=;
	b=TucUO2A3DduCq+h1tMuQPWj3fOa6K5YaMhmSKoqZ1MzpaoS5JMA+rdVTuycmveh6Hc5W
	 SxdfFqSzKz8N7W9xTXghevoroJdqVW7uRkmpPPpHwQyuqf7Ad9ZCc0Q4r8wERnwA9EBJ3
	 g+/PS11mPzP/dcCr2x8exFmUl9KG1F0FpY2QaTzWNfVTa5f1Ny5c3OEbTntMUKYQdpTS4
	 XKNV52fn1/t3WYY3uQ6g4IaZ5W5rxzFgNq2wmHu20Vt4MSCVbRzH8I0R3nv+/IbIXThIO
	 c6UX8A7CKfNXNj3ABSDqCqRb/KWAlmNIIQXEIa9kLV2rL8LYbXFxooAThhGIUvylPWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZHlKlrM1;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8B606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZHlKlrM1
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e2957d7eso24966375e9.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792514574; x=1793119374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbI3E9wpo32mpl8w38bTVPHTLpJsQclRJaeIGMppCCY=;
        b=ZHlKlrM1Qj7f9ziupsQLSfI6saYrZDMCs7hnCXMF7RrG+CpaHxCYRC97K23SIVcgg/
         Sdonjvek8squKoyvDGjl4+zAQz46TJHeFr2xnBtrkoT1eDcnHr9pW6hXzcStcniojJxL
         QY0M7C/l3UyIWq7jH5M15Wn5I8IPIuCBmsblxWfWIQo8iSCqimNwa1Th5W+GUrjTChhb
         vh1h2iL1fCyqks/gny7IUw+3qSqVBnc1wuhu7dWgbeiT9x7SJc8qT3XxbW7x+OsxQRl6
         +qAzYrVRyp7Yn7Veh2b6f+hyBZvTk51ren49WJzWPOzCV9PWJvL7x/mGMJR1WMPPLqxr
         I/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514574; x=1793119374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbI3E9wpo32mpl8w38bTVPHTLpJsQclRJaeIGMppCCY=;
        b=NQZb/Pfi3tq/16HAAPknjGw6KAbnPQbZ8Q/qb75iyGK30IpFIRz0Pgr0G+t3YnUhXn
         zOGaoKStYBK735Dusumg/zUOt7EEi92p5XrUMBWDvqKCGLJyk1SWKq9AbZgmrrXbtJIx
         BvgZ99JVycr+jRHSUDDxYwFc2bZ2xdKqcE9IDiza4I0UoPLYvONBAmIXRqVT8ztIhPKL
         9c5QfeuocRCGqU3OkY4zqfEhSsbWvgZ6AurSfNz5o1cu6rNmOVesA/xNSTPNWH3wuDW6
         3r+8abSQiSTPsERohT/qrdkJ8K1y/axA/wXX39sX1HapIsleXJCl85xDP16xs9txoBcl
         BNpA==
X-Forwarded-Encrypted: i=1; AKwUvBxzwTfKBaese8TOxay7BZwenTH64g80hwuVoUXGcpO7NnKcNJ3AEKCAro9bhUafB9eRI04FjTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJL4uVfYtEf/81fCY038rW09cqi5l8Q9vDQ+Q/ygAo4TVeeJfaa
	EX71Kx1d8r8wCINCB6+97vlPnKK+uFfyQFqKdKfHifAb0Oi0p3aLxYxBaH1BhChZ
X-Gm-Gg: AYBFou1+nmgBD/y8pGtJGGH1ALNMz+kBy8FRR28/KdYzawyay58gzh6dsx6cSku+/UJ
	Y7uPIl6oqppAqJgtnqSLG2gOjwSe8WGeS4iKhZXwN4+yPViGZ7SpyeKxUI96jtSm7l7hAYaIWwt
	Lj62jvjENvlgVArch00LCcnnqyB0a24GZf+blGjS7V7JK8u3rm197I3s+yH0UVEt9m9fzsQ6GPa
	dLMHAwK47svM+sGJRHMBuTiaZ06zSigiE5tpwXZlR0gWSlZs9dI67VoLJjq7KG4tzZvRH1AFJV/
	GQ8tOYbDfL3ZohoWYDPrPlhtZCNUhoUJklLwgshYJxf8hlA8zM7XPNvi37CgcbhYtZfx2iYGeo7
	c/hMsFH2OKMSwk6UXM1Qcak5QX2iFCMo7efJ6AbEIDJ8QX5XxE0bar23IHqYtwFB+tXH4sLPxqx
	OD/F0BaeXCQvLR964OZSzCEx583RZU29cYUxc922SzgeCFjm3RFl4jqCG8q4YOZqCb7YizC0DwW
	LOYifKO/Q==
X-Received: by 2002:a05:600c:8b51:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4a1da58073fmr212926695e9.31.1792514574361;
        Tue, 20 Oct 2026 09:42:54 -0700 (PDT)
Received: from foxbook (bfd231.neoplus.adsl.tpnet.pl. [83.28.41.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm244278035e9.4.2026.10.20.09.42.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2026 09:42:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:42:44 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
Message-ID: <20261020184244.69b78d5e.michal.pecio@gmail.com>
In-Reply-To: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 16:33:37 +0200, Nicolai Buchwitz wrote:
> The Siglent SDM4065A-SC, Rigol DP800 and Rigol DS1000Z (and probably
> others) advertise 64-byte bulk endpoints at high speed. USB 2.0 only
> allows 512, which xHCI correctly implements. Unfortunately this breaks
> usbtmc on these devices. Reads stop after the first packet, and longer
> writes also fail or hang the OUT endpoint until a USB reset:
> 
>   usb 1-1.3: config 1 interface 0 altsetting 0 bulk endpoint 0x81 has invalid maxpacket 64
>   usbtmc 1-1.3:1.0: Device sent too small first packet: 8 < 12
>   usbtmc 1-1.3:1.0: Unable to send data, error -110

Fascinating.

But SDM4065A is apparently pretty modern (2025) gear marketed for
"automatic production lines", so it's odd that it has such issues.
Has anyone looked if the same out-of-spec descriptor shows up on
Windows or (don't laught at my optimism) consulted vendor support?

Maybe Windows xHCI driver tries to enable out-of-spec maxpacket?
We could do that too, though IIRC not all controllers are happy,
so a SW workaround may be unavoidable.

And xHCI doesn't support URB_SHORT_NOT_OK, for the record.

> We ran into this in our factory once we switched some test PCs from
> dwc2 based hardware to xHCI based ones. dwc2 uses the advertised 64
> bytes, so the devices worked fine before.
> 
> This series adds a quirk table to usbtmc and moves one packet per URB
> for the devices in it. The DP800 also wants a ZLP after a write that
> ends on a packet boundary. Only read() and write() change, the ioctls
> behave as before. More devices can go into the table as they turn up.
> 
> The Rigols still have one issue I can't work around. They split
> replies over 500 bytes into several transfers, and a follow-on
> transfer that ends exactly on a packet boundary never arrives. Raw
> libusb shows the same, so I guess it's another firmware bug. Should
> be fine for most use cases though.

What exactly is the sequence of URBs you see vs would want to see?

> 
> Tested on a Raspberry Pi CM4S (BCM2711 xHCI) and a CM5 (RP1 xHCI).
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Nicolai Buchwitz (4):
>       usb: usbtmc: handle undersized high-speed bulk IN packets
>       usb: usbtmc: handle undersized high-speed bulk OUT packets
>       usb: usbtmc: add Rigol DP800 and DS1000Z to the packet I/O quirk table
>       usb: usbtmc: send a ZLP after a full last packet in packet I/O mode
> 
>  drivers/usb/class/usbtmc.c | 87 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 11 deletions(-)
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261020-fix-usbtmc-short-packets-1c4e233ae407
> 
> Best regards,
> --  
> Nicolai Buchwitz <nb@tipi-net.de>
> 
