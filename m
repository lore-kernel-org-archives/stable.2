Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344F428838
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607882; cv=none; b=W8lEVCoDgnGgYfQ1X58g6ky5dG9xCLDv4DapmKm226KC7S1BUaMawkwsekFQJCP5yZHrmBX5t/KvtgJ68yfSrnmvciijXh2y3VRAO7xVM6dHrXrYneZX5r4Lp+vEXguWhIPpvy6cJbAwsH3yJQjcXsH0GX8FCVjnRIwQcrWpVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607882; c=relaxed/simple;
	bh=jsrjb1gJOrLNfKVeyrgWHu2ndB1T3GxIUzfpraL1a4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkoqK5juGrm80bGtiEiD2hJO5PlZqGEBGw/MFxUz4dQBUrJuRs0U00RcpcI8K81QAYS/qDi2wwrPGcEotwS9O3S/f0rhmO1aa1sgtQL+8f/qRPC3yUcRdEguMYttsFWMpXM98qFLuoI5McRDh1d+kVCzzBuV6PWL25H9nvrNiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=cQ0V94Kh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="cQ0V94Kh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so4440292e87.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1781607879; x=1782212679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be9SAeX73nlM0ApRPdBK338zST/MXfWJxoZEdM6cwMg=;
        b=cQ0V94Kh4fDe7vFkKPmwOXcuNSXd18So0R13CfUVBT962BlpZwhVg904t8wEBD7oSN
         eqsMjTfZCd2bCdBwGUKNds7CFinc+FgN0+q0bIA7KcMSdk3nD4jDre12sGDptmiJmqrb
         XZXk9OsSeB4SFtzXNUcOKsCnl/l6jdy3CbuwGNkEIhsTPSXE9LJFwM9HC3F2Cwb5/y8k
         0BXfguvH/qZnKSF8lz+Fm3nMxTzkCm6DVHEtJfLwVDsYUfiPQVyFSOq+rKI1pyufYBjx
         l7pfCKPZsFgq7soo3MmXvzVxQk8V8kgIQHkqLJQ0GR86XqSAzpHhbqwAdLJ4pDFmwm+5
         eIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607879; x=1782212679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be9SAeX73nlM0ApRPdBK338zST/MXfWJxoZEdM6cwMg=;
        b=hu7AmgbJepTfVcu6lSkr6Z4sbOLFWv8VttzsHFUA6SP6grXvoXCNbFBhqAEMFibh7y
         m2FCKjnRZgMdCQC3vwfrEEqgnR7i5uX2IdB1P7768qs7EDgCrE7yHKGR0QxU6t27wfrT
         J++KExgCd9nxjJ4acuKTFBGwINKrycCaSCnvXHeJ/cvpNuuGIFjSaIsdDm50GdMY+H5a
         j1xyu6GR7n2My6O01+sPo7WN5NGBkLovhdPMaMduM4j5Ui9FRf+mTaepBWJnQDTY2hdV
         8zZ7JAFwF6p0r4EiNX6baJRy70OPGPcHBnXVYw7Y0VPI4lSRfFkgNB99gfF38o32SMwp
         FA6g==
X-Forwarded-Encrypted: i=1; AFNElJ9GFTayFoWI3jshAdA4vW8/1wsmMt49403Od7N4luTVkWi+KHlJ2cRQ1JeDDQxmsANcU1NZWxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcgjivWih8hTOAGO6TgIblyycRgE2qm9Z0Kn0662f+v5xSGuV
	rwmKMBlQ8aheg6Ck/QTXGaOYnJhYOlj3oSjkJapJKcSRUWS9U5nYY5BHuOCqurr7SPrN
X-Gm-Gg: Acq92OE8tmHcalIlz/mk48tskS7QLe9MsusOSxwijKMY6xU/DCUhtOYALg/VUbanszi
	ZdqCYjZR2BBAyVZYyOEMyLwgceDk6zLBWP/g8Gu5Fwa+0OcybHNSjjPMQGTV6fDt7GuQ3aj7l0r
	on4Xws16zAo9ioPwY70T6cw1Zfaq0Srb16i21TUfZ5cxlh1m9ClgO9Pb9NruLDQD9B/tPD+27FX
	WNjvY2/JdgGJz+3nbLmRJpnJe3X1Iy6k4D+tu3AFQ6M91PmktwqUeVaPnZQY5u6HI8nI+2P1NDY
	YJFB3+nlQU2I0W7C+YTUTjzHhEkFJZtlRIUZvLhlTQgoV/6l9LazPAS1kBiNC4rgDPaf5q9GrIA
	wAbW/9KJOBZZkk9ucDjgnAJvf0+QXTV6C/8t7Cim71S0kJEjSYA0U1XMe20O1P3+S4S/ZAyvLSm
	05D3tpZlVM5i6de31i2m3DIx/z5S6bEBgIA1CwqWvkPdUaADAJ5v6ANUh6Q6qa
X-Received: by 2002:a05:6512:3984:b0:5aa:6290:f78d with SMTP id 2adb3069b0e04-5ad30d99426mr3972154e87.2.1781607878023;
        Tue, 16 Jun 2026 04:04:38 -0700 (PDT)
Received: from ?IPV6:2a00:23ee:1510:399a:1882:f251:1d3c:955? ([2a00:23ee:1510:399a:1882:f251:1d3c:955])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16915dsm3486523e87.19.2026.06.16.04.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:04:37 -0700 (PDT)
Message-ID: <fa2e0cfb-9d60-4295-8a46-f69ce1229094@bynar.io>
Date: Tue, 16 Jun 2026 12:04:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, bestswngs@gmail.com
References: <20260615150009.1734270-1-sam@bynar.io>
 <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2026 08:50, Tung Quang Nguyen wrote: 
> A similar patch was submitted 6 days ago: https://patchwork.kernel.org/project/netdevbpf/patch/20260610153349.2546041-2-bestswngs@gmail.com/
> 
> I do not receive updated patch from the submitter yet.
> Your patch has the same coding style issue (long line, over 80 columns), see linux/Documentation/process/coding-style.rst
> 
> If you break the long line into 2 lines and submit again, I think I can acknowledge your patch.

Oops, I missed that patch! I'm not sure what the etiquette
is in this case, but I'm happy to defer to the original
submitter (CCd) if they're working on a new patch and/or
add any appropriate trailers to my v2.

I've prepared a v2 to submit after the ~24h period,
addressing your changes and taking into account Eric's
feedback from the earlier submission as well
(adding an rcu_barrier() in tipc_exit()).

