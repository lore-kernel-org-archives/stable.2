Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53835E1CE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692789; cv=none; b=OKzPcpoOf9Xu6IapmFl3COnkL8Nj6wRsMzhLsWcm0TrROTCPPCelgGWsK3FkVgMtAaN69Q2NE7CnWTWmSWpkTjbV4kaBsDbUb8hkP4W0qIeu7/uZo9boCn9C0SFwBKUPROfKlHVFaUx5dMrTV0kGJdVIjOqIE2mrNy7IZ5BqyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692789; c=relaxed/simple;
	bh=S1TulxVZsHpak9reVnyoQVLsWhLRcE1B40Zwdz1KSbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKO/tVumaSdHtoUIx3dPCdkV5F1mSmHsaVhQbhGoQQcKIMvTw4rW2klGifG3Kpo2LgzBCiNa8qDaFEBjCDWVAsg8d2qZrd8xwYOujY5cN2KET2jPQXb/HBCW+JimJlSqiwrgBDfh7+z+VOS0clv44T98zhEeph7ukCAfpt8hzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDiqX9v7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDiqX9v7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5A1F00893;
	Fri, 18 Sep 2026 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692787;
	bh=Q6349h+ZJcwrA2/2AuT8A8FNJvL+asmg8OaT55w7UsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDiqX9v7BSs6VjOugArCSrJCtf+5yMWFSwZYFCssn/MmM2dADe374O0f4vnMd0Ggq
	 izJ3uqVlEH0AjWGZ2b91RWQtZme/72ptb7ooL+I0lwDdNOafb2acIl3iHn8JaEfozk
	 sQVb8TbkbE6IjSHsoJvBcGwUTwfhyJn7WkstggwidMtN/Vq21BMqdm/cmWCH0eJ3C2
	 Mod2D/inLx6X0ywqWQIxp7F4niBsjnj6ZAMYqqjW+yGBFO7ITLomQ7SiBIujoEZta0
	 mILvPimqD2B8lQWrBu6Vsmq1byBK9VjkkaT8THARxisoa2QCNos0eNwc7HIfbV7tpm
	 1bG+qTcY5aGqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Greg KH <greg@kroah.com>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	gregkh@linuxfoundation.org,
	kernel test robot <oliver.sang@intel.com>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH 6.18.y v2 1/3] selftests/landlock: Fix socket file descriptor leaks in audit helpers
Date: Thu, 17 Sep 2026 20:52:41 -0400
Message-ID: <2026-09-17-daily-reply-0014-landlock-audit-selftests-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eef8034f2f40b9a452bf27b3f9809067bfb7c5b1.1789655724.git.mic@digikod.net>
References: <eef8034f2f40b9a452bf27b3f9809067bfb7c5b1.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 9143d790337a0d066c2d632c802f69b981e6c23a ]
>
> audit_init() opens a netlink socket and configures it, but leaks the
> file descriptor if audit_set_status() or setsockopt() fails.

Queued the v2 series, all three patches, for 6.18, thanks.

-- 
Thanks,
Sasha
