Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC7382F03;
	Wed, 19 Aug 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153528; cv=none; b=u0nWfd2z2omdkvvO9EbESGJaDXsQK/0ZEGwHko63pYSV0m6KnhnStzHAdAHBYzbWqIGlXW6UAtM0tDvOhinMsy+NbwxOpGLNUqZd9NSPL9ioyvW9qCEbnSJ+H/rkqhGrLbhkesTpfWyzARoJIhRJxxKx5tQpOXj/yyBdZroe/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153528; c=relaxed/simple;
	bh=cTUV3bVrwGDDdNgR2PugOcHqhAsis67Ysq6II+zazJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTRTDjKLKXUnm847tXqhQSc7pR2QydnT5+bPCtpY/tJN2qGo24QuqZgUYtla0nGIwAyCs5ikx6HP1gxwnTfMwD5kGlPHlJjxB2tmwj4CuH2RBhByMQR3yVrhAWQA9UuIjHn4qquH1kgJ7zR6mgTsAxrZRyJGGMR/Rln/oE+DS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy2D6ah0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy2D6ah0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E511D1F000E9;
	Wed, 19 Aug 2026 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153527;
	bh=++b0GHZbwINw/a9aQSLlA8nye5n4fj9t5uGfoHxF3GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yy2D6ah0JQKy+rs65htcfWd5uWNNZDATwLS00+WVE3r2/IU1OenZjv+iGy/OWWAYy
	 1+9EbCB1S9sOOZ7VMuUG31jHvDtzRHUwMvH/N22fcqwHEhvxAXvxjbgl1wzqAMh6w5
	 Omys6uw2YMxX2JLhAU7fMGjsSRO/B1/XE61tsw04OYo0XfHN9b6wZUX9fC9NeQ/N3P
	 mYlytbDw/3G0ukHr7sGygjWFZ+n0oH2KCrYr8hfQOm8X5iA7QX767Y3WhIs2oTd1L3
	 d3Zrw1ZFZAeSjFagZyZbcG9wzR91Fj1JPUIJULLSoMT/KNb7oaF12736CVtJ1XIE+3
	 XiKFE+LB+qCmQ==
Date: Wed, 19 Aug 2026 09:32:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, dlemoal@kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <aoXMdbA6laYL6aXk@kbusch-mbp>
References: <20260817175859.2966055-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817175859.2966055-1-coshi036@gmail.com>

On Mon, Aug 17, 2026 at 01:58:59PM -0400, Chao Shi wrote:
> nvme_query_zone_info() returns either a negative errno or a positive
> NVMe status code, but nvme_update_ns_info_block() only tests for the
> negative case:
> 
> 	ret = nvme_query_zone_info(ns, lbaf, &zi);
> 	if (ret < 0)
> 		goto out;
> 
> If the device fails the Identify Namespace (I/O Command Set specific)
> command, or the Identify Controller command issued by
> nvme_set_max_append(), the positive status falls through and setup
> continues with the zero-initialized zone info.  nvme_update_zone_info()
> then marks the queue zoned with chunk_sectors and ns->head->zsze set to
> zero.

Thanks, applied to nvme-7.3.
