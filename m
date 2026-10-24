Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852136;
	b=eH4OW10oIu/nAXM9017qK3+91ywwls9Xlr55UzIpn3QO63NodL9rzdmM9NxmUeuw5pOE
	 JtDuEny0nZLGriG8cMIkf3lONGOY3TGcbpIGq15aVxXKyfsw7VWDr9gVsCO1+I3FIDpei
	 o8l3xfPyKhOQTSaJxdvI10XuViMWV6PSryLX7DnpV843VLHjazxYSt9LseOErkIpEft53
	 tTyBmCVcGoujsb/rxmndN4pdDA+Ytu1/0HZdTldRaRR7ezC/LsOOwh3yU5XICoShnf4xk
	 HJTcS3A6kpXrem0Kz6bRJLWQo0L2JHgRVmUvDW6QICdZlHemtCiR5CNcWKaQFE61fBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
	b=5WGy6F98MCrVA3jd1XOtNFz3OpaKE0iZQE2Djkr3XuVwV75rr02o4EAW8a5A8B/zr4Rg
	 JLPtmcvSqtr5nz3ld7sO71AK2/jaH14TB+JRZr2/BXgqZLv+Hzz6mKp+TVo2ys+8KgBp/
	 VLZBZzt5HSyVc2xolLk5v0k6kj12SSnm3nPQCfXH5OO3b+lt8wFVs0XaTGfMvIc/F/UyT
	 mPcLdoHZMnUWzV6vTW14PxFoI1tWj4LlRBwM48KQrks9nfThK87RIqfcaSS/8hie68QT4
	 y4O2/e03mMzhN6HxEDY7eTuK/DjW5rL0JnMLSSVXkK/GXjMHY8dPnJUy7rjDE3F/9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="O6l5tm/h";
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AA606A32D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0AA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=O6l5tm/h
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b8306b9f8so5252846d6.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852135; x=1793456935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
        b=O6l5tm/h2asxEGgIVrye9aRDHQ/BZLggfOdFxKmt97OEQyuw4WKrXpKaJU3Tgb3DsV
         hFo3BJX2ibg4uVAFk+XWdQ+ssbT/ZY5BNJ2bjKMkttIvhDSk3Go6sZjkXKQPz6S2SXaJ
         hY6lqWHaYVUarBYuHCAOd8l7kH2FSNo2Q+bFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852135; x=1793456935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
        b=vrD+i4QWYFFwNiWJarY8UkeVCJUi6DwgEWQlnJExXrWH5DL4GHe1zsjObp26ld2QBF
         aJB9REOd49SzfpPrRqemJu03/f6s8K8If/bReSZh9IX1WnVBzFjMvoX58egSqqIGPHK9
         B1JCyoBfBAqHIZX9C9WhtWtqa3rVGweUt2wO3k34yK32lLAXLpsf8R4lwxw8FjLgEe7Z
         owK+sPTgz5qc1vH7LcCYoQrwy5wao+biU0VH/RG/5tXhz0382fldA3h5VB7MxK8a98Um
         u94k+QBJf9GykK25KsJa+6E6SzOD+jmXzlF1U9jbGGQyroSeeM+dKpHdS6L0B2AoCUOt
         BewQ==
X-Forwarded-Encrypted: i=1; AKwUvByS8lbbeLfLeCGkU+B7/HX2S2C8a6ngzOzUxuXMRTW4da8Qi4H06ziL5uTzmSq/oMHlzDReek4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGSo9zZ3KbD1IZSNaKX75iusv9DQn+XatWZCccWiI+WZ1l6xE+
	8yheI3KRTD2zMWiP8b8bWleNHCsoP9IZnMQIkzDrpvcm0mb+Po3+ZKQQRXf996VfSOCg9xCIcZH
	a3xk=
X-Gm-Gg: AYBFou0BTYCVQe+aYpsylbWrdZUyDdN4OvZor0qfFj5VLawT5PKR3YZONsK5BN1QNCS
	LEkCex/bXigwyZnoGgH9cMI/U/nG8yRRHarL6/EkutJdb+Gb+fL7p/Id5u22bqPzb5JeH5zanvD
	Zq0GCvr9wmxtirlNMLyuCFJIcODlCTWf49AI8i89z1NaTmQ6PpaqhSJFgxXYP0k76IFKhkMk14l
	Au6mXEca8EKPAeqR/obesmp1rzSMK00sWBQGH9zN6FC7URsN9pTEwJ5XXd2iOlya7DXM5bzkbIZ
	uSXWiP7XXWdqK5ipYJbY9q51YLSrVuUf8CHlFF4EfNYfc1qJ8mqUpmWpcJOFY8SyfwHQ+nQcUj6
	93ZA3UyTQmGW4DCCb7WNm7N2Q+TW7vJNyg77kpHAxEIs370pPYSfdYEtV0vs57yjtQ65SQxBgKR
	xdcHt6wAXKi+w1cyH7rqK5hqDRx0yQlbfKLEYwUtMfQ3XEYbslZTPNYvt+Jd/XWTiUOBH2dRPY6
	QvWpsukBsw3F9cOdSVgkTlXZxDSbgYm/iIx0svFk+oRhEbjzAqTf5rnmCenEoyDg3FmWSU6R091
	6LOweXI3VxOpPyhq0g5JVdua41JSAqfEG2d6PCdFJqptUbwv0HtbWKAsMIO1rEc=
X-Received: by 2002:a05:6214:5f0d:b0:91b:ffec:f410 with SMTP id 6a1803df08f44-91c48eca9fbmr28755286d6.28.1792852134679;
        Sat, 24 Oct 2026 07:28:54 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3 4/6] net/sched: act_ife: do not consume the inner header on egress
Date: Sat, 24 Oct 2026 10:28:39 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
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

The issue:
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
can BUG in __skb_pull() when the remaining linear area is short.

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Decode is a receive-side operation; the egress branch keeps the frame
intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
Ethernet and loopback devices generally.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet and an 8192-byte payload;
- the egress pipe re-enters eth_type_trans() via loopback_xmit() after the
  action consumed the inner header.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Eric Dumazet's Reviewed-by.
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..3946a9589bb8 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -769,6 +769,10 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
+	if (!skb_at_tc_ingress(skb)) {
+		skb_push(skb, ETH_HLEN);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 }
-- 
2.43.0

