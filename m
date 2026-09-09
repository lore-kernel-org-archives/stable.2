Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824014734C9;
	Wed,  9 Sep 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985621; cv=none; b=jNXCKdoG8R2h+AaiALoT3BdJlZ0RatbujNFdVkcEnN7auWrCi+hKO1LLb6cEJIUvqEmPGqyp4jUBTLjllCJUpy238i1/0oZja7f1yr7fAxnlYYjdYHTRkHGnaectxNJeK8y8DFTkKmeXtNGZHF68B1A+bJOuk/6UMqHJGQ9JLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985621; c=relaxed/simple;
	bh=Af7KJ9j8BRT/zD4uefVhTYYRaSlN6Msh4EflnrK/ND4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJbYyPUiN67MixyaqgAwzhMra3fLCoUTpFnOa58dn7HoXgnKvBH9jCjezuTm7hG6stn3DIuQ+uFhiHUtfzg+dmah/ADB1q0kxu4Gp1wfp2wnofGPlrtNTMgEUOzZaeV3c8UbP1/Dl4KakAPPS+lKX+qSp+gWMCbieaA2fkX/iAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3okIe5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3okIe5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C164B1F008A0;
	Wed,  9 Sep 2026 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985610;
	bh=GsnPThnz+6Ykvx/D834v65GzrPDHUFlQhKGOUVHY8Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3okIe5NFOSgU8afrqbzzAGeitk0cPcuDwdrongZDNddXHougCK2UIjT700QQHr2t
	 Ge74oMEHIJfZgEx7bX382/0dRy66H7XpN7FQEYgdscozkiWzjlnwqMqacqHhw51ux3
	 vhp9WQ20nhPlpi4P/fJD4y++V6115PeyDljFCTa7TA4C/lE/X2hy+EAWHuuviNDglL
	 YZfFTK58sJeADGphCSqaYm/69XIzTeEZuMpufPCvw8RTwTX5TIixwXzslk8zLq+IfI
	 sug1JjOCNdVfVssgXQ01qEsniKiPEhZtbdZ+YpEFNNmvIwkL8w4uCsJPu2vQDUYydP
	 DKlbXVhALBacw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Wed,  9 Sep 2026 16:26:14 -0400
Message-ID: <2026-09-09-daily-reply-0016-damon-paddr-drop-optim-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909054255.253652-1-sj@kernel.org>
References: <20260909054255.253652-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It can race when multiple kdamonds are being used.  The problem from the
> race is doubtful, but the gain from the optimization is also doubtful.
> Simply drop the optimization in favor of code simplicity.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
