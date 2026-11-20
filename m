Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196747;
	b=eJGOOCx7fxARPGjTppgYm56/zp2xHb1JnEZzciITUslv7CfytcB42ujyHq/SNh/OBjhc
	 h/+fq9jw8WdoAcseI0WAX/AgtdudK4PeWt5A6u/Lv87sT5tOgiuQ7Yqw9RYpFIqa/mkU8
	 wF19UI2j1a4Kv0MBD/ex8zTEHXOkWt5i0Z4KATQYM1JMbGMVgSitrwpuOfxqijA2UMyga
	 lPBYmW6dz92KCJUW78Ny33C03dSM3AbfHFkbofnf2yCnlOpdtIbTPgm5ZeCwiUK7bQdh9
	 ww4UYGTPVVgVOcE9DiE3mob6y45ZB0/azHxSlkV+iuZ4XCmQSJkP5/IsqB6ueJFRujA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196747;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dD5U44nHrFTl/AAIBulcJRmC+nCx2LZfUKFNl03tD2w=;
	b=5LbyTnqnky52Ep1+EVv+9KMDQFi2fcQYQvbNqq5Ab31QgjUu2j0N7RfsswBcOSW9cfMW
	 Xy3r0rARG4oHcspkSYj58L7Gttu7l/m8UQv9g7s/y0tOVGLjhsJxKZwa77Qmg4SA5jME6
	 aDq+5r6PZNmSdhj3EInh3tWc3O4/9YhVKkrl6Ks4cO8CRzivdoZatPA8d6lsGohucMBZD
	 GYlcWFM3zlEuK08n4WCGq1P6/5lJNUizloeHBYv98/CJReR+gdx9J69YfC94UjGSYrq3B
	 byrHAhyns84b7e2/SWvl6qJp8IXrweXLf130F1yag3inVXOw4djNKDTmmvOnFArDhOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AC5TAC6S;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7007606A337;
	Fri, 20 Nov 2026 17:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7007606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AC5TAC6S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795196743; x=1826732743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u77/hB+36LpY07PfSLYCOFalxai0/Sr7Rp8nDWfm1a4=;
  b=AC5TAC6So/Y4lmsTMUUvjJ+1A/RzeIG9yB/luFvKnJyCDohN2ROd00cU
   ZrMCbh/qiDNgpcPsXXa5r1Y+c54iaQGj3q7zk2+0iV1PKxOhI6PRDffTY
   lxrq2wFJvlwmfU9umnYQN1NrLLysj539/UkUcoOHv1a3Wy+d+TdUVTMMM
   mjjjPbqAo2rvN1efVAh2yh5mX625xUHbmQcUQQ2y1EUvClmu9QYcvLQcM
   qKm0GO4RA4dH61l0oIetRc0aq+UBkD48tP75YlPUlof4og6ZU+/2ML3Fm
   wh6GX3Xo62vE1AkiIrhKxunub6EHru/RAZeYKlT1pbg3DMews1ktGCN/+
   Q==;
X-CSE-ConnectionGUID: AXyOQsLRRmWUAtQjOTvtEQ==
X-CSE-MsgGUID: fOyez4xdTxCRkXPJ0NZ22g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3963609"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3963609"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:45:42 -0800
X-CSE-ConnectionGUID: 8rRwW6b5S5SFrW7/L1fIyg==
X-CSE-MsgGUID: gK95g7QHQNKN/WvFEctnqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10564344"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2026 09:45:38 -0800
Date: Sat, 21 Nov 2026 01:36:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chris Down <chris@chrisdown.name>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jeff Moyer <jmoyer@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: Don't leak reservations at the physical
 address limit
Message-ID: <awCFFu76KVuQHTCu@yilunxu-OptiPlex-7050>
References: <avAH5XMCbIWvdD8R@chrisdown.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avAH5XMCbIWvdD8R@chrisdown.name>

On Sat, Nov 07, 2026 at 09:25:57PM -0800, Chris Down wrote:
> memtype_reserve() and memtype_free() pass their physical addresses
> through sanitize_phys(). Both take an exclusive end address, but
> sanitize_phys() expects an inclusive one.

This reads like both memtype_reserve/free() need fix, but in fact
memtype_reserve() is already fixed, you are simply following up the fix
for memtype_free().

Make it explicit by referencing the previous fix, that makes review
easier.

> 
> So this has the effect that for a range that ends exactly at the top of
> the physical address space, the mask turns the end into 0.
> 
> As a result the ISA range check succeeds and memtype_free() returns 0
> without removing the reservation. A new reservation that overlaps
> existing entries takes on their memory type, so the stale entry goes on
> choosing the cache mode for that range.
> 
> Let's fix this by doing some annoying off by one twiddling.
> 
> Fixes: aeef8b5089b7 ("x86/pat: Pass valid address to sanitize_phys()")

Maybe you want to reference the previous fix, but that's not what Fixes
is for. Obviously, aeef8b5089b7 is not the one that cause the issue.
Please make the back porting work well.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  arch/x86/mm/pat/memtype.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index cf94fb561310..007d833b4c00 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -613,7 +613,7 @@ int memtype_free(u64 start, u64 end)
>  		return 0;
>  
>  	start = sanitize_phys(start);
> -	end = sanitize_phys(end);
> +	end = sanitize_phys(end - 1) + 1;
>  
>  	/* Low ISA region is always mapped WB. No need to track */
>  	if (x86_platform.is_untracked_pat_range(start, end))
> 
> base-commit: 5cdc3746fa163fb4e8d05fa3cabf46bc6aa7df75
