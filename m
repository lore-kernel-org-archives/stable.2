Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911380;
	b=V2yoEl6mq2PA4Ki3a3J6UPnHcT9p7d+YtxJqvf8R2Ak39YLzhM3LBXSstfscV1xqQr3X
	 H6aMVtv5U1AkovH4ruTGEVR6NOGvsErwmnArpX5sw9K8nXgHkTVI1SKewPLS1U/BGzx+l
	 VjZjNgd9wQ2t69t3QMcs2RjEwqIWMuSMoDKNLvIXAc0+n71Kmw6Fil8acRVpCbPL2yJ+A
	 dtHXreUkQKX7+vXtbYMZm9MY3bnCUK40qUOfMfRC3UG5BkN0p3RaFx6bAOU35zl2XRLGv
	 wVHNHyWPircbfve/NJophayNO61iJj6Nyqco+TbQTTLubddi4ZamjYzZOMfg/cO/LtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5xd4kH02h2/RHBixGr9Rh7KR37RCKshv/F2OBniMhWQ=;
	b=PUFPYTcTc7MY625eCYeC4qUM8J/wtNbAoyaOOYnq8R/jXcwqjFU7L5B5/Zwk7FimmbsK
	 W7o+YmJXCW37l8VJc3nL+F2d8yBxKFIWNVdx8ie9/h6t9scyL5XogFEavuN5YAu2+ja7W
	 FHj7YaYSZ1x9CGUM8sfc9U63PkI6qHcpljioiDcM0rp39MlXjJ3gevJj1FVMXbBHGgfXL
	 EucCCMjU2awdOqTMtf3Lk1NO9Ox266PL4huaRmJBYYKn7AJv+G8/eB8CcCJZ+1tyZzEUx
	 t/FtiNLhpzNkTZ+KQ4oolOEzfXnDEmfvtHmyVgSaxrrFXbM23PQzyDjrVCHOySvTCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGl0PMKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EB606A883;
	Tue, 17 Nov 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGl0PMKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFEB1F000C4;
	Tue, 17 Nov 2026 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911380;
	bh=5xd4kH02h2/RHBixGr9Rh7KR37RCKshv/F2OBniMhWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGl0PMKrFNzmEF2BOR91pPrc/W8Z37D0KlbhQz16W2M5WXKx0P28v6EFJFsxZjHdP
	 WzoR40aWQ7oFNbp3kQpkcI3S9JG4kxjcvWPr8vQGSifi4qQ7BLznI3WQDnvx27V7XP
	 UuiNMSAP++eI3vrHz0Vvo7cP55LwH1GIH5xt7nGwL1qeluQSMdfGr3heGCbUaHij5l
	 ILtcQjiosvjoqfGiSlbuEuRkENr2+1iJjcdTueyLNfE4CcEWCJ8/zuQ19dc5xP07Js
	 Mz9nJdkqUVU+uguT/oouZnicCApxQw8uk/85KA7kTJ916TYYiv/9cKjQ+G5xXvYxyU
	 lqIh1/NsdIG8g==
Date: Tue, 17 Nov 2026 10:29:34 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
Message-ID: <avwsiDm5bM0OCNIg@gremlin>
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
 <8092de9e-3146-4fe7-a235-01ea8efab08c@columbia.edu>
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
In-Reply-To: <8092de9e-3146-4fe7-a235-01ea8efab08c@columbia.edu>

On Tue, Nov 17, 2026 at 01:37:06AM -0500, Tal Zussman wrote:
> On 11/13/26 4:04 PM, Lorenzo Stoakes (ARM) wrote:
> > In order to establish guard regions, guard markers are installed in the
> > page tables of a mapped VMA.
> >
> > However, problems arise when one tries to combine this with registering a
> > VMA for userfaultfd, as such operations may themselves need to install page
> > table markers such as uffd-wp.
> >
> > When the installation is attempted the guard marker prevents these markers
> > being applied, which can lead to unexpected results (especially if the
> > guard regions are later removed.)
> >
> > This is especially problematic because guard region installation causes the
> > regions to be zapped first, meaning that the removal of userfaultfd-tracked
> > ranges will not be logged in this case.
> >
> > Additionally, the uffd-wp page table marker will be propagated regardless
> > for file-backed mappings as the zap being performed does not clear these
> > markers.
> >
> > This is problematic, as it can cause repeated failure to install guard
> > markers resulting in an infinite loop.
> >
> > Therefore, update guard region installation to invoke the zap with the
> > ZAP_FLAG_DROP_MARKER flag applied.
> >
> > Both before and after this change, uffd remove events will not trigger on
> > guard region installation, nor will write protect state be propagated after
> > guard region removal.
> >
> > This makes sense as conceptually, guard regions mark a part of a VMA as
> > effectively unmapped at the page table level, and removing the markers is
> > like mapping the VMA again, over which operation uffd markers would in any
> > case be lost.
> >
> > A survey of open source users indicates nobody is relying on installing
> > guard regions in uffd-armed VMAs. Software including glibc, android,
> > tcmalloc and CRIU were checked.
> >
> > This change means that any already established guard regions are removed on
> > zap. These will be overwritten with the newly installed guard markers on
> > success.
> >
> > However, if this fails for some reason (fatal signal likely the only
> > reasonable cause), guard regions may remain removed, and concurrent faults
> > may succeed in the interim in the range.
> >
> > Since the installation failing guarantees nothing about the range being
> > installed into, and since success overwrites with guard markers, this isn't
> > an issue.
> >
> > Since MADV_DONTNEED does something similar, abstract the zapping to
> > zap_range() and call it from both places.
> >
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> Tested-by: Tal Zussman <tz2294@columbia.edu>

Thanks! :)


--
Cheers, Lorenzo
