Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A43AEB35;
	Fri,  4 Sep 2026 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490409; cv=none; b=SfozfnoxFXGYSFkvgHQUMZGIW9D1oHJnXeRLQwoTR+X/7R5TXZYC7+gzJ66NgWBsiPjqQ1Hj254rvbiuez2VXm0Xr7DL2P+kv3pfRRtUzmMxL5aoWDP4mToC1MH7hlquNAALRdxgHJav7ucCYvWwQEf5sYyQHrfCnB/YEMFHpqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490409; c=relaxed/simple;
	bh=EikTUJUHdxyIwacE8DRfLaVQJUhkD9g52077MweOpZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNlpIYtKIN1CiHttMSSKtIS40TCU8GyQ7L/KCNjd4iIjzXz5iiZRHd8b1qH1dXYXBKNGcMN8VHkShjxGnidiP3yMm4Fv+H/bpqEvEng9TGTbBdNyhqCJz2NAF53UXG+mGrOnST8nO8aSiLi9KFhAiQiwrwpDSnVK+zH7izKoUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpabTSB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpabTSB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BE61F00ACA;
	Fri,  4 Sep 2026 02:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490407;
	bh=1q0bmQISm09UgwvoqemBnCbtpVp9VO/Fl15gqCq6VAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpabTSB0ezP5YwM6U+xnOnHAsIWzQ93TlgxZNhcJtUC8ogP7g/K/BP1jaVydh56R8
	 mkaA571Xi9ajsJ7k2hlo7JrREZeWcVfuDCSxYzD5rsThL+5UY77xFq9c08w8+KRFbH
	 eBESl6TKXzfpik3zxA5RyMiFBvUuYVA7U1k5+tQjxRln5wjrIrskeFbiLh76ZcFM9t
	 OP/XIehRRK/EuC3tni581CcfppDvg60734tX+idJVJfen8NhLYFpFOmHcwBD7L731m
	 gj1CQpmVF03r6TTJO/ywBKJBDzF08BDTFmmS4SlCJLoVgqPEAQmy+Vhg0PvSGD1wDJ
	 S3Xesp99hbtYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/2] mptcp: fix ADD_ADDR retransmission socket leaks
Date: Thu,  3 Sep 2026 22:53:00 -0400
Message-ID: <20260903-daily-reply-0010-re-mptcp-add-addr-rtx-leaks-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport the two ordered ADD_ADDR retransmission timer fixes missing
> from 5.10.y. Patch 1 makes every terminal path release the socket
> reference held by the timer. Patch 2 uses sock_put() so the last
> reference frees the socket, while avoiding a timer self-deadlock during
> destruction.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
