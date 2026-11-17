Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919556;
	b=4WQY/Y771YeZ607eF7XQDofw9SfleYzStTWWQ4kFKvfWneSTNBaJGd/etoe9Rm+gTiMH
	 8+D0SOCk1xi/IdbP8tZCmKKSpTa+qihAg83phFYftY86NsPuzdCKBgT0pdesVeWGUiDe4
	 w/gP3vScOJrVPFomLpyXEYlg5RmMA8mRNzSDpog/OMajOMCYj4UcFi6L1oaWGc0Fk3FXI
	 MfJfubDL9BeWbAtZ57GmFyZPS4CBaJm6xWLEp9PrY+aOlqqTDGvOcvbIa7Oueqk2nR5Jo
	 PdL82ypeprGEKmnqZyeNz4+F7JyIJCiOvKeKKek9797WLNTHOf9EFCuuFu9vInCAZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wqtnpGUNfBdI2tYwRkteOHEl5pecZGPokpZA5V7JX6w=;
	b=ZjWPeAfma0VSLoc7il+8wUCSG2NlRzJxB11jqBLhdy9E6c40X1QkQmV2arLS8m0jaMlF
	 I06/6UlPImuDiECNipp5ScVwmJgodgYRRJI8tHaINQrgRoW9SBZHHh38Saw3fPuk7c8VM
	 aX419Ucn4tp6C/xJur/EZUBrdC/4PRDN44HrdAH0djDltK9Vpqjm95njgvNdAw6qsUa9N
	 3Wd5HAHVgKgicHd3Uwc70CLrRDGabOpJ0IcJLHLbvIgpb7CaPET1cCcucvZ5OAwZetqdm
	 swMoXba0PmlAzTeSzoSialeItAtMMXvDIS60ODUdP0ALCG7dOA0LCMEHEth0/M3F20g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=neJcPGEj;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AD606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9AD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=neJcPGEj
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a3c08d6928so6412081c88.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794919555; x=1795524355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqtnpGUNfBdI2tYwRkteOHEl5pecZGPokpZA5V7JX6w=;
        b=neJcPGEj0sPqBvoJKx0FchihvGXWnqXwuk/r9RLxrDA5e2Eu73wSyzpsxd6+h3bLdx
         kkHawRT1bwXCIjKe3BEiovXdc2kFCNGY/BPr9SavJrnRwynnSDjOrDw4yzstwrbfI/ed
         V/hZpFpVnkOpXBU2qJx6LidBE0hmbB5NCLK5tahKbNfsLXC7sEPFyyAS8Ba5sOTxJxdP
         xCvdgfMbPCH6EbT//m12Zy0j+nv2ZYV+LzHiGWKO14OKP1hlWTN5JUf17PMu+8rkJrCl
         LVyoOURtaIt5wBAQ3Th5TFPwVChoq04yZSVc7A2uFjHF6QOavGJfkxN24pa/I9nyVdp5
         tGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919555; x=1795524355;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wqtnpGUNfBdI2tYwRkteOHEl5pecZGPokpZA5V7JX6w=;
        b=21P2+eQN1tlC2bSGTab8XNb0vIUxtxMTgXPsyOj3GsfchQsftkdlu938XbBeCeest5
         UEAe/go6fho6TmPovLhYkPnH+alIxENa2yajHQrX2Ad1lfdyfXl5QV11co5Z1NqcWjDF
         /4AaWiBt+ZZH6QiPs1t6F/HIQsLhahBqMxDeIGyWFHmXn5HcTrO9x3HWbr5YC39muhh5
         wA5USv9LrihMOnTGicP1qpUwmROH1oJ2Qh6D1DsNKcVZdK+KA9ocH8AVEoaTWk4kRjUZ
         A2P+98HPAuL11ihgKZPe/ybK8pcDeNv5L9oRGey+aOGo1+RuKWb1UCxI5fWPJx9ILmpc
         sp3A==
