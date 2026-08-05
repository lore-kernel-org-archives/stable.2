Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20F33374F;
	Wed,  5 Aug 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933212; cv=none; b=pkSLYW0dwHUrj1RQMahLlFphZV7kU9BgzLNiqn1oGHIBpUgs0gPZJdWYtSDHTImewFWeRCoKk4sF1sETdhWLrg4qfYGzvreEd8v1vPnxyOapOmmikCewFZJ/g+cKZTmroDf5iYij2kVAfKvLfVCf2BdldCfcgWrRGkS3CanZGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933212; c=relaxed/simple;
	bh=pLvR/dJ401CnXCLgJ8lIzjc32dq7DFFRn9THw7lbIWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMo/oaUf6xp8ZNFkDQJ7/0tbRXy1x7iX+nneyj5JSCIsQXR0MCBjT4F+5FGOIQgGq4d7fD6VWiuZc0Ea+R97WAnSZD0FkVqYFhvYZcFTRwx2I+xMQbwGryWyR+zil/ZQTL//YJD36RAYNao1KXbgt4iB1fW8cmLTe9nijVsZ8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWUOeMPO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWUOeMPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785933211; x=1817469211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pLvR/dJ401CnXCLgJ8lIzjc32dq7DFFRn9THw7lbIWs=;
  b=FWUOeMPOSJaBQNCsptUSnZiD6VQbvr+DuTzsv/hvg8pHXnKUyRgQx3dE
   kEG3LfXgRqk9m1TVBrF/K3rVUNexksnu81XTtRCyxZ/Xs8WrrvRCEx9om
   1NmxSFKbrrnDWxDbhAWhWPfBvKquqgoKzw7YDiuen4cKE8jZzBo9L+us2
   ILPNLT/UZ3JnN1aBKGimIiyckLLuH6k3aZV+hwrf9wFS+wa7vBVtpJpOa
   a1VtwMlEr3WzkbXwaN/Z/fJk8sLXL0j+/9JdzywPdHy0yf/CdMySXW4sJ
   UwpB8CwdUrZUePNkrxF++Cd38E6yYn5tgFBDgPq8hn+OuW7wGEhyQKZBA
   A==;
X-CSE-ConnectionGUID: 5OFPCHm3Q7eDHQAHuO6DBA==
X-CSE-MsgGUID: sZKkji+JTKO9Ft87S8JADg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86515435"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86515435"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:33:30 -0700
X-CSE-ConnectionGUID: d3+QKexrQoGJFBP1xwZGOg==
X-CSE-MsgGUID: 0OgyrI0oR9ONwPcbMng4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="266920163"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 05 Aug 2026 05:33:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A665299; Wed, 05 Aug 2026 14:33:27 +0200 (CEST)
Date: Wed, 5 Aug 2026 14:33:27 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: thunderbolt: Disable work before freeing tbt
 on remove
Message-ID: <anMtlz1AIOgZsJF-@black.igk.intel.com>
References: <20260802014959.416687-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802014959.416687-1-fanwu01@zju.edu.cn>

On Sun, Aug 02, 2026 at 01:49:59AM +0000, Fan Wu wrote:
> tbt_altmode_remove() drops the plug and cable references without
> draining tbt->work. The work function dereferences those references,
> and can also requeue itself in its error path. The VDM callbacks can
> queue the same work item.
> 
> Disable and drain tbt->work before dropping the references. This waits
> for an existing invocation and prevents subsequent schedule_work()
> calls from queueing it during teardown.
> 
> This issue was found by an in-house static analysis tool and confirmed
> by manual code review.
> 
> Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
> index 32250b942..601d39ee1 100644
> --- a/drivers/usb/typec/altmodes/thunderbolt.c
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *alt)
>  {
>  	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
>  
> +	disable_work_sync(&tbt->work);
> +
>  	for (int i = TYPEC_PLUG_SOP_PP; i >= 0; --i) {
>  		if (tbt->plug[i])
>  			typec_altmode_put_plug(tbt->plug[i]);
> -- 
> 2.34.1

-- 
heikki
