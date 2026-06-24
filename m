Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22C368D5E
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305976; cv=none; b=HLG/hJijKkzKiu9eM3nghZDouURNaGHt5GUubuffdbe0f/HNylYVQxw59+7qTdji3zQQr6mRP9ljsHdSCRF0+egfwJisS1ggaIGUc/TE465wcqZm0NDSy0viHkK9ZXQausnRQOwR43pIEM5kaNH0iL8D6g0cV86EZJFLHvO5TKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305976; c=relaxed/simple;
	bh=J/JUDEFTPgEgx7DExAZs6xvdruLI72cZilt73ftHs6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6vRAufmrKW5zV1vOanOv/ONtuYlOMFRKafinxMxhJCL1uQ8j+Fqcx4khjBac+fG32qODrIQObB3WPb6THOrm//wCttnNj29NLtEC6o6TyeIQHG2nSqGs0qazzl+eVJHTF76y6vaEIE/vckqg2GrnMzae/rB93pT0xH/1pw77Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyVTDuvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyVTDuvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8500E1F000E9;
	Wed, 24 Jun 2026 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782305975;
	bh=V1cmYLSXROW5IXWNTGx3/nUqf+/aKOiIIR3ymVREkxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyVTDuvqe512D15DGXpPqu0lhG4ucutzo1uWi8OvhK2EYovjwUoh5f29YR06CFlma
	 sJg5bj5xGeXab8pHxQ+cGoeRH7AVknASKAwebj8Zy/YQjCTOj7SMJeR+O5ThqJIUga
	 AWTy2QeJq0EXsi8BzPc8ms8LCNM7gaTBMMC1ppTi3AYE6YZmlDKLVCOegKghLIBdbg
	 r+hd8as1Cn9Ne1Xwq52xgCa/umeAnd7/y788DJqrlI5PRnBDS9hiGgEYR8PmUt2hyf
	 9kqByNq/tU7WPtsX52sI2k9MSZkIYjPL4mxSMdO0RAlWdmgqngUgBf2vhWy9QC1NnF
	 IGdpZWHQw7hPg==
Date: Wed, 24 Jun 2026 14:59:30 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, 
	Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
Message-ID: <ajvTjodx7LLj_BPO@zenone.zhora.eu>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
 <178230031953.112641.4817434529385736057@jlahtine-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178230031953.112641.4817434529385736057@jlahtine-mobl>

Hi Joonas,

On Wed, Jun 24, 2026 at 02:25:19PM +0300, Joonas Lahtinen wrote:
> Pushed to drm-intel-gt-next, thanks for the reviews.

please, next time:

- Give people more time to review the patch. Only two hours
  passed between posting it and pushing it (during lunch time,
  BTW).

- There were BAT failures. They were unrelated, but so far we
  have generally held back patches until BAT was green, even for
  the most obvious changes.

Thanks,
Andi
