Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F83128B8;
	Mon, 13 Jul 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940159; cv=none; b=hpmOrU+Uzmjc/GDsf2o6Zqyvx27eUQVsOGIkiD59nsi2LcB6zQaydtU5uIbKLty9RYZfN2Sjm41HVUZqFlpM0/P9QvpR87QM7qxj7GMcGhbODITwdieAwGpFWCer0O4G6O8G7ixR6n6wjL5I0OE4fIJUt21tdqt3YCXTLn+mFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940159; c=relaxed/simple;
	bh=BaHYdXOO0CdP2bMTfvbANetF8WpyS/RLkfcH4FfX8Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRteN1LR4PIDwG6sUGk3cwSnCsdfwrrYXHjhX+6z/9Kt/bGOhTBlY77nOdmP4OcGbTNW7cidgNxPU6lLsfCG4zlA3nU2BecRFoacXU4hBYGRZ5OM7lSK8OoEzSuT78Oocz47GacxapCEn+IC6xKrrvggW99UCJldl0rMXN4K7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKPZA241; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKPZA241"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0323A1F000E9;
	Mon, 13 Jul 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783940158;
	bh=ZY6HQ9yXlDTzPMvl0WhDw0jvQa8E1asla5P4P2yuLto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GKPZA241s6VJLUpYc8/dmAgdE1lGLQMwhkRDKp+YL8lEhWCWeMOqcBGPZGaknWWPx
	 JFVfec08kWNpFJyEQYUO0KA2CRhk21OfrwGDb39KRIChDpU0kxQtUFJDJJCD50XQlU
	 hmcRaKS0AdKcq7/plnZYM1ATzjS+RlL5El47V9iMWTCV3f7vg7eohLnvvMkBuBxdvN
	 wZFEG1wI1vzBTZE041VBbrBRhLkq2ZVgIsbpkxZ5l245zm70iMAGUkg1HLGNiwUa02
	 Qctc26F3EkA3Hv+3G5TPdMJJUTzEZgQasha/2zMdV+oA2pt73yDoSTHjUGIKQOx3ia
	 4aU0xrlIP8Etw==
Date: Mon, 13 Jul 2026 11:55:55 +0100
From: Lee Jones <lee@kernel.org>
To: Pauli Virtanen <pav@iki.fi>, stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SCO: hold sk properly in sco_conn_ready
Message-ID: <20260713105555.GA3649328@google.com>
References: <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>

Stable Team,

On Sat, 18 Apr 2026, Pauli Virtanen wrote:

> sk deref in sco_conn_ready must be done either under conn->lock, or
> holding a refcount, to avoid concurrent close. conn->sk and parent sk is
> currently accessed without either, and without checking parent->sk_state:
> 
>     [Task 1]            [Task 2]
>                         sco_sock_release
>     sco_conn_ready
>       sk = conn->sk
>                           lock_sock(sk)
>                             conn->sk = NULL
>       lock_sock(sk)
>                           release_sock(sk)
>                           sco_sock_kill(sk)
>        UAF on sk deref
> 
> and similarly for access to sco_get_sock_listen() return value.
> 
> Fix possible UAF by holding sk refcount in sco_conn_ready() and making
> sco_get_sock_listen() increase refcount. Also recheck after lock_sock
> that the socket is still valid.  Adjust conn->sk locking so it's
> protected also by lock_sock() of the associated socket if any.
> 
> Fixes: 27c24fda62b60 ("Bluetooth: switch to lock_sock in SCO")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     There's still several known race conditions in sco.c, if you look at the
>     sco_conn_put/free and hcon->sco_data access. A redesign could make these
>     locking issues simpler:
>     
>     https://lore.kernel.org/all/5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi/
> 
>  net/bluetooth/sco.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)

Could we have this and its dependency in all Stable branches bar
linux-5.10.y please?

Dep:
  b819db93d73f ("Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready")

Fix:
  4e37f6452d58 ("Bluetooth: SCO: hold sk properly in sco_conn_ready")

Both patches apply cleanly and survive basic build testing on ARM,
ARM66, X86, PPC and MIPS.

-- 
Lee Jones
