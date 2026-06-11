Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35072426EBF;
	Thu, 11 Jun 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195168; cv=none; b=Zz3X02an3RvTKSOd9w66k2pe7RuaoUhY9Rbe66D8Le+p7MAa9Y0jLwh9Ep5m6tn52FPL2DUQjkP1wvntfm2AQHbn5qflkd2MwPE1t+KYRMthZNd3SwNekkT86TPN7orJog2qs//0hn19uAnHz1a0NxRuxfpRQJ6yjUIINkES97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195168; c=relaxed/simple;
	bh=HQwtJaedgsqPooR7mPQBcOpOaTxPXNP5nqSTbE6Ent8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slo4V0nN8nYgMKUz/PDgkHlXP55oNtEINQe8/mcHSv/csp1EjQDfQSjUaUtRSoen34sA8nekYMHQpLbP3HekB4ZwCHwX9Wnwe3txojMiAZL/xxZMddqefvCdPSz0RovrTiELnF+2cZppRiw3WWiTkovXUWPGpy32jbda+z/GJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowABX7RCW4SpqkvQZEw--.3644S2;
	Fri, 12 Jun 2026 00:25:59 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] devlink: fix refcount leak in devlink_nl_reload_doit()
Date: Fri, 12 Jun 2026 00:25:57 +0800
Message-ID: <20260611162557.98150-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7RCW4SpqkvQZEw--.3644S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Zr1UCw1fZr1UJr4xWFg_yoW8Gw1UpF
	1Sk3ZrCrW7Jr13KayDXw43WF429F1jqrW5Cr1Sk3WfC3ZYgFnYqr18G3WS9ay8Ars3K34j
	qrWUKrWrZrWDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoPA2oqzjQvPwADsp

When devlink_nl_reload_doit() is asked to change network namespace
(via DEVLINK_ATTR_NETNS_*) but the reload action is not
DEVLINK_RELOAD_ACTION_DRIVER_REINIT, it calls devlink_netns_get()
which acquires a reference on the destination net namespace. Then,
after detecting that namespace change is only supported for reinit
action, it returns -EOPNOTSUPP without releasing the reference, thus
leaking the net namespace.

Fix the leak by releasing the reference with put_net() before
returning the error, for example by adding it directly on that error
path. A cleaner alternative is to introduce a common cleanup label
that performs the put_net() if the pointer is non-NULL.

Cc: stable@vger.kernel.org
Fixes: 2edd92570441 ("devlink: don't allow to change net namespace for FW_ACTIVATE reload action")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/devlink/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..fd5633fa88ec 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -578,6 +578,7 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 		    action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
 			NL_SET_ERR_MSG_MOD(info->extack,
 					   "Changing namespace is only supported for reinit action");
+			put_net(dest_net);
 			return -EOPNOTSUPP;
 		}
 	}
-- 
2.50.1 (Apple Git-155)

