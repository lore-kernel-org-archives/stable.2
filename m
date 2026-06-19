Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB41E4AF;
	Fri, 19 Jun 2026 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848871; cv=none; b=OPAzKlbyPcA/4DavaI/9u25o2aDLZZzWad1MelZ1ZI0Rsv1H3CVc4zltytgxVcARno/Ep+uA1INee+kk093uao0QNqfRRZNJ5G19FuGdS6zRkRx64wPnzs06TJj9dj/fGF4ofa3/XhSqGh4ijXncXQ7frDZrV7jk2yC/mlO3WOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848871; c=relaxed/simple;
	bh=X+akqTqLtBmiRVDK7jVYa9Ny8yp+mvzw/+z4YS1geiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3j5itkT9x3roTF36RDDqxa6NVnurz48Hm4r/5xjAXxFj7bdSm4Hjf6/BUagzWQPVIcZ0n+a58biePXPjWBMvgC646T/J9O4V1MRIZUmGIiEYKhTNGDpEN1M77zD0VwjZ18IO0V4BXWtSd49xNRqt13i7+vLoy/6h0F0eurjM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRnBN/Ep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRnBN/Ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEBD1F000E9;
	Fri, 19 Jun 2026 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781848870;
	bh=qQdVpG0RcXd5ixABZJ3tD1V9oXxN2i7aAhiPvNPHISk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZRnBN/EpwVbqxj38GA/Xiv5F2TKrboxnSofmAsUKgzxFV6g9S6qNf8AJ4pxIPJDDv
	 xGn6qFrnefAq3XILSOZWz85CeoYeIsS8U8pmZZHvs6ck+9xAaVV84GIWW6/WlQtCTj
	 YLx0KpgGc7mwxvcV30ML9H+IftsU79tHbvQiJBMM=
Date: Fri, 19 Jun 2026 08:00:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cyber_black <Cyberblackk@proton.me>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [BUG] io_uring: possible CQE32 overflow flush inconsistency in
 __io_cqring_overflow_flush()
Message-ID: <2026061918-symphonic-glass-17ca@gregkh>
References: <wK6w40HQFWE32Zzw_hyI9ctCQpBgXgOxWsfBFc2ptY-VZFPHBE5_wzDIu4AT-8ZX2wdr-C3-T6g3mUblIqOMqjCvBhTyMRg0BvOCwmh7E-E=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wK6w40HQFWE32Zzw_hyI9ctCQpBgXgOxWsfBFc2ptY-VZFPHBE5_wzDIu4AT-8ZX2wdr-C3-T6g3mUblIqOMqjCvBhTyMRg0BvOCwmh7E-E=@proton.me>

On Fri, Jun 19, 2026 at 04:49:32AM +0000, Cyber_black wrote:
> 
> Hi,
> 
> I believe there is a bug in __io_cqring_overflow_flush() in io_uring/io_uring.c
> where `is_cqe32` and `cqe_size` are left in an inconsistent state when
> IORING_SETUP_CQE32 is set, potentially leading to an out-of-bounds write into
> the CQ ring.
> 
> AFFECTED FILE
> =============
> io_uring/io_uring.c
> Function: __io_cqring_overflow_flush()
> 
> KERNEL VERSION
> ==============
> Observed in current upstream (v6.8+). Please confirm against your tree.

Huh?  Was this written by a LLM?

> PROPOSED FIX
> ============
> If Block B is intentional (i.e. io_get_cqe_overflow already handles CQE32 slot
> sizing internally when IORING_SETUP_CQE32 is set), then cqe_size must also be
> reset:
> 
>     if (ctx->flags & IORING_SETUP_CQE32) {
> 
> is_cqe32 = false;
>         cqe_size = sizeof(struct io_uring_cqe); /* undo Block A */
>     }
> 
> Alternatively, if Block B is dead/incorrect code, it should be removed entirely
> and io_get_cqe_overflow() called with is_cqe32 = true when appropriate.
> 
> The correct fix depends on the intended semantics of is_cqe32 vs ctx flag
> inside io_get_cqe_overflow(), which the maintainer is best placed to confirm.

Please turn this into a real patch that you have tested to verify it
resolves the issue so you get full credit for the fix.

thanks,

greg k-h
