Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A13A16AC;
	Sun, 19 Jul 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473249; cv=none; b=FORyymF7Ox9zEbYjIzsTb76nbVgl15blQGTLBGw+lWo/WuxS67pDerqzvhxHQMenyZLUOY4KE4AKqvarZU3dcLapQle3wCW6UAfHkLaSyFH0e1c8BI/LbQhA/FZ5Ji31ww0GL96PaHFjBoHCEm+r+yt8COHEGAVugJq3NpEIQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473249; c=relaxed/simple;
	bh=kXUFFBnGEJySSYdlObCtjK9hVDooR4eMh5DPbS5Oup8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbCSZqrHywaM1bUvbWoGJri83zDy+nZhHKFYKWYX4ZNhXe+j8x4uf2ArGecGxFwOXn8GjU8jJV6hSTWsdmWsFhQwHkOg0WLrKnTEtCpgusR6LN5JTS7FqjGIwzic75MOmSd+Da0Q2NLHHtYuGPsq389V9HZTjEjAhL5F7AyR2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASRpZhc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASRpZhc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E6B1F00A3A;
	Sun, 19 Jul 2026 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473248;
	bh=ehItWtwJdnqDENUmEDn5VCP+a56QBD4uOdlQAuRVDUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASRpZhc+Q8o5+eb12tDH65sFAjH+vrHxt85LdypoLwOA+uOCiO2cuaVO8OILcxZ+7
	 1zhuUCQUKlCKQegurqtiqZIfma4lEE1kUH6kRpkvCyxiiMI0yYQsw34DM03oCal2fO
	 dZdAxJzpHws3QmPS3DsaLcFu7KmiBo9Ivi/IXYKfOxcOnc9DNKAu5ZD1SnpExf+9J7
	 4fgLsjTUj7Y8k6UkTkbK3dZO1dtjD9/Rl0ObEEl83UCzJXbHQw4EpqFrZxkedFoduX
	 xQPlcIw2tOJ4Uh2UmJbPC2lDqy7GZRC10TCyp2UPw6a70tSN8cSqJRhXM6OaIdjbOP
	 rBlR1lUyn1xbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
	luto@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	sforshee@kernel.org,
	gthelen@google.com,
	ehagberg@janestreet.com,
	nbarnes@janestreet.com,
	Stephen Dolan <sdolan@janestreet.com>
Subject: Re: [PATCH 6.1.y 6.6.y 6.12.y] x86/mm: Fix check/use ordering in switch_mm_irqs_off()
Date: Sun, 19 Jul 2026 11:00:21 -0400
Message-ID: <20260718192718.0007-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717160430.2857897-1-ehagberg@janestreet.com>
References: <20260717160430.2857897-1-ehagberg@janestreet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The backports of commit fea4e317f9e7 ("x86/mm: Eliminate window where
> TLB flushes may be inadvertently skipped") -- the fix for
> CVE-2025-37964 -- to the 6.1, 6.6 and 6.12 trees ended up with two
> code blocks in the wrong order relative to mainline.

Queued for 6.12, 6.6, and 6.1, thanks.

-- 
Thanks,
Sasha
