Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624979;
	b=5ooZZdVyA3N2BRlkXBltcOUnmk1EEj7q8u5mJ2wt2jrZh9XBEzf83MjBv1tX3UP0xmDs
	 IBCbOdkndxQFd0PnABizddYoHwcP+/cj3RUaS5P2oO2iyg03hPds3kpn+Kdftjp7cDgvG
	 zOCK4e6nTgvseaxrWzgYrSaFkZjQLfNLB8uRUjlnjWqhoflt8gP/UoChrMnc/YZCaNwkJ
	 ZVpfAiA9uIoaUc9TmPbSxCSZfYgTucd+EEta4oqd8j8IED+8GWDS6hJSByjCQ01ab729M
	 vXB9iwkHqKO2JOSzYD5UO3F1PUVKmefNqt+DmiaqPXalqE3qzocVvR9ew2RrykBXBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624979;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=f1aINW1+7Pluiq6f9Cr7hMHt7XiB2jT1yfV2lgVG7PA=;
	b=LV6zP09D5dL6gd6/5i1NWCr8P0933x9eCIHsr0JQldOsE/wIatjgCocdFuU17WMbSEal
	 nFPE/V8skb6/on/478XFWvA4IjH4j+3srSnmMwLyLc22G86m1bkDnTLpWN3jUhYZc0dXy
	 9zAR2NPmDtvcZkPDBb9XhhQ9WdMSiQjEK3onWNsy/LFMzSICHpSAObecz24vTjrnPNi8Y
	 og3r97Emox6OBkBQpfxbGG+VNPRUN03Ew/90Nlg6xZpblcUMomD+d7zuYVWyvzj6lE9Hc
	 63BHHr6uqauNdaGBSaqYq8lAdJ7/uARFxrltyM6KdxPo5CVbqCQ9H7nkBcoiy9lHipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BNDhZP8R;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B888606A329;
	Mon,  2 Nov 2026 13:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B888606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BNDhZP8R
Received: from mac.lan (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7741120B7166;
	Mon,  2 Nov 2026 05:09:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7741120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793624964;
	bh=f1aINW1+7Pluiq6f9Cr7hMHt7XiB2jT1yfV2lgVG7PA=;
	h=From:To:Cc:Subject:Date:From;
	b=BNDhZP8Rb3JGAm0GTwJ3l8iElEL8xjpSnQYzfbyAW+pmzgg0/FMvgInpjDGBQKWx3
	 nDk4i1+KsyUsnAQLgT+IkQ5h7yb0hNdHwwdyWFLIMyVvV9TdKGtUoz7c+zgTCCqi9E
	 hO5tOxddTVeAbQnZJ6xMMqnGW1tvW+3a0iMXWpIs=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net 0/2] connector/cn_proc: fix listener count and socket state cleanup
Date: Mon,  2 Nov 2026 08:09:20 -0500
Message-ID: <20261102130922.75629-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent bugs in the process events connector, both reachable
by an unprivileged user:

1. proc_event_num_listeners can go negative because cn_proc_mcast_ctl()
   does not validate mcast_op before storing it as socket state. All
   process events are then suppressed for every subscriber.

2. sk_user_data leaks and the listener count stays too high because
   cn_release() frees the state only for multicast group members and
   never drops the count.

Both were found and fixed with the assistance of an LLM-based code
analysis tool and verified by the author.

Cen Zhang (Microsoft) (2):
  connector/cn_proc: reject invalid mcast_op before touching socket
    state
  connector/cn_proc: release socket state and listener count on close

 drivers/connector/cn_proc.c   | 23 ++++++++++++++++++++---
 drivers/connector/connector.c |  7 +++----
 include/linux/cn_proc.h       |  6 ++++++
 3 files changed, 29 insertions(+), 7 deletions(-)


base-commit: 94cea342e8915812b45f93c56e134041c7fdb4d7
-- 
2.55.0
