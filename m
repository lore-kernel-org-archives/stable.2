Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF860283142
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512139; cv=none; b=PxFGEmL1aU3375nhnjzS0hxZHBqJhaWle+QBd3LWMie+kCDsdeuN60hWjg7saAzdwTaM42V0mE2wsEPFhd41hFI7DJVm9q+gcaxS1dTcLHQ8iO4QhKvnxiwX9jmh523+rSLriERn0LXV70/x+5IbRGLKYJCkjU75pvYUs3+cu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512139; c=relaxed/simple;
	bh=ibwpRO9tdzRnB9hwRdiCbyvha37TSoCPH2xljG79eqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WURkPEZ7YUg9i+IqazwUxBAhx1rXlcuEqN7j1EEdugP0EuSKvg0Y+39tiJPDnogsWocvPr9UbYVDEhz3vGyxsbdULRuDUhnNSBeHGDPnrI7PhX/jP5zNwgYnbsOvHGQGc0whzBFcn31QVNAqwUfkeQgojgQfugiWS6sSxMwnM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6yiS7e4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6yiS7e4"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso407277a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786512136; x=1787116936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=diIcC2mYMoxigl9uIM8y5rRAYyfw1dzo8pm6pfntNRk=;
        b=C6yiS7e4PB8oRktQoMCAxAAJabO2rmAayk6dsKGP62eRfqZYQqqKplfM3kRVHHXf+m
         GYkN8pCMwWYBaqt5q5O5xOWa5pEpfD5CE9IMSMxfhGUjqXzVrqEbOZA8mUghJcML9SoH
         HZO2oDmPdavfvqg2u1fLenRlFoYpASYx90Ue4lDe35Q6gsim2j3NXxk+f3aohlrz1eGd
         TBqClMezJOgNJ2SSqOxnY7FYTon1t3n6/VJp/cO7ExNuVKWgxVBCKRcxNNf3H41bxDJz
         uuWpEa0QxQFb34qQ44AmqZM+Ann2IwNxJvEdoeZHxDf5tUkTGsxWqKpEjreSOGiIeJ/d
         67sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786512136; x=1787116936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diIcC2mYMoxigl9uIM8y5rRAYyfw1dzo8pm6pfntNRk=;
        b=BSo8Wo2bKjL3GSXiK77JDZlPHbxlSdcYkJSPEzwt+oNSuP6dca26KMrvyBaIlDb7C7
         yfJxw2Vujze7JHkIcjWGbO9UmkWonJntaLDPzb9+MLX3PRZii7jlpGaeF0EFbAJza4aF
         HrpSA8Ltd+AEwwYbrKAMWIn1yri0c/jAKvLvkMHugJZG11OLqBATTFh/xYkSrNdIAw8f
         nQ+hJHJ64azOls6I5uLCaHrFJjBvUjLMJbJdpLzkfksCmFzhZYAykQGfP2J+it9qx72E
         2oZTGMHebEvs+obeWMg4hb8yGnP1dthKFkfZmbdOIq39K3Unf/hTGjhiI6D0u8PPtY5r
         DLOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/sLSiQBMbtxfGkMqVMMTiFuoKkmEVG2svbUFWnwuBQmSq4ykmxf+meJtkfDzdVC8o7bFDOOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUE8lU/28AU0A5oPtPmJ3xVuZUxTpVZbjp8Tsix1qUaBP5dg/h
	XR7RaRLmYmwVXu2b84QBiiImCMDe/TZE8pDBliV5gHb5lyGYyTj543j5
X-Gm-Gg: AR+sD13k1OZNTUpOkgowjUhJTmCLh6dS7kXA1M/kRX1M0vSVzSHSoHNgQf/BFo9fmsT
	jcQNoju06OnuEa19yzK30X2vmgjktlrzmwZ+8a+SV/FED82kTynbws0vImSGt4WlLNrAfXdvsc8
	WH0zMuL4aqBYrIK0wfUsp8o3KriKNbRe456tMNQw0Y8Vp8FezPeUnP/s5BtRQMCb8lXt9B7dTo4
	jaFmfz7n+XE/fJ3ELcHxt0k/QtPpFMvbMaebIeGl+VMekQkE6nwc5qvM+MC2kJPyz80Wj0kXzFp
	+V4unigb1vfWhIH7GwNLa0s/vZhCuonu9Ryc5VX5WhVi7ORKLk6XqSHTtu3E3v7/GSPCNtRmTPX
	jV/mly+mcfXOLl5hxTCCkZX5G9R7uuD2WMajSi7p2VwsFUANe0d2DMNE/y/GzkGUc7DEH/Lwvl7
	7iceIiFe8KZ/1m+qZqqR1IJ0ZLvrafzgYm2TRjRROYOi5GDjojBMQx7soeR46WRfALm7441q705
	5Y0KlWKqecp
X-Received: by 2002:a05:6a21:1509:b0:3c3:7cfe:b32a with SMTP id adf61e73a8af0-3cc3f735f3fmr2725770637.27.1786512135917;
        Tue, 11 Aug 2026 22:22:15 -0700 (PDT)
