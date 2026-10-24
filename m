Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873437;
	b=Q0A4sIQxsJuf0rET82Rihtignoty1dGLCBvrtjXtVW7O3YI9EbiirgfDCPuYTlkj/f9R
	 FJKMMkchMYw5uT/3qzb9XpfqPJVbmzSMyoDO1E37P8VdJa8D9A2/vTmmjat7pRndzoaA7
	 r6xszm8lMVVnMziNdcqTciStGI+QUGVMrXDQ6/N+DXDDK9EUobHYkmoZ0S60Havxv+gmP
	 W8vHgDS4AHaqzALYairFkPxuWwvmIzU0DJNMjKXGl5lOsat3RJ3MuPuyXle4Pppp8TY2/
	 S35NfZvlsMNz8+m8yo9lAkdyOpcJ8EAU2i83ENanUU3e9Nq4/uPcGW6GUcv5HVHkb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u6nBBrzH+5QZg/x9FmxPN7BmlpA5oRt3HSD2i+J03io=;
	b=4suEP6AfEFGZ10HVB887dmMYB4ZfPV4981BxkZwHcxMVrssugeFqKcEx4LrXjPR/ycHw
	 BcjTUzbRfVh6M4RI8mnC98TXb2Nnjgjs8ge6F+hIkA1iqAfo9V4FAWu/f6hrYpdCg2GZA
	 jx8aVn5+yWLAXcpB+lBSmUb3y9fkL3U+f/BwZUpZY8WegAeJOjRS9yUQKYZ930mxOx6pO
	 lyzK39xvXs6jGdbgdambK9wa6uR+sGy+ymTCwqePqXNKoLtcshdXCdRiWNvOSRf7T4hKd
	 fqLupgvss+JXahq2vFaSxPzEwy4Uv7ypJdYmx+VI34agrjxR79IgTqnFjsUx4cXDGvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+3YcT2G;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E5606A31F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727E5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+3YcT2G
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so2381605e9.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873436; x=1793478236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6nBBrzH+5QZg/x9FmxPN7BmlpA5oRt3HSD2i+J03io=;
        b=J+3YcT2G0CMbs2UizMx+Tftg1P/7M0ifAtvD9x77/zjipLjxJiNTRt9dPn1mH9W2rX
         BbAM5jOyP2de8EE4Lc7Y4l2giU8Rk3NG5w7AlY9V7GGmrT3RhP/g/xVRUhNFibxY37fA
         pkmUpKFmrUDpBJAi/9q3G5aeKlrxMY1AZ7+tg4mR9EmF3y46Ihs0nnLpsf2q44C1FrPp
         kZ9zRhD9zl6MnHqDTFW+P+3sHbwqDcSQVc7HUQDkWnVpZT+59Y/nkFVp/7SUREustatY
         ngLlnHetj9LXJrqacKwsgvZXisETavzqVjIBVbKWTLGxtT5rAdqOl0WJJmt4XvrNMVaS
         XvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873436; x=1793478236;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6nBBrzH+5QZg/x9FmxPN7BmlpA5oRt3HSD2i+J03io=;
        b=BYtV0X0/1ltBkZ7En0ptIVkZp/P2ZaYo96Zvh2GmFqmdsriqkmkOBTOas4DkaGDkOA
         3TXg1XanKw5Oj/H1dMn7dw/FANjXApLqxWtjrBkOvDW54p1BAFUNt/gwecXNn68zK2mS
         ZlXKz2nv6fxj0/QNFaPDTCskwAFBv5nbW7OkdwX00xMXbHQoW6BYljf8YRgOaXu41yLc
         xgYZgJ64h7O6xLDMdoeR2nzrubuABKjR4tdLUFRhc5v/EEne9jJnS8SkiyXv0ySWnSqM
         fSYslg5/ezIimv6Zz27jKhXv8n4JDYcg/S1fkTmuR2CZJij7GFgRr/WkmJMSOuGyasVL
         BjXA==
