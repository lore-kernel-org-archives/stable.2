Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733724A2602;
	Thu,  1 Oct 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856004; cv=none; b=O/AKKdQjPBCh3ZqXC95MRoVT5uMhNSF6LclPRpCun+mRQeI1j4hLuNeNnp04bB3DUvmizLEcyWGcEGtA9zxmMMMJ0Hvl/039AJ7sZj5IwsW7plTbExq8LtDwaINL0QwU56nzMnzwDbBIpXC417cPGQurRvzWTGL2ERpehPj5G+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856004; c=relaxed/simple;
	bh=PhCMndaeeUGpBoTaM74tSkvMa+g/T0+mNIsBjet04GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyjbME43dzL8C7NBn57ViEeae7cx68R66pNLi4mOM533FqJ3HM7P20cW+aYNbrnKgowH50fkg98MAw20RR7/F6/0rLxU6q/WprxwBSOVTx5x5U0D16rn6TI5UIeo5MxZiHoXWYttc4F6AMwNoegDYul4PFt7Pj0d2+nIg2Oft7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPMzV4fS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPMzV4fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45D1F000FF;
	Thu,  1 Oct 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855996;
	bh=Xz/sxg/WAisQAqfjavl0oQmFR/Ah1bwDIH/gcVTSxR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cPMzV4fS+XFFN2LskzCoMhNaO61NYU4Q46k1epHIyNtkQ2TCQUgsJ34Kglu1e9dAt
	 vTr/TY2pPH41Ro8lMd3uNTqxUiQmlATEPWTTNObaRX5pHzc62rBEjANxtjGxos5YGu
	 s2cx3HFgFUgaQTS2UO6yDVYBLg8q6qS8uZ9JHEkmKU6gtOorlC2bmWCNIG9h0xBI23
	 WJTVqVPPNFlIcjSrACF/ifnN/P8nrXWaRKe+9h0DeY+qnMEB9EbsuMUipY+9Ee9qsQ
	 +rj9ULe0oHg4DLJCzXhc90USPZ0+uPqxj3acwdxYelpRU6H7KNGj3hLduiIQvkTseJ
	 1EeTswoTQfdew==
Date: Thu, 1 Oct 2026 12:59:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ci3c472c63e196fe9e@syzkaller.appspotmail.com,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v3] nfc: llcp: prevent resource leak on repeated
 connect after DM
Message-ID: <20261001115952.GA13925@horms.kernel.org>
References: <20260925184857.357926-1-qwe.aldo@gmail.com>
 <20260928035749.2305913-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928035749.2305913-1-qwe.aldo@gmail.com>

On Mon, Sep 28, 2026 at 12:57:49AM -0300, Aldo Ariel Panzardo wrote:
> A rejected asynchronous connect leaves a local reference, SAP allocation,
> service name and device reference on a closed socket. Release them before
> retrying connect.
> 
> The device pointer alone does not prove ownership: bind() puts its
> temporary device reference while retaining the pointer. When device
> teardown closes a bound socket, the retry cleanup would put that device
> again. Clear the pointer when a bound or listening socket becomes closed,
> and after a connected socket's device reference is put. Do the same when
> DM closes a bound or listening socket. A DM rejected connect keeps its
> device reference until the retry cleanup, so retain that put there.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://ci.syzbot.org/findings/64002827-5231-4183-bfca-0d91bded8543/syz_repro
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v3: Clear non-owning or already released device pointers on close, while
>     preserving the device put for rejected asynchronous connects.

Hi Aldo,

It looks like an AI-generated review of v2 of this patchset was
posted not long after you posted v3. And that review does seem
to raise issues that warrant a response:

- Re: [PATCH net v2] nfc: llcp: prevent resource leak on repeated connect after DM
  https://lore.kernel.org/all/179058922656.3145.17540746696102333949@kernel.org/

Also, please do not post updated patches as responses to earlier revisions.
Rather, please start a new email thread for each new revision.

Thanks!
