Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653B36A02E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379230; cv=none; b=bQqdA/UI7Wy4tfsZQQDPfC0bD1Icsgnurg8SStuuqEUvW9Pyg+tktLYQEZU3BfNpxcWanDbbpiuf1a0O5mUEKCLtjOA9QNx1ox3/CZWzmQ90aXhpsYt8+FA37vcsheqwvOj0R41e3f5ktXXQo4e/cg1jEwgI2cMu7DmHF9+gPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379230; c=relaxed/simple;
	bh=WJ3oLHswu6ATo+MRj/KSkJQztDyeVO9AxWwSww1JaIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2y1GiIfe37NUOnGWn/jcISDS0st5Qkk4sAGx3q0WltIZ5aizVnl5qLvyI2FsnmXyXZ858uzJDpWLRSDbveGaabBNlriMGQt7rzRj81XBKBrIeBJ6wk5ubqjIIHpNUCKH5+Ur92AjNtJ26BXn+RvV+qx7BnIrerUsOcTvzjfFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqgjX1i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqgjX1i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DD81F000E9;
	Thu, 30 Jul 2026 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379229;
	bh=jdFOglpWW504uMJ/Za0gHd+5fcRAt9x1f+nTqaaM5Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqgjX1i0rKnQcsHjJ2VmSFGs0Kzpgru+Jk8ajvfevPZzBgGqztAa6MrsKiH2JQfWs
	 yTXJZlP32yuw1usDbt44fX/Jac+m6DcxEKDlkueS/uImfceZdQ3+1RWkrN7rDqwgmf
	 ComPAH9D2iFF0bSQWO4rKutnL6NJmn0HlopAwxBI7AEzY2NRX3AI95qPeb0AYmjaNO
	 wu6f9SWfisFPXvlWwSt4RrFyy++BB5ExpRfsSPpmLykInAUfCxWiW3sP0iX9LB0xdz
	 RloH5mjFzHPDN7JBODJuvecNMi5x9btOYNqRx2tUMhwdc/DLkzwzRxU11HGiZkwdtd
	 lO7vT7ajd7IUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 6.1.y] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Wed, 29 Jul 2026 22:39:57 -0400
Message-ID: <20260729223316.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729013809.1745-1-xb@ultrarisc.com>
References: <20260729013809.1745-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] RISC-V: KVM: Serialize virtual interrupt pending state updates

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
