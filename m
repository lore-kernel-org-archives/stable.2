Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6935AC0E;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798117; cv=none; b=MRwQy50jjz2Ci+OmKShJer4y0Q5Xib84gfXqM49e3ag/4PtzZtuLTRg8PuFXKwOjDtgnqYihS6v14By2lpMc+1szp48ACfVXWaPjZgiwklh1mauTWCHrZxKaC7h+2nPeb0aq3Duu//V9vfi0xL3g3njDlJvibvU5kEk6eBYRmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798117; c=relaxed/simple;
	bh=qRqlhtOg+EH5y4ZE5//+f6FThADMBmCgZXhXnTSHfMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kBLh/4HbYKEo6Cl5/N5pBtgVOvg+o5l8Ppwuxotai5fr4WDJbExxbhTB6e0HlrbwE5PnIFjTCYRHoc9KFIHCis3JbYWh2daNyVHBBThnsTeiTvkBX0Xi6Wm3jP7qfD4MFLFej5O4BKPgoZWyEUlmG6MvJD0Fk7/RwPBLmNe2zo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484681F000E9;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BB30618073B; Tue, 04 Aug 2026 01:01:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260802051249.424015-1-fanwu01@zju.edu.cn>
References: <20260802051249.424015-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: ucs1002: fix use-after-free on remove
Message-Id: <178579811475.234019.11116107083120527143.b4-ty@b4>
Date: Tue, 04 Aug 2026 01:01:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 05:12:49 +0000, Fan Wu wrote:
> ucs1002 has no remove callback, so unbind runs entirely through devm.
> The alert IRQ handler queues the health_poll delayed work, and the work
> reschedules itself while the chip reports a bad-health condition.  devm
> frees the alert IRQ, which only synchronizes the handler; it does not
> cancel the delayed work, which can then run after devm frees the driver
> data and dereference it.
> 
> [...]

Applied, thanks!

[1/1] power: supply: ucs1002: fix use-after-free on remove
      commit: 609af0ceeaefdfa42cd01dd060b20f2e41f9a232

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

