Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5D217723
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299956; cv=none; b=FHFJETkCGh8BKpgwSLKkirLN8Egx+tNE3fiYpoSkYyatwWX60fUy1W/4Orp+eYMA41eJX3eZKdZ3/AkPuGGKhUCX4zxIrKX73CZXUgKW4eP8EkYoVGDXgxBgNRTexyWz65NiPOVsHz9JloAsDNddiRs2uSMIPaxZknDdSAh8NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299956; c=relaxed/simple;
	bh=Weov/P+/p0SLpGeOdCKZ0hPSh/5P6GsNL1zHwTxrXD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0wb936tT2Sy0Ho4jWAy/7lvaTl+Xkb5oxiidKOxQeJscDnW1fYi51ZNvXl+Dsp3YIZkvv6hu824/DC/qaG/lnqHKyEMTjv72E4R3KpTns7muUnnVt74WLvddrh0nUvSg9yW9pJC87FBnDCfWYGvcK7bw8vrNtBb8Kz4po8gvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=T4rRGkfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T4rRGkfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808041F0089B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=T4rRGkfl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791299952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Weov/P+/p0SLpGeOdCKZ0hPSh/5P6GsNL1zHwTxrXD8=;
	b=T4rRGkflwwu37nc3SE56s5aXMFNq1Sd7iW4cWzK2tAYnvPhnH1j40GDZVnFwwLI0KGvv7Q
	PJughyNC8CBlfidR36wp9qFjdnU3/WaR95BTCQDoYMMnXMRA5salV54V8Qa9XyGuA6nCfq
	k1qsihynzbgngPpUsholmOlL4gFI33U=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id f7dfeece (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Tue, 6 Oct 2026 15:19:12 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c247f6687dcso110052666b.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 08:19:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtS0i+p+D9mB7PFEc5H18ygdZ4Y3cEFixUyIqaZoMgYJX2Njhyyt0tuTVkojzy0PhWnzlmlQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ktoEAnzOj9tteLcDLDHlYyerPE4QD07pz4EROqcQhsz79ALQEC
	gnCXKADhc5xrLHhlTZP1wZRvjNFNtLBTfRlXUjTQTk40oIe+cGxgxe3xeZ+hg+w8CpmLPg3ybf9
	DK2wR6oAOMPGWdnnwBrZ6Y8JEwBoGpi0=
X-Received: by 2002:a17:907:9303:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c3169fcb966mr205695166b.13.1791299950007; Tue, 06 Oct 2026
 08:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <asQUKTOiEn6GB5sy@zx2c4.com> <asSo7kefA3IQFpQp@zx2c4.com> <fbeae2e157e335504157b6a6683fb505@oss.cyber.gouv.fr>
In-Reply-To: <fbeae2e157e335504157b6a6683fb505@oss.cyber.gouv.fr>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 6 Oct 2026 17:18:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9pgEFwtj2sCvJTcYHSo1P8PG5Kq3d69Qse6FZ2NbN9=mw@mail.gmail.com>
X-Gm-Features: AclHuK-mqDh7kqqib3p4GuIAljgLgEirJ4KIrhrG3xAzndDfPZnbYHtxqYInJtE
Message-ID: <CAHmME9pgEFwtj2sCvJTcYHSo1P8PG5Kq3d69Qse6FZ2NbN9=mw@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: noise: reject responses for replaced initiations
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=A9my,

On Tue, Oct 6, 2026 at 2:40=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
> Thanks for your quick reply. Sorry that I could not answer in time.
> Your analysis is indeed the scenario that I had in mind, yet, the
> second thread does not really have to block, I'd say it can just
> be slow?

That's right.

> As for real world feasibility and impacts, I must admit that
> I have no idea.

I've been unable to synthetically reproduce this -- even with adding
sleeps and additional synchronization primitives to the code to force
it. But it does seem like a real issue in theory. So thanks for the
patch. I'll add some detail to the commit message, and get this
upstream and backported and such.

Jason
