Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24336B905;
	Mon,  5 Oct 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226372; cv=none; b=n8XO3qmn0ezoqReTogRM6ubTPfkoMzRxZcED9zdIchSSOwlSQhUxF/60UL7hSicypLk11j5sda1MWKdv0RIeY+yXT9D88LMX/3Lh+SE4lZsA8naLyh9MY4Fhy2kjnsflhryxtClOJ5ebjIg50M8oj3ousnVtSWSqhcGEfQkMv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226372; c=relaxed/simple;
	bh=OkJCuGC2gGRqCjdLY+RRAaxFUzi8cu/lPqoc8P8kmzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sIcPZnyEKCBUgfoOXhijmjSIcvm64KE5HZfij7692iSvogCcw3Wceo+vJJtr6d5lxr2q5F2cY9YoD2swH+IX2ZvRh400HTtlxTDNGRkxjpxC9Edi9yWN07xKVKfWXVeQ+aGCwvE/bMZ3gn5TGkMilYiDRbp+4E/ltOBsegG3H1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAugaEob; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAugaEob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791226371; x=1822762371;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OkJCuGC2gGRqCjdLY+RRAaxFUzi8cu/lPqoc8P8kmzg=;
  b=FAugaEobMs/cmyYMgM/ND6L8F+HRT5n7YmvcbIWzKTcAREZGzRgQ1AkU
   xJQFZ7Bj8I8vFSb9ql5JYLaNDbIoPcPMkxUtPQuL77zRhNHslnP9KB8vH
   nAMGXOAJVMWIhUtxrfv+H4ydemkKKLjK8F44DgouSmjB+xHhizq85YO43
   OYJzzzyNOWui4BqFU2a0eZtuSnNEOQOHoGtiK1MlZoAcvYMXYg+Hr1Ig8
   aeJu9VaelzrZuZHOCnEYaXNnupxy2V94DxlFfTTIkpji16HCU6X5r6nq9
   5nWHggnEuTGrCKzBsinWMe8b4frk/RkVm2aBnTezJzujNPu4lcSnY69o8
   w==;
X-CSE-ConnectionGUID: 4a2vvGWLRT+xsEiiVhi4pw==
X-CSE-MsgGUID: ng9vBIB9T2OWbqD6wZ2T3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90860991"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90860991"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:52:50 -0700
X-CSE-ConnectionGUID: wF7BIzXDR5mu0UVZxFCBkw==
X-CSE-MsgGUID: mVJnbkY7RKKA06LkEVFGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="303160445"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:52:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
 Ciro Pedrini <ciro.pedrini@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260925205226.883724-1-ciro.pedrini@gmail.com>
References: <20260925205226.883724-1-ciro.pedrini@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal
 profile support
Message-Id: <179122636351.41716.18367302210533871678.b4-ty@b4>
Date: Mon, 05 Oct 2026 21:52:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 25 Sep 2026 17:52:26 -0300, Ciro Pedrini wrote:

> The HP OMEN 17-ck1xxx (board 8A17) isn't in omen_thermal_profile_boards,
> so hp-wmi uses the generic thermal profile query. The firmware only
> stores that value and never acts on it, so the EC stays in its default
> mode and the CPU is held at 45 W whatever profile is selected.
> 
> The board uses the OMEN interface (mode byte at EC 0x95, thermal policy
> v1) and also needs the timed profile quirk: without it, the EC drops
> back to the default mode about two minutes after each profile change.
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
[1/1] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
      commit: 06ea16200e6bbb9bb91a34fbf892c5239e7a070c

--
 i.

