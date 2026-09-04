Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2A446849;
	Fri,  4 Sep 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515909; cv=none; b=ud8A6E+dw63IkduwUDnhZfVCjs/TjUFUDLK2PwjOWlV5sonntOlIXGycxJUoI0YhuO8FsQcnFrcO1nM4XvFEEDvMZaczbkC/3Id9pdm+aXzlm0QX3VmQ0ya7YxEfuGcLESHJqJGADqb1+1+JjkVD0mzD7hRipnRYjnbPppr/goY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515909; c=relaxed/simple;
	bh=s4CNOlTDV053ilbihX92ii1iVx3b5CKxABqJW/sPDAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnqLW+SUTjhSVCPTb+hlz/ZcAb9pgP6fd9MRSDX3xEOoBDfBga64ZPcQHjKI+MCDcRQPN/XWpNtiS4yScO3iyx/cwrOq1pCi5e366sd69hOKoRu6+MhjoEZrGN6J4eZdjQzAML1zosm2a9SWh2c2Nx92H+b4TNNRryOXGi2eaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wZKgQCj6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wZKgQCj6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s4CNOlTDV053ilbihX92ii1iVx3b5CKxABqJW/sPDAk=;
	t=1788515907; x=1789725507; b=wZKgQCj67sYaMqZeVcYvXouW5iJ6WB7WjJPzgik3hciViVB
	5Sj0mKtb3A5l504IeKbYbLRI50VFlnzK/P3Plhgk34b6L8dgypesyz53uyRMZxyI112XinuSuQxTl
	YJCBl8ixI4Pov58Ygyq/SxysFW/7OW5cuZqqxKLZhwafurxGcrSkB+aVdnXTK/G3gBFuCKx9flVU1
	amq6z656BSUp1Bu5y2uaskT69RMES8o5XtvDs9U0OmPKU8XMamQLSunhRjZxyPYN0hG0li7xfX12t
	nyYvbfVY9i2hgpgbfMzYU+C7stuvh9pxeMWvzx5gUDqaSrpKwB+GyrDKRVFJsYlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x2Qgi-00000001Jh1-2F9m;
	Fri, 04 Sep 2026 11:58:24 +0200
Message-ID: <cbbf805aae72d8a605cff52a5264d1048a476f7c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211_hwsim: send config events to
 the radio's net namespace
From: Johannes Berg <johannes@sipsolutions.net>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 04 Sep 2026 11:58:23 +0200
In-Reply-To: <20260809113908.2218030-1-maoyixie.tju@gmail.com> (sfid-20260809_133916_629664_627885BC)
References: <20260809113908.2218030-1-maoyixie.tju@gmail.com>
	 (sfid-20260809_133916_629664_627885BC)
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

On Sun, 2026-08-09 at 19:39 +0800, Maoyi Xie wrote:
> hwsim_mcast_config_msg() sends config notifications. Its info =3D=3D NULL
> path uses genlmsg_multicast(), which delivers to init_net only. That
> path runs on an asynchronous radio destroy, from remove_user_radios() on
> a closed socket or hwsim_exit_net() on teardown.

How's any of that "where it runs" part useful?

> hwsim is per-namespace, and a radio records its namespace in wiphy_net()
> of its wiphy. A radio in a non-initial namespace therefore has its
> DEL_RADIO sent to init_net, with its id and name. An unprivileged
> listener there receives it, since the config group has no flags and
> needs no capability to join. The radio's own namespace is never told.
>=20
> Send to the radio's namespace with genlmsg_multicast_netns(), using
> wiphy_net() of its wiphy, the net the GET and DUMP filters already use.
>=20
> I found this with a static check for multicast that ignores the object's
> namespace. I reproduced it in a qemu VM as an unprivileged user, with no
> hardware and no kernel changes. A process creates a radio in its own
> namespace and exits. An init_net listener receives the DEL_RADIO before
> the patch, and nothing after it.
>=20
> hwsim is a test driver, so the leaked metadata is low value. The fix
> still matters, since the radio's own namespace should hear about it.

etc.

Please rewrite the commit message.

> Fixes: 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-init=
ial namespaces")
> Cc: stable@vger.kernel.org

That doesn't really seem needed.

johannes
