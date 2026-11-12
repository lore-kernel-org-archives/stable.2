Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516709;
	b=eyyOUx8KE0hjE/50AcKIdATjIuJt3Bc/LBEnN4E+5VzPh5A+4xKFUT6bQJYYXzIoWZc8
	 ASLLmkaqXPuO1wJjc+yAdN/OjxUVzrbYn5mX6gOHtmHqoFzeJ4nZTQfW6TAjE0vM0ue5q
	 WwIa+8rdvzxf7m5p2jnB129F7SkBBUByN2f6OWlnO6oCUBoFVwPlDYnRBqe2z4iSuPecJ
	 e3Kp9zkmJ5YTSnsofsKoYDJciogxge1b3igpYWLIUI8J+NwpaKQKsc1yaNnygYscy7hPv
	 fy6Rm3ITCBRd61SUJYLHVMlTxOqC06ClxCK8jSbE+GoCKdgkwm7TS7aSySxXJfrQVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516709;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=P8hIUpMBWFPVL6mV3TWXWd6G3FSR8vMEZSdZssGprpc=;
	b=qIVAIFQ82c1uDE2PqoaoRJ8DtM7HI1P550FqoIl/nzOph8zH81O9UCyBu2uNv3xjNxuM
	 y7cU6thqnRmwfSwoszULnjjcAP1LsYPrAvMunB8YV1l+o+SOWaYIvKpW3HFMB1/G2qlHu
	 zjYoiFlMAV4Yzaxe8fWNySy+t2nHLfHg9nW2W88HK3rseO53BhXci+PAAAuRKaXrqLhss
	 1vP96w52Nk98zZmkld3xGxaayMMCvV+XZNfv9aAUQoccJec29FiPWX1jOwzpRto1bpawq
	 4eVHNXvwOZC9HsZEteMLhFGlofKrLGyLAf9VOdYxSGoMloDsvk+4GxozfpMSVYObSTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwot8IUa;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F3606A31C;
	Thu, 12 Nov 2026 20:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwot8IUa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516709; x=1826052709;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=MRU+T/ZapRMmO0n/n50xZ6wMLQpLIyDCBWRPpE7KrDU=;
  b=lwot8IUaNS8/r9Lzm6oGPS0fmFXf8PA4EXOZGQG6aSBg7wDPEV0C4hxU
   NPxUqxUgrAZUcaTykCim72ZwS97zIPQxxTN/QLjun1to9bPel1PtobCIA
   tWLs14+OBBfgovEiunSaDEGSapfVpnFSdWfyK+VXjVBxBz4vOC8pDDK/z
   NrOOUk8mFHDHr5zksYomaVJ3RUnK4gotSyoBBk/Sw4kFz7+cx5axFam7p
   1uD87clVjcQ29Bi+Jrnb7f6t7SbJ6aJrXU4nfz+CRzokkU9TGN0NX94nb
   cqk5qmBZUxNB5r2F/8+dK2gU73Il4ElXm7PQjq8JV2MSiDYWwaNpPSGuz
   g==;
X-CSE-ConnectionGUID: Ky9x87deTGi5CSaWEgkoMw==
X-CSE-MsgGUID: sv0OG98IRTqC8/hkWI6VFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3346610"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3346610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:51:48 -0800
X-CSE-ConnectionGUID: iA/Be0LcQ86RdGqRh5sEDQ==
X-CSE-MsgGUID: vk9FM+/zQuCBpe9MfMpYSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9089924"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:51:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: luzmaximilian@gmail.com, Wu Enqiang <janussss@163.com>
Cc: platform-driver-x86@vger.kernel.org, chris@nilk.net, 
 stable@vger.kernel.org
In-Reply-To: <20261024054921.48209-1-janussss@163.com>
References: <20261024054921.48209-1-janussss@163.com>
Subject: Re: [PATCH v2] surface: aggregator: propagate -EPROBE_DEFER from
 ssam_irq_setup()
Message-Id: <179451670088.11882.17094899653516205494.b4-ty@b4>
Date: Thu, 12 Nov 2026 22:51:40 +0200
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

On Sat, 24 Oct 2026 13:49:21 +0800, Wu Enqiang wrote:

> gpiod_get() can fail with -EPROBE_DEFER when the GPIO controller
> providing the "ssam_wakeup-int" GPIO has not been probed yet. The
> current error path falls back to fwnode_irq_get(), which returns
> -EINVAL because this device only declares GPIO resources. The probe
> then fails hard and is never retried.
> 
> This has been reported across various Surface devices since v6.12,
> including the Pro 6 and Pro 9 that were used to reproduce it. With
> the SSAM controller down, dependent ACPI devices, e.g. the battery
> with its _DEP on the SAN node, are never enumerated and battery
> status is missing.
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
[1/1] surface: aggregator: propagate -EPROBE_DEFER from ssam_irq_setup()
      commit: 56dd7ee477fd2889babc452106ad3a5301c2040a

--
 i.

