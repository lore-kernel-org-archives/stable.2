Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527912;
	b=YpVdBn1drMNSlmKr/I+q1/qxqPpTERKwzxVNXFbFM1y1T5z7LXTaDNaFLQDwxNBEclJR
	 eStHLQmETcd6wTKfRxmT4BEYUDtsKteoY/yUOQxnm6RSWstcpgrvAtJZaerFrVWk76UNC
	 7Bq8lmdWNX7Xn7QX/EJ+NUFohXmdnooVDD9/TLnbZSL9Y90kbkOMWuSvCW0ZyUDWqn+wF
	 Eb+86ZK4NovkkMUJc+bPINW5zvJ2JLAND5+0ciq5XQXFtSpUFHtD0JcmXsO1U1oirykOZ
	 9XvZL6yXRo6O5zpPtOytEt2KP3QByg/59Q/Eh2Tls2RhgK3yqLBYDdEkg+uvBgfagJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527912;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=9jwjEa/Cjtxu9fBrnz4xAlY8KFwcNbg6ufNDqICcUGI=;
	b=0fcLxvDllthqRGp0Aq+4C/4O1gEDhMAcsd1LyrvF0bdc878Omt/DZUTJCvqjnE1DAejD
	 0KVfYhQt0iOdlGflTxfcZqI2nRP3IZM6F5ukItEF8v5Aq7iNL/SCV7f+872D6AMumon7F
	 XdW/VfRMMgK7ct4jmlcE7LoRJHHZtaICokm2GXWAsM5w2w1nXY3a8ECL6bRloo6liQBjW
	 qcaEApvK3KHZMCjVxRP6mzjLOFvAEXfF/IFCidJfP8dQ5uM7HHq53NrE8Ad3i+RgN4aYK
	 75hTuRxJupWylb3K2RoWSkxodSrEV9sfroH0KXLhpgBS8FOeXBIdF+VFAzHgm6BTJsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1R5spU2b;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC291606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC291606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1R5spU2b
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 338EE4E41290;
	Tue, 20 Oct 2026 20:25:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D8B7760393;
	Tue, 20 Oct 2026 20:25:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9236910328DF9;
	Tue, 20 Oct 2026 22:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792527903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9jwjEa/Cjtxu9fBrnz4xAlY8KFwcNbg6ufNDqICcUGI=;
	b=1R5spU2bpmnK6iO5VGpu8IoE3vWCutNtYQAMr61WJ2AxjhSY1c/CaSV3nUA/jRifNgN9Wq
	BuFnx3B0peEuaO1mU/f+8NmfkbukTjc+5ZLmxj+tzGmfzz3DWSrIdXww9P9OM85JycOa+C
	SDWHwsr6WQUNMHGX8pAew/4ntl7M8rGYwPMxvInHlK1F1V82SpfLXrPcUVYZZqw6GhSuAa
	eX49QmrdwrWfAtbLBO9q2OCq6Z3RmxXe3RRL1YR3UnoWf5oE+IJeXsxd4LuKJ3bjRvhJIB
	faU3XYa7sTrgmsL5Cfxe0x8iHa2Hj+MzYhugxlTld3/5hnT5oPnkixHjFueJVg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 22:24:58 +0200
Subject: [PATCH 5.15.y] net/sched: cls_u32: skip hash tables in
 u32_bind_class()
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
Message-Id: <20261020-cve-2026-74739-v1-1-f63ae6c92cfd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc2ZJWyxNeRXiwdZV1wOaFgmE8
 O4WPX6TzL8hcxLO6KsNiWfJ8hoLdF0hPi7jnUmuxTDKdFoZRXFmOkDu5FpP3nfOtjYoHSLK6Z3
 4JssvOMA22jYrzv89f8KT43TUsO9f+r8OAHoAAAA=
X-Change-ID: 20261020-cve-2026-74739-9967535b01bc
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Zhang Changzhong <zhangchangzhong@huawei.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527900; l=1960;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=jgoXXB8H33Z3xRymMqIUudkbVFtuqCP4zCoagmspP0I=;
 b=P0VvIetMC19D6TufkTYUIJd2UJF17bL+jsgfAE+nBZyJGHDTylNPEtJZxIOkOqUSpoV1pI21x
 Cgoi+0ynltfARyGiNG46SQoNIxfDNBF0D16ytKIhBldTj1SBen6F3rY
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
index 23f9e2b5f3b6..4e623c5c9bec 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1298,6 +1298,9 @@ static void u32_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
 {
 	struct tc_u_knode *n = fh;
 
+	if (TC_U32_KEY(n->handle) == 0)
+		return;
+
 	if (n && n->res.classid == classid) {
 		if (cl)
 			__tcf_bind_filter(q, &n->res, base);

---
base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
change-id: 20261020-cve-2026-74739-9967535b01bc

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

