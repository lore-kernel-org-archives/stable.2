Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B082376BEA
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374639; cv=none; b=ngKMoloCRSEUBFyPl5RPTdT+qAhwglkh6IFCKLP4UeKAGssq6L2xaR1vO3Tg/UXembcE3urSso/mo0yb/4SgtccN0ijTVAomWwgFj6mRgrXUGU+B/e3x5+VgQXLOn6GCyUoYiR0sdZ2PuhOdsvETpJQ/9gLbnJUJncnhIJQzwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374639; c=relaxed/simple;
	bh=I8gng2i3lmLspHzQZSXxzctVXLA/Y9KmGoTqYty8al0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puRyr6WkCSoLf4D1s5OFblKLPy0EgAMqk8hIYIn/RhRHk7LiBNVcr8ZKmED6OX5zUt+a+x84Tj422om0QNHqwVCv1A2ZJ/tdssLHhkOPsanbLoYz6s6iZkpeZfERqYpafL/9SMyCS9ZbVoiy/Rses2kfnhwDfkLho923P16+9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJoL1tTu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJoL1tTu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39927410578so2642388a91.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788374637; x=1788979437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7hhLcfaaN6lTj7tOkHbTxkSZPJoatM6bB6WXeeH31i8=;
        b=EJoL1tTudFcxX8WN8QxQsEzic2nIhlp7ppzYy4IjHgu0agZK0CUNSSTWpkZwCacP85
         YU0slDS53hwuj+ph8dYVnT8m7lvpSktvJR+CoAiFVXjXFV+fUX6Pjf3eXHubH3Gu2Ft0
         vDffykx+yCcaolo+P6cioVIIZHbonP8g9f3UYxMVrR+rYKGjADkre0Q8++PXJM0Ytk6p
         Ee6xf8qQ/rnbTgmI7T+7h1XYC9My0DTBjfb/OUqGiysz/7tQCDmQZU0AHglx23BEVOZq
         WSbhMJfNO0l79D4xaAcU8GQ4ycfmTjCRL/ATkOWB+RaTtFLhX/Ud9p0ABud1PTvdBrsh
         Gkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374637; x=1788979437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hhLcfaaN6lTj7tOkHbTxkSZPJoatM6bB6WXeeH31i8=;
        b=YjVNDU3s3NHA+ceKmVB+JF3DDfPh5bvU0Gn4w/lcA6BTiDmGLQxZeOurJ5jR+qsIzA
         WEjG3g+6DKzAsvIvQRFn6UvdC/ZzZS9rcIMAQIoLzAvm/GW0W1qHExuhR73HPdP4ID+2
         3oCtx6DWhH69utzfbrdFpiKAJXYE1i5+L+hvzQj+9xXshRp+L9hsdQrkqTvic7YHtu62
         u+DbHQTY47HDQIt9P8Jn94VdwhTH1sGcVCl3TpWdLtlddsbIrfyJs5FNVjyWRWB/lDtZ
         ASptCB4gzaL0tN1PMlPGPyaPuf7bffWJ9OY39YvH/FyP0zZ17WEywSW5BjRB9tAe7t2e
         bl3A==
X-Forwarded-Encrypted: i=1; AKwUvBwP9GRXOYbPD1/BHT6LYsuhvHSjToCZC9HLPtI8hx0gI/QxEaP0pzFIm0Omw+l7D4z747JY0NE=@vger.kernel.org
X-Gm-Message-State: AFuF++n6Ei25LDm4zXWZMLXHZ15xhsHZtEUgPSadElHWuZ4m8IEIBWUm
	WvdcBziO8d+tJd8foMnkseMyq2Pu1LYAFZPqZtan0OD0qbbSvJN05hmr
X-Gm-Gg: AYBFou3rjzRJE+Op7E7QFpt1xxOJhYHkYm08SfHZy8h4jCakrTYDf/CXJFTvURSejxZ
	BmlaU1Rxc2SBkB5QZp2kfwWMdLRU9NPcu5WqkLgNzbGyyKW64sii/oWnVA0CVHuGhNQINfQHyNH
	4QKYQXK8c32u8Jyc0tyVGd4PLsvrhW3GecdGoXcNhfFjlrWcww/jqqCeKutnBerC46qjSxSg/b+
	ZpyzS5HXdnHlreRg/+NRlpVn5YZbKH8BacwpZdeVOtp+RFdFQQ2qsaFyP4ENyyamb/iH9NULLHw
	6iVsr1u46sTGRLg88Ve548sD3Nyx67KySoSDz4SBPdJxDFpVYRlU8naLHywuxcb6n5L2QTrZuN4
	KDLpgA0XzJsW/cFoC3VitAYwRP72EPxfAyFd+H5ClKfJWsVjMWBYtA+IceSnx8jsp5yIF7j1l6r
	qSbM14wCD3O18Kqr/I0eNGnrturxdBF7rIW+lr9saMjjW4bfa2NXA6//5qhXI0B6WRZBjW1W/OJ
	1pnRvjyg+2PMeNA6gXmNuNCs+w=
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39aee219f45mr9553381a91.17.1788374637221;
        Wed, 02 Sep 2026 11:43:57 -0700 (PDT)
Received: from localhost ([2409:40c4:d:5c19:7852:60e7:cc2f:a6de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccdecdsm1678251a91.2.2026.09.02.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:43:56 -0700 (PDT)
Date: Thu, 3 Sep 2026 00:13:53 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Pecio <michal.pecio@gmail.com>, Mathieu Fluhr <mathieu.fluhr@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: hub: use shorter 120ms post resume hold for SS
 root hubs
Message-ID: <aphpX-0WxWQOR4mQ@eggarch>
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <9f8fae96-0865-4b0e-9650-00e92e324f9e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8fae96-0865-4b0e-9650-00e92e324f9e@linux.intel.com>

Thanks for the feedback,

On Wed, Sep 02, 2026 at 04:29:40PM +0300, Mathias Nyman wrote:
> I'd highlight the fact that this patch mitigates the AMD platform issue.
> 
> Maybe begin commit message with something like
> 
> "Holding a USB3 hub PM runtime reference for 200ms at hub resume triggers a
>  AMD platform issue. Users running Android adb report crashes after adb has
>  been polling and waking up the USB subsystem once a second for some time.
>  Vendors are working on a solution. Disabling USB runtime PM is one way to
>  prevent this issue, but it is also proven that reducing the hold time to 120ms in
>  resume also mitigates it. See Link for more details.
> 
>  Reducing the hold time to 120ms for the USB3 roothub is in itself a valid change
>  and optimization as the current 200ms is excessive...
> "
I will re work the commit message in v2 along those lines. But if the
mention of the commit 8f5b7e2bec1c is removed, should I keep the Fixes
tag or remove it as well?

> I'd do minor changes to the original code comment above the first #define,
> and just add the second define right after it
> 
> /*
>  * modified original comment
>  */
> #define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
> #define USB_SS_RH_PORT_U0_WAKE_TIME	120  /* ms */

I could change it to something like:

/*
 * Give SS hubs 200ms time after wake to train downstream links before
 * assuming no port activity and allowing hub to runtime suspend back.
 * Root hubs have no upstream hub whose wake propagation needs to be
 * accounted for, so they need less time, use 120ms for them.
 */
#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
#define USB_SS_RH_PORT_U0_WAKE_TIME	120  /* ms */

If everything else's fine, I'll send a v2 with these changes.

Thanks,
Lovekesh
