Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755361;
	b=UTjsJjnjH4uVT/cg5MWCfcV2hepUKusDYl9/0JmuNndUkbkVOQnKOQcgRJGwc0qiy3im
	 KzciUgHXwgZp3oARb3matMEPqd8Qmb/yeh0njof5GmyaJZK8rlGD1rUYFGgOH6EBFUmZg
	 ziiGtI1DZSbRYZ0EmufwWB7gPf1ld1W84pZJJMBQLdftDLgte+aZwfADGPRX4DLVfagQA
	 mcW9HVDLp/1OCEOeCXDOHKAa81rYrm4OlpRmRGqpSiyUqmGwGziYbINp0PWdc9zTN68tU
	 DSIrvt8RGPcpi2HeRMYyauySYVok3nI8Id233ag9daZCK8oOkDvOSFQy7xpAszXjYDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755361;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YktmMxH0HB2xEuGy1iPd+pNCryqr6cfRSM7tW5CcM7w=;
	b=RI3R6QcsD8IjFF4w81iUCxGIbVYwn24Dlt089EZ20k+RxxsQsXtGBXnKe3UkcjL/8Ny7
	 5fDPU7g/gaLZAG1fjwOm6o+1IxmDV6ZQxi5sy+TrU1xeIzP8E1zPHj67gaVKT3iElMA+c
	 9T2fU7JVpgPAycyEeE9SFZ+aBb876XeTT9fjbjcLFNHAku7518uGfUeYVHTSIzbhzcfAN
	 wH8R/uCnOE5/GwQsLIh6qBR+ExDD24nM6uCaPk7TUYwdP9xRY3Me4F8HQwao7HrRs74ZV
	 JINhwgeNn1VbaE0VTOv2WlRqcE0ORnWMYtfX7uk9qROYPAGGAWk1MO8XlJx350Qp3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2ylGTye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843F606A31C;
	Fri, 27 Nov 2026 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2ylGTye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948A41F00893;
	Fri, 27 Nov 2026 04:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795755361;
	bh=YktmMxH0HB2xEuGy1iPd+pNCryqr6cfRSM7tW5CcM7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a2ylGTyehjgJ/Uui7Rqd/AoGOUXn9T7OumV5NAucmXoIXSnHRaXhDpX3AvodjfEn3
	 QYXWYhwEh7RNhhUBcu/MMDsM2lgnwWr9OstP5HKbsXMRssTHVtcy7RL+lWk+pd9FP8
	 EVtFpVdcvZ14yw1MpzoXF7Ej4iIbSG4pHH9FA+qw1GIMM4IiTDTPVkA9TBun38j1WQ
	 jMPw3k70Gb8CHRG9Zxo1XyhfQZoewWge8JKYdPnj8TIT/uFaf6wLE9voJLw+pG/Z3m
	 Hevey4RzUJKO90wE4R160cgszi9hTBDkE+4qJdWlznsGDig6BIcRhda8g0sxLDhx7Z
	 oiP9ZE8iwekRw==
Message-ID: <9b1e64e4-873d-4743-96c4-0f893e8cc506@kernel.org>
Date: Fri, 27 Nov 2026 13:55:59 +0900
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
Subject: Re: [PATCH v2 1/3] null_blk: reject device size overflow
To: Yingjie Wang <x-professor@outlook.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261126074748.1076774-1-x-professor@outlook.com>
 <20261126074748.1076774-2-x-professor@outlook.com>
 <fa532123-2fcf-4236-90c1-a47d5438502c@kernel.org>
 <20261127024601.1465996-1-x-professor@outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261127024601.1465996-1-x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/26 11:46, Yingjie Wang wrote:
> On 11/26/26 16:56, Damien Le Moal wrote:
>>> Reject sizes above LLONG_MAX / SZ_1M in null_validate_conf(), before
>>
>> Why not ULLONG_MAX / SZ_1M ?
>> Any particular reason?
> 
> ULLONG_MAX / SZ_1M would avoid the wrap, but the block layer cannot
> represent a disk that large. A block device's size in bytes is a loff_t,
> and set_capacity() truncates anything above BLK_DEV_MAX_SECTORS
> (LLONG_MAX >> SECTOR_SHIFT) with a warning. With a ULLONG_MAX / SZ_1M
> limit, null_blk would register a disk smaller than the configured size.
> LLONG_MAX / SZ_1M is the largest size in MiB that fits.

Then compare everything as a number of sectors against BLK_DEV_MAX_SECTORS.
That will avoid using directly LLONG_MAX. BLK_DEV_MAX_SECTORS is ever changed,
the code will still work.


-- 
Damien Le Moal
Western Digital Research
