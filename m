Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244895;
	b=1rsWm0xxJcJOaFj59bsj8Rnr1aNRQTCNZj10DvzpzB8ivjQWACx7BTRB6qSE/QGJI2dH
	 uz0aEMtr07CvHM5MAtwx1asuEmL7yqAe2F+/buYXl7r9goAB5tGr/74mEp8QkR5vXmh9I
	 57NTtQ/OHEfzw9GKowyTxUrbR+49iUTL2HtwY4qD4jFqJHCv1G6LBZ53BuHR5qb0zUv3P
	 KUff/50wMDPdEwDjd5o1JzluiKF+pFtqHsgpngVQyVpGcahBdN6vNGTlIM5iZFhSQe1jT
	 0zFggdCwATkvZfCrN/FPyWDRT8pwt7y1dmYk7B1bwtxrEl83U60tjAOiQaUyah8GiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jggiWoga1NJk7y9SQGC+twyNAV0WmO0xloKYic2KKGU=;
	b=reV/qONwAApBVzLP5biOZZq9z0KuyNYtCtnO1/pPq/t8eJ39vReG+zvie9xGIW3PUoGC
	 IVAMQzWLQx4VJgUWBbVraGiPd1AWVt6EBBVYzQ6GQrDMprj/RUqJ34hcaj/irvzsgO2Yz
	 /KtN1tIpsV1ztLJS1fiDukvJoU53ZgFGvyzEPV69lG6fZsKSBqsLTr5VuB/UPmU0G2BUq
	 wYPxBcr+CP+MyCh414ih/LEhkiMiQm/aoqWEHXzzDUeEIXjGk5nwYIp/Up581RVJK9u2n
	 A/KuCUfBkXIcSj03yBOcBRr8FJon5mui+a6IDv31Jl3qGZyGu1clQtEpqnk9S6V4F3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swWh2SPr;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AB606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227AB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swWh2SPr
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1369918a34.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244894; x=1795849694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jggiWoga1NJk7y9SQGC+twyNAV0WmO0xloKYic2KKGU=;
        b=swWh2SPraKH11s8llPywjH2PX9jXWQPMOYAoqePeiNUBsAZGN9QUOLJmcpjc6G7iJn
         8gn7kg6htd0zgX45ftC+OHCgiXplujt3uG0MiDbu2Ripsad+Pwhl1gQmGGXVJnVTDVs+
         CeBT/CvO2So1aPA5ZRhcT5RXfHqo0vQ9OzCjSQ6LbpLKPyFkti24ub/4UBs1c7og5yD7
         FeaefATMtRz92ehVx+OjwUHpdaVR0g/l1VNvn9kt/iZLjMGXi8x2yOHLQrpIOCnUVdE3
         sNjQNb2OPXbOD+eEiKAznKKxp+0m2QA1vmQybPO9c8CSPsiDvKAm/M3BrPSl66cbHhvb
         2V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244894; x=1795849694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jggiWoga1NJk7y9SQGC+twyNAV0WmO0xloKYic2KKGU=;
        b=jOGkXsVQVhuHEQsmUkMuLBpnIy0L+iqdN1zIQclm3JfFBq9zyi8T7PuWNnxpF1w8GL
         42ioMQ1QYAjpypIzbOOyR2soMhB+7R3E6iPxkwglagd33jZLoXmfwh/4NE0CAnAUp3Kq
         9Gq0jkNXCe4le4PvyWrPgaV6++Xz16SzOR9gAg3sACHsv7bmLb5fk9yeTqiY8GDpWASx
         +kfLGJdD6gG9MOzP2TOz6v04mHnQN5sW1oFIM3PRlTg/Q1sf3W0MGuv2jiRRPYp48C/D
         CvvKRmVJ+mK5Y5msbmtkZrdVH9yMhsfNtTrqhPCUiu5fso0BqwynEGwQ3oD9yGI2yRSL
         I9yw==
X-Forwarded-Encrypted: i=1; AL+hErEC8aa1BtfXQuOjSt+mkfUqlF2OmS4e39MPn9jArhgCRvOs2HIelWsosJQtsjb/dF5xgv+GdNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3M/q1pirkf8g23ipY6PXdY/WSVkJ1ktmaMeZ33gIx72PuIsvX
	V8MlUgHeC1Eu8YkS5mfBVOznzJQqWoqDiAwYrlwbldtBRcQNOJm/12/o
X-Gm-Gg: AZFdTZcVECVRZfsdYqwV+OLZ0i3e+Lx6HSBi/vdp94Sbdyqda/LhQ7t5Xvd+NnosDUj
	WOj+p5eDbWGz1yn/gfbmaABO0ay1yOaVBlgPLKfhDxx69xAZdwfeCC7TYCE/rZZgXUQYXKJTttU
	ndROo7NM/V5fuRHSRdlJ4V8Trew+6x+tjECxTvIbFSe+X4Grj1F4cVboVmH+qRGUs0g7Nd5SkQA
	AhGrXbopN9BAjxw/VzN0X4LPEnrKhDa/O0ElOa1itcCpsTHhemGYigcjONmTqK3rVPjSOEGr+Yg
	0PaZ2Lx1vkOWE0zr32Tf6ZEO64MmT6onoS7KVqeweMyYVpBOxw/IJHyPq1mJw0ph2p+DW3CdrOE
	RqYgltnxzECitrBUZVdBmrnASkkLb8EkpfueolBR+qPM/QmplfFZPUqeYyxNORyZR5nnG7nyt6F
	z6H03oLj1LKyz8stejGTdOQmUWL9rQ5itKZHELHOphiKtHYgI/RMcU8cJhkbb5iQbEeMMkjowZ9
	5Vwi2/8C82ckpTTwijW3/MCUWJ53eL1kgQSZ459BEAZv4ZzCJF4p+qNrvCarjpzBt4kH3wZt4Xx
	McZ6HNtUa3ilIA7j5C1Z6OxsxaUTu/guIm6mgVV5XnJxtqBSpnhE1FLzrVkqu1q029lCkg23HJG
	wo155+Ca57tmhz0k=
