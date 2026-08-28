Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDF3D3D10
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919337; cv=none; b=L0zRNHKC+juW6h5lMdAjuuLV03UwOz7c76mKCr+7MNdboPRgHO7mcAljWYwWffzRkz9VwJa7Eg3OBHpN3zA1X1ZZyyR72G+B0mLJUm6S/32rIUa/F1s1Srgnz8PmqJoNQeNspx0y85zwIs95+YoX49RKGRqg0SvLmD64Q7rm2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919337; c=relaxed/simple;
	bh=vcByxpE39A/RXZndYAY1qXdtm5GityOgD5yynVi4hq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BkELkOVJCoMEl23Hm4nvjmgsIIjLbMbbd6LouS6OiOa9TGm1LXCUSoZiNldbjkMsy0IHHggYmlhXp/3NJmLGLlfsUV5t1HK8LC9c7v3CzbtWtVQBzJ9Unpi4LPUSxb5sacy7G2eM7Qbw4yfZ6ZWq+Y7obC6+HFoDngZ3L/d0HCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=N8BpTQrt; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="N8BpTQrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787919318; x=1788178518;
	bh=4aETwO+HWa6/9prvfd6xAdoS7kNHmevdV5KhT0yiN/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N8BpTQrtoWGBF31g1eZt384TBlYg/vRBHP0CUdPtwRyxmjatZ+lfpd9jzJZpE/f4O
	 Pdj7tyiLD7XAun20b1OoY7HhBK5Xt0nXVk1deAAYYFsrQfzTzMAOGdrfMGfrUf5CgE
	 pe04hdbAc1nEYRm64LeLOpVnow9K8CQnipLsX19HUtlRQXbs0oWB+s/jgoE1RbU67F
	 jdF8VahKFzaFjPSZ/l6mCFQr2iOPTR5SUeoiHxdWDSIUX4xNEhcLCZ7UAuHXvYgPgh
	 1dC5PL2RykTjy8F++0E4IIpldzVIApDtfJ3J/NKJTSrWt+vmPz1GOdlaeVviZXUAOz
	 /dJdAG378Gx5g==
X-Pm-Submission-Id: 4hWclm1vQYz2ScP2
From: Esben Haabendal <esben@geanix.com>
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: "Luca Ceresoli" <luca.ceresoli@bootlin.com>,  "Andrzej Hajda"
 <andrzej.hajda@intel.com>,  "Neil Armstrong" <neil.armstrong@linaro.org>,
  "Robert Foss" <rfoss@kernel.org>,  "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman" <jonas@kwiboo.se>,
  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,  "Linus
 Walleij" <linusw@kernel.org>,  "Frieder Schrempf"
 <frieder.schrempf@kontron.de>,  "Marek Vasut" <marex@denx.de>,
  <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
In-Reply-To: <20260819113253.5d602b2d@bootlin.com> (Herve Codina's message of
	"Wed, 19 Aug 2026 11:32:53 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
	<20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
	<BAolbDDI0aiCzU2P4vC8Ym-ffhydGSVEvFuW-aVRTvqdzKqwFi53nnr3ps6bh1e6B-ioI-Jh9tKY76dHj6kkrw==@protonmail.internalid>
	<20260819113253.5d602b2d@bootlin.com>
Date: Fri, 28 Aug 2026 14:15:15 +0200
Message-ID: <87cxv2xwz0.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Herve Codina" <herve.codina@bootlin.com> writes:

> Hi Esben,
>
> On Mon, 10 Aug 2026 09:19:40 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> The error handling of sn65dsi83_reset_pipe() failure in
>> sn65dsi83_reset_work() has been a bit strange all the time, missing both
>> enable_irq() and drm_bridge_exit() in case of failure. But since
>> sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
>> not caused any problems.
>>
>> As we are going to change sn65dsi83_reset_pipe() to return error values in
>> case of failure, we need to fix this.
>>
>> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> index 42b451432bbb..0ccfff401b2a 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> @@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
>>
>>  	/* Reset the pipe */
>>  	ret = sn65dsi83_reset_pipe(ctx);
>> -	if (ret) {
>> +	if (ret)
>>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
>> -		return;
>> -	}
>> +
>>  	if (ctx->irq)
>>  		enable_irq(ctx->irq);
>>
>>
>
> In this v4, enable_irq() is called even if we cannot reset the pipe. I know that
> sn65dsi83_reset_pipe() always returns 0 (and this will be change) but we have to
> take care here.
>
> If the pipe cannot be reset, the sn65dsi83 component could be in a state where
> it can force the interrupt line. This was the reason the irq is disabled
>   https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/bridge/ti-sn65dsi83.c#L455

Do we agree that this patch series (patch 1 and 2 combined) does not
change this behavior compared to the current state?

Currently, because sn65dsi83_reset_pipe() always returns 0, we call
enable_irq() even if we cannot reset the pipe. So I am not changing
behavior.

I agree, that this might not be the right approach, but it makes more
sense to me to address that specifically on top of the change in this
patch, so we can all agree on what we are changing and why.

Can we keep this commit?

Should I add a new patch that makes the change to this series, or is it
okay to postpone this to later?

Or alternatively, do you want me to drop this patch? And if so, I guess
we should at least add some comment to the next patch about the behavior
change that it introduces in sn65dsi83_reset_work().

/Esben
