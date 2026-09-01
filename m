Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216437A851;
	Tue,  1 Sep 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250770; cv=none; b=HMUgiEIbV/IX7FbuifYpKVaWOaqpylrZ7a78kgMpi89R9AAjHxGotUFBlb0+vOK7Gt33pO6/sq6AqaDu/+JLsq1WikxB3fmyuIPvVfdO/PwkXv0AXmZP3A7A6uSY0GhQEMZbHH6iBBnc7xixXcaSPIb6A/y2Voigtb1HpBL/zro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250770; c=relaxed/simple;
	bh=33uW+A7VN8o9QY5De0mnpKtluG0XoYT1In59tmM0yHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMxOx7+Yi9CZFKPJ2/cz87xLdpTfN5SYytGqFvGCDhKz+mFzmsa2wIkxxkr74bD+EBQVWCgWi9XxDQ1yJa4RNofaFacOeTPLudzNNlv52amdA7jPOaBw/gdQUhNQ1iV6Hg9GSXHH+Rg4L0r6gcsiFY8Amn52UFJcyTep1s2iMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0o6Q4u0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0o6Q4u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788250769; x=1819786769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33uW+A7VN8o9QY5De0mnpKtluG0XoYT1In59tmM0yHc=;
  b=k0o6Q4u0bXo7r4VQnzx5ftwcRI4YoeU9A1Vzfnlv56llD/TPlSf7W+sj
   TdXzsMjmn/G5/mp475A4ZloUPnDbh8M5SOQmRnlEG5xDj12dEO2URX502
   KmBhj0loHvXg85cxTG0b8E/G4LJ8xZs5xrQ4IlgvOYDcI1W1qhLd/udV9
   h8nMHtB2WB1W67CK1xWrdivkgVBkoywMnBywxPRlgzfswBmwM9pcGZ8Ap
   jQOdmo5+93n1RB4PUBxgX2F8r2t2vDhFV9zOiZ1jvaoaHUOGvXEkMx1DP
   dpePYO4ImocUe96Di2QD3EC1EQp3yYN+I3Fv5Jo7UltyYd2f23y5ol27e
   Q==;
X-CSE-ConnectionGUID: CVGlo21STaq/eRMJpTbZ5Q==
X-CSE-MsgGUID: HFETvOEtQnSgTHUzRtWfuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99831437"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99831437"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:19:28 -0700
X-CSE-ConnectionGUID: AGfkyWGGR5eZtn19L41M/Q==
X-CSE-MsgGUID: SjPY5xXpTgaPLamYkxyy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="264744147"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 01 Sep 2026 01:19:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F34EE99; Tue, 01 Sep 2026 10:19:24 +0200 (CEST)
Date: Tue, 1 Sep 2026 10:19:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/7] thunderbolt: Fix DP tunnel teardown while an
 async DPRX read is running
Message-ID: <20260901081924.GA106095@black.igk.intel.com>
References: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>

Hi,

On Sat, Aug 29, 2026 at 10:08:32AM +0200, Sven Peter wrote:
> Hi,
> 
> This series contains a bunch of fixes related to teardown while an async
> DPRX read is running. I ran into some of these while bringing up the
> Apple Silicon NHI and just haven't implemented DP tunneling support yet
> such that the DPRX capabilities read can never complete and will always
> time out.
> 
> None of it is specific to that hardware though so I figured it
> makes sense to already send them out.
> 
> Best,
> 
> Sven
> 
> ---
> Changes in v3:
> - Take the router references in the HopID allocation/release helpers
> - Actually call put_device() via a cleanup action for the KUnit tests
> - Link to v2: https://patch.msgid.link/20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org
> 
> Changes in v2:
> - Make the DP tunnel activation callback mandatory. The DPRX
>   caps are now always read inside dprx_work which now also happens to
>   discovered tunnels when they are activated again after hibernation
>   restore.
> - Mark discovered tunnels as active
> - Add a cleanup commit to drop the callback data that's always the same now
> - Tear down DP tunnels that are inactive in tb_stop instead of
>   exposing tb_tunnel_cancel_dprx.
> - Use "router" instead of "switch" in the subject
> - Added comments how these issues can be reproduced
> - Link to v1: https://patch.msgid.link/20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org
> 
> To: Andreas Noever <andreas.noever@gmail.com>
> To: Mika Westerberg <westeri@kernel.org>
> To: Yehezkel Bernat <YehezkelShB@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: asahi@lists.linux.dev
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Sven Peter (7):
>       thunderbolt: Hold a router reference for each allocated HopID
>       thunderbolt: Make the DP tunnel activation callback mandatory
>       thunderbolt: Fix domain reference leak when DPRX read is canceled
>       thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
>       thunderbolt: Mark discovered tunnels as active
>       thunderbolt: Tear down inactive DP tunnels when the domain is stopped

Applied 1-6 to thunderbolt.git/fixes, with minor changes in the commit
messages and the condition in patch 6, thanks! Please check that it is
okay. My testing at least it works as expected.

>       thunderbolt: Drop the DP tunnel activation callback data

Since this one is a cleanup, I wonder if you can send it again later when
the DPRX fixes have landed? I typically base my next branch after -rc1 and
don't merge fixes/rc's there constantly so preferably after v7.4-rc1 is
released.
