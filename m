Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99763A7F69;
	Tue,  8 Sep 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854466; cv=none; b=EQcw5jkep14xlYqzm8iR+47GMRpabqS0Io+JavD283gPzz9/Of37do2LuFcebJs04mfY5ADGPS+S0ihRwojhbs1BHrYKcorCB5MioW7fkhyUecsm9IvRXhWXDe0/f6ZRoIGQsUiO85rmSBFoXS8HfyPJI0m6A/ZJ6eZui5r6CQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854466; c=relaxed/simple;
	bh=qAkkDMfcdHNPXx/9ok2ziusfFzODj74XLMbjjH/lekc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAdj+2nHajqd8iJ9EQrqHoRXMX68arIIhDyywQWVy1hNYqWiJzOGMiBMIFwFuINlGiP8ZuV6X4mBzyUGly9kxk+TFxgGq1ffFBAVf2UF8pF9iUn1zBpfanyCo0ip2RQ1SrGO2kvM9fFiIezerUS2+lvs7ZFDSY9Z24MYuFqpELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, stable@vger.kernel.org, Kalle
 Valo <kvalo@kernel.org>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, "open list:QUALCOMM ATHEROS ATH9K
 WIRELESS DRIVER" <linux-wireless@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ath9k_htc: fix possibly missing barrier in
 ath9k_htc_rxep()
In-Reply-To: <20260803104424.25880-1-fourier.thomas@gmail.com>
References: <20260803104424.25880-1-fourier.thomas@gmail.com>
Date: Tue, 08 Sep 2026 10:00:53 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pb4goju.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Fourier <fourier.thomas@gmail.com> writes:

> ath9k_rx_init() initialises the rx buffer and its lock then calls a
> memory barrier and then sets the priv->rx.initialized flag. However,
> ath9k_htc_rxep() reads that flag and imidiatly takes the lock. This may
> cause the lock to be taken while not fully initialized.
>
> Add a barrier to prevent speculative read of the lock before checking
> the initized flag.
>
> Fixes: b0ec7e55fce6 ("ath9k_htc: fix NULL pointer dereference at ath9k_ht=
c_rxep()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
