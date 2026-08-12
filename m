Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370E412C04;
	Wed, 12 Aug 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573227; cv=none; b=RcfqMi2s3cM6jqnkK/gBNYUJLSLnEuk6hQTRkejL1lE7qNE8qfGCfVFRR78oZkaoijX+B+WWUEaSeFRTNYfDVbaNY5N1YCdoGaAksE+fvaU9FImFW31WjRtxCfnUfNAMNQ6JUOcNy/DTEtJzrNEkEUQZVQT243sB7OI2gGb8UHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573227; c=relaxed/simple;
	bh=YxLZ64E1GdPvRZ5LGKEPY82I3i1UumiSn75DwWCccUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agwB4PJKWzcrU3cyiLT76F70ANeoOZJ4kSSgPKiWI5t9i44SUvFO3p3hz2wl0qEEKN7/m5CPHDvvds7JMEtrCyKEu4ik8IjAWfHgewlEsntl/xB1nBH6LnTPcekthZ+QuUB0rDbEgQAjUXnjqJF8eq9Xn1dVpAgxC3d3K28ZvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9DvdeZe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9DvdeZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786573226; x=1818109226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YxLZ64E1GdPvRZ5LGKEPY82I3i1UumiSn75DwWCccUE=;
  b=G9DvdeZe7OfRYwt9GMdj1+jdG9l3KOHtXW1NEZG+KjCd7713eUOUdFih
   pj5nswa/zzCgeErDTT+e+MieskAHs3qxIblE/S6IMfvGK1nxdgfE/Ql6A
   a3BKCkWulfSWp5YveDLgZzyRO8muLlggXLVdom+69ilKrcW4TBVMDUB1Y
   i0W3bAv8811snJkbj+Ki0Y5wsIie/07stRVdpPuGa4aGVC/r6y1vVz8mT
   7fQYOIIbAyGsyYxhXxSA0gVr47+ifkTM+Q48e562S2m5zpm+hUCVAfN9c
   LSwqx0vaUpttmXBf5qBNlVEPHi4OaEfRFSz445pSn4oGepvm6W92sSCRL
   g==;
X-CSE-ConnectionGUID: lwLYsYAbSf6ASXSUOPJuJw==
X-CSE-MsgGUID: yHPDhQBLS2eyNexX369Liw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87021706"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87021706"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:20:25 -0700
X-CSE-ConnectionGUID: xCREYhKvSy+NW7YeZdCQJA==
X-CSE-MsgGUID: fIo+W2OsS7C3mtlsNHZK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="262456670"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.110.206]) ([10.125.110.206])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:20:24 -0700
Message-ID: <90c2be6e-fe03-4da9-88d2-fe4d4f745cf2@intel.com>
Date: Wed, 12 Aug 2026 15:20:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, x86@kernel.org, syzbot@syzkaller.appspotmail.com
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <anCwUb9lV18v6mfN@kernel.org> <anXp--mLLEE2Qo0g@lucifer>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <anXp--mLLEE2Qo0g@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 07:34, Lorenzo Stoakes (ARM) wrote:
> In any case - Mike - I think you probably need to respin this on tip
> x86/mm anyway?
> 
> Maybe worth doing that and seeing if that makes life a little easier for
> the x86 folks.

Yes, please. If it interacts with things in there, a rebase would be
much appreciated.

Also, please do send things separately if they are fixing active
regressions or bugs that folks are hitting in the real world. We'll send
those urgently and not through the normal tip/x86/mm process.
