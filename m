Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57133DED9;
	Mon, 17 Aug 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990913; cv=none; b=igxvRzlALn6fN/Ug0Pw3p3RMf7GYxWgTH1HqwjFVMpv4cjYD9eoA2djnp/fxdzVZc5YCu5YJxetvGjGILgb7s7+tjUAzx4JbYxU5T+SWANEaGQ05rtIti7c4RgRfgoptVHc+7MkyXGR7RyP4LLZG9vJcdKBVCZCq80SJJu0Qae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990913; c=relaxed/simple;
	bh=jGVtqFIezofrSFTpf08DEw3W94EASrpwimrcWhPW69M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tKsGw22bRM76VGqb4uRSYoUZuuKn3msEsZtnc1fB6L0JE4Qh8xoa9254HXz63jWwBBPkjYIf4gG+l7ItBzmBsQGdXpZCf5eVZl/qfMuZdFsqXk6ftB1azOus/LHM/hCwCOuRKU5PlO/oirqs4LsxJYvKSCZwrT900FRA/MRm1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gKkEscvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gKkEscvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DEB1F000E9;
	Mon, 17 Aug 2026 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786990911;
	bh=0BkhnPeo1KLR/EUoIgA+xCcjgHScjG9tYFnOWvoAumo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gKkEscvG2SIHcy2Pg5QQ00VuMOZJzlMUKm3IDezGJIVl6RotLuqK5O1dx7WXfvPqk
	 qn633LI0SYaf/GuXCCz7xSD0DE/aNWKtTkf2y7FQNXJf08c4CGxwXvofvQ2dFmIAtB
	 H8Lzo10TFV1Vq3Pw1x2HPaFFcTHUkjzAdFDYPdYo=
Date: Mon, 17 Aug 2026 11:21:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Su <sh_def@163.com>
Cc: david@kernel.org, balbirs@nvidia.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for
 compound folios
Message-Id: <20260817112150.aa6cc927cf501d687336c0ef@linux-foundation.org>
In-Reply-To: <20260817120758.669807-3-sh_def@163.com>
References: <20260817120758.669807-3-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 20:08:00 +0800 Hui Su <sh_def@163.com> wrote:

> migrate_device_range() and migrate_device_pfns() clear the entries
> following a compound folio so that the PFN arrays retain their
> page-granular representation.
> 
> If a compound folio extends beyond the end of the caller-provided range,
> the loops clear all following folio entries without limiting them to the
> number of slots remaining in the npages-sized array, causing an
> out-of-bounds write.
> 
> Do not proceed with a compound folio if its page-granular representation
> does not fit entirely in the remaining PFN array. If this happens, drop
> any reference and lock acquired for the folio, clear the remaining
> entries, and stop collecting.
> 
> Observed with a KASAN x86 QEMU kernel using the HMM
> migrate_anon_huge_zero selftest. Closing /dev/hmm_dmirror0 after
> migrating an anonymous huge page to device memory exercises:
> 
>   dmirror_fops_release()
>     -> dmirror_device_evict_chunk()
>       -> migrate_device_range()

It isn't clear (to me, at least) what "exercises:" means.  Was there a
WARN?  Did the kernel crash?  Did it erase all my cat videos?

IOW, in detail, what are the userspace-visible effects of the bug? 
Please add this info to the changelog and maintain it.

Sashiko might have found some things.  Some pre-existing, some newly added:
	https://sashiko.dev/#/patchset/20260817120758.669807-3-sh_def@163.com


