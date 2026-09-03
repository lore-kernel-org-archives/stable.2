Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6C3C5546
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424529; cv=none; b=BvcGjsPOZPQrZ5+IlLBBWvVYU8bV4XqTkkvONYJr3wWOWS5kSRFDa14KVD4LHKk6Y1lpXZIbF7IB5Se8su06MoFTaAKEoo3D9svq4idKzWeK1N65l5kkYGpRYYNWrrPO6t8pnk7q5qCboMQplpcoTv6uyRcQmoWU3K4DSZLXJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424529; c=relaxed/simple;
	bh=DjStITYR2s8Pxf0tCTvMNBrFzY7SIq7O1NXLlAuL/U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQICbcGXld4xbpQq7WbZQitB0SzbZRnVJ4tVp14lgNh86r5T7QVsrUvCAmYdHaaxt9C43Q/ZwxqajTTknQtL/OeD9TDvImT0p7nvPJKm5X7UyaxjVuox0MY1b2xkYdmfZHDjFimpw94KdFECnkhiF5FTeJLWvBbPrySxJCaHwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0m9OBmc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0m9OBmc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so23410575e9.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424524; x=1789029324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYvbakm1Bwgdxf94CO815zX0bPm8KsoE2kOWQFAcVLk=;
        b=X0m9OBmck21pOkLB/p29B1PwqCPhFqkUO3p5SKoazEnJ+Dr5/6izKz5lQAUE+XXBZa
         IbvWgQiL+sWXRguzzrkhKbK4RB3mr74uN6Ez+RNp58tN/ic3vGAs4BBkbvI5OhrznAa+
         7YAfupZdlNaBDJAMhf+ley2aCvwELVrqSNkSMquhOwjTnhSUm1IUGNmZeBcduJqHIxLF
         EiY/AVQi3m8X9KMA+YuwFCSQI8e4/MuOJKJpydNTvOQzvK/ryiG/rFrm1l9Ip9sX5VDE
         SQKjxQ1M4/6lfINf+LNrNSnQy0Lj7mnrLYvU2mIjln99dNzL4Pkfg1rAUA+7P/gTBTR0
         rGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424524; x=1789029324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYvbakm1Bwgdxf94CO815zX0bPm8KsoE2kOWQFAcVLk=;
        b=QJvsI8xOjPgmVMhhn9qGGhyF15arXV3n182a8r625Ib4O20fROMTtwR1xDlZj+Jyea
         b1qKIh0bOhOV8cHubellsmUeRLPOzFUc/ajFeesBuhoNg2ZjkbLZ9hiigNX/qY4hiPop
         x3XQWSNE2u4ETHzqZGLKTobiIhncK2l1cNotHTpXS22XPfMP4Byu3L6M+tjC+VO426Vv
         adOfh2/v2mbwmtesK6WVkAtBCaKKaStA2R+2a66n+PhAgDWfCxD220TZYKpQEid7Byqp
         0Dt+WE8mXsQiXO9Azg2y+4cXaLJyHG2vqAxSKOLJNJuB/0wOz1kp81pKXIMO5bf2oitJ
         +Sug==
X-Gm-Message-State: AFuF++mTz3xoD8FQg373Y1VK2CSlZodIo/WqOTLKxsNYnoxtZDOc7QAI
	Cps9Gh8+WlxiQhZYO33r4c9+9UIW/aMLmauI7WLoLs+mA/wng4ljP80pcnLgwqn+
X-Gm-Gg: AYBFou2CaF0yZcgyOb2vP6/KLJ8Hat5cYDU6zewOGRs/4A+Ibf6wJXWuUTcTcZArxpF
	au4IwaSXrxEuVj8v5IWQff+4LLXwjPXlh6VkzhwR2cvUunmHVwpqrYpkHLBm0us9N9x+xkH/0G6
	9WSyoUUYkl/T5IZzphKvqn8ZMaerLg62hmlK1+D42ByPlAvcdEKKDsjUhz0AaSVX2fnWWPIXGNX
	sNtuBF6Y2yMuosFaZaONmewYcPLfY4UDGjBHCdOJDGflJUU495RF+I9kRVdvL1NtA4vrx6hacFb
	JWp+bQUBK468SqJixqvMwiJRu3zwQViAkxcPlXnCSNAWMeRDr39RL9JhakJJ+xmJ/4G/whBrFHc
	FF33wmVKJiv0Uq7ZWQx059H9U8sdIA6Qrz0FtRQHunGFGByU+YJJzaf/Ds8jtAE52FbGFVthS3G
	SF8eQ5gvxZElnPHmQPo4BKyrxfp+y0+NqUXNh3h43RMQcPSKNRJRixVS48NgvnLxE8lAGcoQKWE
	SZxenuWVL6VtoZ3u2U4LDdZvdZwNKICJVZN36tIYd39TrSOJ3l6/LlGPryMpB3fjTaZ07+Q2B+I
	KgXAl6UsCmV3WUAvRtqEycEYYpfe0UOUw7JQ5cpa6sNNvPRnEqKj9WR8TtWMhVtkBiF4NPqWn9L
	i8Kqa
X-Received: by 2002:a05:600c:630e:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49ce55ecea8mr189868675e9.3.1788424523511;
        Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 2/2] mptcp: pm: ADD_ADDR rtx: free sk if last
Date: Thu,  3 Sep 2026 10:35:12 +0200
Message-Id: <20260903083512.99864-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit b7b9a461569734d33d3259d58d2507adfac107ed ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done at the end of the timer handler when it has not been
rescheduled, not to call sk_stop_timer_sync() on "itself".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-5-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Karl Mehltretter: applied to pm_netlink.c and retained v5.10's fixed
  retransmission delays while centralizing timer rearming. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aee3a8dd9287a..89570f83f96b0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -34,6 +34,7 @@ struct mptcp_pm_add_entry {
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	u8			retrans_times;
+	bool			timer_done;
 	struct rcu_head		rcu;
 };
 
@@ -214,24 +215,25 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
+	bh_lock_sock(sk);
 	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
-		goto exit;
+		goto out;
 
 	if (!entry->addr.id)
-		goto exit;
+		goto out;
 
-	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		timeout = TCP_RTO_MAX / 8;
 		goto out;
 	}
 
@@ -244,14 +246,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
+		timeout = TCP_RTO_MAX;
 
 	spin_unlock_bh(&msk->pm.lock);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-exit:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -304,6 +310,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	add_entry->timer_done = false;
 	sk_reset_timer(sk, &add_entry->add_timer, jiffies + TCP_RTO_MAX);
 
 	return true;
@@ -322,7 +329,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.53.0

