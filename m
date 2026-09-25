Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD0484232
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346492; cv=none; b=ICm2kEGc3+S53r7Q3bwaQS7sKK1lLRuLwCKWHg6iyUkuLdtrGFFiMu/jyhzgL+5YfILUE1YvyO69Wm/PPelJeYQFDCnbyGD2sTNEtIZNX8iayoHeoWCCN2mRn18QcyxZaOJ/XPLMLbg/Y4sGRHs/kdWeiSNsm55m+zoBokAZreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346492; c=relaxed/simple;
	bh=TGNkIuF5gTjAzHPFpiLKVY6ti8pVfUSGwQEaWPQUFeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to8tyc6H2zeSFHQJQieEHJpKM42yX8YM7EZfNOC7bIX9Adj3e7HFvLKXsq5SJi6jBNdm6UJ+jQWOe11ZyVv4sZZlGOH/FaFYL3Dz7OcWlWJJ8hGLOwOzf7ayhkZr09TLJ/btpNAOfS+WqJJVQ9pOVHo1homMycuWmvS8w4gp/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NPa66Yeu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPa66Yeu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BC9054E41073
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:28:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A1B76073B;
	Fri, 25 Sep 2026 14:28:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD405102F08C8;
	Fri, 25 Sep 2026 16:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VNOU4v5DR83cVG7ebuGPW0h6VIJLtkDDzGa9SRSivsg=;
	b=NPa66Yeuw7Qs+Bqo5iJFL4ynuRN1GSs27G7mV56NQnN4LXxhsbWW1jvT5P6xzvLbae9UbD
	XrAPea0fZ6D243EuXgnZRxgCLpdnl8zA6Cvl3FZfMgQu1HvFOJKn8Lbk7xa4H/SqstUGMZ
	0et9HlMgCN8dlIxjBdpGcCAmg02TlRSFhDwuI1VaB0rYRr5vgE0YLfybv6g4v1Ctqz/Uch
	osco2A5uhZbM/c582toSzJsm1PWx2+ZtnEbOBWx6urCtl8MWX5bHMeTz8SayvsnOC5b7Hm
	yv0Im5mTfP93P5ysD060JtJhl1VFbPhXM86udNC7lTSVUYR2nZZI+zj0r+VO7Q==
From: Benjamin Robin <benjamin.robin@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject:
 Re: [PATCH 6.18.y 1/2] rculist: add list_splice_rcu() for private lists
Date: Fri, 25 Sep 2026 16:28:06 +0200
Message-ID: <JyCWa7ltR_KwJYUaBPJh-g@bootlin.com>
In-Reply-To: <2026092540-jokester-certify-1339@gregkh>
References:
 <20260925-cve-2026-52988-6-18-v1-0-680b24895415@bootlin.com>
 <20260925-cve-2026-52988-6-18-v1-1-680b24895415@bootlin.com>
 <2026092540-jokester-certify-1339@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Friday, September 25, 2026 at 4:23=E2=80=AFPM, Greg KH wrote:
> On Fri, Sep 25, 2026 at 09:52:23AM +0200, Benjamin Robin (Schneider Elect=
ric) wrote:
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> >=20
> > [ Upstream commit f902877b635551513729bdf9a8d1422c4aab7741 ]
> >=20
> > This patch adds a helper function, list_splice_rcu(), to safely splice
> > a private (non-RCU-protected) list into an RCU-protected list.
> >=20
> > The function ensures that only the pointer visible to RCU readers
> > (prev->next) is updated using rcu_assign_pointer(), while the rest of
> > the list manipulations are performed with regular assignments, as the
> > source list is private and not visible to concurrent RCU readers.
> >=20
> > This is useful for moving elements from a private list into a global
> > RCU-protected list, ensuring safe publication for RCU readers.
> > Subsystems with some sort of batching mechanism from userspace can
> > benefit from this new function.
> >=20
> > The function __list_splice_rcu() has been added for clarity and to
> > follow the same pattern as in the existing list_splice*() interfaces,
> > where there is a check to ensure that the list to splice is not
> > empty. Note that __list_splice_rcu() has no documentation for this
> > reason.
> >=20
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  include/linux/rculist.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>=20
> You did not sign off on this commit :(

Hello Greg,

Sorry about that, I was not sure about the rule if I did not modify
the commit in any way.
I will send a v2 for all branches ASAP (but I may only send the v2
on Monday).

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



