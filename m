Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968106;
	b=z7n6DcJVyRfgA7NxEDrDl3JWICGYtu+oHAhPda3hamVRu69wMVYklwbnwW+6eqSzMiW/
	 9IqsBAm+H1u48n0oh4dr5eonIOR96XkJUehGfV//7wfheMywZSqRUNFAfHwEuYuzUyf+1
	 UMyvUMc8Nk9REb/VyKFyJ4XPZmp2KQHi4QNUMwRhKIJwCJxr43dmXYXBYU42yvqMGzkxk
	 BK15KWz9z0wbJeoCy1DwFsG0J0+hpEtSc1RPvNdmhZvrFESoMWobr8sdTBsYS1Y78Ms4n
	 WEqdyx3zdYgyBACC6aarmLyvfdLKpd1WHWJXwfAgSA6shDODnamv6lKnLHIDcdjcV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968106;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=X8rCItQ0R9VrDB25XBgU9TXGSTp5Ii9q08TmcSboO+c=;
	b=x1dIgPvOMYavkYFkxZSEbbQ1wZi8DJw7BZVzaDqApxlpbeBx+m6q7qhwG2obI/Cky1jY
	 7av2ssaFYNlB7QNytXmYNgEmvP2AkKtK+mK0wniAV32I3gejPVSgf7c5MzbmhBsgkmu8I
	 RzfSoTTnV6/fCdWmlVOBS0MxS0ejm9IKDcDOHx7PSkRe0o9+ORqP7L0O//J3yLRe9LWug
	 gwa1sNV0cZeY3NYgTZCrGcGCdeWeFmVRp76B+ChHHvjjmUEn7rzyRmCjpGTGmud5p0b3j
	 MceEUo/d9vi9bNafLqW/B8apyNifOYYSbYjvgbIVJMPyit9lA7emckVUTc/m0lwP6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QEj2cYNZ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D4606A32E;
	Fri,  6 Nov 2026 12:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981D4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QEj2cYNZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	From:Reply-To; bh=X8rCItQ0R9VrDB25XBgU9TXGSTp5Ii9q08TmcSboO+c=; t=1793968104;
	x=2109328104; b=QEj2cYNZlv6Q/RXFjhRE9GMCv/B/PJgLia2Js2jmw/YPExOSHZKMKJqHflFtk
	acAO3j/1q/TJIognTr5O83G/DXLjglDEppq+459LkSbiKvo75lXu3ixq9zevfXUoUPn0U6d2pytwB
	8k58DnKj2Ds3kkHg6Yz1Zdudg391QTZev5wc/zQbaEWivAcvv9fxatlNLMifB8Pvs51jbGPCfG8eW
	yU+6OQDdQjAADkm35Hwlyg9/APdTx4ei217xC5agXsBS9yaHcCpyPDMF4vG+RmvJwCgUrLeFYiT0s
	BvvIqP2aXPF0DkwKlQOwmPG3BiAt91ZiFAEh4xExRdvpnihD1A==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xPJ3L-004OjF-6D; Fri, 06 Nov 2026 13:28:19 +0100
Date: Fri, 6 Nov 2026 12:29:55 +0000
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: fix 'inval_wq' parameter setting during module
 initialisation
Message-ID: <au3IQ_tZrpCZ__Pl@igalia.com>
References: <20261019125329.17932-1-luis@igalia.com>
 <CAJfpegsXsZS7CaA-=kAB4_oiyPWeZ8ULpG+kxBNHczM-XHbqng@mail.gmail.com>
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
In-Reply-To: <CAJfpegsXsZS7CaA-=kAB4_oiyPWeZ8ULpG+kxBNHczM-XHbqng@mail.gmail.com>

On Fri, Nov 06, 2026 at 12:33:50PM +0100, Miklos Szeredi wrote:
> On Mon, 19 Oct 2026 at 14:52, Luis Henriques <luis@igalia.com> wrote:
> 
> > @@ -62,11 +61,14 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
> >
> >         *((unsigned int *)kp->arg) = num;
> >
> > -       if (num && !old)
> > -               schedule_delayed_work(&dentry_tree_work,
> > -                                     secs_to_jiffies(num));
> > -       else if (!num && old)
> > -               cancel_delayed_work_sync(&dentry_tree_work);
> > +       /* Only start/stop workqueue if we're past module initialisation */
> > +       if (!module_is_coming(kp->mod)) {
> 
> See sashiko review:

*sigh*
I keep forgetting to check sashiko website.  Sorry about that :-/

> - kp->mod might be NULL which will Oops module_is_coming()

Hmm... I guess this should be fixable by adding a '!kp->mod' to the
condition:

	if (!kp->mod || !module_is_coming(kp->mod)) ...

> - it's still racy against fuse_dentry_tree_init

This one is a bit trickier indeed.  I could try to play a bit with the
modules notifiers (register_module_notifier).  But I haven't used that
before, so not sure it can be used, for example, kicking off the worker
later when the module has been initialised.

> 
> My question is: does the inval_wq_set() even need to work before the
> module is initialized?  Can't it just return an error and it wouldn't
> need to deal with the race.

That's probably the simplest option, but that would prevent us from, for
example, setting inval_wq as a kernel parameter, right?  Or doing:

  # modprobe fuse inval_wq=10

Do you think that's acceptable?

Cheers,
--
Luis
