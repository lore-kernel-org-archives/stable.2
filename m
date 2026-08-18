Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2547ACE1;
	Tue, 18 Aug 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062114; cv=none; b=o8cyAgqD2XsGLw3njaW2Vvimvuby1b/4L7SDMLSBUOVG5+LB5d6uGE5INNILxKuR3Uhi2NVeCdkgkwk+D7oNNrgKX/ybJTIppcghNFwS9vSqF9HCQUqs2z9Iws96iSJjmrqqntM+Vm0KENfEvqBaKLbYG+9ftxrRwv3oNcEjyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062114; c=relaxed/simple;
	bh=cKED0Y4IdzHMkV8Qp0NSOrGrJiZ0XV34uWgZR3v/CZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dnlsaniks/iKEKhuSdpKtYQsA5BA8hav88HkBKcviX/nswSF5GvBzm27iv+dnowpjmQJhas6I2Cj5JdXXiJDa1OlcmrVZzTACn6Z5/CP0x7mH+RdnxlC52ThzILksSTPHt+a4XasT5+4YTWGNsg9emmYQC2dcXCSUu1iZimTyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HM8nnweF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HM8nnweF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787062113; x=1818598113;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cKED0Y4IdzHMkV8Qp0NSOrGrJiZ0XV34uWgZR3v/CZo=;
  b=HM8nnweFuDojpEuf4nyrqVPY2aWkhkt5xCYvARLOYCvn0V9/ORYaOA0J
   YuhSXqSccP95quV4OdzMSZo3zP6rbYc1VnBx+x/8Do3wEySGG4R3dxCYp
   ckHP3M9bJpy2igYoDnGRu/2X8gZNJfspowc6GrCdmbz/a4d+d8q+GF4gC
   v6dMNDXLZETJAGqpUU3qQFTDtboiycefKcU3HJZ+5Fi/chTVnMGGI7lYk
   xGiVBJgyGiYnzDJBP+TNrawDsFpwDC75sCCVnL0juDKAQWk/YMlAmqesI
   SlE5OpBfbJfOVd/0iZ/7xHgNcednmkbbwQZontOzn3mUJm2sqpzg5AxzV
   g==;
X-CSE-ConnectionGUID: 3EJrAo3ITyakZXqZ1+BxQw==
X-CSE-MsgGUID: xEfJjst4RmSWL1tbClLHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="99075234"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="99075234"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:08:16 -0700
X-CSE-ConnectionGUID: o1uce3ScSGOBRnTPtCQkRg==
X-CSE-MsgGUID: EGCIcLpITZaNhjUYeAopGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="288746212"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:08:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260810120556.149416-2-thorsten.blum@linux.dev>
References: <20260810120556.149416-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix certificate thumbprint
 sysfs output
Message-Id: <178706208906.20251.4997070874066491480.b4-ty@b4>
Date: Tue, 18 Aug 2026 17:08:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 10 Aug 2026 14:05:57 +0200, Thorsten Blum wrote:

> cert_thumbprint() already returns the accumulated output length, but
> certificate_thumbprint_show() adds that value to count again, making the
> next line use the wrong offset. Errors returned by cert_thumbprint() are
> also ignored and their negative values added to count.
> 
> Assign the total length to count instead and propagate errors correctly.
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
[1/1] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
      commit: 38443e5748496086940a2033fd2102b702109287

--
 i.

