Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509B38F65C;
	Fri, 17 Jul 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278644; cv=none; b=iIW2Iae/POArma4xUQGW57IiU2014fI7hGBvhTV0iBg93skcgcMqmaJUlXie4W/LU7P9HTjmAVaRfioxQVNFlLmAmFOIqoDcIdulOPeyAbsmFRY3VIrW6bcdzaupVQaG5uet/jvtSygB5bARj+kEoHNF7dHctVYwjFfEBvrgFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278644; c=relaxed/simple;
	bh=iCOzUgjInpKDmnvCoM3/Sr3+AKpivHGUNFh8fjYXuuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KysAs4pQ0rq/Fq8OPG0vd60hynLORnesmbDefYn7OuOjd8piBE2fChduNnQtCPvJ5znWdM04rbZkeooNDCx0tfCHAaGPWTasAuC6q0g28ph+iKFowhiw9moUZP+SQTGROnpE35UNDJ3uFSq4iKCdt6QaMZfo/L9K0wII9A0Ex1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lufKBv4H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lufKBv4H"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CA38A4E40E15;
	Fri, 17 Jul 2026 08:57:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C07460361;
	Fri, 17 Jul 2026 08:57:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8D4A11BD3D58;
	Fri, 17 Jul 2026 10:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784278638; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nTNRAxvEHNQ1OIdSiaDOiaaYwtM2T5SNfxCq9yNYGPY=;
	b=lufKBv4HIEovc2Fl4nCvPnMb1T2e0LMrfQ2aeag4SFqnp1Hx4ExHhhYhb6fxHNfeQMbJD5
	l+hKW+8JJuK4WMvsDQp7XhUZhf195ndlizoewD5bjqK902l27rnSKRbTwIHA5Mt4dk1ohF
	14zfDKnn3ziRAv5FSBeUFkICu7KxRoBeqrPFV4dcwekhuI7u/zOrlcj5PyquBkOqAn4cfG
	pN9hlY3Qepya8cMxS4uXs5KUYYmJOgfrgkCSqXUFLY65BapLrg+leXEXMUmC4E/5i+eFqW
	QQNAB7tKG6CAHF3oYsOIPGjgjvqlMe35VkKmu0is3nT/Sn/QmyFJdi1ItDTrZw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: hold an interface reference across the
 scan worker
In-Reply-To: <20260710140927.13228-1-security@auditcode.ai> (Ibrahim
	Hashimov's message of "Fri, 10 Jul 2026 16:09:27 +0200")
References: <20260710140927.13228-1-security@auditcode.ai>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Jul 2026 10:57:14 +0200
Message-ID: <878q7akn85.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Ibrahim,

> +	/* From here on sdata->dev is dereferenced after rcu_read_unlock() and
> +	 * outside the rtnl: in the dev_err()/dev_dbg() traces below, in
> +	 * mac802154_transmit_beacon_req() (skb->dev =3D sdata->dev) and in the
> +	 * end_scan mac802154_scan_cleanup_locked() call. A concurrent teardown
> +	 * of that interface (NL802154_CMD_DEL_INTERFACE ->
> +	 * ieee802154_if_remove(), or a full PHY removal via
> +	 * ieee802154_unregister_hw()) can unregister the netdev; the actual
> +	 * free then runs asynchronously from netdev_run_todo() with the rtnl
> +	 * already dropped, so neither holding the rtnl nor the per-PHY
> +	 * IEEE802154_IS_SCANNING flag keeps sdata->dev alive here. Pin it with
> +	 * a reference taken while we still hold the RCU read lock (so the
> +	 * netdev cannot be freed before we bump the refcount) and drop it at
> +	 * every exit below. This blocks the teardown's netdev_run_todo() until
> +	 * this worker iteration is done; it cannot self-deadlock because the
> +	 * unregistering task claims the net_todo_list entry under the rtnl, so
> +	 * the blocking netdev_wait_allrefs_any() always runs on that task, not
> +	 * on this single-threaded worker.
> +	 */

The patch seems correct, the fix as well, but can we trim down this huge
comment please?

Thanks,
Miqu=C3=A8l
