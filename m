Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258F4B0E22;
	Mon, 28 Sep 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595959; cv=none; b=WDCQRF0fmFzhktsNRuSRREcAGLO6nAkwm7kwTUlUicGdJF/UurSq4qBPWxyrqe2mmQJpQ5fHATPkZkwlggiTDBV1yQWJfArBLaePI7EOSGmj104mkL6grt07J/CM4/fXb8lylKfXvilg4fAkftG/QhN9CM/zBKvRjgOo7I9c7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595959; c=relaxed/simple;
	bh=xzrXrhwrYA/nGNzNh844W+Q0tLQx5FRyl+iZGxYVkBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzp9mmrSOf3JESUQGxeyaiD8NxW45PauQ8903fpdqDjfNNTXI1TedABXv4hwZAoz2I/VFvDIw4CcSr+C/CGnfIbQ8PQl6DlHf2XUnSBJuPa3/6f54kqSf0stOOTgQ61nu/ldOSsz2YRF+LDGTuRsAzdaMCp2RhzWiZp4gGl1lMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV6prVxK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV6prVxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790595956; x=1822131956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzrXrhwrYA/nGNzNh844W+Q0tLQx5FRyl+iZGxYVkBk=;
  b=SV6prVxKVkhE48Il1vfsC9PMpd8r5j/J7/cpGqSkYq5YNIyS6iX965I3
   We/cZqII3f7wgW/bto7eJJ27QSTx9ZjmRgz6bkMaCm4tFCtKy/H1fSeEx
   kiNCwrXx+C0TT3bKE5qzIKzILKPs91iSpvdobQ0bq5fwJEAiQPV13mc1m
   Q/mZp3xNo4lzeEUFOrWhvQnNNVHcoJFPzdMJh/+6bHDsEf64L/i194GDm
   ASQ3VZMQqB86CHCwJqSv+DQaK4zmJWMUwm9SFTOK+JwMWm+YnV5IwQPrK
   cDrVpg+T0XCdHpT9Uc0ULqBbikDBHNZx2WGLH0HXEz0CQSGOJ6YUaQfvH
   g==;
X-CSE-ConnectionGUID: E37x8rWRStebksC1RClmVQ==
X-CSE-MsgGUID: W3mJMpBdQYyY2Hvvng2+6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="94006862"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="94006862"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:45:55 -0700
X-CSE-ConnectionGUID: 6dylwVTGSwK9zi9Wt0d6nw==
X-CSE-MsgGUID: q38WUgFKT5qpN1xOcVWNQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275070954"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 04:45:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 4A16799; Mon, 28 Sep 2026 13:45:52 +0200 (CEST)
Date: Mon, 28 Sep 2026 13:45:52 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] usb: typec: ucsi: yoga-c630: unregister EC notifier
 before UCSI teardown
Message-ID: <arpTcLdnyuZ83bLs@black.igk.intel.com>
References: <20260923074828.489562-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923074828.489562-1-fanwu01@zju.edu.cn>

On Wed, Sep 23, 2026 at 07:48:28AM +0000, Fan Wu wrote:
> Both yoga_c630_ucsi_remove() and the probe error path call
> ucsi_unregister() while the EC notifier is still registered.
> ucsi_unregister() frees the connector array, so an EC event (USB, HPD or
> UCSI) arriving before yoga_c630_ec_unregister_notify() makes
> yoga_c630_ucsi_notify() run on freed memory: typec_set_orientation() on the
> freed port and ucsi_connector_change() queuing work in the freed connector
> array. USB and HPD events do not depend on the UCSI notification-enable
> state, so the disable command ucsi_unregister() sends to the EC does not
> close this window.
> 
> Fix this by unregistering the EC notifier before ucsi_unregister() in both
> paths, restoring the teardown ordering from before the error and remove
> paths were reworked. blocking_notifier_chain_unregister() waits for a
> running callback, so once it returns the EC interrupt thread can no longer
> reach the UCSI instance and ucsi_unregister() can tear the connectors down
> undisturbed.
> 
> The callback is also the only external source that requeues the connector
> work, so the cancel_work_sync() calls in ucsi_unregister() can no longer
> race with a new connector-change event.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 168c3896f32e ("usb: typec: ucsi: yoga-c630: fix error and remove paths")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> index 1be18d1..59738dc 100644
> --- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> @@ -296,7 +296,9 @@ static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
>  	return 0;
>  
>  err_ucsi_unregister:
> +	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
>  	ucsi_unregister(uec->ucsi);
> +	goto err_destroy;
>  
>  err_unregister:
>  	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
> @@ -311,8 +313,8 @@ static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
>  {
>  	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
>  
> -	ucsi_unregister(uec->ucsi);
>  	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
> +	ucsi_unregister(uec->ucsi);
>  	ucsi_destroy(uec->ucsi);
>  }
>  

-- 
heikki
