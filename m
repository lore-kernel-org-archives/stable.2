Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB11220F2A;
	Wed, 16 Sep 2026 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520030; cv=none; b=W840HwakprPu40OpDUjH4dmv3oNQirY5tl41WEo77RHuWg0/GCK72QlLckVA510yJ1P897bpw10ZXGz6wcBaW518z9cREQHV6FQ81OARIidckX1pdTCjJRIOPeZ4vIj/eu/X7Bvdzgwkp4jExs7D66HwlwnIKq/hZxEMRp4y/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520030; c=relaxed/simple;
	bh=9P7/UltMOnhqjV49cBCc+Hl4ruB8DKu9jUgRO6rmEyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joOswq9aAF015PrWqeDddV3OAZeyBn0JExtT+efaxI5+ili/OSVVIVdjMd+IdUpfRO5lYZEX9MrHhlUeJVKpZI7/LTipgTROsWIYCGMU9DPu9nluZhAC2xMm+dfjD+nwvvJ+w6xNDinrdLU+mSkCVKdTVIYhpqL+4Qphv5oVy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID7O7a9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID7O7a9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F41F000FF;
	Wed, 16 Sep 2026 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789520028;
	bh=BUg8uhOBtKvJElqRbBhcONqZpWnPNheVZmTUTfbwo8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ID7O7a9+vFMdNgZZxS4smyXIsVDAQpvvpU2PBRZkOK/j/h+/d+lyT5/B96X4KXYw9
	 KzgNpYqPGFHm1aho6JZyJRE5gpw104ZCBWAR+eQpJbYQx4nZP5QU/OaVV2Z6f+DNOH
	 OelHkt5PbG2PGxfWHVB7rK6LPFW4E9qC3eRiWHa02fkyKgaV9JFnQCM25rPotrA8mM
	 x8iq32WVYZ4kBYlZo933VKDbTjtgnG15x9UnhEk6wGerjcPb0Awpl4Qoh/b5ol8uau
	 CS7u01UNDDzKkS+c412v2ovlhsJuC8Xi9QtvmNaKzH0duRpTadoE1wilii96Eq7upK
	 6aNHv3mNYUW1g==
Date: Tue, 15 Sep 2026 17:53:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Song Li
 <songl@zju.edu.cn>
Subject: Re: [PATCH net] net: korina: fix use-after-free in media check
 timer
Message-ID: <20260915175348.1a613a3b@kernel.org>
In-Reply-To: <20260910020533.2904-1-fanwu01@zju.edu.cn>
References: <20260910020533.2904-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 02:05:33 +0000 Fan Wu wrote:
> Subject: [PATCH net] net: korina: fix use-after-free in media check timer

Leave this driver be, it's ancient.
-- 
pw-bot: reject
