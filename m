Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCD3E3DAB;
	Fri,  4 Sep 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538852; cv=none; b=g1Zwz+A2qgK/KZvHrOwuD1AgpXhiutWmdSJHMwZFOn7duB54deatMGfY4K7W+BRghQMA3KtRYoctOlM9Q729pJ5mEyC9h0waW0zg3BB1Q/+QL2hKht/WmUXz9etMLvu7LHXWrxZfoGv8Jo3HjIev4MWF3OgyD1HYyNs4N0hr77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538852; c=relaxed/simple;
	bh=0cwGCt6hrRq8xg9wyN+h9VmZMCk/bmEBDFWVngdzaGY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=AmpqH6r9OwgaxOBOLaujDYnhLMQxYIEBc+ZDOXSu3dgZ2nGErF56UpsISI5YYxP8wAb8IuB5TB+shUskDYuWPKPvYzqlNLciCZHS30il09y8ssyZL8kAFo45d4wKzCDNPuSSqSMDpO+FuhpNf9BoXrSnUmIQB/j1nMeF5sq78pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RMVX3uEt; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RMVX3uEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788538846; bh=pQhTt8C1RqJwYOxWHzW/WHRbox3l1hLIdTRTAGI6ghk=;
	h=From:To:Cc:Subject:Date;
	b=RMVX3uEtCsg/8dy021tGiWhNwU8+GVNfrtySttM4qozQaWgzX8I5X3wjzlp3sLVf7
	 5eJlw3Te+aL6dcMr/PYJ8MPXscJmex2XJcf0Jm+0lQJbevdVAnI6ZAVXBr+w84GQ7G
	 hFwJSqb018AocYHJZQYueydGrmS00eEXEv3fwKmE=
Received: from xgyy.localdomain ([2408:8352:603:550:7022:3b83:9f7:e2a7])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5248FCAA; Sat, 05 Sep 2026 00:20:36 +0800
X-QQ-mid: xmsmtpt1788538836ty70909dc
Message-ID: <tencent_3A964832542399A780E646D6A6246335C409@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5S5wA3es0TOFpevCas9KqmgAfUL3rdRKShuGwPlRlASVByNv1h1c
	 KkNZ4QRag8HZVIIHkTQsQrtQ6DBayHRQxKEOGA+ex6X5AaZj22NwSa52UWFW8UdXk0SPrRvFQ77f
	 +w+nsbi9FX6phOyPLJlCnkPQ+JW/oHiyQQpUFOPViVvr7MR0tr4Ej2fVj6/RvwMf4hNt18RgrESD
	 DPhCqK0nFGW0BxiHvZZgJhYMbKnUN0AK5p95qdSbRNX+fPXGR9oZm/es7N/o5khcbsEmpuol/stY
	 RVbQOSEjx1nOqxa9OQty4b9UWYE5jmg7mkUjvCL6FN07GEvfjeoNOAyIDVOPJHFyvhwv9ccSm2hf
	 g7HY6hjQjIuaRsaBaGT1R/bD7pH9ZkL8q2MRIZBjn6Lnn/xKf7PfTqzNSqDmFLtKXAx8nGm4v87q
	 n4x4rfQqX4T+lXNgien+MZLlxbRVKGMtvfe8OaLKlhUyuobcN7lVwTDADDTKKz5zAYAM3o1tzeeo
	 05pf0ytQZ9Z3iwQxU3B2UsuVSz4haKxySxIl60G5hucFhMqDM2y4f4gl2dW46tOU1UhWam4adrQk
	 mfqpB+BndSNpYSfjkmnUeCO15K85Tc9ovbx293TvArqvpngrSzW1K7X81JjR9yKIPKikgoLMfnCi
	 J0BricKd+J9vDWf+pw29YX2AgjEswPui6UjuITTdqWyAbzZkGPi/IdmjYMrX2YeMaH7p/P/w1Cnq
	 AdOnnnkYXPUmEqMoSg+pFX8n5OTBCoaOF0f9CmRMfPnklUUUxlzqYps9yw5KKS1MQnIM8VBAfBgL
	 XUuQO/dtRHpr2kIl8PW9ivK/n6T1YaCsFew2z2R3tODIejQfW1fMAT8oDDiyRR5PnMcl3jYhHMMM
	 pLn/qKbEV/vXewXchiah9Pltch1YKWsXZI6goM3T/zCrc+fZACUa/8qcAriJNALepHGCwWwXiwxW
	 xrEGPBVt3uIbWD47BP4u5a4cDCWGGmLAigy+nI3PoZ//hKPniqZk8vqnc8lteZpIsxaBfWpqyYny
	 iGTXwZC/yYkUsiwHR7sigpDbfqXFTKRDpJrkglW0/3h894VEM6rta1beLcJEKjWSv9SHr1g4xZLv
	 71gdDOaqxl+sqT4ZMUNO7E/7WM3A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhu Ling <zhuling0805@qq.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] can: netlink: fix static FD-NON-ISO mode validation
Date: Sat,  5 Sep 2026 00:20:31 +0800
X-OQ-MSGID: <20260904162033.13431-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static CAN_CTRLMODE_FD_NON_ISO mode does not have to be specified when
CAN FD is disabled. Since commit 6742ca18cb41 ("can: netlink: add userland
error messages"), ctrlstatic_missing is calculated before applying this
exception. Disabling CAN FD on a controller with static FD-NON-ISO mode
therefore fails with -EOPNOTSUPP.

Apply the exception to ctrlstatic_missing instead of modifying ctrlstatic.
Keep the original static mode mask and restore it after applying the
userspace mask, so a request that disables CAN FD cannot remove
CAN_CTRLMODE_FD_NON_ISO from priv->ctrlmode.

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
v2:
  - Apply the FD-disabled exception to ctrlstatic_missing while keeping the
    original static mode mask intact.
  - Restore the static modes after applying the userspace mask so they cannot
    be cleared from priv->ctrlmode.
v1: https://lore.kernel.org/all/tencent_B5154AEA68C02E81646C47664F2DCCB5AD0A@qq.com/

 drivers/net/can/dev/netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..1f67871020a5 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -332,7 +332,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
-		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
 
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -357,9 +357,9 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
 				    CAN_CTRLMODE_XL_TMS);
 
-	/* clear bits to be modified and copy the flag values */
+	/* clear bits to be modified, copy flags and restore static modes */
 	priv->ctrlmode &= ~cm->mask;
-	priv->ctrlmode |= maskedflags;
+	priv->ctrlmode |= maskedflags | ctrlstatic;
 
 	/* Wipe potential leftovers from previous CAN FD/XL config */
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

