Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504766;
	b=yfKYZ1lIL30mrDKj2AJjxTVCxdlL+O3Yao3ZrFHAjkse2bfi+qB9ClOeUxqB0t7b98gE
	 U5QKGwJdOKE+8VBxVgUf27v9DFxJpl/hLKdN/BXS/rF5wdLwLP5ZTuHd9ALqXJYR8SIDo
	 q1WlchIgvbjXmxzHmGKI+k+10iaHkJLJD7mDr8JYPUnyRy0OqeWb1DsuLh0CoEzdhH8PY
	 OLNXZi6Ea/igDguNPnBXKSHxiYbvFJLWIt7mIWyb2OzGE8rnjopcCw+ijmVR6I8nMU87i
	 FsIt0eE75DGZlPM6hH0c7ZVOhebveqpwOzAVg60f5QPmhlF4ynetR89gKj0+lB48QyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504766;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=iqEGW7YrXkG1u5nBLzxdbiaTFloAHoNSMLITrHG2DkA=;
	b=4JFcHh6JPuoj492uFQlcyh7P2Upy7MAH7UUbDZU4/YnFC/wq8jKdVBPFwKYn1o7/cSM3
	 EJXpvCM7QqM5suHyLHkOndLqzUXLCjszeSaqpB2ubPFC2ZqT3SJRedwSwlllJiJS3ZQ2x
	 xGROPHhhWBu7lZqxU3WEmfve5ahdxoJ7lZM970qMJCv2ghvq8s07Kzvca8+1wRQDJAIOX
	 7TaFglBYt8val3JfJ5C5EicAPyEsVNKKSpwmp549S5Z+WVzE6dlWW+EpYr30MWWbv2CFj
	 sOcNmF/JKOIQL1Y3sPq1sLEFneOmmHSAaQITHnf9S36Co6ReAuO/5ba619w1C3GRDAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8asuU4n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9F606A31E;
	Tue, 24 Nov 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8asuU4n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6BB1F000D0;
	Tue, 24 Nov 2026 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795504765;
	bh=iqEGW7YrXkG1u5nBLzxdbiaTFloAHoNSMLITrHG2DkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=m8asuU4nq8UldY+Y4KSPoTLuU7iU0LyPs9C2HSVxikOL79jBA6D0zp5HmX9t0bukX
	 udEQCVy5QC3MHftfBfOHGsNHsoNYQYICMXxUteMwIdsSFRph9lqSixG35OK12GBf2m
	 oO2HGzkeuXHHatek2UuZwKso4tm854cmT/mfLSLSrmRoM/c2Et3g3o8Kwztj4uxjCt
	 etsXcoyHI35pUmmc21TkPHCPcNXpW+55xCqCSj0fH426s5bzGCjHRSObR23a+IpacQ
	 /rNuKnT3Mgyn21MCifeA8o58iAPB3AeBL78Uf1lFiGediLBErQwJI7flJEQqdLUWzK
	 1ppPM4CPFCYcQ==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Mani Tofigh <mt4022@columbia.edu>
Cc: Chris Mason <mason@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Tal Zussman <tz2294@columbia.edu>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
References: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
Subject: Re: [PATCH] mm/shmem: don't drop a folio whose swap write failed
Message-Id: <179550476098.5668.10320150453441389834.b4-ty@b4>
Date: Tue, 24 Nov 2026 08:19:20 +0100
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
X-Mailer: b4 0.16.0

On Mon, 23 Nov 2026 12:21:34 -0500, Mani Tofigh wrote:
> shmem_swapin_folio() drops a large folio that does not fit the mapping
> from the swap cache if the folio is neither dirty nor under writeback.
> The folio can belong to another file and be under swap writeback, when
> the swap entry was freed and reused before the swap cache lookup.
> 
> Swap write completion does not take the folio lock.  On a failed write,
> swap_write_end() marks the folio dirty and then ends writeback.  Since
> dirty is tested first, the folio can look clean and written:
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/shmem: don't drop a folio whose swap write failed
      https://git.kernel.org/mm/core/c/e3464357

-- 
Cheers,

David

