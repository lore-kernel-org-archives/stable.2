Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807587;
	b=zG7+xApDeLV2XrY1OKqNvsVIQtAk7nVlWtdorrULDsXGQ1b8HbcOZph7FAJ8SzQ5VVuZ
	 Mxvr7jJBPhb8Xrsl+nFwHZa7oqZef0zD1j1MTcxa/uuFk8TN/ovwHaNCGbuVKf9IN8APb
	 iu6mmqxnQd6fYgyVloVOsIOHpPdpPfpksIVZagu0beWmhntshQ9XNgWHAD8HwcQjwzLXi
	 rJDw6zXdrvxxMavF949pSlSY96J1nf+nZGSe6W7kmad3IOJiqmtmbZWwI0UQWO2IC5vIR
	 d6MGnYQxBDrOHCbrCDs0Ab5Zgj4+uVoBDPKI8cYHkSg8yZTIb03ketV81EodKVnP3Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FStOBzoT+fPx22zxEE6lOvFUI3PzKHiME65DxeWev/Y=;
	b=xWrdZGPMyvNziH3JAuqTui9yG99Wh9yIr1kJN1Gd4loKwlzES6ZT9Sa+byDjfG6zo5WQ
	 bZ9sqxz7fjPGyq41B9vmyehfsdabf3EmAcSOOAyQny4Kc8PXmbZ3DiFyUkMgpEGjhEaNI
	 gzpSIhJh4upne9VDzqIU8ZDD1UwZxJOe4gcWeWhTA2cV17DDmLSqtdn0R9oSNunrSrq7m
	 uc+tZg0Fq5vlBLZEMz7N84TcjM0AGq4ONP2o8izWy19nK55e0oo/gtszCYxOZwBPTfvqt
	 O3bXZzYlFzcCEtD8Dedg2BhxJE+w2owQzEO/HBlzF8WUEFv3O9iPae3CCJjZLtzflqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2V0hpRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5F606A32D;
	Wed,  4 Nov 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2V0hpRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255A1F00A02;
	Wed,  4 Nov 2026 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807586;
	bh=FStOBzoT+fPx22zxEE6lOvFUI3PzKHiME65DxeWev/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K2V0hpRrmm7i6ABIxWoPqb0KDMhWoNNejnX1hcJ05fxTueW8buN+YI91B8DCi2bpE
	 nCeNmXWCXsQRWK/yAjWc66xc9Pdn61deqD56TFmSL8vnb3GIbFS0RFb0xkdxhEpfgn
	 8r94T/eKtMsOKRad1lRfZCxz0eZJFrHFsBEAr7/cfc/hUwWH3uuBsRA38Pt/Deljkg
	 ySDcTDQhk9PPGs/wHL2HpClGtNepPhPGlQmBjKevFwhMk6mDDpssRz2rZWt9uUQG6E
	 m1SucgRRfzqdrMFPrBxjgsy5VMMB8+/j3QSiVGILa6JhTJ91WABl3vgDIuEDorRNlA
	 JtfJVFzCKGkVQ==
Date: Wed, 4 Nov 2026 08:53:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <autU4LYsgtOy-Ywj@kbusch-mbp>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
 <aunTlxXbRJ6ZP63h@kernel.org>
 <20261104090440.GA30968@lst.de>
 <autEfTlEWj_OrtB5@kernel.org>
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
In-Reply-To: <autEfTlEWj_OrtB5@kernel.org>

On Wed, Nov 04, 2026 at 04:43:09PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 04, 2026 at 10:04:40AM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> > > And essentially what I would want is key_type_dead not to exist.
> > > 
> > > This version is based on module pinning, and  thus not having that
> > > key_put() would keep key type module alive in that case. However, it
> > > turned out this approach will not fly as AF_RXRPC and DNS resolver will
> > > hit the wall given e.g., the remote pinnings.
> > > 
> > > The approach I'm going for next is to have a type registry instead,
> > > which is independent of the module system (to put story really short).
> > > I think I'm doing this with right process as this really needs a few
> > > trials in order to find patterns that stick.
> > 
> > So what's the plan here.  Should we merge this standalone as a fix,
> > or are you trying to get an entire series in?
> > 
> > If it's useful as a standalone fix, please resend it standalone.
> 
> I'll send this as a standalone patch.

I can just apply it as-is unless you plan to make any change from what
was submitted. Just future reference that the intention wasn't clear
when a series' recipients are split up this way.
