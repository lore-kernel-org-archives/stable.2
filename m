Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BA379990
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035012; cv=none; b=Q8QLVllpxQeDi4uOCsYEseKdt7fZCezSPZrxf5XJyrKGJCKSS921vcbOTcArSw96HEYss75Qw/yalmkip0Fzktvk37bywPH8VyMdZrJW43dqpRkRgXtwsJESr2/keNzmp7XAoVkXst2vKJ2cCz7QYOyBpHuB7VWO0i/KygF1eQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035012; c=relaxed/simple;
	bh=Y8i5Gv2cLNVREF+rGyrT+RPmWuzhF0tSjM8P4S74rQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr/MfBw5z6j+VuVNSfdUGvqSnCp5UZx7E3mjIGM4t7Dc8bGFjfMoUcAgcRvd2ixA2irQOclHy0ipilp0XcNtn7c8gIiUlUUrK62GjbmDR2fHQOPKashYPDyiPDPb+JhXE9k2x1TLZ9q+WIPta+KkT1KvkHcpWHg4DS5t6w+ejyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqMYDRpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqMYDRpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637591F000E9;
	Thu,  6 Aug 2026 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035001;
	bh=r5kkuAZi1cFbhidHs08hqRpg6IHgOP7AHWcJc0lBDrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YqMYDRpw8/z1lfQ3xpuDlTWCfMlsMrQ6YdXnnx3iS7+bLk1Bi1Jk9ziaWbI+4lqvo
	 Tty/6GLO31YOPajoLIjdLpNxLd25LAVnAsUignSsMU/VU2qaeeeqUqLQY7oBHS05S6
	 AqbTQa7+/3pYQUzEoC1zJFII+/+heFVdD0bNEE7UQTraJKAh1kj3JTLgbf1+9/hgkw
	 2IDG3ud9R5Fq3TrH3zEsXkAuWtj1u/nlSkCQewVd5KnIotl9Wj5Xk+q25bjazTpCSP
	 vLTdunQgo35+k4uf4we0qpDgdKR2u5yiuPeV5ev0m6Ev2Ew9YgYNeoWdNMReRmPxXT
	 RSYYyZqks5Rgw==
Date: Thu, 6 Aug 2026 12:50:00 -0400
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y 6/6] KVM: x86/mmu: Rename __direct_map() to
 direct_map()
Message-ID: <anS7OLhkr67ZDsx4@laps>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260730192933.3123642-1-sashal@kernel.org>
 <20260730192933.3123642-6-sashal@kernel.org>
 <6c049895-dfc1-4cb4-b90d-35d2ae503153@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6c049895-dfc1-4cb4-b90d-35d2ae503153@oracle.com>

On Thu, Aug 06, 2026 at 09:49:23PM +0530, Harshit Mogalapalli wrote:
>Hi Sasha
>
>On 31/07/26 12:59 am, Sasha Levin wrote:
>>From: David Matlack <dmatlack@google.com>
>>
>>[ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]
>>
>>Rename __direct_map() to direct_map() since the leading underscores are
>>unnecessary. This also makes the page fault handler names more
>>consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
>>direct_page_fault() calls direct_map().
>>
>>Opportunistically make some trivial cleanups to comments that had to be
>>modified anyway since they mentioned __direct_map(). Specifically, use
>>"()" when referring to functions, and include kvm_tdp_mmu_map() among
>>the various callers of disallowed_hugepage_adjust().
>>
>>No functional change intended.
>>
>>Signed-off-by: David Matlack <dmatlack@google.com>
>>Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
>>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I don't see them in queue-5.15 , FYI.

I don't think Greg got to these yet. We normally let these sit on the mailing
list for a bit, for review.

>Also I think along with 6 prerequisites and final 7th patch, we also 
>might need: commit: 9f33697ac7ff ("KVM: x86/mmu: Stop needlessly 
>making MMU pages available for TDP MMU faults") should be a clean 
>cherru-pick.

Possibly, but there's no fixes or stable tag on it, so without an ack from the
KVM folks it won't go in.

-- 
Thanks,
Sasha
