Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92743C045;
	Fri,  9 Oct 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545277; cv=none; b=hlhfCYcyuBTJmP+IYngxv5+aIZDhVDL2ddbRzu6nOlg7QzIH/bjqVKtZuxbPYXP7goiHBLEczb1276GpLtyWJ8QDMpgv4JFF2yUQ1nxK+Ke1u0csqdp+CYWPrb/ynKDlljrY/fQ+JocJH3r8lLT4/7NsTJhccxhGmxww2GHy924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545277; c=relaxed/simple;
	bh=W7FrgUXuit3xNSlwmEY5cCVuhtGjhoUnEK6xYtNjwsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCHZuV69vpJxyh6Zh5AtPy7K7t6P078YJv3cg//bh30+G1a6zII7OHDbOB/e1G0tSwny2sUH+cklw6Z72hHr02X+REybP9mdVRq2fjUlW3lxNCTYGI+wfeyIQ/VlNJeLU2nSnZzbSYbq4QMZ1JPyWXN9FG5Hg4Zh5mQEpFxnvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkUzQj92; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkUzQj92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791545269; x=1823081269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7FrgUXuit3xNSlwmEY5cCVuhtGjhoUnEK6xYtNjwsg=;
  b=UkUzQj92pUySAtvoxmnQqXQdvK7mDaEFrEkFBXD58i9J5I/jGZ+jPFFV
   qD/grtPcvOIiBVMC2Xw222GEcdcqdx0FW+Wknf1sYZT2kNNaR36SvKxWI
   CzRu0leWZAH5IOAgl3bZC6tg04w+GB8AA47HbdnvpIYFs3tZ+4GTMHDgX
   cRYmUceHBwpYh85qIcrI5h2d2qbIK5YVQhAsGQ9VD5Xs/Dk3t1w7VCVzZ
   M6GahyK8g0AXZ3zQ9XpBZ1P+2jWXTZeqX9x9rQ86EewIP0/P0HDk+JPnH
   RN3kJCtm6nwKynCYGjoO4r9trWFUuRxFr3sHUVeWaWd3qWyyEwRMmQeUt
   w==;
X-CSE-ConnectionGUID: TeguN8GqRvOkzq+hOZ5ZZw==
X-CSE-MsgGUID: kQaCJkMNQWmztqBnNcYuIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="222839"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="222839"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:27:48 -0700
X-CSE-ConnectionGUID: K2HeL7nuQi6fkh8TGAbNhg==
X-CSE-MsgGUID: PLf86bseRxS9J824ARgThA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="253807"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 09 Oct 2026 04:27:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 919A299; Fri, 09 Oct 2026 13:27:43 +0200 (CEST)
Date: Fri, 9 Oct 2026 13:27:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Johan Hovold <johan@kernel.org>, Ajay Gupta <ajayg@nvidia.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: ccg: Validate altmode index in
 GET_CURRENT_CAM response
Message-ID: <asjPr8RBDnQp9v2V@black.igk.intel.com>
References: <2026092918-evolution-modulator-3a97@gregkh>
 <20261003215520.611083-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003215520.611083-2-eeodqql09@gmail.com>

On Sat, Oct 03, 2026 at 05:55:20PM -0400, pip-izony wrote:
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
> Fix this by rejecting responses whose index is out of range, printing an
> error and returning -EPROTO, so that the caller cannot accept this.
> Also check linked_idx before using it as an index, so that the write into
> uc->updated[] is always within bounds.
> 
> The response is now only processed when the command completed without
> an error. ucsi_sync_control_common() only reads the response when the
> CCI reports command completion, so otherwise the buffer is not filled
> and must not be mistaken for an invalid index.
> 
> This bug was found with a Python script that traces where firmware input
> is used.
> 
> Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
> Cc: stable@vger.kernel.org
> Reported-by: Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>
> Assisted-by: LLM
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>

As a personal request, next time please send the revised patches as
new threads instead of as replies to the previous version.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  v1 -> v2: Print an error and return a failure instead of ignoring the
>  response, as suggested by Heikki. Only process the response when the
>  command completed without an error.
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..80e3e84b418d 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -384,14 +384,28 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  	return -ETIMEDOUT;
>  }
>  
> -static void ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
> +static int ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
>  {
>  	u8 cam, new_cam;
>  
>  	cam = data[0];
> +	if (cam >= UCSI_MAX_ALTMODES) {
> +		dev_err(uc->dev, "PPM returned invalid alternate mode index %u\n",
> +			cam);
> +		return -EPROTO;
> +	}
> +
>  	new_cam = uc->orig[cam].linked_idx;
> +	if (new_cam >= UCSI_MAX_ALTMODES) {
> +		dev_err(uc->dev, "invalid linked alternate mode index %u for %u\n",
> +			new_cam, cam);
> +		return -EPROTO;
> +	}
> +
>  	uc->updated[new_cam].active_idx = cam;
>  	data[0] = new_cam;
> +
> +	return 0;
>  }
>  
>  static bool ucsi_ccg_update_altmodes(struct ucsi *ucsi,
> @@ -636,8 +650,10 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
>  
>  	switch (UCSI_COMMAND(command)) {
>  	case UCSI_GET_CURRENT_CAM:
> -		if (uc->has_multiple_dp)
> -			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)data);
> +		if (!ret && uc->has_multiple_dp &&
> +		    (*cci & UCSI_CCI_COMMAND_COMPLETE) &&
> +		    !(*cci & UCSI_CCI_ERROR))
> +			ret = ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)data);
>  		break;
>  	case UCSI_GET_ALTERNATE_MODES:
>  		if (UCSI_ALTMODE_RECIPIENT(command) == UCSI_RECIPIENT_SOP) {
> -- 
> 2.43.0

-- 
heikki
