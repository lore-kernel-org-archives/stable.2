Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534610;
	b=iJ5So5XIvA+6qgv1c7GJlgCDIJ0qez/Cd5zW/DsyQf+ffoYi7phS2HErEbQ4YXptCIzy
	 PWil/HwQ8lLZf763TDvBHiWcwNd/YT+dA9Q3ZpYPrrMxkcGD/U2qim/3X3NSa1OwagAEn
	 vfBzhvDHEBh4KkRBf5iRQbPrZLMlsmQsfpD1DQPQisyZ97lZkPofmrI43eYsULhS4hBtY
	 iG+B6gn16RVN+hH8tTYwZcMcCnEig4ijN83b4WK1aIjSaO4i9ymfuwx4e/o8G8wLbEVP7
	 SkSJXf4GddA+LotDpL2I5lglmzo7L1yYtBJHHqU1U4Ip4/AA+I1fhEuZ0ccxVCAJkzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
	b=HTEspmQZaDH/hkilJ3mxUx7VYHX+fNq9zZ7fJiDQrkRAPtFE/jS2nYppqOlDOyylwvl8
	 FCe38zYVwQB6YAPZxUWAAY1ssPdEaoYiB8/s4FkheivKIXP71gyhFl+xAakEx9W7mA1is
	 FhXmkuwKPvRosXIesCTtYmnQ3XbUnd71ovb2T2AP/qVAJvYHjqvtiWGvwO30IqBg4bfS2
	 iRIRMTNn3zk/0GLaeFkAXTW1AJJim8DgBSqnot/Dz/Mb4Nft5UHqvz968IJeX2/YXW4p9
	 I3JxsmlsAG8MbofvBLMpHttHZT4cj7UWymhUwYAogkXOJWB/PqvCoSlC1bx+s6ixa4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nilk.net;
	spf=none smtp.mailfrom=nilk.net;
	dkim=pass header.d=nilk.net header.i=@nilk.net header.a=rsa-sha256 header.s=nilk header.b=tWp0rI71;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AEC606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9AEC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nilk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nilk.net header.i=@nilk.net header.a=rsa-sha256 header.s=nilk header.b=tWp0rI71
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8615bd716c4so221244a34.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nilk.net; s=nilk; t=1794534609; x=1795139409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
        b=tWp0rI719UU142KQhb1yPGUl22F17Sh1JUxpA4NsFc6kEp0tYVQHnx5pXkb/LVfX1f
         apiUvZt7erHl1d1SZQPcXchXhdJwr031RgMcmeLjD2AqxA/cjX+tXAMgMye2C4J01kmW
         4VCNg4tNBzaeV2/xYB+XAyTMxKM8cJPuALGzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794534609; x=1795139409;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
        b=LT6RgClbp4ojWabxwTTPBXmLgWK7uzihKqLASu/7N5GRtcOslZYPqK4FmED2hKhnuw
         uWiasBGGGEilncx5GJ0GE3go8gGH7z3DtzYGNWA5BuP6VVSwdYK1ESwK5gfR63mmXZvJ
         d6Z6fBBXvnvu9I6ZAuDfLtBowqzxyqnGffYXkFOyHkVLjMSelDbMVLw/QdVLgeh6US2B
         ktEwNeHGMQUrCaxY+av8LsdeIWcbMyUll6vDvjXMjXcE4GvWQrucB3SKe/BmGzOp/p3k
         LWJuDDfHvchu8GFnVYiluboAR1FBbEo26Lm1a+pA8wJnoyWRVTZEeU9X0xw7AEua/zae
         2CrA==
X-Forwarded-Encrypted: i=1; AL+hErG760OujKpUHXK4P3NtD7UAzJVItSlfS0JTWLz1RL3c9/++JH4AGfxGUb+WecuvMIy4R3jOBzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fz05LIYaJWIKmWSAfjdSlP2v1Yi9msRGBoPL7TqjduTnVT5CX
	+MWIZo1CD9U/Xl/em4Ba3QKIjrNX/5InRJL8AzHjFMEDa4e4kK5PSEJj1CiddKpa/w==
