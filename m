Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCA373BE6;
	Sun, 13 Sep 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288494; cv=none; b=Zwk1SYrLh10q6uNiwSzVd4BQkN6ohoPw8nLAKa1zQdz1REeWxNyshR2A2abXs5w2Q8Tt5mg22IxKqUxDA2p+s4JrvZ+Zuz6QUPlH+rnNqoOilZ3FHmRMDPP9fpYmaIQ7Gwbum6YPDYbI4T5ZW+OS+bmxlq19scxk9FGPrBwIrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288494; c=relaxed/simple;
	bh=1caI6d66uWK9U5HdnuGtv7/7d/cjaQoKX0DkZNmqYdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3sWDlpqW5m27Mpn+VHiVvfCV2uuB43789FmtY91Vf+6+ua4Z9Qqjmkv4n+fB/w0UcE2pzOx3NPjjSpYYcferIBAFRlG/5EpkJxoZNQH0HDBPPD9RDYSxwLRGl2baJr3LcWnuurvMK7iCV5Fm/0SFILUyVQtYXLjHCn8GvIl70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VbNkbRDC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VbNkbRDC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CC0AC14C2D6;
	Sun, 13 Sep 2026 10:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789288491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ma1x5lDYEMp55hiAYkooF23uLQn7TZ0/xEAqBaPw7Lo=;
	b=VbNkbRDCGM0qEZDQ/XIcdWA5N+GqDxHHZ5uqLZR1JQh2YSyTs6E0tFH53DEU8Gfv1c4kCu
	uNauQUZOAMF2ts8eB82V9TsY44c/hV4ndMjxOp4ZfmHm7wqBVwJqiKUNOwUscpo31NsMgU
	yRGpqLCu7YZn2JrbzutvHUEq3PlNACl56tl6RgqCxYVgoX1SLXghpOwk2riDcSetIbCzQg
	lZ/UoleB7atO1kUvtS0RKTeAj85+UqgOCTqKUPJVyeKPposfDDZk5WmsiFgoQwpOMmK2M8
	nOyRdFnugHtQsNWryuUFN8XSOG+dFbH45UJAJMGqlHGDEvNEaKufAijiU6dAHQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9ef3ceef;
	Sun, 13 Sep 2026 08:34:46 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:34:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net/9p/usbg: fix prefix matching in device lookup
Message-ID: <aqZgF17zCzbFwIMW@codewreck.org>
References: <20260607121907.12588-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260607121907.12588-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Sun, Jun 07, 2026 at 08:19:04PM +0800:
> p9_usbg_create() matches the mount source against registered usb9pfs
> instance tags with strncmp() and the length of the caller supplied source.
> That accepts any prefix of the registered tag.
> 
> For example, a gadget instance tagged "secret_channel" can be selected with
> "s", "sec", or any other non-empty prefix.  Once selected, the instance is
> marked in use and the client is attached to that transport.  This differs
> from the configfs tag lookup path, which uses strcmp() and therefore
> requires an exact tag match.
> 
> Require an exact tag match in p9_usbg_create() as well.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Thanks, there was another identical patch later so I did the same
(actually just adding co-authored-by, I kept the commit message the
same)

I'm honestly not sure what to do in these case but there's probably no
harm in overcrediting...

https://lore.kernel.org/r/20260719040346.88295-1-liu.yun@linux.dev
https://github.com/martinetd/linux/commit/9ee83ef8d24f11feb55fd0d222c0ec19f09dbd3f

-- 
Dominique
