Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A379CD;
	Mon, 10 Aug 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357414; cv=none; b=QYiW7zKRJZOEm6jLfEt2zPUsW3P8a/Kv7OqqnfZ3MigrGKQGfa5h/BrhlgcZUuoKsyV7yxJY1z7wOYW+PkV/9zgCiTGrSWO1nZtHd4iYWy0FM7+PG5RlMBCmgA2B4F+A7F30LAH4LWF7RKysX21xu8yxGaHuKFkFPZ2MvAAye+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357414; c=relaxed/simple;
	bh=9Yh0clu7u4lVtVh34Dp+gC0JFh93WPNsk9BS18L/SME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/edH8iY1eCv7mPPh6P2L/qpT7NnJOo28W3YvlyfheOJqlnL+/VfBKL5kCD9r+Vw5WDdGz8eL+5nz5kG20d9HESYmxOtEfx0yCDGMJpxunyW09KZkkwdUa+AZKu1GFriq7GrCn7sC20p+nrtqeLCJLJyUxTArQuLYpfCAuLqQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpX7kahG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpX7kahG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9951F000E9;
	Mon, 10 Aug 2026 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357413;
	bh=vnUvrr7IoocGT4/KYIcdA5t85DKhlgAR1KS3KJm2ODQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jpX7kahGlSVvtJiml71y4ohVxG2JqWKw3Ncl83nF8OTCr459uzpMStWUaX4r+u8IS
	 D2rfvl0Yoy/CwB9EiZihP/7eSGSEJIumFhvi0IxhP4KaHew+3GZH7KI/RequYqWKPq
	 y5IxJbOhBjAExidSYWsT4wLTMN4Pg0Ohk95Ft12DNNncJ3RHs+A6NeAI2l8VA+eYoz
	 im/VW6MV4dHIL9ZBcqj/vADtP39eks2nIpo+7ILFHiMA45GSQbd3hKRAtjAu3EWigM
	 HIXbBHR15pBlTg/1SVR/okY10Ak+hIzJMgsCm65fo4dno1ZZCgdae8nzR5zwDN/G/h
	 7m6NLett+khag==
Date: Mon, 10 Aug 2026 11:23:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, stable@vger.kernel.org,
	syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com,
	axboe@kernel.dk, io-uring@vger.kernel.org, asml.silence@gmail.com
Subject: Re: [PATCH net] net: expect instance lock in
 netdev_queue_get_dma_dev()
Message-ID: <20260810102328.GR51943@horms.kernel.org>
References: <20260806225627.3998672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806225627.3998672-1-kuba@kernel.org>

On Thu, Aug 06, 2026 at 03:56:26PM -0700, Jakub Kicinski wrote:
> netdev_queue_get_dma_dev() uses "compat" locking assert which wants
> either the rtnl_lock or netdev instance lock. This is not right,
> the callers are taking the instance lock unconditionally. All entry
> points for queue config are purely instance locked.
> 
> In other words the callers use netdev_get_by_index_lock(), not
> netdev_get_by_index_lock_ops_compat(). All the state we will
> access is effectively instance lock protected (it's const for
> devices which are not ops-locked).
> 
> Update the assert to avoid false positive warnings.
> 
> Cc: stable@vger.kernel.org
> Fixes: b6c5f9454ef34 ("io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock")
> Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

