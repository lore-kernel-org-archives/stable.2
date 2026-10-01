Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88790519922
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862758; cv=none; b=W37l8mwi1YChvhDJB23/oI8Z6HWIpQkv34ighBX4ufIpnZQRp70d6aozFyaMHxDlR3Z9l+9Ak7l8qdDLg+pvxX8BPc2PMJbN6B6LW5DoG8ujB+KAP8dnXUSb6mcg2Vay3Fqu8vyYQ7n0Jnuhcz52LD1LoxQtVTPSQtChHiO41Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862758; c=relaxed/simple;
	bh=qFOzTmUwdj0Fpdewt4njvjxpeBY9NRhjbrL9RjIDXis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLtxuTKFCdUDWnZdPf04H4Vxqh4t1yRIvl55LUMzyrE75sAZ+8Dc34tKmyNpUvu6Zl8VjK0C9r/svga6kluUQ0WUs5keJPpZv0z/B8Q7IADzq8tY52tKTvsIJa4XYcpdQqGpCEms+WER0nfn4c663WFqXbkN0p0HgyC7YBsVnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foal6RJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foal6RJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A672D1F000FF;
	Thu,  1 Oct 2026 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862753;
	bh=RJn5y9EsKTNoP0S2XzP9Px8qiEkABfA4lxijSRqrx7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Foal6RJwTgWs5mkfP67PCWeFkpQ5PoabHyIYmwQHIUL5qeK1kDpMSMwA39TXjJprO
	 pi7T9TTDDSo+Kg4kIoeHBglcJM46ruCI5B0IbL9l7xaQJMQXKDz6+FhwPYMwmznutF
	 xVmfjz8j5ENMh8dCiLJzTkxC0rMpzN4+y5qM4OZw5xFv/c5GmTvaDqwi0FgIIbDWFk
	 XH/NVfwyYMhxfZsl5EWlGgiDkTntcZkmIRoLdOTbPWYdo9HlP+JfsguyDacRZIOJs8
	 QfWl+ngmGlxJSL/gv+p+NO4VZoKUtipupXkch0HERMHH5EUgOtDtQPljumjmHKUzdZ
	 n/Zwzn/p54XkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Titov <ilya.titov@wirenboard.com>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 6.6.y] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Thu,  1 Oct 2026 09:52:10 -0400
Message-ID: <2026-09-30-1-daily-reply-0006-sunxi-shadow-latch-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929143648.18798-1-ilya.titov@wirenboard.com>
References: <2026092929-storage-cure-cb51@gregkh> <20260929143648.18798-1-ilya.titov@wirenboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport of a13f7f5d14af to 6.6.y.  The only conflict is in
> sunxi_pinctrl_init_with_variant(): upstream had already converted the "apb"
> clock to devm_clk_get_enabled() by the time this commit moved the request
> ahead of devm_pinctrl_register(), while 6.6.y still does devm_clk_get() +
> clk_prepare_enable() and unwinds through a clk_error label.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
