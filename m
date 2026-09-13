Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC22BE65B;
	Sun, 13 Sep 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789292738; cv=none; b=SSaRSDxHA5tHlQbdsXI1XG6KW2l3oU571agrVWXCyEU8LBaqSsj5nIS4PyaVE4LwFe813P9zOQwf6uFJ9FpX/XvQmS6MWN2dafs3kDsYvpDsTxMsEdL63HJ06CLVDFLS0Sx0vvcFjOnqHhPI8f/bV6jC49heLW/UqUMpwxZfwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789292738; c=relaxed/simple;
	bh=fxZfcUwrGuLbBq1at1NH+rfhj1ofaZCGvEtNjvvI0V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdLPsHrBEohpns6/xMj0HkbAo31A9Vm1DE6ATOvgiklhTZFWaHBgBnPhLnm5nHynb4OPUcBywCQdxNM9mpQlAVNJ0MTatw/R060LyoIGEY8A301DjCXpsaOgRQAD9SEVO9vIJKv8Dver7+n+ANL+mU+SGftFL3ixAszU3KNItRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=lLcxZi1D; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="lLcxZi1D"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F20A414C2D6;
	Sun, 13 Sep 2026 11:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789292733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mntXXygWBINUxvtj0AxV1Eods6rKk9GuaqJdGpeqf70=;
	b=lLcxZi1DJDTuc9DOL9tOMNq83rN637b7422Twq9WU2UpAUQmN2e20QvI/T5+p2Bt+APcGo
	j1ENMo5Zev1GVftNtJCDZVg3kqVMSTx9RAAmMbCFwomMlq3FYmNrc9NEar+qfRlwchZR/h
	RAtfjnHvPgkKpYih9D2yA4s10XrYhVKI27OkgpmPG+cpUpgHQAs+jsyLlzFbVraZnM4QhR
	ckS37ADtM63Xfre+GphP1mnQPMEsDP5rDc1Jwc4ejFBFKbY+bUZeQiVaSEX7acDDxAUzwx
	VrpELkWF5E/YigawYLegUgI7q4+/1xxxiB6Ruba7N1FdKwUQwRJ+INYedaRslg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 42fff295;
	Sun, 13 Sep 2026 09:45:28 +0000 (UTC)
Date: Sun, 13 Sep 2026 18:45:13 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Message-ID: <aqZwqdnm7PW8OUv-@codewreck.org>
References: <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Sun, Jun 07, 2026 at 10:06:01PM +0800:
> handle_rerror() copies the variable-length error string of a zero-copy
> RERROR response from the receive pages into the request's static response
> buffer.  The amount copied is bounded by P9_ZC_HDR_SZ, so the data can
> span at most two pages, but the helper is not told how many receive pages
> were actually mapped.
> 
> If a malicious or broken virtio 9p device reports an RERROR length that
> exceeds the remaining bytes in the first mapped receive page, the error
> string is treated as crossing into a second page.  When only one receive
> page was mapped, handle_rerror() still advances the page pointer and
> dereferences the next entry, reading past the allocated in_pages array.

I'm not sure that can actually happen:
If there was an "in page" (if there wasn't this is all noop anyway and
data was written directly to req->rc.sdata), then req->rc.size amount of
data was received into the pages, so if it does happen to span over a
page boundary then there are at least two pages and we don't need to
double-check here.

Christian, do you agree with me this patch is not required?

> Pass the number of mapped receive pages to handle_rerror().  If the error
> string would cross a page boundary but only one page is available, copy the
> bytes that fit in that page and leave the response truncated, matching the
> existing behavior for overlong RERROR messages.  Otherwise continue with
> the second-page copy as before.


-- 
Dominique Martinet | Asmadeus
