Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1F37416F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957483; cv=none; b=OhWlvTJVF2ecmUTtIrgxmJyiD44Ms6mNseo8r0ULMf23ZZx4qIUGJI2vAQ2XdRzeoyUmnc9NIJBlNHUQ3zneq+gngjKhLjomO7aVSgrW/0CBzPRMMWVpZE4bhFuadC4SnWTLP8zzbFjThMZ6vD/mFGuik5m9o2IGaGw1XR+fp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957483; c=relaxed/simple;
	bh=mHvINIZNyIF2nEW22ULGyBJnEMk0OfKt7s7RsyXUitk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgBt4BdOKXAx4bczFzvYTaa056x0Gai5KCfJTcsGQYTTlENjWi1f7FMr+CtsB0aJN7ZxQlKy0asSuiG936My9NmTWVXNMY6s/H4UPVlR1hOYM5m1A/teArgD/zf2yd29tEIW9VIlMRHgINiQpksKrC3EBb4KOWVh73gACCozs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=jsLlTMXg; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="jsLlTMXg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3lrknLW5y4akh4ysEcAiAVU/GpJHM5ZHBlTirOF66NE=; t=1791957481; x=1792821481; 
	b=jsLlTMXg9D2XrySKPrbsg3UufXUzqhXkq2OBxU01aLPYvBy3YFZ+9t8MSjwW/95XnDetQi2gj4e
	vDEOxTJJi/9IfWH8wOi2Pv7xHLX5b3d5zAgqdtQ7hxMby1bHrkQospX1rqtyNG7onOqR04TzHyZhu
	zhliUzrkvUv51vXFCVV6M3907ltIajH5v1RWEUrX2MKL3NoL/pLhVTaWuNWkLae+Vshi2IUj4k/pa
	lNPlm5w/pTSzopsKJdf9aEff5xN48qWewyeW/gtuAM4W3UBt+dYRNYYSewZovbRXoqaOs4nvUNWLN
	7mcEfUPiHpNAsMYZUqySGVbkAQYxCuNDOR8w==;
Received: from mail-dl1-f42.google.com ([74.125.82.42])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGrzu-004WiX-Cp
	for stable@vger.kernel.org;
	Wed, 14 Oct 2026 01:57:54 -0400
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1517bda04a0so2337256c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwau4rSIG3eFGBfss3rAUpNKg9sNqIvuAOzabEWVEZpNXSI5/5Uv50cN9eqg22GEi8mWg0ItM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGTI7+DMwDFqnZD/xXu06NP2yl2giLIiyaN8MNNCHjvEUhUTUS
	tO4yHl/hR6zPE9843vhiVvnzVIL8BSSxjlYP6uNEMCAIt3Lqq6t0/3kW4vjDdYDCC7gdB4XYCxv
	VNCdubOD7GZ/b9mCFC50/gZvfC4rJv7w=
X-Received: by 2002:a05:701b:4508:10b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-16a5e49d6c9mr18358639c88.37.1791957473445; Tue, 13 Oct 2026
 22:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009221957.760606-1-nickolai@csail.mit.edu>
 <20261010155110.764010-1-nickolai@csail.mit.edu> <as8FTtH7yzeKCpE7@xhacker>
In-Reply-To: <as8FTtH7yzeKCpE7@xhacker>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Wed, 14 Oct 2026 01:57:41 -0400
X-Gmail-Original-Message-ID: <CADGQE7EUNKbWUyr4thAs2XqCaykjjWByfvcRVGD2GWdBUT_UUQ@mail.gmail.com>
X-Gm-Features: AclHuK8Z3adooWzqDYNqaJpR4xFHG0X3uEiFJENAdhdcUonFyJbNwabOncI3VwA
Message-ID: <CADGQE7EUNKbWUyr4thAs2XqCaykjjWByfvcRVGD2GWdBUT_UUQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix icache flush being skipped for a second mm
 mapping an exec folio
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:50=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org>=
 wrote:
> Now the patch looks better. I only have one concern: RV32 doesn't have
> native atomic64, so falls back to generic atomic64 implementation which
> disables local irq, takes spin lock, then does the operation, unlock,
> restore local irq, so I'm not sure whether overhead for RV32 is too
> heavy or not. However, I have no other better solution for RV32.

One option would be to disable this optimization on RV32 (i.e., undo
01261e24cfab on RV32, by calling flush_icache_all() as before, and
keep the optimization with the icache_gen fix on RV64).  This might be
a reasonable trade-off, if RV32 tend to be relatively small, and the
many-core machines that benefit from this optimization are RV64.

Nickolai.
