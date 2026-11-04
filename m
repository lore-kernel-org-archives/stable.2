Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813769;
	b=filXIS2jRrbuae5QoOTSPZ4nxKNcEd8YIE+YCThd6ovfNrn9XFrxoWyIJnAofOJ4SQKd
	 GXOQ6oc/Y8+sRw4w55PCWVH8i0MjAY43tGG+iTx7Qe+aZ2/H0ECsuucfY8ih6FfE5hLIe
	 Iyyrl/K6hk01Lw/BLtzt31f7iY+Fr7izis/36PwbMPgfTwErLlApUuGgbuxWVqy4tEOg4
	 5CyDk1OegRS0EY5X8Oire3C4PKvLjnirfz7QHy51N9AUKM8kSjoNI5egozAr0My90ZHCd
	 Eh51Iu3Z/6jroliREOYHYkphxAfBK629WAvurCt+d2ZSe6PMtoEHEYvjC6NTxvYfzbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6zWWmAM/EjSfX+fzNtWWpqxiPfU3InnZ+YWyZ8VpU1Y=;
	b=uQoAS//edvGmjCt3fushGgpHAtmV4rInXC1nyxuXkYdVgviPZDaOZaGausuNJ4SlgG0P
	 5k9by8NzfSWX9olAIBhp0oeQxy/WNFzZe2KdEfibdjCf6NupZNaGXCIY6xB2ARU/CYBne
	 C/h7NWN35tUPrA0Th6/Up+ilaN+e1fy4SwWHU+r7p/jb+WN0gamjCzrhas0Rzbd0+xXvm
	 S7D5iXwRFGPRkE6PP0r8ziym05OLJoxtIievppbJAqGGS6TzA8iFfjaFyz9C5q3t4i5hU
	 jdlaeUMYowoTUspBB1Jx88zvafZaDlDCX1sKpUrQgxB+rBPh0/RtRF+WA8HGs4/0iHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wufik20/";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3F606D83A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E3F606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wufik20/
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df4f540ebso523840f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813768; x=1794418568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zWWmAM/EjSfX+fzNtWWpqxiPfU3InnZ+YWyZ8VpU1Y=;
        b=wufik20/hF2eGBxiq5EJOIEIs3TvBuHcrkCWZl4iunPIc/jhCgNNuuYqUB/VKoz4nb
         rdlyC7Q0EPWILdkaRhUzDeEyKof0V28bqH2T0TlHfpRVt1Qe5Baf1lwWsvLU/75RZlbh
         bqB0ykMxUep4Ur8yvE6fkibug9V5IZpeyAAIDrui3507ekFUacV6zsNvNAAMT3plDzfU
         264qGYsGhaynzVWx2lPks/HF4qzlYieu62zoC2GL/yrIul+6mlfr4wr5bM1HKLPEqyOl
         5CCD9HtILxCwa+SUjsFF0ysOHZLYiIna7ALDMU7R2oKtXjqJMScQ4bK1U58WOy0n75d9
         TakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813768; x=1794418568;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zWWmAM/EjSfX+fzNtWWpqxiPfU3InnZ+YWyZ8VpU1Y=;
        b=ueAi9vEpF/kuZpnbPociiZL1D6+/DHhSaf9BVFmfYevP6LfD5iJi0fyEYECxEiEvdA
         I06znkWui0orFGdElIbGDtaitP18eZ9FGNxAIcp6H3qCAhTcHNFp1UamFfCCniWggcSE
         HYz4hjczHniJpw/T9zWtFHkBNJb1GAp/X0ZG7i5+lKoT0gRP1nkjUpd87/T9y5h7yuLP
         FRU5EtPKjEr4jBBvDuAahispKtURKrBVadYg65nuYxqxIuyKGijef3Kld64EHjE5faTM
         TThKBZ0USCRckd7rQLdn2iLVQIX1cqCPd9fmK4aUuiioeV0wlY+LncNixSCdEcwiSJu7
         ZCdg==
X-Forwarded-Encrypted: i=1; AKwUvBzbMfDZ6dYgYJdK97DKWsmI08XMopTpGShWEwe/ZwqJgws9uCQU4Fg0ojrxv83VZjJj/nHyf1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TywGcbJ/t4fJnRGi0lsiYljO23ZtcmiEQbXMmuDhjwKpT8i/M
	/CY4gSsE1suckd5zkqK7hf+j8ToVbhzwjtBG4Ysd4ZLgXbWnSzPu/EDv
