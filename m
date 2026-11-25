Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649274;
	b=oOLRUdiaD6JYBLN3013zmeXa+Q9gVkXQa+RYravxT70ttUKZnfrZ97nqy0uJL7Rdpp1q
	 mUgaEAcEZKEbqMlN5eFk2VJK77lzToFsVKBiYSuGaeCY8WREhVlaMLj3AeOQ7PJqMTj5C
	 MT27oOL6eDpDfzAAGl9BUYVaV7wfbtV900MjvRM3INPtcnRyGA7ALrQjm8AZho4n937BF
	 aEw+iiE9aVl6OOj6GOGLbxB7zVlvjPeiKP3r71BAxeOSZ1UFtVuTm9yGqB3LJKI4NK3+c
	 dUoMvU/kcC6+LkSAyV72apj+SE5mIWIPC7ikliZ+CeWH5CTkt3o7v4UrUpA9qQ51tDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649274;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=rs01krc+wqBscjKS5ouFiuc/XjIr1tXXVQy7AXGKTpI=;
	b=Rou7roT0B9OA7JC7f0rH8tYWUj6AbYfxqzIUSsqwBcfHbT+hG/lURv0+in48ALKQppyw
	 TrNs0UP7EAi+urUznQ+BgKOuFX0/Me4uK9Tt/orET9spwvs8339zXgxmERxOkKmAwWZt7
	 oJ6xUrWsFkFcCH3q81wxIKkemOpabVarNKfAhUTiOBY1id8zw1JggiOd5riEx1Ea9MBpI
	 xusyNq4TQVzpgpyE8m8fsnrHC/l+Xycqlq5yQWWDv872FTVORcZPEx6613TxcuOWxUzsq
	 0RaRPlzrTpz1eexg9KAd7TsWUbz3KCjQSAYKRiI7NeyBwFUZbJ3WfTlHq+jEn3nOzFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PSEQeemw;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C894606A31E;
	Wed, 25 Nov 2026 23:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C894606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PSEQeemw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795649273; x=1827185273;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=IqWWeEtddWMJJhPbjNAGipU35XPv+oibVCKPS2QATBM=;
  b=PSEQeemwh6wAJu2C7hFtZ6Ki6ttLUASYEwqLUtiQiJpJfjsoMkt22NPN
   6fcneTbCnsjrsyW8X53sC4ZI7S8EHSn0QoNGkc4KuqB+KCJqph1Wz5piT
   wMZbHQ2a/pnrBzEVnL1oZDd6J/4jOiIwykci66VqXdF9qT/zZVjjCWc28
   uO3xFoFuVJ7m2qa/Uh+vuXAAtI5hOtqmfsziRrRaCXqQjD0xPXTOxIUx8
   hCQ6i9tHvf978zIACFYJg9K7sDfWfv4kd7+aVNllH4zXHwfXz6jbyiWlK
   NQ7Viocs8J+iki+GOtGJpddQ0fhrmTbXC9J4fSmHUiUTSWHunHNJxI70Z
   w==;
X-CSE-ConnectionGUID: 9reLNfWSTcSIbaToxs+HWw==
X-CSE-MsgGUID: rBBTTSTAQKO2w8nQdJ+B8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4451069"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4451069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:27:53 -0800
X-CSE-ConnectionGUID: KRByZqxjQoe+boaOGiMPbA==
X-CSE-MsgGUID: ejLiUDIDTuWVykIpDL34cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11889592"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:27:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Bullo27 <matteo.bulloni.27@gmail.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org
In-Reply-To: <20261121125207.12284-1-matteo.bulloni@mail.polimi.it>
References: <20261121125207.12284-1-matteo.bulloni@mail.polimi.it>
Subject: Re: [PATCH] platform/x86/amd/pmc: Add T14s Gen2 AMD (20XG) to
 s2idle quirk list
Message-Id: <179564926576.9828.17218975210270395593.b4-ty@b4>
Date: Thu, 26 Nov 2026 01:27:45 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 21 Nov 2026 13:52:07 +0100, Bullo27 wrote:

> The ThinkPad T14s Gen 2 AMD is sold under two machine types, 20XF and
> 20XG, but only 20XF is in the s2idle quirk list. On 20XG machines the
> Lenovo BIOS SMI handler runs during the NVMe D3->D0 transition, so every
> resume from s2idle stalls for about 10 seconds with a black screen.
> 
> Measured on a 20XGS08D00 (BIOS R1NET68W 1.38, Ryzen 7 PRO 5850U) with
> pm_print_times: every PCI endpoint's pci_pm_resume_noirq returned after
> ~10.32 s, all finishing at the same moment. With the s2idle_bug_mmio
> workaround applied for 20XG, the same callbacks take 38-82 ms and the
> stall is gone.
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
[1/1] platform/x86/amd/pmc: Add T14s Gen2 AMD (20XG) to s2idle quirk list
      commit: aeff3c10c05e8dd07074d8ab5533af1c1fe2ff8a

--
 i.

