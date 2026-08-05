Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC9483BC6;
	Wed,  5 Aug 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947395; cv=none; b=mcuD2Ud0kHNUrVboXF9sa3p6sCQd9H1p8143FKmZf0aGe/LnY3TCowRgx6EtNw03uvok8sixCdYfaRajZs71aNqIyuA348Nqdw+ZbhDroSEXjQ9NxsKPdLBCoILM0d5oagjhYsmIXvQ0us4DV+A1aqdJ5AJuYzW3o+rsMn0grDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947395; c=relaxed/simple;
	bh=q9L2N9YRxda5Bh032maEDALi7aTeAmsvta3X79RfQpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhzNQwCRD8ieFKtOQd+DG6eFB4Frz2+1egEgJeKnyA50VzRcQL8bncUo3ouMuYUEh7ASpaW8yZDWr4p4oM1kMAWd8m5UIrNe8NJtygYRjM+QvzoLh7us+DNWuCI+oeOOm8Sj9VbNz4dngo6bbgSMSRdGZFq0uBnSEg9bjNI3QLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/g+aw9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/g+aw9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6435B1F000E9;
	Wed,  5 Aug 2026 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785947391;
	bh=q9L2N9YRxda5Bh032maEDALi7aTeAmsvta3X79RfQpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/g+aw9Z6Bn8DJHf76ODlG6+nfC79yTIBLBiI6tvVxfuoykLHCMXCju2F8BwJHTU6
	 pj9UX58lBg8TJ+DraHlbBlPtclIhJtbxPvzUBHuBXROx/CSCt+dSsx1EDsW/z7WTu1
	 nD2XAYmaxsP2aOkXPgGsC31tRHp8vNRdgkDAD4xbGutpCPeSVzHxghNp/nNbBL6ifw
	 x8Qi8jlSJCm3ixVH4WyTDgoQOIW9CRkQ44/qjSzCa/uKz+oGJpWyMYZrl2E6DUQd2X
	 FjOE/7kO/lFz75YYlxRutFq+mhqiFdmnKBIb3ooCR9wyBEoYVCKqZWOydYGIye4S/h
	 i4bxMBl/smNzw==
Date: Wed, 5 Aug 2026 17:29:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anNkjl0qNHK47WTD@lucifer>
References: <20260805055544.1568534-1-clg@redhat.com>
 <20260805121524.GM27883@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805121524.GM27883@nvidia.com>

On Wed, Aug 05, 2026 at 09:15:24AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2026 at 07:55:40AM +0200, Cédric Le Goater wrote:
>
> > The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
> > page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
> > with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
> > severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.
>
> Broadly upstream we expect people to use iommufd and dmabuf for these
> configurations to avoid all this nonsense overhead. :\

Point taken on that :) but I think it's generally reasonable in line with the
huge PFN map changes to do something like I suggested.

>
> Jason

--
Cheers, Lorenzo
