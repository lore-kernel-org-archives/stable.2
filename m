Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C522370A;
	Sat,  3 Oct 2026 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067085; cv=none; b=n1SouCNjQoAvmiYrSydq0zGTm73QalqivWp2TVntzANCXt1g1B4y2elM6m5/9qjGrDOKSwC7HTHIZVS/vT7u1h2WqJmO19a2elA/CPnmQvWEjINrdqtedkYEqW7z6FjCOqBF1gerFAfz8KvUyrOGQBGqPjZ4BZh/pQlhgqPw8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067085; c=relaxed/simple;
	bh=f8qZDCleoNbGsH/ygnMnnN6PrvWIPHNRoAHn1cvEOWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHhrTHolej+f600pNomVc2ZRZUlron0LU2+8HyZSksUYyEw4xrSYm3ZKgtwMvdm2kVJAF/COPRrIzYNFWDaqw44nthm2xrHauKf5kVxZgdTALr6x3jGDfQjLEdzj/5Wch/yLXksBv5bpvPQnI+067NuTCpErk+Krno5kDqGrghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI+Iy38r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI+Iy38r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1333A1F0089B;
	Sat,  3 Oct 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067084;
	bh=eBzr4YTPQUP3nF8hY66j2htV41vnUfMgR3tV5Q+OhXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aI+Iy38rn74cVT8xGzoTqmPC/lUxc5segDxqq42/o8tqp68F7df+cH9sxPgTVgvbc
	 kispNODRNEsiRpbRO+BeOCx3ESgMIKbeIHHLpHEJqe8oAoe1b/BbKLktn1es/7CM6S
	 CbgdwiO9bT7D9beLplFTLjaNPfI04zXzvgFnaR0ZcdsO5wnUsMkNUfaeudXE0Q0Kjg
	 67gFYcAKvmmPQZaPyECKSZai+mkIvhuCU682DW60r90H5n918P0RIEgW2hYVct8kbC
	 NPIePL7co75YNcxMaAKOMd2+9CCB/T7mfPOPbPd5twQ31WzOQ2adyJGoCUcTn/47h5
	 XSAk1blYyiQhw==
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
Subject: Re: [PATCH 6.1.y] drm/amd/display: Validate function returns
Date: Sat,  3 Oct 2026 18:33:01 -0400
Message-ID: <2026-10-03-1-daily-reply-0020-re-amd-display-validate-returns-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002193753.20239-1-artem@trailofbits.com>
References: <20261002193753.20239-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
