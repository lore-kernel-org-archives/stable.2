Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475373;
	b=J6yg1CMQsknxIjnXFqx3NHZiKJ+CEr3/Ljomp55/DTUzWCjbnxmPPSaHEIEB3BVTGdia
	 Oy/pjrT4SouMqYjtq2bJL4nk0fppjpgGqwbZzOTYl5h4jLV5W3mFPGQp/eESrINb99BcN
	 bQE4evJM+nQbhU90DidBQ/GEgBZ4vjO7hFGAAFbedodwu2e2OI7gOTfLkB9xIXXL3pLj0
	 N/aNxz6ZhKsiXZL0TCgxNBO+AygHpyrYc27afWnflHVuenGGvEAo8HJ+kFd/VS7f9ZHro
	 JKpxcdatsrlWmUBsnnzT10XLltnSjisbFCt/AOgt8TqQVGdwztBkEHdwMO1JgR9nOgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
	b=uuPqm4TDzaugFn9637Owxkd2Fdh3Nck4QdZnaz3mTE7tGA58R+VdvBIhcoKTPaBT3g7v
	 UeshTlVhwiUyS0RzOeXykHKBx9XQRFelfdB4A8FmlxRhZ63ieiYDEvf/TpyPSbajuEeuB
	 I6nh286lt/ZyqkgzCcVk0UF8Wp0f0iKJaWWKmn5p35Qscf8qRWO+WmtuXpnqw0t6WdQMi
	 /0HVPxO6ZqeJ6MXGx9s4aB4FVoHKLdCkQpN5UISK36RXYn8LxafYu5UTryxgIx1uDGaEv
	 THzZ2Bzx56mxf+qTTiIid/56Prw+I/HgB+JjE0KiCkjhGf+Jyy8N4oljO2DhMrhqtOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XImFTfsw;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52689606A327
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52689606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XImFTfsw
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91befe703c4so17486866d6.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475372; x=1794080172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=XImFTfsw0SLwJqjGHU+fV4jK1Pitb1f2YLQ4OV5DYmpH1j0ONA2NwZptddo8FuYy7I
         D2shw2sErCs6c/bYUjzUrIdCefLv4uD8HxQGWFYshionn5tM2jrb4bVS/PyICOCIK6m3
         K2gb7eFXNzA8+TEDDD+UvIhPl/UxhqO1kLLxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475372; x=1794080172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=DlPUH0zVhwJmEoF+nh+vy1o/eVEMRkS8e6pliSOGvejfrOcSAzYPSE1ehLuMgHMqhF
         MHlfGr6DanuCKgbz5UDFqO34UES8LkNJYcsKeRqDShr/RmAUXQDTH9R4XNlufRr9HoOX
         UyVEw4yuWNE9vksrg+ZWeob7CQ7MEDgFsArSo9T2GaBVDQtcoKW1D09HbcqNIF/b7h0x
         tEK0b/QBA7gLLTESWSQRMthpf+QzFqtksq9HnYjW7cqyvR6N733WXmfICn8Gy6Uyx7sc
         yfL4FJI+WvTs2VGbDy8UxrQHW+zP3/UuSV8Yq4DWEZE6Ftmn+WambkE7KvihnzdjOEB6
         ydJA==
X-Forwarded-Encrypted: i=1; AKwUvBwodoLPPtiQPLBsHoDy6Ojj2D66b0VPmtjsF+0U9TiB/NjDBrwxw34MVYWpBZrs/njUItBMGho=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZIgVJmFuXto3Tc9SKgsxW4Tvl8SQbqY1I2GpK4TY9z2AOPa12
	l3OaGqHza/X6QQxujWh3cR2yUWJHnlJIp+rqVxlbHwVDD6aGK6MVRyQ9RJ7Pp08YCQ==
X-Gm-Gg: AYBFou0Ejl1TEhnYAPu1qOixVGi7qac29QTbHqwJ82d0AnzmFfonPv4HuMWw3Qa8WQG
	J2bHcJy20rWgD3/8aqUoCuKBBqI3RcdEDiynLmcfQHQI5hH9x4j4qGQaJLlnaBpZz1nObHPEuRO
	icCiGlIY100KB6IPEEslFM2FBfGMalhZn0dkmn2vFPfv+htHx/zoa2LPkuiguVxARP+6TS1jgbW
	gyyXNj8cHuGZfQs/ybTFSDAYDIOu154XC4ZzgsSWDrvso/IP/WnvaGwCVPAP/i6bQX0nqD/pQLZ
	YgZl7l4YwGYDumm+8pRfrl8KwbszZGrPVs/iXooiE/Jao32wpQ4oVe0Uquk8rFClb/UmSogzVqD
	Ehc6vFeIZFthCDKOxs95uCSjyBjMSoICxqGLnhh9DDNCguUPYPpFrNXUGxspxilsto4YNjhKgCo
	qUhdWIXs6ImwTmzQbWjzzXUpbEqOYeu5KbF+SlQlTrArKYqLT2PJ5SU+pcT8yNQl+xMMsIWqsGe
	1+WiWVBIfK1BN8O9GKIPgf/crxJmmiqLQQTlOWtbMM4Z8hw0usIVj1MqHzblNh+ahUiVy3rGR1A
	9qIid0hvLNM3ZeuZPPEBLF3/H4RyA55LrfgdjqwvKZSLfEUxvUBUYDdvPQJcgbxkEhLO2Goq46N
	h2ts5MCryxpJSQo4=
X-Received: by 2002:a05:620a:8388:b0:943:faab:aabd with SMTP id af79cd13be357-944216c608amr1010302885a.52.1793475372306;
        Sat, 31 Oct 2026 12:36:12 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net 3/3 repost1] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Sat, 31 Oct 2026 15:36:00 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The issue:
The teql master devices are created once in the initial network
namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
teql_master embedded in the registered sch->ops and uses it without
checking whether the new qdisc's device lives in the same network
namespace as the master. A qdisc created in another netns can therefore
attach to the init-net master and change its MTU and flags.

The Fix:
Reject a teql qdisc whose device is not in the master's network
namespace with -EOPNOTSUPP and an extack message; same-netns teql still
works.

Initialize the private skb queue before any validation so every
constructor failure path, including qdisc_create_dflt(), which resets the
qdisc before destroying it, sees an initialized empty queue.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_DUMMY=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
As an unprivileged UID, unshare a user and network namespace, create a
dummy device, set its MTU to 60000, and add a root teql0 qdisc:

  unshare -Urn
  ip link add dummy0 type dummy
  ip link set dummy0 mtu 60000
  tc qdisc add dev dummy0 root teql0

The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
on the same device leaves the MTU unchanged, and a direct MTU change on
init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
privilege is required. With the fix the attach fails with
"Operation not supported" and the init-net MTU stays 1500.

Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace aware")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..55f9944ca47d 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -188,12 +188,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct teql_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *first;
 
+	skb_queue_head_init(&q->q);
+
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
 
 	if (m->dev == dev)
 		return -ELOOP;
 
+	if (dev_net(dev) != dev_net(m->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
+		return -EOPNOTSUPP;
+	}
+
 	if (sch->parent != TC_H_ROOT) {
 		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
 		return -EOPNOTSUPP;
@@ -201,8 +208,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->m = m;
 
-	skb_queue_head_init(&q->q);
-
 	spin_lock_bh(&m->slaves_lock);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
-- 
2.34.1

