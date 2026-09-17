Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D73537E8;
	Thu, 17 Sep 2026 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614351; cv=none; b=Pfn2v734FU8JKiGh9zONuPcrIvycfFoA9CVosiwJiu+LAvls+x01OQb8QnvKBxwPM09Qv7fsNGRJr2Ecjk177GkzQjvZOSWDtGMII6X7AN72iXH571395kJLRnOF/RkyQfVs2BYL0rZQNmLnraTRrbBA5rHWrt3C/AMHeZvVQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614351; c=relaxed/simple;
	bh=jbeJzO5n6sJ+4m6lQ6TLwCWBTO8CHq1Cqr1AMsCx2gA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiE07oX7jB8XqBbkeNTrS3QUCNHYNmtlcetjnZFhmT5CQOvZByzcGRarD+4D+gBFa/TCklWMoel/V9e4RIlQw6lBokl5VPDMbZ+CVnvrYaPp+2hD2ZJDP0drqlDiFevunpwn9YrU8ULLeH9pEbgih9kGQd6Phsq9aMn90PdI41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHwLeRuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHwLeRuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CDC1F000FF;
	Thu, 17 Sep 2026 03:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614349;
	bh=2+fkdTQ/raiQYYgRa0ZJ6r63NemGLRl+TLMgLDDs6kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cHwLeRuf+DBvtxC2r8ep2LEUMeLo4YmU9Q0niZxQDIMKgqg10gGnJYw5gXAU8ccK6
	 uGyVD3wQBOgEV2qqlDt0xxpIV1GKyoGXvN6bUJkTwzwU5PNjtjz4dtOQcvxc801sZD
	 UslVq3XQkMf3ZtpV4gyZHxuoq9uG6Cog7wO+az+Hs5osOqPP7nDXTJ1eGg5rSymnhU
	 Dpx4KctxiTi/HvqDKifzlyzub2hCCPq58NYCJzXPyCjx8WH5VypTJ25H8wbOLwsNDx
	 LFozJmry93FNrDJulMsKglYNiD63OB5Qjr316rgQZ46/Fcn5zFZrAMBcTL9mUyRDJQ
	 di24YFyeH1o5A==
Date: Thu, 17 Sep 2026 04:05:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Matti Vaittinen <mazziesaccount@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Message-ID: <20260917040542.2600a7af@jic23-hlaptop>
In-Reply-To: <20260914144920.00002f7b@gmail.com>
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
	<20260914144920.00002f7b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:49:20 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 14 Sep 2026 19:20:53 +0800
> Guangshuo Li <lgs201920130244@gmail.com> wrote:
> 
> ...
> 
> > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > path.
> >
> > This issue was found by manual code inspection.
> >  
> 
> I'm on the fence whether this sentence should go under the ---
In this world of LLMs I'm going to stick up for human effort and
keep that in the commit message :)

Either would have been fine with me.

I'm not going to rush this one in, so applied to the testing branch of
iio.git

Thanks,

Jonathan

>  
> ...
> 
> > @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> >    
> 
> It would've been better if you sent the 4 patches as a series with a cover
> letter as all of them are the same fix.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

