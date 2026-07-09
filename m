Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626938D006
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559094; cv=none; b=HYMszyMRyNU3YH5E7/8TTYjaqJkjerBBwthpAjScIcqLQ9niU7M7TTeF45k2f0tqRRIhuDFUeWO9R7WjjH8rgE2Wnyr6wXHQ7GqMHWmF/qsJC2GYgM8hntTwJIAl/gg4BgoO5qZ0r3pslzjv32uxd6yMAelEXCVTzd8Pq9MqgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559094; c=relaxed/simple;
	bh=Z5VFbOAC3Ri9cdhb1eEpKXC/ALDLW01UUeaO1oW0G7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWwCrcbST5VIxBzeqkEIiSxw4c2bY7SNsO66vLGziEE9gXDaZ2izThi+0zkbTqc4k0IBqo43vt0k4sgMrV8mvc/44/fkECa39RsRfBTmVIa4YgCKeTjp2L1PIO4X2df5bQKcFfN6he+x3u1oRoXtKhcqhO/VX3FHouBMQp+ZKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvnL71Ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvnL71Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4131F00A3A;
	Thu,  9 Jul 2026 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559092;
	bh=rDPsuXfb71P8QMlyL1xkCgIVz6MR5hXJfhNhODbBLGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvnL71IhHQsPiLbaRfS+L3S54P3kl/LVZ+HR8g779cYTnWMXzFh/QmYj0IXFH4p9z
	 2he5aP5Yt1t+Oz+m/lqVaUqsa8KLOglI5SyqDloeTrzmAEZJK4N51eefBADP9KCoVq
	 SZDAHsDP8SNVAV/va1dGScMPsD9mjwSDhqVrJWOc/y1cXpzSDI0jnLlTEVsTLatgLY
	 B8lv5uXlU6rhokr2fFyZt3M9rzbq+FWq4mK0OZBizqI48iELuwfl0ptmETkoFt4A1e
	 sZx7jHRCo66YO65TzWVQoBVXO1SEmDW002MwFTyC0kAxJPMLq5tveClFcQG0M8tliy
	 5Mgnl+zKmzfVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Darshit Shah <darnshah@amazon.de>
Subject: Re: [PATCH RESEND 5.10.y 5.15.y 6.1.y] KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
Date: Wed,  8 Jul 2026 21:04:46 -0400
Message-ID: <20260708194323.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708163100.92583-1-darnshah@amazon.de>
References: <20260708163100.92583-1-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Sean Christopherson <seanjc@google.com>
>
> commit f1edbed787ba67988ed34e0132ca128b052b6ce8 upstream.
>
> Drop a BUG_ON() that has been reachable since it was first added, way back
> in 2009, and instead use get_unaligned() to perform potentially-unaligned
> accesses.

Queued for 6.1, 5.15, and 5.10, thanks.

-- 
Thanks,
Sasha