X-Gm-Gg: AYBFou0hqfpneW28psH5tyIdVW6IMbrQ5Vx2ydKqSN/1mzUQLQb889T42LPlPPaNfDe
	Os4XCgoZH6QJ2RHDTrQee44Cegt9HXarpfDbwLWPfREIophRXa6UjMC9CB+yYUQ+Pic2MTdYMs1
	mnZsLwoNRDvYNnKhJim3MIhrNltWWmKfUZWXhDWgsboZEH9IlQjo+iW9A4vULAmGPcfctVtZZx0
	VmAx0RUgykw0UHdVh8CG0etlt4UfhT7+HY8iORCdrRmfdebM3uIadidDbEQ4ebt896ApdXvzLw+
	PJ7mJs0fzl3jMdNT+oWTXHzJLbLIJkhJ7nlEiswwNKfAhXsnRXtWZFdoq0Svex2XQVU1twTZD6e
	nv6KkgR8JAvCDTRUgr72fdg4MV9/G5zJyV654LX7C46FpqB89I32qx32jX6eUDFaLbLQnTJqC0D
	VBdV7MD6iUbKNYOz+sRkw7lH0c8znqeSKZUo6qKegFrMsEyte/ibflK9UUJKwz6Va333vatSG//
	4NhoHmTDWkuYcj/d8tv4wa/ZJCUModbizHb517g0w021DuK5vYn6yqLEGndjJVkPvV12yPC7R/J
	xltxtHu2J4WzSTyzzR0zQMfBkTu5A/2diktjQVcvtFHieU4fMPIp2dvTpEB2
X-Received: by 2002:a05:6000:400c:b0:48e:35d4:55b5 with SMTP id ffacd0b85a97d-48e6e518368mr33802651f8f.52.1793813767532;
        Wed, 04 Nov 2026 09:36:07 -0800 (PST)
Received: from foxbook (bfg124.neoplus.adsl.tpnet.pl. [83.28.44.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac2772sm4825519f8f.18.2026.11.04.09.36.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Nov 2026 09:36:07 -0800 (PST)
Date: Wed, 4 Nov 2026 18:36:03 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pengfei Lv <lvpengfei20@huawei.com>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, xuhaiyang5@hisilicon.com, xuetao09@huawei.com,
 caiyadong@huawei.com, suzhuangluan@hisilicon.com
Subject: Re: [PATCH] usb: core: hub: Re-guess ep0 maxpacket size on reset
Message-ID: <20261104183603.17d663ce.michal.pecio@gmail.com>
In-Reply-To: <b9ac3c8f-7ce5-43d1-bcf1-d2ce9877d914@rowland.harvard.edu>
References: <20261104124402.1269650-1-lvpengfei20@huawei.com>
	<b9ac3c8f-7ce5-43d1-bcf1-d2ce9877d914@rowland.harvard.edu>
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

On Wed, 4 Nov 2026 09:59:24 -0500, Alan Stern wrote:
> On Wed, Nov 04, 2026 at 08:44:02PM +0800, Pengfei Lv wrote:
> > Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
> > all device speeds except full-speed devices, where it can be 8, 16,
> > 32, or 64 bytes and can only be determined by reading the device
> > descriptor.  During the initial enumeration of a full-speed device,
> > the USB core guesses 64 bytes (hub_port_init() with initial=true);
> > after reading the descriptor, the real value (e.g. 8) is stored in
> > udev->ep0.desc.wMaxPacketSize and propagated to the xHCI ep0 context
> > via an Evaluate Context command (xhci_check_maxpacket()).
> > 
> > After a port reset (usb_reset_and_verify_device() -> hub_port_init()
> > with initial=false), the "if (initial)" guard added by commit
> > ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()") skips the ep0 maxpacket
> > guess block, so udev->ep0.desc.wMaxPacketSize retains the real value
> > (e.g. 8).  The xHCI Reset Device command preserves the ep0 context
> > as well, so the xHC ep0 max_packet also stays at 8.
> > 
> > When the subsequent re-enumeration then uses the "new scheme" and
> > issues a 64-byte GET_DESCRIPTOR (get_bMaxPacketSize0 with size=64),
> > xhci_check_maxpacket() sees hw==sw==8 and does not issue an Evaluate
> > Context command.  The xHC queues a Data TRB of length 64 but applies
> > ep0 max_packet=8 for short-packet detection.  
> 
> That's exactly what we want it to do.

Should we want it, though?

Were there known devices with bMaxPacketSize0 <= 16 which required the
whole transfer to complete before they are reset?

That's not what happens in the initial iteration, so it seems any such
devices would always take two iterations to begin working.

Is this what the only correct Proprietary Operating System does?

> >  If the device's first
> > data packet is exactly 8 bytes and it sends no ZLP, the xHC does not
> > recognise a short packet, keeps issuing IN tokens for the remaining
> > 56 bytes, and the control transfer hangs in the Data stage until URB
> > timeout.  
> 
> That is the correct behavior.  Indeed, the same issue applies to _any_ 
> 64-byte transfer (not just control and not just Get-Descriptor) when the 
> maxpacket value is 8.  If the device sends an 8-byte reply with no ZLP 
> following, the transfer will hang in the data stage.  That's _supposed_ 
> to happen.

Right, all those details about HC behavior and xHCI internals aren't
important here. The device is out of spec, apparently expecting the
host to always use MPS=64 for this particular request. It should send
the full descriptor in response to further polling.

More useful would be information about impact: what this abomination
is, does it always fail to enumerate on the first try and trigger this
unsuccessful retry, or only in exceptional cases? And of course,

> Have you observed this problem in actual testing or is it purely 
> theoretical?

Regards,
Michal
