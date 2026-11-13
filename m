Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566674;
	b=yLeMf1VAGSlINscbHIFOjyni4uzzdE1HoRwM3BjfXY/zFlKMifg4lb2OXnd8YSrmO18e
	 fFmZ8AYdJGulTy9Quc6BwxMvtqmUXTdRLUQErf77HtbyROsR5NT+t+7rqTIYpnKOT+4Tb
	 es2x0C4tZj+xtJFr4Kwew+q0ddzmO5wTJDNZwUNORUn7m9KRlra9cHa0+AB559eIGfGOC
	 PcMA1xF0wVdkinCFPjlmV7FVpzhLOSdMNYH+1Sq5UNOJcuzxP4iq0diQK86l7Ih5YJko0
	 UeTbHkoKlHnv9J3ak3zwMZFM3FtkhCPkwSEYS/k3WKxxKmp6nSMRi3hzwlmhxEvuyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zInJqY6LTEmXUTu5FxX9E+7sI30J7lDtTDw1puFrswM=;
	b=2/WdqXhlfhDeoAwV9SanJPpQRuL0xYVHiKGzCkQvTFXHnjJmS/oBW0EAIT618r/8I8hW
	 h48sDnYwi9hJG5djuVAv6jol/vYH94vHtjAKPLpiIM1HPzCOPeM+zFprFi207apNRHUPx
	 IpwV+QnFQzIcgM+0QOKCwcywIPRaT9G2aLRq3Z3skuDzW70sa71xjcc5G5LSyZzERNaL6
	 S3oX2cLrukocbd8oTM08wwyT4vacFahpy/wF8LGrSANvERtxZoFzY6tts3N3DGFD4XyWD
	 S3dOFUs1Wq35WvJgFIrwyfviFr0h099yzXZXvRGvI1uNfGXGsfUyCmvwgu2MHAEN9rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="hBj44/3i";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3B606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B3B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=hBj44/3i
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso7337235e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794566672; x=1795171472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zInJqY6LTEmXUTu5FxX9E+7sI30J7lDtTDw1puFrswM=;
        b=hBj44/3iRLCVreNnAiVzoLGZ9xMj0mc6dfPc1w6tDuiTDAWDgWwUz2HvvYrBgRPQJy
         puKWeUWlJaKd24DljFMIAtLh6+Idr3kSaLNEAG4miBQ5m5wW/M9knFuFSJn8jzous0+K
         ph3Ipha6mTMuzmAU28JyGB9z/L29mKboEaNN3afMxSU80HgoPLt0dEb0aOnDd/r3UVjx
         KpR/Z4cApQ3g4dzcVB3bTENEwKeZqm95rK3gBHHAw/zbtc7kQlFnZ3lAgu1Cf7gwzT7Q
         /KXffKsXLDZCgsAHBOnY2w4S/2dof9iO1oL7+N7kujuIP9BwHEYv5QCHREdlfctRqY/q
         CoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566672; x=1795171472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zInJqY6LTEmXUTu5FxX9E+7sI30J7lDtTDw1puFrswM=;
        b=SFzxjDz8pxSuerOFw47JrYsGfSgsqw4LiIPBkvvQ073DeEwnzRUOqPok1WuOowgzp2
         y+e25cjK655jJDA+BQ0SNrEJkhsXjlL+YXM5AdDiB8VwVFEfOvRJWY5uQFrB9DBHnAp3
         jEe50ggNmZ8lYH+EeMy/yTwsfsxK88HC32xnvu2a6mQ0GkI2c43H5xj0sjpCKkkGBh5W
         fwSpEzGVE6iyH20kOh5Pq5f7gn3t9QmJqX7SSJFimlWLh3xWtsouq1pHYyfCgDUUFher
         vHMahP/dAOYYx3v5iwKnKHqIOIB8ddjCCmVY8pgAi+yU1Djq4IIZe01MKEb7sGAFVOm6
         N7DQ==
X-Forwarded-Encrypted: i=1; AL+hErG0XmlwJMl9LSvGpdmUqNdiUgeUUwQfYjPwwD4cqyhxAQY5TmtvQRC7B+l5ThLaKYQXYb3pzKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+imSolMHo4wu51c8zrMcZ3WaUUnTRe07HaphC7hPW15dTQkC1p
	cGQYSBxsaxG0+5TVFwFAC/dst+upXZTxW9nxnNooZBD4GukmThCDnwnx73yfsX+Pj4c=
X-Gm-Gg: AYBFou0wvgZC85jsbZk39QIOn0YK5UXnXF2HDjpuIkSkNSVDNiW/spnOm9ewXwhD71G
	J5joELLwQ8as2Ikru6/uCo2zDi7HSHPrAXj3yBs9iAVrCsAEJ3qWYGva7k7ZW1IHMlhb31PHhgA
	cQZOol5Zdkm6T+hdLIqKn3AK28cTvIlgh3Dfi5WOH5KySOBGUQiV36ryesXarcfX0A2jO7JyoYb
	g3CoRGq6uqEgDc4L7T0QyUthOWd87fExOlSxfs96yYLPOi4MtRG+varpLV4WegOyRddcxSq56ur
	GIEwK6rsBZVg40b8dKkWQUYnG2BHPocWGly0Ym9q6m9nfmBeuFx4M+aRTfnRILQyxeLXKcm7r0p
	IeYmatByH1uGU/RvhPbFoCrKMz7/FFhSROmkuZ6+kGfCTfS/oDPWKGEMIfkXJ3JB5qaIpkwNmvA
	uPh10+wn9Bh9jhRGlzNCHzFeg0kYqGQdW4HzXs4TrcqOGIOMbf2++8B3pWqbQ5yQt79/KNsxJzM
	QkVfWyO/jTPR4e1OEiAkM7ixEz8Es/Uzw+9QQd6NdwrEqFWq5LxAZeR7a5uPNYFl/AtPHML2d93
	I/gYXes65nRGy6AUoeTY/WTJZv4Wr/clYihRvOPUN4NOFAZrmz7IxQuUwXeR7iPGpnbb0A==
X-Received: by 2002:a05:600c:1f96:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4bb55a4d2b5mr43823765e9.14.1794566671745;
        Fri, 13 Nov 2026 02:44:31 -0800 (PST)
Received: from ?IPV6:2001:a61:1390:8c01:a86:2939:41a7:7e8e? ([2001:a61:1390:8c01:a86:2939:41a7:7e8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae501bsm56364925e9.10.2026.11.13.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 02:44:31 -0800 (PST)
Message-ID: <4a7f62ce-a02f-45a7-8e81-8808551b2b20@suse.com>
Date: Fri, 13 Nov 2026 11:44:30 +0100
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
Subject: Re: [PATCH v3] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
 stable@vger.kernel.org
References: <20261112160929.6479-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261112160929.6479-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.11.26 17:09, Olivier Kaloudoff wrote:
> So by your criteria this stays inconclusive — I cannot reproduce the
> queue-depth wedge on demand. The enumeration stall remains the only
> repeatable failure and it self-recovers via the host reset. I still
> think the blacklist is right for 174c:55aa/ASMT135x: two filesystems
> were lost to this failure mode in the field, and UAS buys nothing here
> — BOT gives ~3x the sequential write throughput on this bridge
> (~136 MiB/s vs ~45 MiB/s) with none of the instability.

Indeed. Could you resubmit? I'll ack the patch.

	Regards
		Oliver

