Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1033D50F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174042; cv=none; b=GyExG168D0cubjj78+x76ph0ZuTF2Aa1wGshUEJAPiWNbknv8gZjYHi+ux7zC8S47gOLfXYx6pJmPwt3oGlfFwOJDkFRU7mPPPy6NqeYbY3H5l1YNR5lPm5l8dd+MwMjAC14Lf6I9yi25N12yfElaLVQKVWhQWEr0ecLqLupUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174042; c=relaxed/simple;
	bh=qLSDHmt0uiYBxN+JEkYuUN9wyR36Mq074xndRfuUSEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4ZqVzerv2xivJxkyOuj2WR76EH5tT4wWN7OuA+7sowCRnHUw0RaDviRY8LU4xlVKvFT8Mw8XVX9ctJ7tpV5Dh4I5O5A21248HWxyuT4L/skw2hqVju5GmKbqEAoaFrXDbvoboynlWz2ac9lsjZH6W63TGInfGZZ7+wN5bWc0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs4apWVe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs4apWVe"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b4aff8e8c4so2761151e87.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788174039; x=1788778839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SDQLGo2eBys2v5fSX9hMlquDuFbTQ/zAGUSHKc6b0N4=;
        b=Rs4apWVex3BlW6GpElQW9ji8J1JBjEhWZ6LH+hCJpRxTvxsFzjbenEyQDicMQZ58ZD
         Se/uVU635dheuiCwf4yqxZSMztvOaItRZxgA+LGd66m1mgBnLVVG7HNUhvBAoqrAMcBp
         8KKhkWEjO1hUT4f9e0iH2PV5FPUEYxMRLyNKknjoBget/G5Gv8XaemCbVC8H64QMh991
         GNKZ9rVDx6muB1p7+MgwySqaRuGSv3arsDDF2I1rvKXAVZtdm6jL5HEUigupeNbgQed1
         f2utOk6sKj3y+g9fc3OXBft7WESPxQRGL/DlZ6yB024dWo0Pvdho2wMY6BD05l48we3r
         1hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174039; x=1788778839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDQLGo2eBys2v5fSX9hMlquDuFbTQ/zAGUSHKc6b0N4=;
        b=SLGPU3Ku3f0sqLvhe+dY18Ajzj0qqGkGgIyij/tazBsm3x15otsVZHFZaTL69wutKw
         HtCz5OqUM4mRp3CR0lj2eOGSvpFEyoW6hGGfjOx0/oSgi35JZ4pIdYSXcHGbvfkIochC
         gbakNHgyHD2VY8cQxFpxMt3WAbMeKYV3Cql+XAT5aJQkAegRtqU/GgGmv6udO3me6NEp
         DG5mkXuVWJyr6GApKkpSS9DHWXNqZkp79YHwu4SfUNFtKm3CpvxzSOfd6Ug8QwFLaR7x
         fFb5PtjhvOpyDWgPnGgxV5SGITzUnGrIxPtc9opTH/xJszu/uy5aPspuqK+/uLngHlGH
         Lq1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTA9SrD7vDlBElucIHGTaxkN5Z6m2sae8bRNkeok73a2dc0PwXOmkqdice76GVcTh8+bxg89o=@vger.kernel.org
X-Gm-Message-State: AFuF++lHdIxxF2ozS72qHpwFVcL5yfHgFukgGjo9iqH0wMbgimS902dQ
	F/TkeGAg3vR2WRChb2zqLJzuaFrdgp2fO3dmmhyINlzkrfr/1veIOiKa
