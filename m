Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC5339363;
	Sun, 13 Sep 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342635; cv=none; b=QKjwm9jrWt5J4RvsigzHcoLKfyRbrsLfauv2ONWquvMtMFfL3MjdSN+f4U3/+11QqGTwFMxW+zR3gpt00F8xNm6ZTYrG0tMr4IPGBktjqSc4QiuTGg6jQhCW281qC1NP6zeZqD6e+cRdQkGmbrMdU0nHAQ1MtZYnNzb9dl0x+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342635; c=relaxed/simple;
	bh=t2zhvhfVodgUoXgapbWkLn257EwJZmghPAu8AxgOCM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3TNbxNML+xVNlA5S5cBBaj+tzSF4BLX9YKzIdngzAMJVFedCKjpuYw2X+wOruJ4Li9//02Trma8XEAWCoWgXW1VsUnFlvDxwmvM1iLmgFShFDW2Po8nRJ7onxMWtfqL2UjR7wTy6VZZqBencaQx2Nywl+5t2GK63jFAygUSNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FFQMgCJo; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FFQMgCJo"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1FECC14C2D6;
	Mon, 14 Sep 2026 01:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789342629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2O8L0LKx2hGeIX51IUswVSIofdl6KTJAE2rOz4nBCQ=;
	b=FFQMgCJoOi7i6rv/+e7KrV9zLkR2+Y1FikaZzFv2j/Fu0sQyG4KKruQziO2SMkpb77LrI+
	Ljp2X/nYud198fdZ1+rZuIj3FxoHBWyobyRw1yuNYEb5AtcnmyFc7kuaoxnsE3BGYnllaG
	0a3m5bgrY6PD5P2hWl7VRRb9UiIOZJGqgYHoJgFhLEntud0dctcvEIUllBSkb5iI+1GQo6
	Qic4c5jH4cqLPMw9pBZGf9PuurvNfL0bT5vSKXEl7dIc6KCjozj9ORzb8E0KCFgYm9OjcC
	bwKm1mbZja0Axv3diAjiRNPx2aM+wV3m8jfuFi5b4m97bDURvpsCqPJtQRGzHQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0a35401a;
	Sun, 13 Sep 2026 23:37:04 +0000 (UTC)
Date: Mon, 14 Sep 2026 08:36:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Message-ID: <aqczkXDT-thZshJr@codewreck.org>
References: <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqZwqdnm7PW8OUv-@codewreck.org>
 <23241140.EfDdHjke4D@weasel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23241140.EfDdHjke4D@weasel>

Christian Schoenebeck wrote on Sun, Sep 13, 2026 at 08:09:05PM +0200:
> > I'm not sure that can actually happen:
> > If there was an "in page" (if there wasn't this is all noop anyway and
> > data was written directly to req->rc.sdata), then req->rc.size amount of
> > data was received into the pages, so if it does happen to span over a
> > page boundary then there are at least two pages and we don't need to
> > double-check here.
> > 
> > Christian, do you agree with me this patch is not required?
> 
> req->rc.size is coming from virtio device's used-ring len, and that is written 
> by 9p server, and this server-written value is not verified anywhere against 
> the real sizes of the descriptors that guest provided, neither by the kernel's 
> virtio subsystem, nor by 9p client.

Wait, is it?
req->rc.size is written in req_done() and comes from
virtqueue_get_buf(), I assume that was the actual data obtained from the
transport (e.g. akin to read() return value, not what is in the payload)
Or can the server lie about this?

If we can't trust req->rc.size I believe the p9pdu processing will also
read past the end of buffer so there are much bigger "problems"


With that said, I agree with your assessment that qemu is mostly
trusted, and don't want to spend too much effort on this (unless
something like me losing my job happens and I suddently find a lot of
free time :P), so if you (or someone) can confirm rc.size isn't trusted
then let's drop this here.

FWIW I said "mostly trusted" because lately we've had things like black
box hypervisors (I don't remember the exact name) where guest VMs memory
is encrypted and can't be accessed even by the host: sure the server
could still *crash* a guest, but it shouldn't be able to get arbitrary
write/read primitives, so if someone wants to spend effort fixing such
bugs I think it's welcome and I'll be happy to take patches.
(although it should probably start at getting a way to trust the size
e.g. clamp it to whatever pages we fed to the server rather than check here)

This pretty much aligns with what Jürgen said for xen recently here
=====
https://lore.kernel.org/r/931b763d-2ee6-4fbf-9222-c5b75f35ec47@suse.com
> Especially with driver domains malicious backends are a thing. They should
> only be capable to deliver wrong or no data to the frontend, but ideally
> the frontend should not trust the backend.
> 
> Any work towards that goal is to be supported IMHO, and there are already
> frontends listed in Xen's support statement following this rule, so any
> violation of that principle in those frontends will be regarded to be a
> security issue worth an XSA.
====

> P.S. Remarkable backlog processing today! :)

Thanks! I _think_ I got to at reply to each mail I wanted to look at
overnight, but I'm sure I missed some, so if you have something in
progress that you want me to look at feel free to ping me again
(and someday we'll be able to get through the virtio backend page
mapping rework started in December[1] (Christoph Hellwig didn't forget and
pinged us in May...) / your msize limit lifting work[2]... someday...
But that should probably get priority over chasing untrusted servers)
(The links are for myself more than anything else, my working memo is in
flight mails)

[1] 20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org
[2] https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/

Cheers,
-- 
Dominique
