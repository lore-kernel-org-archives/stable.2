Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF23D45F2
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499680; cv=none; b=jNf8yeEdO/FZtsUWYToB73N1T7Uyzk6yYOzrbRs25LRPR7lY0cvcuT4f3uAcrNHxwYhNUVVC4TJbBL/VeolOfa9pCSDji3uE931pJOsvujiSJFVDZRRJqG+qpQpp8u8EzfPcP3xWugJxeA+y0KzJgd0u14JwtIZL+uPsn1SnQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499680; c=relaxed/simple;
	bh=LxgTUKbn8KNhLGRhBso8SsMhr0Dzs7JAPcOk+R2tsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWnMWpz56SgSs8ESSYSda5PXVUpukQlSkjoHPKtnkH0YqQ6RElt87MZXmjOQJLwmMaTLg0LEjgkFcdLBDbt6U8P/A6NiFhWDuRAOy28+nKf6vUBW31UuyfjkeyNn6NqUrSs6eR1sX44TPYAkflX2FGGIvGeyYbVoT+xzA9ceYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py/1l4H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py/1l4H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE31F00899;
	Wed,  3 Jun 2026 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499679;
	bh=6ujqYMqXB0/i41pw2tThC/BzMjS9s70+BOjvuc2SkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Py/1l4H4khFDnLB1PhkTxBkd6jshmSWTldby2no0x4qqj4vlRfCEFyzi40F/FsfXe
	 2wq85ysiKOr/BOxdQOyq8+/KlyXBNINVaEEkb1831WRYWqC/zr9hnAe1qrowVX02tc
	 8d8lMwjfnVSb7gus2nStUiimDgG+HI6LZbd1pXhZ4QXMsJieF805d4dLZA7KSsUdxm
	 183V4Dcg3Fs9XZd9VUBnw2yEueNJ+/HeqRsAsp9jm/qoasiGF9VLxkqqk5XKkHqo/n
	 7T7KPTFh9sPY6zM7xx4yVkw2f/yF6E+c7ZkDznYEJWjZQU9jQH3nTY32chs6moSTXu
	 Zq0Z2WRfUdNyA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	yuantan098@gmail.com,
	steffen.klassert@secunet.com,
	zcliangcn@gmail.com,
	lx24@stu.ynu.edu.cn,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] net: af_key: zero aligned sockaddr tail in PF_KEY exports
Date: Wed,  3 Jun 2026 11:14:04 -0400
Message-ID: <20260603111500.item010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529060945.4813-1-13621186580@139.com>
References: <20260529060945.4813-1-13621186580@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