X-Received: by 2002:a05:6830:44a2:b0:862:bda5:b88b with SMTP id 46e09a7af769-86315a0c16cmr6284627a34.21.1795244893993;
        Fri, 20 Nov 2026 23:08:13 -0800 (PST)
Received: from hyprland ([189.146.113.144])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6d8sm3737609a34.10.2026.11.20.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:08:13 -0800 (PST)
From: Alfonso Villalobos Ulate <alfonsocvu@gmail.com>
To: westeri@kernel.org
Cc: andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	Alfonso Villalobos Ulate <alfonsocvu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] thunderbolt: Re-add host router DP IN adapters after DPRX failure
Date: Sat, 21 Nov 2026 01:08:04 -0600
Message-ID: <20261121070804.26185-1-alfonsocvu@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When DPRX negotiation fails, the DP IN adapter is removed from the DP
resources and is only added back on a hotplug event for that adapter.
Host router DP IN adapters never get such events, so after one failure
(for example when the GPU feeding it is runtime suspended) the adapter
stays unused until the driver is reloaded.

Re-check the host router DP IN adapters when a DP OUT adapter appears
or a device router is plugged in, and skip adapters already on the
list. Keep host DP IN adapters in adapter order so a re-added one is
paired with the same DP OUT as before, instead of swapping monitors
with the other host DP IN.

Tested on an ASM4242 host with a CalDigit TS5 Plus dock.

Written with assistance from Claude Code (Claude Opus 5.5), which
proposed the code changes and drafted this message.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Alfonso Villalobos Ulate <alfonsocvu@gmail.com>
---
 drivers/thunderbolt/tb.c | 52 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 57c11ba13459..4a43da6817a2 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -109,6 +109,29 @@ static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
 
 /* enumeration & hot plug handling */
 
+/*
+ * Insert a host router DP IN adapter so that host DP IN adapters stay
+ * in adapter number order. A DP IN that is re-added after it was
+ * dropped (for example because DPRX negotiation failed) then gets
+ * paired with the same DP OUT as before, instead of swapping DP OUT
+ * adapters (and therefore monitors) with the other host DP IN.
+ */
+static void tb_add_host_dp_in(struct tb_cm *tcm, struct tb_port *port)
+{
+	struct tb_port *p;
+
+	list_for_each_entry(p, &tcm->dp_resources, list) {
+		if (tb_port_is_dpin(p) && !tb_route(p->sw) &&
+		    p->port > port->port) {
+			/* Insert before the first higher numbered one */
+			list_add_tail(&port->list, &p->list);
+			return;
+		}
+	}
+
+	list_add_tail(&port->list, &tcm->dp_resources);
+}
+
 static void tb_add_dp_resources(struct tb_switch *sw)
 {
 	struct tb_cm *tcm = tb_priv(sw->tb);
@@ -118,6 +141,9 @@ static void tb_add_dp_resources(struct tb_switch *sw)
 		if (!tb_port_is_dpin(port))
 			continue;
 
+		if (!list_empty(&port->list))
+			continue;
+
 		if (!tb_switch_query_dp_resource(sw, port))
 			continue;
 
@@ -130,7 +156,7 @@ static void tb_add_dp_resources(struct tb_switch *sw)
 		if (tb_route(sw))
 			list_add(&port->list, &tcm->dp_resources);
 		else
-			list_add_tail(&port->list, &tcm->dp_resources);
+			tb_add_host_dp_in(tcm, port);
 
 		tb_port_dbg(port, "DP IN resource available\n");
 	}
@@ -1421,6 +1447,16 @@ static void tb_scan_port(struct tb_port *port)
 		tb_sw_warn(sw, "USB3 tunnel creation failed\n");
 
 	tb_add_dp_resources(sw);
+
+	/*
+	 * Host router DP IN adapters may have been dropped earlier
+	 * (for example because DPRX negotiation failed) and they do
+	 * not get hotplug events of their own, so re-check them now
+	 * that there is potentially a new DP OUT to pair with.
+	 */
+	if (tcm->hotplug_active)
+		tb_add_dp_resources(sw->tb->root_switch);
+
 	tb_scan_switch(sw);
 
 out_rpm_put:
@@ -1971,8 +2007,10 @@ static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
 		 * also tear down the tunnel and try to re-use the
 		 * released DP OUT.
 		 *
-		 * It will be added back only if there is hotplug for
-		 * the DP IN again.
+		 * It will be added back if there is hotplug for the
+		 * DP IN again. Host router DP IN adapters do not get
+		 * such events, so they are re-checked whenever a new
+		 * DP OUT or device router appears instead.
 		 */
 		tb_tunnel_warn(tunnel, "not active, tearing down\n");
 		tb_dp_resource_unavailable(tb, in, "DPRX negotiation failed");
@@ -2234,6 +2272,14 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 	list_add_tail(&port->list, &tcm->dp_resources);
 	tb_exit_redrive(port);
 
+	/*
+	 * Host router DP IN adapters removed because DPRX negotiation
+	 * failed never get a hotplug event of their own. Give them
+	 * another chance now that a DP OUT became available.
+	 */
+	if (tb_port_is_dpout(port))
+		tb_add_dp_resources(tb->root_switch);
+
 	/* Look for suitable DP IN <-> DP OUT pairs now */
 	tb_tunnel_dp(tb);
 }
-- 
2.53.0

