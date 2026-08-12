Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4937206F;
	Wed, 12 Aug 2026 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524797; cv=none; b=T+Sl00b9jbKeg/C88ntKvixiFZUyHIuKiPBlQtfF3//8omtlxDEmTYWY7QAoZtSj+JhCCnFqxUHPDn6nge1Ur1L4TFukWdFxy8SKFYds1BNPP14csDtxTg8uN4IsEbdkrLuoRFSzWNw1n8BLf34qd0XgV8yesSc1tX4Mp+sToeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524797; c=relaxed/simple;
	bh=xg3SaO0KedoMkyn4P8Q+rYIy9nsoCka+jvsorAqNj0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZuCk5STCB8IW6PQ8z1U/G3S4lYg9j4492TmeBmw7tTAGUqlrwfhP6/A1lB9lpRdxHQAqzrtKm1995W82hdjrej6V47W0lveWio6ODVxyjWRw5lBZ4I5kS4BQjZNZeqb4QaRS9aYaB2DxeKdjl3Pm/Pk3sHRIgIaJRODkfhZ6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5RUtLPv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5RUtLPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786524796; x=1818060796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xg3SaO0KedoMkyn4P8Q+rYIy9nsoCka+jvsorAqNj0U=;
  b=F5RUtLPvHAVEaGR35KPPR3VC2m/z25DdTiRPSnNShiU+ZM3eSHWDoX0L
   k4TFFvnRBWT9fv15CbCj+c0r+Ap+WOqOdjCpa9n1spQaPBF3RIwCzh9m5
   tlnZUNEtEarbdB7ZlTBWPW3LHV2OQFBqGEdaA6+F6ekDl7H04E6445QJ1
   t6RjXQuCGRwnEc+Q0IcdEPjtIvWWMMIfobZNEwgLMhJ8mD9wT7UHMbM48
   njnmamWIq0gm0Hsn21Zc+NwGPzGc3P17816pswV1O4Gw4RZt1CZtRvCz1
   7D6PqJ2xySXAMnmBrv8+dss4SGtIZbUC47KjMU9kyAXFYQmPtwSJXcT4k
   Q==;
X-CSE-ConnectionGUID: PpwwcFKLQvChygFKpp59Kw==
X-CSE-MsgGUID: /E+JfvRfS5uYn78rwql70w==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87145290"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87145290"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:53:16 -0700
X-CSE-ConnectionGUID: 5H4NEmmKQZ+8+kLbiBwDlA==
X-CSE-MsgGUID: /dZj+aZQQOW9dHMkS4J4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="268739249"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2026 01:53:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 8643499; Wed, 12 Aug 2026 10:53:12 +0200 (CEST)
Date: Wed, 12 Aug 2026 10:53:12 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] usb: typec: thunderbolt: cancel work on driver removal
Message-ID: <anw0eIpSau17rCwr@black.igk.intel.com>
References: <20260806060713.863-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806060713.863-1-getshell@seu.edu.cn>

On Thu, Aug 06, 2026 at 02:07:12PM +0800, Hongyan Xu wrote:
> The probe and alternate mode callbacks can schedule tbt->work. The remove
> callback drops the cable and plug references without canceling that work,
> and the devres core then frees tbt. A pending or running work item can
> therefore dereference both released objects and the freed tbt allocation.
> 
> Cancel the work synchronously before dropping the referenced Type-C
> objects.
> 
> Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
> index 32250b94262a..57c8dff0c51f 100644
> --- a/drivers/usb/typec/altmodes/thunderbolt.c
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *alt)
>  {
>  	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
>  
> +	cancel_work_sync(&tbt->work);

There's already a fix for this one:
https://lore.kernel.org/linux-usb/20260802014959.416687-1-fanwu01@zju.edu.cn/

thanks,

-- 
heikki
