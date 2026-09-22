Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548CC3D6CCA;
	Tue, 22 Sep 2026 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064734; cv=none; b=YF394gJ092VAqZdd/pNQ5BL6R54E7J7J6wvOgyfcp4M1nGhqTrXQ0KMEet6alu7fAdTaHGiyBeDzMszfgL+2lN2z+pDSwjI25NqNzoZpdNuLyIDdFdzd5r34oawBfM/KaRXhaaarjGtKg50dkmnNXd6xNsXTTe+GiU6hnQLMLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064734; c=relaxed/simple;
	bh=3uY1ZzQFjuNnByobm1ruIq7eFhX6iux2RNyqlgkn5iI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tGqsXyAE1IVk9EnO0CGOajzKeOfF/dUCaSBW7KW9B4E/x3YDMDSFbkiknIq2vHoYAiIxbE5oHY5FB2s7dAWkLTjfxX1XnOceTpzyMm6nFTBP48gKp53VZB5B81uSMJE1mVVv8qi7uRFM73Id+/THoaawrNFcAgs/1sXBTgHUFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3SGREOLJqY5MtAQ--.1323S3;
	Tue, 22 Sep 2026 16:11:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAnl8xDOLJqObySBA--.33459S2;
	Tue, 22 Sep 2026 16:11:48 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] PM: EM: Fix use-after-free of perf domain in netlink doit handlers
Date: Tue, 22 Sep 2026 08:10:52 +0000
Message-Id: <20260922081052.321581-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAnl8xDOLJqObySBA--.33459S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?xWOwzwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2uaDNMb7vQ75MmoQ9iB71T+wILGpmjwP10e21M2U3fDg67
	kMmEGEwP0XnGFdBH/aLN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw1xZr4DAw47KF43Kw4UAwc_yoW3XF47pa
	y5Cr9rXr40qrWjv3WIkF18uFyayryrXr42v3y3Kws3Ar1qqrZ8ua1YgF4j9FyYyryxWF1a
	yrsFqFW3Cw17KacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

The doit handlers dropped em_pd_list_mutex before dereferencing the
perf domain, so a concurrent device unregister could free it while the
reply was being built.

Encode the reply from em_perf_domain_for_id() callbacks, which run
under the mutex, and allocate the skb outside of it, like the dumpit
path already does.

This issue was found by an in-house static analysis tool.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Fixes: f2d2946eaa5c ("PM: EM: Implement em_nl_get_pd_table_doit()")
Cc: stable@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 kernel/power/em_netlink.c   | 122 +++++++++++++++++++++++-------------
 kernel/power/em_netlink.h   |   8 ++-
 kernel/power/energy_model.c |   8 ++-
 3 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 4d4fd29bd2be..1f68d456a713 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -95,41 +95,62 @@ static int __em_nl_get_pd_for_dump(struct em_perf_domain *pd, void *data)
 	return ret;
 }
 
+struct em_nl_doit_ctx {
+	struct genl_info *info;
+	int cmd;
+	struct sk_buff *msg;
+};
+
+static int __em_nl_get_pd_doit_fill(struct em_perf_domain *pd, void *data)
+{
+	struct em_nl_doit_ctx *ctx = data;
+	void *hdr;
+
+	hdr = genlmsg_put_reply(ctx->msg, ctx->info, &dev_energymodel_nl_family, 0,
+				ctx->cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (__em_nl_get_pd(pd, ctx->msg)) {
+		genlmsg_cancel(ctx->msg, hdr);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(ctx->msg, hdr);
+	return 0;
+}
+
 int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
-					      struct genl_info *info)
+					     struct genl_info *info)
 {
-	int id, ret = -EMSGSIZE, msg_sz = 0;
-	int cmd = info->genlhdr->cmd;
-	struct em_perf_domain *pd;
+	struct em_nl_doit_ctx ctx = {
+		.info = info,
+		.cmd = info->genlhdr->cmd,
+	};
 	struct sk_buff *msg;
-	void *hdr;
+	int id, ret, msg_sz = 0;
 
 	if (!info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID])
 		return -EINVAL;
 
 	id = nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID]);
-	pd = em_perf_domain_get_by_id(id);
-	if (!pd)
-		return -EINVAL;
 
-	__em_nl_get_pd_size(pd, &msg_sz);
+	/* Encode under em_pd_list_mutex, like the dumpit path. */
+	ret = em_perf_domain_for_id(id, __em_nl_get_pd_size, &msg_sz);
+	if (ret)
+		return ret;
+
 	msg = genlmsg_new(msg_sz, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	hdr = genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, 0, cmd);
