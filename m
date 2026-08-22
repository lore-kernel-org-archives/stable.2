Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D42368D47
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428535; cv=none; b=eOKHp6Ref1iRgvhvqXCLQhAuSg724feg1rwaws1TWK6SHz1mDM9JTBN6eeKrepC6Zlj6w1Fsu7O/6BDNQfZmyoZG/SOHhRbgWKWiAODykf2qJkm9OlVWruzg8+c/XTxnCKJsFL932Yb88h0rlg95BXBm96kk1wVEBjRo+TjHGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428535; c=relaxed/simple;
	bh=+jlwYghC4ExY3ERsnA0RO1DbLAH1xLhGCcjcB80hAqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fui1ClpF5Dvm/aPybHFhkptAVTnQMXEB6ngCmhRXCaGLIxETIP8VlfLFV19FDts7+KlFNzjycU/ejKALIPn9yMuSgRh3HjnBWqPK3lY2f5JNxvS2oqiWMSEvLN+4cILdtSEBduG8h5H3WHuigrfH+/6Sw09MinnY9nF2HiMdDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TEEnlxS6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TEEnlxS6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6c4a867cso129211085a.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428533; x=1788033333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlRU7IbJKL/9+tg8sRrGYCHYJbXO8RJqk3wUbHTfj0Q=;
        b=TEEnlxS6eLGCPxxO8Ir5J+8h2lzy4XMvQpPf3Ts9dW4UaZM7J7BFifGpihoAqnrYIn
         4MPK/F8+KEx51exo2DgyNLEPzUSh2XtX1yaVanSL/ClvhB/VaEMrQOx3XEsWsknlh3Lt
         FG6es8SrS0qzVn5+FwppOTSXvi6d1bCm65q0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428533; x=1788033333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zlRU7IbJKL/9+tg8sRrGYCHYJbXO8RJqk3wUbHTfj0Q=;
        b=Dg6YmhMnEaZDpzEqU7Mx1jgjdQCMgoyeINC1rJCi45o0ohriIJtRV9SpF5S7BFOzp/
         N/E5tE/SynjhdH6yxHVn/ApoE3GoV+ZR2eIuCAP7n7REa9KJPcXc+CccjfKj+bFS8NAl
         QaBMos0N4q3cj54a27X0MheYEZ7miIRi+mnppHCld7lXXbrehSpHjBfJQKldL7ROZonK
         Ga6PrdaW4T0ywRINeDve2H30lXQhKIoqJIOUmhy0y4dSXJepuVd0hcSfHnlXPdNTunsS
         pt1LfbjxcE8zvhoZBzoatEA2c9oKS1wDYrXUI6G8PMRTkihnFXSU/8AKRV0OozKgRLxr
         nITw==
X-Forwarded-Encrypted: i=1; AHgh+RoSVNBYR2QM1yC4ix5xN3Xuhn/TFWUsR3ZmNKOznGUUZ8yR40t2Wq5YOYbUIcVKdx46rvht0h0=@vger.kernel.org
X-Gm-Message-State: AFuF++nWJBFD6yKFP6vF6jvG3yQMpLkaWhCWSnk5im0PxnNnJH0TJZ4T
	XGjCP90IoWlC5Rf517k/v8oTz5GOc4yvbasx7r4sY7U73XTXZ/2vlCFQf8Z94fIU1w==
X-Gm-Gg: AR+sD12zz4qoSZEajortfRcH8V13rmBm+KKbYVnd9rOu4Q4Mh6ERqlJK0IxnUwzNau4
	FepXjZa8bSTd77pzIL8jvMOCrap7pGTRTFh74XVBHLNUu96Z/UaMmcCeEx2VnM86D/bMSv6XNyi
	XZ99irI1BQTmT3RzAqNd2cQg+opYT18B9FuJxFpUQSvAgfy2l2IwhuIcHIoECOMvHmOU9VBAW2a
	9MI6bbjlN05/EKuXixD8YhvB4TkDXvWzzqmTs5arP1wtIGodkJSOkcOr+L6GoSNZwF/oFNR5K34
	pxzhPWQBzhaYmZl/GV1hilr+px8uqJeTjEkcFcy42w+gsmQJR/6X4l5LFLCrO4l07rNemVkIhTb
	7Hvb4FI7ELgmxjYc12jdQ0nIwyjTDL4eVFl0J/zg2QQoTHWbr629RDKXFcC1fw6hjmFpmsuSQP+
	KTen1O3YV6tY3G0xjm96agkP+/ikLvspvkZQ7jtAmHDKM9vI2vZI0wZrxRMfmM36g=
X-Received: by 2002:a05:620a:44d6:b0:92e:6c8a:2a39 with SMTP id af79cd13be357-937394750cfmr1369602785a.13.1787428532875;
        Sat, 22 Aug 2026 12:55:32 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 3/6] net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
Date: Sat, 22 Aug 2026 15:55:06 -0400
Message-Id: <20260822195509.112717-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codel_init() sets q->params.mtu = psched_mtu(qdisc_dev(sch)) without
clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
accepting MTU 2147483634) makes psched_mtu() return 0x80000000. In
codel_should_drop() the test "*backlog <= params->mtu" then compares
the backlog against ~2 GiB; with the default sch->limit of
DEFAULT_CODEL_LIMIT (1000) packets the backlog can never reach it, so
the test is always true and CoDel is silently and completely disabled
i.e no drops, no ECN marking, codel degrades to a tail-drop FIFO.
codel_change() never updates params.mtu, so the init path is the only
place to clamp it. Constrain to [256, 1 << 20], matching the fq_codel
bound; 256 is a sane floor that only makes CoDel slightly more willing
to act on very small queues, which is the safe direction.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_codel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index cacf5244958e..6aa5829d6961 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -205,7 +205,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 	codel_params_init(&q->params);
 	codel_vars_init(&q->vars);
 	codel_stats_init(&q->stats);
-	q->params.mtu = psched_mtu(qdisc_dev(sch));
+	q->params.mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (opt) {
 		int err = codel_change(sch, opt, extack);
-- 
2.43.0

