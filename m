Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844111;
	b=H0/gJVnqksjPwKIpiH4/LLiKDtF0NFtxWpPJno7CzCSFyj6TFtsdUDGlwZyUvJsF+LxU
	 Pos2ikBSHD/JDhCCZ6tUsY+GrV7yF40MJoRqSPjTcL0EVOdGk1LE41dhvMQx9sBEJZ9zR
	 7RAeGkz24Pm7C30AMt/biXHC1n+Zcmqlxiu+IRUzjRz9m4UH1hzOq/YzYdNK1IUpNXwtP
	 noG4zhC52qUW633epaMJ+Amt1e1iiQSh+x9iGlgX+GlRaaVqnZLkgzuT74Yz1sa9CzQni
	 z/9YRE4PGrU4svPqXk4of2vbDBOQ3zRtGAtn79355py6IPZYsQQ3wOscQSYT1i+6f5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W+58/eJYAEOdpebyKZhpejKCIvBBjMslhdPrEgFQ83Y=;
	b=szBhwxnlkbJsu0hT4qhbQ5iFbEesWR5EuGT3fIVDgtSygJlWI/YeclncAAGYlFIaDLGU
	 Wp2wT8NvVDd+g3HLVk5xF/e8k9VSooKHrjlXYiSSNeP8da4PVUGOAvuoTUYCzghSsbqw0
	 LP/vzMxR6xCxqL8heK8VMcYJtfH/w1H5fmA5moISTV8zu6h2XKB8rtOFLOG4iUfykVFhp
	 mVgGobCqJDwvB14cd5StHt9qp96/xbrVes3ptk/j8iwT20B+XCWTGWMCBjlzO2xnIu7m1
	 GFW+UQNNGlXJWcfIr1YIm9w8dVJGBk5KANoSap86rI3ESnqbM5/We9K4Wpofa3nB5jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mlm4gKtA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415D606CC09
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mlm4gKtA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7261F000C1;
	Thu,  5 Nov 2026 02:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844111;
	bh=W+58/eJYAEOdpebyKZhpejKCIvBBjMslhdPrEgFQ83Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mlm4gKtATsG53loqG3aLmlshVkXm57k39Wbff4OdU9fD0Yr2/hGuIWzMzZYuIBQWd
	 T3MDaxF/oiW1SxhuP57DupRCVkR8srP9ibiIGDafAgSgXkLo2zH8gKG3L0pFIOy+1R
	 zp7xcmdQVWbvEaw1t6lezrG4CAsQU6In1YBjIk89lA7MDd/CvEx2WYfo/cs9tkexxH
	 s/fiQQUFPLtvGxJAVRbNfracIK4CTKR/rqG+QNnrrfVxeKne1lezEtGZtYBhAww8cL
	 mp5zEST3S0DO3G1WprD6dhM4/Xg+0Y9nfjp2UwK8IALhLmJZgt3rA5IDT69QI98B5e
	 S3/v/Xcl19NgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Oleg Keri <okerixx@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] phy: core: Fix race-condition between _of_phy_get() and try_module_get()
Date: Wed,  4 Nov 2026 21:01:49 -0500
Message-ID: <20261105020042.1032242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110412-deskbound-splashy-7b2b@gregkh>
References: <2026110412-deskbound-splashy-7b2b@gregkh>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 090055ee629523092688da42428558ba56d4272f ]

Sashiko asked during a patch review if the existing usage pattern had a
race condition; specifically in of_phy_get() if it was possible between
returning from _of_phy_get() and running try_module_get() that a module
might be unbound leading to use-after-free.

Looking at the code this appears to be so, there is no linkage between the
phy and module under a synchronisation primitive.

Using the phy_provider_mutex in phy_get() will ensure there is a link between
the returned phy pointer and the module_get() bumping the module reference
count.

Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
same usage pattern.

phy_provider_unregister() must take the phy_provider_mutex so amending
phy_get()/of_phy_get() to take that same mutex guarantees there is no
use-after-free.

Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Tested-by: Oleg Keri <okerixx@gmail.com> # Lenovo Yoga Slim 7x Gen 11 (Glymur)
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://patch.msgid.link/20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-1-dc244e124e71@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ sashal: Placed mutex acquisition after the existing NULL-name rejection in phy_get(), preserving its direct error return. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-core.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index dac0f7f4f3d3d..5bd96f11bb467 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -117,13 +117,13 @@ static struct phy *phy_find(struct device *dev, const char *con_id)
 	const char *dev_id = dev_name(dev);
 	struct phy_lookup *p, *pl = NULL;
 
-	mutex_lock(&phy_provider_mutex);
+	lockdep_assert_held(&phy_provider_mutex);
+
 	list_for_each_entry(p, &phys, node)
 		if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_id)) {
 			pl = p;
 			break;
 		}
-	mutex_unlock(&phy_provider_mutex);
 
 	return pl ? pl->phy : ERR_PTR(-ENODEV);
 }
@@ -504,6 +504,8 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	struct phy *phy = NULL;
 	struct of_phandle_args args;
 
+	lockdep_assert_held(&phy_provider_mutex);
+
 	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
 		index, &args);
 	if (ret)
@@ -515,11 +517,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		goto out_put_node;
 	}
 
-	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
 	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
 		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
+		goto out_put_node;
 	}
 
 	if (!of_device_is_available(args.np)) {
@@ -533,8 +534,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 out_put_module:
 	module_put(phy_provider->owner);
 
-out_unlock:
-	mutex_unlock(&phy_provider_mutex);
 out_put_node:
 	of_node_put(args.np);
 
@@ -558,15 +557,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
 	if (con_id)
 		index = of_property_match_string(np, "phy-names", con_id);
 
+	mutex_lock(&phy_provider_mutex);
+
 	phy = _of_phy_get(np, index);
 	if (IS_ERR(phy))
-		return phy;
+		goto out_unlock;
 
-	if (!try_module_get(phy->ops->owner))
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
+	}
 
 	get_device(&phy->dev);
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(of_phy_get);
@@ -678,6 +683,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 		return ERR_PTR(-EINVAL);
 	}
 
+	mutex_lock(&phy_provider_mutex);
 	if (dev->of_node) {
 		index = of_property_match_string(dev->of_node, "phy-names",
 			string);
@@ -686,10 +692,12 @@ struct phy *phy_get(struct device *dev, const char *string)
 		phy = phy_find(dev, string);
 	}
 	if (IS_ERR(phy))
-		return phy;
+		goto out_unlock;
 
-	if (!try_module_get(phy->ops->owner))
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
+	}
 
 	get_device(&phy->dev);
 
@@ -698,6 +706,8 @@ struct phy *phy_get(struct device *dev, const char *string)
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -837,15 +847,17 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_lock(&phy_provider_mutex);
 	phy = _of_phy_get(np, index);
 	if (IS_ERR(phy)) {
 		devres_free(ptr);
-		return phy;
+		goto out_unlock;
 	}
 
 	if (!try_module_get(phy->ops->owner)) {
 		devres_free(ptr);
-		return ERR_PTR(-EPROBE_DEFER);
+		phy = ERR_PTR(-EPROBE_DEFER);
+		goto out_unlock;
 	}
 
 	get_device(&phy->dev);
@@ -858,6 +870,8 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
 
+out_unlock:
+	mutex_unlock(&phy_provider_mutex);
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
-- 
2.53.0

