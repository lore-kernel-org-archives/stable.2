Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454951;
	b=wl4U6T3eUhcLc3sY6DD+RLyox0Lo+rRyu9Rf86B8xETwucbPESbBtwSstPTXGkaXxnO/
	 Y5Bb9xtcKdLQaYHcdxM+BygU1GHed3YjEQXX56Ah3ieZb7JQGDpQ2Jj1mzsDcRxgAfUhh
	 x3mUeR+mL5TcFUbnxeMvnrWOVwJjYVCgFejBeiQbWbq6hlmE85e7Z5KrNBMYNQfmuGOo1
	 jrHLHglCJexBem2Aw++zYsBzYzpXhoad9TRIXuEBJ7hXI/AgAYi831+sZrzU/fvG30Ktb
	 RsKP77VehF6r/T7d7rQR4wUz1y+JBqrttBo8hGvBai/r4C+m6WhTGhuNgB1x80urEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454951;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wluFuluYu5l7dmTRpGiVMzM9AyFdm4/EFExSNM/YpjY=;
	b=gLIqbH1m9zLvGHcskxeu+AKEz3zuz7pqUezQ6PB6Zez5CdRpxdx1UPTyPY7Kg8Tz6/nf
	 GMBmjdMQ7thLXe4E4ao0xg8qJa9TUbxPv2TcAu1nmukNDJO8BfcWkrMbeSeCDd5fcHP2Y
	 Tu+fvS11ZDddCNsLhCL+cXZJzWrFxDFY3A2jZw5X10cPDTdhbyXTxNYn2DJv1d1r0MeAu
	 00Ur/GsGOMhvvh1gm8TxeyAPdrQtNj/nX6B1a1VWMxV+UDL1qzxTbXLplyM5Se539Pui3
	 w3j0n4JHHJ7ifMgwlYef6+E+6VhxebT5d2XxR0vHEmMsmxv0DKkkRwjv6yXDVSVq+wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QdfTH/0n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1814606A31A;
	Tue, 20 Oct 2026 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdfTH/0n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C281F000C4;
	Tue, 20 Oct 2026 00:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792454950;
	bh=wluFuluYu5l7dmTRpGiVMzM9AyFdm4/EFExSNM/YpjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QdfTH/0nFxSnE9RT8uEeGmRBvELZLQJLsMbD+EVLoem6DVlogQcFsidu+L6CHPq7L
	 IY+C+jQ5dSgcsI2k1CzASg3WzGdVZWRseqzsOuZL8F8XJFiSJNSuqZjon7a6fgvwqp
	 L+A4ob4w8pYYvO5QzBFQyDlHDteOemVWe0s5XLHGoitT9RhZwxscoLWK/ZyZVboRb8
	 Pzs1Ps/Xr190d48e60BU+TBW5rbPm1dLSzOGr2BhPYplX9wzL9sHIZpmSXOIZ9RaD0
	 17PCcmRTE+aDyjo2gNMO8lt/scU/NzwgbgY5lWG0ZRCqUDL7xfIYe1W21DXo6VMVO0
	 pr/AF/vJrZHMw==
Date: Mon, 19 Oct 2026 17:09:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: cenzhang@linux.microsoft.com, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, mazziesaccount@gmail.com, greearb@candelatech.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
Message-ID: <20261019170909.7b065b7d@kernel.org>
In-Reply-To: <179167292799.434549.17886083109176424564@kernel.org>
References: <20261009225142.47005-1-cenzhang@linux.microsoft.com>
	<179167292799.434549.17886083109176424564@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 22:55:27 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +	read_lock(&net->ipv6.fib6_walker_lock);
> > +	FOR_WALKERS(net, w) {
> > +		if (w->state == FWS_C && w->leaf == rt) {
> > +			pr_debug("walker %p adjusted by unlink of %p\n", w, rt);
> > +			w->leaf = next;  
> 
> [Severity: Medium]
> Should w->skip_in_node be reset here too?

Sounds legit on the surface
-- 
pw-bot: cr
