Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961209;
	b=T8lniS/ufHQMVgWGHFORbyb0dHGDYQYUsf40Z9Ivyx4+Gx3H4Eq1PBh4dzlAKzrkvRyR
	 EFcUiGCfHbGibvhvTTKrB5ke/cDdDnmrdqEqCvEdTl9ZFTaGGGuE4+MuB17nGzVBK9Gn3
	 6KXVCA24DZWMrOCKnjan92Ij4Ku+9err/dmFtW66HIMaw8BT7teMjeHJwVvyPaiRkiTAf
	 6dl6wUyk4Sr7Gs32sgBrt4mYDBRr4VASyd7BTphbJB5uYdnFNpDTcdH9PNruyPxErogf7
	 twdhYvRyqFzTOW2rocOQBAvpr5VI8PcFd68qktAeB75tyUcVbbibVCo1oWvNoqFft6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6so24GezOUeLshnz+r9/uQrQbBVW4KNO24KQxAvhjmo=;
	b=S99WofiFJxz7Cle58uy8FAsE+fraQO2ZbTOYztOHrybFmV6CWCQz1xU4OuA9fzy2aMW1
	 ouTEIV73t4FU/LZb0HMZYiG9iPbkAxbHq3DoMYL2+65vEXmJkrJRMnx7pL+P4EBaVkwzi
	 vAzPFJfW8+E0ax4kFqWzfUuCNJns78pzvk1s8VuAyLJyZkzO0VY8cYBo77i+nlEzHZnDU
	 6CL0onHZYvRWFeK7dhoWhlQ/XWcrIzK6Bn0M2aewqmxMfWKnFW5Kh23nG42s4Y7j+XL7c
	 w2f5k48ESyv6E4kFHuHA9Hf9cAKeldJtVn1drnZ3FAMgz/S8APe/4NQovwQcCTQr3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1ZYGFW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873C606A887
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1ZYGFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822391F000C9;
	Wed, 18 Nov 2026 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961208;
	bh=6so24GezOUeLshnz+r9/uQrQbBVW4KNO24KQxAvhjmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mk1ZYGFWyc+Mg2qwBo1YPEdoME2QsUO23tOY4Sd1WHLz7FiFJwSoETTqb5YJe9RW9
	 dPOclLekAsH55cDRB3qoSJGeVtun/8ZpUsIBzxPldTNcDevM2dF/RmizvQcfhTUNwC
	 cOCBRY0/v1Dp/q++QzuaXVs70w7kq+bMT3qzJ5rTiqM8nzaQn0KxdKsp5GLRSmB4t0
	 bL6rBbrCEOYibTL3ryvZHT2CyZkyISySrVc98+I5clhoW8WY2magEPyJC0p/JBA5kP
	 BFqEeK8Sp85poQLLF6AuHjX/l/DVvT580UYwJILgulmFFKm4Wij2+2FrlHSbft6NG2
	 snD9dn+wpDXww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	Dmitrii Chervov <fary.ru@gmail.com>
Subject: Re: [PATCH 6.12.y] mm: fix OOM killer inaccuracy on large many-core systems
Date: Tue, 17 Nov 2026 19:19:55 -0500
Message-ID: <2026-11-17-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117124938.72111-1-fary.ru@gmail.com>
References: <20261117124938.72111-1-fary.ru@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 5898aa8f9a0b42fe1f65c7364010ab15ec5c38bf ]
>
> Use the precise, albeit slower, precise RSS counter sums for the OOM
> killer task selection and console dumps.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
