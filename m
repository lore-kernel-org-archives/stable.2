Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8F33EB01;
	Fri,  3 Jul 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074434; cv=none; b=Wy7cFW8Z6bsYnBgA0Xs7IcWu8dzEWKzND3TGJ1aD6M+HTNbUOD7Nj5Uo0w1eFuOKwlRZo8H+yW1yP4d0t1KkWHbhESmHzZ87rNX3pmhDVQnJaulBeGfx8EeU2uhC4vMJKQrcmsU2pK36QYZwu8vfGV8q1JqQ0J6OtbsR1INq+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074434; c=relaxed/simple;
	bh=HmboNyAIe4dTx2IifK75XbPPrpWSwd9JfBv8N3wWANo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw6uYyaOpBxBuHkxYvKXG7Pfj/hCGbSwPadscPvJrjbyx1qGUGf72dyXeMNNvhbl7m36V+FkAS2o//jsmbvxMDmqwSBYrfFff8w2ag3GeHu5h8pJAIDwAlr42N9E2oCHGBHZ1O8ErxAYg2Y/N1UKje5y7biuWYXKpCVxvEFjOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qJWfT/Mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qJWfT/Mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879D81F000E9;
	Fri,  3 Jul 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783074433;
	bh=fEOBAPlxutWwDuikOta7Exa0G6S47i4nFlvKOz5QMi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qJWfT/MtOeFDqZa0KO2Ha6r6Vx3pzmQqCQRJqAuscheVCs3sivq+zN7YGf44Z67dg
	 IZRnD4pBWn/AtzXhIcie4lhRMphqGF3vFTcCXMOzb1IubeI297riF0Kk0LC/EEwLFX
	 reKjcvrzaJDOAj9izmEaXYJUpb6D0eH/cxA9FeGA=
Date: Fri, 3 Jul 2026 12:27:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rust_binder: clear freeze listener on node removal
Message-ID: <2026070344-alike-ducktail-5fe0@gregkh>
References: <20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com>

On Mon, Jun 15, 2026 at 01:13:16PM +0000, Alice Ryhl wrote:
> Generally userspace is supposed to explicitly clear freeze listeners
> before they drop the refcount on the node ref to zero, but there's
> nothing forcing that. Currently, in this scenario the freeze listener
> remains in the freeze_listeners rbtree and in the remote node's freeze
> listener list, even though the ref for which the listener is registered
> is gone. This could potentially lead to a memory leak due to a refcount
> cycle. Thus, remove the freeze listener in this scenario.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This series is based on top of:
> https://lore.kernel.org/all/20260615-binder-noderefs-spin-v3-0-3235f5a3e0a0@google.com/

Hm, but that's not a bugfix series, so I can't take this patch now for
7.2-final.  Do you want to redo this one or wait for 7.3-rc1?

thanks,

greg k-h
