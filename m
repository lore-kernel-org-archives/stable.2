Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1437BE93;
	Thu, 15 Oct 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050500; cv=none; b=PKYriV7QPa6rom1X4Tv2IkTy97sBOW1yQKLt84vn7WC4YvPpOeqFRb6GkiZQ4r5QM0UBSKeDSs5l+6jqbJBxU50jEhGQS5kpA4q3IGlLdlTB3QFXcT5Pj9Ddffc3vOyjZFYRiE4GOMtNgpH3lVQimzTPBNNK3OKJpQAmZnMDvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050500; c=relaxed/simple;
	bh=2T8DWHLOuIMjqX7qR5+p2AHvU66WpzmJ1U5OQVan6qI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLwrclxgjgtUPA/tqgn93tlLxQRr+IH1bmVj8o05fD06QCW1ePlE3+7hQbPXul7HNnfCESt0YqfGadtyMhh7nsIw9gnl3kXiq9WLXpJcfD8RWOxVN1Bu10W0lVphA06LoFTYOWaBapmJQoRdTff7adVlLh1V0W6dDApYDzhxKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFcubVq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFcubVq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED41F000C4;
	Thu, 15 Oct 2026 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792050497;
	bh=XNRe4wdgHJC8WqhZGcOYLCOcUoEAbq7B+B2ZqkentCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nFcubVq8/68DVvnbVCzBHzOy4FsSOzLUb+8XDxxVfJOEdfnorggiqeDsZuiEQusUM
	 qgnwBSWewJapgC8leeknF9ygrJO/II5b4Tv6vVcDOAaVzY6LNpx9ypdv2yMD2kSpl8
	 OcZ/oVDTEFZVTZn1kkBZz2fjh6XXZ2g13J0UyxJhFD4vqgNdwsuK8siq7zTiDxHLi6
	 Y/LsuShBJsccuua6/GHzySKz5IvTrv1N/VmDl/NYZAUVk3Z0dsL1UpS6HxReaGwD9n
	 Ar8mb8LY1lXhx+pH7QSeN86OKYiFZdMX+QI1/fSCGcLB0QClbqv4j2IA+ukxjObAxw
	 Lx/2kxShMUxDw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Til Kaiser <mail@tk154.de>, netdev@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>, stable@vger.kernel.org, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Vadim Pasternak
 <vadimp@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
In-Reply-To: <20261014173117.26305-1-mail@tk154.de>
References: <20261014173117.26305-1-mail@tk154.de>
Date: Thu, 15 Oct 2026 09:48:14 +0200
Message-ID: <87a4of8kw1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Til Kaiser <mail@tk154.de> writes:

> MFGD register queries can exhaust EMAD retries and leave Mellanox
> Spectrum switches stuck during boot or shutdown when running OpenWrt
> built with GCC 15.
>
> An example failure is shown below with the second line wrapped:
>
>   EMAD retries (5/5) (tid=3D9b544fc100001f35)
>   EMAD reg access failed (tid=3D9b544fc100001f35,reg_id=3D90f0(mfgd),
>                           type=3Dquery,status=3D0(operation performed))
>
> On an SN2100, the failure occurs during driver teardown on reboot.
> On an SN3420, it occurs while probing mlxsw_spectrum during boot.
>
> The register query API transmits the supplied payload to the device
> before replacing it with the response. Both MFGD callers pass an
> uninitialized stack buffer, so the request contains arbitrary register
> field values and reserved bits. This makes the request depend on stack
> contents and compiler code generation.
>
> Initialize both MFGD query buffers in the firmware fatal event
> configuration and reporter test paths. The initialization has been
> confirmed to eliminate the boot and shutdown hangs on both switches.
> The subsequent read-modify-write still preserves the other fields
> returned by the device.
>
> Also initialize the FORE fan fault query and the MOGCR mirroring policer
> base query, which pass entirely uninitialized payloads. Restore the MTMP
> query initialization in the temperature history reset path, where only
> the slot and sensor index fields are set before querying the register.
>
> This follows commit 5b0907407e7f ("mlxsw: core: Zero payload buffers for
> couple of registers"), which initialized other query payloads after a
> firmware field length bug caused firmware to consume uninitialized data.

Hmm, isn't this pointing to that the query should be more robust,
instead of relying on zeroing receive buffers pre-call? Maybe just fixup
query instead?


Bj=C3=B6rn
