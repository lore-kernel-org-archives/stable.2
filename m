Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91693478E45
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628960; cv=none; b=EvYtfp1ZeP5OjBxPiyVwCTAMK80CmKzWbFznq5S57dEW7Om5nRXpOCVe6pNWfkH/4T0lR/mXpDlcWBv+vE4MPlXPPerawbCmUOF47lT6LbMqDij8GTcEtYNSyXXr4FJlSYtu9cqcJlteOO7MfIPb/BpQDTLVnXyvtDc8Swp00Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628960; c=relaxed/simple;
	bh=+L61YVI/UzHosdMdDao1u0equ7xUrsf4xUcdakFXRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0PN8Le89+PDjfMR5IGtrkp7ixSW2KEgUlB5QxBvgGzRX+LPG3p7M2Wlj4UOKRgA6kyjUnzyGkqtJuBPEHXX+5USLCMKLr8f9Iltqzag/j4mp5u462RecKOunRIXO4MN13fGiSWXYGd7IKuGosvl5aQRdZB26/WrdONbk/Pj5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuqqTLqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuqqTLqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69EF1F00A3A;
	Tue, 16 Jun 2026 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628959;
	bh=gsXqEi0Pna1I/n0mLJM7Hpshv6GCzUY8F5t9ogDVyr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuqqTLqodUBKV8l7V68v3yP8NMZcQ1+CNZT7GAK+0b9RZkdqkyL3TATSHjQUWV06t
	 5fdan3qh0O4VQbCN9F7Ez4Y/ZOmQTb/trpnYJbsBTIS7Urk7OrNyxaEKM5BM53MxrT
	 /dOr/n3S+TKE/rgyVqW+8DcEqwk2vF/yGjmsi0kN6X0ROtrFb3BLorEAxswzZRZk+R
	 8mNO04CdKskEHg2OwQu+YsVjK/ntgEo+HAIepX/UzOcyGgT2O6HIESGEGw/TaeI/jz
	 133H46MpJCNWTcX3qDPg3Tnxyxe9MX0Izht55goz3xgvoXGBdXWqRF1rKEGLhayHhG
	 LPii2kfOQ9bXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 12:55:57 -0400
Message-ID: <20260616165557.3366587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061557-scraggly-diligent-2098@gregkh>
References: <2026061557-scraggly-diligent-2098@gregkh>
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
index 62795f6cbb0019..8b409a3d41f048 100644
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