X-Gm-Gg: AYBFou2MAtO39iO/iAysM2CoJaA8FzChqmmbGdYOXF07cLEkoHTbw+m/qMKM4HUAD6l
	uLVuS9uLhMh/C7xMSFWa44VuWlSSTE8WdoPO5ZXhPXSRHhLZ3AMh06NzT+QE+0nRJkx9Bbl8B1B
	MNCHyVu88QEO14ecj/7DCl9VJdHCae3BFYlM9Ad3tZq8MLG4w4gB530rsCzqTK/yZhBw6mLtN4D
	8RJZNJac2zaIxPtzJCXoiWmqQw38dPMnw6axFsIaw2yxLLPHxKANIWvahR0wra3W6Tir4+RxchE
	VLT04QsHoWclTR9Evfw6EbIYG/PGHdzNiePFV7h1OhB9JQ/SlzaMowJj5y3FKwAdo8O+O66Xhds
	J4RMulVMptOGpLAfOo9Zr8wLUyWolWV2pw4AdR1Hi/oGDCgEQsBN81B9iVXpnmxRXjcNhcFf2tY
	3ht4kNp56q4S7MGwft3aSywbQKsuUD+XRLuDrFR5OH6+/kUke/cTD0PCIcW5MSSwn3D/WeuH/Ky
	YoUB7SZ4vAKwrTLUe51RUaLLNq2wx3GyeETigDDRPKejjb/FsBXOe3h6rVV4/8Gewi1hKsULtSe
	O+hLT+d/w6n+V3F4PpdfXKnuCq988R2YPfMxanMYO03YyCKwponA8DlLydgqq/mJnUExeMUX0XZ
	V2e/ikXhP3BLx4QsnEWCUVVidQR2h11u7GC6pa5tIJtbIV+CTjD6mYk5qcRnEfzLBmIJO3Q41Jk
	sE3RR/V6JClAv1k80HBZduuas7pg4EFXpoZbTPmPnF900ClLpkP6Agm7ssz3utz57DCs/qGF0Ub
	UbnYpcB
X-Received: by 2002:a05:6808:23d3:b0:4f1:a873:6efc with SMTP id 5614622812f47-56e65a25c0dmr969736b6e.64.1794534608616;
        Thu, 12 Nov 2026 17:50:08 -0800 (PST)
Received: from [192.168.0.45] ([187.14.251.153])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm811902b6e.9.2026.11.12.17.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 17:50:06 -0800 (PST)
Message-ID: <3e1c4b83-9eeb-4425-8231-216bf6c96038@nilk.net>
Date: Thu, 12 Nov 2026 18:50:04 -0700
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
Subject: Re: [PATCH] media: ipu6: Keep psys out of direct-complete on system
 suspend
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Antti Laakso <antti.laakso@linux.intel.com>,
 "Sapre, Sarang" <sarang.sapre@intel.com>,
 Divyamani Tripathi <divyamani.tripathi@intel.com>,
 Manik Bajpai <manik.bajpai@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261017-psys-ipu6-v1-1-56e333f6ed04@nilk.net>
Content-Language: en-US
From: Chris Simpson <chris@nilk.net>
In-Reply-To: <20261017-psys-ipu6-v1-1-56e333f6ed04@nilk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2026 at 04:13:38PM -0600, Chris Simpson wrote:
> Since commit a1fa010b3c9f ("driver core: auxiliary bus: Drop
> auxiliary_dev_pm_ops"), the auxiliary bus has no dev_pm_ops. The psys
> auxiliary device has no driver in mainline, and its PM domain,
> ipu6_bus_pm_domain, has only runtime PM callbacks. So
> device_pm_check_callbacks() now sets power.no_pm_callbacks for psys,
> and device_prepare() puts it in direct-complete.

[...]

Hi Sakari,

Gentle ping on this one. It fixes a regression since v7.1, still
applies cleanly to v7.4-rc2 and to media-committers next, and the code
it touches is unchanged in both. Please let me know if you'd like any
changes or a resend.

Thanks,
Chris
