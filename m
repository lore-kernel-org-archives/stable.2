Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828503;
	b=KAvNWUaTy4oXP742Yti6oJz+mm20zQuP9zHrUyxbsnba6PMxoTH6Alr/ajUeIAaiuQVS
	 Jw8McTCcKiydwmcDQK3e2aDJr48E5FEQxhaQtj7xfbeOmYUzreOqafTg2CoG/BEk7rFiG
	 YVwBuBZsV+bBy9kCgienNwC5oF+AsTYWShdlc1TtXQvV4UVldYkt6gmbhy71a2wO0Dy7Z
	 uvjl2AketHQhQBlav5ztmJTdlFqW4Hy1kcJ8t3jeaCOQnb78q9tkyIoL0Ru+op6Pqn7dC
	 DnDUUwkXSMSXEFYgvuJsQdngo847IdWXLff1Nx1lTKkTQO4LDs+dEhAR5ckDM+eN/dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=0hlTDBmIiuUpro0fpaSZFKNZWTALX/pKa1s/geMvaCU=;
	b=k6u0b8sFSGK9QlP/e1HUXDC4z605Z1AJEauud7aBkMcI4KQzx0B4ibUVoGzbQDT/b060
	 thXJisdM7ZSSaZ/ZhqkcvnDRvLMiaQFRF8hNd6PPqcUbmDMs4zrXMPVxMFJ25u9zIBKjC
	 b7TsWP1ln39XI2KoufFGRxGvhr0I5UlBIWAuII0PCGu68UgrMH9XtjpkAN8wfUHU0nAXQ
	 /qkOTrAdyMt3IhX583UxOn/AOCHcr0s+9kyBa3ETl2R6K8m0TnyX28zuk8c5OFSPkQEwt
	 NoF+QYjeypk533cnJaZT+RYKABc1rhv6Mq9YGNAzCPVYo0tlsH0OYoVT/eS9p5T5KFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJiJs8Fl;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55B606A330;
	Mon, 16 Nov 2026 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF55B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJiJs8Fl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794828504; x=1826364504;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0o74o8kkP3rdi5jDk/1yA+QR72xMJzlJ2Xkc1vFvsI8=;
  b=iJiJs8FlVSxQ/u+4lU2KftQ88CiZrL4eVMt3v5FvuL51QpNC7B0D44i3
   KD0rCT+oEy8Y+F07D708BqUYJMi4jOMyDL3i9fpPld8oy6mEOu26mDgNw
   7E3bK4Z4c5sEnOPa3hSH1w/reS5OCtGXmFb14PlEjiWig62q6YGrl2RK3
   H3slhH3KwlOuSEbRSkPK/1bVUrOp4pT4u6SOQlJAQSAlZ8wq5HhT6ksnK
   07sOAqwBj/NqqadY+wifgIFzXzTWfVTVMMtItMZ1sLP6cJY4XaSOY4q9S
   6jNStB8tNeFljSLSvxPNEVpgodNp6Aj37ukcxliN0MXyWaU2nuQ7xSkLZ
   w==;
X-CSE-ConnectionGUID: PGciGPu4SJCVBrU3JpYuBw==
X-CSE-MsgGUID: nl1ZFl/TSLa4Jt+RgQmdUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3431293"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3431293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:28:08 -0800
X-CSE-ConnectionGUID: pe6sw38ISzyAE3EXGwsZwg==
X-CSE-MsgGUID: wxc/tGo9S/qv4ZgqhbZSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9849782"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:28:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Nov 2026 13:28:00 +0200 (EET)
To: Hongyan Xu <getshell@seu.edu.cn>
cc: Hans de Goede <hansg@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
    Chanwoo Choi <cw00.choi@samsung.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, Rong Zhang <i@rong.moe>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] extcon: synchronize all-connector notifier
 removal
In-Reply-To: <179474326273.103840.4798359664806814358@seu.edu.cn>
Message-ID: <4f3601df-029b-0ee9-41ea-c0ec29c5f80d@linux.intel.com>
References: <179474326098.103840.15531040789536968458@seu.edu.cn> <179474326273.103840.4798359664806814358@seu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 15 Nov 2026, Hongyan Xu wrote:

> extcon_sync() invokes the all-connector raw notifier chain after
> dropping edev->lock. Unregister unlinks a block under that lock but
> does not wait for an in-flight callback, so managed consumers can
> release their state while a callback still publishes work.
> 
> Use an atomic notifier chain for the all-connector notifications.
> Its RCU read section and synchronized unregister provide the
> required callback quiescence. Use the notifier implementation's
> own writer lock and perform its grace-period wait outside edev's
> spinlock. Document callback and unregister context requirements.
> 
> The current all-connector consumers defer their operations to work
> items and their callbacks do not sleep. Per-ID raw chains retain
> their existing behavior: some OMAP callbacks perform regulator
> operations and need a separate context-compatible repair.
> 
> Found by the author's in-house static analysis tool.

I think sashiko found this too:

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260806060526.1189-1-getshell%40seu.edu.cn

> Fixes: 815429b39d94 ("extcon: Add new extcon_register_notifier_all() to monitor all external connectors")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/2ef4ad43-497f-c40f-b18a-f5b75799d95d@linux.intel.com/
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>

