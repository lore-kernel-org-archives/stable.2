Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098537;
	b=5fjaCYJWSw5X60Gqc8UgInLrywheLsTZuNEzyouAoUJlK01RCKf/77OvPgiGSw62eb3e
	 lBBaPmokpk88v76xylHazvGKrvaytVhbQAPxz/sWa3hH6U4NReZob3D7haQluRjP1YKaX
	 t2ahb6OaX+9HBFg01dFg89/hSIBf1RwXmrBNRGYQY5gcdKx91McgS3u+D9d9ZUBPoIbDR
	 c+w4CPlAAdvy7N0pXliPfbv50DIjfXro/VsQOluuDHKPK8bpLUxfzy1VZDW3RNtc2bMgG
	 UO16LPivBir5lXzTww56ist3hhsXqHZ/1f9Z7aEer61RBrOk6+Nof3TDClN+3mR0AUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098537;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AKbxYvklE+RtW/4px6T7qZCglKItX3GKgrMwqEp3qDw=;
	b=qhQ68tJ0DHfjqdFUt9JhzenICw2yLmojAVRhHu7lcuTPzkBCgEGvNfTtswj83THOyiki
	 3fyrp4cUPd4as8Tulo/LUenGSAuVZo5dhvn0UkDIL2q6BP/1DKqjV5VwBwKx3MjD400Ou
	 BPGuJR1uAkiZ/1W2yyyrSXGKROjXKYtjDzJUAidJ5KB5APJYCRpHYss3ekN4U2xSUewHu
	 /j4dG+vf4jJOcmoSODuqVBwn4aixpqHvjHXubGL1oslKCzsXe2YYLUcyuC6gnm+vfYTad
	 YVdejlgqwMxfxvZm+XK5jjZKc6bLFnxcIowzGceiJZbcazgITdnhMAmTWWzT5ud/R/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hc95gwYr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22CC606A31A;
	Tue, 27 Oct 2026 10:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hc95gwYr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D800615A1;
	Tue, 27 Oct 2026 03:55:30 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00023F59E;
	Tue, 27 Oct 2026 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793098533; bh=2KWWEm3YGgOg7VXROLDs0BaAsOc3yp6g0LrHlJpAeJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc95gwYr4hlRyW/o5zs0jyhfOGs74Do+ch0sJPW5V5HxppF6ribgfdRKL5l+Ph1qM
	 divMRR/TWoxxKhidxaYV5/bLcdzmWWzi7zrZ3SsmUbA2ws9BGJeDnbCnPVa+mkE9Qm
	 v0KvihGVOgmtbN05Kl4GX9PpZb6J8aJNpWqTJH9I=
Date: Tue, 27 Oct 2026 10:55:29 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	andreyknvl@gmail.com, vincenzo.frascino@arm.com,
	odys.yuan@gmail.com, sashiko-bot@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: untag addresses when querying page nodes
Message-ID: <auCDIcgPP2tKq32y@arm.com>
References: <20261026195330.46757-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261026195330.46757-1-dennylin0707@gmail.com>

On Mon, Oct 26, 2026 at 07:53:29PM +0000, Hungyu Lin wrote:
> When move_pages() is used with nodes == NULL, do_pages_stat_array()
> passes each page address directly to vma_lookup(). A valid tagged address
> therefore fails the VMA lookup and gets -EFAULT in its status entry,
> instead of the node reported for the corresponding untagged address.
> 
> The tagged address ABI permits these pointers, and the migration path
> already removes their tags. Apply the target mm's untagging rules to
> the query path as well, while holding its mmap read lock.
> 
> Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
