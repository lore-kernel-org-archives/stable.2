Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3540DB3F;
	Fri, 25 Sep 2026 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314219; cv=none; b=WZkEOzMKLsSmWyRwt7xmNTUycdkphpu015/8fk2rl4wxajMnqkI1cuygUG79y4uRH9OhlU4Nvg/SJhIFiT2Abq50l4DxDd1s7VL0ZzTuWtz7YZNqgYLbJdiJniC0FCQ0yS36f2eb5ie3R69t1BxWlioirAsgVaZQmyfY6xftJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314219; c=relaxed/simple;
	bh=ibENGHcc1Z91hnkDlPuyvRQ5BYkidVtng8t214jbk8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTrBQpf1FUbyA2fLDFaNjl4pb1dtUpz9/HNvJw6nMK1jLYImsavFr06b5p6q9Pqrpo+dmtLOibinloS3Wxd2gK0jdd5DFmZuCsmPpRG6z42AU6EQPFdjU/yVrbqEnzCFKq1nql8g0d/1ZyX3p9hNhbfQYPvuq3Dhlel9aDrZP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBaO+Zgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBaO+Zgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406381F000FF;
	Fri, 25 Sep 2026 05:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314217;
	bh=HZI9lS8DIMjeAPo5oH72MXZLc4nTybYrp5yISIe1pNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBaO+ZgdBqAilddIWgyalGBk/LU7SrjslBKyrStfNOdxwSgrKgQJb8iqFh9hZt9Yd
	 KPwdlX++kblMeJyQihBpSUizG9nGuVwNvEv0t7390Ad2I5Tyfw1YCtaREQItUPca7I
	 tloRh7iB4sJlRNo37cSOm3hMvHZSvgXqkq85GSNY=
Date: Fri, 25 Sep 2026 07:08:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mhun512@gmail.com
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org, i@zenithal.me, ae878000@gmail.com,
	michael.bommarito@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usbip: vudc: Prevent transfer timer rearm during
 teardown
Message-ID: <2026092538-feline-aftermost-8c2a@gregkh>
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
> 
> A KASAN/DEBUG_OBJECTS_TIMERS x86_64 QEMU harness binds g_zero to
> usbip-vudc.0, sends CMD_SUBMIT to usbip_sockfd via a socketpair, and
> repeatedly unbinds/rebinds vudc.  The unpatched kernel reported a
> free-active timer and a use-after-free in v_timer(); the patched kernel
> ran 4000 iterations without either report.  No physical device or
> remote client was tested.
> 
> Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition")

Do not line wrap.
