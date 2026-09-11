Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF97443C31
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125683; cv=none; b=G1GwVgJfNqpWrRv8iNWUyP/I6xCHz5X0UHqUMUKMIShwedrE73RlX2KOZRC1SQ29ZHfioOqedqKUhPVuS69sjqegRaMdxAx0mWeXbydAooQBNeJcE6Gmm3cM7tXdeEpHOelq2gq3wiYwxGUA6Ub6GDLqGf/eUr/LlIYhWKGPcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125683; c=relaxed/simple;
	bh=t7Jkr923w7HKOfn1yXkJ4qplye5nji0k8fjQdKHY3iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiKx+nVa0jcaF3exZnFl9uNXzXsV8dz60HIuW7JnX7+68W9U9Tgj9tPmS9Ra60bi78lJaLM0uhV2725ZKFMblD6yIOJCaJxb7M6W0T4kfSvqQ5gFuJuPYznZOmjHd8RHqRnjS24lQtTWv6Xxqf27ZCnLqydO7Xvv9VPbUy28yX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HknIwJd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HknIwJd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E31F008A1;
	Fri, 11 Sep 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125675;
	bh=UMBs+gF/QEo5GFeFSqrs2Pz51Yu0HeF63YUUJ6ykhWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HknIwJd504PsanGrnwVCTjtD49Ok/6HH7/+qQBQJ5nrIJx0CFdoS7wSXTU8KqzNgA
	 eASBgIkNMziA/IRSyZnjOu0fQQr1kS2NsvNHJBDrhJXOdMty6/leC4uw20XHbZVXlq
	 ExradzVCr/y4UzJGcD/0N3GBqvbb5Nin0/n3U9LXxU4TNS6aTzEGS4HR8xJBCiCmhg
	 vBgWwrWWDFFA23o7bBBnLZSaI0dOhTFby00mZXY9bahgpI5//4cjmptYfbAzn4PbTe
	 t/YKt7RdQjkXZky+R1PTvzV24II7gXbgB0pOO0/Bp1vjlPeXKoAya1c+Yz9vTlV4/n
	 /d7Ta/5i2aMXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:33 -0400
Message-ID: <daily-reply-0014-re-batman-adv-dat-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191652.1174815-1-sven@narfation.org>
References: <20260909191652.1174815-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

This one had to come back out of 5.10.y. It applied cleanly but broke the
build:

net/batman-adv/distributed-arp-table.c:901:53: error: format '%p' expects argument of type 'void *', but argument 4 has type 'atomic64_t' [-Werror=format=]

-- 
Thanks,
Sasha
