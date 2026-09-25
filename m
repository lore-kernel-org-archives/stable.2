Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11D35A393
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324575; cv=none; b=Nnu0F4vrD4acl0bdx6hQaDKAPcyCTtD8aKvNACC2XAr5mOQ1A3UeIErrSxkSt71mrz5+s0/wtqJfUqVb4IS+PW8AobQPkgpB1wWNlCMzZ36fyiy3QZTQ8bcLINP2+1qCsFe4Hrpg1+/ieDRW+yIqjwA+81x85OSWadTCJcQP5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324575; c=relaxed/simple;
	bh=9Z0/S6ZmABrK+l27B5I2Z8yd1uEctVo+Rmj2z6kxKM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eeqnB0NOua7/1W1Pcw/JducJCNd5Y9vZ50JOStJ781MUWmNNWR+Vd6v0o3U4y01wtVuZ1vur6GPTR8eZOQm8d3TlvE3lrlS2+UaelOoquMF3k2zLkcG2olVRTx7HckyBYKzkbrQH2Ul+jNN+G2zconrX09S41Q2ZwnIEMi+pFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jYrdhlvU; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jYrdhlvU"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb769ca02so7793331cf.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790324573; x=1790929373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=jYrdhlvUpgqju2tKjGY5vgmermh2KaVaI8CwRK0bAaMOyb7mcDDPeJOe3/Srlvp0s8
         NegrPSYVoG7xmqKUMbz+xKU854XQEvCFUxCeYBmL0MeQNPFCO9t1WRFQdLp+xeziBzl9
         hk0nvXdZwr7sSZZYdXcbfsZHCbN7DJMwTxGHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324573; x=1790929373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0saLHrvWxSfUHEQ01OMjuyvbZ8NuQR40GLYKRy9/kyQ=;
        b=EaHw95mNE/uh5wXMEWXakQKuUEfgsuCP91y6ivBQteCC2iJioxhCHcGDE7i3ODDQ24
         VhGmUiJTfEUyP5L8g9hD5/uZfgyu8E9zFkZryg6S+ofpHQNkK+J/zksTblkvZp0lk0jj
         7JBRbMA6eaHrFkBFF9S82JHIKwUoFZ5OaIdDOIVlw06ex2ucXtTqwUQRhkJJvS3RHMpe
         bkZAbNHWYa8kSKmorOvMKaGeEh2x9DwfrlpxNL9tQ11JPt/g0gIv8QnGySA9AHHG7MfH
         qoZcNNYelvVE80RsF9LgfM1+Q26fjcgT5S63cY0/xj12Re2ouVl9099ycOFdplS8ORxP
         AE6A==
X-Forwarded-Encrypted: i=1; AKwUvByAldWK8wWYp1CYAiPmHkwyoyFoFUbS0t7no0Q2F0VukLZTq1d/oiz51PNppFfufRFCdvZjiGY=@vger.kernel.org
X-Gm-Message-State: AFuF++lsG+MwsB59M62UQcAsNgT8qgOzJUuYSRBDmaAmKPjeK5w7N84I
	qOyaOM5iUNbpg6KmqapH06EARVUdpoUZrMPCqXnghxXBKFZBqNuuOipQ6qjePawRdQ==
X-Gm-Gg: AYBFou3RdEugzYVBIJHQaJ8MENgLL2thPqjnImwROHESReLyqAhtMyUy5pcmec8Sk+p
	GKFlOd1Zjz5lJGk038iNGU7W+1zoUncMIAGw9Zgpv/gp1t9bNfxOfImzsucDTabFgbCOvwg1V1G
	H6fmtQq7IZw9DOLJ7Cr5ktCsrkWtUHMOi2Ucn/QDJSW4ZHHYC39vtUg2MCQzKgFhayHirW7y4W1
	OWYlVxZmHuYJ3CVyHn840swchsm2whAWvdzq/grhfxWUNh0nRBKuIAhPWnjzGNSKPOgeyPV5BvW
	7c88RKlRou75+NSo/CWh6k7dcET2hS1OockiXZLbQ4fwfQjlMSpurOv5rpmd+riMNQXvE1VC+87
	F/X3ykaF5c8UN57Xn6iowBJnsXtHEjfAQgeyP7Wwgc2rM2wEOQYOFT080HG7PSDo5rxY5v8/alj
	gqVaanGroYOi+Fe1OavOTmpBKREDx4lcXGXmrS7BruDV46Rjv+M9DKTeMJFrsg5o/CN30Cd6uwA
	Yr+CK5IrIo/xCRWExGJ3kM8NRlLhMnHKdwwE9MOsO13TCpmaQ==
X-Received: by 2002:a05:622a:260a:b0:530:b2e2:2f6 with SMTP id d75a77b69052e-5330b705c17mr26762761cf.56.1790324572722;
        Fri, 25 Sep 2026 01:22:52 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0aae6esm10554481cf.26.2026.09.25.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:22:52 -0700 (PDT)
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
	Victor Nogueira <victor@mojatatu.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2 repost] net/sched: act_api: reject duplicate actions in a batch
Date: Fri, 25 Sep 2026 04:22:37 -0400
Message-ID: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260925082237.xktTTrRQRmp_V8OKNBxFnnUlj6a452UO12AQPOXYlPc@z>

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

