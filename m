Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327383;
	b=gmpT+eG5P4dwUJ0/ShYPasgR3qPohnR0D1HG/FdSuNBLkpgpcrH2J9C+/bC6e4V+EYIy
	 jORyQr55jn1R2lqI9GbE48lQ7Vkyhy1sivpgjDEdOta6oxOfBK2vdS7dbgy44f58GgoEp
	 o2TRqbXkBJLt3sU7xSm3k/FrTFC2pRBbIQfLY/Eq2xyzua9UFSNeN+1KoxZmmBLt6OiqF
	 xpCAgEv1qTswxNl8j8YfNewPYNGXDuCT1PfdUOJXu1ZUJNn8faZK9drqARHTK7KPAc8ih
	 g/eHbr+tNdvxEiCHu45DQlJzg6HFgSbIjZkQdlp/q5q3Skc3/oVyDri+Cek9RfkZpSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7f1ySo84xYHH6J6aZsdfzUqb47zQoz3llqdOUUrt6M8=;
	b=00s8scSYHD6SYDhEAhR9BFgSk/VV8XbA9v4TxCBxRsx9IqjDL9WLpVtMxZbDIs7Sa+eS
	 3OPNlxTpsBOxMCzFgecOxQmVi6Dix7Alfoph66ge+WEW6yls82BkCB7vjY4MqGdKW0Hqm
	 38rcbDfrG7n42Vy3f50tPmcI08FriZxF7dWZk7wOj7oF70BiDNr+LljevJQ/lB+ua+9gP
	 YuJoSPCras4iDw6/DjZRfp5NOmbmXVjw7svdFfN7i0BJuF2b4r3yTs7Yd36XOJ51neL52
	 raZBryen7146E5vZKo4lWAFJAqtZz4BymvH9VprfM+Gl6PT2JkvBP/bnpJJ/58C73hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+TNHcsp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+TNHcsp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFB21F0089F;
	Tue, 10 Nov 2026 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327382;
	bh=7f1ySo84xYHH6J6aZsdfzUqb47zQoz3llqdOUUrt6M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+TNHcspMnB6Rr8uKH4H3jcsZz/tIsmyshWP6qtIR8bvyWsHKt2etJed72rNT7jHO
	 p5AIcloUlZ+kcvBue0M0CzzDNDULPwzMTOlMIvk4G6u7RhZImeO4ylhVEqIFuN2lfh
	 77Z2lczUhPrg5ibonWtxoJpXrnw8bnIAmJB7PzEZm3MgMWBT1YuRVtbrufieXodBHd
	 v2Ydy6QoOoVXFxW4A0NLI2AW2jyYLRGu/lT1b6tfIBFkbo4VEujzsoD5P4h7xC9KPK
	 Jyp5aLUILdflACfTq5x2mr+Ak+PODRD8fJgDp3RRZKrLRvyiQSoDODcRvQrV4AS8G8
	 Yz+1vopdAg0tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Tue, 10 Nov 2026 11:16:19 -0500
Message-ID: <20261110161539.2394981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051051-failed-6.18-b9428edaf410@kernel.org>
References: <20261107051051-failed-6.18-b9428edaf410@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

[ Upstream commit 22ea7b9d96e26147b7a3ea1be7aa106cc700907c ]

Export symbols for reading/writing WMI symbols using a namespace.
Existing functions:
- asus_wmi_evaluate_method
- asus_wmi_set_devstate
New function:
- asus_wmi_get_devstate_dsts

The new function is intended for use with DSTS WMI method only and
avoids requiring the asus_wmi driver data to select the WMI method.

Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20251102215319.3126879-2-denis.benato@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: b9428edaf410 ("platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c            | 46 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  5 +++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c8cc47df9294e..07525698dace8 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -389,7 +389,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 {
 	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
 }
-EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
+EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, "ASUS_WMI");
 
 static int asus_wmi_evaluate_method5(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
@@ -553,12 +553,52 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI method ID to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * Returns:
+ * * %-ENODEV	- method ID is unsupported.
+ * * %0			- successful and retval is filled.
+ * * %other		- error from WMI call.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if ((*retval & ASUS_WMI_DSTS_PRESENCE_BIT) == 0x00)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ *
+ * Note: an asus_wmi_set_devstate() call must be paired with a
+ * asus_wmi_get_devstate_dsts() to check if the WMI function is supported.
+ *
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * Returns:
+ * * %-ENODEV	- method ID is unsupported.
+ * * %0			- successful and retval is filled.
+ * * %other		- error from WMI call.
+ */
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, "ASUS_WMI");
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 8a515179113da..dbd44d9fbb6f8 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -166,6 +166,7 @@ enum asus_ally_mcu_hack {
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
 void set_ally_mcu_hack(enum asus_ally_mcu_hack status);
 void set_ally_mcu_powersave(bool enabled);
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
 int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
@@ -179,6 +180,10 @@ static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return -ENODEV;
 }
+static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.53.0

