Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344377;
	b=nx3yD58upxuPjjHA+8lqQvVIOWnrujLxm7JAOi67/P9+ifeQ2AP2MnGEUyxZKDDfdXPZ
	 98i+yLDwY1Ee1rZi1UpTiuVkVmcDW51VOj99dWZIeoD9uTijLN9eLDpKTciOctOVZjEHT
	 sYbB6DRWBTgan+DwbwJkUnLATxjAW0/EgtZ2pfusxxo3snNLe0g9paNfU0ES2lARVaZVH
	 qI1E1hf5KY9gSE2cZryymEKXWRmInparcRIPCSLBSa18qlj6G2pKdt5IxS5A09g6YYKwS
	 XE5jU5vwZCfVRLCp1/Or9GZd0rpUWblaaKBiIGO32gyqr0YQ3OFZ7AAH2iyBPJIrBuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZT4/h39Azl956Nn0FIFhJlqu1SWNZ8I4BptipZr0SlU=;
	b=Pa4pnlpiASMkb49Tb5HKnikDbTZ5oYRzdZiu/Gv68WeSlsieD23HAzqsvo7z2ASXsgKw
	 id20vDDIbtXRI6Nly/tw6/k0UPv+mWSPD4d+EQcBiYcJg95dPoOU5SWPBgnFrfH9Lfu7J
	 UGvOSF0XJjAIKGEG5x49PusmHRXSC0llazacyLXsQrnKf0qhpmJBs6+ZF0yt0fB/yu9SL
	 Yr5upyhIJe/hpg1m/mFlTup40J7zhQmGKOV195fpHTrtR1dS4YSKs9nNmP0eYoUKJnF/o
	 wIkLT9HzTvckYqDbzzWyTV5JM1wFRDvgJNW7eTuGoq//ao1olfk7jb8YiSceYhIrF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nngIjQtZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C8606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nngIjQtZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32841F008A3;
	Tue, 10 Nov 2026 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344377;
	bh=ZT4/h39Azl956Nn0FIFhJlqu1SWNZ8I4BptipZr0SlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nngIjQtZfY8OJbiSUBQAGCCghsg6amnXK0LByEbP2tmHV+NjBjKczUL2BeE2bsjyl
	 oL4K1V+6uhiEUqlJnyOsQcjS7uSNNRDhjOLSHDsPKpZWdBxVtfUp1ILwTQ+hYo3cK2
	 n+EjKiJ96UmHdFX1k389TI7UuON1vh2ebGU1m5Vqr4hbFuHHa+rMRI0a+2FuAvk8ve
	 Al/9OK1cXgnGXnrZS0oZdIaqW8Ods1D+pp4+3ewhDgLc3LlF6LeNiBRSYO1+RjJXhb
	 0XJfsAwOKO2cMHHwcxtJTwZQNDjti+lwtUeqUQDm7f+3n5cIPLoKB8jC6CWdbQl1ov
	 R74GLjL+JvqSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 6.18.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 15:59:00 -0500
Message-ID: <2026-11-10-1-daily-reply-0004-can-raw-isotp-lock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110175827.791828-1-socketcan@hartkopp.net>
References: <20261110175827.791828-1-socketcan@hartkopp.net>
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

> can: raw, isotp: copy socket options outside of lock_sock()

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
