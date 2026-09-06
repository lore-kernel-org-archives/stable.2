Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA13DA7C4;
	Sun,  6 Sep 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701657; cv=none; b=DDNC++lLhw2c5gtx063t6coxMzJGcu7/mlanO4kI+g2DIWvgwqDiH5kGxOHlMUiEPIgxygv7pjG7w7tFcravMpfzvIdNcE39BvIhrv4OpHLD8w1DaCzjB3YL3frdEoczhIBtR+7p+p4CGwxUrTrPxQvJ9iWv3lX85EEPjfU40B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701657; c=relaxed/simple;
	bh=1ngHckCR/bdyR8NMhlcnieS00dvtXTHP6AOzuDTttoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8FZsS0Xa181xuFFn6ug7EXXToiiDOM7n4fJeNGtGtgXSswVCmieJ85XhoMy9oB1wWQB4krG6sD9hwxQfWr3I89W9OKZkb7Al13DmkVr+/lYwhsNmE1b8tFKW5WD61ukd6/S5X2H83K/yfMX390iX+e+S0VyZ3zJzt9bM5VsYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoF2KCvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoF2KCvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8831F00AC4;
	Sun,  6 Sep 2026 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701651;
	bh=qBBdL3eMrqIT1zlDMRZf1WHy2Ze5qH8f03hHQdTOxcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GoF2KCvB0dx4kuBccNdzp4/3kX/nCcUiBURL8h58JFkaJVtkqJI51xP7Bv3DQdmrj
	 hTfVoDpZXdOR9S336FiEl4qWqnOrFjLPSuEd1CvUm+Nky/5ytp5zIwUcFgloQyxj+q
	 MMhs5ZHZ8J39VpusRbTvHt43oERiIBKqIxry9tH/7eXa6vOAumLIWb2Z0GPRrO1i6i
	 rl6vru8Nnd65vIecCeSu/q4sQrl657Fxy90lazzh3L8NpwkA0lRzQpvcBQv3glNsoc
	 QWLZfN8Q1ACEyiGZWkbtYbIJJ0fRljq43Zkg5vRC9NLDMo/wck0GYeATYV/QcZ4sBf
	 JdKAjxDMbxBmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	atul.joshi@nokia.com,
	joakim.tjernlund@nokia.com
Subject: Re: [PATCH stable 5.15 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Sun,  6 Sep 2026 09:33:15 -0400
Message-ID: <2026-09-05-daily-reply-0045-tcp-syn-recv-race-v2-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183500.3841094-2-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes CVE-2026-43198, v2 of the earlier submission that broke the
> DCCP build on 5.15 by not updating every icsk_af_ops.syn_recv_sock
> implementer for the new argument.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
