Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6553230BE9;
	Sun,  4 Oct 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131420; cv=none; b=rSYtFyatQ+goSqv/QplV621FkKdotABImpWMAuqKarYDjjR2bsINHy3k8cDy9Dl9KZmAtpp4W3YC14jmIs2LIo64ErZOOJmL2LyLPaAbXb0zigUi90EzFNtdSjHGPZNeMDAI4u0nYf2vQFq18TPVEsUPw7AflbEluf2UMPTwrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131420; c=relaxed/simple;
	bh=vjoH8uxTlEFA3Ofxlf/fUAqZz+LMf9eeft6QBgcr7oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSPR1XIly05Df47q7GUBHIm+rMfT13uyWroh3TfSh5ipBinAuEJWX6Intb0OpCkIBAwaPQdglk7nqWwQpVLDGMhrjPfErJ79Qtey6syCCF7dgHswFRaIp4OUTWnTOWupoWj+mwVSSj3quljAKtFtBFu23b4B3ALtg8BgUZOkzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbLlbxnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbLlbxnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E41F00893;
	Sun,  4 Oct 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131419;
	bh=MXTzGPw3PKVNJiwd82nxvwPA6v+axfBGoLDgJi7kSo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbLlbxnTcY4gwl/qhL9ho5Z686478kThIbK/LQp21188l8WxSc+Sty1wKnidrZtTb
	 AOwUxvwa2/5YSAx93roaPjHQtQmst9JIGc3OnEeMVJA3VEX6PzrWm94Gt3m1AkUCrH
	 qNEl5rrYfgliaQIpWhVTde9NoXYiLU0ZoHuRs69lu+aOa3Qp/AgqhrAaIxi5VqHVK+
	 juwo5DNjcNTZDy6KLW7CTOx2CMpx57HN8vk4Ank4LkwAnYuyCieGJg5b/j7FwA8BsL
	 0jDs630490dkqUVcMAHivACixzpF6jzbuqt7URkYmvC2uS3RtNJuLcVx5gf0H+w7TG
	 muxwZXjwGxEBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.12.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sun,  4 Oct 2026 12:29:47 -0400
Message-ID: <2026-10-04-1-daily-reply-0009-damon-adjust-quota-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003154616.22092-1-sj@kernel.org>
References: <20261003154616.22092-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature.  Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
