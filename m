Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3A3E7BA7;
	Thu, 25 Jun 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399692; cv=none; b=uh606El0IZS+FGsEN1+ueenjfZTOgAbbAFttqxrxHApI2WsyjFxOD3j2cy6isBqWkN9BxwO5tWPY0duycyr2hxFUloic0UDcVa9FJjplXQoe58UKzoKc48Yje0/JW+xG5bufM8n23X39epZpKl7AAq1qZwOQfEzgd0y0BJvQTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399692; c=relaxed/simple;
	bh=y0kLbmjBiEqarhYNWRM45XNqeHkgeRs6fYzViD2tGxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UaO5VUhnj5Z+hP05nVUWjg0Su4OYtUJj0dSEBtw5NDoBb8ggkIfVX/WaA1m7OU2DdbyLXeiXUVaAdR6Rq1rITskH1Q/X15ZJAiygVqnhA3V6wBnPAkTazKiTL5ZuSapDef7hhueuXaeU/66pCJ95jqF+29nQtzI+0cjZMaffhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ycI0Burm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ycI0Burm"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmMSz0dPXz9vDY;
	Thu, 25 Jun 2026 17:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782399684; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDf8uKydeb/dWDgOUroHzcLhyUDFhghnhH6xp9NcqCs=;
	b=ycI0BurmMS2ieeqdTbYQ84MnvXcjhlbp53mhDYB9+wT3sGlmCH48HAU8XRCob/RY15qKfa
	46vH0a9/eUKKIR6acC0jVlN70oxzUXcuQ3A7lfNj4LGqNiG2AoTlWmdwoe7jO7wc9PRn5c
	FX/dlwNXmSfJw5lsGBbl3YhKjkWsZ02u3jekBXN3SwwTNuqptKlYhuMf5nD+/NfEld7Ibh
	SZvnezVMZStCMT+ko8iO8+rIXht+Hz+DQ9enUvZRxRk40lcClIkValkQnBvj8oEanFnqWw
	WvnJHDu3QY6aDNry8JeBVbaI9nfArpBP2ct0WI5HTIu/avTb6zCPcw6MwLQT6Q==
Message-ID: <de3b9b978ffeeb43c18d877080e93823214313ec.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Fix dma_fence_timeline_name() to call
 get_timeline_name()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Baineng Shou <shoubaineng@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Akash Goel <akash.goel@arm.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 25 Jun 2026 17:01:15 +0200
In-Reply-To: <20260625141227.38931-1-shoubaineng@gmail.com>
References: <20260625141227.38931-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1c878a47db5afd3a54a
X-MBO-RS-META: xyidt6keibsxozexi515dqim3gdtwzox

+Cc Andr=C3=A9

On Thu, 2026-06-25 at 22:12 +0800, Baineng Shou wrote:
> dma_fence_timeline_name() incorrectly invokes ops->get_driver_name()
> instead of ops->get_timeline_name(), so every caller receives the
> driver name where the timeline name was expected.
>=20
> This is a copy-paste regression that has resurfaced twice. It was
> originally introduced by commit 62918542b7bf ("dma-fence: Fix sparse
> warnings due __rcu annotations") when adding the __rcu casts, fixed
> by commit 033559473dd3 ("dma-fence: Fix safe access wrapper to call
> timeline name method"), and then accidentally reintroduced by commit
> e58b4dea9054 ("dma-buf/dma-fence: Add dma_fence_test_signaled_flag()")
> when both wrappers were refactored to use the new helper.
>=20
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Andr=C3=A9 has caught this a few days ago already:

https://lore.kernel.org/dri-devel/20260618-linux-drm_crtc_fix-v1-1-801f29c9=
853d@linaro.org/


To save my honor I want to state that e58b4dea9054 did not actually *do
this* change. But merging it must have caused it somehow, since that
commit was still based on the old bug. I guess somewhere in conflict
resolution somehow tho old code must have entered.


P.

> ---
> =C2=A0drivers/dma-buf/dma-fence.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e..5292d714419b 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dm=
a_fence *fence)
> =C2=A0	/* RCU protection is required for safe access to returned string *=
/
> =C2=A0	ops =3D rcu_dereference(fence->ops);
> =C2=A0	if (!dma_fence_test_signaled_flag(fence))
> -		return (const char __rcu *)ops->get_driver_name(fence);
> +		return (const char __rcu *)ops->get_timeline_name(fence);
> =C2=A0	else
> =C2=A0		return (const char __rcu *)"signaled-timeline";
> =C2=A0}
	=09
