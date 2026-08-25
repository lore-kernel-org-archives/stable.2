Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30438DC7B;
	Tue, 25 Aug 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648507; cv=none; b=pQ8L+IUanEO+T7oTWc4Bwt8mKULlVheCf0K86Vw/eLUuyKVwI/3LglJYzPbe4as4UrgcJXk6pZ1/DmeyezwTYXzxpB93uFjPSGJdanxPfLSI/HhsjlCNwFI28B90W/lXcur3NtbZfy//u3hM54Sgd7q3pgvKNz7soxlgxXBRN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648507; c=relaxed/simple;
	bh=XotsZz9x/rxWLRI0SYvqB0Io5awIEnupWlJiP4m0LZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHuRFU7KOQZg7+BQi++EE36LFq7CNTSBIbeqof7gcAA5mRlH2eVgt6wvD/1zCnLhRhJMjfhcm0uFjVRzz5FVlwD++bQ6qA5kgxy3wI0oo7M1vKvPGBnSvNL7mz/7WTy8Ni5GclnxLtHEcet+mtgWh96laiW00XQJdSS5919gqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=D44ofn27; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="D44ofn27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787648503; x=1787907703;
	bh=/nP18Hx0tRTE63n07f6nEormlZZuADgFGbIvgxd/UIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D44ofn27juLRVWR8xgNLgZb2c1JvlMBnRfURDXaBrx3c9c7xXIAL8GGcGUCYx+XbQ
	 AKVcRURSarvaoYdn6o0NtNkMZzVmv3sp/dGsPzUXiMeEMuggPQhWcCV82BCGW4nAIy
	 NU/dqR9e0vZ0sUdW46hiodgMxGpDnyYmeVoYMVMg00FVfy/HQUc0gy8ooD6eV4qAZM
	 OhH8hgbdKyYuD59TFjKTrMjoL7KPaTlLbWp9TLkNvnKghgEX1NnyB/zKD0qr6O6ul+
	 Uxk6jj5QkcQKHEexDCx8D6lCyFfCCCDi3YdfAjvHf92MCIDXY5SuB1L4XHhGsCfItG
	 lRc8e8zthxPlg==
X-Pm-Submission-Id: 4hThbm54v1z1DDX8
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
Date: Tue, 25 Aug 2026 11:01:39 +0200
Message-ID: <87o6eqo9os.fsf@geanix.com>
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

Ok. But maybe take it in two steps.

The change here, together with the change that makes
sn65dsi83_reset_pipe() return non-zero on error, should ensure that
behavior is unchanged. As long as sn65dsi83_reset_pipe() was always
returning 0, we have been calling enable_irq() even if the pipe cannot
be reset.

If that is a problem, I think it is fair to do that as a separate
change. As you say, we have to take care here.

If we leave the irq disabled when sn65dsi83_reset_pipe() fails, do we
simply want to leave the device with irq permanently disabled, or should
we add some additional logic to sn65dsi83_handle_errors() so that we
will try to recover periodically via sn65dsi83_monitor_work()?

I think this is tricky enough to warrant a new patch series.

/Esben
