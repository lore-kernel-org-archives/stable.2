Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624991;
	b=TcnxXSDIc//Uq8UYiLkdwuUt/qpWBJidRobljuYA9YV1PDPasDj5O1/D21I0N0wre+67
	 rq3z83AyYt65R0hLxQ9RxL6RUeeYgSegSkgJFBGsqymIMjLQbk14TkSYCFQ7KtQBhvkLB
	 FuhHKpQ2fQ0huwjzQCkRFskh4jCCgS1ZlKmKiro8hzhgg9Mw2iqvOFsaKePrCQkTYRS9C
	 Pk51lsx+U8bLuMEs3BasRr0+f+DajmS5LsJnB9RJIISd8+MVrQN1gOf5xqDS3+A2Kmz8z
	 WxqXrMZ2jvtDPHgLFpu+8Jy/ADTWbVT7dxV9fuT+BHsEagrSGLyDiwHtzSixMQmSuCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624991;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=41nOmbxrN09tLyKUIJQ74F59C4mN14LzKcygeV3dkjA=;
	b=MM/35gz+pwLvzhQNYTTJ+8GYyQrGNQjOfw8sVNcZFGpdF7FAupD9cgjQ8jfsxFWTlnRY
	 IffzOarWoEKUj+y8SsBlSpbGIQ1wRERzDKuCL2cJjHRJP/Q8zno7A1xkrPZSWmzTWnAQS
	 juqGqg9bJZA2KzrJQkUiV4xY7/lA/H1zgjBPor5Kv9kyQTE4FNAL/jn8w6zGRx30WnAlB
	 1YlnAHT1+Mgzgl5vRVSQ8qnwmJ3mfJGtlTCeUamejYH6eSoykn/lfMVmxESobvTI/Ub10
	 6p118C4V1tRvzZxH+gheI2u7EDOXxaChzDme41ZzKofPXu70GEs1PM8cOlCHBYPDoog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ahTVvF66;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71173606A329;
	Mon,  2 Nov 2026 13:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71173606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ahTVvF66
Received: from mac.lan (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 846B020B7168;
	Mon,  2 Nov 2026 05:09:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 846B020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793624976;
	bh=41nOmbxrN09tLyKUIJQ74F59C4mN14LzKcygeV3dkjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahTVvF66k7WBCEetA92cNrJZLxG4My+YA5DgaWqTMFYxX/Eorw1hLXhZU4/elatRA
	 jvvgUTvLBxKEowZ8QcwCtwN28MSOqDeYxtMNAkO7flomEzitxahFHsG4I1RhyApQph
	 tQCaVtPs4HIjXLEynGEA/K8dS5ApG3M8B+3X9kcA=
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
Subject: [PATCH net 1/2] connector/cn_proc: reject invalid mcast_op before touching socket state
Date: Mon,  2 Nov 2026 08:09:21 -0500
Message-ID: <20261102130922.75629-2-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102130922.75629-1-cenzhang@linux.microsoft.com>
References: <20261102130922.75629-1-cenzhang@linux.microsoft.com>
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

cn_proc_mcast_ctl() does not validate mcast_op before storing it in the
per-socket proc_input, so an invalid value is kept as the socket's
state. The IGNORE case only tests prev_mc_op != PROC_CN_MCAST_IGNORE, so
a following PROC_CN_MCAST_IGNORE decrements proc_event_num_listeners for
a socket that never did LISTEN.

Since commit bfdfdc2f3b70
("connector/cn_proc: Allow non-root users access") any user in the initial
namespaces can send these messages. Alternating an invalid operation and
IGNORE drives the count negative; every proc_*_connector() then returns
early and no process events are delivered to any subscriber, including
root-owned monitors.

Fix by rejecting an operation other than LISTEN or IGNORE before any
per-socket state is created or modified. The default case of the switch
becomes unreachable and is removed.

Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
Cc: stable@vger.kernel.org
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
The bug was found and this fix was developed with the assistance of an
LLM-based code analysis tool. The analysis, the patch and its testing
were reviewed and verified by the author.

 drivers/connector/cn_proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 0056ab81fbc3..4f613c0648ae 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -421,6 +421,12 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		return;
 	}
 
+	if (mc_op != PROC_CN_MCAST_LISTEN &&
+	    mc_op != PROC_CN_MCAST_IGNORE) {
+		err = EINVAL;
+		goto out;
+	}
+
 	ev_type = valid_event((enum proc_cn_event)ev_type);
 
 	if (ev_type == PROC_EVENT_NONE)
@@ -455,9 +461,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			PROC_EVENT_NONE;
 		break;
-	default:
-		err = EINVAL;
-		break;
 	}
 
 out:
-- 
2.55.0
