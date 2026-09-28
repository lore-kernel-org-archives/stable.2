Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE64E4C5F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613981; cv=none; b=RxPfBMFai42LgHma2ZIM9m+Yl27amSNJvEstO4r8NzZp/bmpOK9LkQagDYwSQGbNwyyjbFbDwDiXMuyFXvA4j0TdF53/hGH5L5ayjEcgx6WBZn8EkbjTRCHcntbuzoME7BUwuLHbpWC7qNv31vgOpnYq4ve2BR5jv552EEw6+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613981; c=relaxed/simple;
	bh=SHZtiYotyT93nb8eyKiQRHnCc4OmX5rua4lLCzkbh20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yk+afHk5H673m//QBl5glSeJfZrd9WuUukA2lbbGzVimGps6Rkv6GxiMCpifYS25UKrzE+hKV3CTqc/DSGJM8q9/M1gE+ihn+7FlgldVSI9KhqxkHkToY2LmOkvZwozQFIovdWPCaCfgCKZfUEqEpRPSXwcKHrfNn0+ng3gEf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P29FzTpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P29FzTpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BEC1F0089D;
	Mon, 28 Sep 2026 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613979;
	bh=9h3uODyhIk/PtVLjcOTEwtEl+5z04qOwkMx2YeyPoo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P29FzTpQVV5k15vS9QycF636kCkGgevafIhJOVEfN89z3RpdTMXVwG8Va8w9Auuqh
	 pWYVWp1b3WTMzLmBYoyb6qPhoErmFT8QKJwLhCxC2GLfrUsFA+foy20cPzqY/VTgCM
	 7IGsWxp/jy4SzqK6zcpEqT4Q5wO2PTNiBXt1UrkmntYgaDR6iWqwn5TS07zbBdEW6G
	 w4jStZRUpA4mzj4Fgfl+Ntb31GWie5o/MxtrUo6J5HS21wN2fAgI9do3cUi6+20Bdk
	 pSOID0SGfMFlGXJcC4WjIUMDuXFgDteCQXCTlgZovthXqyUYbqMjYBqATwXAh8mtlN
	 47dl2W0D1YMzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 6.12.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:03 -0400
Message-ID: <2026-09-28-daily-reply-0004-re-nf-tables-splice-list-rcu-v2-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-6-12-v2-0-74d198e65cb2@bootlin.com>
References: <20260928-cve-2026-52988-6-12-v2-0-74d198e65cb2@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An additional patch was backported, which adds list_splice_rcu(), which is
> required.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
