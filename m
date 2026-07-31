Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134B442120
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512646; cv=none; b=GSkmVJoZd2zVbr666bTs1+4U2/YFwI1yi8HjxxJI5JkYKVG0QeXC48uMtGLmLcc+F094RYNQzFDpAbjxAyl0ZTwC2D/Um9sy7coivqdmoM1eJCkajMugTw18DJQMnBI4utL9b1XDY+82fXFMPVQvAqJMpitbnDKl6D2W4T/3ZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512646; c=relaxed/simple;
	bh=+XG+Mh8yW32nwruJvs5t7gq02xrcTlg7p4alaa7Ltng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3kCCeX9Pe9tPS/pPK7bEya2LNjgDjJXhZCFYWw3di0ghBAk03HTi39Ul+RlrWsjYN29TM5zqOjpQbEVwBrBJsaFRasqImd2Ob2eRmsjhYYnkMlaEVZsoIcYORb52GjW46zroKyoX5oQYNG933bvtyqonrhm+tE8/b/NKsx1z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSzIzuxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSzIzuxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA7D1F000E9;
	Fri, 31 Jul 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512644;
	bh=mI5bKbZ5XZcHbyBNeezoo1B8QPg1B7GrwtNRQGHZIvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jSzIzuxscYTh8cy3ToB7XacrotlmaRxxO8TYtPmlPzKG66aCjm/DODfWdFZzYdGqs
	 VD2Uo6Q8TVLBhmyiP8x5Uq+p9RY9wXM0vjXyTf1RqEOCRgsVQTQL/PrBPlSvJrO1KG
	 FFOWoqF6kgGTPpRtYXcEYVsmGPSS2HCloTSwMR3A9PiLkUhyDzwl91MrmBDy5d6OGJ
	 XkBMjVHj3GVGcKEu0Kq4Jlm8H7jxa8SwwCIaMCtc/iM+fMsgWrP+u1oN/RItQp3TJl
	 8GOz/Ksj8VUQ7alOIYAl+L5aHVxrbp3iEfT37MI27FjnWG1HM4Oul92CdkhGCcW1m3
	 12oXmFx29pwSw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared function 'kzalloc_obj'; ISO C99 and later do no...
Date: Fri, 31 Jul 2026 11:44:01 -0400
Message-ID: <20260731145256.GA1841293@sashal-kernel>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178542714373.4058.4312420996135460246@kernelci.org>
References: <178542714373.4058.4312420996135460246@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 03:59:04PM -0000, KernelCI bot wrote:
>New build issue found on stable-rc/linux-6.6.y:
>
>/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1086:9: error: call to undeclared function 'kzalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 1086 |         pmem = kzalloc_obj(*pmem);

The stratix10-svc patch was already dropped from the 6.1 and 6.6 queues,
so this particular failure is handled.

--
Thanks,
Sasha
