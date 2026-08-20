Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51B3ED3C3
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230248; cv=none; b=mhN246RWvEz+qeoIiUzMeqdEiodSVIQFoSx5xcrENTLfnNT58wRlnwEg8Ys5GgGt/SHCO30TSPNz6oFyo3Rrj3l57RgfUa4I/6S/+TCbCkmdrepmSJcgNKx0a5AtT/GsVOCoCZY0W+PwoyrK7o6oxuYTtMJ69aDaogAL1/q2wa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230248; c=relaxed/simple;
	bh=vIuzLiY7OxCmfcl5opyGG5r8wQFHqJEDnbfBxie1K74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZzyEOLjADALYOJ4FaPMWZwLqiJ9rteYTOa8t0G4CK6uOAqRZTkvQv/KscZr67zaXixjQw/W5oTL/ikti0nwiPyWU/8/98yw6vB22upqKlEzkMW32HgahlIwjc2gx5cXso9RBO7dkrmMcVG4PrycnRUt0DTxmx4MPxQ63YQ0/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5Q2lW96; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5Q2lW96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787230247; x=1818766247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vIuzLiY7OxCmfcl5opyGG5r8wQFHqJEDnbfBxie1K74=;
  b=k5Q2lW96eobz84bqDlS9nKGxQHXKCHLm7MF6X4/1Q0uO7VJVKe+Uz29U
   S/kAPsH+ikdeP9kbfaYC6ddd9msnGdcETGZgs49edGKgbgLOYwDdBHkKU
   10SSx9vaPfsVgVt673f4mDNpWONnXzXMj49U88T1nU8VasVvG6FMH21Xz
   LVUP7S4upvry40iaeUxiilm4h1/QChcfhT0/cP0ThE8EeKr0wFZBy/YwB
   hPCN8BDV5YlpDtdx7R3IYcRjVY7nTcacDYF70fFHgsCNQuXSYPws9sHHl
   KAi9pEYV4E8IoUtsGrd81G/cFJ8gbcQbGXTlniUUVuMZVd5hJYHyB7ifh
   A==;
X-CSE-ConnectionGUID: s52HmidCS9WXj69dFig57w==
X-CSE-MsgGUID: oxOjjAAeTyuGOIOcqJtNvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91441897"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="91441897"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 05:50:46 -0700
X-CSE-ConnectionGUID: ricorxZrRCuTHae6yrJGRA==
X-CSE-MsgGUID: 5iNnPi6uTPqSr4fUcTw9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="261765027"
Received: from szadworn-mobl.ger.corp.intel.com (HELO [10.245.246.124]) ([10.245.246.124])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 05:50:43 -0700
Message-ID: <6e773e06-ab3a-40fd-aeb2-f411ed51e412@linux.intel.com>
Date: Thu, 20 Aug 2026 15:50:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Refresh copier
 IPC payload before" failed to apply to 7.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: broonie@kernel.org, kai.vehmanen@linux.intel.com,
 liam.r.girdwood@intel.com, stable@vger.kernel.org
References: <2026082016-frisk-riches-3e59@gregkh>
 <1142f719-4f26-4a2f-be99-af4822cd78b1@linux.intel.com>
 <2026082057-sulfite-daunting-34da@gregkh>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <2026082057-sulfite-daunting-34da@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/08/2026 14:49, Greg KH wrote:
> On Thu, Aug 20, 2026 at 02:45:30PM +0300, Péter Ujfalusi wrote:
> I see major conflicts here:
> 
> Applying patch asoc-sof-ipc4-topology-refresh-copier-ipc-payload-before-widget-setup.patch
> patching file sound/soc/sof/ipc4-topology.c
> Hunk #1 succeeded at 3167 (offset -37 lines).
> Hunk #2 FAILED at 3221.
> Hunk #3 FAILED at 3229.
> 2 out of 3 hunks FAILED -- rejects in file sound/soc/sof/ipc4-topology.c
> Patch asoc-sof-ipc4-topology-refresh-copier-ipc-payload-before-widget-setup.patch does not apply (enforce with -f)

I see no such conflicts on top of 7.1.9 tag, checking the original and
picked patch with -U20 I don't see any difference in the surrounding either.

I have sent my version of cherry-pick as per instructions in original mail.

-- 
Péter

