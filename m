Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528043;
	b=qs1tCRZ+Z5JvCesyql0uIcCiBNZFJ/m/v//Ig6UrnQGfvgaBobyz5VMRLKMjujxtdKXN
	 SkpRg4wGLeKIQHAXf0JjR5V5H60IJTOOE9pR6Ju9h/OEKKPpAO8V90WpWPMHM94Vww6RH
	 /Dhm+/L6zQLqUP/wb7mzRMxkrDKIIor+Pb2584lmWcztHOCKOVw2/3V9TLglu0AqONje2
	 cWWj0DZsJFKv2YTkoey9KDSZRBy+lDCbrBT7vU2VYpzQ/9yQM5x08WWArlbnDITPcGYQ7
	 mhdmD4kfmj7N9wMzIVPqp3mSGHWdOsNDwPwqtsIm6qvH8W/OxXKA1+OAjXGLyGi9QYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528043;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=pozseQb4WC7A1P13dfxO2zH3hVpjW8dCUT3pdYQ074U=;
	b=n3SAh2nk4F/H29/WTWrBdSm8BD8xxHgRsKiXb4FxdeBqZHXCufDAmv1H0Zb+dl0W07uh
	 K6EIYyW61egvy3RbdNr/CqOkkAlvKrGHhGhIUrWW0q1EsisYUnaHDrghurlE1DUXSJ3pR
	 OwQ+Kl2gQkhGkwIwPXywfO0anol4E5jCTDANGavKW8DoQn9bFHe8QVCLxK5OpzGSFrJAy
	 hdMkUBhVZXr+45Yw77fohBFnX8vuCYLRg3aKj5X5kGVLJ7g9XcF3cEG1QZXo1z87v6vll
	 DPoO3RT8rk186Z1EtXRw+0gAWpXyvif+eo/QTa3NC9S+uZ4Z5xeZWrWYwZddVDCGKIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MsQnSWTC;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B112606A32C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B112606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MsQnSWTC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E6050C5CD64;
	Tue, 20 Oct 2026 20:28:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4994360393;
	Tue, 20 Oct 2026 20:27:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8551610328E34;
	Tue, 20 Oct 2026 22:27:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792528039; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pozseQb4WC7A1P13dfxO2zH3hVpjW8dCUT3pdYQ074U=;
	b=MsQnSWTC4RSL8xBqvuWKkBWxEPb/X0VN1wCIpRidK+tnlmf6gahOeDOZVgylH1LTA8Aeyk
	c+xyhAecudB65T+kf2nXtNy08Hiiq3PuBZ6iEgeu1JnpSBmQVF3nyB+XrH4cumsByXrJjx
	j9MfT69MJE/gbz9YPYAE8YbrSprKGbaNbb07//UHYGapMv6uMHr80DyNobDWTnjfatF5in
	SowLz3aujPfPhbmJDmAeWif5pDrsQRP5LrB/YcIdihzznmLjd14BEhJmhwVytY5iXSUjVC
	c1fiFFDbYmH42PQyeFHJWN3GgT+1YfUluAvWsDF4UWGcBqCTQaagvoPag/mqSA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 22:26:36 +0200
Subject: [PATCH] net/sched: cls_u32: skip hash tables in u32_bind_class()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cve-2026-74739-5-10-v1-1-c4b65c36f234@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1hKYiApV0EdIBhwB1olFCGh3
 J3Qjm/4/4TIQThCW5wQeJco7zVDlwX4pV9nRhmzwSjTaGUU+p3xBtrK0gNr1App8DXZkZxzBLn
 8BJ7k+F2759/xO7zYb/cKUroACw4b1HcAAAA=
X-Change-ID: 20261020-cve-2026-74739-5-10-3bc537d38883
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Zhang Changzhong <zhangchangzhong@huawei.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792528017; l=1965;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=C5m7oNXli4kbXFHbyFnrNOBmo3bf0rn4QfSO8scql2A=;
 b=auB3KMIzdX4uCm+CYd3e/RvRGJaYA8xOlxjmxTEHqoZEgNKaeDUtkJgdkILmcokd7s0CSWyBX
 No+/yEQn9XfCwKeTm4zojJOsZeWe92oIvYShWPNu+2zArd/YVBqRWY9
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Zhang Changzhong <zhangchangzhong@huawei.com>

[ Upstream commit 6d3724e616faf952c3adcf8414fc21a828ef3709 ]

u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
through the walker callback. u32_bind_class() unconditionally casts the
passed fh to tc_u_knode and accesses &n->res, so when fh is actually a
tc_u_hnode, which has no tcf_result member, this results in a
slab-out-of-bounds read of res->classid in tc_cls_bind_class().

The issue can be reproduced with the following commands:

    tc qdisc add dev lo root handle 1: hfsc
    tc class add dev lo parent 1: classid 1:1 hfsc sc rate 1000kbit
    tc filter add dev lo parent 1:1 protocol ip prio 1 u32 match u32 0 0 flowid 1:1
    tc class add dev lo parent 1: classid 1:2 hfsc sc rate 2000kbit

Fix this by skipping hash tables via the TC_U32_KEY(handle) check.

Fixes: 07d79fc7d94e ("net_sched: add reverse binding for tc class")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/sched/cls_u32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index e501390ccd75..dfdd6fbe3787 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1303,6 +1303,9 @@ static void u32_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
 {
 	struct tc_u_knode *n = fh;
 
+	if (TC_U32_KEY(n->handle) == 0)
+		return;
+
 	if (n && n->res.classid == classid) {
 		if (cl)
 			__tcf_bind_filter(q, &n->res, base);

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261020-cve-2026-74739-5-10-3bc537d38883

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

