Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495057;
	b=ly0MrRsmUAyEWANyOP+HWbzp9cqpxZhruGFOFwcM2Je83g/b7sen86HbXSO2qXnPrU3d
	 eog4VCUuMD+ufgOWTuHsaeQYeXcp/tBjrItMTZOEqrJvtwwP1p7Do3EhId4NBjEjuGzUp
	 egIWo8Pr7aNzZPNymPQ7x6hfRv+9amNOAncOVNTcy0ysPNTOEVTqV7cnOYIWL7fSNSL9K
	 k9HOVq3ISM1oQyqFWcsblvKXWCME1Z8frVFZ+Ro9V9miJIGyNcMEUxC+EtquS8P8JfRPa
	 0eTgmHwUUMBY4FM/aKE0ytBvVr/M4JAqJZOez66oXvXc/Jx/yn+JQzp2Da5OxZnaZuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495057;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=q328z0ADOm44aFCRH7JZRW5DbKLu3Wk/c/or5Xdo7vs=;
	b=YIEZcv5Em+fG8ua6pPnjCD0/WfWcKIAgxkWFhjDXyQI1wZ89H7pVdbRCz5jdkQETAJvF
	 qlbWma4xlaMlCzttdilEKSaPK9OTsQqseV6TG6VOoi17LEJXkfEfDIXNuIWOHVWpAtcm3
	 pALg1HAdyfABXI7mgfcKK5vDJOztiVe8/zNCChm0ewh22NPVdM6zpW7pyyuRlIMkmFXks
	 0aHhn7dXyjtNaD9f9ZGBtFSeKrYbKYqWAvld4yZ8KPhb50ZECu14Bf4B6x0/H1qMRybC2
	 M4yM9AlBriO+OJ2wsKd5ZUkZqKSk9vrYmhG4pZJvVha1KDn55tqRdJGNfOehl4c6Lhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FANES0FN;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC8606A330
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BC8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FANES0FN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792495057; x=1824031057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fgKmmC114oVM2L5rtRPnA+9JSsDg5PbLD4MSLzg7Y1s=;
  b=FANES0FNGMlzl2QL+oQSECXbFEeQ4DTw8JQfpFV/IOX4cL1dTpic8dNJ
   GN2/Gsfdfvw7VqffPTcIp2OKTNyHkkTQq7DOxNxTlz5OHklb0Ra/ZX4dn
   U7tBM4dgaaIfUBRMoGZoagMsFnDj7nfCHpjzV2nmO1HhstTelWUQCvdLh
   8rK014Qx0oBRyyh6E6U2gVppBpB9NanBUO8tFUrIBnCP8XTCAx1gwdGxJ
   J5Hl10SlASXb+5tuDYNGl6JPTUpDJnfvffznyuv1jdvsrhEj9WFsjwBMa
   UVFLjjZ0pIygARrBrUFmeVOLLdxS9v2SR3PpgWOfbHv3BDa4xg/7b55Bq
   A==;
X-CSE-ConnectionGUID: 13QuyQubTfO9xskPXvVMLg==
X-CSE-MsgGUID: cyV7N7rIRtijZvJRTv3Btg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1068092"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1068092"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:17:36 -0700
X-CSE-ConnectionGUID: Ks5F5TPUTKifJ/Aj6zR3Yg==
X-CSE-MsgGUID: CWaC/wjeSNWU4C4R8SsSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4545192"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.166]) ([10.245.244.166])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:17:33 -0700
Message-ID: <281c6c14-2692-40d4-b812-e41c3a2acaf5@intel.com>
Date: Tue, 20 Oct 2026 12:17:30 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Shashiko <sashiko-bot@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261006110706.1636971-2-matthew.auld@intel.com>
 <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2026 07:06, Paneer Selvam, Arunpravin wrote:
> AMD General
> 
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Thanks. I assume you will merge this?

> 
> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Matthew Auld
> Sent: Tuesday, October 6, 2026 4:37 PM
> To: intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; Shashiko <sashiko-bot@kernel.org>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; Joel Fernandes <joelagnelf@nvidia.com>; stable@vger.kernel.org
> Subject: [PATCH] gpu/buddy: do not pass caller list to __alloc_contig_try_harder()
> 
> If the caller passes a non-empty blocks list, __alloc_contig_try_harder() unconditionally frees it on failure or during retry.
> 
> Pass the local allocated list instead and only splice it onto the caller's list upon success.
> 
> Assisted-by: LLM
> Reported-by: Shashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d7
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/gpu/buddy.c                | 20 ++++++++++++++------
>   drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
>   2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index 2f2aaadafe35..a86f454fbb40 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
> 
>          if (order > mm->max_order || size > mm->size) {
>                  if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
> -                   !(flags & GPU_BUDDY_RANGE_ALLOCATION))
> -                       return __alloc_contig_try_harder(mm, original_size,
> -                                                        original_min_size,
> -                                                        flags, blocks);
> +                   !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
> +                       err = __alloc_contig_try_harder(mm, original_size,
> +                                                       original_min_size,
> +                                                       flags, &allocated);
> +                       if (err)
> +                               return err;
> +
> +                       list_splice_tail(&allocated, blocks);
> +                       return 0;
> +               }
> 
>                  return -EINVAL;
>          }
> @@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>                                                                  original_size,
>                                                                  original_min_size,
>                                                                  flags,
> -                                                               blocks);
> -                               if (!err)
> +                                                               &allocated);
> +                               if (!err) {
> +                                       list_splice_tail(&allocated, blocks);
>                                          return 0;
> +                               }
>                                  if (err != -ENOSPC)
>                                          return err;
>                                  goto err_free;
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index b75d32ca6ca0..2c6f1da1a6d1 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1235,6 +1235,15 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
>                                                              GPU_BUDDY_CONTIGUOUS_ALLOCATION),
>                                 "buddy_alloc hit an error size=%lu\n", 2 * ps);
> 
> +       /*
> +        * A failed contiguous allocation with a non-empty blocks list
> +        * must NOT corrupt or free pre-existing blocks.
> +        */
> +       KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +                                                      3 * ps, ps, &allocated,
> +                                                      GPU_BUDDY_CONTIGUOUS_ALLOCATION));
> +       KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
> +
>          gpu_buddy_free_list(&mm, &left, 0);
>          KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
>                                                              3 * ps, ps, &allocated,
> --
> 2.55.0

