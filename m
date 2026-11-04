Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803419;
	b=DdaqeEq2z8Do+SxPWYO7B94VjPI1ayubK6L6GMhtXlVJGKHnGQ4+ap3Pfo9+Ocy/jPDt
	 /YLwpfPKKb8IwJgnhBezmbkAZ8o8Ux9i6luODFvF31nmp0WxbyedUzlkb87vVghcKAMzN
	 7C/Xvf1pDI5uFFSwBtO0SxtADTyniVCu67dd9dbvlhNkYDnRYcxAxmELDfGAllDGbgZZE
	 Mwz8wNlGHUBn769NnQnjTkz496ss1W+1I2W3xGp3Md+iGRbZ6hCgU2eGo0Q1jt9CgVTeK
	 5ewBBtd308lt2TEPaCHPOkiutZM0kIl03bRO5/35N4xX2fBcyziHbAKzBj0Lznn+fEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nUB3f0u/OAhwBngmBxLo2s/x0auuF9zUa4v/an2QD/Q=;
	b=cCzmvdER50Wj5rZ0d7WlNqCyjrIeVT7MXmIQywBZBInrt7n640ociivC1nD/NYczP67R
	 IJK1CXxU/JGXWqSjaeK36t7DOHvBnfj5rt6c+2amKvrZaymxKyq67rRXgtKJ3ZisO/BDj
	 nHITNTA975dIPcS45RqQP49uNj2LfhG++5orVAkVH/F38J7NQ3vPk9iLAkw2xlVJJOa/1
	 reYVwxCo72OgZn020R0pV5r4Lv8q1cFnx7GjqDMyHXklMyelr0hqbO9ivp40Nxqhsrkjl
	 2uh3fEo9cxbvjk13F9+jF0jpTljTYFk3A7Gvg2mSJYOW1AtfeW49VFgTT8+ygdw16NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBBqnkMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7DA62606A31B;
	Wed,  4 Nov 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBBqnkMJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 931151F000C1;
	Wed,  4 Nov 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803419;
	bh=nUB3f0u/OAhwBngmBxLo2s/x0auuF9zUa4v/an2QD/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lBBqnkMJGfU/RX/i1wy6Mgf11gEeRIwGdYrVz3E84VPrWCz5y9Ym6yDDe+YEA5XIZ
	 Fcrrt0e97l90jSNqEGEQUcVgPkJIwlko5sxtFu7wfxdKU4EzusiAfuPYuDEz/9NEru
	 ort8wMMMVvPaqrqGvw5+dKtzSD6VEZsG4QGhYTNqVbWYzE4FG0TG3jcym354tAa0gl
	 uszgK0DFwtJPsNudSqxKuH/IYYmuPYnxKWNoEcdffg7WeFSWhvfsS5q+IaVDodpXW4
	 +b/wGXuBqHdrAQsxY6zX222R5ce6bWmlqZOL4TRZeFTXoDU1zneSD4gmIFONXbJcEf
	 g4syZZlvnAlLA==
Date: Wed, 4 Nov 2026 16:43:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <autEl7wvRjt2hgVD@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>

On Wed, Nov 04, 2026 at 08:45:11AM +0100, Hannes Reinecke wrote:
> On 11/3/26 4:02 AM, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> > 
> > Cc: stable@vger.kernel.org # v6.12+
> > Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   drivers/nvme/common/keyring.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> > index 32d16c53133b..87cb51e1f5a7 100644
> > --- a/drivers/nvme/common/keyring.c
> > +++ b/drivers/nvme/common/keyring.c
> > @@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
> >   	}
> >   	if (nvme_tls_psk_revoked(key)) {
> >   		pr_err("key id %08x revoked\n", key_id);
> > +		key_put(key);
> >   		return ERR_PTR(-EKEYREVOKED);
> >   	}
> >   	return key;
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>

Thank you.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

Br, Jarkko
