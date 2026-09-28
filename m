Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A64F474A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613988; cv=none; b=Gmt0xyLiNXXT5moN+dLR2ScZc1rAT7bFH9N19m/yXN6kriCYk41eyfcpajHJKOUjwnHRBoHKO0pql+K8loMG5cKkCXOFvsUnVeS/ORz5iveka6Gs+oAoSj9ZUNRs8i1e/lKGugIx6VdS8dvjqalVjn3UqDwQQaGpNP+QqhoXERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613988; c=relaxed/simple;
	bh=RJZZeyiCOYav5nYJdXIhTLeqcsMEdQWS2s3I3j81JzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEBuwyyFq4kqwBqBCLufvwEhQB83FkXnSKLvOBlaPX/FyTMeWf4zxWhnOjc+0M4ELpOsygxLrFW6FrS+6O7E5n5vttoGoBCcDP6eT5CiG9Hkw9Xal5b+ghaFa1DAHU65x0BS4AHPlH6OQjjnNdsUEFiQD4oczIXam/AV8SuA63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct32Mwm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct32Mwm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E02A1F0089A;
	Mon, 28 Sep 2026 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613986;
	bh=VslqOrCcU3YyHCquySi2J536faYRaCSSTM7wU7Xqx5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ct32Mwm65DgD0/Dma7J/WEIVfuQwTynXtXtCQ06TmtCrQ1I5mV3ZoYa+mly/XlD+H
	 KkLqXEwk4dAo682zaXMx99+Hj0LffPG8fja2zCShrehAkUucZcU+mPuIDJv6qD43dv
	 3p9459yNRtxR0tCRsWm3ixZyeFiBYI/SAkIMZkYJhSgN09Bl3z0bM02P3zDBpIUIZ5
	 u9SM8rF9FO1b1FXU5PyMlWofzTq/i6Bxx80SDdUovTqiMMNN0Beh4cEzuZro4eq8m5
	 j3ogsjWmrtIogKTZLsdAQ3UWZLAHD23vv8s05h8ATPsSKoPIHdc6ZmSMV3aJMtf/X8
	 9VYGwa9EB5lMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	liuc63@xiaopeng.com,
	Jakub Kicinski <kuba@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.1.y v2] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Mon, 28 Sep 2026 12:46:09 -0400
Message-ID: <2026-09-28-daily-reply-0010-re-t7xx-netif-index-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928020418.6117-1-zhugl3@xiaopeng.com>
References: <20260923022159.16308-1-zhugl3@xiaopeng.com> <20260928020418.6117-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> v2: add the Link: and Signed-off-by: Jakub Kicinski trailers from the
> upstream commit, as requested by Sasha Levin.  No change to the code
> or the rest of the commit message.

Queued for 6.1, thanks. This replaces my own 6.1.y series for this fix
from September 22, which I'm withdrawing.

-- 
Thanks,
Sasha
