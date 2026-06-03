Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E43AA1BB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503736; cv=none; b=pqSQ7WbsdT+59c4insjyzbG4ed35BEn6Hbmxw+C+fAvTqPRmzi+AjGL3luLROwrx74pozR4xrwKxo4DemNt4//mWOg+ZRqDgTqke6zYsZBcxJ9gvtgto5UXCir0fPW0pVIZxpDhJTACrTnfzSXK0HeovIYPFyJzSfkwi5B5/lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503736; c=relaxed/simple;
	bh=wGxgAQwcjweBt1joUDz6N7yOUq13v1bmpae5T1zCRVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJsLe4nnR90eiEwM9pSFzDD4MunfoDF416DG/5N3Ji07KjSMK7FWS4uF0M2rzTZsT/b26uCGslHn+fgyF8ME8zWXhm9BFQD7ju1IqD1j8Fal14wSsvQeKKcGXbrlrq0hB9/pcwbKEvPRhxh/UBgUHo2/OSF0aU8WP8VCP0Xd5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Jz955fD8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Jz955fD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780503735;
	bh=wGxgAQwcjweBt1joUDz6N7yOUq13v1bmpae5T1zCRVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jz955fD8YsMTRnyLCPRjrx2VocqPW6P2sKxDJA/F5zbGSVGa1j7c7oSe3shqwYz/G
	 KN/xwJ+z9vwwmtHIlOdtZQlvdta3GDdBx25ToSIFeeNJywqmCvoEOEosSOQFbBbQgE
	 bykQbPRO6hvMyRw/ujp/egqZ8CX6bg4Zz4IN+LHM=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8B92E65987;
	Wed,  3 Jun 2026 12:22:14 -0400 (EDT)
Message-ID: <56ddd82d81e14d5b14247e2066955bc21223951a.camel@xry111.site>
Subject: Re: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to
 DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Thu, 04 Jun 2026 00:22:12 +0800
In-Reply-To: <20260603105137.drm-amd-fpu-guard@kernel.org>
References: <20260527144428.1095001-1-xry111@xry111.site>
	 <20260603105137.drm-amd-fpu-guard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-03 at 11:13 -0400, Sasha Levin wrote:
> > [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> >=20
> > As the mainline already contains the move of FPU guard which should
> > ultimately resolve the issue, it seems better to just backport the
> > final fix instead of adding the temporary ad-hoc change back.
>=20
> Thanks for the series. Unfortunately it doesn't apply cleanly to
> 7.0.y.

Rebased onto 7.0.11:
https://lore.kernel.org/stable/20260603153920.249671-1-xry111@xry111.site/

--=20
Xi Ruoyao <xry111@xry111.site>
