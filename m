Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40B46A618
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987329; cv=none; b=j5eGWsfImoKmkG/5GwkkavkL4Upge9Vj4Abknq1IiEyqUnWOGwYla+W2eUSycOceFgtQi/ei4DREuhKA/dIuTTGmimQs6YXXata+QQMMlZivEQh8jkrMtNwxkP2rHPMIzutV2PaHRR1F88AMzjxbt/hPvt7QxSRQSuxAvD/XAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987329; c=relaxed/simple;
	bh=rsWpgWyTG8F1CuDnXVgty6t/FxOndhvrhLNDCyp5r0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR0yy1YFCesG0fFmkNN7uoqgJ15yiVTxJH+KRBfwMFI9OO1Tm8CgyPeIxPZ2wrG096c8/zUFICGTEnmtckBbUQ6wTCDkwzEA9Y+m1BMkzA95PLgyfE2IhWVKHaNMg0+lYthmRWIqajgd76N0xexdSMXcb3ZlFelj3k02fRYy0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AHL3IEsO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AHL3IEsO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso62331255ad.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786987327; x=1787592127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=AHL3IEsO+7qiZ5BP36A8zNn7f0asLJ/pfKfopomTqV0WmeYUKO4UQZ/ejv/ZdKOdg3
         CQFUVx7eJ4y3LnKeEYqScwxsKXShsF4G53WoOIj10liRuzmbV4l0gVyfOyyzbH/Uvf3x
         lW6aPY//n1rdFg+rZHoa8B/O6DAIUAuX7CmXyGNiy6IXuTnGekEL+DK4Ulwx75oED+AH
         UQo4NcRNs3ipBrkakLAwLtC3XfIzdLsiZ8eCCaZ2mmPpgNvvnr6UHTg9hSvIeF4YwDyY
         QJ0AjJt4US9ZGE/cycxCOpP1fh41HY7EDssgpPGUJxCiNIopcdpKiPh44SRnFU0Gmsyi
         rC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987327; x=1787592127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=Qo05UnxoOEW/F5IXO8aCGr3Gbaue3aISDvWZSgsjUsRkh66B8TGNqM4TDtIX1fu0GG
         05WSYV4OFRTUrF0DPVWScZ9QtQn0KWzkA0AmrPwgQ1zPXyjmJFsCNvVxzNk3JoSbvscT
         sKkhfdg11l0kv1ZONUA/g/F+r2Z7LNHCCLv6sUIKOxkXnon16tlzImhiR8FzAN1y7gJi
         BHBOf7nepL6SV1tvwnxBle7CLeSmsFq83qpQDASeRQv0Yt0fCiVuiSq53xYmAkSDqBT5
         /VF0CChbTnBQsFxvzvGFEyVx9tC9zgNqFLO4ycsHnkfvpydtb46HGu9BZuzqtM4Usww5
         83tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr33UvVeji1UrEGjUpdO1ssvJ0NshjYxnjDbQ6ykna9EYvy+8k9KCEA9IAzflyhL0DLDoMVPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV22EbEeqdN2I0qtnYNRPOsqSrINl8DMB/0A9R700KkRMB1pVO
	N8YMLCgWuarcNqfTjQHfY0TXRG8rhRscvGDr21R2tIK5zcarqGS+ooa7KpNTJ/qeI1cO
X-Gm-Gg: AR+sD108mK5gBegJPGPCPgSxSupz1nEtFEH5NIN6V0u3ItOSHSr6y+7iQwq2Hph2hhf
	YbrlBVTR5JEondSPHMbJmDlHkZW12tcC81be6zvPSRAihVoPfmppcsQB11lS1xJpSgaMXOjlf9y
	BNHklpAGdgcXuS9beRxeF695LoY3QYK94IzNZwnW+TXc/epYfntgNVw8c2ac2c2DAa8FL1zibxD
	7GT5XlBrEoldqrBnQ2VqSrc+yJsMxGoOIe67RONnlhrdX5ryv5Wh0+rBjZZLgpbZQgG5ko9KFhf
	LN8rQMo3A2P0rq10qEAxcbjNuXHZOEvtOu5rtWeDlqSro+VQJDyypETk9FjEEgRpfoWFhYDboXk
	9NEBB/yEAt9KEOuxcumrLMqRuqzoDbZ5ApJDVJsaD8HK1bMbPt0XSssmp63XKgaQlobms2a3rOn
	YGT0WhVQjGUzLkKTzTvkfO0vmZzbXnR5Ao/Z2cLcAQkeXN9B1PxttbREHzmbtTtlnE
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d5c4f07dfcmr19832145ad.4.1786987327419;
        Mon, 17 Aug 2026 10:22:07 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb5175afsm9260495ad.28.2026.08.17.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:22:06 -0700 (PDT)
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
Date: Mon, 17 Aug 2026 17:21:56 +0000
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
Message-ID: <20260817172156.v23zY9rxoVvzX1BMGt1_VsLbfChtFGL7_-cnFYCw8wA@z>

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

