Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEC36E488
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310823; cv=none; b=BG8YXgtjZNpEot29F5pYePeSSnX7/4n65bFJwl1tKpns8OwM69wcTPfkJPoSX6bg2XEehJSWf2/VzX0iaCEYBA/Qgt3QZFZ1jGfMNb/pyurblowwp3fZGtuwmTwJAtWZtcZpVsTEZ5JbtEXQBLW+rX7Vz3o/4Yz9xgA5ox4ekuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310823; c=relaxed/simple;
	bh=G/ZuPG5aUH+2gEMdd7aL9EhmbAOAuZWxu6GJ5kQuOO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHh6JOwqWS+7lMrw5EEMxji8oyJ2GZUVn6D/7Bzrd/0qWGdMx9r3UAYQiFwUET56TlfkVL53ZYUVKc+QkAxO1cVH7/X98OM9jvPeDtvWX/OgHKUYdr8UpdMRx0FTB+uAivR2nUToDUmsd1yTWYT5P1Nh0dcKkn8bjzTyo7qB7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErHsC3q1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErHsC3q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780310822; x=1811846822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G/ZuPG5aUH+2gEMdd7aL9EhmbAOAuZWxu6GJ5kQuOO0=;
  b=ErHsC3q10kFtHuXnoar1MKA4oAojIN96COrKH21QV/ABd22oH9UWpQ3C
   k/cImYducHfqYla+ex/+oT1kHHNwyAsGImgjB3TLhtTSsS/0YwCOGJV8g
   qHblQ8AYdq41sxFmkDPDDPrgxHVZ4PNiNRtiB7eAt6ZCD5dxm6QZFZhX6
   ywDbxq1nFPQ3ifmizrkYK3uvOyocZ7tTQ7c8o+T89e+qls2TtsHJT25i3
   /erjeMcy/yQFDWTWpkowYXCbYWAJaJCl+TVMgbuQSvabYi8lRHSGr9lDk
   4EJkRqqF6vfgUJ8iRHlssdqyAiZlwN/8mSKpuld36EMIpLec4rLkbvLt8
   Q==;
X-CSE-ConnectionGUID: jjMQiVIoSBiV9yzG2BKY1A==
X-CSE-MsgGUID: wZW6ERBgQiCMhEaRii6WFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81178428"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81178428"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:47:01 -0700
X-CSE-ConnectionGUID: z6RNbQ3NS6+9dICzzjir+w==
X-CSE-MsgGUID: Bi6oWTQ/QCqjy7elmoyqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243659033"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO [10.245.245.132]) ([10.245.245.132])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:46:59 -0700
Message-ID: <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
Date: Mon, 1 Jun 2026 11:46:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: stable@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260601101536.1333480-2-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 11:15, Nitin Gote wrote:
> xe_dma_buf_create_obj() creates the importer BO with obj->resv
> pointing at the exporter's dma_buf->resv. When dma_buf_dynamic_attach()
> fails, no dma_buf reference is held so the exporter can be freed
> immediately. Since ttm_bo_release() now always defers cleanup for
> ttm_bo_type_sg BOs to the TTM workqueue, the worker later calls
> dma_resv_lock() on the already-freed exporter resv, causing a UAF.
> 
> Reset obj->resv to the BO's private _resv before calling xe_bo_put()
> in the error path. The BO is not yet published (attach failed) and
> carries no fences, so the switch is safe.
> 
> Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG (QEMU):
> 
>    Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9c
>    Workqueue: ttm ttm_bo_delayed_delete [ttm]
>    RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>    Call Trace:
>     <TASK>
>     ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
>     ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>     ww_mutex_lock+0x3c/0xb0
>     ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>     process_one_work+0x239/0x740
>     worker_thread+0x200/0x3f0
>     kthread+0x10d/0x150
>     ret_from_fork+0x3bd/0x470
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Cc: stable@vger.kernel.org # v6.8+
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 8a920e58245c..6d944bd4065c 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -384,6 +384,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>   
>   	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
>   	if (IS_ERR(attach)) {
> +		/*
> +		 * The BO was created with resv = dma_buf->resv (exporter's
> +		 * resv). Since attach failed, no dma_buf reference is held and
> +		 * the exporter may be freed before TTM's delayed_delete worker
> +		 * runs. Switch to the BO's own resv to prevent a UAF when
> +		 * ttm_bo_delayed_delete() tries to lock the stale pointer.
> +		 */
> +		obj->resv = &obj->_resv;

+Christian, does amdgpu not have the type of same issue here? Also any 
thoughts here?

>   		xe_bo_put(gem_to_xe_bo(obj));
>   		return ERR_CAST(attach);
>   	}

