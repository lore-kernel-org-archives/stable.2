Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB2442109
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014713; cv=none; b=U9aFdzMbbTOWWL+CI8gX/SZZpNHJ1MBPGR6dAMDio98KtsriSD08PC1ibO9WnTBxE25BVsp/sG2B3B48K8HbAhGrnG1TaS8q9XmhHICRLYIyovGg3YEtCDE0+hZf45nvtF19O//U5M7fniVeTNaL1OvM8cFM9vpOhNSF4cRtYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014713; c=relaxed/simple;
	bh=9TqUQ1cEN1iSqYeQKVPH3b6O7vlJmwNuvfTAHuje9SI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OeR3lW6HSGCK6nIrMc7+5EHVcKgv81AZGboh08Pzu7RXTLhfFKrZAyuTq5dRxpq/H3y9hV1I9l290zdqoJMUp99mq1EUOb/SM3zK52UEoP07TyzpsA5nkuFAR3/90kvkES+lJERaXc3V7WlIzwpLJFT6cnRuCPJwSiUSeWeM/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beK3IHy9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beK3IHy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786014705; x=1817550705;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=9TqUQ1cEN1iSqYeQKVPH3b6O7vlJmwNuvfTAHuje9SI=;
  b=beK3IHy9NmB91ozB5Pn8kiIm2HPLKwoBaD4Gpgc+ZMMdbpd4y500RfAr
   QNzBqwGfj/9UOQyoR2XO1T22TEf7qCYtE+KzCeO2dPh4df78jW2jALZUc
   nbRLzLb41ID+9RG3JAktlC8l9e8YJ0fpmaa1vNJvvc+IaiRbUhx+IlLj1
   CynA1d7wcL68G+d0CAgkMR32AKPtsRba84LT1ovbKiKyWBhtuOyaAjUJT
   bV65i2Q43hhnnw/q3u1ptjJvggNq5/aqHevt+RSeklIPtVHiLivXtN3C4
   dU2p5BEbqEWBiXUcQS+NenqG6dW/f07bKs8cQMqPlEaldPzTdHHAxgtjI
   Q==;
X-CSE-ConnectionGUID: Le8VHS/fRtKUbrkabReujQ==
X-CSE-MsgGUID: dB6TIbUrTki/kpSSTvcYeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86616020"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86616020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:11:43 -0700
X-CSE-ConnectionGUID: beAXEw2aTPufaFFjbwCZiw==
X-CSE-MsgGUID: o7oimXP9Sky+ViulMjT5Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267222759"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.245.11]) ([10.245.245.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:11:42 -0700
Message-ID: <424d6e9f-3e33-4f06-bbb3-11ce2d6e2607@intel.com>
Date: Thu, 6 Aug 2026 12:11:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
From: Matthew Auld <matthew.auld@intel.com>
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, stable@vger.kernel.org
References: <20260804165057.129529-1-jia.yao@intel.com>
 <20260804165057.129529-2-jia.yao@intel.com>
 <88b53afb-d7c1-4da1-9708-d0843be27b6d@intel.com>
Content-Language: en-GB
In-Reply-To: <88b53afb-d7c1-4da1-9708-d0843be27b6d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2026 11:30, Matthew Auld wrote:
> On 04/08/2026 17:50, Jia Yao wrote:
>> Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
>> CPU memset operations on it, which eliminates the CPU as a potential
>> cacheline-polluting agent and helps maintain consistency between GAM
>> writes and GuC reads.

Now pushed. I tweaked the commit message here, since we missed detailing 
the contig related fixes.

>>
>> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
>> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.12+
>> Signed-off-by: Jia Yao <jia.yao@intel.com>
> 
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 

