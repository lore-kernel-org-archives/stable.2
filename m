Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997B3D4138;
	Tue,  6 Oct 2026 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322584; cv=none; b=BZtziatyPMgorcK+eDIHVnMpdo8hCZnGL8Wnx/IPgtoV13dzjhxP9w+UYXrbiquIQUqNAWXxAXVvd4hY7Gf9uF86cQ7LGNVGQMymGpljSfJ9f/SRW0U4RGY43iMqWuCY+SAUN74//uwdVozXlMPDtjVuFzWR2/Tu4i987tEsIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322584; c=relaxed/simple;
	bh=Is7r2UQkiL0IIMHY7iVW5w+1/FG4jltC+We0JlS7pks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGs4GNoR1E8DDA8d+Krky4APgD94SVvQPsF+tsioiv5L1AdBQUB3OuhzjGEu4v3qVpBqlLEtLXiwxFrzmDqB/UD+XLYs47jM91T99Y6IPM6HYDgZAQd9X53DKFJ5joG3DB16rLoWgyNmMwZydvSM1XquvLlCELhjupn7LiClwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULHsnARB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULHsnARB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E07B1F0089B;
	Tue,  6 Oct 2026 21:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322583;
	bh=DoIPMteEZGl9sKihffpx/Jd0w6HJSg/dXjkh/QaT8pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULHsnARBVAzyLrz1vCbkdTaw51f3LZIfhN67jRy8+Zz/3WSaeX7oa9+Y/BAuu6GET
	 nNcBXowpHPk+oP3FTIWv6ho2j4vbZZatlEIqgmicuE+EvqzRzBMH4tZf6s2fgn78VP
	 os3QipcFPTg3Fg3kZvsLA8RRsMSvwvhVfm9nXGFWp+mvJb7C+7X81bgjGskPKOiubz
	 sJ9HM9UCrOzIYOM+q3AyoI7kmCAl7vTeU34Wv+i5fbgDhmTJWc7D3wW8LEPi65setB
	 NQ4BY3BTkMQL7689Np3lGUMaxjKIyOhFp0WgkOv5GMjXo0ds4Y1iGOXeA0vzCx2sC0
	 3cJgHjyguOSUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH 7.2.y] mptcp: fix msk->timer_ival reset
Date: Tue,  6 Oct 2026 17:35:41 -0400
Message-ID: <2026-10-06-1-daily-reply-0009-mptcp-timer-ival-7.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005174222.3524381-2-matttbe@kernel.org>
References: <20261005174222.3524381-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Reset it to TCP_RTO_MIN, which is how msk->timer_ival is also reset in
> __mptcp_init_sock() in this version.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
