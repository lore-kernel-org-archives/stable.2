Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BE393DF0;
	Fri,  3 Jul 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077356; cv=none; b=ncX67g/Jr5wdhxWvTM4s7nW0Axceek9M6R0JnGR4O81Y/dmGEuJh/3RwxvmhkRkoC3KIM1oBIWEG2sye3GahWZ5JrqQ3NfQoGtO3ImzTNaZ8j627z3GKI1/gno5om60j4OpVU0Oip64NL1KLO+rLXfAxJCGf8G8EpmVkHWRDjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077356; c=relaxed/simple;
	bh=9iaMSmlox51RK9UxCBR8HnxGg5QHRgbAboXffhGBB+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5hVJky4IcdMepgOekAu6XmTeM9rD/mXs2WG+o2f9db/1vpgkr54beIzmkcGA+mulEww++jmzO6Dv4A4gDOFzXeeNzlqlwZIEz7A7OI3oALan3G8uXDjEuHSPz+OxNfVH6XyZ9MW3j2WwKMiTZosDdNeST4JrrP6tJKyTLaTQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xJAYl+JS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xJAYl+JS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A77DD1A0E0D;
	Fri,  3 Jul 2026 11:15:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6881060300;
	Fri,  3 Jul 2026 11:15:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA7AC104C948C;
	Fri,  3 Jul 2026 13:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783077350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RhPj3LBc7hrgGru5WDxx5wR5FSjgHrAYO0nqOqYbFgo=;
	b=xJAYl+JS9Ps44ZAJ7fxF4vXOtu8hstDn52kf4AMg8lvbPTT88kAZZ1GVipRLr8V+aIaZxP
	+HhBVpS52e2x+507fIwBBgDM/p23exw2KepMcgVWWYuahKNLtGs2OSrN+3aVrR/kopbJam
	Ogk28PkVWGmnkbRFQKW80qlFw7TCN9C0KhToX1PEIJd1Y0Fsj84oaLeZANwkJTSIOlAH6e
	5rsbuLRu0t0K9lRu0D0fOrshvwudY6cLW20yUOzZzdVjrQTYYehYfXOQGzcfwwv0dTPVTI
	Uk51YvwIzxJudeb6Ddg9GzuMEVpUygSoUGdqV88o5NNtXFoheU8EIKjCG5Ub9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S . Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,
  syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering
 hardware
In-Reply-To: <20260627235805.17310-1-alhouseenyousef@gmail.com> (Yousef
	Alhouseen's message of "Sun, 28 Jun 2026 01:58:05 +0200")
References: <20260627235805.17310-1-alhouseenyousef@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 03 Jul 2026 13:15:46 +0200
Message-ID: <877bncnx25.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Yousef,

> @@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
>  		list_del_rcu(&e->list);
>  		hwsim_free_edge(e);
>  	}
> -	pib =3D rcu_dereference(phy->pib);
>  	rcu_read_unlock();
>=20=20
> -	kfree_rcu(pib, rcu);
> -
>  	ieee802154_unregister_hw(phy->hw);
> +	pib =3D rcu_dereference_protected(phy->pib, 1);
> +	kfree_rcu(pib, rcu);
>  	ieee802154_free_hw(phy->hw);
>  }

Would you mind justifying the choice for the _protected() version,
please?

Thanks,
Miqu=C3=A8l
