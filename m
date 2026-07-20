Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CD3BB111;
	Mon, 20 Jul 2026 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561921; cv=none; b=fpFSuv6IjRIpaA2YXRsAamUsI9vpaI372hRjH8kz9lidUxr1nrWw1bsXcB4hxt1rqIOn6unC+dU5Is7Cl6hxoT+7EUZmSnvNKrFmIIMzj9JNY1Wbtma1yZVBN9Pm5cHpova7Bh1OgoBUtfF0xF8UPdwlbQXVw8z+Ys7GHU3VxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561921; c=relaxed/simple;
	bh=+UsCuOV5G/ZeNTXe1z+hCUGQx28dRSxMmrhwKT3xjAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkC1F92kXIsUbgVpZqtf/E4EZUYQ58U5MqfCbQyR+gtXnaeEpNg4k3998qvfxqL/0aH5JIffECTkxEshvd3hOsoHhV6jVFQnQLnpMj1MR8QTCUy38htkCOnrxoFAULa7LyK4VH44YqaHVtm2cVYAzMPxU/k+6Ybxy1+YLm//2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+CF2QBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+CF2QBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3CE1F000E9;
	Mon, 20 Jul 2026 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561920;
	bh=320lZWOP7Be76LRxzscSD7R+x+bdzGRYS+OkSMWeIUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+CF2QBM9I1dJaRlQr96O9J8QoU0CrUC/H27CPaCXNxeJc2q0qmnRE/0raoyPxOjK
	 +6fKQvMZbkmEBEvOTfXIhoPdTXM5YnaM/+hILaWctC4PUJG2ijAMXLwt6Ja8M7wnRn
	 QT2R4FUlk9ySUn7z4F1T+7UxvZ2/SzxhX+QInRsHcQD32KzE6EnMg+JTTvslb+ACbn
	 bZ4yNE3XuZVsSNEkERUYK6NUyHrAPeS8C6mdKscMfStpZVmoRnu67cGTkmBWtotKrO
	 +Y2JQaHhui1c0GXEnYTLJ/RqpaHhyoZxyHfxd3ieOzlytoe6G7ZkCkDEhDVYLekwm+
	 FstokRc8NABIw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Yikai Zhao <yikai@z1k.dev>
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 08:38:31 -0700
Message-ID: <20260720153832.90939-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720094708.243937-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 17:47:08 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Commit 2f54908fae211 ("mm/damon/reclaim: detect and use fresh enabled
> and kdamond_pid values") introduced a typo in damon_reclaim_timer_fn()
> where '!=' was used instead of '==' (unlike damon_lru_sort_timer_fn()).
> This caused damon_reclaim to return early during the delayed work,
> breaking early boot parameter configuration like
> 'damon_reclaim.enabled=Y'.
> 
> Fix this by changing '!=' to '=='.

Thank you for quickly fixing this!
> 
> Fixes: 2f54908fae21 ("mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values")
> Cc: <stable@vger.kernel.org> # 6.1.x
> Reported-by: Yikai Zhao <yikai@z1k.dev>

Closes: https://lore.kernel.org/CANMyjpgq5n0Ekt4dgyLRHGb89_Ew0aOMZ3j32V_w0GjHkqH1FQ@mail.gmail.com

> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
