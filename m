Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB62261B8A;
	Thu, 20 Aug 2026 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269846; cv=none; b=Q2RsUm3yzDjs/k7pQ0QOVp+rxDSw91n0xofOH0LK0/rhUAcrSec6fYWYA0RIor/9vaDRt6Mpqawpzgils1Qyoi5TvEcY2uqNs6hyyfQ9CgoLcVPJOX3QnViL1sCBT7a+DHfIsUky2nGq34C3pRExf7hHBs+dTjxx/ps7VEcR7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269846; c=relaxed/simple;
	bh=IgVE/lr7YofvH8yLY/jmG/IdEV6+Sa6k+Yr1vR/A0TE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vGc/KxX6TkSRFxBBaIue6APfQeUUxGdKrBo5YxvhtmKOjpQMqfaGCyC9gPF0DmthHMxCUTpJn8UncddMi+8qhM5eddDvVKHxuP74RpGgrWRpD/q5oszSf3z2PMEmhYJIyO9er1wkfvc6jnrCzXVDEBu0DSUDhDdob6ComZwNbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR55DVVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR55DVVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB41F000E9;
	Thu, 20 Aug 2026 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787269844;
	bh=QRZ+PTDJY57nN80ihzFkuyF+etn9biA6akSbuthcJ34=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=bR55DVViWaTUbBrmSFAtG2etlVFOfgO8u1XLbP0C14GkcBeUv3NmvO28pXXullVwO
	 OH08nh+WEdjfa3/BcjIFwckU4tfyQDZdFJ0rI612dADw5vjA5RZ4Z9P/QxYq3qNR1Q
	 6NfHF1goFnzZbnX80/PAVfyL8OP289wJP9g16567UiUMp1BwuLOOtnoQSQiGQueBAL
	 eR1lvdA+TQLx+dFZsP3ZbPFOWe5HR47ASDyxR/i9PqxQulapkl/Se9sfqzYgovfEV+
	 xWMylRecxmh69TclPBCAVkJVsKfpcaD2fT7veLaNY3IV+EsS0LkBizc9d2LTddIsaU
	 fiV6IVLbEfPhw==
Message-ID: <b12d9999-44b8-4b82-8d6d-72ddcb398cff@kernel.org>
Date: Fri, 21 Aug 2026 07:50:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260819180635.1165300-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260819180635.1165300-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 02:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In free_segment_range(), the curseg evacuation loop only iterates up to
> NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
> types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.
> 
> Even though these in-memory curseg types are not saved in the on-disk
> checkpoint header, they still occupy active physical segments at runtime.
> If an active in-memory curseg happens to be allocated within the segment
> range being truncated during filesystem shrink, failing to evacuate it
> will cause subsequent writes to the curseg attempting out-of-bounds I/O
> on the truncated storage range.
> 
> Fix this by expanding the curseg evacuation loop upper bound to
> NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
> out of the target range.
> 
> Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
