Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785794;
	b=drrgCkrAwscg8ZVOQmJVETbBVrITu2LVCkSkWx5iV/afBYrZVEF4nUB4oag/KDB7I1Eb
	 uZYSmmo/Z+4O0b3r+j5TgZe+oMZ4iLlQe0d2eYDLJuEztgQGmdne3UzNEUwgyccmFUhkh
	 Q8L06+Oaqm5UfkWNDRh3Y8K001gZ1K6bmgtjCcTc8BYhTNsDRAVYfy70ZUTrt+0w2/pL1
	 NZZs+TU6nKLDkZJg78efCr0W9a5YBuhns2Lp3BpQ43U4ZISJoa7k6wHXYf00E2nzyWtiy
	 TBMPiYsc9M2xxtXcHeyfbymvFEPXPrBhn2c2E/naLwZ4E4UXxUabiGmok6lCejKTPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1gyfVBhBGNVTKcacMKgLTgjO8MRiP1DX38/TSIsqWVc=;
	b=MNUHyJnizhXq5t1UKAA22baZFytmkz66C8OOQM1vPT31iTVKdNdvVTnpGMTkskJaTH9V
	 5mQ60QcoGtsDszZnPDWGm853IvjqGIvjWaBNoVErKyaJgDW7oOHXxp2P0xKhGF0prJeiO
	 lFodBZrwAxaSo1bD2/jT4C1+JhyO2hJ1TD+iw+xo8PQu41KuJgz02WJc6/xocdOqv9xxS
	 okCgx3ZLMDKS6A5ktAuAr4AjGIueSREWirZRMwrlSdmflEsalWxOaDoWPqCnnrhv6pasU
	 eX8J3iXxK1ajNjV3FOQ/Ihc++ddSB8VJmYL8KhTLA/1U506OvksMOQUIgeTlC2o+TJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPMIu2me;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076A606A327;
	Fri, 23 Oct 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPMIu2me
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904C01F01829;
	Fri, 23 Oct 2026 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785794;
	bh=1gyfVBhBGNVTKcacMKgLTgjO8MRiP1DX38/TSIsqWVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPMIu2meWVe/QGVFjj6jPQafRWrAXv9XHovMYP4T5+WjfbffLgqvT3ENc0+uAbef3
	 lPg2zaeaPNeTlPxyRUUYba/2RrxTNeokK93HjUnrlAlQttOR8Qd8oSiS1dWhIBn/lQ
	 hlFSb54B+BspVNCuuqE2RpaHpzAudFsnVAPUPOxj+ajA3cR6eZs7sV/i0RfJL5QihR
	 /K1yGI24QwFxiZegy53+b21cxuHHUXWZ54UiFzNqovlro7HbzJx1CmNTPbSUAwitZa
	 U7KN5auVCz7xcinvWt79oFaBsPMZnsb+wf92SMP7B/rT8CAKpk2qzGgI/N9MKcwsvs
	 rqXi8505xt5CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: Patch "power: supply: core: implement extension API" has been added to the 6.12-stable tree
Date: Fri, 23 Oct 2026 16:02:52 -0400
Message-ID: <2026-10-23-1-daily-reply-0016-power-supply-extension-api-6-12-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5fba6144-ffc8-457f-ba29-6c95f81b0e63@t-8ch.de>
References: <5fba6144-ffc8-457f-ba29-6c95f81b0e63@t-8ch.de>
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

> This backports a whole feature series to enable a single backport.
> I don't see how commit 5b4bd13e0552 ("power: supply: core: prevent
> unregistering a power supply while a callback runs") functionally
> depends on power supply extensions.

Agreed. I dropped the extension API backports and the fix that needed them
from the 6.12 queue. On 6.12 the fix would not have reached the crash path
anyway, since __power_supply_changed_work() still calls
external_power_changed() directly and nothing in the tree calls the guarded
wrapper.

-- 
Thanks,
Sasha