X-Gm-Gg: AYBFou2lrXZtk1Yz9qYdgXWwziANXypCUPPfG+qLSzNO6uL4oubcP6ZjKcIe73aJON+
	MsPjjottdPQ8ZIKwVXl4znRMIVAk19rkFBuGB/ma53jImkjK0PA4qt/vO0GODDuk1HY93muFhlw
	Ua+9/vjnnNPyB9RnKnAOCVfCLxa58zAbxBofuTfcMIf2BEUaFzQ5UXb0jxbBXTjvVGZCQr/4tDF
	4YoUMjqg6pHNAShNdpOBHx7bSVn4Mj+J8oXDcf+ynbf/Aqjw77mX94ccXKy9hLXnr3JQgwl/6do
	MaG+KHsZjVizrmu/5rUBfKcO/qM6WWSn8CUH7XWub3S7LUPg3e8CLwrSt4dEEDg2Es89hd98uTp
	xyZN6RQbpq09Bfj1JKYKfDKLs9qCUw6VBUr+OVskBkSSTb8OFsJCco+gQtSukqomSnrqXNt/K2k
	ik2FU4x/ZsabHNvGySN+ZfmNHIP1LuCqEYyLzb84E95Z6lc4NNVrJEx44Mi2EyjzDxswbC2TJ51
	Rdqs5fiRXAoeivMBNZarko0qZSSeDPUXkOpfrcbef0Jf7gdSXWI5W9WXYwAJg9o1sr+WmbLVd11
	yJ2W/38xo8xrjzaynn0UmtWiCAbqbYE/1wu0NxOjFB8uhhbEzBG45snTGxaEsBxDuxObp4FMTZw
	=
X-Received: by 2002:a05:6512:2355:b0:5b5:f946:513c with SMTP id 2adb3069b0e04-5b5f94653e5mr1425845e87.17.1788174038781;
        Mon, 31 Aug 2026 04:00:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89c5b65sm2175666e87.16.2026.08.31.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:00:37 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:00:34 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] arm64: mm: clear extra idmap level before use
Message-ID: <apVbNN_gtowKWVhR@gmail.com>
References: <20260831054247.33352-1-kmehltretter@gmail.com>
 <2026083125-upbeat-series-9565@gregkh>
 <7f744f2a-409b-454f-bdb9-fccb5031640d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f744f2a-409b-454f-bdb9-fccb5031640d@app.fastmail.com>

On Mon, Aug 31, 2026 at 08:15:52AM +0100, Ard Biesheuvel wrote:
> 
> 
> On Mon, 31 Aug 2026, at 07:54, Greg Kroah-Hartman wrote:
> > On Mon, Aug 31, 2026 at 07:42:47AM +0200, Karl Mehltretter wrote:
> >> The 6.6.y adaptation of commit 0e9df1c905d8 ("arm64: mm: Don't remap
> >> pgtables for allocate vs populate") removes the clearing performed by
> >> early_pgtable_alloc().  Its replacement clears allocations made by the
> >> generic page-table walkers, but 6.6's create_idmap() still allocates an
> >> extra root level directly when a sub-48-bit VA kernel is loaded
> >> sufficiently high in physical memory.
> >> 
> >> memblock_phys_alloc_range() does not zero the returned memory.  The direct
> >> caller therefore publishes an uncleared root page and passes it to
> >> __create_pgd_mapping().  A stale nonzero entry can trip the bad-descriptor
> >> BUG_ON or be followed as a page-table descriptor, preventing the kernel
> >> from booting.
> >> 
> >> Clear the direct allocation through its linear alias before publishing it.
> >> init_clear_pgtable() also supplies the barrier required before the table
> >> descriptor becomes visible.
> >> 
> >> Mainline is not affected because commit e6128a8e523c ("arm64: mm: Use
> >> 48-bit virtual addressing for the permanent ID map") removed the dynamic
> >> extra level before page-table initialization moved out of the allocator.
> >
> > Why can't we take that change instead?
> >
> 
> Nope. That relies on a massive refactoring of the arm64 startup code.
> 
> Can we just revert 0e9df1c905d8 (aka 54322d95309d) instead?
> 

Yes, that fixes the issue too.

The commit was patch 3/3 of the following speedup series:

https://lore.kernel.org/r/20240412131908.433043-1-ryan.roberts@arm.com

Patches 1 and 2 accounted for most of the speedup.

I'll wait a bit to give the others a chance to comment.

I can send the revert as v2, or my original patch as v2 with the
missing "Assisted-by: LLM" and "Signed-off-by:" trailers.

Thanks,
Karl