X-Forwarded-Encrypted: i=1; AKwUvBwD2QTrUyt8fCLlTOUYPIsGTLni8FrmuUglPxvZBXPq7OLLaHj1t/kqZtiofxRO/byvaw9Yexo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkGMox6GhChgjtfX2rNaUluhj0rmJqWs5ZK16A4li1cfhWYkJ+
	6GjrAthrxpuhoeEGPBHafPxU20zgBBX9istuQV+Qzp40KMZeVzjCVoCw
X-Gm-Gg: AYBFou3NZhMonCkY20WvujGhpWIBKw81N4RisFpHobtBnUkFmXW7JA+Vc70Qh/xHoHv
	XVAplpMvjVhxm281bpd8bkm3W4hor+ZFxaZ4apylr3IwASYe42Newrmujl6QdY3tZ8abTNHc6XS
	3uHnEkOCoibS+mmtbpS7Ve7iUtD5tkLsS98cfmPIecQk8bf7QXji24yzEEtpBtrs24WPrZWRPte
	Mu7pPoPQtn17aQdWXqeVYor9RvFm1sYiObgHHpLbUSRSynhY0MIa+qIO/eUg0AV14NbHd2+1VCH
	S2+eQz9UmKYhcBPdys4ULztBx5mmg1LpVR/Ten6JJ0t5iDi59fdBW8Xan1F/fv5UwBbC3CuMUWb
	1vfjY1w5dYhS6MwTr4PqNu9/Se05ywNT53bNQjJZEFaaeYy0XPV1M+USe564dC4EPwYsOkQTRS4
	pSmoMI/hDrGiwbo1fbtSD7E2VbrLtxj4b43NsRgSoa/YVgWOsO9zIdLavZw2OExXhCqHTOlqj4s
	7e7Lr9JJw+u4R5Fpl/myGg1QVhTXQOZWLAc+8pvfZD+V+OyrxIYtg+YKkGG/mIF7zqmYwyGLA4a
	bYNVfAMoaA==
X-Received: by 2002:a05:600c:3b96:b0:4a3:5a42:b2a4 with SMTP id 5b1f17b1804b1-4a35ac8dd4fmr54691375e9.12.1792873435759;
        Sat, 24 Oct 2026 13:23:55 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e11bsm93522995e9.1.2026.10.24.13.23.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Oct 2026 13:23:55 -0700 (PDT)
Date: Sat, 24 Oct 2026 22:23:51 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
Message-ID: <20261024222351.396b0c8c.michal.pecio@gmail.com>
In-Reply-To: <bc5865736052c55683b2d3f2eeca0e01@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
	<20261020184244.69b78d5e.michal.pecio@gmail.com>
	<a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
	<20261021005654.23517441.michal.pecio@gmail.com>
	<cae2e837872be0560f7f46e13651059b@tipi-net.de>
	<20261023202645.7bf4827a.michal.pecio@gmail.com>
	<bc5865736052c55683b2d3f2eeca0e01@tipi-net.de>
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

On Sat, 24 Oct 2026 13:17:11 +0200, Nicolai Buchwitz wrote:
> On 23.10.2026 20:26, Michal Pecio wrote:
> > I don't have any out of spec device, so I tunned a Cypress FX2 into
> > one - it exactly replays every received packet back to the host. I
> > found that power of two sizes from 1 to 512 work, except on Etron
> > HCs which only take 512. Guess we could have an exception for those.
> > 
> > So this seems very viable. I will turn it into a proper patch and
> > see what the maintainers think. Seems better than patching class
> > drivers.  
> 
> Thanks! If you need something testing with the devices I have at
> hand, please let me know.

Hmm, I blamed existing code and found that it actually solved some
reported compatibility issues. Devices that specify bogus packet size
(that they don't really care about) do exist. Somebody had a problem
similar to what I see with Etron (maybe it was Etron), somebody's AMD
chip didn't like packet size of 4. Using legal sizes helped them.

I think I will restrict this to plausible values and default to 512.

Testing which could help is to check various xHCI controllers if they
support those 64 byte endpoints or not. Just because Microsoft and
Chinese TE vendors do something doesn't necessarily mean it's good ;)

The Etron issue is real and Windows seems to have no solution for it
(instant yellow exclamation mark on connection). Better to avoid such
drama with devices that don't care. Hopefully it's unique to Etron.

Regards,
Michal
