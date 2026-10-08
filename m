Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393B3B14C6;
	Thu,  8 Oct 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481065; cv=none; b=dpyhqyvfPfqmFtzQ8irsQi5mc0yQyuPEax3a0/rxo2/0cHn5ypi4+CrSOxV/nbUjtF4SXCIdgMonTrxyvHhe+g/uRR3mQzozKfadcgSckEKhbl6q0HIvTr94ZHvR+tGG02RJrhoV/dMPoSmXsV8s8xilHpA3xawRCWKq1jemH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481065; c=relaxed/simple;
	bh=OdDcaTjKtRxj9r2WnDxnm/yJGB2RcDemplWn36Wr8Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QqaBqwyfs0cDSyFN3mb0QdnbD6JVPu+QaRCqbEbsc8gkFz6FoiEqVhVUQYeEk0SNiAhLnYOBGPW8BB3S2DGEu2OfU9waEJoaYq0708Ichphijog+ZJTKogjxuwv4X6Xt1oE9nEmO+1g1WU5PHRl8B7HmDYYISNWIWX6ajLXqzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYCMO53K; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYCMO53K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791481064; x=1823017064;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OdDcaTjKtRxj9r2WnDxnm/yJGB2RcDemplWn36Wr8Cw=;
  b=VYCMO53KOiYCppmywt/VjyVoaoq87JFCPegAWu6/aT3+kcCV0BRf/O4w
   EhoBCIHRn295rhB46P8hb7sV4/6pqceVeh/dx3yRHD+rc0c1ARxsmgnHl
   2YQKT05OydEsQDYg6h3NsYO8LJMISN/9yMv7ybJxF5zPaIdcnBG7NLAEJ
   feWaTRQpPj7nC+tDdd+cvmDQDAaqAyNMwbuGfZt/QVJO7EUUpcSvUBOBs
   vgm0wMjv8h+KJiBIOoZ+W5B3ypHiA5SB7vIcTUSTUCrwl4CbkakM+rjtu
   WFx5U4ZCYg2wtnEJJSvhDOfo6I2vkiOTEt3OGsvRBXZVTCP6PgpVk2Kwz
   A==;
X-CSE-ConnectionGUID: WW0Q3pNTQUarYUnm/FiH0w==
X-CSE-MsgGUID: 6hgXXSGWQ82/Z4R0HLne9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="170829"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="170829"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:37:43 -0700
X-CSE-ConnectionGUID: dbs4ysXeT22yIrL1BApD4g==
X-CSE-MsgGUID: aljnPPbqS/a/Vfr9U+Fc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1859788"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:37:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bao Cheng Su <baocheng.su@siemens.com>, 
 Benedikt Niedermayr <benedikt.niedermayr@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Henning Schild <henning.schild@siemens.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260924115617.1578309-1-lgs201920130244@gmail.com>
References: <20260924115617.1578309-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] platform/x86: simatic-ipc: fix platform device leak
 on registration failure
Message-Id: <179148105282.29028.8593722043212919488.b4-ty@b4>
Date: Thu, 08 Oct 2026 20:37:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 24 Sep 2026 19:56:17 +0800, Guangshuo Li wrote:

> register_platform_devices() registers the battery, LED, and watchdog
> platform devices in sequence. If LED registration fails, the battery
> device remains registered. If watchdog registration fails, the LED and
> battery devices remain registered.
> 
> These failure paths leave successful platform_device_register_data()
> calls without the matching platform_device_unregister() calls.
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
[1/1] platform/x86: simatic-ipc: fix platform device leak on registration failure
      commit: 84aa6bb468d27c2bf3694c30914ebecb6ebc97a4

--
 i.

