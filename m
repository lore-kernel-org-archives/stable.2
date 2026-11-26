Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711870;
	b=mIJ492x0cPGeC5qXe2+uLmUhjLTuj9sjz5g9DMuhJ/oqKUVi/f4QvAsMi5KLAZqNBO5L
	 Gh9tgR0GJN20gr0MG4b2r7FXJpJs+zXz4P+AcXqrxNp7Ke7AnkpnpNpNBaXM3wPzRMXms
	 TA+wZipjFPOnXM5T1ZHt6VrCpO8qC5UA1X3a8Uhl4Joe+0OJyRsusH/KZNpO2y9CnQ0lF
	 1/k0ct5HYpJjcokiespLvBHzg/ysUuO/WUP7KxgJNzYRjVMQgEJkhS4kjK7UuPSKu81u7
	 dixSZ0aSwpETz7dMpSIe7fr7ui6aoqhK+nETGDV5vk7X03C7FrTuKVjtfA6fjSa264g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zjLnLX+lmNppPlVM75Q8FIKWM2mrLVH2MPlih+I69vo=;
	b=c3PNbvA4ZdWrBTV2Ih1cvZE6Ob33xPFVr/xpcVo6USmDqnaq7CX+JkSVEzayb/tGDbqt
	 fcw4NBuUgRaGn+YecyB+Dq+0aiODxh/7C5cLLzKetF2y144JB7MhLuhrN8vv8d14xvYd7
	 jmq6beN28LGCrkumE3YOqI5HIZRnyMbY1orCE1+Vcs6nuYW4lAGm5bcEuuaP0vUKpY68C
	 7gplW3bTVVwhJBmyFOtVwFCsw+gGJ9ZLD6KQfv+oAKmYKlMafQWECavb1cL2MAya2gWRR
	 HULMxa7FU5kybv5MhVhon+58yGP/w3DJaFSXOORmW8AHjgLnLLjMiRcqmG0S95woWVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLs5gicv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FD606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLs5gicv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655171F000CA;
	Thu, 26 Nov 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711869;
	bh=zjLnLX+lmNppPlVM75Q8FIKWM2mrLVH2MPlih+I69vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLs5gicv1pruCq2csD6MWnAvFNVpH5ewnICgc87S1LlxS1+RavRic27KmJ1azeMp/
	 29h7i4xWkXvjroCUhxDPNIecEDV3sD+8Eb4/UxREmH7d7SF1qWAYJQEqRa7NHSxjfZ
	 HPr9aDtpUhTOz7Uop9kwa5WcIdnpofLGFrb4rXMJ9QLEzBOywkpLbXlGSpQZZqCKCK
	 Ek2B3MQvMy3qZxxUCQ6klR/A50dEg2hF3qMW6gnPAOu8GF+kCAF+aDhNVG8IJ/d1q5
	 MP1xOmvQEVBQiGNk63pWnss5TNyLMRPMI3RYBfWb4+18cAPVGtXwRboHuy11nmwL0a
	 NOjPgUTVee3RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] devres: add devm_remove_action_nowarn()
Date: Thu, 26 Nov 2026 11:51:05 -0500
Message-ID: <20261126165025.2602010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112512-disfigure-marmalade-b2e1@gregkh>
References: <2026112512-disfigure-marmalade-b2e1@gregkh>
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

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit f1725160fd28a2e65e47166637aa44856a1a7f89 ]

devm_remove_action() warns if the action to remove does not exist
(anymore).

The Rust devres abstraction, however, has a use-case to call
devm_remove_action() at a point where it can't be guaranteed that the
corresponding action hasn't been released yet.

In particular, an instance of `Devres<T>` may be dropped after the
action has been released. So far, `Devres<T>` worked around this by
keeping the inner type alive.

Hence, add devm_remove_action_nowarn(), which returns an error code if
the action has been removed already.

A subsequent patch uses devm_remove_action_nowarn() to remove the action
when `Devres<T>` is dropped.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/20250107122609.8135-1-dakr@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6c6508e742b4 ("usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261126161615.2569078-1-sashal@kernel.org>

 drivers/base/devres.c  | 23 ++++++++++++++++++-----
 include/linux/device.h | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f229c5b3e7850..03da20f0431dc 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -757,25 +757,38 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
 EXPORT_SYMBOL_GPL(__devm_add_action);
 
 /**
- * devm_remove_action() - removes previously added custom action
+ * devm_remove_action_nowarn() - removes previously added custom action
  * @dev: Device that owns the action
  * @action: Function implementing the action
  * @data: Pointer to data passed to @action implementation
  *
  * Removes instance of @action previously added by devm_add_action().
  * Both action and data should match one of the existing entries.
+ *
+ * In contrast to devm_remove_action(), this function does not WARN() if no
+ * entry could have been found.
+ *
+ * This should only be used if the action is contained in an object with
+ * independent lifetime management, e.g. the Devres rust abstraction.
+ *
+ * Causing the warning from regular driver code most likely indicates an abuse
+ * of the devres API.
+ *
+ * Returns: 0 on success, -ENOENT if no entry could have been found.
  */
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+int devm_remove_action_nowarn(struct device *dev,
+			      void (*action)(void *),
+			      void *data)
 {
 	struct action_devres devres = {
 		.data = data,
 		.action = action,
 	};
 
-	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
-			       &devres));
+	return devres_destroy(dev, devm_action_release, devm_action_match,
+			      &devres);
 }
-EXPORT_SYMBOL_GPL(devm_remove_action);
+EXPORT_SYMBOL_GPL(devm_remove_action_nowarn);
 
 /**
  * devm_release_action() - release previously added custom action
diff --git a/include/linux/device.h b/include/linux/device.h
index 95bfb360915b9..601e60c68504c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -287,7 +287,23 @@ void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
 /* allows to add/remove a custom action to devres stack */
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
+int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
+
+/**
+ * devm_remove_action() - removes previously added custom action
+ * @dev: Device that owns the action
+ * @action: Function implementing the action
+ * @data: Pointer to data passed to @action implementation
+ *
+ * Removes instance of @action previously added by devm_add_action().
+ * Both action and data should match one of the existing entries.
+ */
+static inline
+void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+{
+	WARN_ON(devm_remove_action_nowarn(dev, action, data));
+}
+
 void devm_release_action(struct device *dev, void (*action)(void *), void *data);
 
 int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
-- 
2.53.0

