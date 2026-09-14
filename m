Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60231ED81;
	Mon, 14 Sep 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405103; cv=none; b=gDN2MesDBuTgr5qQJVBVL7KluK1UE7IppsZzK4JecNwP3EjQ/G40P8l7IO1zf1GU4rh6yTI8XruZf/aHjHR4OfNjSNYsJZQMExYURmvmgsu9EjlX7G34po2ASOGlYsUne8BbNfPdx+hhj725KaEB6K/EZ6Ff78VXreRgJGieLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405103; c=relaxed/simple;
	bh=YH4Z3zsrdC2h/tVP5Mlv8NZglMCdqPImvNfsjGetM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP2fmDssep3zy5AzUes8u4WmfDXd4hBHBcCLRfd1/dJY4rPemNdKOAfleOIxcUJx5xHOr+r4/YaB2HqYWhrDfJ8nc7/eUHRK7Hi9w9Y49cTPvjWniYI0EuoWgu2TpVebtzn464Fer/ZDJ3tMxTEioFaigoqagJbe2FB5LW78Dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxtnviw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxtnviw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5001F000FF;
	Mon, 14 Sep 2026 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405101;
	bh=iPXFV7WbqhoyoHdqaE8UVyUuWxfYNUVV+jLy3zXJO3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jxtnviw3BedCag17+j/BHTNdDpqaSSUHebfqQZ4E/e2YNxB2LfTJqkmntAq61Fp6F
	 MATLHjhvfU541ShcF2rLtdRVu7xUdNDV9lngpptGvpZVPDVN0i6MtIgszoAGw6c92B
	 OYdhiRAeN5Mi9VTbWrmYOgh5BfR08BthO38AWzeMKkyWBYxQvHND3K8n4g+86rewd+
	 EDIg8HcsEuUsuPVKO4EO5zI8KLUvfY/EhZq/1OjwNx4XN7aXPlwJ3W8hi/26HE6eUw
	 8crQV+vraHGx9YZQ8TpRqohkngZDykU4DfWqVQkyKWPXv83nICAlszkUoVq2B36M7U
	 4stobkpu6OR3A==
Date: Mon, 14 Sep 2026 19:58:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
Message-ID: <aqgnpAqG_OS7gTeX@kernel.org>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
 <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>
 <aqbvFtlXd3Jdnfbm@gremlin>
 <00dcd8d2-67f3-4ecd-bd7f-06ba1f9c106a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dcd8d2-67f3-4ecd-bd7f-06ba1f9c106a@kernel.org>

On Mon, Sep 14, 2026 at 04:19:11PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > See https://lore.kernel.org/linux-mm/aqbtfms0_2ULBIT7@gremlin/
> > 
> > I am not really entirely happy with somebody who has sent a flurry of patches
> > across disparate subsystems with no previous track record being in charge of a
> > potentially backported fix.
> > 
> > It's David's decision but I think this fix should be taken over by somebody
> > else.
> 
> IIUC, this patch might be responsible for random CI failures (Mike still
> investigating).

Checkout of this commit in mm-unstable [ 1be399d378b78 ("khugepaged: hold
invalidate_lock across collapse_file() readahead") as of a few hours back ]
'khugepaged all:file $XFS_DIR' fails once in 20 or so runs on my machine.

With this commit reverted, 400 iterations didn't fail.

> So I'd prefer if this is taken over by someone familiar with that code.
> 
> @Willy, @Zi, @Lance?
> 
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
