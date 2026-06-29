Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2E3F0A9C;
	Mon, 29 Jun 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722965; cv=none; b=KnIwjV7GW6z6Rs4vNhvRn5jpSc45FO0Ij2YYhd1IRWHDLZZbL/7fTjAO5TeWx6jMMsIYFN56o7I9INKcZ9tRtwEtHAST8Hr82EgD7V59mfdsQsM3r5flXtGVTTroULm+RF55LFLWGnPYNVES0xwBJenBFEkhE+rD1azDUvq8+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722965; c=relaxed/simple;
	bh=bNexwtP6qx9lBB2uR84+WnHRT3J5jrJo35qB4/OoSvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=er/LeWQPeyAY+fkR25TtydurpyzOfAbP0z1uFjS15oQEB6RVg1mqvioEWDOWq1yVvYlMMTjBxJ0pJLoK2+N/BEgM4aGp3HY0I6jfp91dXwdGG5wLDGveBwQNXJXldSMMRi6WuCVD1ruroov2ApqUTK3iT3XTqkm67RZeDiI4UTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xo2DxI3n; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xo2DxI3n"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gpg1j70zzz9vCB;
	Mon, 29 Jun 2026 10:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782722954; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNexwtP6qx9lBB2uR84+WnHRT3J5jrJo35qB4/OoSvo=;
	b=Xo2DxI3nSm1iCegJk8MQv5Ll1eLaAPBnhGRqiegbYbTjCxRaGQqzDB3W07+kH4nKtBOK3X
	dxkTDCXuQUDwC3ZesbR6kjyCUEGGStztrYbNGILYnuOljcBSgRh5/6RAXtVP+gguGSSf+x
	Yp9xjAj2QGvTgG5xfjoDECXVfis/ea/aNTXlV72Invo1LvyMebH9dEi7iC4S+JDfzfAdnQ
	NRnFSdYbz+GRaxibti2WUcwH/Eu4d6B7AwsMUUcfxA9sx16NZNKM+5nDCFuW7+7BGqOKXG
	6xcZzlTKT1me4aIiAYV/TZQcQYu1viLrzGkqyS1iVNviQ4rGqBMWAmeqkCMbHw==
Message-ID: <058f4bb261e408cf17deca9ff7354460675eacbf.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Make dma_fence_dedup_array() robust against
 0-count input
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Baineng
 Shou <shoubaineng@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Akash Goel <akash.goel@arm.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 29 Jun 2026 10:49:08 +0200
In-Reply-To: <becd29b5-9e40-4104-b6c9-3d91e2ddddff@amd.com>
References: <20260629031346.3875683-1-shoubaineng@gmail.com>
	 <becd29b5-9e40-4104-b6c9-3d91e2ddddff@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: qsgddayaj8bgcsbnm6438m7kgxrxucpg
X-MBO-RS-ID: eb9239d37414620f1a5

On Mon, 2026-06-29 at 10:45 +0200, Christian K=C3=B6nig wrote:
> On 6/29/26 05:13, Baineng Shou wrote:
> > dma_fence_dedup_array() returns 1 when called with num_fences =3D=3D 0:
> > the for-loop body never executes, j stays at 0, and the final
> > `return ++j` yields 1. This contradicts both the kernel-doc ("Return:
> > Number of unique fences remaining in the array") and the natural
> > expectation that 0 input gives 0 output.
>=20
> Good catch.
>=20
> >=20
> > All in-tree callers currently filter num_fences =3D=3D 0 before invokin=
g
> > this helper (__dma_fence_unwrap_merge() bails out via the
> > `if (count =3D=3D 0 || count =3D=3D 1)` fast path; amdgpu_userq_wait_*(=
)
> > cannot reach the dedup call with a zero local count because the
> > amdgpu_userq_wait_add_fence() helper guarantees num_fences stays in
> > [0, wait_info->num_fences], and wait_info->num_fences > 0 is enforced
> > at the ioctl entry).
>=20
> That's not correct, wait_info->num_fences is just the maximum amount of f=
ences we return.
>=20
> It is perfectly possible that amdgpu never finds any fences to add to the=
 array.
>=20
> >=20
> > However, dma_fence_dedup_array() is EXPORT_SYMBOL_GPL, so any future
> > caller that forgets to pre-filter the zero case will get a misleading
> > return value of 1. Depending on how that caller uses the result, it
> > could dereference an uninitialized fence slot in the array, since the
> > caller's array may have been allocated but not yet populated.
> >=20
> > Make the contract match the documentation by returning 0 early. This
> > also skips an unnecessary sort() call on an empty array.
> >=20
> > Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> I will add a CC stable before pushing to drm-misc-fixes.

No offense intended or taken, but don't the DRM rules say that things
do not get merged while there are outstanding concerns or significant
points in review feedback?

What about my comments?


P.
