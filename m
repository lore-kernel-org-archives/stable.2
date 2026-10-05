Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487620E023;
	Mon,  5 Oct 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222298; cv=none; b=rueyn7MLfOr/XsP153ugLFPKSbkzC8NOdsUJ2fFjL9DBJlr/+UDZzN7D18QHchgCJMzTt+lOBO/FKGm8jpg3qufLEVU3qc8k/EoRV0aoiKZvpWaAYSnBSex0XDBumEEb+o1dTYycu8lPvJAO0H+Q6h7lhhFvJfE/zrvzfp/tVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222298; c=relaxed/simple;
	bh=PZ34xtNrbmdDwRo8oAM75wRaxkfuQ/u+Rvb0EJ5jNlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p4SLuOjaTx2EoAHkxZqjOqIse9VPa6qdtlBLVTd0dawxHeCN1fv3FuJOAPyQfRpQ0T8mIgF0XljgwzbM6F2QTHSdZuKHZAC5idGE0hfs7BpdiysKeU09uocFiVPl8idUKETu2CSrhglpyW8w8VHNhpSA0X8lotRQEAk/oC4d7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftk0gv62; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftk0gv62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222297; x=1822758297;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=PZ34xtNrbmdDwRo8oAM75wRaxkfuQ/u+Rvb0EJ5jNlk=;
  b=ftk0gv62V0uFjSAB631dBTLRYavmhGj4ZajO8D0Ieg5rW8eT0O7aDHlF
   N4dCxPyWqZRCNaXS1W55WuomXIhv0QEU8mj7tqOgnWAnFJ9UtbsQAvcfM
   g4vooEjKv19SeYbYyokcflIG35p7xUbWm5rMsfyZxh+Am0ACWvGWKLC38
   EKpEu5PyWngPWfW1xSxBubiw3AGocWJIgQP2Zo0aY3OsPAGcHZsnonzDs
   sWGgWz4zgen7EsOc0iGSIH1HLhWMlKiB8pMWDPiHRXHRT9syyj0BhW/t8
   Wv2Hzmtq8wB6VjMNQEpo1booLspZWVCwjVO2EXYPsXrB2e3FSurhWncvq
   A==;
X-CSE-ConnectionGUID: LIc7q6xsRZW2chSk+pIA8g==
X-CSE-MsgGUID: EbqdHUAqSlGdK3Pc/fjGCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102064011"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102064011"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:44:57 -0700
X-CSE-ConnectionGUID: Vevv1ClTQP6DONBMIyL50A==
X-CSE-MsgGUID: chqxonyITlC1aQRSlGAoVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="937180"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:44:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Marco Scardovi <scardracs@disroot.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 "Luke D . Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Corentin Chary <corentin.chary@gmail.com>, stable@vger.kernel.org
In-Reply-To: <cover.1789722252.git.scardracs@disroot.org>
References: <cover.1789722252.git.scardracs@disroot.org>
Subject: Re: [PATCH 0/2] platform/x86: asus-wmi: Serialize WMI evaluations
 and drop redundant rfkill lock
Message-Id: <179122228971.27048.14573857783638253323.b4-ty@b4>
Date: Mon, 05 Oct 2026 20:44:49 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 18 Sep 2026 11:14:58 +0200, Marco Scardovi wrote:

> ASUS WMI management methods share a single firmware/EC mailbox that is
> not re-entrant. Concurrent evaluations from ACPI notify, sysfs, HID
> callers (hid-asus, asus-armoury) and debugfs can trigger nested SMIs or
> corrupt the mailbox.
> 
> This series serializes every ASUS_WMI_MGMT_GUID evaluation through a
> global mutex, then drops the old per-device wmi_lock that only covered
> WLAN rfkill hotplug.
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
[1/2] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
      commit: cb63a1472d982dd837fb148eabfcf1ad0dee161c
[2/2] platform/x86: asus-wmi: Remove redundant per-device wmi_lock and duplicate rfkill ops
      commit: 293806b33aec63f2d47f51dae9ad26bd47afc552

--
 i.

