Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731D3033EB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807887; cv=none; b=uc2N42wDXFFl27nj37tBdRoll4mU9U1ThvrqKkMr/vOjg/j1qeyKFI+S5v0xdi7eyeDm/UfaLKzTc6g7Fh/vPmna8fEL9dOU9nI83OUYqyr5AXgy6Ffj4dYs4JFghyGzI/+hPlz8JC8Usk8V90kRnqoZCkKy16VbTmts6T2VKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807887; c=relaxed/simple;
	bh=kjTXdFx0hYlZSg0bJOrOECOIPiG76y6pgmYhTKFgpik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWqTyOm9H1gEQMQneunc0NONK3lqY5HNmW00Mr+V7R6WPcCWg7LFTMVywkmRZhngPgTKwM9/j7KBBB3up0V/ppmOgmyVK4UjEUVY+IdzhDPenq4UpHTG6VD7wuHaqOZ6GlgmWTt7eOzClOhpWX9VXA832XUjVpFiROyn/TDCDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBdbeA+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBdbeA+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921B81F000E9;
	Thu, 27 Aug 2026 05:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807886;
	bh=hHGfECbOChgmTOLrziXlJ3w/j+HKsp8cs7KmczNlu94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBdbeA+xoVTbLH7WvqH5kwDqyGt9ZeRNO/EKR5monyaanbnCRgj5wLeO0GE97nGlP
	 M18SnSYCCyZmTWGHjhfK4bQWMP2hcZdZKCpvImPUCoh0lhhp8u9zQ7iTVF3CJ4pcK1
	 q3Fg0g3T2bvItzvcUh294mvcZecI3zy5Ntc2VqKp5fxva/FtXN9N/0LE2c4xpWMJ48
	 PU4xpW+bw7I2Mrj1rrwMWvqkzlsW8kzIdZ4fdnzm5z9/DP/B3JkocHMEGJ7SiDHHK5
	 brRqlb69fizaqrBRmoQTFdapySwmQkH+FbiT96yVAXnrJcOuz5auD5RnYoU7d01Vkd
	 G6S4BDkbVeQKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 5.15.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Date: Thu, 27 Aug 2026 01:17:55 -0400
Message-ID: <20260827050834.10005.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825201314.1687660-1-yanjun.zhu@linux.dev>
References: <20260825201314.1687660-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> free_rd_atomic_resources() iterates using qp->attr.max_dest_rd_atomic.
> Updating max_dest_rd_atomic before freeing the old array can make the
> free path walk past the old allocation and trigger a slab out-of-bounds
> write catched by KASAN:

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
