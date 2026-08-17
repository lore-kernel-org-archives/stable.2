Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54045446821
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987280; cv=none; b=Jyufxqi+QF7o2WTIrpYADTTBTs382jUb8CqCXQ62Sio9lT5Q7uDPDXSWTLAehlX1jwtA89FaRqUqE0BDgy2H0QKAh3SDw0A7mPH/ki0339tYCgHquAs/1TXgBNEYvKnHabVql2yHYhZTbYM7QBlxf58Ko43D2tDGddBbn44R1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987280; c=relaxed/simple;
	bh=rsWpgWyTG8F1CuDnXVgty6t/FxOndhvrhLNDCyp5r0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5argM9Kbv+UzbAtwYFQdfDDFA00gMDr8LzZGS5MnC5hTqebwLws6WkV2jHK80bdYMYm+4NjYnJlRXagpmasvrTE8p6TSbHYceMEV+eMYI8rDIrzyHaheTXHinqkq8cx3f7EzgrAsbNDyjt17WICW8bMCKNQhb0/rXVUrFOpPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=dxxaXRag; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="dxxaXRag"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso62318565ad.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786987279; x=1787592079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=dxxaXRagGTbbECiKjxie2UCAtU/XCsRMayK5Z8eiCTp57NPS0aoe+8kETqnafVAAys
         CdvxVHk6917eClcbVFSdMGPqgzBjF8roFnYFMCKd8fkUnshcSjc2W4/c7axDqc/UDjmF
         O1tm8wCPV5FIwBKOITKovTwFJKsPB4gQqXG/nT1KAyKhStfFlNfWkzjFMBm/UjJr7PLX
         nyaFIK+FZ0zdIRaVZmmvC3W+qSdAjNgmQaHswD2un7WAZbhUZOiqO/q7lFP4rxPeLi2W
         bma0bW7EGqT3Bcl7VyDoWmeFZAFvjQaurEdBJXtb56ijreJyenGtt/xHBcv9sX0O9NXJ
         wU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987279; x=1787592079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=qzi6zDsDci7M3Ztpv+HA2fcNpJ2VN4er42X4qCxLIKDLnHzIFH4c/dou7Qvbv7oJwM
         INEoflcqlCj7bCUCeIdoUBdOMEjgWEBHS+QrwHMIRFht9PkIPvmPd67WT01QR11T2h6A
         +jHEp7fzurJ9JC78m/1nDoStV5antuXASi9QcFOKy224UvEYxh322xf7YTc1TMivHTYS
         hovmUPEEZgBqcAQS6epx+bIpONEnrhsDZdwsDvXrMTRrHQpx9zm2JiWLx4/lUOHi3+YP
         zWxCtiA/YkoB0coQLateKQ6YpuBMWZASCYguL4C6A+nhzY0KMe8TQCXkK0tF6bH43Kj8
         7sHA==
X-Forwarded-Encrypted: i=1; AHgh+RoBeW7qL+XN2GN5JcgZXPuqYprGLXR3QACRMM44cJWJkNhUM9cAt6VqGWvAXtp8VT7fakJvs6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5OFrndPS51v2NlAkAjPKZ5qg12918X4aB9d9QIzyWTYXEQy2
	SGleiX2rVYNKmtsG0+cvNVqIqtSHL0INk0fSiUCqQepy01n+NnvX2bFf4alhqFeh2TP9
X-Gm-Gg: AR+sD10Ud/Yvt0wjJubXHIjK7/laMQPTcQl2E8M10xXZuq0nUhfS691+h6pY8f2HOTB
	NaFZvOkSXdcNjAOKD+sWyTklPWht42qC43KTaSRqdebvr/2sRFX/gGg9q1kdEZOANktXtEtfool
	yGdM4+rHahe2uuxGbcHHZp4wiGk1xX3TFhEQtWe0pcFXJXxu/jnAPSDAwTcEUP6YsnE0Wh9tqp1
	5rgrF69Px/qtjIPw2XbfQXqEjSOOf/NnEpw/G2ZKX6Gd8JftHMn+0tJzIPzraI7F8iNnJ5cUXXO
	Gni4mbtWpc3L5YBy16y7nuMRPQkCep6Rx8cv5P9Gw8gzq9Lvn4Ieda1Sefy0d7th6hVQK/onJW0
	605aZBCHA2gmQYPbdC0c7GuiCdFlRkr21D5Veq+n4l93iwXusX1BCWgPf8x8PGYsAdKehSfbeWU
	dr8Y8YWEUgq1K4sHjzs+rL0CFzEv7KuSLJgtwbonU9G2c85Cp8m0t8cQ==
X-Received: by 2002:a17:902:e5cd:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d5c4f38113mr13840855ad.7.1786987278618;
        Mon, 17 Aug 2026 10:21:18 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e8de43sm6184255ad.57.2026.08.17.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:21:18 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bhong@brocade.com,
	stephen@networkplumber.org,
	sven@brocade.com,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] net: l2tp: ignore multicast notification errors in netlink commands
Date: Mon, 17 Aug 2026 17:21:09 +0000
Message-ID: <e9cf566687c906ba6843f72b28f11a3431a595b5.1786962220.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786962220.git.zihanx@nebusec.ai>
References: <cover.1786962220.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_nl_cmd_tunnel_create(), l2tp_nl_cmd_session_create(), and
l2tp_nl_cmd_session_modify() update live state before sending their
multicast notifications. A notification helper can fail while allocating
or encoding the message, or while multicasting it. Returning any such
best-effort notification error after the state change makes a successful
command look like a failure and can cause retries to accumulate live
objects.

Keep sending notifications for listener visibility, but do not let their
best-effort status overwrite the command result. The explicit (void) casts
make this intentional for all notification helper failures.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/l2tp/l2tp_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c1..21160284f 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -248,8 +248,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	(void)l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			      L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -645,8 +645,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 					   tunnel_id, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			(void)l2tp_session_notify(&l2tp_nl_family, info, session,
+					   L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -710,8 +710,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	(void)l2tp_session_notify(&l2tp_nl_family, info,
+				   session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 
-- 
2.43.0

