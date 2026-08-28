Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D3472520
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928960; cv=none; b=POFHhJtncWpi0tCLR6AecOp3UQN/wd+B7+fJ+jL6gxry4JJVgcaoIbJo2SQzspLCiYFVywBWaw7YIq7W02FRC/4hgYpzOJX78JqmHjoKi36o6gzyqE3fyigaH47aa6Ao/FAuScq9G/nTSmJxAV9Frex2TMD1l4+2hg2/9pxoB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928960; c=relaxed/simple;
	bh=Dw2FiA4mmLfH1Z22Wh2fY/8OwNamo0N71MLJCGPpkXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8TIxAGRoaqd61KQ9XXx2EelUK8RrSbQN5aS7cIR7ancbVIWP7Z57M3C2jzAnG32a5Im1PiPgmptiv3hUpxLXeDOtHHer1b41zFhx2JZed9buMgvlR7YsmSgaDp1I7neyBoC0QGid3sGLaOdBlCVvPwcCh2RoGKgudU4cLgxMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EDUkg90q; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EDUkg90q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787928952; x=1788188152;
	bh=V0hb2voKgSJqDmgc2p7cOkarJ7UY6K7MCbTZpq1OfA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EDUkg90q7sYiVD99e5kRcamXugkXAPb7OJCzk3f6XUt8OO4OQkr9khgExN4TPVqGB
	 cJG5cj4F4GqjgZdyg0enFW0VzGhYnZQU/9dk4i+VykNrNgZ3sm2tzGhnKvGaUqZHai
	 +JT6fsMy04hv+GgeZyqlEtXYHmDQRnX4kHYOiFT6AHkd9VcUUN+ilodlmmgQSQTQKH
	 Z/Ntp1lefA88utBtyHfXqoE2ndrsr3+1VxhpegkXKt3jFix4WWyrwLREXT8N1rpE0b
	 rjtqtNDvSJW2eDW5vqAVAz9wUD4y6qFzpnAs6cFilxixubKNblBNdSCs50HQbqC0E8
	 ZIApObSSBRv1A==
X-Pm-Submission-Id: 4hWhK12291z2Scpm
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
In-Reply-To: <87cxv2xwz0.fsf@geanix.com> (Esben Haabendal's message of "Fri,
	28 Aug 2026 12:15:16 +0000")
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
	<20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
	<BAolbDDI0aiCzU2P4vC8Ym-ffhydGSVEvFuW-aVRTvqdzKqwFi53nnr3ps6bh1e6B-ioI-Jh9tKY76dHj6kkrw==@protonmail.internalid>
	<20260819113253.5d602b2d@bootlin.com>
	<rCL-JIGAxmoKXwK9d57EdKhnA4BEacPZQUCiEpnkDXaA3_MBTYj59kYlKla68QKigl2jMCdFsLA_iUgbc0rN_A==@protonmail.internalid>
	<87cxv2xwz0.fsf@geanix.com>
Date: Fri, 28 Aug 2026 16:55:48 +0200
Message-ID: <874igewayz.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Esben Haabendal" <esben@geanix.com> writes:

> "Herve Codina" <herve.codina@bootlin.com> writes:
>
>> Hi Esben,
>>
>> On Mon, 10 Aug 2026 09:19:40 +0200
>> Esben Haabendal <esben@geanix.com> wrote:
>>
>>> The error handling of sn65dsi83_reset_pipe() failure in
>>> sn65dsi83_reset_work() has been a bit strange all the time, missing both
>>> enable_irq() and drm_bridge_exit() in case of failure. But since
>>> sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
>>> not caused any problems.
>>>
>>> As we are going to change sn65dsi83_reset_pipe() to return error values in
>>> case of failure, we need to fix this.
>>>
>>> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>>> index 42b451432bbb..0ccfff401b2a 100644
>>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>>> @@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
>>>
>>>  	/* Reset the pipe */
>>>  	ret = sn65dsi83_reset_pipe(ctx);
>>> -	if (ret) {
>>> +	if (ret)
>>>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
>>> -		return;
>>> -	}
>>> +
>>>  	if (ctx->irq)
>>>  		enable_irq(ctx->irq);
>>>
>>>
>>
>> In this v4, enable_irq() is called even if we cannot reset the pipe. I know that
>> sn65dsi83_reset_pipe() always returns 0 (and this will be change) but we have to
>> take care here.
>>
>> If the pipe cannot be reset, the sn65dsi83 component could be in a state where
>> it can force the interrupt line. This was the reason the irq is disabled
>>   https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/bridge/ti-sn65dsi83.c#L455
>
> Do we agree that this patch series (patch 1 and 2 combined) does not
> change this behavior compared to the current state?
>
> Currently, because sn65dsi83_reset_pipe() always returns 0, we call
> enable_irq() even if we cannot reset the pipe. So I am not changing
> behavior.
>
> I agree, that this might not be the right approach, but it makes more
> sense to me to address that specifically on top of the change in this
> patch, so we can all agree on what we are changing and why.
>
> Can we keep this commit?
>
> Should I add a new patch that makes the change to this series, or is it
> okay to postpone this to later?
>
> Or alternatively, do you want me to drop this patch? And if so, I guess
> we should at least add some comment to the next patch about the behavior
> change that it introduces in sn65dsi83_reset_work().

Scratch that. I will squash the two patches into one, go back to only
calling enable_irq() when sn65dsi83_reset_pipe() succeeds, but ensure
that drm_bridge_exit() is always called. Basically what I had in v3,
which you both (Luca and Herve) seemed fine with.

I try to explain the situation a bit better in the new squashed commit
message. If nothing else, it helped myself understand what was going on :)

Is it okay to send v5 with this or do I have to wait a bit longer?

/Esben
