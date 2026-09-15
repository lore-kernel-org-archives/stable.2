Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59141474252;
	Tue, 15 Sep 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464220; cv=none; b=naz8KoshCO/uzEFH1mGmVk3WW2rzPtP3HWxUIXGd68Kcq/TK5vDdW0jcNzvrbVsw6dbcV3823+FnCgd6LaoLGsEER3LG83N3Ubas/QAYQ7cvXVWA11jcW1w0X/TIu9Z8Jge81pHQxPY/3+5NHn7LPgWtpcjlpWY+LABcNUin5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464220; c=relaxed/simple;
	bh=ELWtCmWKg9UffUuU8jX78aQx3ESv/i5dnSDtUNB7t6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwaBB2A0ONz6n43fF1o5Ll+i+wxqj7y4kBU1WB9Ekbl6bEwOnunwkkh84JvuthngDtuhsIBd+LOJL8QqsOQbxers2FfrImMXM/ckIN5rupH2u5GJzrcgL18BEgt8SXkIB8hKTMs+NLrcYeUCPpBNQ7atLxQefHBTi/Hd9nwLLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzWcz8Lc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzWcz8Lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464219; x=1821000219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELWtCmWKg9UffUuU8jX78aQx3ESv/i5dnSDtUNB7t6o=;
  b=PzWcz8LcWgzTwxU/eVvl/eS8S2ryuXZseRSk8o98NxD4xktTcdIaNa6F
   7bGgMWrDoFKxWaU4lr15UH7pBQy3e3dx0ZHY8k93C59kfmNL+7M894K8V
   qUFirjW7IH3WyxzfEm9iokfy+gMs3r+uWAMCM8mb+JYRX4KUsx630uKYO
   825g1/WrjRbQx3hYnTbKOJze7PkrNr57IfUIi9Hjk1f/AnyjfgcYgkptH
   8A/o3Z9eglTWVUkiXmjwFWpawz5+mNmIszfMXZyer//9qXKZmmYIIf1g9
   NA4IzNmdumihPfX16zseUzO/TAMFgXIsrPpBtrYjd1aF7qREeqt00P3Ob
   w==;
X-CSE-ConnectionGUID: KU1O5q2ESQaV4yYuXDCruA==
X-CSE-MsgGUID: 8xtrgrGwT9C5Eo7OxALalQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77382945"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77382945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:23:38 -0700
X-CSE-ConnectionGUID: JdDWu1veSZmrKaPKqEo5DA==
X-CSE-MsgGUID: bsyLqtywS2KjOqa98cCnfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296409760"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.227])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:23:36 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F104C11FB58;
	Tue, 15 Sep 2026 12:23:42 +0300 (EEST)
Date: Tue, 15 Sep 2026 12:23:42 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: gc0308: drop runtime PM reference after probe
Message-ID: <aqkOniN8555x_kCF@kekkonen.localdomain>
References: <20260915080501.2164892-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915080501.2164892-1-lgs201920130244@gmail.com>

Hi Guangshuo,

Thanks for the patch.

When you do similar kinds of changes to multiple drivers, it's better to
form a patchset of these. There will be several versions of each, please
collect them together for v2. I presume most need changes.

On Tue, Sep 15, 2026 at 04:05:01PM +0800, Guangshuo Li wrote:
> gc0308_probe() powers the sensor manually and takes a runtime PM
> reference with pm_runtime_get_noresume() before enabling runtime PM and
> autosuspend.
> 
> The probe error path correctly drops this reference with
> pm_runtime_put_noidle(), but the successful probe path never releases
> it. As a result, the runtime PM usage count remains non-zero for the
> entire lifetime of the bound driver, preventing the sensor from
> runtime-suspending when idle.
> 
> Drop the initial runtime PM reference with
> pm_runtime_put_autosuspend() after the V4L2 subdevice has been
> successfully registered. This allows the usage count to reach zero and
> the sensor to enter runtime suspend after the configured autosuspend
> delay.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 3ae52083b533 ("media: i2c: gc0308: new driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/i2c/gc0308.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/gc0308.c b/drivers/media/i2c/gc0308.c
> index 15900d5414cf..266f737f9c5d 100644
> --- a/drivers/media/i2c/gc0308.c
> +++ b/drivers/media/i2c/gc0308.c
> @@ -1385,6 +1385,7 @@ static int gc0308_probe(struct i2c_client *client)
>  		dev_err_probe(dev, ret, "failed to register v4l subdev\n");
>  		goto fail_rpm;
>  	}
> +	pm_runtime_put_autosuspend(dev);

Instead of doing this, drop getting references in probe and remove and call
pm_runtime_idle() here.

>  
>  	return 0;
>  

-- 
Regards,

Sakari Ailus
