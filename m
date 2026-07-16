Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9F3246ED
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184948; cv=none; b=Irwj30/4Ojt2aQinN9u2xIl3JoM3dM9KW+hiYCIwH1KmIoLWtzT01z5wuEa6mi5tJDt+4RBkgzaf6vzrXIHiaO19vXeiRiapJpn/O/dpQrW1AM8XMrx3INwbe0ab9v1wRQyqALD474OGMevIIjI8mfQvyZWlbrguLGhcGSpFDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184948; c=relaxed/simple;
	bh=5aFC7UIJ/0MkSOfFxU38E5MSc5aE2gJ8tn1j4wAS9QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsIj6tLMtjj+BY5IPB5E6seCluaKAskKg6AdBA6wCz2fosG/6COGl7l34T41ZGnyRWZ/gVRwD8vgkhX0TWjoxPzYs5WC/BVsBqym58XdurqbKU6RPuyEw4G0p0IrMi7dGzZMyWln/o4GJ+WkEHWS/CzSjurXNxoLI7LyRj0vDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZAcXk3M; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZAcXk3M"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4896ae35be9so2597642b6e.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184945; x=1784789745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CzxD1cLTPriwoM1nM4cGtIKasJcP9ac2Us6YiJuTHfo=;
        b=jZAcXk3MAaUJmUxp74zjuT734o8Er8twcjEMhjwQ0Pi3ZGPLvOfmPPyefcxOqLeBA2
         F5lqsitTzAFoxnZPsGhxMJrLXjIxuFZ4ymGVCm/DY+wmwCEckGd9NeC2s1Uef6NODJ1S
         VaWZ/laXr24jCVzja7+4SbYXmlEJtU+NLvKr/0fN185cnuYkwTpO5F9QqTbOq1RnxRuQ
         XlF7r2OGq9PobprhKlIBnC1fdAGZvAfQLERI54vKR3ooLxYSFaStT9B+ndOLN7EYU8ke
         rj7JWZk2INDuR0tWDxwIJPLhxFlVSri3wSM8yflFs6mbR2w57QsOC3me3BcAk2OAeMCC
         tDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184945; x=1784789745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzxD1cLTPriwoM1nM4cGtIKasJcP9ac2Us6YiJuTHfo=;
        b=jDIQP6MghkM1DI3l6WIk5WXr6xQOUcKKTpsPVQJvufnyzqKlnICAZuovOgeMGjFdC3
         roSdX5l7qgBMN69FKGQ2d0e38PKXAGL2DKdEhhwJeookaWDzWx0uMOPf5+BlMEIaELFx
         BdRi+JkO287CnBllSu5jPd1aoDh5tAnNBdZATh6uu8JTBeYw1sqK5ehiRUq1qb+v8+Td
         tB2BJ3hb0P1olhR0//qYxPDr0rUSa9SoLCgBaz8UWxQ9B3fCgQNLTE8q8/e7sEdErzvH
         B9ooaKlbAIxNZ3+mfh3Mi/UEjxJNpvkeuwk172FpCIBN3pgZeVyWlFKdT5HRhZsraKmO
         egFg==
X-Forwarded-Encrypted: i=1; AHgh+RqsAa/l4IDHgSbmMAEkirqJeGUttbYKV9U5tVbWlXIIiQz8efPWRu5PDqE0qeq/wkvUX9zuJNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBQzaNNCwVIez5bQP52N9sYjwJIa/D9OaOdvs5aR6P+Uaypa4
	W8jFx9EJR/L4aUy2rHiTHjBps6vSVXtZ2eno9/rnNIBljAxHtt3F56Sl
X-Gm-Gg: AfdE7cmD0SVY/sijtUsaVvtM02OzW3ftkYp/Cl6LMZ/H/6LJqGU0jAWKFMS/TtjzvkY
	B+d3RtTOTexFW7EqrG28mlBwojwczvNhHAu5F9VbsIYU65yJuVjO6tFLBEV1OPwqktnQPUOMPTe
	Mh2QGys8MzWQNWHbjSCtZrNPz2cC/ueHfrL3Yh/l+Yr3ntpnaGbLADnQ/nGv5WeTnYUOa3cTxdi
	qd9L2x8+BBtUwcE824U0F+uYiPE0f2Xr714gBGkdvs8GBztKOIyKeWEVujwmowRHQlU4ivRP/bx
	/vjAKSaHlDj00z6V/7P/swkqhtRwyJ//G6KAvsOypEi2ssfDcjaUspLtH0DD+HqFl3rBRix3+Eu
	DVc0FuKhB4s1HkdT9Oa/Q0mtu4INTw2piwhspOkkGk1gUVIYWqKS88NCuNAho5QZ4yDObwXQdMf
	n7BhZx
X-Received: by 2002:a05:6808:8947:b0:492:285c:4da8 with SMTP id 5614622812f47-4a495eab7b6mr4246595b6e.13.1784184944575;
        Wed, 15 Jul 2026 23:55:44 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a42ae81f1esm11281900b6e.11.2026.07.15.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:55:43 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:55:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: johannes.berg@intel.com, Georgi Valkov <gvalkov@gmail.com>,
	briannorris@chromium.org, kees@kernel.org, bhelgaas@google.com,
	s.kerkmann@pengutronix.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
Message-ID: <aliAaHF3NgwAZ60v@stanley.mountain>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
 <20260716061638.GB9973@francesco-nb>
 <alh5y74H5bJyDSSP@stanley.mountain>
 <20260716063246.GA17850@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716063246.GA17850@francesco-nb>

On Thu, Jul 16, 2026 at 08:32:46AM +0200, Francesco Dolcini wrote:
> On Thu, Jul 16, 2026 at 09:27:23AM +0300, Dan Carpenter wrote:
> > On Thu, Jul 16, 2026 at 08:16:38AM +0200, Francesco Dolcini wrote:
> > > On Thu, Jul 16, 2026 at 03:17:28AM +0300, Georgi Valkov wrote:
> > > > Replace deprecated one-element arrays with flexible array members.
> > > > CONFIG_FORTIFY_SOURCE reports the following warning when
> > > > one-element arrays are used as variable-length buffers:
> > > > 
> > > > sta_cmd.c:1033 mwifiex_sta_prepare_cmd
> > > > memcpy: detected field-spanning write (size 84) of single field
> > > > "domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)
> > > > 
> > > > Convert affected structs to use flexible array members.
> > > > - Preserve existing wire layouts.
> > > > - Use DECLARE_FLEX_ARRAY() for structs inside affected unions.
> > > > 
> > > > Tested-on: WRT3200ACM, OpenWrt
> > > > Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
> > > 
> > > Cc: stable@vger.kernel.org # 6.12+
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Are we CCing stable for this sort of thing?  How many FORTIFY_SOURCE
> > warnings are still remaining?
> 
> Yes, you are right, my mistake.
> 
> Johannes, please be sure to not have the stable tag in once you apply the
> patch.

Wait...  No no.  It was a serious question.  I guess these warnings
are pretty annoying for a real user on WRT so it's fine to CC stable.
I just assumed these warnings were more common still.

regards,
dan carpenter

