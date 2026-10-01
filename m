Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3329DB8F;
	Thu,  1 Oct 2026 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826524; cv=none; b=u2/efxVWdNrdSpYpakS7S+VRdCgtkyB1nbQiu7hKWqG5XxAINK81BnONhdPvdkRp3tv7LtMUNtOXPt6FaNJKU8QiG4nXEY09QEyCmZPgfnJSFszDQOlNxx0QvSlRro3oGjrkL9W6MD7Jqzc7u5ElHXNZdsIWQI3XRT7BLDrdyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826524; c=relaxed/simple;
	bh=e1JdyBH/hqAFwwUTmozCaUaK7Sn1qFw3e7aAi1kyiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8LjyWyEILqeveXJ6YfctYcxwOCmg9hMcqNdL7Pu3QUb5ztW/foGQd/OfHN8QeM9gPe01njnbXoP0Pz9WG99RtFgnNSaBscH8S8LdW6dNk4LEOtNMguzfKO3FtIyzhbxKZlOXrOxhN0G7p48ZiaXHbvdIgaknX4oVtM6GDYT5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6zneDsE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6zneDsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790826523; x=1822362523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1JdyBH/hqAFwwUTmozCaUaK7Sn1qFw3e7aAi1kyiJ0=;
  b=f6zneDsEy/4fFusL896/FRZMEntk70qYoRCGQqgYy59otZvhfVk4CZVD
   wSvl4ahUwyp/1spMF+bGirxEI01Zcr/nfE4ofh6Jq1JxQcgickSviSBbG
   cqn8y9UmIplpDu7koAKtrv892zCx342HKorBscGDpRKOpaZBMCBsZ5goy
   XrD9mCNoGErZ8vyAvHwB4m91pSJdC0srXqAQZUUQdyNfgCSTnAznOudmk
   tID9iDF+ThvaPTkJyX6rV+Bd2RxrffShh06/AIFfuaqBt8fMYg/FZ6JT5
   W9vk+HLsEjLCwwwXZdAaO5YlhdzGV3ilaOhFS7FvcGDzKKZt64cUb1+lW
   g==;
X-CSE-ConnectionGUID: qpIMO2QgTfeoVfkKf4LVcQ==
X-CSE-MsgGUID: fhK82FJORg2ErPUT+NKP1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90610728"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90610728"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:48:42 -0700
X-CSE-ConnectionGUID: wFZsO/LVRKSmgnXRT70gFw==
X-CSE-MsgGUID: p350iDy1R3KzPQzXBoCqdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283937959"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 20:48:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8226A99; Thu, 01 Oct 2026 05:48:39 +0200 (CEST)
Date: Thu, 1 Oct 2026 05:48:39 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: b2amedina@gmail.com
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix domain reference leak on DPRX work
 cancel
Message-ID: <20261001034839.GA176164@black.igk.intel.com>
References: <20260930-tb-dprx-fix-v1-1-da92659e491a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930-tb-dprx-fix-v1-1-da92659e491a@gmail.com>

Hi,

On Wed, Sep 30, 2026 at 10:16:35PM -0400, David Medina via B4 Relay wrote:
> From: David Medina <b2amedina@gmail.com>
> 
> tb_dp_dprx_start() takes an additional reference to the domain with
> tb_domain_get() and passes it as callback_data to tb_tunnel_alloc_dp().
> That reference is only released by the callback, tb_dp_tunnel_active(),
> which tb_dp_dprx_work() invokes once the DPRX capabilities read completes
> or times out.
> 
> If the tunnel is deactivated before the DPRX work runs to completion,
> tb_dp_dprx_stop() cancels the still pending work. The callback is then
> never called and the domain reference held in callback_data leaks. The
> domain's reference count never reaches zero, so tb_domain_release() never
> runs and a subsequent shutdown/reboot hangs waiting for the domain to be
> released.
> 
> Release the callback_data domain reference in tb_dp_dprx_stop() when the
> DPRX work is canceled, mirroring the release done by the callback.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Medina <b2amedina@gmail.com>

This should be fixed already by the patches in my fixes branch, can you
try?

https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/log/?h=fixes