Received: from Vinkys-MacBook-Air-39.local ([45.135.228.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141244511afsm6026783c88.3.2026.08.11.22.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:22:15 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nicoyip.dev@gmail.com,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH net v2] net: pktgen: use a consistent flow count
Date: Wed, 12 Aug 2026 13:21:30 +0800
Message-ID: <20260812052130.32823-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_if_write() can update cflows while the packet generator thread is
inside mod_cur_headers(). The latter first tests cflows, but f_pick() then
reloads it when selecting a random flow.

This allows the following interleaving:

  CPU 0 (kpktgend)                 CPU 1 (proc write)
  if (pkt_dev->cflows) // 10
                                   pkt_dev->cflows = 0
  get_random_u32_below(pkt_dev->cflows)

get_random_u32_below(0) returns a full-width random value. Using that
value as an index into the fixed-size flows array causes an out-of-bounds
access. The kernel reported:

  BUG: unable to handle page fault for address: ffffc8fe2d2674bc
  #PF: supervisor read access in kernel mode
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 65 Comm: kpktgend_0
  RIP: 0010:mod_cur_headers+0x16f8/0x2840
  Call Trace:
   <TASK>
   pktgen_thread_worker+0x305a/0x6bc0
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Read cflows once at the start of mod_cur_headers(), pass the snapshot to
f_pick(), and use it for later flow-state decisions in the same packet.
Publish proc updates with WRITE_ONCE(). Flow selection then always uses a
nonzero count bounded by MAX_CFLOWS, while a concurrent update takes
effect on a later packet.

Fixes: 007a531b0a0c ("[PKTGEN]: Introduce sequential flows")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
v2:
  - Use the written value when reporting the new flow count.
  - Add READ_ONCE() to the remaining lockless cflows reads, including
    pktgen_if_show(), as suggested by Paolo Abeni.
v1: https://lore.kernel.org/r/20260802152309.821584-1-marsy12010123@gmail.com

 net/core/pktgen.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ee64f3012..e14bb9a48 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -566,6 +566,7 @@ static const struct proc_ops pktgen_proc_ops = {
 static int pktgen_if_show(struct seq_file *seq, void *v)
 {
 	const struct pktgen_dev *pkt_dev = seq->private;
+	unsigned int cflows = READ_ONCE(pkt_dev->cflows);
 	ktime_t stopped;
 	unsigned int i;
 	u64 idle;
@@ -590,7 +591,7 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 		   pkt_dev->nfrags, (unsigned long long) pkt_dev->delay,
 		   pkt_dev->clone_skb, pkt_dev->odevname);
 
-	seq_printf(seq, "     flows: %u flowlen: %u\n", pkt_dev->cflows,
+	seq_printf(seq, "     flows: %u flowlen: %u\n", cflows,
 		   pkt_dev->lflow);
 
 	seq_printf(seq,
@@ -675,7 +676,7 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 
 	for (i = 0; i < NR_PKT_FLAGS; i++) {
 		if (i == FLOW_SEQ_SHIFT)
-			if (!pkt_dev->cflows)
+			if (!cflows)
 				continue;
 
 		if (pkt_dev->flags & (1 << i)) {
@@ -1632,8 +1633,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (value > MAX_CFLOWS)
 			value = MAX_CFLOWS;
 
-		pkt_dev->cflows = value;
-		sprintf(pg_result, "OK: flows=%u", pkt_dev->cflows);
+		WRITE_ONCE(pkt_dev->cflows, value);
+		sprintf(pg_result, "OK: flows=%u", (unsigned int)value);
 		return count;
 	}
 #ifdef CONFIG_XFRM
@@ -2373,7 +2374,7 @@ static inline int f_seen(const struct pktgen_dev *pkt_dev, int flow)
 	return !!(pkt_dev->flows[flow].flags & F_INIT);
 }
 
-static inline int f_pick(struct pktgen_dev *pkt_dev)
+static inline int f_pick(struct pktgen_dev *pkt_dev, unsigned int cflows)
 {
 	int flow = pkt_dev->curfl;
 
@@ -2383,11 +2384,11 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 			pkt_dev->flows[flow].count = 0;
 			pkt_dev->flows[flow].flags = 0;
 			pkt_dev->curfl += 1;
-			if (pkt_dev->curfl >= pkt_dev->cflows)
+			if (pkt_dev->curfl >= cflows)
 				pkt_dev->curfl = 0; /*reset */
 		}
 	} else {
-		flow = get_random_u32_below(pkt_dev->cflows);
+		flow = get_random_u32_below(cflows);
 		pkt_dev->curfl = flow;
 
 		if (pkt_dev->flows[flow].count > pkt_dev->lflow) {
@@ -2461,12 +2462,14 @@ static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
  */
 static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 {
+	unsigned int cflows;
 	__u32 imn;
 	__u32 imx;
 	int flow = 0;
 
-	if (pkt_dev->cflows)
-		flow = f_pick(pkt_dev);
+	cflows = READ_ONCE(pkt_dev->cflows);
+	if (cflows)
+		flow = f_pick(pkt_dev, cflows);
 
 	/*  Deal with source MAC */
 	if (pkt_dev->src_mac_count > 1) {
@@ -2582,7 +2585,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 			pkt_dev->cur_saddr = htonl(t);
 		}
 
-		if (pkt_dev->cflows && f_seen(pkt_dev, flow)) {
+		if (cflows && f_seen(pkt_dev, flow)) {
 			pkt_dev->cur_daddr = pkt_dev->flows[flow].cur_daddr;
 		} else {
 			imn = ntohl(pkt_dev->daddr_min);
@@ -2611,7 +2614,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 					pkt_dev->cur_daddr = htonl(t);
 				}
 			}
-			if (pkt_dev->cflows) {
+			if (cflows) {
 				pkt_dev->flows[flow].flags |= F_INIT;
 				pkt_dev->flows[flow].cur_daddr =
 				    pkt_dev->cur_daddr;
-- 
2.25.1

