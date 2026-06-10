Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DF409121;
	Wed, 10 Jun 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098197; cv=none; b=HfLL5/zTTo8oplwUnXlL1VFFP7UmQd0b4j5m1Zti7TVG1o5G1ZNhpUS7aWxOKEJkQn5RTdYPQuEcNI7z3uw7QQxnvlRRKAa6EhkjVLkU4Zp00qK3+fHweBv9czmX4A95YO9JIhjp+h6w6SOlEWaQlNGgxe6+z6tXLFNlQM+lqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098197; c=relaxed/simple;
	bh=dbe+9BOyBVZOsjR1kOBJIjg4Nr9ScyqXDu18kJGNKww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zr8ZsrVhWyuiFzsWcWbZ2geF4LKFcXW5PrecY727sP1jqozUgVzctXGcgYjMG0C0pLvEz5fRAX1myu1kcs4OOJ8wZPDN8iva4Gw065MUCkjEpfamiqbuqYkj/AfmKlZaWWCuuWYJdF7/1o7TS8vbTsBrbuSozJrz5mpdFLlZoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndZbZav0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndZbZav0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781098196; x=1812634196;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=dbe+9BOyBVZOsjR1kOBJIjg4Nr9ScyqXDu18kJGNKww=;
  b=ndZbZav0AIBiVOSf8eiBN860sPJieZCC5WxnXAa/lSgYjuaEwcqwxCE2
   qFKZvX7xoK2W6IFdifLS/FuEQ3S7IvVTgL9rfZ3s7gZQ4VvEurIJ6oUCN
   JCyjj0hxw5NyQQPJbHQqVBAvF0OLSGmaN53cYOULncRvONQ8BlBFgbJZL
   15FjS2JKbrYm33EaaB3i+9gBIshHRdTxJwN/JAB6cNDLyYv4E8qTk+Wem
   K3VC78iAK6Ir1g2eb4PivQhQTOMK7KVBjuaJ+NtwKp3HhHfIkKmOvhty6
   uhOuLZoQsO6W7FkXg8fpO49FCbY4esL3yKDK0FOU+1Z/v/v8uvSZEv89n
   g==;
X-CSE-ConnectionGUID: 05Udg7a/QUSAvxzVqhx+xQ==
X-CSE-MsgGUID: bKyPYGPwSD2AKxGyznVEWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85517576"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85517576"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:29:56 -0700
X-CSE-ConnectionGUID: K2RSPoAZQSWvyJLWmMFYgw==
X-CSE-MsgGUID: gYG+bqfrSHqqc5YLEzJ9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242040028"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:29:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, hansg@kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Guixiong Wei <weiguixiong@bytedance.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260602020752.3126-1-weiguixiong@bytedance.com>
References: <20260602020752.3126-1-weiguixiong@bytedance.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz
 after CPU hotplug
Message-Id: <178109818931.24283.13969327178546972194.b4-ty@b4>
Date: Wed, 10 Jun 2026 16:29:49 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 10:07:52 +0800, Guixiong Wei wrote:

> When the last CPU of a legacy uncore die goes offline,
> uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
> re-add, uncore_freq_add_entry() still populates sysfs attributes before
> assigning the new control CPU. As a result, the current frequency read
> returns -ENXIO and current_freq_khz is omitted from the recreated sysfs
> group.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
      commit: 6b63520ed14b17bbe9c2103debbd2152dde1fba3

--
 i.

