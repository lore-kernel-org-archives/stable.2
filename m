Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8951A73A;
	Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707881; cv=none; b=EAy7JLu/rzomgoN5y801ERoZRi4WGlYXVNSAsOlQkbw3qHtPu87DJMYHdBux/6N+cNJhmb1GHrRf/KcsAazih8HJiEZoVZHeVWIeM4vbAi2rEz1llHyng+vevth7vR3AaW0dKf6CPSqp+u5zDqRofHp/je4ptel/nHav/zgMqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707881; c=relaxed/simple;
	bh=25eIGJgXWOneS0Ide5UfNBku/2WyQjPBVblAY5Ewpd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFHs456ZSNhP/MMvCFPTJMEWjBYoHe5TL0pZfh/xX6kA6C/B7Uf9ZeoPJGy1kHRYcak2Z8tMeCkSl6Xm530bxUUiK8GnEmAmnTho3E0BF8zbA7/W47qElOgxNvd0ewMOv2QKes81TZ9aCSwVyEJo8LSr8mF2r5w7w/KOK51Xvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT3kBYZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT3kBYZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E161F00899;
	Tue, 29 Sep 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707880;
	bh=Z2xVvwUtdyqBwNLaR4fNUGqbS0doqYiFvfVfZlYtop4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oT3kBYZ4yMh0AWp0GaDMTffmAd0p5slEU7Lr57QPYUQxqriPV8vpWhZcgMPh6Idot
	 jdWheR6EdlgUYPvHcQPWbWGrHSzJcUruZh+eNjusrwIyzBTf1093nSUwYWaVYu3ZcI
	 5J7w8POdHwLPzhfON43dyFoeH/fegSaj8k6DWxY5m7o0DUF3JX/joM3lS6T5AZe9hv
	 UUH8i/DJjO8squaCap+KVfG/y45xXiGYRFAV5OeN0zTgpLwmy/0XtdXzWcAo48wXlC
	 W0UevDGqzNizZDaEfd+19M/aeYFaEWm27EnLAuusTkZcS9c+J43FuuGe3L6tCJ0dEp
	 pT5QJKS4RuPkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Validate function returns
Date: Tue, 29 Sep 2026 14:50:54 -0400
Message-ID: <2026-09-29-daily-reply-0011-re-amd-validate-function-returns-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031602.87583-1-artem@trailofbits.com>
References: <20260929031602.87583-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-46775. It checks four display-helper results
> before their output is used.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
