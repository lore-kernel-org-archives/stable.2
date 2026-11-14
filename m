Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661780;
	b=lLLSAl9RKg0T3QYHhWLBSLzob/xyH+6+82JZpiDl/fzQnDHgSLKKm1/J3jHQRzvI3fVC
	 x0VjMtA3KaOWsl/TrqBKjtnVujnKL3RjV/uC0gzotrXw54gZ6JVeXa/3ZcuUp5tjYU2Yi
	 iQWr+lbajFQZO3VUO4ynLtVpx+JIpXDQOgUhwoc+/M0P9JlsDrQbeIFHq5BLASSeK50xk
	 s6NRrk9Q+yahebPUN+7el/zzskxKXvKGS5evx/7JCZdRyDrrxOj7xjqKhQbLfMWj9GoLZ
	 VVqdytBOtUc2FHgBdr2uEq30i73CYjXs5GMOpBSXEow0SvI07tPFFDfQa6+IkBIX4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661780;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ptAK2PfuAn77oHZ/Ek1nHocPe/xXcFqzM2kqY1MBHQA=;
	b=3K89NKTkID52NC0TNx7vH69iIym3hpeVjoZ8kb5KpYqekp75sTiMWvd/QTfotIQ8fdQJ
	 Z2E0mi0YBwUat+CZ/JEHl0A9HP0/xBK2+iqcIou9zq4bHetwG9c8jOsghKzBzF2CpO/mr
	 pDw6rlNjf7Kv0HqEe4UE9z0E9YpvaJ4nIdaXqvqoDqwk2YSkiac9Dwxz5YhTWu4L+Us9L
	 q+WqkaI4DxINLvbV53RxdWmW8HgMDbE22DlWL6fGQe+tS9KUfz/n+/PTGhtvBp/BB8RM3
	 CM/mzT9Tx8zYwOKKqRSu3Ik7Y/VTPr0VLR9CYgLq40uOO5in5wzmtXMt0CpgHerC77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x0ELlvH+;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE8A6078A15;
	Sat, 14 Nov 2026 13:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE8A6078A15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x0ELlvH+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794661778; bh=ptAK2PfuAn77oHZ/Ek1nHocPe/xXcFqzM2kqY1MBHQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x0ELlvH+oI6lwYCLAelq+HYAJoM6Eg/3h2UoDlt9MbZ0AMmOXJW4xoWWsYsMls9nN
	 3k6gApyWj3cFlixEw3lMSCwOOoUca1cNyiiECuKT7q+P/+XGf9/qIXGAufobYZDl9L
	 Mtp5SYjBTqm5ZhM6q9Bhf2FH15G9bpQCH1ojL8q8=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:7443:873c:1230:8af8])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 25C3B2E4; Sat, 14 Nov 2026 21:09:28 +0800
X-QQ-mid: xmsmtpt1794661773tm1g0da2u
Message-ID: <tencent_BF4B5FE9E95165CF1734F65EC40D4FEB4808@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Jue+F2vLrGacWsZf+O1K50A2SxhzxbnblTYVisPlYosMMO9+GzfQ
	 KkU/rLf3pqY/SQG0YYi3MjAPAU+YHFdMvV2FPEbi1pZeuZoeiGo0iZqSFulBSgQT76JhT02EDSNr
	 S2HuW0ZteksJch8+czq8sNa/DWTSHuKRrtHHd3/zDbN3yoeEYtu3zkfGm7Y4MTRJFYya0jH/ZMeE
	 kC5369UlwjKaN46W127L2qf068duoUjmpo6GEb77X331rTnf94y2LPolmXWOSUwWfjx8CuLX6bIQ
	 jfct3kGfLdK1Gb/Zez8p/aP87RN4v+Pn/cvmJzv11pyAr/fRFIr/4cVHlURDWHStAQxUyqjwfhU7
	 I5xLPDEQingaftMvED1PPFFpI3v3223l5czpKauufO2CmyD83+SzCYelZO9h0WUlCqQ0aF9kZhb4
	 yzPU3R6WxpwxlC7duKwhE/DisUN3/5s8gGd8XgKgpQBgvn+tOq4NTACP0kxc6C0S7mJPUDxsCQKd
	 VX0LOqLJ9E5AmBlPMTut8fmtco2ndjI/v2Y2sheVz5o75DIM07gA5MhmtxaPqLzPcyzo2MZ0zliw
	 3ukgTPLDwBkOR1d+YVDO7yJvdrZE1+YmPD3L6PPE5ehkzO+HILG58y30KOIzi1gMjP9uUd9Mr6xA
	 A2qy5yWnUUiAHv1mnPfFsYQV+Mlxrl+dgD3tMsUO/Dfvhq3w/02p5BogoUiBY/I/yaEoW/KNDERP
	 bRsRqMuWNf9lpZvC18FCGwA0iAFozQEFm9fuew1iqRG+wEi1+UEJlffPJpwAFJyi508tSUVSraCu
	 ImDFXmxe6f124UrdPvLr5z9tx6jSt1jiveU0ElG1hWQrogWrX+DtPUpZ9/6+ltmH+j/2xZL+B6bU
	 kqOFssgLN3iPAlKAR/J/RSfMCkuShrj0t5AcGLHbZFvDs/wHPZWBAUNRKubVHWmNAWVSHpOQu2lR
	 tWbdW1SY2fVIQaYs8XCn0LMsDJcN/vQAAsHcFo848vkKE3qoVUZdMU7xx7lvdDb+6B1jzjXmSJbL
	 Xi+c5rz8ZBRHIl+7kuzPWyjb+jbOFg4Z+et97GtqaAl4Hfl4Ry+7EyHAzn5pUWGpQ6hVYLKe3PTb
	 T8lOXM1KIJmjO6EGRRxld+yuhS2Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v3 2/4] net: core: take the reuseport migration reference with acquire ordering
Date: Sat, 14 Nov 2026 21:09:25 +0800
X-OQ-MSGID: <20261114130927.91839-3-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114130927.91839-1-2122295973@qq.com>
References: <20261114130927.91839-1-2122295973@qq.com>
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

reuseport_migrate_sock() returns a listener with a reference held, and
every caller immediately reads that listener: tcp_v4_rcv() and
tcp_v6_rcv() pass it to tcp_filter() and tcp_check_req(), and the
request-socket paths clone its state.  A listener removed from the
reuseport group concurrently with that lookup must not be observed in a
half-torn-down state after the reference was successfully taken.

refcount_inc_not_zero() lost its acquire ordering in commit fb041bb7c0a9
("locking/refcount: Consolidate implementations of refcount_t"), so these
subsequent reads are not ordered against the reference acquisition.  Use
refcount_inc_not_zero_acquire(), as was done for the established-socket
lookups, inet_twsk_purge() and bpf_sk_assign() in commit 5b5d8f351dd9
("net: restore refcount ordering for lockless socket access").

No behaviour change on strongly ordered architectures.

Fixes: 1cd62c21572c ("tcp: Add reuseport_migrate_sock() to select a new listener.")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/core/sock_reuseport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index b9e5648fa4c5..56230aa55a3e 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -667,7 +667,8 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
 	if (!nsk)
 		nsk = reuseport_select_sock_by_hash(reuse, hash, socks);
 
-	if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_refcnt))) {
+	if (IS_ERR_OR_NULL(nsk) ||
+	    unlikely(!refcount_inc_not_zero_acquire(&nsk->sk_refcnt))) {
 		nsk = NULL;
 		goto failure;
 	}
-- 
2.47.3


