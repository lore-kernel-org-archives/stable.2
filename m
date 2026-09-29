Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420F3EC830;
	Tue, 29 Sep 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688817; cv=none; b=jvu9EPfB/dnKObT2R48+xKSGv//Uk60RusscRhPYrfNAjRpGSne1ShQ+CjEfUEGlY41JD0fvC5qM/eyOuPNXK8vq2CwBFhh+g/BZ+1C+2eCm1jYnl6jyl1RD+ZAo+LuK7/yL0eif/IVOQXsoP6DzDYlZcU77oDnjgGzxgTiplGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688817; c=relaxed/simple;
	bh=0L7FSZ57YdGdvGk9Es098LolE1B7AUWH0wgLSFsQpYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHUGQnwrxlY6QffxErmgtMchT6mtQAiyZiWMAQBKIwswQHNOXtbJuaagoAu5FD/kwYFc//nTDHCjMp+9fpIPkwj10JgTUBFOgiBVCxoZgOX5fdhIIxliqzBosxr67RAqOt8X4AQondZxaBuxZmt9C/Fb8raqpy9/fKMQS8Se/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vQ/2vBR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQ/2vBR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE991F000FF;
	Tue, 29 Sep 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790688815;
	bh=diL6msZxc8dWd+VYNDwRHUHjTGEBT+ehpImKw+oGlZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vQ/2vBR41YiqZsCQkUd8N4iG2jHGGByUC4eAtsdITCyMEzgdtMoXejCRWq2ilRa6u
	 MjWda8SKxpu0uwdUjWpKW8wqUK1dFPrTHX1Y3Eu2hI3YYjl6LwIMY9LMe0/hnHLeko
	 X/LJmN07CHwZ1Uh3xXR7vkF4QjJYk+/hsSvDvxKI=
Date: Tue, 29 Sep 2026 15:33:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: pip-izony <eeodqql09@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Johan Hovold <johan@kernel.org>, Ajay Gupta <ajayg@nvidia.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: ccg: Validate altmode index in
 GET_CURRENT_CAM response
Message-ID: <2026092918-evolution-modulator-3a97@gregkh>
References: <20260928053759.533956-3-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928053759.533956-3-eeodqql09@gmail.com>

On Mon, Sep 28, 2026 at 01:38:01AM -0400, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> When the PPM reports more than one DisplayPort alternate mode for a
> connector, ucsi_ccg_update_altmodes() merges them into a single entry
> in uc->updated[] and sets uc->has_multiple_dp. In that case,
> ucsi_ccg_update_get_current_cam_cmd() rewrites the response of the
> GET_CURRENT_CAM command. The response is a single byte holding the
> index of the currently active alternate mode, and it is provided by
> the PPM firmware.
> 
> The function uses this byte directly as an index into uc->orig[], and
> then uses the linked_idx read from that entry as the translated index
> into uc->updated[]. Both arrays have UCSI_MAX_ALTMODES entries, but
> neither index is checked against that size.
> 
> If a malicious or buggy PPM reports a value of UCSI_MAX_ALTMODES or
> larger, e.g. 0xFF, uc->orig[cam].linked_idx reads over the end of
> uc->orig[]. The byte read from there is then used as the index for
> writing cam into uc->updated[new_cam].active_idx, so the out-of-bounds
> read is followed by an out-of-bounds write. This happens without any
> userspace action, since the UCSI core issues GET_CURRENT_CAM on its own
> when handling connector changes.
> 
> Fix this by ignoring responses whose index is out of range and leaving
> the original value in place. The UCSI core only uses the value as an
> index into con->port_altmode[] when it is below UCSI_MAX_ALTMODES, and
> otherwise treats it as no active alternate mode. Also check linked_idx
> before using it as an index, so that the write into uc->updated[] is
> always within bounds.
> 
> Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
> Cc: stable@vger.kernel.org
> Reported-by: Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
> The issue was found through code audit and was reported privately,
> so there is no public report to link to.
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Did you forget an Assisted-by: tag?

thanks,

greg k-h
