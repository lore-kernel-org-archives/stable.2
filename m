Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253178;
	b=memuHiRLEdA4NuJEhKo4cYK8auDj9Tou1H7sC1A+lB+7WhqWkGdV3DrdGQI9mtDQ1X5c
	 Nh7QrvQhgzJRk5IIjdZUVhUgwpE3xfRy0TnskW0SiywPjmCi+7N1+n3o+Hlu4x0HSnJWV
	 itur/+mQ91pYw2yKt77i/OlJkTnqW8wEXFFcPfoqvNvF/NASDYORE3KgLNeyxUmy8gXn9
	 /MQf7VMwegPOOpMP5j+0vHatpjPfQDGzLoYJp+sAYKLw3w3yuXk6GxCT2gEcpYmhswAPu
	 YlwaPE7bfQLwWCRqz0FGiDUp5B7ktUQDtRvZMRLwFUmbAcuhndgqK9NnwGouqFeUUsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253178;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=AO6k7VhnPykl5qhHlZJsMqShpDZ0BaYxHbA6JDryfgI=;
	b=zFNnGAMZMhacXZpokguIC4xeail5BpNWhPuEPRtd2lejMoGZlRv9t8HUs0iGi3NofDqY
	 2++2I5DXm68jn5FplHj9GpvD9t/5ZwkwGCHijz9UMd40gzWPPM4501DlDAEEohyEcEsU7
	 iUmD+Lp5p6KvguBCjhhBndABKMGajbDfEPRiwi86qpONgZDdH4qNGmC2QTPy64b9aduoo
	 YXGYV1uk31O7RqhFCSOu8/BgtlojRFpa+o5T0nuRGvxFtCvhOZRTB3812GBJnp56PFuzY
	 6+tRuFWY/sHe7mN3Z3iYyeERc9dsegrmDgbaqekBrzMVg5OPojrgYbf2X3P8MubTj8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C5xOgybl;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FE606A330;
	Mon,  9 Nov 2026 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D0FE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C5xOgybl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794253177; x=1825789177;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=l/IGU87br/8GR7Q3A8JKigp/P5JkZtjTrJNcbWbgJm4=;
  b=C5xOgyblT90Fqo4wsRxZEoV4SbDTbVzHiIhcO+guz4P6xvbHGkhj8lOw
   JuyuYSqSe5an87HiXrcjL+6p3pxNyseLlcRtynjNfCHpCYjmr6o3VYUFU
   rwe/PuWwzq9ZxAyI19I78IV+fqpBjmLYM6/0BldTDXj4vfJ+wp5jUfnIW
   TPw0VcG2/2WZSsAT/44KEQR34kaeJ0U+QuUHGN38hPqimYEzVzd7UmsmA
   y5rA6QzEg/vLzXhKC3YTm1s8p888DDRhuTfYCHjT6wZC1frnd6Ciw6j7z
   FFaeGcE3iBgJjiVUFB5hPC82quwbJHAVfo2tgN8L7URFGrTykHu/jHAyZ
   A==;
X-CSE-ConnectionGUID: +dqBvUqeSeqjq7NQ7KeqMw==
X-CSE-MsgGUID: QHvuVOF8QiSsXRj0ePcevQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3090764"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3090764"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:39:37 -0800
X-CSE-ConnectionGUID: S3vCqCXiRbi33fK07+TDoA==
X-CSE-MsgGUID: 09MmypJ0TM+iKDRxsL0HoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7810163"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:39:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Darren Hart <dvhart@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261026083042.3982005-1-lgs201920130244@gmail.com>
References: <20261026083042.3982005-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] platform/x86: toshiba_acpi: fix UAF after IIO
 registration failure
Message-Id: <179425316878.10927.5628001844548737863.b4-ty@b4>
Date: Mon, 09 Nov 2026 21:39:28 +0200
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

On Mon, 26 Oct 2026 16:30:42 +0800, Guangshuo Li wrote:

> When iio_device_register() fails, the error path frees dev->indio_dev
> but leaves the pointer non-NULL. Since the probe continues, a later
> driver removal or a subsequent probe failure can reach
> toshiba_acpi_remove(), which may call iio_device_unregister() and
> iio_device_free() through the dangling pointer.
> 
> Set dev->indio_dev to NULL after freeing it so the remove path skips
> the already-freed IIO device.
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
[1/1] platform/x86: toshiba_acpi: fix UAF after IIO registration failure
      commit: fec3ad5dd1411c3b05f5ff1ff21a5025a0fd68f6

--
 i.

