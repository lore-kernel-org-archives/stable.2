Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952693B05A7;
	Mon, 24 Aug 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571977; cv=none; b=DcxWNJMija4JhDTCUeJHgs5BCCV0TCt1yoj7v/Qxbi1ihLQLb8lRYTZAGnlPZ1jfYnOoI6oho2nhI/agthSbFddfM7Awx6lq/A75df49HLGUS9Evz+iMt3FUi2BichjTyr+6tk5ILpflp6hJ/Qd4nxMDKzQMudWHTqTq87x6Ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571977; c=relaxed/simple;
	bh=x6d/ND55smF2vf7Qpj2bDWwc6TViQwM7uPrKhikunqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gzyyi69YWL5Dgo5Href4YWWcJP4RN6osFuk/elIxNqHlGQASoYphFh/7aK5z7UW8XPj1lX14cCaWlX7JBopOfTZT8Xbvwd+6RpdlgsWCTMoHxRHhCvVZl6eMG9yCO1macVZqefffmIO2CSQIlfQPrhcNe6w/bKa/1nr+RUNjbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ejVyI0DY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ejVyI0DY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=cgKQJY4TKyZP/EbATGldDo68Xm6R6vfDjmgUvHjDlDU=; b=ejVyI0DYMVCNSBpqMz+AkdaU9O
	mGrLYpWAgpTFHPSlt//fcICTTtT74yB4NmBAMQwXNaIF+6gNDX5EVkdYjBh5wj1M7QrHGzH5a2qA2
	TeZkqUwo/JQ1ueNBbuSoitTfSWBEsNYsCKAcVuwjm2iUdhfm0sZa9vV/0G9Pk7XIh1STVKHsfYjUP
	GOHfwDzQmRHId7CnzjrEj2lK6DvRriOQXCFKq5hnO85BXPQEXaIdatqxDrI4cneO6mj7kF/56nooJ
	lxH7rP167e43BKFp1/SuryhX9kcy+3GYF5BaW7z/r4xBIfMP7wuR85pjHB1QemSKbv30zNVLkQ3Lo
	xNduQuLg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyT7t-00Ddjq-09;
	Mon, 24 Aug 2026 11:46:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Aug 2026 04:45:51 -0700
Subject: [PATCH net] net: fix spurious TX timeout after dev_activate()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
X-B4-Tracking: v=1; b=H4sIAO4ujGoC/x3MQQqDMBAF0KsMf23AhhhDrlKKhDits4kyE0pBv
 LvQd4B3wliFDZlOKH/FZG/I9BgIdSvtw05WZIIffRyTD65rabZYL9rdNM1c11BTihED4VB+y++
 /PdG443VdN8YFvIxiAAAA
X-Change-ID: 20260824-trans_start-557ecd4c8866
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=leitao@debian.org;
 h=from:subject:message-id; bh=x6d/ND55smF2vf7Qpj2bDWwc6TViQwM7uPrKhikunqA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjC74nlxXoWmn+yuLrFjBjMyZyOHhCYuAopiVl
 4+PEh1JML2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaowu+AAKCRA1o5Of/Hh3
 bUPnEACnW/WBuwO9xWNOjpdg5Kl2AVhsgSCCOM9S51G+vFrL/78+Rauzt6VzX3RgWPuOrigye9j
 rcp6v1GrdFNJg8/eIxsUxI/NjOiJVxtME7N6n9RwzKSNaRGYUB6xw8QbmSIJz9NZkbJt8I6owiV
 ADaeu/2LO6jjxeTRGIKtXF/xjibS+rIENT5lVSqYKxbwuaswzx71Kisi3y2VhzPSgQkldLUtOTH
 DvLpmxnAdN9DwHQMppM/f3I5pO7M0px0wwF/sGsyBakQy51aVm2WP7bjzzf1/r1f0nBdnqS2fwx
 GTT+jh74iqryd/MeCyeOnHKxABbsx75YNomLii/PnIBmgpIacQts11+dQj30WdIs0gSb5t+0BhM
 RiHmVvgWm14xGh3Xa/hSm8gjg5WJ1nYzYi20b/cGrFUA3a+k/Y8D0WDcuTk1jcd6RXHJ5MqJI9J
 Nr710+212/9vr1ArXIMXhD1MbBgzw+5eoi32R1Y3u8yH62j3ExDk8BCnWp6R3pMS887uGI4t4WO
 UtaX5PO3lXC2BJzyp1wV1JjEXa9/ZDZ1zFiCWajICpnxvazpuk25CLMknumNh5lW43iTaNPN0io
 E2dmzsgDKZMZGWRoYCuAy4ckmT50+omS4G2oHBTtf5Q9yua02QHfhtYKCnikz2OidpMlpfVSnZp
 Yt5GlH/4FZJQ2gQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

While debugging another issue today, I found out that my TX queue is
stopped for 136.07 years (4294907392 ms).

    bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 23 timed out 4294907392 ms

4294907392 is not an elapsed time. It is the value of jiffies at that
moment: INITIAL_JIFFIES is 4294667296.

dev_activate() runs transition_one_qdisc() over every TX queue, which
resets trans_start to 0, and then stamps only queue 0 through
netif_trans_update().

Stamp jiffies instead. A queue stopped across dev_activate() now gets a
full watchdog_timeo of grace, and is still reported if it is stopped
that long.

Fixes: 9b36627acecd ("net: remove dev->trans_start")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf515641..4539dc2c6d380 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }

---
base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
change-id: 20260824-trans_start-557ecd4c8866

Best regards,
--  
Breno Leitao <leitao@debian.org>

