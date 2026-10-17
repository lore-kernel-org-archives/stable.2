Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F533BE62B;
	Sat, 17 Oct 2026 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206034; cv=none; b=n3J850lzdywMgzAFh/fUF/u2njpD8Gw72veB/iUbCe8bGo9jER5W+3Pzcm0BnP/ZWvLsax03Uvmpyh4sHQ7kVMrmLlH775XHoOs6FTWNRYKqzWjAJh3/xgdgOPM7yNXjBXufzRg/JuT1jkZvduZkO2kXYAfulA1anSssViyKmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206034; c=relaxed/simple;
	bh=IqmwSZ52JTGVl4TrAyKO4toWs0mNLkLk2YsA33VciuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMR0vaZ3Qqr1NnTtYQNiRaga0lU1FfaHTN7LYtIiCsePEWgVRSwQ9VhSF9jSjypA41TSM1nhXMu3g1j5ZcOhWpquUz84onUMqe4XbDxV7UvSU9l0+wAOSwDYa6CqjOf/sHjf1bHn9JbD30rq8sT0O9E7Z7Nh4KIfICvOj9GtSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfXXH/Xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfXXH/Xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB501F000C9;
	Sat, 17 Oct 2026 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206030;
	bh=ivoqL5kIVJZ0NzshfXAI83feukEc2ZCQV/fiBOG99us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfXXH/XuT01Qi6SHoWxyfoePd84I+hm1SEx/ebbwQwefYgja3WHK6lUqGjM+TXOR5
	 aUt3T1Eri7OcP+IYXgcfs5KFisSfuhDKfwqs1Qd7sBdGYkz/HvzLmt4iPlXLVFQEs7
	 yhZS+5i2A9WJglFQvUmj8graWod0BGb5lr+04G7j9lrSCN0KJ3UtNg+EV8BH7qC80Y
	 miApW60UYVCDGOQi04nXZP2v/80SRhLBwwA8YeaQ9yxnYFsbTF8VkVy4/asCDDw62R
	 tAJDVAKdw5r7C58Uxu9DhzyNmVROE8P1wTqNxSx4ByhckjjPhM3ORqpSKUkjG8RaJN
	 u2U36XCUqg3kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com,
	edumazet@google.com,
	pabeni@redhat.com,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Re: [PATCH 5.10.y] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Fri, 16 Oct 2026 23:00:10 -0400
Message-ID: <2026-10-16-1-daily-reply-0005-xfrm-policy-hthresh-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015202239.1936469-1-taherafahimi@linux.microsoft.com>
References: <20261015202239.1936469-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An XFRM_MSG_NEWSPDINFO request can queue the per-net work item
> policy_hthresh.work onto the system workqueue. xfrm_hash_rebuild()
> retrieves the enclosing struct net from the work item, so the callback

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
