Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964A2C026C;
	Mon, 20 Jul 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533615; cv=none; b=ly8Lrusr5SPHCwk9uyyHVYywcrKT2Lsd/69vZTT7X94hgQQTczEyVRfa5S8LMQuVISud0Dnie1mhT1Do88c83O1+P+4C0S8MOpVB6ExP8gxZZjtf10V1d6QdfmFa0qSq8GCgAAooWMLg28ztYkZW1GoWbv/vLUOQQxjckXV2j+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533615; c=relaxed/simple;
	bh=CCoeMS8v0/WQcZ432od6tLHiuBmbkGyieuMMNx+qGs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svORXWwXidTZNw9f5thI6m5arY2D1OoilAN0aDMLLa6EJxUsSHH3Ux5C8g/jpFRdTO05KToFCeWSkM8rXyHC3ZlyNBmUtkBrpgTAHoeWOihrmR5WqY0Uu6R+HGX89NLLU9Zq2wbjn3fBLZ3MEZPkNbDzRgp4+gz2NJMl8a8oOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPMv6jzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPMv6jzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677321F000E9;
	Mon, 20 Jul 2026 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784533614;
	bh=UBc/yWJmyhiDlZn1np7aMFU7W0x6UxAAdGnPwptGW9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SPMv6jzZn0dpM8V5G+tqDB6k9osY0zBMqNnwVN16IBfeSRe3VZx8YeHOwDBSw9JcG
	 sLDo4EOb1UT6hyPpEjM3kv+mn7xra2s88/SeXdVwZ49io9yAk43pj4AjAXjoQXlabY
	 BW/DhjzLijdMfvcTsUDD508OfZXnVz/AwISXv37sHFEX4GUHpUIfINJRoVN4btLjeP
	 VVL4w6IzYLGPrkrmFnOO1/qNX5XueoENNQCZWLF/5BvW4igopX+w/DxmcKgCcFYzii
	 H7dd7tYtX3TZShsgEpgwzb1O8UolQElLRkulsVBTK64c/cYMAgcMmk6HUJAGoVkyXI
	 vBmGyh8LFS56Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wliiB-00000008VGh-3CWA;
	Mon, 20 Jul 2026 09:46:51 +0200
Date: Mon, 20 Jul 2026 09:46:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe
 failure
Message-ID: <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-2-johan@kernel.org>
 <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>

On Fri, Jul 17, 2026 at 10:03:42AM -0700, Doug Anderson wrote:

> > @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
> >
> >                 if (!panel->ddc)
> >                         return -EPROBE_DEFER;
> > +
> > +               err = devm_add_action_or_reset(dev, panel_edp_put_adapter,
> > +                                              panel->ddc);
> > +               if (err)
> > +                       return err;
> 
> Yeah, devm makes this so much nicer. Thanks for fixing!
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I'll plan to apply this, probably to drm-misc-next next week. Unless
> someone objects, I won't land it -fixes because it's such a corner
> case.

Sounds good. Thanks.

Johan
