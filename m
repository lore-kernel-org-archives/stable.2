Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F283A0E99
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473251; cv=none; b=OCNAf+8ZGFGPX/jwjHNcEUyE1ZIfPYehFHax9E8AjpU6QIv1DlNjQLvkZsvrPG66dkS8mpcXL0Cv6bDWqDLyaN7mXMCT94ET95PcrIO4S/vOrFrdvB3joiTvVb+kgtuU/Ts89V6FmkRpjKH+mD+rWMtGLDU+4qzWGLZqfvS1w/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473251; c=relaxed/simple;
	bh=TdzGziEhY3bIdY0r9wd7TLiNXg9aQMgoXvbF1z6rMPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAPE2HoSIFCjYMpIAT2JgkKrd+lY4ka19Po7cW/ul44opIWYTnZyoNnyI4W2sUq+e2/f/ih4QHA/8zmomX3bjlaD1stCAzpyV3De92z90shYBVSJCkV6UlO6GQf4wqgBfEEzQQJxodmW8NbksS2OzWhmCB58ZpNyKfgWJkc3WNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlpClf27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlpClf27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9345C1F000E9;
	Sun, 19 Jul 2026 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473250;
	bh=kaPwX0fxPl7l91njxLhKv8jvamuHZtSJpwGIlWSjrFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlpClf276FcsoJdKS3f9RX+U0ds3ojpr0onrnawFLsi+6ZaPme8yCyPUIxPuFxNnG
	 gq1Ec30qKLiGcaxb+VcPI675VBrHeCaxm3S1RKywXnuSTpYxyu2lUUAJn2mtsi2ni7
	 1A+KXgu+ZpOewEE7vrUqZYEYSfD4Q6jMDoHhEPR5A9VOUxZag7qvPXuo1SUICJyNyX
	 n2PtTZBbcwfIuMafRvYpanTABdZU6LR7BKK6eXvTFW0wC6qBFz2v5mA79X23wL1jBX
	 DP842Z+qYP2p+5IsRPuiPPjsJbR5fqR41ST945nDrxdd4/QP2bos/R9exh6auEc2r8
	 r3PA0fKBxPZPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y 0/9] Backport "af_unix: Drop all SCM attributes for SOCKMAP"
Date: Sun, 19 Jul 2026 11:00:23 -0400
Message-ID: <20260718192718.0009-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717172922.3398851-1-heiko@sntech.de>
References: <20260717172922.3398851-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series backports the "Drop all SCM attributes for SOCKMAP" for
> af_unix onto 6.12.

Queued the series for 6.12, and picked up the fix for 6.18 as well,
thanks.

6.6.y/6.1.y/5.15.y still lack the fix, so backports along the same
lines would be welcome there too if you'd like to extend coverage.

-- 
Thanks,
Sasha
