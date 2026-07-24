Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC842EEB3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892172; cv=none; b=RE9OZk8m/v6K9qlER4QkHB9jCs1Yl3l2Ejlnhzr8eZsliGnI1xseb40je+FrjquqKpiOPsAhVk50TVuUfl7eCpFcL47EBsWDiWUCy9z4PQQNtY3FH2jRPjjwJpi5A37YANn09jORIVKCQ2ojmdkhlDDIPcKoJwPfWn/CQJkRX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892172; c=relaxed/simple;
	bh=4ggn0cRWz5TQbffankiQ/K36b51BwmmPt5qrhZvrpB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDVLDaVhwKym9/PUxF+m962RiAiAw5r6mkzHQOPovWnKv8pT7ImegJVA8EkgmdXILcRPi7v0MhQQvKf2nrmQ78yLEpotTX5M0MkmFWAlJAzmwY74Mxi/k6Bq6dDeH3Xr7PGogsTlOjJZutDWKwv1dYke52+L82mWNO5ttaskTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsghI99s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsghI99s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21FB1F00A3E;
	Fri, 24 Jul 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892170;
	bh=XXhBl9ATWh5fA7UYnQivRzspZXHDJjdE4XYaM0h8stA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsghI99ssUd27dEYgG0SowCfpeDbpHge/4YNPTZSD2oBGxDUG2f7pftMBUySf0r70
	 pPVBVH4Bv4kET9UHHLRMZyMg1Bj0ORn6kSjnh+hLFPh0CfwxmG4Zn1HDtBNLQdBSN/
	 5EWxvdjsO1lb/hsESqAt9Bk7WtKLy6xRrPx5GdXGhLiASQo+5tTbQZBqvDcykV1/TQ
	 3m96RG7vuUK75wvSJyhi8D4QLPpiLmZUDJnAkfsNjWzJ48sfMNbpaSSBareJ5HkwxP
	 fwkeWeWcqqKXeoGWqjCqC3YET99/qKDNF+vZYbzHz0m9wq5vWZvur30YmXtM+6RWSI
	 dctbJdQ7Pb0+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Moritz Klammler <Moritz.Klammler@ferchau.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5.15.y] futex: Prevent lockup in requeue-PI during signal/ timeout wakeup
Date: Fri, 24 Jul 2026 07:22:35 -0400
Message-ID: <20260724105500.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722204748.104836-1-cmllamas@google.com>
References: <20260722204748.104836-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> During wait-requeue-pi (task A) and requeue-PI (task B) the following
> race can happen:
[...]
> requeue_state = Q_REQUEUE_PI_IGNORE

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
