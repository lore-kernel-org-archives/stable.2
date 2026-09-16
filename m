Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F14C041B;
	Wed, 16 Sep 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556448; cv=none; b=a/uP60qeoKF75o9RfkUQdfCk8JwGfMGouluVtCT8JxtKHVZZFwPHfH9MgU9NLWDJ1/cr/i5LTLWd0xc5S04SXdGFbp9osh1Wo5KsNxKpaA2e6YgaNQayx0OSf4YMJrRjevqTVaOLjgge+JUxyO5NgiZfphwql0cb/WvC7jI8s7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556448; c=relaxed/simple;
	bh=PJpQYbu415ELCrfr0jCIFjBdr7v2k5CCIebbxVzZso4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JYc4a+Zrs0lVaaCQf5avI4zcvmHPIgR9+B5hTZbEPsqTBolco+LcipEz5YQy5yPBLOiNmuhBjDjYmj6yNkNPTSM/yMzGDuFzC/2pQS+4MzbnXsrxjhO/kq94dzCFZIq6FJTiFs7gTMd4JbShxJ8P9b0S4vGKkVEd/CdP/W3rvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uvn4mx7c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uvn4mx7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789556436; x=1821092436;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=PJpQYbu415ELCrfr0jCIFjBdr7v2k5CCIebbxVzZso4=;
  b=Uvn4mx7cS4tObIELk60D3CVVB4dvk6VwMABjWaUmBt8l9i2utKKI9J+8
   L7+5x94pv9tuxhQKdOOIwI9pC/OKCTR7QmWB4DomJZssniCx91u4Ws6LT
   7M+w5ND9w2JWXWF7NOBZSzxq1Pl8ebJFe7XvhwFuVpvIpZOTQqtodbVFa
   4Ir0E+7zDaSFsA/qTrPjAaQnjzNy1E8iaMPD/uLFM9fYm4Dc23W8HgpWn
   fXsyv8hzY6PGD4+Tf8/G5wm5vIJAqMgnzjTGtQtn94WyWaYhH79nvjccm
   6GhZO1/qK5UwvgFHJr9K8VgXm+HtW+ixgzFcRg35GDNhCtyUD0ll9IUN2
   g==;
X-CSE-ConnectionGUID: i1AXW/0cSM2EkfJALiyxCw==
X-CSE-MsgGUID: 9UBsu7qhTl2ksZf6Fe2cFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92436558"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92436558"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:00:30 -0700
X-CSE-ConnectionGUID: wWRFzWo0S/KoLdVZnBZ0+Q==
X-CSE-MsgGUID: 42a5cbN+SNqLFbCAPVCsSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1708830"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:00:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
 Denis Benato <benato.denis96@gmail.com>, 
 Hugo Baigue <hugobaigue2004@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20260915172608.14234-1-denis.benato@linux.dev>
References: <20260915172608.14234-1-denis.benato@linux.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: fix use-after-free
 unregistering kbd_led led
Message-Id: <178955642375.2305.2037186031246803284.b4-ty@b4>
Date: Wed, 16 Sep 2026 14:00:23 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 15 Sep 2026 17:26:07 +0000, Denis Benato wrote:

> kbd_led_update_all() registers asus->kbd_led with
> devm_led_classdev_register() on the platform device, but kbd_led is
> embedded in struct asus_wmi, which asus_wmi_remove() frees at its end.
> The driver core calls .remove() before devres_release_all(), so the
> deferred devres release runs led_classdev_unregister() on memory that
> has already been freed. Whether that faults depends on whether the
> slab has been reused in between, which makes the crash on module
> unload intermittent and silently corrupts the led classdev state in
> the remaining runs.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: asus-wmi: fix use-after-free unregistering kbd_led led
      commit: 2f5005e261ed758254767a32c24587bfacc6db82

--
 i.