-	if (!hdr)
-		goto out_free_msg;
-
-	ret = __em_nl_get_pd(pd, msg);
+	ctx.msg = msg;
+	ret = em_perf_domain_for_id(id, __em_nl_get_pd_doit_fill, &ctx);
 	if (ret)
-		goto out_cancel_msg;
-	genlmsg_end(msg, hdr);
+		goto out_free_msg;
 
 	return genlmsg_reply(msg, info);
 
-out_cancel_msg:
-	genlmsg_cancel(msg, hdr);
 out_free_msg:
 	nlmsg_free(msg);
 	return ret;
@@ -148,19 +169,6 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
 	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
 }
 
-static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **attrs)
-{
-	struct em_perf_domain *pd;
-	int id;
-
-	if (!attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID])
-		return NULL;
-
-	id = nla_get_u32(attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID]);
-	pd = em_perf_domain_get_by_id(id);
-	return pd;
-}
-
 static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
 {
 	int id_sz, ps_sz;
@@ -245,34 +253,58 @@ int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain *pd)
 	return -EMSGSIZE;
 }
 
+static int __em_nl_get_pd_table_size_cb(struct em_perf_domain *pd, void *data)
+{
+	*(int *)data = __em_nl_get_pd_table_size(pd);
+	return 0;
+}
+
+static int __em_nl_get_pd_table_doit_fill(struct em_perf_domain *pd,
+					  void *data)
+{
+	struct em_nl_doit_ctx *ctx = data;
+	void *hdr;
+
+	hdr = genlmsg_put_reply(ctx->msg, ctx->info, &dev_energymodel_nl_family, 0,
+				ctx->cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (__em_nl_get_pd_table(ctx->msg, pd))
+		return -EMSGSIZE;
+
+	genlmsg_end(ctx->msg, hdr);
+	return 0;
+}
+
 int dev_energymodel_nl_get_perf_table_doit(struct sk_buff *skb,
-					    struct genl_info *info)
+					   struct genl_info *info)
 {
-	int cmd = info->genlhdr->cmd;
-	int msg_sz, ret = -EMSGSIZE;
-	struct em_perf_domain *pd;
+	struct em_nl_doit_ctx ctx = {
+		.info = info,
+		.cmd = info->genlhdr->cmd,
+	};
 	struct sk_buff *msg;
-	void *hdr;
+	int id, ret, msg_sz;
 
-	pd = __em_nl_get_pd_table_id(info->attrs);
-	if (!pd)
+	if (!info->attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID])
 		return -EINVAL;
 
-	msg_sz = __em_nl_get_pd_table_size(pd);
+	id = nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID]);
+
+	ret = em_perf_domain_for_id(id, __em_nl_get_pd_table_size_cb, &msg_sz);
+	if (ret)
+		return ret;
 
 	msg = genlmsg_new(msg_sz, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	hdr = genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, 0, cmd);
-	if (!hdr)
-		goto out_free_msg;
-
-	ret = __em_nl_get_pd_table(msg, pd);
+	ctx.msg = msg;
+	ret = em_perf_domain_for_id(id, __em_nl_get_pd_table_doit_fill, &ctx);
 	if (ret)
 		goto out_free_msg;
 
-	genlmsg_end(msg, hdr);
 	return genlmsg_reply(msg, info);
 
 out_free_msg:
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index 583d7f1c3939..bc98a3c278b9 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -12,7 +12,8 @@
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 			    void *data);
-struct em_perf_domain *em_perf_domain_get_by_id(int id);
+int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, void *),
+			  void *data);
 void em_notify_pd_created(const struct em_perf_domain *pd);
 void em_notify_pd_deleted(const struct em_perf_domain *pd);
 void em_notify_pd_updated(const struct em_perf_domain *pd);
@@ -24,9 +25,10 @@ int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 	return -EINVAL;
 }
 static inline
-struct em_perf_domain *em_perf_domain_get_by_id(int id)
+int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, void *),
+			  void *data)
 {
-	return NULL;
+	return -EINVAL;
 }
 
 static inline void em_notify_pd_created(const struct em_perf_domain *pd) {}
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index e610cf8e9a06..a76089e2ce8c 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -1031,7 +1031,9 @@ int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 	return 0;
 }
 
-struct em_perf_domain *em_perf_domain_get_by_id(int id)
+/* Run @cb on the matching domain with em_pd_list_mutex held. */
+int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, void *),
+			  void *data)
 {
 	struct em_perf_domain *pd;
 
@@ -1040,9 +1042,9 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
 
 	list_for_each_entry(pd, &em_pd_list, node) {
 		if (pd->id == id)
-			return pd;
+			return cb(pd, data);
 	}
 
-	return NULL;
+	return -EINVAL;
 }
 #endif

