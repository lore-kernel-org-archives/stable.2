Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191F35DA76
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496980; cv=none; b=QaNR2dLLSR7DAmd6RwKq3NWTnjYnbal+9y/smL8dJrDcLK0Ftl9kXxzigdaNI7G8c1Z6vmGuem6cTIntm9fnWwaXEYSVAzUl+YebwvAEHo+A6Kkns4e2DW7ueTzSEUKoD/k7GvDaBkq8RcvuSobhDbUSRy0IQfLjvcOnsXJg448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496980; c=relaxed/simple;
	bh=kMwGUDAu/de3tkt3jVhD/aGmQuGBHseVSfGHs90L+h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDX3/fx6ZB6U6CtUhOG1RcNXpBEzE/bmP8l0O4JlQiH3yj67XDmwehdGH30mXtu5/dG14qPWjocXAqmedca/vW3liRu8qd356zR+hndkFlVATvY3RyzgQYm+o6IOX98JSf+HaIEzgzt9DTytq08g5acgx+kIwcDTfxGwbhLj/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOREZIZT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOREZIZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785496979; x=1817032979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kMwGUDAu/de3tkt3jVhD/aGmQuGBHseVSfGHs90L+h4=;
  b=FOREZIZTj7N0PGXOSf4ImGCBfAtyY08xs+K7ollyznhDz50FXksKQamc
   2pcR7XPkp6BBhChmv3/X/1ssCEKXSZFcfnVWzmv4wBcwja5cqUAIscMnN
   P3wsMo6YksvPe+0iG6OD9EjQWHcCD8wWCh3oAifrm2iMR/pbA7p7Bfgnj
   OABGHUBxyVrroPTlGT6G3ZfX+HNCC2A5is746Of3j+YtgD1hVzcKmKq6r
   yufgSlKxE6Ico7Dk3K3Y99lGzOCqDSzaqChUTVNDwO6WrOJ1O265vXFqv
   J/XwgEMZzsHfqUoGsmoMIUGoVMAyzaq5XGCVmz9ZSNZ9Co6DDV6D+8hze
   Q==;
X-CSE-ConnectionGUID: AhdzksIDQVigxqeoOuZSUA==
X-CSE-MsgGUID: C/pQLebeSJCNEs5cVVkk0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89801006"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="89801006"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 04:22:58 -0700
X-CSE-ConnectionGUID: 4LtVhJbuTuSUwtChfnsZtg==
X-CSE-MsgGUID: 6x7TqhZFQUGl33kkRcc3jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="254250054"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.244.78]) ([10.245.244.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 04:22:57 -0700
Message-ID: <7477c473-6027-4941-8a0d-fa6b90dd477d@intel.com>
Date: Fri, 31 Jul 2026 12:22:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/xe/guc_ads: use uncached mapping for UM queue
 BO
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: gwan-gyeong.mun@intel.com, stable@vger.kernel.org
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730232712.517989-1-jia.yao@intel.com>
 <20260730232712.517989-4-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260730232712.517989-4-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 00:27, Jia Yao wrote:
> The HW unit that writes fault descriptors into the UM queue ring buffer
> may not be coherent with the CPU cache.  If a descriptor write is still
> sitting in a GPU L3 cache line when GuC reads the slot, GuC sees the
> stale (all-zero) content from DRAM and forwards an invalid descriptor to
> the driver (Faulted Address = 0, ASID = 0).
> 
> Mark the UM queue BO as uncached (XE_BO_FLAG_NEEDS_UC) so that writes
> bypass the cache and are immediately visible to GuC.
> 

Did you mean to drop the fixes tag here?

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: <stable@vger.kernel.org> # v6.12+

> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

