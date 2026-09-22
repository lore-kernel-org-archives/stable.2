Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5454489D;
	Tue, 22 Sep 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080858; cv=none; b=URNoXFqdT7yEsoAyJa1BnAM0jQxn4wstmpRmkT/efIV2s2PV5jpdZ3VV/y5oOnTT41CFRd5pZSZFsRIzjCiUvaVg2UB1oPvQ9gTWFmikEoLSJQyvwu9qEA2WFP6BwomE450FhZZHdckKS+F/1OyOsamtRqOgFoi+1FFchYnoaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080858; c=relaxed/simple;
	bh=kZV6ZLZgI/wrqlr69pqr0fOAak+X0p8hf4KUVheyMqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQp64JhXUNChrd6NWs2Uayps/0l9Dckk6SKOheVYb8ijc8AMyJbT9igaccqkIrJTTS4bqPMTWWUjJZ2CazhzY1IiEvONsIt4gdwuLPAo9Wq4ZtCBC2KQh/67bryPWpqD0FTMkVt01qXD6ai7uBafbDdyHshBS9Mq++oFx3/PBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz2F5oh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz2F5oh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A950A1F000FF;
	Tue, 22 Sep 2026 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080854;
	bh=zeSEO72eCnxZ+iTsaOq9jItk1bhUJBMtPWgPqZ5OXvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bz2F5oh71xSQKDwoPWRQpqlNzjB2lihMXyzz5kpO3Kfw3CSo52E6It6jp2jbgAomW
	 SlP553uKXXJYkpE+xXb5myXYWAsgs+K/A3TyeAigkDdUrRS9renBuDMC0fFQChMqBY
	 5cquCzN16jkiXVyKgHwkczMu+K5dVK7njIeKsx75qi8m0b9D+Yvk+KPaKPIOouP18F
	 2koh5VFtDonUUkS12Tm1exefTuspRMB4fpmRctqkQOWnM7Ou5gh652Nc5parMQ7AXr
	 Dksgq2lgdHmkAg+sIQryVGtDOc5vzmun+g/ePQkIxmvCWemgUPxbfX7Tjys8Om6foo
	 hZYQF88KkB6QA==
Date: Tue, 22 Sep 2026 13:40:51 +0100
From: Lee Jones <lee@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jan-Simon Moeller <jansimon.moeller@gmx.de>,
	Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: Remove sysfs group on allocation failure
Message-ID: <20260922124051.GG3277918@google.com>
References: <20260915020600.91955-1-mhun512@gmail.com>
 <20260922123713.GE3277918@google.com>
 <20260922123745.GF3277918@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922123745.GF3277918@google.com>

On Tue, 22 Sep 2026, Lee Jones wrote:

> On Tue, 22 Sep 2026, Lee Jones wrote:
> 
> > On Mon, 14 Sep 2026, Myeonghun Pak wrote:
> > 
> > > register_multicolor() returns on allocation failure without removing the
> > > sysfs group created by blinkm_probe(). Remove it on this path, matching
> > > the helper's existing LED registration error cleanup.
> > > 
> > > This issue was identified during our ongoing static-analysis research
> > > while reviewing kernel code.
> > > 
> > > Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > > ---
> > >  drivers/leds/leds-blinkm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > > --- a/drivers/leds/leds-blinkm.c
> > > +++ b/drivers/leds/leds-blinkm.c
> > > @@ -691,8 +691,10 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
> > >  
> > >  	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
> > >  					GFP_KERNEL);
> > > -	if (!mc_led_info)
> > > +	if (!mc_led_info) {
> > > +		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> > 
> > If 'blinkm_group' was created in blinkm_probe(), shouldn't it be cleaned up in
> > the error path of 'blinkm_probe()' rather than here in the callee?
> 
> Same with register_separate_colors() failure, no?

What about:

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index ee1589015826..7932095780aa 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -749,19 +749,17 @@ static int blinkm_probe(struct i2c_client *client)
                return err;
        }
 
-       if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
+       if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR))
                err = register_separate_colors(client, data);
-               if (err < 0)
-                       return err;
-       } else {
+        else
                err = register_multicolor(client, data);
-               if (err < 0)
-                       return err;
-       }
 
-       blinkm_init_hw(client);
+       if (err < 0)
+               sysfs_remove_group(&client->dev.kobj, &blinkm_group);
+       else
+               blinkm_init_hw(client);
 
-       return 0;
+       return err;
 }

This is completely untested.

-- 
Lee Jones
