Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AA44AB88
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125707; cv=none; b=LAzg9uG+GwFYcZooTJqZbXxhAdCvcm9XrtHH6PP1ccpVKOPW8w/4/awKgb70qodjZDehLM/tHUMEbTUcQOaEZc5zNtqhw7myGDDvG06NKTSglfHu/JwhrdhkhRTabwqHWNOnmVfwTHG2hkXJrZoHf2VNWye8amYrEr3r1XUrVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125707; c=relaxed/simple;
	bh=NfeVZbC9nc08zyz6wk9OEMAnjarWb7nbqlGxVuo1Yw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mee4wTRalyzYyfC0woKJana3cbEudNWts+Mv39mGpHkBmtAwKTQhzZ6KO4JgcUtV+/9WXlAXeAUEXnWf8IHs94YVVTOXsCrlFm8+7RAt+5laQJa2xYOjBKpR0Sy1UI4DXKPygV8Iu9vwMa2RypwwgZ7/TWJwqM17HfvlYoxFafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJTEapyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJTEapyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273F71F0089A;
	Fri, 11 Sep 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125702;
	bh=Fuv87Xhj64vY89SHecYBb5HPFLsFKttmfP/sY9kcdsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJTEapyhbhQiOVyiIz5cLMDcrlYByrDHqum913ddquUlzJcLlTMQQwOoSuTAfC1Wl
	 OSQp9hcFibLsK/ZvUz2Nd9arRXdvl7Hsmi0nbjcpmtbY+aOcYYBW6nyE/PXVJs0KML
	 3cwB48uedlY2tiz4TFr3WccU4cE60Eq/pHi23cSNX2+jyZvQg6Oh+LqEwn9sAIBJ+3
	 zj5Y9fObegiATxG4SkpQaijkn2iWCSOT66hpyWKAsaVNVQBvDUIgZFv3nIS0Cn5nEz
	 NFUqIYsxyntH5gmmqkEMb14c2qDFb2BCElawB11u6QOeaSSzxo6AEpC+fcqMPkf8FQ
	 5+d5+aCl+I7gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
Date: Fri, 11 Sep 2026 07:21:03 -0400
Message-ID: <daily-reply-0044-re-batman-adv-tx-priority-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185524.979838-1-sven@narfation.org>
References: <20260909185524.979838-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 7aedb59b80993c912ab45ce24386a2775150962b upstream.
>
> batadv_mcast_forw_mode_by_count() pushs the skb->data for
> BATADV_FORW_MCAST forwarding via batadv_mcast_forw_mcsend().

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
