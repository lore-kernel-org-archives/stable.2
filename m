Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE04119E0;
	Mon, 24 Aug 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570405; cv=none; b=desXty7wtoGaUyrblxGxAtmnhAzzLVWbJhPqIqkiMR0GLWa+0t4NkROK5MwunvnL4YMgKvCU014xXXbw0E0fS4axUKAWuIVOfWfSEvAqE8IvCNQLrVOmZd+OsfKzFvNRoK5wRdarQ/MP2+JMIChi9pjCc35Wd9TPnE/ZL0UYTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570405; c=relaxed/simple;
	bh=CBQJtTadz8j39fVTrD8BrXPJ+VCJRa5hxUkhja9QjUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWqyfr1OYqm7LVFPK8lxNo+mKrT/aqC6iUFiVzhOmp+Syiws2AC6U3Eq8qC9ctJR54OCTGwxoSgNoWRNJsHgRyMcMuJl42rl6IWAaugta+qRmVSqmjihaVBnnafz5oPmjrixzAfV3DBPFWQD3oEGEIDQbzQgP9azSTelZay5uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JB/5icX3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JB/5icX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787570403; x=1819106403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CBQJtTadz8j39fVTrD8BrXPJ+VCJRa5hxUkhja9QjUY=;
  b=JB/5icX3KqSpt8hlhWJ0dzRbPbGUfKrRmx4RZw2G4scpCKv9w7hzRjPj
   a/1mGFLEVT26EvEmPiz+LjwF7oht2Dlz0b3MyUjNK9eztKPNDRnkG8DyM
   9UKC6MQsl+VTmGnsMAnZXd+721GAFBZQjLiAyxqsUBSkkRlufwUCTkFoO
   AwOIl5rCse5+r+eqeAsgB2DFCGq4rPr0p/lhjiGwNGhDEbJahb41D2TSc
   rmg6F8w7bkBgjebzU/HF5q6I12zIwubAozcF/RLb8Ohs4QJeTFXti7kc/
   7/ewgad473KfQZTcvO7tbvX62kcXwylCaJjfUYoJOxYB46mXdIdMiaiZY
   g==;
X-CSE-ConnectionGUID: W1dkqETzQ16QZBl/k2PlsA==
X-CSE-MsgGUID: 669aNMlKSJq0NNFIvdIpWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88033092"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88033092"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 04:20:03 -0700
X-CSE-ConnectionGUID: 56RXLQU6QTGK4Xf/IM/6aQ==
X-CSE-MsgGUID: uKZyOZjFQAqPg5GjNOjeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272190349"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2026 04:20:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id ABB8399; Mon, 24 Aug 2026 13:20:00 +0200 (CEST)
Date: Mon, 24 Aug 2026 13:20:00 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chang Wu <kunjinkao.jp@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Remmet <j.remmet@phytec.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: hd3ss3220: track VBUS enable state per
 consumer
Message-ID: <aowo4CwwNjYSN1bA@black.igk.intel.com>
References: <20260819152027.90994-1-kunjinkao.jp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819152027.90994-1-kunjinkao.jp@gmail.com>

On Wed, Aug 19, 2026 at 11:20:27PM +0800, Chang Wu wrote:
> regulator_is_enabled() reports the aggregate regulator state, not
> whether this consumer holds an enable reference. If another consumer
> enables VBUS first, the driver can skip its own regulator_enable() call
> and later attempt to drop a reference it never acquired, triggering an
> unbalanced regulator disable warning.
> 
> Track successful enable and disable calls locally. Keep the state
> unchanged when an operation fails so a later role or ID notification
> retries the operation while this consumer keeps balanced references.
> 
> Fixes: b3f9d6e491fd ("usb: typec: hd3ss3220: Check if regulator needs to be switched")
> Cc: stable@vger.kernel.org
> Link: https://github.com/qualcomm-linux/kernel/issues/472
> Signed-off-by: Chang Wu <kunjinkao.jp@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Testing:
> - scripts/checkpatch.pl --strict: passed
> - Qualcomm CI checkpatch, sparse, DT and UAPI checks: passed
> - Not tested on hardware
> 
>  drivers/usb/typec/hd3ss3220.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index d0de5a2488f9..4eec90c82bae 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -62,6 +62,7 @@ struct hd3ss3220 {
>  	int id_irq;
>  
>  	struct regulator *vbus;
> +	bool vbus_enabled;
>  };
>  
>  static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> @@ -208,7 +209,7 @@ static void hd3ss3220_regulator_control(struct hd3ss3220 *hd3ss3220, bool on)
>  {
>  	int ret;
>  
> -	if (regulator_is_enabled(hd3ss3220->vbus) == on)
> +	if (hd3ss3220->vbus_enabled == on)
>  		return;
>  
>  	if (on)
> @@ -216,9 +217,13 @@ static void hd3ss3220_regulator_control(struct hd3ss3220 *hd3ss3220, bool on)
>  	else
>  		ret = regulator_disable(hd3ss3220->vbus);
>  
> -	if (ret)
> +	if (ret) {
>  		dev_err(hd3ss3220->dev,
>  			"vbus regulator %s failed: %d\n", on ? "enable" : "disable", ret);
> +		return;
> +	}
> +
> +	hd3ss3220->vbus_enabled = on;
>  }
>  
>  static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
> 
> base-commit: e1e6e541c5c9cf548e9fdc35fc26808c82074440
> -- 
> 2.48.0

-- 
heikki
