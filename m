Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763754AF9D3;
	Tue,  8 Sep 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857802; cv=none; b=Dy1OuPB5hm6pfkNMCuliZHSu5o6uP+enaMMNwsUADoR8SzBJIMMJ/ViksunBUKRKQDLn1kJM4QYNKlS2Qv3YR8VrXQzblYGWmjR7Tnva02KFQoS7Pp8qkdQul5620m0SQEkVDEIJAVunHgXYBin356uhuHbuS7WzztkzCwA9KiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857802; c=relaxed/simple;
	bh=XuR89paReM5i+jnslJrHfRiRnslXz9G5DzQVW+tZL+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjvl4/XyqrsI9kWRlcdQUPIlm/1HPhmbnOONYFQRog8RRwtPeAfMgI6fG28a6/pJzAflg/rwVZnoWuXE0Lugyi8m1CaGcs8zf+xRayoK8+WtCfy8xFfP8QHmtkwj6PLHezz6tOoENUZ2rAzNnU460AgV07V7J/yq3SbK8JWMoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HKIenxmD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HKIenxmD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XuR89paReM5i+jnslJrHfRiRnslXz9G5DzQVW+tZL+k=;
	t=1788857797; x=1790067397; b=HKIenxmDNRr2sw91wb7fF8JyRmCjmWgr3vkX2029i64UJX5
	XrPu6OPfVTYc0ZA05qbMcoFh0rF6dbMT89ZMQ5i7IQpdqdx4qbVbdObM1Az9pVMekrochOqnpxHE3
	Jvw3W/x+GZDkfWlMnWs5avk76XlkSgExRjk3Dm6dBhtg4C58x0maErAW3bkGEW8EG4nNNwmIP6C1H
	RJFhmOyDILpAbiqY4tT6B/9Atlw2ybSN5PpMye6xOoV3MXB7LF1dphyTsb4ye1IwnjvaBkP6uvLn9
	3AzOn4Y1vskgtM14wcTggvSne9TDtBQ7ZyOlXJoMrGxqQJASOYTedhtQtXP7IwSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x3rcz-00000005ttu-0Bos;
	Tue, 08 Sep 2026 10:56:29 +0200
Message-ID: <0fc3903fc2b6e0b2a01a8b473cd5ce1fa3b57f00.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 1/1] wifi: mac80211: fix mesh fast xmit path
 deletion UAF
From: Johannes Berg <johannes@sipsolutions.net>
To: Zihan Xi <zihanx@nebusec.ai>, linux-wireless@vger.kernel.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vega
 <vega@nebusec.ai>,  Luxing Yin <root@tr0jan.top>
Date: Tue, 08 Sep 2026 10:56:28 +0200
In-Reply-To: <94174303640c5e1022b31836770bad75f741afbf.1788845030.git.zihanx@nebusec.ai> (sfid-20260908_082840_904659_5067153E)
References: <cover.1788845030.git.zihanx@nebusec.ai>
	 <94174303640c5e1022b31836770bad75f741afbf.1788845030.git.zihanx@nebusec.ai>
	 (sfid-20260908_082840_904659_5067153E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-08 at 06:28 +0000, Zihan Xi wrote:
> mesh_fast_tx_cache() stores raw mesh_path pointers in a persistent
> fast-xmit cache entry. Path deletion flushes currently visible cache
> entries and then schedules the path for RCU freeing, but a sender that
> already holds the path in an RCU read-side section can insert a new
> entry after that flush. Once the lookup RCU section ends, the path is
> freed while the new cache entry still points at it. A later
> mesh_fast_tx_get() then dereferences the freed flags, expiry, or
> next_hop fields.
>=20
> Mark the path MESH_PATH_DELETED before flushing the cache, and reject
> cache insertion if the mesh path or optional MPP path was deleted while
> the entry was being built. The cache walk lock orders this check with
> deletion flush, so entries inserted before the flush are removed and
> later entries are not cached.
>=20
> The crash path is ieee80211_mesh_xmit_fast() -> mesh_fast_tx_get().
> The same cache is also consumed by ieee80211_rx_mesh_fast_forward(),
> so the deletion tombstone covers both consumers.

What? You need to start writing your own commit messages.

johannes
