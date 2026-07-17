Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD30311954
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252275; cv=none; b=p3g0G3/FrAFqR/RTdPsNnj7UY9sWVBMhO87rUq0Df6YaiC1MwNeu8wnf4V/l+FBrFVKLpbKJifPNN2eAm2ZW10gD136smNj9bgZ7ycuAUeg378PW9wjHawJ637f1ej3l+A5KxTfZ7FAZq+T2y22PbnIH90LgFvBXInALx09b7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252275; c=relaxed/simple;
	bh=0h98iqxKocDVyERBAnQip/WL+dfjrCT9e4UIhGt5ZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeQP1l8WIKP+CSWuRlT5fy6d4Lm/RrF1GVxaVdu4tOZ5FdoqnrOb2H1JSEyPhvJSMZrVpuKypOZq+eiKWxrGpGpzrg5hSMPFiDhDiDFZxG1kOC37uVn/0F7Rg7K4g7TinaraZDZ1HaByuQVHhhN2vlJsX8kYdvTAIMXqiPgqTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9B+D8bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9B+D8bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843D51F000E9;
	Fri, 17 Jul 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252274;
	bh=soIJXttgUFMWw4ZG/ic2xAbY+DjhBHfy7eIeSt94ZSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9B+D8bqQ5ieNBtoTQjtUmOH6IJGyu7nFdA40iqBkg+nmaoM9HtHME3jLh3XEEO/w
	 HY9p18DzDNojipJ7XpV/S90T0G2DRYeDrJV86GGTRACe+X7Ki4+wt+iV8HlJ4CgoIy
	 L0IJ4S4JNp7Kl8Yx0BBQgCb29Z+P3KsZ0pUlNEAUWZOqSuC5/hsC3q5DWxCyeQMv5m
	 on7iTTtUs2tQSN4RafATJXAHWhXke7zpioF1y3wq3xGMT3v8ym1AWxDsIDIPZzbFkc
	 bJfHHnWhhz6t2z5U0Vtoxi5IoQNQRWcUz3xBUldN2F4Bah54AGaI2HOtIqvWc8VfIR
	 Ld9jtWOmcEu7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	Kuniyuki Iwashima <kuniyu@google.com>,
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
Date: Thu, 16 Jul 2026 21:37:33 -0400
Message-ID: <20260716232340.0006-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715120704.1950127-1-heiko@sntech.de>
References: <20260715120704.1950127-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 02:07:04PM +0200, Heiko Stuebner wrote:
> Since all the syzbot reports had PREEMPT_RT enabled, the only
> possible scenario is that reqsk_queue_hash_req() is preempted
> after mod_timer() and before refcount_set(), and then the timer
> triggered after 1s aborts the reqsk due to its listener's close().

6.18 has the same issue and your patch applies there as-is, so I took
it for both trees.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
