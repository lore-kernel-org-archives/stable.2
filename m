Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123B46D2D8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590984; cv=none; b=ZOK0pev+zIfKzYIPub73QSppQjRJvFhhIIJoZW46M2+bmawa1s4rbneGWMKDmaq9N+HH5eY2UQZiJK/6PjXwV+UiRW68hdF2QAFRewZsUDQtQR3MjPNAD5mjWjzWr2VtGL/SXJWaa8B7zxLuKChXd8VmFPQa6Hp/H1xXbUHsQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590984; c=relaxed/simple;
	bh=6dq1Lggyr7LGGKiEV4R1PN4y3SmjjJJ/dOXgv41EAqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiqg8CsIfXaDQHSSlnJk5K3LSAmDqxUdWl/xabKilADFYxfFMNFj1XZAbob5E71KAtUPbLdztlDzcfhv8U0YGm7MqOXU6zTAlZUO+s1xNA1rtbCzs6yah6QrrLQ1g7TInKq9N6cTK3clpnpWXaSAS3WuUP1NzwehDQl/YrkwawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElllB9Y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElllB9Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2261F000E9;
	Mon, 24 Aug 2026 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787590982;
	bh=Kzng/FqGbMdiv9oPx2aIBOxgr9Ua0fjeIk3Vy8BJKl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ElllB9Y+SGVAbg4FFPTRUnO9bi7s2foTxMa71Ov7wxl6LAMzxNu0wa72rgZidIWNY
	 Id5BflCHeERvdFFAuIa19RmXd0x9y1WscAAw9SbTtU6VOoX2hWPrz5t/xe5LOcKnLS
	 Dsi7+9xIOm4pfFO+d+sH3575NRC0oPWuBSqZgjwQ=
Date: Mon, 24 Aug 2026 19:02:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Message-ID: <2026082417-detonate-glacial-6417@gregkh>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260824165208.498797-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824165208.498797-1-jia.yao@intel.com>

On Mon, Aug 24, 2026 at 04:52:06PM +0000, Jia Yao wrote:
> Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.
> 
> We also need to ensure the base_dpa for the queue is contiguous on hw
> where this is used instead of a GGTT address. Another good reason to
> split this out to a separate BO.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> (cherry picked from commit 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> (cherry picked from commit 99b01815957bd7d848420cb697f79ed11f7f215c)
> ---
>  drivers/gpu/drm/xe/xe_bo.h            | 14 +++++
>  drivers/gpu/drm/xe/xe_guc.c           |  6 ++
>  drivers/gpu/drm/xe/xe_guc_ads.c       | 90 +++++++++++++++++----------
>  drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
>  4 files changed, 83 insertions(+), 32 deletions(-)

What stable tree(s) are these patches for?

And what's with the crazy 2 cherry picked lines?  You all know better
than to attempt to mess this up even more...
