Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1553CA72
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077862; cv=none; b=EJWrNKPE2FWX0aDMmJInwo9HZ/NEG1noYPymX8gGTCO+DmkEUs4wT1yvBWDms0Sr1U/eUfXrubndA7rHuTYS1/qAfNQIgwqZ2OFuF7gpLuq+zkUJwK6hmryu69nChBhPS6IVWKyqGrroy50MeSfgDgxBJOwpjEZ7Esx49xX99Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077862; c=relaxed/simple;
	bh=9Z0/S6ZmABrK+l27B5I2Z8yd1uEctVo+Rmj2z6kxKM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUsp1FsuR8FnHcSX549cbqlpHBXHo5+CMSb+lP/1y+cXlgqLeelmpzSj2/q/oJwtCMa60Juf9n+rLX8rBYwa87Pqhi/xOsHg9gyZ6l8xtZmfgE+eU9oyWINLFknSqzND/TcequadKchfnVvlG9hRx5BQBHtzOlVe8LY9sNTIMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fAZI3SPP; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fAZI3SPP"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5311edbc154so33106211cf.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790077859; x=1790682659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=fAZI3SPPERHKxgQmI/DGUMQH1VuMotPv+gSaFIhp5ZVzHOKJC1pQI4ws5VLRZEbNYz
         Q2UZrnhQFiRCmbx9FFMEkswIkggUl0M4SyEjB8paYTGQc2BRvXVB6GaFOZaecf/K6MiP
         MsihZJszrKZkDTh7QL9KcdE3Acl5xQgiei/aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077859; x=1790682659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=W4bUut+vsmwqRlgosSh583jWEVL5X27sPrJfauZEZpo261AqxdidLvZy9EP1G12zGn
         4MWQ91QUXdp2IxzGGNra7QKjd3dg5D3OpZK8V8aHIAtgaLrOUoZPss/Gauba9TOL4JX0
         wbGp+w3FXXDtJzwB/hyCB4KBr+en4tq9MwyI9YT05JbLGe4/AOT67Bu1MqczlnB8boPN
         SJY/+v9y8oymncIO/NDr26u5HG9ZMiDbCwZL3+7I7AOd8E6vrwA+IN7kgsD8BttHywBQ
         p6BteDmv1xS9ZD4Yn8IoQTrbSrKvCt7Hn5AJcX0FQ1+0Ep/qSvEYNT3vEwQaPImkSjE7
         XAxA==
X-Forwarded-Encrypted: i=1; AKwUvBwNMebzuLl6j8KN4CWasrdyI+nlitdsGEHnauUfZu2O7aMgUOQ1RS4Sh+Bq/O0sAI0+6ngTffQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nWxRbXJrwAAlssuDBbXbEtwEvXpvQJVHvKx3HrRiJLyPYkywe3
	wZOf/ORI3voHhPL3wxmBle7iOpEn/aou+OqOq1rt5IojjgdaswhXz1KBp2JVwjbiRA==
X-Gm-Gg: AYBFou0SNzcnoHHYaN1EGYOYFGOdLu9KSn04XDYe4EgF/QUcrI7jqmc9IVcK5i8OqJp
	uN9+878tdG9zX0fj0G6Wvh8xhOW8eiohwSFMLqYE+Pm5CEQuTUMGBaUh6nBHkFcu3jNiwl3zIkM
	yK1Ia2UZknzFf6SOwsOjzZfOlwAnhC9ZgFCzlCETMz7kXWl7hiFWZbh9AVQk50gJinW+M88NtIB
	qb0RJQzpZS1WZ1fV57vTd/GDuqaayadHBMgI5NAwNKOC1Lb1VNW/gmDyhZ0HmjSRdEbqcfigzMx
	vMxjOhqDXIniLwy1vM3USEbIO1BBfhWpwedNCEUvEzWBgGhY+9OnnLUq5VGxqgxLvsEw1AfM9Ui
	LYHeGFmhuOeVX6ZXB/csYswYWRQAVlycZWoHtZoDCgRPPYWZ5ohW/hQ36z2av6D1LpuGnHeHDYU
	ccx1FRLOI7nueILmwwpDtUCQFv/vwrZ61UTxs20zryTTczFPKRUOJhCTglh+aGoGp94TJWzPazt
	1HE0h8pXmOCSQT54DsYN68M/5SF2/EZuPQ0PC8pJ4j2HmJg+uvOSVjjaVG90/t+t3qpwA9/e/ao
	LJupisqk3wrhr8nSKbXWSxY=
X-Received: by 2002:a05:622a:259b:b0:530:f9e4:a0eb with SMTP id d75a77b69052e-532d8d21d97mr50658031cf.18.1790077858801;
        Tue, 22 Sep 2026 04:50:58 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e1903c5fsm10927391cf.16.2026.09.22.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:50:57 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch
Date: Tue, 22 Sep 2026 07:50:54 -0400
Message-Id: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca_action_gd() builds actions[] with one tcf_action_get_1() per nested
TCA_ACT_TAB entry.  Each successful lookup takes its own reference to the
resolved action, so repeated TCA_ACT_INDEX entries in one request yield
the same pointer in multiple slots.

For RTM_DELACTION, tcf_action_delete() then consumes two references per
slot: one in tcf_action_put() and one in tcf_idr_delete_index().  A
duplicate therefore drives the refcount to zero mid-walk -- the delete
frees the action and removes its IDR slot -- and the next slot calls
tcf_action_put() on the freed action:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:87 at refcount_dec_not_one
   refcount_dec_and_mutex_lock
   __tcf_action_put
   tca_action_gd

Three duplicate entries are enough.  Reject a repeated action while a
delete batch is built, dropping the reference the extra lookup took, and
return -EINVAL.  RTM_GETACTION balances its own references and keeps
accepting duplicate entries.

Conditions to recreate the bug:
  tc actions add action gact index 100
  tc actions delete action gact index 100 action gact index 100 \
                     action gact index 100

Fixes: 16af6067392c ("net: sched: implement reference counted action release")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..a9323c42a69a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2026,7 +2026,7 @@ static int
 tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	      u32 portid, int event, struct netlink_ext_ack *extack)
 {
-	int i, ret;
+	int i, j, ret;
 	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
 	struct tc_action *act;
 	size_t attr_size = 0;
@@ -2051,6 +2051,25 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
+
+		/* A delete consumes two references per slot (tcf_action_put()
+		 * and tcf_idr_delete_index()) but each entry takes one, so a
+		 * repeated action would hit zero mid-walk.  GET balances its
+		 * own references and keeps accepting duplicates.
+		 */
+		if (event == RTM_DELACTION) {
+			for (j = 0; j < i - 1; j++) {
+				if (actions[j] != act)
+					continue;
+
+				tcf_action_put(act);
+				NL_SET_ERR_MSG(extack,
+					       "Duplicate TC action in a delete batch");
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
 		attr_size += tcf_action_fill_size(act);
 		actions[i - 1] = act;
 	}
-- 
2.43.0

