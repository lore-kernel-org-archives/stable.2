Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427666;
	b=IVcUIdj9EIExog+mrS/1ihFljT/qLTB4LNflai2VCkMfawk+jqNBEVRMo0wJldC/Gvyj
	 Yp0Ucc9jzs9wBabXZP6femgn31Ydcp5KH1qKo8ZndfMCWGu6jXhzojxAEWlCMxGoMu47P
	 ka/rxRAZn1INXz7LZMG6MqluzONA1hEyTpLNfPZqB5akqgiX3bIbzSN56t870FFevVKcI
	 Ho4eTzmaq1cmpRMcXfVcQU8oNoJJ+r9telWjXXIXwx8EdOsRUJMpS/qU68q79VLxE5Eti
	 eihJGVDBhUuUSo+t9X/8vX5n0PAybqJdpR9Xm8bOrK1TRTETDzQRcolYffzLUxmcySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427666;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R+2F6AJyqmMhZLLiE1+5yjRPhKmjITuzkCioBcCEkj4=;
	b=N/qHG9UfPvINCYpmUzO+Np0HTLgTW3ouy3cVyq70w4yG0vbnYtvFOss1G4IiRu95h5mk
	 zaxY9vu30JAI3THZq9ZfzrAwn77Uej1dYmFamWc6ZyKQhnCQY9wnHUqh+h2XV/LRisO2d
	 /cHJx5su2SetQiLc6xEO374q87YLCW7uODBLqxUOIcFIuwF0GbFF7nswaEFQRRRm4V2yu
	 bvf3QP7IA3nMzJHUtxkl1ZJWSfdGsBuG/k5/JPJR6RF4E1LlDqOx6Nvd+8XCCp89ZJCra
	 qPzTUhwfsBIw2g8SxBivQNrfMJiXfWJRDA+OFU4uuRNJPJ/cyv3eVn8lgXmy3pCYAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaP7vIjz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B1BA5606A31B;
	Mon, 19 Oct 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaP7vIjz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C2FDD1F000C4;
	Mon, 19 Oct 2026 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427665;
	bh=R+2F6AJyqmMhZLLiE1+5yjRPhKmjITuzkCioBcCEkj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaP7vIjzQrjDdSoVL4EhGhsVnweMBxBgslyfIrozPvi/ha3RucSLWqOaYD+IChK3G
	 eG25KDO0sRkBxN9a0yJTXxNebxxJjFDzb5oI19eg2XayL/5pTGZ/2FHzPncyKt7xwU
	 aYJQXIyO6ghaQ8Q9as2B/u0nN+bqi4BsTY6ycKN/UFLkgDUdqmpfahnarRbsrYgvA2
	 ryk6qL5zC70Kkqco6lrHzGCBcSS6y4AHZ5fk5Zie0ai39fjbnAtygm4RjwRClw+7sN
	 lphfi4TaXA4ImmlVGADdQywyzmYzeWSnEqXphMnc8xPO8e1GEkmd03EKm1U5LsM0A+
	 kbkC7yGNbpNUw==
Date: Mon, 19 Oct 2026 19:34:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 6/8] KEYS: Prevent overflow of user->qnbytes in
 key_alloc()
Message-ID: <atZGjQxDP7-kcfvH@kernel.org>
References: <20261019142516.300040-7-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2610123.1792424505@warthog.procyon.org.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2610123.1792424505@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:41:45PM +0100, David Howells wrote:
> I suggest merging patches 4 and 6, then add:
> 
> 	Reviewed-by: David Howells <dhowells@redhat.com>

Ok, I'll merge 1-2 and 4-6 both and apply, thanks.

Br, Jarkko
