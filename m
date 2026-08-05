Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76E3BCD05
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968415; cv=none; b=oP/c+FvBzhVMKlU+eH5O1eO9FLTRxjWpKumkB+fFe5ZDHQFqttyDlzykvdClHpF49+ZUePTmmMeOUuIKqFTXsDiP6yDxfvbfiEdXnJkzU3tXHbdRHiOvxUzY5PDnNA52/1N25BgeNH7y79QFVzUJ6Jtit0Jzi7m6XLW2Vch84u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968415; c=relaxed/simple;
	bh=ohmr4zInTP6iEMUroBC9MqGNU6f+X+BOz+JQOQbM7L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6F2sS0lvHzVrotGaIcHFZNcAXjtIP7TwpLHu6RgAkZOCh/VGTsddBesU0SuoiRB+DcR+4KwCF4NHejBTpO9NM7vufo+ZEcqqsVM2PIJ6KmyseVUTnd3+mj7x8SMDlFrmXio7cUonn9ieGCY7dLuMKaqHu+6+88upe6PgVgUdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so599524f8f.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 15:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968412; x=1786573212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8e7ns1bNFzwSj2SHNBORmZWjbG/E/7bLGWPE6lx0Z0M=;
        b=LA3ZYHZ3EJN6fpKNo20sXlOfeJbA8V5Wb97WCb3TlPsyT9aMybZ2CcSS5gbX+9XrOB
         G6QoS6ikz8DhgItQvQNNOcCRsN6bU5+MgkbGve/o3ztjMaufhwo6yeXvJLEn2Mr6pjl3
         TQPhThiGKWQQXpkjkMOfqFyKnK2SLEBA5KD3qQ5gjzaSnHzlFkOw2X16QWkEIOStApaX
         KYl7V7uITPY0cIlspPfUGaE7k6HAj22dU4lD4Dplagy0DujtbK0pn6ehaukOzCuHcw8f
         YRZMQFyR8AcgmReUAEf/Zrx5z0M7WZ0tAK1O8tXpIUzFwtmL3HZZqhRu1wG4Kf5ramqH
         fsyw==
X-Gm-Message-State: AOJu0YwDUEU7KQiVLBeSmwQ/Pau9ryzxk5yyUQ4LP+PN6k6hGPAKGLpg
	mn2OAnBmZlv5Gti7HXUl+OL1AFwQV9RhO7F5bEabjOpGkQrYiTZUHDv2GUSNLLefMj4=
X-Gm-Gg: AR+sD13GjJ7dL3Y7fhZ1LNQm9L+2VnI88WnjUOmUF1XSwByC2wQD9Ja7GX3dtAmyRuw
	zALPfKI4zUyOMdgWfuaBz9XTip/WQMbR8Hi/tUjvDC32uKhIKm2E+BC/H4Nevsa5eJwJWC2vebO
	mlQS8N6wh6GfEEF+qROvZMSVp5w6Owiy37Ue4sakJrMqlidYIoXGVQJoq4FJeax5f9fouX0x700
	tnKkiagGw0B8h7UN4C24V1MJ88RaNnYiW/ILMA7+zb4zZKRP/AdD+TbB995GcM7dQc/qjiuArj+
	q+Xj0ltBT2R2iJyYmgEjG03nI41AUS9G6FGhG/FBME2KwGC+clgS1e8PtiDBu66kfdpob3lUok6
	Ith8DwGj8Z9F6DdZv32/uzNsj9C91fC5tJSq+9ZzZw42U2v9Ggr+uike/+/87oSfLbpEQ7X3Fb8
	W02Zp3eg8niCCUq5NvjOj7gp1nhxHdEASvwktnqEffXS1/Ll088sTBKYiMOZCeN1ErXsNloJUUu
	857Lc6Zk+9yA9lwrzLnAQ==
X-Received: by 2002:a05:600c:1d23:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-49951b8d652mr61047175e9.3.1785968411679;
        Wed, 05 Aug 2026 15:20:11 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49952f0192fsm8511785e9.3.2026.08.05.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:20:11 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 00:20:07 +0200
Message-ID: <20260805222008.2820396-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080538-jolliness-altitude-d16e@gregkh>
References: <2026080538-jolliness-altitude-d16e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit e1cf066244dad576221b7123a0e5005967f25a20 ]

do_execute_actions() returns right away when execute_recirc() fails on
the last action as it assumes this function always takes ownership of
the skb when 'last' is true.  But when the flow key update fails, the
function doesn't free the skb and it ends up leaked.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: 971427f353f3 ("openvswitch: Add recirc and hash action.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260727181851.306076-2-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[OVS drop reasons are not available in 5.15, hence plain kfree_skb()]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index aa240953d766..3758267303f1 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1111,6 +1111,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1121,8 +1125,11 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				kfree_skb(skb);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 
-- 
2.55.0

