Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191441F5DD
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972382; cv=none; b=YMWAlrrL6s+1lgpTWLM63r3uO5v9D2LQJd5GaouurUdglqCTUJRmwynOphY3JqjUTCYbrT1dVuhy3+rSQpP7sGUSE4MTq9rxsMhy+TO5Vn3P062V6RubnYnW1ouOJAse2y2WmXdp5+Vy2OBLWP5uRtK/72MqmfZY7uxj8wRKGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972382; c=relaxed/simple;
	bh=4QruugZiDYbn9n5UGyi2+FT6/ZrMmd+8+jAf5GVJ40w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBjvx+Xqoy90XmN207UjDClSfCdHmE+i7QiHxIfkDPhbUXlSJZ6KQgBr+zY0hevOI9GUKb48tLGJxndOBlB4gzkoi3vCNrTD0LaicU6vdRa66rxbow3OdTOSr9oDOkSbWLS/VPdQhwVI3B8SDrJn/6mAGw0bF0/1NpJrUsm9OEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=d5HhxuZM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="d5HhxuZM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1686342b3a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786972381; x=1787577181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ata04BjbhgcCIeKGSAUINAv3LxYkBqq+xOXTmgSke4U=;
        b=d5HhxuZMGGzl2Qsg+ObR+FLw56RVRMVzUCa8Mhq+uEASyXueNbWy66l1zOoElAhRR+
         4GoOC0GlQ+YtyeQnsAn8FwebBgK8fZt/57csFZpt36I0rpPHJ3auMOclG3gQlpcMij2A
         2DWOXCb1o3xagWro3iyI0VDSQrqQd5lcAfEuU/7xBVs9ZpNWoL6Np1L/LZPKtsnqlKZE
         yXRKKDmiAWIUHLTkXdT9Mq7sj3u2CHYdDHs8DNN/VRUQnMeAD7Lz02RHX0iDOTOqNRz0
         gsp6SVQLV/rWVaeiQwe0qcD6+GAWIwMaUgxPNNmET0FzMH6WJPy0+VgQ8EFiiLDdX/sQ
         rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972381; x=1787577181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ata04BjbhgcCIeKGSAUINAv3LxYkBqq+xOXTmgSke4U=;
        b=DxgN7o2MytAZ0VCcho6OF1hgR4T+AVU2010jH7uQDuqJJZKe1GsCTMW15f1qPRyBZ5
         ICECz0ZU9SZ/ncikqJfd6IZa/Y4vEJKOaJUIpxPouhmPJ6bIewcHz3MVMCuwMLR5FNwu
         bIfq1YqkNEd2AaYjbERkXJ2fVsEBHuY7i/rCvS8OgjZxgh1n1PF9ZdgJZ6ZEQk9mwVIE
         MY6ny0fpCswPG9H3ehlbpSYg8kLQ0p9iRR48YDZD6mReEe+xF+QjcBLHNsG7mtMwdDLK
         cnC9eoA+z/lrXfEGLs9Tn5l9z4jmNf+SNUHw88sa7GusTSvPv9vvz4QMDOxHbmA+qu6g
         aaVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5fzYvdrFMSR32MQs3QNTb79D3x08SysJkvFV/y/nw7BFkxMTyvO5MF7pJabb6BFHRFQjGlTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20y0fWuRGtk4obJXpBmvm/aRHsJxfTnHpnp1a+ZxN6Ft5fHhU
	HMPQc1jG5eXZsZ+NGPNz1ZugIKivDDaXNeHKyUG38l3ClSxicBIX9/3lrl7oyA4d92xS
X-Gm-Gg: AR+sD11ZkDavH7Tuh+YvCLjohJqjgu5UfGmDYTtp4cJDYy5ezna0IhJFdprJeJem+4x
	ic1QYGIbDGnRGQuTnlrs3/IOioBZ8ll+WxnWOVaU2zzjyqUA+rS7OaW545z5LNL1FxtZQRvdIe5
	I5AdxJObytJUEwJRus6HqpFt2BlWt0IXG3kK2eBfjLWuPNxTD9ui3/XRndjKtfits76PWcD38Ii
	pSVeFlpcRVIR2mSwUnTp9H3MsSUF4jh+KgSfJYb8YhYy+Jy5GIlMlqpL40SCQTVTbMUFjxaBjEk
	nujDqdQwfl4OvDXNSZ3GEsh9XGmTSJg0aWzA0zAWfzo1swx8vjW+NMWND66EKdecULT8P3EQLcV
	yuI4xr3/3Ua5YfW0XHW0jTuuin8Rtz7RuJJw/qbsmc65nA+rMgxfuD/iRzWrQeVRc74kIL/4peF
	gQ1CPUm9rn+UMAG8yUavhTwwr3meP1BFX7DpOKh3A1UnJrsd8QS94SbQ==
X-Received: by 2002:a05:6a00:44cd:b0:847:8f8a:a05d with SMTP id d2e1a72fcca58-851b8906afcmr584528b3a.29.1786972380530;
        Mon, 17 Aug 2026 06:13:00 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fefb3asm261312b3a.53.2026.08.17.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:13:00 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	pch@ordbogen.com,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipv4: Fix fib_rebalance() divide-by-zero race
Date: Mon, 17 Aug 2026 13:12:10 +0000
Message-ID: <2080e22819c552b0d186563eda255a44c68404f7.1786812660.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786812660.git.zihanx@nebusec.ai>
References: <cover.1786812660.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_rebalance() reads ignore_routes_with_linkdown while summing active
nexthop weights and then reads it again while calculating each upper
bound. Sysctl writes are not serialized by RTNL. If all nexthops are
link-down, a concurrent 1-to-0 change can leave total at zero and make
the second pass divide by zero.

Route insertion and link-state updates call fib_rebalance() under RTNL,
and netlink devconf changes are already protected by RTNL. Make the
sysctl handler take the per-net RTNL lock before changing
ignore_routes_with_linkdown. This gives both passes a stable policy view
without adding work to route lookup or rebalance paths.

Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/devinet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662..71d961013 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2604,6 +2604,23 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int devinet_conf_proc_rtnl(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = ctl->extra2;
+	int ret;
+
+	if (write && !rtnl_net_trylock(net))
+		return restart_syscall();
+
+	ret = devinet_conf_proc(ctl, write, buffer, lenp, ppos);
+
+	if (write)
+		rtnl_net_unlock(net);
+
+	return ret;
+}
+
 static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -2709,8 +2726,9 @@ static struct devinet_sysctl_table {
 					"igmpv2_unsolicited_report_interval"),
 		DEVINET_SYSCTL_RW_ENTRY(IGMPV3_UNSOLICITED_REPORT_INTERVAL,
 					"igmpv3_unsolicited_report_interval"),
-		DEVINET_SYSCTL_RW_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
-					"ignore_routes_with_linkdown"),
+		DEVINET_SYSCTL_COMPLEX_ENTRY(IGNORE_ROUTES_WITH_LINKDOWN,
+					     "ignore_routes_with_linkdown",
+					     devinet_conf_proc_rtnl),
 		DEVINET_SYSCTL_RW_ENTRY(DROP_GRATUITOUS_ARP,
 					"drop_gratuitous_arp"),
 		DEVINET_SYSCTL_RW_ENTRY(NOXFRM, "disable_xfrm"),
-- 
2.43.0