X-Forwarded-Encrypted: i=1; AL+hErEbDmFFuTooLx8lvKcsVSYUhp1hgRNkAPr4SrHQ2UgLuKzwwM6CZA+wee4RbxKVJSGMMtdfsBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UMSaTgVWsTK2B7qzbRVmEFM2WzsIZz6NA9FTUnQfCbqZH/eue
	KYeyKMYEPll4RPPWjxiAxRBOODO2JnMSVAAL6Lnq1Y6Z2hicmA7WRsEpOVn6PSBAZpw=
X-Gm-Gg: AYBFou3NKzrKmnVDK0ExB30tdROvy9Rk4LdY/xHMyXtCXL5OVxQP6PBMuSP3KhwwAly
	AugXGMl7rlpvVvC7NXXnH/715SWPXRtum4Tu8zdgRAN1hli0lM1R/QHePAE1U0yspp8iEaWO/hX
	oAss9h1yTczXh8cifUzxn1W2guITcHyP5+R1Z8uWim5at83M/iHGiNWS/H2O5dPROmn9uPoGjs0
	tI6pGx+7BfNbZlznf4a5mJe3fdCUQFz9/kA9r+hOYT7+wq7DQKqn+/1zshI2EZ81fchGTeRSUeL
	kUqK90SdjkiMTTsPGmADtObFO6ZjvlfyLtdxxrG56fUb1igmvpUOqNBKoScPG0KEwW062rhPzJf
	xacl6DTj8Ty/KY26waFz+OJsvdGPk8XrzvWjZN7SQ5zS+GCHTw60VN2EWukeYB9OSBnjZWf1pQI
	Bq0Msfx03xFGDr8kVup0GlAwXs0Y6+JiGda2X9CJ3WA6vexfcmk2gGf6I22rnPJcT9kAj0+rUyH
	+bY21Jqsgciz5Bx+zit2dcZdO+8vgxnmSfhkHtbAXZBlxjLx3HYJzn9pAaCU2GPiXt4R6X1Ocbn
	rWKsKcuwBrHT0cRLtBm1iPGLLHLNZss0ANB7gWEw+rYbayCj+0rPU5bXNHSNPkQ0Gl2/fZSLEqT
	7LwIfo0GI/7B9jpt6I6oKbpcMTWSspxwL/AGQuazapNA1AM/g
X-Received: by 2002:a05:701b:455b:10b0:1b2:4b42:1870 with SMTP id a92af1059eb24-1b5030eb0cdmr12758685c88.31.1794919554771;
        Tue, 17 Nov 2026 04:45:54 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm37302905c88.7.2026.11.17.04.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 04:45:54 -0800 (PST)
Message-ID: <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk>
Date: Tue, 17 Nov 2026 05:45:53 -0700
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
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk> <avxLtZ2YLHdbeZxC@laps>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <avxLtZ2YLHdbeZxC@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 5:42 AM, Sasha Levin wrote:
> On Mon, Nov 16, 2026 at 07:21:38PM -0700, Jens Axboe wrote:
>> On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
>>> On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
>>>> On 11/14/26 10:42 AM, Sasha Levin wrote:
>>>>> On 2026-11-13, dev@rebasedinc.com wrote:
>>>>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
>>>>>
>>>>> Queued for 6.18 and 6.12, thanks.
>>>>
>>>> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
>>>> Getting a little tired of chasing these.
>>>
>>> Now rejected, sorry about that.
>>
>> Not sure how we improve on that, it's really annoying to catch these bogus
>> ones after the fact?
> 
> Hi Jens,
> 
> Since some of our reviews are LLM based, I was looking to see why this one was
> flagged as a security issue.
> 
> From the explanation, and looking at the code, it seems that we can register an
> eventfd with io_uring, then have epoll watch that same eventfd. When something
> wakes the epoll, the kernel is holding epoll's wait-queue lock. That wakeup
> runs io_uring's poll handler, which signals the eventfd, but the eventfd is
> watched by the same epoll, so it tries to grab that same lock again on the same
> CPU. The CPU spins forever on a lock it already holds. One core is dead,
> followed by RCU stalls, machine wedges. Any unprivileged user with io_uring
> access can do it.

I think you're looking at the parent of that, not the followup. Yes the
parent is a real fix, it's similar to the eventfd fix in mainline as well
for that exact issue.

-- 
Jens Axboe

