Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BB5908A9;
	Tue,  8 Sep 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907172; cv=none; b=Ecseyt9UOv+C2XMV3oiSjnP8yzziq8Q9r7IXVlsAk46QckJ8tMQDJkDCnbdiutXm0phxI5VuI9imXkwN6+JAbGdRnHPIn5GpV7gOfGpsH01BlCkRsJLZrsPVjoFATytjSPrLWYirQmnRzDGnViSxpPyVdFHMruJyZGDp3CPEaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907172; c=relaxed/simple;
	bh=1puAgS9MLWK5YPEOCZxlS4CUkc9YPJjpwjFm2jWKBkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK7ld37FARpLaIx5QjWNBQw/QlP8EGte8y4yYpamGjbsev8BAkDGn5onCtp6IP7aHNhFNLKzAWAshUdmK8Vw97HeRnwTw1fdNJQvoeqe7YePuYmDJvjja5z4otDbeDNy265HWCs+POt6DOs/ehwcuyh4ZwkVYNKZR8oOhJlWo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1yh5PJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1yh5PJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984381F00AC4;
	Tue,  8 Sep 2026 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907164;
	bh=TpFqSqx7JWhlSoJYF6OnCPl9FE4EFdbf/nAn+FRBYXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1yh5PJYthiG1YZ/JKEtKUcXsLigGwY8g2+Nkv3Y+tVW5+OkeVbqMyJxIrteQkcNg
	 QsmcxpZq3j5GO6lEmqYw6CPd8et2pPG41ymLfTj+jhcMHoJ0O00V3a0Qg3StChvxQq
	 x5aOByCJG6Ak57A0S4IHhw/zMdtwaPlNGKQoPSPC7lTrWiiMZGYB+pDXFJH3JDbYj4
	 1rvq3K7wp5tYDk6It3VVU457g+z/1th0fiRThXVbCuISVGm4ZKYB99SLHy9KIZAyNP
	 lxwPyOKP9cVpR+0cJvPrNkkIHIM73VJFGWRP6sGqRlBA1Uf66RzpjKApbmMu4Eyjkj
	 3f4V1ZvztP3qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Garcia <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before updating state
Date: Tue,  8 Sep 2026 18:39:11 -0400
Message-ID: <2026-09-08-daily-reply-0004-aiptek-macro-index-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
> the derived value in aiptek->lastMacro and later use that state to
> release the previous key.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
