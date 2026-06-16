Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B644BCBE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630652; cv=none; b=cM0jV0lNAhn+h+sYCfp3dLrzpQbrXwBSdhB2lp+zbPg+dxbBi9ptfOUhZ7181TxFGpBMU1ZVsVpKVFimscSU/+gxD4d+mIM2Sls95fz4FsLwrMXK+O2Xv44j9mkadFdW8FxVBuWBRKK2LVJij28GVXb383G3IyWO++XiMRffe/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630652; c=relaxed/simple;
	bh=sRO32Nws6B/xQoRqaeIWnb6n7Hg4q/oIxmARgeZ5F1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9PP10ao8aeVtisf9VjwmezjFQKdgLCJbhEUfCFI854XOXfIp2EBAXQyDP4HMdJ4tZ52sulcTW/fpEFehtEqyiqzmMe2UP+jdwQ8xqBfb1wdfOGawPWLCDu/qnwAwU3H/IShxtoQrP9Z2j0bjrMV9XMgjHesfXko7doMOOPicSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWLG1bk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWLG1bk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EF91F00A3A;
	Tue, 16 Jun 2026 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781630651;
	bh=rb3o+O/RaY5zLsgupgwLYtGG7y6qHbxQ3K+rPM5tLFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XWLG1bk4PD3XPDFeb0EcTZuNFZe+9KH5MUrljUL0PKGj+tV4dPdk289GwaxpaWrEZ
	 8FKn8lxpCFMDisSj/633T4dvmi0DLXJ94jOQ80xJjGpj8OyyLxpcBAx0kZ5gcGFJMQ
	 cj6Rg1pw0oxzl29lXJ68sWzNJ5MROVwtEPvQU8ANjY9OOHOnb9DRUj1Q+2p8KCB+Uh
	 oFqQs0PC+VSq3Vt/24NBSHdsA6zFVuINVeSrRQBBU1ZT04tK5mNkyeNWKzbym1Akk5
	 kN2CDjGjwu6V7+QcyKKkp9tLVm7kyx8Ld1QNjHxHMEEvkI9xzAjjpKjzzAu1jfoseu
	 CkkkVo0Oldwcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 13:24:09 -0400
Message-ID: <20260616172409.3390421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061503-baggy-protrude-228c@gregkh>
References: <2026061503-baggy-protrude-228c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 3fcf923302a8f5c0dc3af3d2ca2657cb5fae4297 ]

Make kvp_register() return an error code instead of silently ignoring
failures, and propagate the error from kvp_handle_handshake() instead of
returning success.

This propagates both kzalloc_obj() and hvutil_transport_send() failures
to kvp_handle_handshake() and thus to kvp_on_msg().

Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv_kvp.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 77017d9518267c..8019ef2cdcf2a3 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -93,7 +93,7 @@ static void kvp_send_key(struct work_struct *dummy);
 static void kvp_respond_to_host(struct hv_kvp_msg *msg, int error);
 static void kvp_timeout_func(struct work_struct *dummy);
 static void kvp_host_handshake_func(struct work_struct *dummy);
-static void kvp_register(int);
+static int kvp_register(int);
 
 static DECLARE_DELAYED_WORK(kvp_timeout_work, kvp_timeout_func);
 static DECLARE_DELAYED_WORK(kvp_host_handshake_work, kvp_host_handshake_func);
@@ -127,24 +127,26 @@ static void kvp_register_done(void)
 	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 }
 
-static void
+static int
 kvp_register(int reg_value)
 {
 
 	struct hv_kvp_msg *kvp_msg;
 	char *version;
+	int ret;
 
 	kvp_msg = kzalloc(sizeof(*kvp_msg), GFP_KERNEL);
+	if (!kvp_msg)
+		return -ENOMEM;
 
-	if (kvp_msg) {
-		version = kvp_msg->body.kvp_register.version;
-		kvp_msg->kvp_hdr.operation = reg_value;
-		strcpy(version, HV_DRV_VERSION);
+	version = kvp_msg->body.kvp_register.version;
+	kvp_msg->kvp_hdr.operation = reg_value;
+	strcpy(version, HV_DRV_VERSION);
 
-		hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
-				      kvp_register_done);
-		kfree(kvp_msg);
-	}
+	ret = hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
+				    kvp_register_done);
+	kfree(kvp_msg);
+	return ret;
 }
 
 static void kvp_timeout_func(struct work_struct *dummy)
@@ -186,9 +188,8 @@ static int kvp_handle_handshake(struct hv_kvp_msg *msg)
 	 */
 	pr_debug("KVP: userspace daemon ver. %d connected\n",
 		 msg->kvp_hdr.operation);
-	kvp_register(dm_reg_value);
 
-	return 0;
+	return kvp_register(dm_reg_value);
 }
 
 
-- 
2.53.0

