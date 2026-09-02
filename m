Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414838E8AD;
	Wed,  2 Sep 2026 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329707; cv=none; b=L9S9nadaeWW5OeQchgwVFofBrFwT2Lotm/8wE6LX4lWxoTYU7cTSeHWbmsSE2gyCC5ubDhmWp740HD7i71JyaguqOi9sgEo/ixgPgPOpM+VaauNAKTdGZUqHX88hXaRUkfgs10ReSos/EJ1X+nyr32+SGenTlqj24q1wpnVbquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329707; c=relaxed/simple;
	bh=4n35J7lWSrQp0Lt5f5Qos2K2/NQjC7zZ8MAyNJ6k0Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGhUwU4rDJs2IZxVAeVGcw+eMA1FkzGCrk7xYDI8rsCRH2ZEf30m9VPYgzTRNVjFOHoVYhAOkUx1csFNQ988k3nfh/mPFMnw/84WzD0iWWoR0eY5fGO6B01OwGzKGbmfeBM2NQXRXf+ZQVwbFzs2AcKg0dD0TOBoq7F26rBYDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEjcz3oi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEjcz3oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C811F00A3D;
	Wed,  2 Sep 2026 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329705;
	bh=Pt3eNlICYrOQZriKcUpzaM2kRhceaN9oVbn62k5BQ8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VEjcz3oiXAgmX94kmowcWGN8ij5X3NQFqTdRvgnxF0qMM4hjSVzTy6nouv/cKKzFL
	 GP9dn3xEBUEIf4hooko/3acXi4nQN2RRyqP8jmURNhFbIOt3wBUcfEVUq1KfXX79RK
	 1abGiFTXIesuNU1d51QgvpgBAhPwxau0P+A7EFEzd2xK0q/9avTRbjmYpIfYKdWfNS
	 KKUyPnE9+2kAbeW+MFKzPrLrqigXafz/eBHIuhG4bJWrvKjBB5nO7VmWBzuSo0arHf
	 VW5v3repV6NzKFoxSPGQ9y4hkaBq3rQD2gDl/0sVVJPHj7WsRT9IyQDhv7R9sFn7XL
	 1kz+KRqjmfQjA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x1eFS-00000005JgI-3NWN;
	Wed, 02 Sep 2026 08:15:02 +0200
Date: Wed, 2 Sep 2026 08:15:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: elder@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] greybus: operation: fix out-of-bounds write in message
 allocation
Message-ID: <ape-5pTO1JuZQYoV@hovoldconsulting.com>
References: <20260902033017.40290-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902033017.40290-1-adrianox@gmail.com>

On Tue, Sep 01, 2026 at 11:30:16PM -0400, Adriano Cordova wrote:
> The incoming message size from the device header (header.size) is
> trusted without checking that it is at least the size of the message
> header itself, but a value smaller than sizeof(struct gb_operation_msg_hdr)
> underflows request_size in gb_operation_create_incoming(), wraps around
> in gb_operation_message_alloc(), and results in a tiny buffer that is
> then written past its end in gb_operation_message_init().
> 
> Reject undersized messages before parsing the message header.
> 
> Fixes: d37b1db13f8b ("greybus: refactor gb_connection_recv()")

This isn't the commit that introduced the issue (even if that commit
made things worse by removing a WARN_ON()).

> Reported-by: syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=2fd6aefc361af86911d5
> Cc: stable@vger.kernel.org

How did you find and fix this issue? Are you missing an Assisted-by tag
here?

> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Note that this is also being fixed here:

	https://lore.kernel.org/lkml/tencent_1CB189506DEFA4B38099D654FE6C2A2F2E07@qq.com/

Johan
