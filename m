Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E826FA60;
	Fri, 14 Aug 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679810; cv=none; b=TWJZTx9muVbgycWxANfwWYINkpKP1SMhZfQ3NKgFKIN0yFNjFP5OOSAKJTdm4GhzryvOwxXPqR3+0UTdYTiW+Ci3yWjmdS2evzzMo+GYgjWOWNSOEMUntRD/2FZU/1VrQY/6LWr1lBI98ESvTaKMrsjI4lYBOmwGhYexsr83cKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679810; c=relaxed/simple;
	bh=/bxYWHRMtRSYtGXydwgRnz1yaDD9XFxmxSkGatI/Z4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1px7xTEmR8OlerR9WYQJCqG+FdSDv78m3w2lgzyErvvGXuAG3tco/fniVQIQ5Wl1jFrG7CTA09v3+QC2f1E/tAVr94bqHf48W++fvHqst++u8Nfsb2t9Nv7b6AmHG+qqqEmzP736CzdZXzsoI229cS3qx2z+IQDHYnI2bSztnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B7iF9GvX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B7iF9GvX"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB9E140E0031;
	Fri, 14 Aug 2026 03:56:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 60FRtOqCLnTH; Fri, 14 Aug 2026 03:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786679794; bh=Q67dQ+6gdr5vpLb6ofSNxryrO5qN2AtuJzCoKQDqoH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7iF9GvXKne4lZe+MI9aMqMLOO87sqd3p508VnH8Q4OvXHUmJE/iKtPwfsriXOA9Q
	 3FXLbo8CfvZAWmv+PP0EDPFIEnR/tYt/AcvwfKMdlJgbUC/SJfTAsS/P5qxuRRA7o9
	 RhlbU44dMibMpQIu9nrdJhyFEyR4CG1qpeK1/GT07vI18UQc2VUiBBSt82GHem+rfM
	 lRdrexUvROqdr5a512gJHwx9x/ipq9E4utRagHgPWXX5nuSxJ8NBhne8CUKq4+sH+E
	 cXSJ57Npt96X22cb5+ceYW6CZSzB3hCIy5YPQtrUX5V2fplju52DLazorz8JA2TacZ
	 0aWgx0EVVxB85VfDQbIylRcZrVnUEGj5E6MriK+zHkNR3FPW1q7v+jQVBodEQW59ZW
	 30CMC9YCKFlY7z1im6eNsx8uHGAg11QZMe09ShAKJbTxBm7zkWzi58ztgWToS9+fXd
	 HiR0E1kkDRcobNCuHS7ghioVKjFHyl2KRssIXD06FvF5iFx2dCz22ZP6AujGp6xO5X
	 8pjGpb/7Dq3ObP8L+bBfR9CKBEsTujDi/DePt0PCP4kKyzd24YVjTZ7Su4VEwFkeOy
	 trFKTt+RC9sl3liwOEbNzM6fX0orarXU46r68hZsa1VA7pD4bufWsTfzsSOU2tPiZq
	 Kw4AFNy7H3ThPA0gEZ++XGaY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E9FE40E014A;
	Fri, 14 Aug 2026 03:56:27 +0000 (UTC)
Date: Thu, 13 Aug 2026 20:56:24 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: tony.luck@intel.com, rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/4] EDAC/altera: Add suppress_bind_attrs so driver
 cannot get unbound
Message-ID: <20260814035624.GCan6R6BgX0EoB6-DO@fat_crate.local>
References: <20260806155412.1518582-1-dinguyen@kernel.org>
 <20260806155412.1518582-2-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806155412.1518582-2-dinguyen@kernel.org>

On Thu, Aug 06, 2026 at 10:54:09AM -0500, Dinh Nguyen wrote:

> Subject: Re: [PATCHv2 1/4] EDAC/altera: Add suppress_bind_attrs so driver cannot get unbound

		...: Do not allow driver unbinding

> The EDAC driver should not be able to be removed from userspace because a
> re-bind would clear out existing memory contents of an active running system.

Simplify this one.

> With this change, remove the .remove functions because they will not

s/With this change, r/R/

> ever get used.
> 
> Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)

Rest LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
