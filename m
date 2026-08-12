Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706F3B9DB6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530135; cv=none; b=fC04RV4gpangTKUNyo5mjFigU1f0FQiEerBueUoEAFwpLRp+wIUCJHAvSsfXxYmSiR5ZywxuJy5uLeC9qxN4sXaCEQAw7K04DflxXvk+LqcO0IoP/oCSLlFvGi93ar1YRY5CFNWw4EhLh2tjW9Pth4gFUL57Tl/0CF14UTQ9J+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530135; c=relaxed/simple;
	bh=FLzwucoqgqoqYD5vWAO5v/nzGauUT6aN0563qNhH6ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcDXryjU9/6BFsONHdPPYpJniHU9j8BsKVtuqci0jwd3KaEIRudLvBp3Pe4xpa7sK6ggsJAEk5Ovf5TRpCPnYM4DvzINTBZ+xblcmjMNxOb/t+rNe74daP/iHq7BpHHynaN+Raf0kmaZp+vlIF03ihKH7V5DcuyUtvFVrIFE1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhWlxthU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhWlxthU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786530131; x=1818066131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLzwucoqgqoqYD5vWAO5v/nzGauUT6aN0563qNhH6ZY=;
  b=QhWlxthUG5ByZcrBySEALZdzlM8vR+wJ3zs+R713yrlUFwAxOoSyqgJP
   mJX8Mvdxq0eRL9yZxpFTiaGCnu/UiIkPd8sxOFpJAmv/wZ00YKFh+9ZHQ
   eXoQw0O80FcBqbbGJRJeldct/zGZnMqn8W1GRB+TvZZ5ag7i5UpiZkIN6
   2eZH/a7kUdRuHrWS7jj7DK0FgsRFXpzfUNQnTXerbd74t32SOd/kspPbo
   DMtJpXla3mVnLM/Vyo2DoaZ85rg0uauo35eMklSGGox8PUPZtQZCQFMAf
   350xLR1gkeCtexBFpR07NWw9MMcO7El7vHQfK4eLrF0TTiJpcpStovmPq
   g==;
X-CSE-ConnectionGUID: q8kfqAjyR4SK/9anJ2KUbA==
X-CSE-MsgGUID: 7yyMhn+DShqFOQAcJKlpWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87006471"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87006471"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:22:07 -0700
X-CSE-ConnectionGUID: OjTksvmWRbW4Mzu8BRoorA==
X-CSE-MsgGUID: f3S60uvGS/2P/lh3hZjmvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287036032"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.154])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:22:07 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E7D04121C22;
	Wed, 12 Aug 2026 13:22:05 +0300 (EEST)
Date: Wed, 12 Aug 2026 13:22:05 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 6.12.y 2/3] i2c: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <anxJTS3MkvCEckhz@kekkonen.localdomain>
References: <2026080542-curse-dispersed-597e@gregkh>
 <20260812101347.1638816-1-sashal@kernel.org>
 <20260812101347.1638816-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812101347.1638816-2-sashal@kernel.org>

Hi Sasha,

On Wed, Aug 12, 2026 at 06:13:46AM -0400, Sasha Levin wrote:
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> [ Upstream commit ae11e08c3d0c78d08dac4cea30bf39ede2130b03 ]
> 
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Stable-dep-of: b08c9857aa1f ("i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please don't.

The patch adding pm_runtime_mark_last_busy() call to
pm_request_autosuspend() was merged in 6.17 so before this version the
explicit pm_runtime_mark_last_busy() calls are not redundant.

-- 
Kind regards,

Sakari Ailus
