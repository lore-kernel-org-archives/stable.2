Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D037D131;
	Tue, 21 Jul 2026 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643098; cv=none; b=Gg+30yC1KFHBWFpRXVhaEPxl5hD3+VSKwnq8ZQYTHYyDajmrvtjsNoQdnPG0O4gAMUmddixjdOQOwAhCsIKIU7mhiOHg/6kqI05Pb/PaWTdVNtUU0nga943f45mONJVgXgVPpJIHCtmh+Ino2vU7Y6CZ2xzCWhvWVo+9OGm3wAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643098; c=relaxed/simple;
	bh=rpFqOx+TsMaVwS/8DdMCOrSKpISWlzOMZL2nv+19d8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2OIs0kWJt8yx75jzEYitu3HM2Ro8DtiRUi6BUh6oSNfszeRR4l30fdH7U3iVJsUVoi8N+slkz97fOxPNtk1OKRN/n9cNVfZNKpOR+SQ+yEbL+YnX2RJ3hOSkgLz2kSdoHlfXfkS+kjDiV1VgRdt6L4OYdZo9HvkTVkL8cSnxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5dYi+mx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5dYi+mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739671F000E9;
	Tue, 21 Jul 2026 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784643096;
	bh=rpFqOx+TsMaVwS/8DdMCOrSKpISWlzOMZL2nv+19d8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y5dYi+mxTGv0in5N0FFAm5BWI1Yg1//GcmBDVLzKLfm3BDzh105Ightc2rdtZ1ydz
	 JdY/GvONP/ucNnh6OU7HwQqVQltBaru2IZxfF/pOcilqhJ7aJ+2ZnLUxcumOt5j0Qv
	 O0ymlsgR/93f+HDqrg6FAbn6HE04xo4up1/9thx0=
Date: Tue, 21 Jul 2026 16:11:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: stable@vger.kernel.org, Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Sasha Levin <sashal@kernel.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH 6.6.y] mm/memory-failure: fix missing ->mf_stats count
 when hugetlb folio already poisoned
Message-ID: <2026072119-facial-encircle-f1c8@gregkh>
References: <20260721121956.124887-1-xiqi2@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721121956.124887-1-xiqi2@huawei.com>

On Tue, Jul 21, 2026 at 08:19:56PM +0800, Qi Xi wrote:
> [ Upstream commit a148a2040191b12b45b82cb29c281cb3036baf90 ]

That is not what this commit is :(

