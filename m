Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559500;
	b=Grm2M9R7XY6QtssXs6T/ruevumDSpNUH1oNulr7gZB7b2myz1jfTBoOsKRoA/4bKOrPM
	 S3Xzh/HryTdZzFUoTUIL2oFyavYudFiMwkKjn6VSKrywaCp+OikC/PS6MOTwi4ypNNJLF
	 6KUg0bHSgAS9DUfCg1JNgoWhG2V+3vanBbsY0K+0QFarrEku2jcDwyJOk1o69VGCgX2kL
	 vAsPmImrIcoxCiCBF96TUTm6xEJxeKyltM8Q1bJyJaKYKhAsHxjKlUdkP2nBX2lrmUT+s
	 80RyceHQdiUOgXC4u4EVQdUbRPmMRVRLIwT58+fF48K9PfU6MhngebQwSv8yKyMdajQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559500;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ILcS6bN6z3SIzwRf1ayUd7W9PQmsIX6xKOxhAQ3Yemo=;
	b=S/ZI9bj63D7IU8clkb8yfjAGbqfqMpfsUzYzEtJj64uplL+g+akNGGIrcjKqPToGriwH
	 Qg925vS2UeKyFAXXd6KrpPDQ+iN5utMHFOD1eQBxLQCv79CD5/RfsMXG7RndcpFW+p/Bb
	 wGM6yllY69fLXmP+hxAAwUEbkDOsHmVCkg8TF2TURBdzo0oywdwB4qubxRlIm0byOGrEd
	 433FsOZAjXD4lZAjcG0X4zyf7WdvESMAbjtl7/tZKTkMGtsOfDEYef3DYhDfXgLAR+kwA
	 4XtQHnv0B+WhwHBr0rCkj1VypTjcTbevsy8VwP6StupGAaP5ufpLJU8+YeaYwxhsTFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCkAmQpP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340860A5BC3;
	Fri, 13 Nov 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCkAmQpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8B81F00929;
	Fri, 13 Nov 2026 08:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559499;
	bh=ILcS6bN6z3SIzwRf1ayUd7W9PQmsIX6xKOxhAQ3Yemo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=DCkAmQpPKuaaOBoo8rnCvE3d8lHoXC7DHM4MAf1MsKG2Wxk64DB3VQGd57oIWsIRP
	 YGVC5qwfSIopx7rgs65XHLSvQdviFfAQu2xHxujiIaD8qOheSDazbZFbIaBWnucf2y
	 681ekR26P7PZTpYvu7y4U5jODksJP5W2I/6uteAI9A8lqe4OFXBsPf45fijgtUmiJq
	 WbV0eT1J8p5CILJJHuch/Mj4Ta1khZyC76Xfp8689eybzFxoEYy20L83gpSUF1bzNF
	 SqjCegxaJDH1wWhm3cqsQ9DPi1sbnzjhibHa5ZmIZBoWOaJHu5XoaeIqV2ydaspWaU
	 xabzSAlQpZv9w==
Message-ID: <717863c4-4654-493d-821e-a7bdda0a3453@kernel.org>
Date: Fri, 13 Nov 2026 09:44:55 +0100
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
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
 <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
 <5b3592b1-74b4-43e6-96e8-a600b6fa991c@pengutronix.de>
 <17cb2a11-9c9d-43c9-889e-8581522c7a74@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <17cb2a11-9c9d-43c9-889e-8581522c7a74@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 15:18, Dmitry Osipenko wrote:
> On 10/16/26 14:06, Sascha Hauer wrote:
>> Hi Dmitry,
>>
>> On 2026-10-07 14:20, Dmitry Osipenko wrote:
>>> On 10/5/26 16:28, Sascha Hauer wrote:
>>>> @@ -2792,16 +2807,13 @@ static void hdmirx_remove(struct platform_device *pdev)
>>>>   	hdmirx_disable_irq(dev);
>>>>   
>>>>   	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
>>>> -	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
>>>>   	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
>>>>   
>>>> -	/* touched by hdmirx_disable()->hdmirx_plugout() */
>>>> -	hdmirx_dev->rgb_range = NULL;
>>>> -	hdmirx_dev->content_type = NULL;
>>>> -
>>>>   	hdmirx_disable(dev);
>>>>   
>>>>   	reset_control_bulk_assert(HDMIRX_NUM_RST, hdmirx_dev->resets);
>>>> +
>>>> +	v4l2_device_put(&hdmirx_dev->v4l2_dev);
>>>>   }
>>>
>>> This is uncommon v4l driver removal pattern, I suspect it's either not
>>> correct or needs to be fixed in the core code.
>>
>> The pattern looks uncommon because many drivers in the tree are affected
>> by the same issue ;)
>>
>> Just like many other drivers the hdmirx embeds a struct v4l2_device in
>> its private data struct which is allocated with devm_*, thus freed
>> during driver removal. With an opened file descriptor the video_device
>> outlives the driver removal, and v4l2_release(), called on
>> the last file descriptors close then references the already freed memory
>> via vdev->v4l2_dev
>>
>> This is a long standing problem. See [1] for example for an attempt to
>> fix it in the core. It seems consencsus at that time was that it must be
>> fixed in the drivers which is what this patch does for the hdmirx.
>>
>> [1] https://lore.kernel.org/all/20240610100530.1107771-1-sakari.ailus@linux.intel.com/
>>
>>>
>>> What is the user-visible or sanitizer-visible problem? How to reproduce it?
>>
>> It can be reproduced with Kasan on affected drivers, below on the hdmirx
>> driver, but it should be reproducible like this on hantro and others as
>> well.
>> ...
> Thanks, the patches are good to me (tested on 5b with no problems found) 
> apart from this one that feels like it's not a proper solution.
> 
> Will be good to have input from the v4l core maintainers, or have this 
> fix made separately from the series to not hold rest of the patches.
> 

There are two possible options a driver can use: if the driver has just a single
video device that it registers, then it can use the release callback of the
video_device to do the cleanup. If there are multiple video_device structs, then
the release callback of v4l2_device can be used.

Using the release callback of v4l2_device is the more generic option, so this
is fine.

Many older v4l2 drivers do this wrong, mostly due to a poor understanding of
how this worked among media developers at the time.

In any case, I'll take this patch. It's good.

Regards,

	Hans
