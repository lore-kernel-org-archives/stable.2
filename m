Received: from smtp-5.sys.kth.se (smtp-5.sys.kth.se [130.237.48.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86CEEC0;
	Sun,  4 Oct 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.237.48.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134951; cv=none; b=PUie9WC1VDVLj0+5iDOpmbdCkM1NtqusL7afOwg5d3eGIq3pxsMsH/SSHVfqjhKuyQEsCSJBlUjmTeQILoJ+mJRbf2VCIxvdG+//IXzSY/BupKbS0F9yBky11bAq60UNS1kQIkRYhM8ITZEwrhPJZgGDhCFLBcVLirDYMtAqCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134951; c=relaxed/simple;
	bh=hK6E+45sBVzz2jJ6CO/SqVH0q1OgFKjrSc+BGRSntvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJNjFN0amcbjWUyjKVvxK0XDeGPyIYt+uwaY6MMjWHgKCZEzj6cQzECR8MnclWBGIWrdu0xPZ7c/ePC6GFfOOQTbLzSx4YW5Tv1Q2SRs00kvSLMvnu9uUQq1urBT0NQsIlyR7Fuf+swNu+xqPy0jNIBx3mh0cYMFBSJs0iSu49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se; spf=pass smtp.mailfrom=kth.se; dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b=ISade73v; arc=none smtp.client-ip=130.237.48.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kth.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="ISade73v"
Received: from nargothrond (c213-100-197-198.bredband.tele2.se [213.100.197.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sfle)
	by smtp-5.sys.kth.se (Postfix) with ESMTPSA id 4hyTyl0LbLzPNQ1;
	Sun,  4 Oct 2026 19:29:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-5.sys.kth.se 4hyTyl0LbLzPNQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
	t=1791134943; bh=3iQQZKWZE7b00XERG4KjbFNTvF+cDXLsDgw08nTzOkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ISade73vf0r/BSwyJFK6lKKpg0RPz7tlINdoesJV9jOPgBqT2Jq/7twYUh1n7HtEZ
	 tQJny+L5CaT0DVmtwgX4KQ9XQ7ArDqxexlcBNo3eLsD3df5AQ4moXgTfaq1b4LLSV/
	 v/WEiWStL4bZtmO27PI72zqoaCM6M6VsdUTTTJJE=
Date: Sun, 4 Oct 2026 19:29:02 +0200
From: Stefan Fleischmann <sfle@kth.se>
To: Eric Dumazet <edumazet@kernel.org>
Cc: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 <regressions@lists.linux.dev>, Joe Damato <joe@dama.to>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
Message-ID: <20261004192902.3ab3b7f3@nargothrond>
In-Reply-To: <20261004163532.3134dd41@nargothrond>
References: <20261004122616.56714cbd@nargothrond>
	<f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
	<20261004163532.3134dd41@nargothrond>
Organization: KTH
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Oct 2026 16:35:32 +0200
Stefan Fleischmann <sfle@kth.se> wrote:

> On Sun, 4 Oct 2026 13:46:08 +0200
> Eric Dumazet <edumazet@kernel.org> wrote:
> 
> 
> > 
> > Notice that 0xfc499000 is on an exact 4KB page boundary. This points
> > to a DMA read overrun where the Broadcom DMA engine reads past the
> > end of a buffer mapped in page 0xfc498xxx into the adjacent unmapped
> > page 0xfc499000.
> > 
> > Have you tried a recent net kernel ?  
> 
> Hi Eric,
> 
> that might be a bit tricky. We use ZFS on this server and the version
> we have installed only supports up to kernel 7.2.

Scratch that, I noticed that this even happens with none of the LXC
containers running. So I tested with the main branch from
 https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 (commit 6dc989ea46b9)

Same issue.

Best,
Stefan

> > Could you please test whether disabling TSO or hardware VLAN
> > offload prevents the crash? (maybe adding one option at a time)
> > 
> >    # ethtool -K eno1np0 tso off
> > 
> >    # ethtool -K eno1np0 tx-vlan-offload off  
> 
> I tested this now and none of these options made a difference. I've
> also tested disabling other offloads, no difference.
> 
> Best,
> Stefan
> 
> > Adding Joe to this thread, because some parts in
> > tso_dma_map_init() or tso_start() might have bugs.
> > 
> > # Disable USO on the physical interface
> > ethtool -K eno1np0 tx-udp-segmentation off
> > 
> > This reminds me on a prior attempt I made months ago to sanitize
> > tso_start()
> > 
> > Note that my email address has changed to edumazet@kernel.org
> > 
> > Thanks.
> >   

