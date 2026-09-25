Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779E423E99;
	Fri, 25 Sep 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314216; cv=none; b=gLJ1fgNpsOeyeuStvQPT73WXo7/h72SwDeUloP1WVQYeJtMMtrTwYxEHL5b8kadVVwR/E69HnJih8PQkxgStaxVCKYAkDHIPxifj+ORw+8JXO2gwEmlgRLZ31RbPwL3DlS502waOf8I6uaoczK06tXc/9PxnDJgViXKXw5on2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314216; c=relaxed/simple;
	bh=+5f8E3hOM4QhzPk4W/QLUJ7sHloiO7DiVELzcZebiTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALRohuCG4e2Kwa1XTrAbK72l9TE5Ez1ax9Y8/9/vO5eWmGfHh60aOcLtvtrl/drD11KeARoCiUV4dzwb1cuDcpZr+WS/r7nu1tR50DHui896q4Bambz3KPtTapvvOLH2N30tmhp+LOAaB/fOwVwLj/fg8kgmeEOdlv7JaF5nJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMBya8Le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMBya8Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618411F000FF;
	Fri, 25 Sep 2026 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314214;
	bh=6agBB+xlIInaNFgPYojPw8v7PFgmCfgsq4/k+3Cg+Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IMBya8LeYT6QF2CQUNhgQDf/NNGsCp+iNbxqInFIxVnimGOQpysC0GSTxPMHwT+Wa
	 kCN6Gqiv38gshmoWJ08/Axh50HRsDP4j4cN16/XAHSbgLbf9XRde31KN6QBZPXR6vn
	 gXpNipC3kwpbP6DgfGWwle2Gtp7UjuDwxlVfOfWs=
Date: Fri, 25 Sep 2026 07:08:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mhun512@gmail.com
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org, i@zenithal.me, ae878000@gmail.com,
	michael.bommarito@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usbip: vudc: Prevent transfer timer rearm during
 teardown
Message-ID: <2026092555-pastime-fender-3712@gregkh>
References: <CAGEsz8Gwh=Y31EuTJLUp_jq3HhiizHxt7_ivOuytyZZH06mycA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8Gwh=Y31EuTJLUp_jq3HhiizHxt7_ivOuytyZZH06mycA@mail.gmail.com>

On Thu, Sep 24, 2026 at 09:51:44PM +0000, mhun512@gmail.com wrote:
> Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition") deletes the timer before
> usb_del_gadget_udc() stops the receive thread.  v_kick_timer() can rearm
> it even in VUDC_TR_STOPPED, leaving v_timer() to use freed vudc.
> 
> Use timer_shutdown_sync() to reject later rearms.  Replace the
> inaccurate blanket lock comment with __must_hold(&udc->lock) on
> v_start_timer() and v_kick_timer(); v_init_timer() and v_stop_timer() run
> unlocked.

That is two different things you are doing here, so this should be a
patch series of 2 patches, right?

thanks,

greg k-h
