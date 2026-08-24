Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9857377AB6;
	Mon, 24 Aug 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590148; cv=none; b=ZCny0rdh/P17xCDBucf4QzaYJDl49sX6hvIW21EtrFMiVXx4qf1ZowpxBMv/Ez+RMMyYRI0/un3Jh02CpEu9p0YRZYfP4f4ppCrsIn4ppHArOoUEYYCjcaZ6lP0dahvgZBUck3pQn4ELCSD3ZGT4mAvp0JaaS9/VeGPeUMt+fag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590148; c=relaxed/simple;
	bh=YFylSvvgBVNDRcVxg7NOMFhIOkuNvjs1mND2rsz75Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvBisR92pcMv/NRFg1Zyn7XoxKMCTtZMzAi4YLrzM6tC8xdtY7xG2Ayldc/0wDZ+CTaFhRKu+VJ7rgBHd8XE8ETKZ+UjfaWiCSSzJXwRHV5SNMQ28R0p61vqH4w2wC6QiXyKIkjPAi+1HqgVxjCZJuluuoiIuePuBwlfQeqhD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ7VkAi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ7VkAi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D91F000E9;
	Mon, 24 Aug 2026 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590144;
	bh=x6P/eBi6yTWWHYbzFsRgX5z81fY7BIwf7GDF+vIGFhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jJ7VkAi+U1JJHwTtxftp9W6OBIeajIcX/nq8YZ2KitSKqZw/1rcuIC6g7UILpRA29
	 qnWTTQwwmuf2YpXppPvNO0t+fVzs8J9wAe4BlTZMxdlQfkwZMlZKr9VKSm7QNySwMv
	 Rnnrkgb0ylj8yoqDTy2EYK65N4iHjjaohM1obsBtDz0ehIna7bGFo4c50a/tz/YA0i
	 HJ/yUjnj3yoiUNfDPxWMa/2TyMTWbCdFcsgb6IM1EyD6Kiudh/TMUI0WrK9osKY6GR
	 UCFr49c3Ot9loJ4nOp8R0IXDdPkcSw3n8U4TBQlm1cmJPGgkKJ2xXBdHPswdI3FJ4W
	 /guq7wQtOZQ9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:28 +0200
Subject: [PATCH net 08/14] mptcp: pm: reset retrans_time when ADD_ADDR
 entry is reused
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-8-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Kishen Maloor <kishen.maloor@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YFylSvvgBVNDRcVxg7NOMFhIOkuNvjs1mND2rsz75Co=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sh+xBcWnTO+19NNpXqF+b+K8yyu53h9SOFLruvnWY
 wHdydtsO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyZz4jw+4HAZ7fze/mfJGZ
 N8nmzOpb29ecYVF/+Dx3uoVbT+kNvauMDA/9hP8buK14q37ux9YijaIXtzYkO7dN1z759ava/jf
 /DzMBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR entry is reused, the timer is re-armed, because the
goal is to re-announce an ADD_ADDR, and eventually retransmit it if
needed.

In this case, the retransmission counter should be reset as well, so the
re-announced address gets its retransmissions back instead of relying on
what was left before, and possibly not being able to retransmit it.

Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
Cc: stable@vger.kernel.org
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c5..b0b71adefb8f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)

-- 
2.53.0

