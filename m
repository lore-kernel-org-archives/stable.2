Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3246A5E2;
	Wed,  5 Aug 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933599; cv=none; b=NjtI5CSh2TitBMHfqoDi3KDyt73wdVm+xxPdWkWJCzX7F72R04KUlHNGh610KH4loabpSd3Plt5vYnMOCj9kkqE4BZqKiAjEoksVvR9wq598KH5nM3nxs0hJ4BKkxqsGGDfKHAM797NAF5IzXAev1GGSE153sZdeuKUWaQSPtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933599; c=relaxed/simple;
	bh=lrcxuTxEaHXs+XSoVE79k7yizRc7CV2ga7X9/3vaVec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQBuyn8k9jk4PTc9kc5NMLC0VyaWBIbGIT2s2QDv1JRFg/ZC4LPtD7M7xmeGCnTiQ0kdJCOYOoegZF/zZEcUrjaH6ae0I5H53h2QGay0ZeqJDX4LZTSH8yEzyc8I31H+xuzOQsYwFwp+z09v3HGFTEkTh0Pu4t2hbl8BR2pJtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI5uM/lb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI5uM/lb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785933598; x=1817469598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrcxuTxEaHXs+XSoVE79k7yizRc7CV2ga7X9/3vaVec=;
  b=mI5uM/lb7N6NWpPGn7mR2PF9CX1mf6Uf8+RTqHz4mV0MS4UwkWapHaxX
   0gql34raw2sw+4StgGdimSJvMiUqaqTlkOJ98ssxkxw/R2iar61rMPSpf
   hlTsRfzW9AB/t/phLQQbp0rinDAKuAj1lP2u9YrKr46jT8wfbLvMoPxV+
   Kw3aL7bRbLQq09n2TLi+LQ4KostOEb+uKLktCVQTJPkLRDr0oMrDgLNqp
   AdYw0aK36uyjQjAN4Dsb9hNdzwq4RVOzByvHxjfWxC3cFZP7O8hV2o+74
   TJBy9Pqbg9JXX8ewI5CoLvPk3ufdUpEJ40R9dgtkBonTEuQacyFYlwXcS
   Q==;
X-CSE-ConnectionGUID: 0E5JIybCRUCtWJxkT17sow==
X-CSE-MsgGUID: duVEymeoQkyuHnA48YGJ+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="112055280"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="112055280"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:39:42 -0700
X-CSE-ConnectionGUID: KWBw/tg8TyCtAV6OjW5s/g==
X-CSE-MsgGUID: NZ5HeV+BRTO6X3IokRkKbg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 05 Aug 2026 05:39:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3F3BB99; Wed, 05 Aug 2026 14:39:39 +0200 (CEST)
Date: Wed, 5 Aug 2026 14:39:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Huang Wei <huangwei@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command
 completion
Message-ID: <anMvC16L57IAiBZo@black.igk.intel.com>
References: <20260805085725.389761-1-huangwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805085725.389761-1-huangwei@kylinos.cn>

On Wed, Aug 05, 2026 at 04:57:25PM +0800, Huang Wei wrote:
> The synchronous command completion path in ucsi_sync_control_common()
> hardcodes a 5 second (5 * HZ) timeout when waiting for the PPM to signal
> command completion via ACPI notification. This value matched
> UCSI_TIMEOUT_MS when it was still 5000 ms, but it was not updated when
> that macro was later raised to 10000 ms to fix PPM reset timeouts.
> 
> As a result, the two PPM communication paths are now inconsistent: the
> polling path in ucsi_reset_ppm() respects the 10 second timeout, while
> the event-driven completion path still uses 5 seconds. On machines where
> the firmware is slow to respond during boot (e.g. some Lenovo ThinkPad
> models such as the E14 Gen 7), commands sent after the PPM reset, such
> as SET_NOTIFICATION_ENABLE and GET_CAPABILITY, can exceed 5 seconds and
> cause UCSI initialization to fail with:
> 
>     ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> 
> Once UCSI init aborts, USB-C PD negotiation never completes, which in
> turn blocks USB-C dock enumeration since the dock depends on a successful
> PD contract.
> 
> Replace the hardcoded 5 * HZ with msecs_to_jiffies(UCSI_TIMEOUT_MS) so
> that both communication paths share a single, consistent timeout value,
> and future adjustments to UCSI_TIMEOUT_MS are picked up automatically.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221740
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=2183790
> Fixes: bf4f9ae1cb08c ("usb: typec: ucsi: increase timeout for PPM reset operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Huang Wei <huangwei@kylinos.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index d221ca9bc88e..37fa20b302ba 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -91,7 +91,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci,
>  	if (ret)
>  		goto out_clear_bit;
>  
> -	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
> +	if (!wait_for_completion_timeout(&ucsi->complete,
> +					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
>  		ret = -ETIMEDOUT;
>  
>  out_clear_bit:
> -- 
> 2.25.1

-- 
heikki
