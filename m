Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103128;
	b=vS+H/xsl8QlrjG8yocy3DKd0c7QWn3yxaQdoE1SwmAi81cOs7yYFDkgolR9V20uvIEUS
	 SxMHTQXvZVvoi5NZDJM9nt4ppB79qYXX8LWuMr9+VNKKT22pOquTRXGlmsBmTwJL/IfEh
	 noCqhMN2HASvpParX97r0DBpatXfraxXFmUMLLm19gtCmlXiOTSemFzAbOJWaQHDCURDf
	 NmE1ZBSbsXhQbwpB/5jveNXquwfjZUToU9irA6E7PxCMKaCBlwQKNnGBHkVi7q8QwwSky
	 CvbWtgDILbItGRCjLcumjSssIJJEPEaBwcLBoGdnVR2/E+wyw+EjZQCTwcWh6j6qQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103128;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=myKKudY9AElKYbxGQePv2vddrjcLrdPLn2/PF00unVI=;
	b=f2Dlbzt5RCn8BRzVBDMDOJcvWFEuaNM3svBnwpe438Pcg2Ds6nqU0/2bmh6+z7kYObtF
	 i+0WAAZQ0Z54VMO5eEcm6HarnIWwx3jkZ5ezLtaAn14cPmaEx2iQ2SznCoKUEovI4aVtq
	 zcLIX82H7S7ox7euNYi2lY7L998dPk7ebUW3oDcXcrrFPPVyswNVqyPe+7EIbApHxFH88
	 AhOf5S/g5E+EskPlN0Jm1QGoDkl3bsPnS8RWM3zG4kw9dSk3QCelzwtufVaLkKo+Sn/W+
	 E0gNR8NjJf+Qfxv4xWv8pyEHnAU/T3ySFMBtqpMJ36Jmrp3RQFyrokT543T0AtYaVaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdGBtsof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016A606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdGBtsof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619471F01829;
	Tue, 27 Oct 2026 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103127;
	bh=myKKudY9AElKYbxGQePv2vddrjcLrdPLn2/PF00unVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdGBtsofI8YcoPXtyx8lkCxdQDmLN3OUIJlU595mRf8mckm8AT3oTgF84fn/PVE7V
	 BuiOCXppr7kNOIWYqTYgoZWISnHuQ5Nv0x+s0RHTB3nep7fkcxTuE7Nah/aCD5y1mI
	 P7SP84rQC4m20Fzyjlaqb6CcDV3+P5E3wHAFD79wVJ1g/UBU0OANd2CxcICZpsDLuY
	 MuyZNpD1T5wjhnEXdMgjWQHagrB2xfK5h6ne2i0s1id7XhVPsbwFmKW3lzhCBr4Krv
	 vPfAK0watnfgPPAy4ZiJQD5zNYRXbx2JHxfE8efm2rUmShTqejUueJro0hD+qMMw4c
	 lgbA8D3Ol+coQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id B3BBC198004A;
	Tue, 27 Oct 2026 08:11:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 08:12:04 -0400
X-ME-Sender: <xms:DpXgapG0meWIN0OM66ofji3vvc4hNVtH0drLydv1KcNIs3ErsZpJ8g>
    <xme:DpXgassn_lZcNXJFSd8gXX8QhsKHGrp27KDHGK01N2lkLJsMN-kA-SA6sBTv8Mneb
    CuMRL_aJzmPFEkIodcySUV_VxtN9HCoV6CjJbVJGzh5hDgWtimhgNeM>
X-ME-Received: <xmr:DpXgatl5ve32KSZ52FWmLf7pa8yRPvWx_n5HehD8GDPXoMiFRmAlNElLDRM>
X-ME-Proxy-Cause: dmFkZTGe5tge3hMEKwWY8gQags5EmqESoYDA0+zWY7IvA1d+/F6MsE3Cn1soB2gZC+4C8m
    AmdeqR6xBlYdjHkIi1+xb2TKsxTiKKv5qUEaP5dpCSOsLFN98khIIpouApYCUZ9iaewTN0
    hT1CmGkfdX9omvnjCFWDGuofhrU50LyeRF23rClfUeUbjui0PU0B5qFKnfogAY0cVw9+6O
    4l2HB0vw+6RGJXa4SsnIhqMXtV9Neg0umvLPylEUbt52l2DRcdcEZf56++DvuebVy5KRjg
    xa8UyxviWzWUZZykb0Fnka1ej9fCGRTSjDsN4tbCgsE4rWbtQ4MqGo2ev5BggJ27hNHiEV
    L8ibXBG14E1YD9USjV1AJkkSV08UoWz2qtU7PPRmtKgS3ApkHJBirZCYH0ppodUqAdwlIL
    69W31hE/Gs9Y/AZ5W/Z5yKU8cWSN6msM6P2mpNzDLiMPFopbpJ7fKurotK6JPMvwtTzs+x
    CceVUI8VFllI706r169j/JZsf045pQEb/pwr7oaouDKNI3rsdfX0ZepQ2zVHs4CQOk6zY/
    VugIsLjXQosrDDGEfECKAx0oj4ODRX5noTPyeL3FIjBHTxHUsQjH8ohCl1+RbkTNnO/dqR
    jw1e2R++h7DvurnnFSeIGznQ/jdZjSoxnKgmRQCZrUCh5beAl3uD4bGaZQuQ
