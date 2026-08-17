Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED430274FD0
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937130; cv=none; b=i1c0X7ajYAd9qyyzOmGoFwS12HEmTut4r3a3654QrLtedkxO+9NsjlGGsUv1gOgOXQa37cdaqCBuQ2bLZ7TgvGYApaT1cUgH8Q6XiGoSBRgO+LMvVJ8rD+ITcjBcfIYxbnDd5JNL0kNFDLWqH3WAQHx9i7VUIVVRIPLXIZj9g5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937130; c=relaxed/simple;
	bh=ketbWZ5PgYOvlmffbg1C1krYA0dLiaAcW4RL6JTUfWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk6IzGC89k56rMwFIPgxIyae4m6vSVhlWi1sliO8vHGODnM83xZ1ecLrxyU4wBBxHGwlmFTfP9mT4FdPI0ek0wggR8er0JVevgstclmJXvwKSdE97d0C2gQaZvXV3GcyzJC9chA/Esb7Fe9uUGC955pYO9nznLVR+pEof2QTQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+3zXTQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+3zXTQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559341F00A3A;
	Mon, 17 Aug 2026 03:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937129;
	bh=2lxj1JIdxwx7lHFXGJQcAoPGTzYS472TJSBYQQfzaCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+3zXTQxDWk/NBcRXJz39Xbp9ttk8NmPGGqudcUKsI2S1UfIVup5AiPKR6vyvzkAc
	 6N/shQ02iQiOsyt5lfA0z9IMhzOu9Mn4xBv6TSjBbaDLEdfP3mzffZuBE1YCghch4D
	 sQZBmWi6b4XE9cxzipPDMfVphyx1P9dU7SvqmfIdM52A02UOBAwChJrLpM787mhoKc
	 k3mLvJtX8oPyM9+sXYnHIEbEtpir8oRLSoknqUkDQFEoVgZgZkvf6i1IECwhhA7V9f
	 rsoFU/U3/IqloNItWNz5nwpqMU3XLMy1b2liQTejQ+LOE0SYCAKXB0w8IbD0eC2CRM
	 HQ0YDuwUkyafg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Subject: Re: [PATCH v2 5.15.y] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
Date: Sun, 16 Aug 2026 23:25:16 -0400
Message-ID: <20260816211000.13@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814143553.2949913-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814143553.2949913-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit c1492da3939c89372929e062d731f328f7693f1e upstream.
>
> The pinctrl and GPIO core code make exceptions for the -ENOTSUPP error
> code.  One such example is gpio_set_config_with_argument_optional(),
> which returns success when gpio_set_config_with_argument() returns
> -ENOTSUPP, but reports failure for all other error codes.

Queued the v2 set for 5.15, 6.1, 6.6 and 6.12, thanks.

-- 
Thanks,
Sasha
