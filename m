Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F40D578
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397036; cv=none; b=dkrapDppqxDgzZg+affRBu8pRvHoaCA17tt4G4a6iFbL2QYTcc0ZWcJWqAdupYTFuU5wZCTVr91choOjAtopY8zfCm/EnAPkZe/BHvAjts07wwyBtuEISq19QgqM96948SyZn4+sjA27AXqpPEAb2LQYHfmFmTOzKgqLg6GY+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397036; c=relaxed/simple;
	bh=8h6Gwx5AwUCsw0Rbel0Q1oDUGoOYHJ3M7pzMbq8BSk0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpkkdJHuYcWYIekgkATu+Tko9fGeg2zw1TI1qxsmCi157mFCF1szSMY+x++nBPrdcBF2fmHkR66GK4BaneHEvT84EE1lhQWvhlEXbIIsUBj2aXocHYSgc9kHd7gG0iKb87Wr2HYdx8331D2W7PRIaJFyZR7XhOelH9tJUX3TN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA9pbYry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA9pbYry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCE41F000C5
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397034;
	bh=432hnMFFtUhI4FrERk0Xh3wkIg0S682QS2zkowiC/lg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aA9pbYryehjYw0DEq/q0bW0Jp8WU/IlMnecndGyLZPqL+UiOKYjqh04ER78PypWD0
	 uwyq8WYwo6jv7YBIBNbhSisjUlF5YUsk5NgNii/fT9ED713B4ps/IzU+pkNw/u6qhe
	 YCnb9L1FDE4FrpA7jy2TZ3khMVc5xZdUHEmy3cdAtH3rocLgoodKYXK4Ht/lkadAVE
	 Nbykw8BD+tU4tWWe+nla/Ghy/sy+fP+1Hc74iTorFGLGeNv2o3VXvtomk/lQ3ZVtUS
	 kaXL2nSO6Si3dBFxR+Xb3Eo8gN8C3/ERf/trNVx7sx/YDSV/fwn2pvXser8NOoS84o
	 mC+z1keryfwmg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a9787a156eso12810661fa.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:03:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuBP4Ow8C1B7xZoFNVInSKRa0Hw2HJJdwBtYDthLD6C/A4Kh9LS8qYiXyJ7XoG/F2ob9jqlIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyTEBKNRuo5eW97kh96KyoNSiRpXgE/dynLVb4U7+C/Y+My2AV
	SxkIPuTYlEe7uizZXQsY7Nb/E3t+h0qIzb3JLYgaC/UQqyVa2wMYKF0Fyxc0dF7o9CyebhHVeel
	Y8k91ugm56MQK+O2Tl4hwf80rJ3Gus0K+HvKR9nwipA==
X-Received: by 2002:a05:651c:4208:b0:3aa:f72e:8ee8 with SMTP id
 38308e7fff4ca-3ab2927d2admr13570991fa.6.1792397032907; Mon, 19 Oct 2026
 01:03:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:03:51 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:03:51 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261016115009.GA111978@rigel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-gpiolib-cdev-direction-v2-1-aambrozewicz@nvidia.com> <20261016115009.GA111978@rigel>
Date: Mon, 19 Oct 2026 04:03:51 -0400
X-Gmail-Original-Message-ID: <CAMRc=MeDpODJCEst-T1wgOu=MA5v5zVL1WXJUjOYW=sLdc2usA@mail.gmail.com>
X-Gm-Features: AclHuK8VxD4Z_6Z6OuAzqsywQwW9p8T1pUJDAZ4jAPP0jrXs_tSb35EG2zXRV9g
Message-ID: <CAMRc=MeDpODJCEst-T1wgOu=MA5v5zVL1WXJUjOYW=sLdc2usA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 13:50:09 +0200, Kent Gibson <warthog618@gmail.com> said:
> On Fri, Oct 16, 2026 at 12:22:58PM +0300, Adrian Ambrozewicz wrote:
>> When a line is requested or reconfigured through the v2 uAPI,
>> gpio_v2_line_config_flags_to_desc_flags() copies the requested
>> configuration into the descriptor flags, GPIOD_FLAG_IS_OUT included,
>> before gpiod_direction_input_nonotify() or
>> gpiod_direction_output_nonotify() asks the driver for the direction.
>> If the driver refuses, for instance with -EOPNOTSUPP from
>> .direction_input() for a line that can only be an output, the ioctl
>> fails but the flag keeps the refused direction. gpiod_free_commit()
>> does not touch GPIOD_FLAG_IS_OUT, so this outlives the failed request,
>> and GPIO_V2_GET_LINEINFO_IOCTL reports the line as an input while the
>> hardware still drives it, until a request without direction flags
>> makes gpiod_request_commit() read the direction back from the driver:
>>
>>   GPIO_V2_GET_LINE_IOCTL, line 0, input:         -EOPNOTSUPP
>>   GPIO_V2_GET_LINEINFO_IOCTL, line 0:            input
>>   GPIO_V2_GET_LINE_IOCTL, line 0, no direction:  ok
>>   GPIO_V2_GET_LINEINFO_IOCTL, line 0:            output
>>
>> GPIO_V2_LINE_SET_CONFIG_IOCTL updates the flags in the same order.
>> There the line stays requested, and since commit 92ac7de3175e
>> ("gpiolib: don't allow setting values on input lines")
>> GPIO_V2_LINE_SET_VALUES_IOCTL on it then fails with -EPERM, though the
>> line is still an output. A line whose driver refuses to make it an
>> output is likewise reported as one.
>>
>> gpiod_direction_input_nonotify() and gpiod_direction_output_nonotify()
>> set or clear GPIOD_FLAG_IS_OUT themselves once the driver has accepted
>> the direction, emulated open drain and open source included, and
>> nothing between the copy and those calls reads the flag. Leave it to
>> them, as the v1 uAPI already does.
>>
>> The other flags that the helper copies stay as they are. Active low,
>> drive and bias are what gpiod_direction_*() applies, drive and bias
>> possibly before the driver refuses the direction; edges and event
>> clock are the character device's own. None of them is read back from
>> the driver, so there is no earlier state that is more accurate to go
>> back to. A failed request releases the line, which clears them, and a
>> failed reconfiguration leaves the line, like the lines before it, with
>> what was applied up to the failure.
>>
>> Reproduced under QEMU with a test GPIO chip whose line 0 refuses input
>> and line 1 refuses output: both refused requests and both refused
>> reconfigurations leave the line info with the refused direction, and
>> setting the value of the reconfigured output fails with -EPERM. With
>> this change the line info shows the direction of the hardware in all
>> four cases and setting the value works. First seen on real hardware
>> with v6.12.
>>
>> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
>
> That is an incredibly verbose commit comment, particularly the
> discussion of error rollback behaviour, or lack thereof.
> This probably isn't the place for it, but I'll leave that for others to judge.
>
> I'm definitely ok with the code change.
>
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
>

Yeah, I would have loved it to be a bit shorter too. Is this an LLM that
generated it? Anyway, I'll queue this for now but please try to make it more
brief and to the point next time.

Bart
