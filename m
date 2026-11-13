Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.40.151.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594740;
	b=A+by3irjn1SxO1/oo+I9dUJVto7askO7RwGUZaxgrgzarxqj0jXVdU/pzya60WEPGVBN
	 ZS9cNR/Ka5BvmAUmU3xrGF9DShWC4guoyHgREgfWgV70kVms1UQie4m17GwVPPzyoKKMc
	 DGsKhtLRDplh5I01Jj7wfdZ5wVsW+m9duUtBO7PMlemE7opux4MBFvI79NfoL9EyCMnpF
	 d1xTpytIkwf+y6LU5wMQaimROx9r33YuDcoe/i7+LTpjUJeK7eGMrg9BpHbr2fbFvILQ7
	 k1SpYqv+I5rWNfCCJ/crYUTsgRBVSEK+L4PlpKSCr21qm+eHX/8FzdgXEdZXocTKGWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594740;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=Y58XWTkjTLBew+Qz8dT0kBKz2jPaTBqmrF7x3TUDRZs=;
	b=VQXiB13d0FoaaPDTwAXEdwphHj3rORmhYhCK4Oi0/DjtQJIk0RVnPihVPCnN6DFn6sMT
	 VowdrbKhUVihM5MCAS+eaDePuZtbp7jU+qHILitjk6iGf/rtpEJjN/VTTVFeTicRtCqjl
	 JGZ+PCQTHLHrk1vz1i1ADEwQ4K8tGQFAm1/QIZEGUwiq9MKYTCLWM0zqcu2675v/bRozr
	 0JW69ZMdrUaZw/4+nUKLbtlQAZ58/NcSmvQbquofaC7GDBFRlX53Jq44Ft1RD2ciMAzem
	 MWu9VpXBLqIQwGvkZiv+o4S/oJxMZpjCFbVWoiJNKBSVQHTGlpOoQsvFKudRX44+eHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ehuk.net;
	spf=pass smtp.mailfrom=ehuk.net;
	dkim=pass header.d=ehuk.net header.i=@ehuk.net header.a=rsa-sha256 header.s=default header.b=ths8oLW7;
	arc=none smtp.remote-ip=78.40.151.100
Received: from james.steelbluetech.co.uk (james.steelbluetech.co.uk [78.40.151.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DB606A8A2;
	Fri, 13 Nov 2026 18:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24DB606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehuk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ehuk.net header.i=@ehuk.net header.a=rsa-sha256 header.s=default header.b=ths8oLW7
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
	by james.steelbluetech.co.uk (Postfix) with ESMTP id BE80BBFC1C;
	Fri, 13 Nov 2026 18:32:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.10.3 james.steelbluetech.co.uk BE80BBFC1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
	t=1794594731; bh=Y58XWTkjTLBew+Qz8dT0kBKz2jPaTBqmrF7x3TUDRZs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ths8oLW7xITp6Y4+Jbr4kq70SRk2cgwJdV4y9VUB4WRtumOVE2BjmhcJIo4FlBFxG
	 mCk0IU3Q9qhbz8HYEMvKDH6wonqZ6hptSZZgeP13wzM6wDluHQjzA4k0L4l+wuQtjB
	 FwalPvThcZhkTj9WnbiZmWwootgJTcVtCdmCm2iGvVKaQYzVfg5zYsN8b+P5x/FG5Q
	 gXa3sjDHaOSayD6Q6VKlELCyXg2G5zhid+EokICOB1u4yU5FgOHj78mI2Qa6gI/0QP
	 JioXCV582RNu2pkXBTegMsk595GhRVZrYPvVAanEZ35L8Elv6E0PcfNcqiSBV9vpHU
	 wdUvb/wXY9bcw==
Message-ID: <578d6cf8-264b-44db-8610-59848683ae5e@ehuk.net>
Date: Fri, 13 Nov 2026 18:32:11 +0000
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
From: Eddie Chapman <eddie@ehuk.net>
Subject: Re: [PATCH] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 usb-storage@lists.one-eyed-alien.net, stable@vger.kernel.org
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
Content-Language: en-GB, es-ES
In-Reply-To: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang

Hi Olivier,

On 13/10/2026 23:19, Olivier Kaloudoff wrote:
> The ASMedia chip detection in uas_use_uas_driver() assumes that every
> device with idVendor/idProduct 174c:5106 or 174c:55aa reporting a
> config.MaxPower of 0 is an ASM1153 with working UAS.
> 
> ASMT135x bridges (iProduct "ASMT135x") share the same 174c:55aa id and
> also report MaxPower == 0, so they take the "ASM1153, do nothing"
> path — but their UAS implementation is broken:

I've been following this thread with interest as I have a number of 
174c:55aa devices in use from different manufacturers.

May I trouble you to say the product/model of the Orico device you have 
which reports "ASMT135x" as the iProduct? Hopefully that's not too much 
of a pain to find on the casing or box if you still have it.

Also, is it still running whatever firmware it came with or has that 
been upgraded?

I'm asking purely for informational purposes. I just thought it would be 
really useful to have these two things documented in this thread if 
possible, for the benefit of anyone who might want to debug issues with 
this hardware in future.

As I'm sure you know, ascertaining the actual chip being used in these 
products is difficult without opening up the device to inspect the PCB. 
That's impractical in most cases but product model number can at least 
give a clue.

Many thanks!
Eddie



