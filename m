Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907259;
	b=MVddJpxUTqwbQotYRLrMFmnrZ0NaIWV369xVXIflvUmfUoD+uV1Ox6VQ6Wt9WKmgIB5t
	 qtxYtPnZCkNcVDauVBCBYFFdiNW4GU0+fcmQ9QuE18ryTUDcTygdFQaQ8Uzy5DlboGumI
	 DXIv+h+THUg8j1eLwlpZwEXjhHZRJ9gwkqbBvOIJy3uGIzyvBSZh170237O4ImnFItqbf
	 jRQS+9XYn/AcHsH11na4DNXJqZ4BL/9BEsF4SwQi37AJlAJyQGtpsikYOluAQmZL/k+wy
	 aqXdrv7DE2j2SpVqYXUjTNNdsh1tJcLnsom5Fpb46eOZoWmxtrQNVRoEIrGn9mld2Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MDJ1ZuofLgVrpfv3I4TcFcX00mth3LkloBGTNtx3eGs=;
	b=ETuPDj/hY1pYWqyJ5/MwbJZhW+hfK0Hkxyx3dXCl9BFrJ+g7ftMmBDlMFFPNzAf5OL3D
	 XR3jF3vrNvWtvCwIR87Z90Vrcc0K7qv0x+sXSb4Du98iexD3E6yJmrXOCyp6OeAoFZJVx
	 DGTADWTAESNFqBuKTMrNKLmEU+QnGLAyfJsdIVNoiuZR1Gj5IaLur0ZVrT4cBD8XgYN4k
	 Kn08WYPobkSvwV5XCQP7CZS9C0VGjKhRJ5HBC9HtTtjLhRxQMANmhaiOi/OrC2uIFA72x
	 aZpe7woHHtv5T/fFkJjTSvq5Q/NFdIgvogse/14e5/9gtEcvvvnPNXFqrRHSnXZm+vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHQiqgNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC0608361A;
	Thu,  5 Nov 2026 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHQiqgNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A051F0089E;
	Thu,  5 Nov 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907259;
	bh=MDJ1ZuofLgVrpfv3I4TcFcX00mth3LkloBGTNtx3eGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iHQiqgNVDF6AO/Z9+xmHNYJq09sECOJ/V1ouMhJqojtr1X2lJdIRL1IYYXP1RAJCt
	 Wu+CnpR0hPTdGkb3X1/WjYeL/32yOdGH+PAP/eOvqaAFSsJpD22pEg0uyGpaT6+gom
	 gF0bg2MI/d5sHtDIiu8RRs9aHcei0IP77Zmebbu7PK4yDcZUqq6YP6mxN3lsspiek7
	 cCK5oxm5ovZn+oyouQ4HciyjLYzwyWVRUfskUtb5rb8sGPnHSqaPbTm3z/eEl9tqsV
	 +1672ZPVSu99Q4WD3xyK+mLzz2UsWbX7T0lij2m3pPMEEB3yFttZ/T3qPisBsl47pm
	 1+a3ge+2jqcnQ==
Date: Thu, 5 Nov 2026 19:34:13 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
Message-ID: <auzZF4cGOeHH5upi@gremlin>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
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
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>

On Thu, Nov 05, 2026 at 07:16:44PM +0100, David Hildenbrand (Arm) wrote:
> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> uptodate. For example, shmem fallocate() can put such folios into the
> page cache.
>
> collapse_file() already refuses to proceed with folios that are not
> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> such folios, leaving handling to the page faults.
>
> Note that collapse_file() effectively clears shmem folios through
> shmem_get_folio(); let's keep this fix simple and simply let the page
> fault path deal with that.
>
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Looks reasonable to me, there's no reason we should be dealing with non-uptodate
folios there.

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Once reviewed, I will pick this up in a timely manner.
> ---
>  mm/khugepaged.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8d9f05a39afb3..db135b3c44ef1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1900,6 +1900,12 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
>  		goto drop_folio;
>  	}
>
> +	/* Leave any uninitialized folios to the page fault path. */
> +	if (!folio_test_uptodate(folio)) {
> +		result = SCAN_FAIL;
> +		goto drop_folio;
> +	}
> +
>  	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
>  	switch (result) {
>  	case SCAN_SUCCEED:
>
> ---
>
> base-commit: f44fd601f72e09e44c667b9234c9cd469856679c
>
> change-id: 20261105-set_huge_pmd_uptodate-9b9820307f30
>
> --
>
> Cheers,
>
> David
>

--
Cheers, Lorenzo
