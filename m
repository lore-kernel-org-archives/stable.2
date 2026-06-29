Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0D30FC1A;
	Mon, 29 Jun 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729820; cv=none; b=ZAAKx3pAmelzTwZ62nWK/4NqvRYrk1bmtyd8A0qujLgfX90gbbjdh4APyfF8wuzkMyNBuJdbHNX+DkVN2tEk3wc9MV5n1WG32QnJW+RCEQ/9Hk8Bn7O3RF3nNqTSiDWIfiEuwuWegF7qpXriqg073d4akIG7Mnf7AUlZkhGtEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729820; c=relaxed/simple;
	bh=NKXo9kS8UPvQyEKtU98KqOyTUanqfXLW03eEjmWvD6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGv1GkFnOWSNBsNj2Xr7c7nD/x3Fkz8BCMGNNZw8Rr8IE4HsxVGitqVsVi51uTAjwThpTETST/fiyOWs1qAJltjdP6O4g7xB2iW5BqoiDy0TKTQMQ5io/akPvMqDOmICYG4f2XJohdC8m8Bn74FU1Bo6TBCECCR8F6idShZeCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZePC5gdl; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZePC5gdl"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gpjYg3zfmz9v78;
	Mon, 29 Jun 2026 12:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782729815; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKXo9kS8UPvQyEKtU98KqOyTUanqfXLW03eEjmWvD6I=;
	b=ZePC5gdle9c/KcEU/FYbGda+2I6PpG34VSg5jS1oI8JgrZ4DYtByZwiZmyIRlYjqHM90L6
	88cfHBWbJXwtxgJxRAWLba+JOsqISencpdXFGXBDXV8RG48OUMnFM6ipDZDObdTMG4BZBU
	Kz9OMQ9mlXDPUHOBoTHXvChLOSM5Uqz28Me4XbK//lcfDdtNjhiknw7n2mup1zNgkZ8TUI
	wb/+P7Ovd6uuF9E8c1Ptlueqkbtl/CfUnu4Cz3F0F0KgadF2WXB0atXvhPyjUBqpOVPqvk
	ve4bd45yRdq/NwFwF5Z2nhGGhcBnoTEjXEE79+wfjEj49O+nB8+q9+YmRP1Ouw==
Message-ID: <2f4ee171084d82235e23017886662b2d5b3506c0.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Boris
 Brezillon	 <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>, Danilo Krummrich <dakr@kernel.org>, Gary Guo	
 <gary@garyguo.net>, "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng	
 <boqun@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 29 Jun 2026 12:43:29 +0200
In-Reply-To: <688077c3-903d-4cf5-837f-40621175cb30@amd.com>
References: <20260629075636.2513214-2-phasta@kernel.org>
	 <688077c3-903d-4cf5-837f-40621175cb30@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: fyurinxj6p8ugeguzshhwdjorkkaou3a
X-MBO-RS-ID: f215f38f57b359d7c56

On Mon, 2026-06-29 at 10:49 +0200, Christian K=C3=B6nig wrote:
> On 6/29/26 09:56, Philipp Stanner wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

As the maintainer you push that one, don't you Christian?

Regards
P.
