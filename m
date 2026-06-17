Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C47318EFF;
	Wed, 17 Jun 2026 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719747; cv=none; b=IALwM4CtK6cLziszGCBzBoiLKwb6/VbaGUvaqb+5ph/wZO6KvL47aTLUMjgfn9S/Y6z4zKCRq9BVK8eb/inCvsjQPF+zUeh8+nEYuAGRe92XPCnOOq+PlrmYspmVXjj3B2nX0XyQsyYq9S9X+R0JfbFogTATLgLPFIeaQxQxg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719747; c=relaxed/simple;
	bh=8ZmRW4mX2Dv9ATUZb0Ea8pdMkv24H41DyPo6k6Ue8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4s9YU6+Uig+860BsoQ5G6HTbGnjmAzUeFqIal83Z2a4sEGZOi3hpBXE1m4SnB5BbVrzY0Vs5lk0spSs0OsQpp4dAQxFSMlz/nIs4YXvchmAIbJzFdV1ZKyjzTEOZH2ErzU7iuu1wDIMmArpunVqNfcDG3z2l1xgdLNwmNcsG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLA8Wfv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLA8Wfv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4571F000E9;
	Wed, 17 Jun 2026 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781719745;
	bh=5M72rRNDNk4gzJoqbel9sUQ88muLiWkbO9KQPjKK0g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLA8Wfv3wYG5UQ2SNt/9vO/cufYZsF+7sZZb6ROt3qMVwnVDlbSUKkhREi4uHJeh1
	 n6jGONZjekietRyamgpOG2DI0qq63ypRzQbRsjbCuiMJYNqElh4cp4RoIi50qWsFHM
	 h5KQ+uhGll/1Zh3NdQqIaEmBARy5aU3ANzYuQ12c=
Date: Wed, 17 Jun 2026 23:37:55 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.18.y] io_uring/net: Avoid msghdr on
 op_connect/op_bind async data
Message-ID: <2026061727-thirsty-sculptor-1e6f@gregkh>
References: <20260617175102.2976716-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617175102.2976716-1-krisman@suse.de>

On Wed, Jun 17, 2026 at 01:51:02PM -0400, Gabriel Krisman Bertazi wrote:
> [ Upstream commit 3979840cd858f30f43ea9f4e7f7f1f56de82d698 ]
> This fixes a memory leak due to the lack of the cleanup hook for the
> iovec.  The stable backport differs from upstream by dropping the
> io_connect_bpf_populate hunk, which didn't exist at the time and by
> fixing the merge conflict due to the introduction of
> io_bind_file_create.
> 
> Both IORING_OP_CONNECT and IORING_OP_BIND reuse the msghdr object just
> to store the sockaddr. Beyond allocating a much larger object than
> needed, msghdr can also wrap an iovec, which will be recycled
> unnecessarily. This uses the sockaddr directly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Link: https://patch.msgid.link/20260602215327.1885109-2-krisman@suse.de
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  io_uring/net.c   | 36 ++++++++++++++++++------------------
>  io_uring/opdef.c |  4 ++--
>  2 files changed, 20 insertions(+), 20 deletions(-)

This isn't in any release yet, why just 6.18?  And why wan't it
originally tagged for stable?

thanks,

greg k-h