-- 
 i.


> ---
> 
> Discovery: found by the author's in-house static analysis tool.
> 
>  Documentation/driver-api/extcon.rst |  2 +-
>  drivers/extcon/extcon.c             | 28 +++++++++-------------------
>  drivers/extcon/extcon.h             |  2 +-
>  include/linux/extcon.h              |  4 ++++
>  4 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/driver-api/extcon.rst b/Documentation/driver-api/extcon.rst
> index d3217b9..384d743 100644
> --- a/Documentation/driver-api/extcon.rst
> +++ b/Documentation/driver-api/extcon.rst
> @@ -70,7 +70,7 @@ The core structure representing an Extcon device::
>          /* Internal data */
>          struct device dev;
>          unsigned int id;
> -        struct raw_notifier_head nh_all;
> +        struct atomic_notifier_head nh_all;
>          struct raw_notifier_head *nh;
>          struct list_head entry;
>          int max_supported;
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 98d85cc..b8d8c2a 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -456,10 +456,10 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
>  	raw_notifier_call_chain(&edev->nh[index], state, edev);
>  
>  	/*
> -	 * Call functions in a raw notifier chain for the all supported
> +	 * Call functions in the atomic notifier chain for all supported
>  	 * external connectors.
>  	 */
> -	raw_notifier_call_chain(&edev->nh_all, state, edev);
> +	atomic_notifier_call_chain(&edev->nh_all, state, edev);
>  
>  	spin_lock_irqsave(&edev->lock, flags);
>  	/* This could be in interrupt handler */
> @@ -967,6 +967,7 @@ EXPORT_SYMBOL_GPL(extcon_unregister_notifier);
>   *
>   * Note that this function registers a notifier block in order to receive
>   * the state change of all supported external connectors from extcon device.
> + * Callbacks run under the RCU read-side critical section and must not sleep.
>   * And the second parameter given to the callback of nb (val) is
>   * the current state and the third pameter is the pointer of extcon device.
>   *
> @@ -975,17 +976,10 @@ EXPORT_SYMBOL_GPL(extcon_unregister_notifier);
>  int extcon_register_notifier_all(struct extcon_dev *edev,
>  				struct notifier_block *nb)
>  {
> -	unsigned long flags;
> -	int ret;
> -
>  	if (!edev || !nb)
>  		return -EINVAL;
>  
> -	spin_lock_irqsave(&edev->lock, flags);
> -	ret = raw_notifier_chain_register(&edev->nh_all, nb);
> -	spin_unlock_irqrestore(&edev->lock, flags);
> -
> -	return ret;
> +	return atomic_notifier_chain_register(&edev->nh_all, nb);
>  }
>  EXPORT_SYMBOL_GPL(extcon_register_notifier_all);
>  
> @@ -995,21 +989,17 @@ EXPORT_SYMBOL_GPL(extcon_register_notifier_all);
>   * @nb:		a notifier block to be registered
>   *
>   * Returns 0 if success or error number if fail.
> + *
> + * Waits for in-flight callbacks. Must be called from process context and
> + * outside a notifier callback.
>   */
>  int extcon_unregister_notifier_all(struct extcon_dev *edev,
>  				struct notifier_block *nb)
>  {
> -	unsigned long flags;
> -	int ret;
> -
>  	if (!edev || !nb)
>  		return -EINVAL;
>  
> -	spin_lock_irqsave(&edev->lock, flags);
> -	ret = raw_notifier_chain_unregister(&edev->nh_all, nb);
> -	spin_unlock_irqrestore(&edev->lock, flags);
> -
> -	return ret;
> +	return atomic_notifier_chain_unregister(&edev->nh_all, nb);
>  }
>  EXPORT_SYMBOL_GPL(extcon_unregister_notifier_all);
>  
> @@ -1300,7 +1290,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	for (index = 0; index < edev->max_supported; index++)
>  		RAW_INIT_NOTIFIER_HEAD(&edev->nh[index]);
>  
> -	RAW_INIT_NOTIFIER_HEAD(&edev->nh_all);
> +	ATOMIC_INIT_NOTIFIER_HEAD(&edev->nh_all);
>  
>  	dev_set_drvdata(&edev->dev, edev);
>  	dev_set_name(&edev->dev, "extcon%d", edev->id);
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 9461826..5a3f0c4 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -48,7 +48,7 @@ struct extcon_dev {
>  	/* Internal data. Please do not set. */
>  	struct device dev;
>  	unsigned int id;
> -	struct raw_notifier_head nh_all;
> +	struct atomic_notifier_head nh_all;
>  	struct raw_notifier_head *nh;
>  	struct list_head entry;
>  	int max_supported;
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index e596a0a..869bac9 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -209,6 +209,10 @@ void devm_extcon_unregister_notifier(struct device *dev,
>  				struct extcon_dev *edev, unsigned int id,
>  				struct notifier_block *nb);
>  
> +/*
> + * All-connector callbacks must not sleep. Unregister waits for callbacks and
> + * must be called from process context, outside a notifier callback.
> + */
>  int extcon_register_notifier_all(struct extcon_dev *edev,
>  				struct notifier_block *nb);
>  int extcon_unregister_notifier_all(struct extcon_dev *edev,
> 
