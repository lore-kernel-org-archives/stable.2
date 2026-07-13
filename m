Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68F35DA6E;
	Mon, 13 Jul 2026 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974852; cv=none; b=eLMROeSJEO6BE52bEGZPWzSHnJThJsf5Qg+hIm6Necuk+yIMCSJ57L53Oy4PnAl/hBauPDds74cHmL5Om7bIuvD1f+BNQqX+WaBDD6N44Y6YvtJG2hIr6SfAubDbWSbSTgprmv4wqptaXB7kAJD/Ao4qcUIARohsmO97CBH8lcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974852; c=relaxed/simple;
	bh=44hmvPO4AtiF0P/vaIYzI5H0vQwHFzQasldVqbmQtjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2kQtx0F24fuUf8D9YN982Ozszlz8ToxrlTZ8wsKiMdp5/fSb2J6bDIM/JCiZyvsT7zMRqR7Ne5ZaJ7URL1uURkOhiFsmOOLTDNe7jAM8vpOzTpMnaKvZf7CuE6NJsxemFXS/68ff+CHqoDE0jzHaVwTSqhAjfki/AIAC+jb8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhZZLFJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhZZLFJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF41F00A3A;
	Mon, 13 Jul 2026 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974850;
	bh=TqlUnhogkB2uWjF8yVSstf+H1gP7hNWaSwgD9gsc/rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HhZZLFJD2JPgTfHWawdGLeJC/xRnt+XtzbKCQvcEF1kBimJFrAtEjD6K1qkt2uamR
	 vrTExX/4HEI1jDtRY6uKFHXdjvYBLadBwqMsTZEPtHpxxeEOWpxjyGbcOyG7etFC52
	 EUf0K4HZ9QuGupZq//LbW9T5Y7PjujhuhrB8C3p+SLQ7OurRoBtrucMh9f3oNalAfZ
	 ug8bhattbqA3edcXjDxxjh6NoUPrTCuoFXq/4l+GB6dtFjHDgU7/NhSz5fO11BNZqV
	 oMR45VeAjgOWOoEpl96iYMIuBXDvieEwiN+4/A2EouNeVP6+RUqWKg8cRtUskwJHzv
	 QCJ0aDZNyytnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	heiko.stuebner@cherry.de
Subject: Re: [PATCH 5.15.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Mon, 13 Jul 2026 16:34:03 -0400
Message-ID: <20260713131907.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713024943.37452-1-lulie@linux.alibaba.com>
References: <20260713024943.37452-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 upstream.
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
