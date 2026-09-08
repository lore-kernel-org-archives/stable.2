Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02B377AB6;
	Tue,  8 Sep 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900580; cv=none; b=JwtbhVkdaBYQdubEJvqlJBuSuZKQzX/2iVJEapanigpx/+Hg83K9riE+9eni56MSh5G6pS7UmHLs9ekXHFPyKLKRTJYyYXLLWTGPnKyJetnF+xvbLA2JLPEFi/3U2Qc7IF1dvOVKSSF34EXdgx3RiFO990jilLkBZTRbOzbrCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900580; c=relaxed/simple;
	bh=BdNIm5ta3VCwzOrwksPRbN6l1u9Uy/spjjcW0OCg79k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdvL9zxsTo+BLLVEvJW3AYTZhn+E7EhVsHu1Ws8PI9Xl8nhMSGEA+EXAYzB8doPZqqojz2B4Y1feA907Qz3MjLRC4WiwcX5XRyZgLEuZZznIl/7l32YrN4mduT8T9OoiV7RD/wmpAo44Cv8iD3+GbF+yP46jOK+RQlGVT8nimM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrlFMTYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrlFMTYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD31F00A3A;
	Tue,  8 Sep 2026 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900579;
	bh=L5TvYHqutXPjtrE4rDt0c1iDFHiOpTakCNmkyu5yJ6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrlFMTYpyxx40cHnbV1tKQQba74Pz6z1FgTO4JES0uA/w4XRCVpuyixAAELYcgii0
	 za6NKVSg0YkjLAacu9z+SYKIqvchfypcFc10SE5cWP0ifsyyeqOKVcdeb/rPsWlUyy
	 L7Z/2xiIbnYsuaaTQu6UuCMGvvpPjAlvSoRoO49/+cjgCysE2rxl55QC/KYdcEMhhK
	 lVVy4+qpbGZK2gJqPcSM15SG00dKiOsZ7CUchA7Ce746EDmZQmo/qLqrL4y6IlEbK7
	 wVH7OOUCNs872tOVPMDUU+0wAKtBVXhKBlnb13n+n+AYRu2n//TQw1u/PGiTqazmG6
	 5UynjjHUp/WDw==
Subject:
 Re: [PATCH net v9 02/14] afs: Fix afs to abort the rxrpc call on send error
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:38 +0000
Message-ID: <178890057821.219967.3151788385662119051@kernel.org>
In-Reply-To: <20260907113743.1453210-3-dhowells@redhat.com>
References: <20260907113743.1453210-3-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Whitespace debris introduced by the patch:
  afs_send_simple_reply() in fs/afs/rxrpc.c now contains two consecutive…

--

afs: Fix afs to abort the rxrpc call on send error

This makes afs_send_empty_reply() and afs_send_simple_reply() always try to
abort the rxrpc call on a send error instead of only aborting on -ENOMEM,
and makes afs_make_call() abort unconditionally on send error.  The
afs_abort_oom trace enum is replaced by afs_abort_send_error.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index a80b043d36be4..04756d8744e2f 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c

[ ... ]

> @@ -930,12 +920,9 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
>  		return;
>  	}
>  
> -	if (n == -ENOMEM) {
> -		_debug("oom");
> -		rxrpc_kernel_abort_call(net->socket, call->rxcall,
> -					RXGEN_SS_MARSHAL, -ENOMEM,
> -					afs_abort_oom);
> -	}
> +
> +	rxrpc_kernel_abort_call(net->socket, call->rxcall,
> +				RXGEN_SS_MARSHAL, n, afs_abort_send_error);
>  	_leave(" [error]");
>  }

[Severity: Low]
This isn't a bug, but the removal of the -ENOMEM block seems to have left an
extra blank line behind in afs_send_simple_reply().  After the patch the
function reads:

	if (n >= 0) {
		/* Success */
		_leave(" [replied]");
		return;
	}

	rxrpc_kernel_abort_call(net->socket, call->rxcall,
				RXGEN_SS_MARSHAL, n, afs_abort_send_error);

That is two consecutive blank lines, which checkpatch --strict flags with
"please don't use multiple blank lines".  Since this patch carries
cc: stable@vger.kernel.org, would it be worth dropping the added blank line
so the backports don't inherit it?  It is still present at the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
