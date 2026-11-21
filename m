Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294501;
	b=IULSuGesC+8BjYLVjo7RKTqX//PNtV4DjRM6enH1uE5kz4llrsu4mvyAeRD0lUKtv+tG
	 g8HFdfEE5yBdOueWQGIm3GfrT/f1c+CwvAhy1yN1Hw4Pd2uqGzx3lb0ZBdGp3Q0tM7nVW
	 6nSZTU2GX1BdJUFSLZIlgfMYenuzY34+Rw35tO35bdKXPR26H8xw0G/Gs8kC4kl93yZhV
	 vD0gE0fF/fvC7jKSwITZTYfg5RWW8uSTbbxaldlTfdEaLeo9gIdm/+zzsGYKeTaRSZ2Wd
	 4iIO4HITlCC2Tv1UrCdfUHxZtKplDsADaxiLjIgj6wHRxY1pgDhX3rpBQ7kjG1XhERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KsAe0DhYdt/3g87gB1LeApXPRoWIhM10pQ46a9pN3C4=;
	b=IsR8kNSPBZw1mjeMAi9bLnqwJoXCizofl8aSyxBu0rSSujA+2uuUw7YcY0+H56R7qCN8
	 K58+E6RCfx5gEbnOZhm8qdZy3qfdecB3XG7m83BvFa297IRdgxoVhjhfMUCX5vS307cPR
	 l0KzRLlKOqJ2jhR8PXWwLLLD8kad3Ejmt0s3aQ7MFaloTDxb9CwcDqlMms+PGyf07rMsP
	 Mq8EqfaSq3SxjOEdAs88em99O6HlDtDkF9Xjx2xt3+bGn6QXu7ffPJhJPNfN6bXOfW7hr
	 SlynYakODobAOB0ovgpyPs/6fsE5wAsJNSjFErTSDWKvhCMhG6D9LKv4pqqu1CbIXDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=XshW6s1k;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE4606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEE4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=XshW6s1k
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9212dac247aso23388166d6.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795294500; x=1795899300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsAe0DhYdt/3g87gB1LeApXPRoWIhM10pQ46a9pN3C4=;
        b=XshW6s1k7WQmR+2O2DWZ4GneGxkUS/SJGW0cSDG3Q4YBBbLNsjXA757q/8fabmUPpi
         nqQJd4MuMDODQrW65W/CqW0K3c/tyhZybm5R0QhPdCYll3lXGhMrmFwLqWOvgoE9Ssx/
         oERjx9P24ajqlRpwagkS21qqjRVFUD+jMPLHXaxxGi+s2oCEhjPbv1emGdzUKM3HovV6
         i86/SjI3vTAH8YvB+PH4Qs7VwnxIsP97xogmec5nk91r9ljnstyYsIZy4EyMz+gjBbLn
         2tJkpD6xNjxor97q+4e5hI3uaZAjaVndHg6nfOm7lZs7GO5q+PsYxY9vRfaeEpK50eNf
         xiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294500; x=1795899300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsAe0DhYdt/3g87gB1LeApXPRoWIhM10pQ46a9pN3C4=;
        b=tMJUVr+bJrsrOdZ/FbAjAI4f6oNfNteWTmYXeIcq1fF5Lc4iD9M2EtT7lLpFZnv3+4
         j2sWkw6Z0Nl+qYnzc5WuBMGCSguHYk1guoyL8Uj4f697hMbt4BHp29QlsWfaamEHAMiO
         iySDkzgzFeXG/LnfDP41Wsiqh5wwMqcABVEj0tzc5SLA2WQjRtykVhgjgA//PCJoDp5M
         5+XVKfBdP3as1AVeSa/lCaGzDsIo0pusvqaTvlmW97zHIp8esNIxV+O0/Oxch2Pki59/
         rGjdPkHivGtjGCYi5pYm4ZKMi+CkzpooEPgol55SPKtzErPXIc4Usa0ayZM8tf8iMcwl
         FJ+g==
