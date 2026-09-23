Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2915483829;
	Wed, 23 Sep 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159866; cv=none; b=VsMMjkf8thqwShGAqIfrYCkp3YMst6EE2VVKG0X4dv3YuBI7rSipGfbDKUsQLA7n+D/QNMoLCLMJxZ3Jl1ISc0/XJPRaazpeUBtju1BoLwM8HhBBGC6l6N/L25N0CjAn+7+5eGy2g8BZuY7usoAWnQ8c/7B2yd1a1yPH3zAXtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159866; c=relaxed/simple;
	bh=ivPKQO275bIHoaGWzftuJz4sePC704OiJnvhK7pEW3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsmPIneW0NUkacVGepKhsEtVCBvGACv+AMbT0cx3Pd0kJREgeUGvAg3ZQ8y+EGZk9S2KicQy1etCyuSF7NrXKWdkAdeUp3qoP0hVSC98jRsiIvKY/4cPs/f62Ebw9b09fI1zKDcFaamDMkcqI8Ep/vCuXFPEf7xVhZSoFT78u0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MG1ZQJTl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weFnxqoV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MG1ZQJTl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weFnxqoV"
Date: Wed, 23 Sep 2026 12:37:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys+yTlQA084sSegBBXyRjp6onu4OnYNCVWTZ5FFWaVI=;
	b=MG1ZQJTl7q03HKAJcsqgk0eGbUiFnn7cuEm4rUxYBAIRxnSJhIHI7fsc1SaPdQpQVXQlw8
	lOCrZcM56htDIvaVL0JUJeF/rfd+ypjvs+mcnHPL9k3KBLF5SCSIdsQ8iSZ5F7ideTokhb
	GzdXjn5dwpDYosw5GcH8QWkzZXdYHOcNajmnWigt0+P7Nr/7pKPKbhqNsJapQimaog6nZt
	AWfKzjQD5ttlr2v/MdMCxzs+xSYEPyL9+exGLzKh8PsPj/f3vfBOiBk3jgIzAC6pjYWjeX
	R2kkq4RrCZ9Ox+0SFOIf/ksCP6EjsjE2is/5NRNhTG4ngQeIJc0kQG/BMqZv5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys+yTlQA084sSegBBXyRjp6onu4OnYNCVWTZ5FFWaVI=;
	b=weFnxqoVKcZ+r17KfN0QO+bvu4v3xYLk8M2pRppLWR1u6rycwD+w+2AATu1iksblC9NUAc
	lBJGAwihmY5ezPAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/4] net: hsr: shrink seqnr_lock to sequence counter
 updates
Message-ID: <20260923103725.kB_5-sDD@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809121455.1745-3-xiexinet@gmail.com>

On 2026-08-09 14:14:52 [+0200], Xin Xie wrote:
> Commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
> incremented outgoing seq nr.") and commit 430d67bdcb04 ("net: hsr: Use
> the seqnr lock for frames received via interlink port.") hold
> seqnr_lock across the whole forwarding path. Transmitting while
> holding the lock can create lock-dependency issues when HSR devices
> are stacked with other net devices, up to a real deadlock (see
> Reported-by/Closes).
> 
> Since commit aae9d6b616b5 ("hsr: Implement more robust duplicate
> discard for HSR"), duplicate discard is order-independent (sparse
> bitmaps), so only the sequence counter updates need serialization.
> Limit seqnr_lock to the counter updates in handle_std_frame(); the
> master TX path (hsr_dev_xmit()) and the interlink RX path
> (hsr_handle_frame()) drop their outer lock, and the supervision frame
> builders release it right after their counter update.
> 
> Concurrent forwarding may emit frames out of allocation order, which
> sparse-bitmap discard tolerates. The master/interlink tx statistics are
> no longer serialized; consistent per-cpu/per-queue statistics for all
> HSR paths are handled in a separate series.

This fix relies on the bitmap seq nr handling while the Fixes commits
below do not have it. Doesn't this revert the synchronisation change
leading to the problem it tried to solve at least in the stable kernels?

> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
> Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
> Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Sebastian
