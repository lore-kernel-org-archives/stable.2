Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD013A0B2E;
	Fri, 16 Oct 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148201; cv=none; b=KtMkB+Ar4dC/f3xeHLqEwh0KoXCCdC29qpflIXkj3qb3eR2S4HRDOutuKlfWP0QQorfcmcpQU/hegWos575Y04JC/L8o+2zeivbKz9V5+xkCxeQ27QO6VoIg3Q02JQ8XZUusCqDffPKFGM9RRy1SQZye0VXjGfPksqVttCpo/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148201; c=relaxed/simple;
	bh=ekPL7Cosl/iTNxfkWZ2f3dQr5AG+19luc/O3WiAN7gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvKf8O3TtWLYwQE63G8XaY5fNX+pyrVCgTxZIEH6k+M4TRC5dSUcUvSSu+wwnqGM8DliYV3SAN3sYvWQCO1UArfbRHboTugVpfaNLOl2Sr+zSWrkt3FCQel6NxqYyWphEk356HWXe3HXGUYtOPAXiF1LD1UmtDUuV2qXShxbkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXa4jDqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXa4jDqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7671F000C7;
	Fri, 16 Oct 2026 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792148200;
	bh=ekPL7Cosl/iTNxfkWZ2f3dQr5AG+19luc/O3WiAN7gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kXa4jDqoCJVg3BD9uU6fNczAUph7/be7U+sZHwi1Kkoa0CIk5omN5GFSGnngorXxe
	 VhlcFsq6fYjks5LBBG6ErNcs8LSapyOK7aj/ZlKnCd+/tqvrZM5QU8ZTBkbc+d7mmY
	 V6JRhEM9/x1riK7wyeyVxNSGS0dSRAFvT+bxC49WNDsHx1UcfiENfZzC4u/WYdgVMU
	 MmnqwZNk595iy9lBXzKmf4PDKFSIij5pADVPP3LJdlxgb2JeeHwCwnf0Bp1qYEwIXv
	 tMZhvW5SP2ugEALv3nS06l9nrY4QOY8wla6EuBRMqEX45EkF+pkCunuAmC+ZjtFEQc
	 /X7i0d91MDdIg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Til Kaiser <mail@tk154.de>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Vadim Pasternak
 <vadimp@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
In-Reply-To: <20261015155944.GA1836432@shredder>
References: <20261014173117.26305-1-mail@tk154.de>
 <87a4of8kw1.fsf@all.your.base.are.belong.to.us>
 <20261015155944.GA1836432@shredder>
Date: Fri, 16 Oct 2026 12:56:36 +0200
Message-ID: <874iel6hi3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ido Schimmel <idosch@nvidia.com> writes:

> On Thu, Oct 15, 2026 at 09:48:14AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Hmm, isn't this pointing to that the query should be more robust,
>> instead of relying on zeroing receive buffers pre-call? Maybe just fixup
>> query instead?
>
> Most registers require an index, so the common pattern is:
>
> mlxsw_reg_*_pack(...);
> mlxsw_reg_query(...);
>
> Where the pack function zeroes the payload. We can't zero in the core
> because then we would overwrite the indexes.

Got it! Thanks for clearing that up!


Bj=C3=B6rn
