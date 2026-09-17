Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B14E4331;
	Thu, 17 Sep 2026 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653140; cv=none; b=b4AE19W4aRNK2t1AqnA9WTnurCs7chrKFKRenoi0G9B2sPYewIa7v4o0tOca/t6mWB2IuQ6Tz/gH+gwPEc1y/D/9L8jCLLUZTCp3ge3NYV/v8TanWTI41hwjSdnwLc32degxVfIl7FiiTIf36flxCbspSec7xoug9dtsCVKLQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653140; c=relaxed/simple;
	bh=U0WV19mMDYZZ2r82yfKOREY0jzLopBT4TjYPhIHBLVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=RBB9l3PYLZA3D2zHUBSOU1OjM6aLvVzS2yGOlX/lHbQANEX7vdxmxAb3mFlUzNYzLVgJKYKkT5RcHToR7i+QoYj1ya8pKJGIMuPKaxLuz3ksxfPCyg0W7I+YcVqZr/4RRhTqY98ofOLiIUzyrBXx+hYWXAtlmq1SRh0QJ5g9fWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijxsKd7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijxsKd7D"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 551B11F000FF;
	Thu, 17 Sep 2026 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653129;
	bh=U0WV19mMDYZZ2r82yfKOREY0jzLopBT4TjYPhIHBLVs=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=ijxsKd7DvXQ54XTb3Nsuu+2FQpdKcoPnzKrt+AwR8Zl+Xgo6NPcxNSmkZ73T6wRfC
	 jwbM6wJTjDwe7oHotKjqVZi5EbkWuayD+YAMU5ie9s7Ex+gw7PB5GdmpGWfdXKP+E0
	 6ZMOdOdlbyuzQmkLfS+0Gl72Gdd3Ny1SJth+/9DN6voZNWkl+EchgkUqcAx1dkxPxy
	 jCeDTAb0maKHktJiV88Ug0m7GnNDM9MgddFz1D4jdSBNa8i5kLGAb/eJfoC3xbS+CP
	 CutVBHbeOv/v2SOLjvaIC29bNUu+ZWmKcPhereVp3q1VnQzqXbub6t3lpocjxmwih0
	 Lrjp9HjYrQVqQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6986cff046563c85a623e63c61b202c38ffb60e00f18af07a8184602b31c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 17 Sep 2026 15:52:05 +0200
Message-Id: <DLHN33YH1DJ3.2UNJ1EY6IU69Q@kernel.org>
Subject: Re: [PATCH] nvmem: layouts: sl28vpd: Fix np reference leak in
 sl28vpd_add_cells()
Cc: <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
 <srini@kernel.org>, <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Wentao Liang" <vulab@iscas.ac.cn>, <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.20.0
References: <20260917123735.2151431-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917123735.2151431-1-vulab@iscas.ac.cn>

--6986cff046563c85a623e63c61b202c38ffb60e00f18af07a8184602b31c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 17, 2026 at 2:37 PM CEST, Wentao Liang wrote:
> of_get_child_by_name() returns a node with an elevated reference count.
> nvmem_add_one_cell() only takes ownership of that reference on success,
> so the caller must drop it when the call fails. Add the missing
> of_node_put() before returning so that info.np is not leaked.
>
> Fixes: d9fae023fe86 ("nvmem: layouts: sl28vpd: Add new layout driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

There was already a patch fixing this:

https://lore.kernel.org/r/tencent_65156571568C9E4076E52D1825CC5F476A08@qq.c=
om/

-michael

--6986cff046563c85a623e63c61b202c38ffb60e00f18af07a8184602b31c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaqvwhRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gUhQF7BH4XzxnZZF9GnlabPI2k6xVb9/eWQiCt
XX2/t8Fo0ITcw4J0eazQ6EV/7cynvcj0AX93a0YH3LmiPOKbz+lX8Mu0DuX7uqH+
To2wtNuNla22fJExMlOJKiOf+iHIh2vMLVs=
=+sPi
-----END PGP SIGNATURE-----

--6986cff046563c85a623e63c61b202c38ffb60e00f18af07a8184602b31c--
