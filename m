Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E22AE78;
	Fri, 16 Oct 2026 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123487; cv=none; b=M2colbPlAReXR73QLS2WmpSpDWSk58tPSJSzrQqOLUpIe5GqbVnX+HG7X2By1NYLxyT6tApdMbz4BZ1Gq5335TSAPRmk5DgjjKAUtY85T2GXkPpyTsVgIgsSnwsFlTMkXK+TmGY+k7YBu2anfSUe9lgUKOvXY0Q4tL8LVdarxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123487; c=relaxed/simple;
	bh=dBccgCuaVzH+N1Rz9JtQ4trlumXJHxiMaEFh5SW0AVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cZ8F1fDCqSuQyaovFQfkGy54+VJIcJcgFGTo9OZe1PDSKXSLaLGkqlyMXeA1lrPftOwKPQ+aoQpzpTfkQFULqy6U8T4JvvNT/zNR5uIpfscBYLmwTGPpakbO0phiO3klReRCEBx10FUMlo60A0CqorMaKgxeZE2CdyrWTuhwziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DJ0fKwU5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DJ0fKwU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4b
	e52hP6zWTa7KhzJ+Re6k7CxAgZ28hbTTZrb39cHuQ=; b=DJ0fKwU5o3ImQNDeeT
	WDSGSmMdy7SiT7PGFC05iOutxAHlgN4QAJGjby2sksLWDyxlmiwyogbAmBopu1XU
	qkJZpcl6qfWknwpPEwUisofajMjIURRaP+acp5r0MO40TMUBTkWBOwB/09XPMSIM
	f8YixgMtZMYWbM6d/xxixriPU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_5MzotFqa0TGAQ--.25685S2;
	Fri, 16 Oct 2026 12:04:04 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Tao <taowei@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Fri, 16 Oct 2026 12:03:30 +0800
Message-Id: <20261016040330.59041-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5MzotFqa0TGAQ--.25685S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1Utw13Gw4DZFW8Zr1xuFg_yoW5JrWrpF
	9rJw1rJw4kZry7G3s7Ar1kZ3Zxuw4IkFy8CF4Ikw45JwnrGF1vkw10g34SgFsrCFWrAayr
	JFy5KrW2yr1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jCJP_UUUUU=
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC-RTEBmrRojQvrAAA3F

flow_change() calculates perturb_period by directly multiplying
nla_get_u32(tb[TCA_FLOW_PERTURB]) by HZ, without any overflow
protection. Since perturb_period is a u32, the multiplication
overflows when the value from netlink exceeds UINT_MAX / HZ.
The result can be an unexpectedly short period or even zero.

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10

With HZ=100, 42949673*100=4294967300, but UINT_MAX is 4294967295,
so the product wraps to 4 jiffies.

Both the filter-modify and filter-create paths in flow_change()
are affected.

Since perturb_period is ultimately fed to mod_timer(), and
calc_wheel_index() internally casts delta to signed long for
comparison, reject values greater than INT_MAX / HZ. Besides
preventing the u32 multiplication from wrapping, this also
keeps the relative timeout within the signed-long range on
32-bit systems.

Fixes: 72d9794f4447 ("net-sched: cls_flow: add perturbation support")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Tao <taowei@kylinos.cn>
---
 net/sched/cls_flow.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index a9ac3acf6eda..29d1042a1988 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -408,6 +408,7 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 	u32 keymask = 0;
 	u32 mode;
 	int err;
+	u32 val;
 
 	if (opt == NULL)
 		return -EINVAL;
@@ -486,7 +487,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (tb[TCA_FLOW_PERTURB]) {
 			if (mode != FLOW_MODE_HASH)
 				goto err2;
-			perturb_period = nla_get_u32(tb[TCA_FLOW_PERTURB]) * HZ;
+			val = nla_get_u32(tb[TCA_FLOW_PERTURB]);
+			if (val > INT_MAX / HZ) {
+				NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+				err = -EINVAL;
+				goto err2;
+			}
+			perturb_period = val * HZ;
 		}
 	} else {
 		err = -EINVAL;
@@ -504,7 +511,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (tb[TCA_FLOW_PERTURB]) {
 			if (mode != FLOW_MODE_HASH)
 				goto err2;
-			perturb_period = nla_get_u32(tb[TCA_FLOW_PERTURB]) * HZ;
+			val = nla_get_u32(tb[TCA_FLOW_PERTURB]);
+			if (val > INT_MAX / HZ) {
+				NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+				err = -EINVAL;
+				goto err2;
+			}
+			perturb_period = val * HZ;
 		}
 
 		if (TC_H_MAJ(baseclass) == 0) {
-- 
2.25.1

