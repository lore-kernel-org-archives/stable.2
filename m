Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F940912B;
	Wed, 10 Jun 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098191; cv=none; b=TYNp4Okq1Owy0A+tWChOPwTWnyAjPSIb610J7LMgGYwrDCQ1jWqGADnGvOeJF+g9+aXmLFH7B2KteAU31PONp4cU82tVVy/fwSaNVTzEs2w45GuuLHBf/rsv60gRtemKlZDG1LnxjqH6u9cJ7r0468cKo6SyvTiZQqOQ54zmE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098191; c=relaxed/simple;
	bh=D+FkAqhDBf9T2E0ScM8NB+BKwUhwi9qp/c5R0ptiMcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q6OBh7h4aHBDlUXE622ikiI4iX1gpXjmLGLolk7pODzUxfFxy7HJoA4ueLDjjcvcxCkProe+IPPvi7GMfnTtemxDYTH4kWeZY0AQwvIhqqZMs6Mi3/nlFUP81HRNkY96nxpzJ02ehoeHK9jhSuJiZmQC5AF9POPYc5ZUv9ggAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT55veI8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT55veI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781098190; x=1812634190;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=D+FkAqhDBf9T2E0ScM8NB+BKwUhwi9qp/c5R0ptiMcg=;
  b=ZT55veI8A1u7U8PTLC3gvOau2h2pHxE9I+K7NoMqGQGxQdfYq5nBxyad
   ifJSwOV6YhV0OqHndoFfJ4mdJ77cBigsjpP1mruLNDQhGloPAVRHAEjvI
   hZS/YAdHBJ9E6qC9wVeNqzOAQ2YQXmY1KFe5C1W4DMr+JMRE1qdFosMGI
   DM69ocTMQGCcD9d9XGZv+J6Gogv2PxgTvLZUqOqPjBPiVqHNGFyEdgQrm
   QLRx2YG/nQa83veizpN+eE/mHi2JDMVAkCcQ0g7Hzv6/R48l3oeyKLLTz
   FnWmDXoj5MQnI0u2bTGSZKbOhJWA3AWVbILHjIFdug/At2OGjNb7wbmJd
   A==;
X-CSE-ConnectionGUID: XpGjEQnMTNeYKjAIrX30XA==
X-CSE-MsgGUID: X355334eS8G94L1SfenaCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85517568"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85517568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:29:49 -0700
X-CSE-ConnectionGUID: bzIxUL0iS3KiwNrMgGAu7Q==
X-CSE-MsgGUID: KTvIRKcGTjeqih7UPTC4Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242040019"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:29:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 HyeongJun An <sammiee5311@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260605174905.131095-1-sammiee5311@gmail.com>
References: <20260605174905.131095-1-sammiee5311@gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Protect ACPI notify handler
 against recursion
Message-Id: <178109818072.24283.15797736389185718869.b4-ty@b4>
Date: Wed, 10 Jun 2026 16:29:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 06 Jun 2026 02:49:05 +0900, HyeongJun An wrote:

> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on
> all CPUs") ACPI notify handlers like the intel-hid notify_handler() may
> run on multiple CPU cores racing with themselves.
> 
> On convertibles and detachables (matched by DMI chassis-type 31 and 32 in
> dmi_auto_add_switch[]) the SW_TABLET_MODE input device is registered
> lazily from notify_handler() on the first tablet-mode event, via
> intel_hid_switches_setup(). When two such events race on different CPUs
> both can pass the !priv->switches check and register the priv->switches
> input device twice, resulting in a duplicate sysfs entry and a subsequent
> NULL pointer dereference.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: intel-hid: Protect ACPI notify handler against recursion
      commit: c085d82613d5618814b84406c8b2d64f1bc305e7

--
 i.

