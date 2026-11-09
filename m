Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244558;
	b=a/DiXqHn9mlCwcGm7/Hs6VAJGatYmIyJ9Gw23LFaaqjtukrzOWB2diIJZRhsEuu8fTgG
	 BUJB6nEsHZweTDZJ0bQ9e3TbSQqCfQtahL7qce5iqagh4LQ5melX74XbpIzdGlImSCc2x
	 L5yu8bhb1OKZBWBuGshc3AYEQqq1AvFcZFo2EZGhSP/n/x0pG6kKz89SuuZULyHrWnmVW
	 +8aTD5LuVpD895y0PH46Vo53wqcyf8YtkQNnGDpRJsq8mmHkphYllWdZUNeAt4Giulc0q
	 7NQC7z4EsGxhzUqr2aUJDcedfGP7MCYo8H2dxjOQTBQGcFklDk2QImLhGyMPB24A0Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244558;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dr92Xm9+28OUIofnhdhc5CnNStgxVsfRHB1xg54LXOg=;
	b=0vyjseM9QLgdPfXYIZr/iop08i/gT4G7vTiQuQncY26ei52iI94M+jqFbu0+BPdCBtSq
	 l6saVDV2ltQQ9kJb4M7N3SBCuVDHNlcq/7eIhO7WszVfpPJunt4Zjym2/rc4y26VA8y1y
	 hheVFX0b9vjPD6493M+Q94eEas9gTcs7L3tRohkiOmofLkvJUZHBzvwxt7962qLLglo/y
	 77hN3pWTdkFzSA4XPKe06ZgR+gwjKIsSstkMMqfkQjZF+bNQDYvY7QG7IUnlFo/ZPc3qn
	 /3j08JUwAzpyCFSZRP95OvXBq9ehsiG3yEpPvrabn/GJegFSIa2hjIiHe0g2pi0kPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI1wTtkg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196A606A33D;
	Mon,  9 Nov 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI1wTtkg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF71F0089F;
	Mon,  9 Nov 2026 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244558;
	bh=dr92Xm9+28OUIofnhdhc5CnNStgxVsfRHB1xg54LXOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DI1wTtkgzwZJNojKn+KwP24X98ubOP3GB/SyFSA7V6rWPXqp0EVBIKddvVL5oh4lp
	 7I0ILbQDNrfbHxF6SLvH9GLbvlhGBg2KqrC1Cn78+9nz/EZ8//Isa7zafDnk0M5Xd1
	 pIPMdidyBZVUdZoF8WvrECietRwJEkUyW/VqVzDGtqGYj0ERd+w47BguFe/GKMEiZf
	 3V+VdFMFp/EFhm4Gfv1YSTE9n1CVYn1J7rJe6EORmo4RHOzO1p84Ii6rErUquXvuNS
	 PU55htrBHnmHdPNkQ821Xyz4g9vR+en29MCbIWQMAtmnsVw4bXKCOmqEhs2LgDFfxm
	 3s+D2+HPUm2vw==
Date: Mon, 9 Nov 2026 17:15:54 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	victor@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
Message-ID: <20261109171554.GV18859@horms.kernel.org>
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
 <179406458348.994134.6942745655171316289@kernel.org>
 <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>

On Mon, Nov 09, 2026 at 06:44:09AM -0500, Jamal Hadi Salim wrote:
> On Sat, Nov 7, 2026 at 10:16 AM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [Medium] The new gate in neigh_update_process_arp_queue()
> >   (net/core/neighbour.c), `if (!n1->dev->header_ops) skb->dev =…
> > - [Low] The comment added in neigh_update_process_arp_queue()
> >   (net/core/neighbour.c), '/* headerless outputs (teql, shaper) transmit…
> >
> 
> I think i missed responding to this one. Sashiko-nipa responses are
> very erratic. For some threads (not mine) a review shows up 2-3 days
> later. For mine the average time seems to be 7 days and sometimes a vN
> review appears a few days later after a vN+1.
> 
> Summary: I will not be spinning anything for this series since there
> are no new code change requirements. I have addressed the
> neigh_update_process_arp_queue() issue as a separate (producer) issue
> in the past; it's a separate net-next focusing on producers. The
> comment (Low) i would have rectified if there was something meaningful
> to make me respin.

Reviewed-by: Simon Horman <horms@kernel.org>

