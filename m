Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B83CAA2F;
	Mon, 28 Sep 2026 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600026; cv=none; b=dvX/VrvzolJfI46i7dCM+rP6qwZOcyzbVRj7NR3MTDmdP7EdPSmAz8PB8Q/SkMo9G1MKDShVFixrwU2Q73tRFb2EgG2biz2MVpIkobpGon3FHkPakbKlSRx467VcHlhN+Sb6bOoYys5aRLFAvs/tUK5Gveqy6z1EYJrj+/vdrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600026; c=relaxed/simple;
	bh=2tS3MczwPj42PWO3FAUfVUyYTR3S8sDgpalVZFYNROk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTCWMthMKknQxjpcXaTjtteuVKlzqqjt8+m9fbX1OnfQY2LeZ4TCnRyvL2CeMvcm76R1kfYKzq61p3tmkYlOrBw14wc7wnHPrhf+wABj4tCwFxjmeiwqZbpwhjb6pZS8m2W69e72Mn6J4umkD4z+vNIKuTXbDxg0mvO8iyyonDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rx6pXc/Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rx6pXc/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600024; x=1822136024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2tS3MczwPj42PWO3FAUfVUyYTR3S8sDgpalVZFYNROk=;
  b=Rx6pXc/ZXK0WiqlOeTuNM/Pfa76ThZRczMfgOMvY9ArcXeZPpQ5Oiayt
   pyCQv4nI5V7quewqtLaEnkZoSwO9T7aeh+xRoxgYwPyBJOKn0i8APE/qs
   WE+6gEQMDRTbQOxkpYB/AFiGLh7pZqnzj3biWUO924xD9tS5dPouyGc1C
   obzKgTkXlU9rGB4zWvZNr330pV8A7K33WvFQh6SacAu86IgOq/BemYUAB
   ZIgbvZEZRKc5Hdd3u7cgRzs7JP3q1XfzkZHV1EVc14LtMJd2LsCTK8YAf
   /6hvl7A0Pq1AKx+tCEqk3sUE9dvD2lB+uSPDA6InCQINlLcVP6r51BxL6
   w==;
X-CSE-ConnectionGUID: Jb/VSg6bRau41kdVyW29zg==
X-CSE-MsgGUID: T+Amhz81SZuzz8bAYpcVeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90349316"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90349316"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:53:43 -0700
X-CSE-ConnectionGUID: Gl1DAGKuQ72sQ7VZUK7+Hg==
X-CSE-MsgGUID: 179CtxMER2ugTVWL4w6T7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275168739"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 05:53:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 1669299; Mon, 28 Sep 2026 14:53:41 +0200 (CEST)
Date: Mon, 28 Sep 2026 14:53:41 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] usb: typec: altmodes/displayport: Disable work before dp
 is freed
Message-ID: <arpjVXg8DdgCv6Yh@black.igk.intel.com>
References: <20260923024637.403624-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923024637.403624-1-fanwu01@zju.edu.cn>

On Wed, Sep 23, 2026 at 02:46:37AM +0000, Fan Wu wrote:
> dp_altmode_remove() cancels dp->work with cancel_work_sync(), but the
> typec bus clears alt->ops only after ->remove() has returned, so the
> dp_altmode_vdm(), dp_cable_altmode_vdm() and dp_altmode_attention()
> callbacks can still call schedule_work(&dp->work) after the cancel. dp
> is devm-allocated on the partner altmode device and is freed once the
> unbind completes; a re-queued dp_altmode_work() may then run on freed
> memory.
> 
> Fix this by disabling the work instead of only cancelling it.
> disable_work_sync() drains an in-flight dp_altmode_work() and keeps the
> work item disabled, so the late schedule_work() calls are rejected. The
> work is still drained before the plug reference is dropped.
> 
> A later probe initializes a new work item, and the remove path holds no
> lock that dp_altmode_work() takes, so waiting cannot deadlock.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org # v6.10+
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index d96ab106a980..f7b3566d4029 100644
> @@ -815,7 +815,7 @@
>  {
>  	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
>  
> -	cancel_work_sync(&dp->work);
> +	disable_work_sync(&dp->work);
>  	typec_altmode_put_plug(dp->plug_prime);
>  
>  	if (dp->connector_fwnode) {

-- 
heikki
