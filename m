Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1330FF2A;
	Tue,  2 Jun 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402489; cv=none; b=VHVrgLPRQDqHGsJsm+JfO0yXbznJx/l+Ss+rzWCdkjB8cEfOJKB/kJQITQNf+bB+NrmBofXHfNNC42ey0S82jG04k+Dzzhk4M+BY2hTQA7MNz2VqpPDtnxbVoAbTmDh5qHB5qhfIJ/4GIqEN7Zhr/dK3KB5BQB4yOSIBy4L/FvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402489; c=relaxed/simple;
	bh=rkQBiCaZv3FLsMCB1B/qXFTAapBqRO/jjIMFsa8uZvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kfnz3BRzyjEQ4cTutO1XzfhEHaMi60tKYYab3Ei8jUoTga0Z30gBQ7GEQnLbvEixlRi67bRoYxb2lvOf6bbqLX4RPsQ35P44p1euOFXCkz/HUDmHvkLQwOQbUbLcN6yvqYtdjlFWJ0SKD+wNDJ5a8n+VVwkhxC3cHlhExfYD67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr8oouv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr8oouv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B74F1F00898;
	Tue,  2 Jun 2026 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402487;
	bh=8up5MYwx4EhVVjUDefYI07aSVy3uzwumnDLm7oQTWB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qr8oouv4dNKcKjpjri0nxbW6z1Vo8+ndyJ+hGZuPnT8k6/jo7NPKV7MoJLDUwLRm7
	 xQEsw8V6QKE3/AwsaHp4Lujb/duvgu2+v9tLkXm1GCYrmZKZ4zmI095C8srw7xeWDm
	 wYIe7LZMKfSeC+nxudjqxkB2o2vZfpZvFYTgSDappsq7LphLf0BhJpfoqTvxefLO0I
	 RM3aqAtBAkwUxlqQCBRPrlnLTQ4dAG8Xao6LKFVXVPO5Oh9t3F5HYDLZVPsy0RO+85
	 sr4kIErvZkc5zW0Fwsyc8Y38kakOaQNv+Tsoxydf4BXXtAETfTnkSRi+/bqiG0pcoT
	 czf/VhfZfYxug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:08 +1000
Subject: [PATCH net v2 01/11] mptcp: fix missing wakeups in edge scenarios
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8bYMyyvhQFOSZqNFT4QxJeSNWbzfPC95/VwNPuygVVk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksQ67lkTH5XRM3T3lMPHAJFgRuZTsmQJlqO
 DuLz9eZ/96JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 cxiuEADrrwdslrpmxQDqBrLmqjh/TBxh4T4YLysTxsZBUsbOODlADtJqdH2q1iLScEmt5ENBTAp
 a4YOR8NzjfELOkVBok3C1BU4G7cZwUbIrFmQ6h+lb7+1bz2vlW52WOmyv/4ZGfYTtAOZKLO4LCb
 Pm4/Vx8acKZDkYlGOR/hN4j0b3qO0fi5D+Qpl99qzLgolLZLPIqAANB/LB+7H4R3G7k5LMrFx0G
 3sjmOfXTenSRwpda3xh8XXF0QKimG2vpwQbqhvIKDQqQP4VqxsXMeqpU+9Gnks5QSQowdAocZnw
 VvxEOPexEokxP4+rrCWZbcul/6Plu10GOgBsIQgNrOuj71ownyF6rZ7ir+MfJOI5/JE2OO4Fhal
 kFmD/gybb6Em/N6x7XeOh4IPe1UOF7K+wXm57ZsV1PKf6n9gRV8b4JyXFA2O3ra/dAjPHda04df
 I5lYv1WV60PgHgXHJNP69aDLkrd04KLDMmCB90ogRrLAHEeEbkVsyc90s/eb0qw9k2ltsaNhHLc
 DPO5+ZlmsrfD63K/z+gE6Jf++5kqES2ljVhNgMSkf4/WANxu7m77ggFfslOC9kMvu8yPBENT4c2
 EtRd85gBdWh7y6852oHIAs/E5hMhXYbsiSpMJdPPw/z8+D1JPjJzkXYSpcNYR8txCMydU3pK8/g
 dqLQmRt/AZTPfuw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b..5a20ab2789ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,6 +2276,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 	mptcp_data_unlock(sk);
+
+	if (enqueued && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
 	return enqueued;
 }
 

-- 
2.53.0

