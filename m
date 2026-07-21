Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58122343BE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595403; cv=none; b=MUkKNji1QneiSj7+ouxKz3VpXUiqjpiPafiuuPtU1LLpfSiXRQHV0b/aWcYTlX5a+8kdLCwGubgfTTIuTAd8SM8wFxosI8GJLA/lmrb6kRknPh1qBuLpgGSKDRjKAqSBKDENf/P6KdVe9hny1BgKTssQooOVkJBdoIjvLwO0lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595403; c=relaxed/simple;
	bh=JSG1/ufOuox64D3KX83rRhl/5W36PjYAt9mxgPQeYNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOz1QHW3//tO/a6SMHoUEvHYAskKOZ6BfHy6BY7QAkwNa3O5RMbMKeMHU0gv0dF3nx3ldyVjsk3wqsPa0fCBjSopGfH3qr+p7WruyG4PF2mU2dP7Pu1SibZr6N+QRVeqHjs9U+CE+qMUm13L8z7G6TxeYrJfiXw2Jh/rdUTS6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQPPXcvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQPPXcvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BDC1F000E9;
	Tue, 21 Jul 2026 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595402;
	bh=CAESDlG6yr/xvABXW749dOmaw0/1XAJsGopBotZlLds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQPPXcvBddCBXqyaplxobBgkSW1tml1VI/Cl8ifdnyJ1IRHcP4bFNXObORwgGXWR1
	 IIhE25fScWDX1AbXCtNV9Qjw6Bo2tmYptAJfySadhW2QVcuwclIlN8bRFNAcwTFQSe
	 pW98dQ1jOOKUWULpVbdCl+w7yYsG30WKIs0C+c1ShXSZ4MHRPOx6S2XjI8NrWVJEPA
	 yMaHBbMD1yvTeovyYeCrKkhtRGZzsIDngr70Swke/pyySc2F8NkXABG8sc6FuRr+Mt
	 0VObx9CrotduP8ztJEk40/cPcq9/td6Fs9joBBt8n8G/7p8VcKPtOipp5C5qBBJkbP
	 FZw4iZrHGELiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.1.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 20:56:15 -0400
Message-ID: <20260720175500.0008-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720131832.142628-1-sven@narfation.org>
References: <20260720131832.142628-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
