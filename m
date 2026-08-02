Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFA2C3268
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640562; cv=none; b=YCo+NpOPpn+yKQxlTXvtWs1+qtMQe8zbuUkK8jvIy6fJWGdZlY7b5EqoZwYRRJmedR7RhUHWmXUkQoN6M/aUQ3ufZ7g9QaRGnCsZEpcV2VpIjOH89EvD+AY+oBuwNSGSQQU6IquyUpRygv8Q5xga1cgGcFb1nzIEenCgntrvYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640562; c=relaxed/simple;
	bh=M2QFwDRn/TxHZ+8BVlzkVux/19WKZrqk/jwp1LsTIII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUOKBvq/PLV/CGJgNh4bZ2nuPTs/OWQ/8FHYGiprN50ph5Ns6m9XnkJfS9XPASzwk/uLCzbzzHscbZKLjVyDWdd09KElZ3hkAMEf8EogkY551P7WpOnoIchHEtFNKWeYJttW7/1CTm0C2Pxq2xTsuvVrCZ1uYLJ12iV/MRbpvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snasdlxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snasdlxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78831F00ADE;
	Sun,  2 Aug 2026 03:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785640560;
	bh=tNV49AtYz2KpfVIsculyxalssyUtZ3B1ZN6qqoIWQf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Snasdlxc0D2RbXQA07XAz84OHwEwGI06BiVB47ic61t7ti8WSxGkigHVHaaqXsVfY
	 TOi/a7/xpvYI5JtOv/15jjfX7DyJCb3OaPXBrT7lw4fNfkKh/a472o3ZVF/KrHdnVO
	 H8OAH8FgDFuS35cyVNDp5t1ubw3kqDOMGtFKVZKOFdn6Bxg8PcWy+HZLMZnncy0VQZ
	 ZoxkLktnJTL0f+UarpkBCgfxg7QNKzF5Y1v+3YTy1yOSdQiy7RmfDPBKjOLaOQsphc
	 cxNIpYEWSV6fXzhDIaz3/UBMuxi5jBdzA7sdbCM8R2DjgdDaT/FG81tcrq46F1zpn4
	 m153yMt0TZ31Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	yi1tang.yang@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths" failed to apply to 6.12-stable tree
Date: Sat,  1 Aug 2026 23:15:53 -0400
Message-ID: <20260802030154.ab05caca123c@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
References: <2026072912-manpower-thrift-f2fd@gregkh> <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 10:35:51AM -0600, Jens Axboe wrote:
>Seems that's already in 6.12-stable?

Not quite - stable/linux-6.12.y has no io_fixup_restart_res() at all.

What 6.12 does already have is the older inline ERESTART* -> -EINTR
switch inside io_rw_done(), which is the code ab05caca123c refactors
rather than the fix itself. The actual bug is still there: io_read()
ends with a bare "return ret;" after __io_read(), and io_read_mshot()'s
"ret <= 0" branch only does req_set_fail(), so an -ERESTARTSYS coming
out of __io_read() reaches userspace as -512 unconverted.

-- 
Thanks,
Sasha
