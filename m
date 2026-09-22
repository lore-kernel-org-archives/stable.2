Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905C542ED7;
	Tue, 22 Sep 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080674; cv=none; b=YIjvTGPJCapI8vRlKzzE9P/dRFOqKEg2okQ0XHj/sNydX5wXswswvVbz+mp9FwJTpKrhREM2ejMM/Cl2xnPRndTwOL1MMHQQ1yeEsEcbp8hcIjuFgSDY+50E7BFYn5H+u4vy7TggiwETm4f/8kKTZNIZ6RgNd/IFxKyD6vl6emg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080674; c=relaxed/simple;
	bh=qpH70Ol2PLcpHcJUGLjjtYPQ6X6/O8lEkD4UOR0MP9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC22uyQurqYSLTahWjOgSbvO55AgJrBbgBVrDhvf/xN7voO7RvmRXjsxtMIaOEoKSjWIsq65i++yQecqI1zfbSpMipL9/REV3jE4RR8N4HBtRnHaDY2x2DWBY5DuZrw/5tHwz3yC6bNGgaaKb+btEYAB11pbVW3DFwQ1ghJsZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXsWUg04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXsWUg04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA301F000FF;
	Tue, 22 Sep 2026 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080669;
	bh=gOSG/yajQNGAcixw1vxtLBXUegoQ/DA0N/CktIU9fKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXsWUg04m9IIALUKHl255CWLOXU0UMu4Bu8rY2wX83V3RqeE1XYM/9V5IGKj3+n7j
	 VZlCQrIA953RRa/kUsGy4XTS382mkRrVzcXVVxxgI3T8o1l5a+68Wlbl5oCyHX8/gK
	 KhrlgbfKYtPR4WffFnvqqvtGiBlheX2j6GCdy8S8TDwwdpdLY5TlfrAELwH40mKjyx
	 PgQledWl9PnePUdE+G0EOEH38ser8uq6E94NORXkFx8NqU6LRJUrcGjOf+VIjLXWxW
	 IK4T+4At/eNtMR1L4V9ZlVImGrl29k4aBCEeNKbs2SJ36E6vYVka4TKw2NDTqUN8TP
	 cgQYc81NFq/rA==
Date: Tue, 22 Sep 2026 13:37:45 +0100
From: Lee Jones <lee@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jan-Simon Moeller <jansimon.moeller@gmx.de>,
	Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: Remove sysfs group on allocation failure
Message-ID: <20260922123745.GF3277918@google.com>
References: <20260915020600.91955-1-mhun512@gmail.com>
 <20260922123713.GE3277918@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922123713.GE3277918@google.com>

On Tue, 22 Sep 2026, Lee Jones wrote:

> On Mon, 14 Sep 2026, Myeonghun Pak wrote:
> 
> > register_multicolor() returns on allocation failure without removing the
> > sysfs group created by blinkm_probe(). Remove it on this path, matching
> > the helper's existing LED registration error cleanup.
> > 
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> > 
> > Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/leds/leds-blinkm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > --- a/drivers/leds/leds-blinkm.c
> > +++ b/drivers/leds/leds-blinkm.c
> > @@ -691,8 +691,10 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
> >  
> >  	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
> >  					GFP_KERNEL);
> > -	if (!mc_led_info)
> > +	if (!mc_led_info) {
> > +		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> 
> If 'blinkm_group' was created in blinkm_probe(), shouldn't it be cleaned up in
> the error path of 'blinkm_probe()' rather than here in the callee?

Same with register_separate_colors() failure, no?

> 
> >  		return -ENOMEM;
> > +	}
> >  
> >  	mc_led_info[RED].color_index = LED_COLOR_ID_RED;
> >  	mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
> 
> -- 
> Lee Jones

-- 
Lee Jones