X-ME-Proxy: <xmx:DpXgasQ1EyxtRBs4tFiKL8tb9Hn_Y9_cB9p6DEQ5SXWv7itXQGBAwQ>
    <xmx:DpXgav7Y_iwdhRD6lPwDAiYjYRymzwiWwL5vNpdSwH-mETNsjZ8Y6Q>
    <xmx:DpXgamlH7FICF6lnNILH3u5xidPa-NkHHRAF8lynadF3sQqtQ870lg>
    <xmx:DpXgal5jGenzwm1UO_iCp-fS1b4AlC1TALorVMgfcXv_uVLHSAwGbg>
    <xmx:DpXgapx4HHMRpaZzmToEh90JxUkL7hrk0zETU6mAek0gaMBujEKHWGps>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 08:11:57 -0400 (EDT)
Date: Tue, 27 Oct 2026 12:11:56 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, xu.xin@linux.dev, 
	chengming.zhou@linux.dev, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jglisse@redhat.com, 
	aarcange@redhat.com, peterx@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bobbypowers@gmail.com, bgeffon@google.com, 
	dplotnikov@virtuozzo.com, dgilbert@redhat.com, hughd@google.com, hannes@cmpxchg.org, 
	cracauer@cons.org, mcfadden8@llnl.gov, gokhale2@llnl.gov, mgorman@suse.de, 
	mike.kravetz@oracle.com, rppt@linux.vnet.ibm.com, xemul@openvz.org, riel@redhat.com, 
	shli@fb.com, jthoughton@google.com, corbet@lwn.net, pbonzini@redhat.com, 
	seanjc@google.com, sj@kernel.org, ziy@nvidia.com, stable@vger.kernel.org, 
	samarth.colleges@gmail.com, med08elkadiri@gmail.com
Subject: Re: [PATCH] mm/ksm: fix userfaultfd protection during merge and
 unmerge
Message-ID: <auCTv9O6F1JPyOAu@thinkstation>
References: <20261026130054.91461-1-lance.yang@linux.dev>
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
In-Reply-To: <20261026130054.91461-1-lance.yang@linux.dev>

On Mon, Oct 26, 2026 at 09:00:54PM +0800, Lance Yang wrote:
> KSM loses userfaultfd protection when replace_page() builds a new PTE
> from vma->vm_page_prot. Dropping its uffd bit lets a subsequent write go
> through ordinary COW instead of userfaultfd write protection handling. For
> RWP, a merged page also becomes readable without faulting.
> 
> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
> have to handle unmerging. An existing KSM page can be protected with RWP
> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
> of preserving RWP during merging.
> 
> Unsharing replaces a shared page with a private one and should leave
> userfaultfd protection in place, as do_wp_page() already does for write
> protection. Currently, an unshare fault reaches do_uffd_rwp() before it
> can proceed to do_wp_page().
> 
> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>   break_ksm() then reports success with a KSM page still merged.
> 
> - With asynchronous RWP, protection is cleared before unsharing.
> 
> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP. Let
> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
> private copy as well. Unsharing can then complete with RWP still armed
> for a subsequent access.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
> Cc: stable@vger.kernel.org
> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Thanks for fixing this:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

> @@ -1463,9 +1464,14 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>  		dec_mm_counter(mm, MM_ANONPAGES);
>  	}
>  
> -	/* Preserve soft-dirty when replacing the page. */
> +	/* Preserve soft-dirty and uffd protection when replacing the page. */

Small nit: the period at the end of a single-line comment looks odd to
me. Am I the only one?

If you are going to respin the patch for some reason, maybe drop it?

>  	if (pte_soft_dirty(orig_pte))
>  		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_uffd(orig_pte)) {
> +		newpte = pte_mkuffd(newpte);
> +		if (userfaultfd_rwp(vma))
> +			newpte = pte_modify(newpte, PAGE_NONE);
> +	}
>  
>  	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
>  	/*

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
