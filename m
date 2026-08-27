Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC23033EB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807888; cv=none; b=H/YTnevFeyCKKVa5vi389wCmpmTCbxOGvHEWLhVdGD/ADBd/OgG6A942BlPDFiMMNcZ0nSJcgT8WMCghhMaXAAzdQwDMoAExZGwUjDn8Ew88WLBR0nBypZ6XALrSsMHrTKT22vH5OH1GrthXM0/Uu4OynNj6ZQwW1rPEvRsfTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807888; c=relaxed/simple;
	bh=q2ycZS+3qsPzKlpJa5pTchjHgU2fFM6zDIAm2NjEb4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBlJbSpsChVxA3jyaSa6ojrdBK2WJ9DgsvWkEpUR0bgDm332lsDycifckP2F/nVB3+63Qhmfc/A4Zh8XYmHJ1CYreaOLOUeoJNuPxdsKJUOhaVFoJ3p05O/sjAF5FVKoOSHbP9ElTaTAjVbvTlSrPG522K11CIP1zVAZ0k2PScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9PM4Bna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9PM4Bna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE41F00A3A;
	Thu, 27 Aug 2026 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807887;
	bh=8kdaO6JMaHGdH/9FU5AxYt4B1ujmxHXLjx6HBknWj34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9PM4BnawZ5/L1KXHkSDZ6eq/dyQRINqqLuq0k3wEqR63NRkuRHO8X6R91QhZOvjg
	 wgSyc1Ddgh2ISHEt4h/FVM8Fw0wEWutI7zlzkH5b1qHQScnN4ZICmKbauBavakR/rO
	 LAMbSZybStcNHWXGpnO/e4Ay5Bo1t5hQLviC8FYdN9v1CzcKhZwwwYFHBw+rOdfuEM
	 Wm0jfMPoUh4ZFpXqr+aX2kjrIWGvyXj4XQNcT+Y7HK7Y6bIDZw+IkY/QzeuQUCDGyT
	 3cUSJbLxbtGK1tuiFok5ptzEkLoKRS13ZN+ylTorXFz9XBIaolzNIpdYw0lqLblhmC
	 bywLIKYZAlJhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Demidov <roman.demidov.nn@gmail.com>
Subject: Re: [PATCH 5.10] ipv6: mcast: Fix use-after-free when processing MLD queries
Date: Thu, 27 Aug 2026 01:17:57 -0400
Message-ID: <20260827050834.10007.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826074010.9256-1-roman.demidov.nn@gmail.com>
References: <20260826074010.9256-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40 upstream.
>
> When processing an MLD query, a pointer to the multicast group address
> is retrieved when initially parsing the packet. This pointer is later
> dereferenced without being reloaded despite the fact that the skb header
> might have been reallocated following the pskb_may_pull() calls, leading
> to a use-after-free [1].

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
