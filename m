Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB2391835;
	Sat,  5 Sep 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636572; cv=none; b=FQPue0XB78JP15hAlwfeAMi51zhSlQlZdK0nnOKdm/qBsBWbwN18d1xW8ZHJ47kPBh8BV8Crm9WtVTMS0pM5jWJPo4dSfHqrjB9N5sSNJvyv1ZCW9PxmZ8kkRRhE8knKWpixYo0B/FzA4SL1iu5OGFitRjnXr7jFiFll8nL2OgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636572; c=relaxed/simple;
	bh=B1ppOpPbviRzyBRvzSXjY0WHZU3/VeGa9sEQ843QBNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3VClHZauspzMEgU3ngaCs/WwCRRwnhO4OrsiwSjD0G7kky5GVBex9nnYSJJ9Xq/D4ziu7MOjJPzsY/6EFD+viSAs9sSzB8GlxOFJjc4qSmjVnAuD0eqQs/Quu0iJwgtwavtIB5ewZQYeXyEG6W7foyCd6K8fyBk0gNRecmF2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGTfy18A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGTfy18A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B43E1F00A3A;
	Sat,  5 Sep 2026 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788636570;
	bh=kIarTBDrMQaXpsAeKpsxpWu81PITLhaO4Nrvi/ktLpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gGTfy18A878jp0Qd0kp76iheNgEcPIrBfYVMPTbEUHW5X/Gqol/in8NnkcmiQmhbh
	 37gVpizpqUtH6o+BxWHpZiolxMjDneZBRA0QRQtGfRyrVC3RFegLDQyWGwTH2CK3MA
	 G42PFyDRaIvCwI5adpVNjSnnfQ/UEpOqb1QqZqNWRImozeSsXEKUOCUqnCUGZhE0hs
	 nz3RDJZe+Wf7586dzT3OAUJCi497al7S17Y6pM2/S+Q3TE4WkQK0q5xXyq32dYsbLX
	 pr47mDz8i15KdA4n67EQVaO7pyIaI2YQJfaycl3ouwWU2GaGZTnEbZOki5zUEHQ6Aq
	 djXVc3phma0DA==
Date: Sat, 5 Sep 2026 12:29:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zihan xi <zihanx@nebusec.ai>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xemul@parallels.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 vega@nebusec.ai
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
Message-ID: <20260905122929.5bd1bd45@kernel.org>
In-Reply-To: <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
	<20260905151227.75099-1-horms@kernel.org>
	<CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 23:49:05 +0800 zihan xi wrote:
> > When an active netlink dump for UDP sockets finishes, inet_diag_dump_done()
> > invokes udp_diag_dump_done(). This function drops its module reference using
> > module_put(THIS_MODULE) as its final step.
> >
> > If this was the last reference, a concurrent rmmod udp_diag operation can
> > proceed and unmap the module's text segment before the thread executing
> > udp_diag_dump_done() executes its return instruction to return to inet_diag.
> >
> > Could this result in a kernel panic due to the CPU attempting to execute
> > unmapped memory?  
> 
> Yes.  If that module_put() drops the last reference, rmmod can unmap
> udp_diag while dump_done() is still returning to inet_diag.
> 
> I will keep the extra module_get() in udp_diag_dump(), and move the
> matching module_put() into inet_diag_dump_done() so it runs after the
> callback has returned.
> 
> v2 incoming.

FTR your patch also looks atrociously ugly.
If you send v2 please make it better.
