Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835862;
	b=yWwJi4pBOqz2AAAtZSOLCOOPngDP4kVkTygVSAixGOu/bahwzywAh59Jdixfegl3eAqX
	 o2IAIqzMpmeiirwL9RLxjnL7ABUSEXoglA0CaOWaLrgGDdHuO5c2zR8lbZ9aupZqMuCyD
	 7HUVnZ+ajluXO6Mq6+JHLLPrfzuB1nFzBZ+t601eeyvqo6ICQmsexHrsX6WKdrGZK9mdZ
	 yGg/w5U1ixSie/Qb1fQU3H17MD6ke8MEjMoHoKLpzxoi/d6A4kzh1+/UOPKDE6aGYmGME
	 UteZavQBwYt6y2sfI6pJrbk1DmT2CmXZEZyBkMGLl2wMVNFUuCzEUP/qtYxqcEkrdLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F8pFZttgkMUuGwTbPVUzTKwXNXUEksLNie+O1XNgO4I=;
	b=GG2EIIL3wPHXQroHLyd7BwbzZxDN6YldzEuca+OXeXQ3jL4Fm6o9EZYrHvGbYgMbeY00
	 Qb6fGpMBSKlKnukJTkqw4UPFF0JGHepTanRvjdLgCSL2MQWMsPPbqLPrrZku5MCC1ZWZm
	 dBbm9jitZGjw1dL0znNsvg/OS98bDlof7SFzpZRb6qYpigdoMg7habTRyfkQ29o9bsxPx
	 qGDqPRd0R6C7hY+KyTGMQzWUAq2DvnXbcfNhJcm5idbZIdo4fsDexAk/bc3/Jh3FfKJTr
	 c3CzqCwDxG7IiqgY5B6TjX8sQQut/BsN0hTkf5MJiW2PBfhuCJfY0hA8ZOtocS1mygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxxbmmxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5BC9606A326;
	Wed,  4 Nov 2026 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxxbmmxp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F0CE11F000C1;
	Wed,  4 Nov 2026 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835861;
	bh=F8pFZttgkMUuGwTbPVUzTKwXNXUEksLNie+O1XNgO4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxxbmmxpjVIzMW01FPySsPhSedoUdkvXkNVYNw2LjEQSB4230rP/pH6QHcVVcaFnM
	 GGJlGkS9wYfmh3GkPEZU52ueQxF7T8qSarKL4Xv9XG+cEFNP665Q6RkrD4lOkVotMg
	 KCmCekah4H0UwZT9drIQrS/aVAreAL2B03D0TTuWaGevSLnKIj8TRfg3gbBHQkuqx3
	 I4gRrozFzbeM3vOcCFpJTo6qBKHjrwml3gEplWLTScBqbKJoCDwg47toI8smquqVpQ
	 o6HcdEr/L6XScw7ZbIx/pAs50q+fchbS0dpS1gcZ06VJZKioEipIiYB9hd6EpmwETo
	 cf9JFiQL2xXtw==
Date: Thu, 5 Nov 2026 01:44:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: (subset) [RFC PATCH v2 02/11] nvme-keyring: Add a missing
 key_put() call to nvme_tls_key_lookup()
Message-ID: <auvDUbg2pr42d4-y@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <179382463580.3441171.16018709754015712565.b4-ty@kernel.org>
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
In-Reply-To: <179382463580.3441171.16018709754015712565.b4-ty@kernel.org>

On Wed, Nov 04, 2026 at 12:37:15PM -0800, Keith Busch wrote:
> 
> On Tue, 3 Nov 2026 05:02:07 +0200, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> > 
> > 
> 
> Applied, thanks!

Thank you and apologies for all this noise.

I'll send standalone patch next time if/when this happens.

> 
> [02/11] nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
>         commit: 404a8f6caa63822c1d2a45adbf07fd9c0567a7ef
> 
> Best regards,
> -- 
> Keith Busch <kbusch@kernel.org>
> 


Br, Jarkko
