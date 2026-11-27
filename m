Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804642;
	b=Q/l8OqxmnkNPxoTtsc56XbfMu0u9WaPcXRpp+kBHDXeGFn7wHOpeMHlomoWhEs2IgaEG
	 0YP2oILmiwXtFN6zqh1aSetL9ERpMa0pj8mng/Y+Dp/1dkJTDWPcY8pLIJkZ21CAtrqWU
	 QHmGx7ZRGxehhRoVexd8XeXq+W2/MeamGPy+FQcUs0+qrepsQVC3edrCuAX1GRG4CfR6w
	 U3tWf+qrUv7xgzGGI6OIAwTY/Q/b15001WyUgr+8odG4dmCJ9sXMO1hXT9wf7xn4Y2wt5
	 M4HNUgTEkKfZI/QcmDzo6Y9DYwWf5eKgHU/tULRdrMcX8xtCc1Por2aUDWWj1UgFQzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P7GnHJ1hLZFWtWZvu28WAv33Jbr79ezVOiibjV6ztDg=;
	b=atqAvKcRDnxmAFcV3ofCLJfg1jeot91Z0TtIkOwneAhtPYYn8IyBSIv/oZXXCEzvNQmA
	 0eCmU/1d2vNzgGnQNe9w7l67+Od8v1uYk4tzXeuAiCrleIPavgql5kzd+29QiDBLCumpK
	 3K0WhXm3b1hsfFNsRLYiUHs4N+z8/prqsoEPdGNdYCxw9szwnwkE3WjLdQbdTQo4d01gU
	 L6j16c/fh09hH9byS/gh5yHGULh1x0/UP0EmDyhZGVMuxTK0rydgAYaNRYu2UNrqGn3hG
	 6/W61K8vWZxVSk0aaICo17WIY43vt57S/keWhgY33P6cTXZGm1lLf2v2ujyFUftrWlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUEy0Hb7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F0606A323;
	Fri, 27 Nov 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUEy0Hb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6F41F00897;
	Fri, 27 Nov 2026 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804642;
	bh=P7GnHJ1hLZFWtWZvu28WAv33Jbr79ezVOiibjV6ztDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TUEy0Hb7tK8b5i3LcGxZ1ZOr8uqS4exWaPb+5w+J7fa5b9s5fbsqQm1m9AEukmLLR
	 8Ys/WZn8tbo0kTaib2xMFLs7yGTQXjINBooBK6wnbVvCZAwrjdaT1ONzc/Zb54JKzs
	 cbcl952cE2ZYqAjwLB7rtMAnsHKCh4VvLWTM2/7VuTOY8cfrkDyKv/pOFlB52vCNpN
	 FBpJVqRZnFRGUqdLeJpv+P1iU2wgdQtYjuuMfygWHQih3LLErp3YfRMFpwzAckS8In
	 7J0uGG0m3YKUgAwY63pteOZP+0MppZa7nrDve/cWYRjI08o9zdUWH9AGnIic93Ho8f
	 9b5RAxWKZWkmw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jin Park <jinyoungp@nvidia.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 8/8] regulator: aat2870: Duplicate regulator data per device
Date: Fri, 27 Nov 2026 18:35:48 +0000
Message-ID: <20261127183624.3341010-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

aat2870_get_regulator() returns a pointer into the static global
aat2870_regulators array and mutates its fields in place, after which
aat2870_regulator_probe() stores the parent MFD pointer into that shared
entry.  Probing a second AAT2870 device overwrites the first device's
state and leads to misrouted operations or use-after-free on removal.

Mark aat2870_regulators const and duplicate the matching entry per
device with devm_kmemdup() before registering the regulator.

Fixes: f7eb6c5e8e5e ("regulator: aat2870: Add AAT2870 regulator driver")
Closes: https://sashiko.dev/#/bug/linux-6f356dcb-fbbc-487c-8fb3-0f765ac5a4d6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/aat2870-regulator.c | 30 +++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 52c08e6c4803..326886371e85 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -114,26 +114,33 @@ static const unsigned int aat2870_ldo_voltages[] = {
 		},					\
 	}
 
-static struct aat2870_regulator aat2870_regulators[] = {
+static const struct aat2870_regulator aat2870_regulators[] = {
 	AAT2870_LDO(LDOA),
 	AAT2870_LDO(LDOB),
 	AAT2870_LDO(LDOC),
 	AAT2870_LDO(LDOD),
 };
 
-static struct aat2870_regulator *aat2870_get_regulator(int id)
+static struct aat2870_regulator *aat2870_get_regulator(struct device *dev,
+						       int id)
 {
-	struct aat2870_regulator *ri = NULL;
+	const struct aat2870_regulator *template = NULL;
+	struct aat2870_regulator *ri;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(aat2870_regulators); i++) {
-		ri = &aat2870_regulators[i];
-		if (ri->desc.id == id)
+		if (aat2870_regulators[i].desc.id == id) {
+			template = &aat2870_regulators[i];
 			break;
+		}
 	}
 
-	if (i == ARRAY_SIZE(aat2870_regulators))
-		return NULL;
+	if (!template)
+		return ERR_PTR(-EINVAL);
+
+	ri = devm_kmemdup(dev, template, sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return ERR_PTR(-ENOMEM);
 
 	ri->enable_addr = AAT2870_LDO_EN;
 	ri->enable_shift = id - AAT2870_ID_LDOA;
@@ -153,10 +160,11 @@ static int aat2870_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 
-	ri = aat2870_get_regulator(pdev->id);
-	if (!ri) {
-		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
-		return -EINVAL;
+	ri = aat2870_get_regulator(&pdev->dev, pdev->id);
+	if (IS_ERR(ri)) {
+		if (PTR_ERR(ri) == -EINVAL)
+			dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
+		return PTR_ERR(ri);
 	}
 	ri->aat2870 = dev_get_drvdata(pdev->dev.parent);
 
-- 
2.56.1.839.g22a8290db9-goog

