Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBB32C94A;
	Wed, 26 Aug 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731908; cv=none; b=XF8yr1zqS3njmINeJ4CwHMPQ8Ubx+N2d0wrAV2Ao6aHwT646OkDAzmrHpBkVJfKz0XQ5Od6YG9MmxdsKqhsCTmHhwC8azKvH2OQ/GW+P4MhQATNZUBhHEW8WBjL0fBnxvZYT7tFaXo2eKRmZ7PbHs5cfG2sxNkhk4dDmev5VHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731908; c=relaxed/simple;
	bh=QbuA9sCDms1plCJVTFINo6UU8t19ff1R+sOLb+97I3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD5iMYbmZNsKCVKOLg4A+K2wlXmZXUJyzOatBn17ujbQHWdVo/IY5XX3fkbXNKZaIpnlckspMcQtMye4aqLInF9cY43IYFGaq4WqUakmlPXvaARY1YTYWwsV+ihrXjgoCpBSn+MDRfkQIerZgEB8aRp05LNSK3xWS4dLQc+s0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePHnLnjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePHnLnjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A965C1F000E9;
	Wed, 26 Aug 2026 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731907;
	bh=NTz+XP2ZmEJS+adHOO/Ohz8zpeHQ/sJQxx0X7QLGjQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePHnLnjC++XvojUVKd/BioxVavElfpLaXW3WK+6BYE6qBGUJ/b1aud5whdp1KQYDw
	 ZtzgLxJ3Q1eV4ZNT+DivuCFM0UCNDK/Cj2ggZZxOxGQvbXExjKEQQKZ9wcv0M51jvk
	 BA3JxyBdJr3e5VPvhNPJBXtuiKvaBAGYhkbsTxU7cHXLBYY52/B8B1BhZKgqBoh1cu
	 eU57qdTZnBw+AZpKNTwyDHxCrin6ioJKb+2A6U4pHLPGOqDUKra7ncHmmoaixbFHv0
	 PsyAul+BvYzKh0z6Dw93KDuotgBQlmN/aZPaXT5K9yLrTwvrK8SppYHorvfL7DEOGO
	 7s7jfE9aFKyeg==
Date: Wed, 26 Aug 2026 09:11:41 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <ao6fSHW_nX8YC9QK@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
 <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
 <ao6c6Oe_KV0O1LJn@gremlin>
 <b6fbf952-c619-4fc7-8a8e-62a0ae64ff0d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fbf952-c619-4fc7-8a8e-62a0ae64ff0d@kernel.org>

On Wed, Aug 26, 2026 at 10:08:58AM +0200, David Hildenbrand (Arm) wrote:
> On 8/26/26 10:07, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Aug 26, 2026 at 09:57:05AM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/26/26 04:44, Vernon Yang wrote:
> >>>
> >>> When the `xas_for_each()` iteration to terminate and the folio operation
> >>> preceding is normal, but pfn will be incorrect.
> >>
> >> The PFN is only relevant when a folio participated in the failure. Maybe the
> >> following would be cleanest?
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 75639298efc27..371ee0b16d10c 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct
> >> mm_struct *mm,
> >>         int present, swap;
> >>         int node = NUMA_NO_NODE;
> >>         enum scan_result result = SCAN_SUCCEED;
> >> +       unsigned long problematic_pfn = -1;
> >
> > I find this name... problematic :)
>
> Elaborate.

It's overly long, I read it and am confused as to what is 'problematic' or not,
it reads weirdly in English and pfn_xxx is the usual convention for naming of
pfn's anyway.

I made a suggestion in the reply as to how to refactor this to avoid the need
for assigning the name like that anyway, if you branch the result ==
SCAN_SUCCEED then it's implied.

I did wonder about pfn_folio but then that's confusing wrt the function, maybe
pfn_fail if you really want the name not to be pfn.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
