Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3753BF67A;
	Wed, 19 Aug 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153646; cv=none; b=XzS8P9xnprluBGgCSLIrTuQmM79hLM3xQbvXMQBXI4C6ZRg1EP76peszAUa82gSODxBPesnCJsb2GXy71Uqjk19CqIqRCZqJQ4yHrwmZc2JZycMqEJ8HfpSmM4GKUiG3O4TE6EfjzW2rXKghn9sGC130ogpMRzxblO9BAwrGR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153646; c=relaxed/simple;
	bh=/3uGvBwBcsoy0uNTfX6Jna1UAY900+/0RZHlDJx/WS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc24LlteZb9mShgarEO9+eJGNVgckmsYUwbvaHLK3781pRZPZYcIo2KcHqvtV2Ei/RaPLt9osAEZQrMjnKN6i2HXDttFIzp26F3xZ/wNh8koy4JqGZUzc+FTcVrXdLrpTvFPWKRV2sfVzlckoSTsmhlV+y+CZfJKL1Mf8r+nZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDKl7uBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDKl7uBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C721F00A3A;
	Wed, 19 Aug 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153645;
	bh=/AbQ3S8aGxqK5iofr0fazeU2d3tOj7rvF9ihEQ/lF/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDKl7uBA/FuXOmUr/2tkodSU7lSxppXUzNfAo/aomp4B97OZ0oZTwEwPopwzXlcld
	 ZL0Im0m4kQP4VKUJ7P+KuqOHu+3xWfNwrq8auqEMEXabNWCJFgcn+1OW2lIj0W9Dat
	 j7SlE72PvYTaXYhHKgWRGbc/aRo6r6jCultAD1sJRoeLdKn9DAyF0LvLw3Ptv/+9yj
	 EtiEmrJVIDrwkoxqvYBheUyL524x3jRuub1bPk3k0WqPMjAZ5iCSMCSmaE0FrBzu7X
	 beLMMv1eeh7COMH8nb8kPdMy6lImkv+pfAkWpRpLo+Rqm+b2WE8io4c5H68IiE39Rv
	 2LaJYSMNeyfFQ==
Date: Wed, 19 Aug 2026 09:34:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Message-ID: <aoXM61XULtnUeVg5@kbusch-mbp>
References: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>

On Thu, Aug 13, 2026 at 04:31:07PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
> with match_strdup() before validating the DHHC-1: representation.
> 
> If validation fails, the parser returns -EINVAL before the temporary
> string in p is assigned to opts->dhchap_secret or
> opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
> but nvmf_free_options() cannot release the unassigned temporary string.
> Each rejected option therefore leaks one allocation.

Thanks, applied to nvme-7.3.
