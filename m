Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23F4756C4
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584292; cv=none; b=KAfoH59csSOdwpvTLQvsKUTJv6s4TUxILcLpVtL6nTHIqQ1vhlIk0G9c9mtUllk0xveygu7SKI4wjrCh64SrtH6wHlCqimF7xZBNr/pZjfX6ae4ZzZdjzfXMDi63bHtPB4MglH5M9j14ndWFzHJPSdWhpS30OgnHebzsIcjujUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584292; c=relaxed/simple;
	bh=MuqpoHduVduL/y0wnBWdGHkHHicM70MFPxT5bKmE1Us=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzHuzyOUXyX4ULr/d5lFV8JJLbQLMOKDTCbyY5Y1m/nFmBQPyz0YzyYBpWPtgC1RacKVu9B7OFX/35RUXB5XhKYQ4x7h59ynJ3yW4yi80MiMsHOLS4wPrXxqkHIKkozeAd5uWQLAi9vkUumUJZPS1CrnexbsE/+C0iiLyIA1xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdOItFxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdOItFxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012871F0089D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584291;
	bh=MuqpoHduVduL/y0wnBWdGHkHHicM70MFPxT5bKmE1Us=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WdOItFxAVAnzGluXvaDDPCqN97XLfPMl6A4YDyzTSNHzz1xZ0O9nipQg6bqWldVC/
	 bL5P14/A+KpZRX6/6d7cfBu+8IQFHbklBnqpXAhUhYWlJ4eIq3TLtRtOeuTktBrmdN
	 aFOKcRw4xro1MwdgAj8WWPyzfjwtc6k87zPYO3UJOKiEYK4kNkcaiBMTIitBS5Fut1
	 NebZzxCskzK8/PUepB1K4qmKLNbteeJzIedfndeLsC2nKSc7m9PkIj0IMaCwAs9yVU
	 Ta2Pu0+eLOSVAFCdkb180/qey6U3G3M3sTybDecgX7XFbT4p0f3+BSR5cvMZ1Lr4Vq
	 z8fkqXxbr90Lw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2381150e87.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzSTU5JcjFVLl2Dqpxk0zJAGl1afYjxporP5T7wcCBJDlPcBA7iBAzjbVu2fVudrDa2DR9HVuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkGneotPCOlsfIcaAx203I20Yr19TmGFV01qlY2Y2umGg8Z8DT
	yv3cW5FY0a8/0cBzSwK1H5MxyBd2M57x/VrH4eh8KTwq1Ifs0Brqv7t2fK0TROORiquuKRyIQSc
	ag8ihlskZXeit9UJ2zsDg/Q4ZMdPFv2uA7ggT4NWi3A==
X-Received: by 2002:a05:6512:3046:b0:5b8:c311:88e8 with SMTP id
 2adb3069b0e04-5b8df1e6cf2mr3720055e87.26.1790584289662; Mon, 28 Sep 2026
 01:31:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 01:31:28 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 01:31:28 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260925193008.127314-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923184450.135601-1-2000.costalucas@gmail.com> <20260925193008.127314-1-2000.costalucas@gmail.com>
Date: Mon, 28 Sep 2026 01:31:28 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me3iGe9bxAM2Ph=kBU8PAvRZxq16NHk3FSKsp3EafhbdQ@mail.gmail.com>
X-Gm-Features: AclHuK80sCVvVAPH0hKzq8SMRPB_tS6-QZBjVGjDspI-Uie2oIgZKXJbO_KiA9A
Message-ID: <CAMRc=Me3iGe9bxAM2Ph=kBU8PAvRZxq16NHk3FSKsp3EafhbdQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-spi@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Sep 2026 21:30:08 +0200, Lucas Costa
<2000.costalucas@gmail.com> said:
> of_find_compatible_node() returns a device_node with its reference count
> incremented, but bcm2835_spi_setup() only uses the return value to test
> for a matching node in the loop and never releases it.
>
> Declare the node with a scope-based __free(device_node) cleanup so the
> reference is dropped automatically when leaving the loop body, matching
> the existing __free(kfree) usage in the same function.
>
> Fixes: e19c1272c80a ("spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> ---

As Mark said: don't send new versions in response to older versions.

In any case:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