X-Forwarded-Encrypted: i=1; AL+hErHzfnOptw74l8lxH5EtMOqpQooe5kFMUZd4yLdH2teEwWRz12l0/0s37/yVKUhSxJLHF2nNsgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jyUcUXYYsv5fPMMsiNmUAWrZBk1YbUS37OE7ldZPjvFF1F8PU
	R1vfAPx05K298tRcX5gnXvfht/UIya0f71OePjycbLJwmw0EBBZfSf4a9TgGhb9Sqw==
X-Gm-Gg: AZFdTZeK/R7QdcWkMbWGrNeeWfvO8kxrh58VQPN7HhxdXwSYyomHJYF+1I8m8v1vstY
	e0k6cwiVsyfl5HoZnuH61KH+jc1aLZaq77Kw8/+f2LIR1RHdep7fa7dJBZGOfPCQT7nC6Dukfta
	aCGsGyGeTjoxubJMandR/g0G1qnIVQeWRMmQ6DjR6uSBHSMpPx82luaTujG5/cz3Uvg8S0haRgL
	wMzFeX3J7r9xhc2l9Ei1CswPdnl4Xnfpsz7GDqGIyzfiNo7cDBXmDLGvft4JFz3P/wqTqSi0MhQ
	Q0B+LP1k658honmFz2W0DN/ORXYx4ppbbkMv9/39mK7Z/bDk3OqeYPSIAumtmYJA1Q/0mnVHxYF
	ONbbmDRl5SvibXlgG3KL8G1pdHAf/CNeUaoaQUskHUyeVdAwwmY743M4KnoI6XBK5NByOmBsg4w
	ei4rf/IxrgcMpv7GX3lKjRJDSY5B0z2KZbfePfNmtWJTyLEvT50b3SLPhg36DswVfOHwby/7iuZ
	axMGufnJzYhKfi2J5YrJqRpNkDRsll1AXvWRzDCiQlxf6I9o07VeghgNfOwcH6abb1A7PElzldE
	Cs6nyclmcQpZ5PnGL8wdF/TGN598BA==
X-Received: by 2002:a05:6214:4018:b0:921:3369:a766 with SMTP id 6a1803df08f44-92134a90270mr122441186d6.37.1795294500229;
        Sat, 21 Nov 2026 12:55:00 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm60909116d6.1.2026.11.21.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:54:59 -0800 (PST)
Date: Sat, 21 Nov 2026 15:54:57 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Arbab Haider <arbabhaider649@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shichao Lai <shichaorai@gmail.com>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: alauda: track media_initialized per port
Message-ID: <5d2e1310-88db-427e-ace0-c2a0590560b1@rowland.harvard.edu>
References: <20261121171956.1455-1-arbabhaider649@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121171956.1455-1-arbabhaider649@gmail.com>

On Sat, Nov 21, 2026 at 10:19:56PM +0500, Arbab Haider wrote:
> Commit 16637fea001a ("usb-storage: alauda: Check whether the media is
> initialized") added a media_initialized flag to struct alauda_info to
> prevent divide-by-zero errors when alauda_init_media() has not succeeded.
> 
> However, Alauda devices expose two LUNs (us->max_lun = 1) backed by
> info->port[0] (xD) and info->port[1] (SmartMedia). Storing
> media_initialized in struct alauda_info shares it across both ports: once
> port 0 initializes, media_initialized becomes true, allowing port 1 to
> skip alauda_init_media() when its media-change bit is clear and divide by
> port[1].uzonesize == 0 in alauda_read_data() or alauda_write_lba():
> 
>   Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:953 [inline]
>   RIP: 0010:alauda_transport+0xe5a/0x35c0 drivers/usb/storage/alauda.c:1187
> 
> Additionally, alauda_check_media() never cleared media_initialized when
> media was removed or before re-initializing on media change, leaving it
> true if a subsequent re-initialization failed.
> 
> Move media_initialized into struct alauda_media_info so each port tracks
> its own initialization state, and clear it when media is absent or before
> re-initializing on media change.
> 
> Reported-by: syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=dc208a8cf8d37cf3e5ac
> Fixes: 16637fea001a ("usb-storage: alauda: Check whether the media is initialized")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
> ---

Has this patch been tested?

Alan Stern
