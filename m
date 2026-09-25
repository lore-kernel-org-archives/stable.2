Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F443E48B;
	Fri, 25 Sep 2026 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362111; cv=none; b=UTk7NOX0GPunibfH1tTPZpZiehqDQTP7dB3TWy3DaMfnTlI6WBEm06Lap7/eAMZ49ury++fwWjJHkGaLKBAgGtLDUPaT3uITY+0nNOqX5ScCnqdwhYwOgIC3X0XuSLtsb5pR7nL3/DxUk3OZG3aCvNrYRJlElPuGR+sf9zseQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362111; c=relaxed/simple;
	bh=Lgbxg9hf/JixN1bh4yYjqMkPNR+EWnhkxX9pTnZxFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLrv1dq3bqzTT5HxqaU3NaQOn4/hzU1KHhL9+qayS5WFxSVFrEGNAxj1IP4epZZ/weJCLAt7c20rFW9O7rVWdJIWRjG8MGsjgt7EBzq1nSD3TgpLYwsju/8QG6VwnA4980uinSxcb8Cncc/thYrCwqgQalFfy3VdSXLVF0b3JfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTLefvhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTLefvhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E89A1F00893;
	Fri, 25 Sep 2026 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362107;
	bh=fFFsE5Dpykubt5ihgA8tr0oReh42cQ0wz2+h2wzH75M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UTLefvhP+xVVODmxOEkIVp2q8Cm4Y8BXsoklodKRduQceqYqoGdd5BpylBxYJSRpB
	 zyf7dFmm/SrSlG9+jeC7zKMw0OfBmEGxvwtla9vXSFdKa2W/XICKOiQRLa9NZZ+3+G
	 OYS5bF7UN2qja0iN3wvsXLUxZ4Nm67S2gZ7RjrQhPEdHM6IySV2Jafk3uZ1fE/T5sw
	 o7xrOhIAakeTq0rSDa3xGV6ve2aX0NiYe4i6UMF48B/jVY+SzI5JLWhHHA+/spWJCA
	 8gmZR8P16MlP343pghfem2byOATYfkNsrX64egPgV7ZqZLuyKlARbqUCLPbFmDjiXb
	 Nj2T97s0+6heQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 6.1.y] sh: push-switch: Reorder cleanup operations to avoid use-after-free bug
Date: Fri, 25 Sep 2026 14:48:01 -0400
Message-ID: <2026-09-25-daily-reply-0009-re-sh-push-switch-uaf-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924173842.88036-1-artem@trailofbits.com>
References: <20260924173842.88036-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: use timer_shutdown_sync(), already available here,
>   so the timer cannot rearm before the queued work is flushed. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
