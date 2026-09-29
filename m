Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A355D87F;
	Tue, 29 Sep 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707871; cv=none; b=r/09iqM5gCgYaN9IlfpHoNHOUXcmLl7vEuj3JAN8DMbnRyh2kUFm5rJO4bsEajBhE3WJssW7e78+Oqy51dRXszXQt6IYy+/wEVq0+SAcVCtxqHIyglh/Knt9e3C98l4HN3IxEVxAe21bYsPUM+JUAn5veW27Kmk7zq0x5oV7Xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707871; c=relaxed/simple;
	bh=cs11hZ9wpbNAYYUBMS4z8hhs+CMeBgghfVV2iyRtoUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uohjXe+3OBEvXUae6TPKOF08PqpMR0QHjF0bQHX5wnpTHSDGtuur5DH9KmWt0NycsPuFBAUOL6WgUN/IPv6kuclqC6jnDMRHZg4raGhx19Hi2PSNvB9PluyHR5SOrd/PW5ru1veU4WEOaz6GOZDS97oszLFtbT6dB3I60mF0I3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awm6Fw3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awm6Fw3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632981F00898;
	Tue, 29 Sep 2026 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707870;
	bh=fduoKlZbfScAblXPdiyREwhE/mDD2fOriAlwTEcK7Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Awm6Fw3or5iEcTLw/1HmukYttqWb/1FH0wxBKVzgcIs5ut7GUY+0YGPBE+lujVlWI
	 Js6xxMKFQrHycAox58RL9bZIcKASmR/fOQw8BuQ7nr9CGWT/LBlw/Dj6kxuwgglfSN
	 SROzXr/n8HE4/mHzDBWvWiI4BjdSzKYncxYC5Hn3/SyasGLjk5Rdlm0VwsgcvmOkwN
	 MpRUd+Vwxy+yTkUrE55t/Kz993HZ+NP6jnoPbKYYNF0ll2xaPF98rQYyR4t0qbSr2j
	 vk+e7covOyS54jtHSvvgXt6h5goTk4Oo8sqyi8GPKVpr1JG5c2o5qnVVGqyAlN6GWX
	 SwhH7kcPiRhtA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [STABLE v5.15.y v2 1/9] eventpoll: don't decrement ep refcount while still holding the ep mutex
Date: Tue, 29 Sep 2026 14:50:49 -0400
Message-ID: <2026-09-29-daily-reply-0006-re-eventpoll-ep-remove-uaf-v2-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929090724.1461557-1-lee@kernel.org>
References: <20260929090724.1461557-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2 upstream.

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
