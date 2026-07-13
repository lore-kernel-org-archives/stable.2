Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0233BBBD;
	Mon, 13 Jul 2026 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961988; cv=none; b=ETvWt8cYmWpAEd/qoRSjmer838riartbQug5Zg9cHzusPm+zvxpIMRCbP+UVpx/1FK78126xmnYMnigQYfIVgWAwNofvrGEo7ZRRoPeRcRlZnNgqBuTqRiXR0xfKkNLQWBseXbZPIPF8Bfn5oPLLpE5DzDDOKlgCQam432i9pI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961988; c=relaxed/simple;
	bh=6kYyUM0vlYzvsVeOdLxV2TU9wMYEAAcFjhAUKuUzNO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQBodJc0lmtankUuudhVvodfp3N0sPXJc4y31+YPsdl8t7reeq5oyQN+jhQf0+P5c13fLq7AKPGISFpGDqTso4BXumgCxcFlplfvvidXPZAshFZ5OkhOrKC3XMPtZKPxNZjPhc45ZmA7UySX1sSozqKuMPMamVFWKc1VViadmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pOjLk/uA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pOjLk/uA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6EA131A0F95;
	Mon, 13 Jul 2026 16:59:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D9E960345;
	Mon, 13 Jul 2026 16:59:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 878E511BD21E7;
	Mon, 13 Jul 2026 18:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783961982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=upyw5z27II/LTmypKUU14CZMkjZHj2T+KI8+3Zow0fQ=;
	b=pOjLk/uAV3fNcunaC1mWU8f8dnQlw2uaHYk9pAolRNKkZOb4ut1cjTi5crxkXzIPmvXzYx
	+hqv7CwcgQkpNO6GVUP65769T2PwVG6GnLnMjm5WNcqrDOA7vzg1uLxQK2C+/hkRBqHOpi
	Oc/5xjp4UTBGnDyexmwzwDLOECGTeV4a9ed64RO890bO7/qRwkvCMPfdoRAktpoP0hmoc6
	l6TwQwPnP8S1U6lsagA8pVQbf1Rz0c8+m6LV4MJz7t900xUopWHgZjYksIwv0nBnj2qejQ
	QsJDrDhgOEjIgdmyZPRvPVwzawzU59Owe1SgBZM6KVPilAAolPfH6dqsz/lLIA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Carlier <devnexen@gmail.com>
Cc: alex.aring@gmail.com,  stable@vger.kernel.org,
  syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, Yousef Alhouseen
 <alhouseenyousef@gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: serialize pib updates to fix
 double-free
In-Reply-To: <20260709221858.158063-1-devnexen@gmail.com> (David Carlier's
	message of "Thu, 9 Jul 2026 23:18:58 +0100")
References: <20260709221858.158063-1-devnexen@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 13 Jul 2026 18:59:38 +0200
Message-ID: <87h5m2g70l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello David,

On 09/07/2026 at 23:18:58 +01, David Carlier <devnexen@gmail.com> wrote:

> hwsim_update_pib() does an unserialized read-swap-free of phy->pib:
>
> 	pib_old =3D rtnl_dereference(phy->pib);
> 	...
> 	rcu_assign_pointer(phy->pib, pib);
> 	kfree_rcu(pib_old, rcu);
>
> It assumes the RTNL is held, but ->set_channel is not always called
> under it: the mac802154 scan worker changes channels via
> drv_set_channel() without the RTNL. Such an update can race an
> RTNL-held one on the same phy; both read the same pib_old and both
> kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
> batching kfree_rcu(), this surfaces as a KASAN invalid-free in
> rcu_free_sheaf().
>
> struct hwsim_phy has no lock for pib. Add one and make the swap atomic
> with rcu_replace_pointer() under it, dropping the misleading
> rtnl_dereference().
>
> Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D60332fd095f8bb2946ad
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Cc: <stable@vger.kernel.org>

Thank you for the patch, but I think Yousef already provided a similar
patch:

https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.co=
m/

Yousef, can you confirm you will send v2 soon?

Thanks,
Miqu=C3=A8l
