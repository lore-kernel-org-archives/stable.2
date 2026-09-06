Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA53D5647;
	Sun,  6 Sep 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701661; cv=none; b=lXpazUo3uwOKzBXaFdCHU4St5X4jpAJU4YAzOWOtIx1vAe4RAHpS/MwEdyeLVhdFfZ6XYeo7LDrKLAL1wIaD1MChdMwCOEOhFmDHixMBeMyQTXFF88GXUxZa42I9BAXxAf2O9nAsyuXPydfrtxiMrbcf9atk80XXD0X9E/D8l9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701661; c=relaxed/simple;
	bh=yGZ2b4/I92LY3NojNG3JFWKOdDEdGIwNd/V1UB4m9yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCXopaMv2wUI6ouURuFOot+/wui+yZh5DC0uk36TTYwCHMi1jyihxs4ISyA472eSeNvlbHfXk0v55Ta83u/0RZ2qr2mApJjJbWFZTjt+AV4DcxufGVwbe2Ta3HrsIb/o+67qTpXHf9dw9Mhbs/HOuhI2eYHJSLAGHflAs05buxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i45OGsWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i45OGsWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ACA1F00A3E;
	Sun,  6 Sep 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701654;
	bh=azucrmYpARUvoUfk9mDRH5xbntyKnSIKyTPXUjGk5WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i45OGsWqdy4euSHczyhBbYe9CKjXc9/5/9umXeXZeIo2Fd+DpXVd6d6zWbawkVF5R
	 1p5dloxjqHNKFzjVRD2RdtqCTVePdOjtf5HcjJ1IfkneMSXm3YfBKD0Z+0BUytu8H3
	 qDWE1qa4o3NsTO0P4yTNf1KPMli+dzHAfb8ZZu4zBMzVebONe+3Ts+U5uT6PFEvOIc
	 OMuvjJTz7Y9g0X8r4wX/aOo+IcMLlGpYxLpqtcW9vM27oQdIQZIjdn3nCbuHVvs49C
	 H6HlyCOz+7RSHpbX8lBH3jJJTt8rjMXZkl2bhwo516jr426/5aa5UxrMpv5krE5H4Z
	 s78OwHpd58OlA==
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
Subject: Re: [PATCH stable 6.1 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Sun,  6 Sep 2026 09:33:16 -0400
Message-ID: <2026-09-05-daily-reply-0046-tcp-syn-recv-race-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183500.3841094-3-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes CVE-2026-43198, v2 of the earlier submission that broke the
> DCCP build by not updating every icsk_af_ops.syn_recv_sock implementer
> for the new argument.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
