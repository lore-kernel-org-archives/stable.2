Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37A477E57
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631354; cv=none; b=TGv6lLtfKQhAdfWzqistBiYWkNwhZGcvi2PPdTWUpx3GpdbIuwCSMWeg547VhTFF6/MG0LaToLR9XO/gQLWpJSv2d7wAwLG2gQ8y1WAVs3IiuVwZwKWLS/BKYm3fPn5ZroUH+Wv0U0T+jTm53iLRUgTwfqgwbF1rdZe2zYBeqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631354; c=relaxed/simple;
	bh=VJrGe2PBgcZ82vZ68S9owlOjrFti7BZzFWW9PW/Uyvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im4N5HmKodvn2EGku3H09NBh+7SH/fcGidw5kJkmF2RNKhf/knxUARLLSo6T947NZfh2qwfQgX2rFlazrzsmR+vTRH08UKYTf2cqCz+Eko1YUUi9G3nk+MSV3IoMDpH4VOYCRUFEZO1SWonRWpDi6psoMCViB8iJJ0pbe5RyImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJlSkgoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJlSkgoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398EB1F000E9;
	Tue, 16 Jun 2026 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631352;
	bh=OMDkbIpaHYz/GydYqr2N3E2ihdSRMgVL3qZhM2qM3Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJlSkgoVTWFk80skWMZHIF9KjgSFE2dP0cY533auSZeZOOOfXKa684ZUSiLKoYO2c
	 bCLAn9g4nr1A4pt0XMq/0RPZJHeilzB6+3VDM41NjFOXurK5fcZ/qA7y1h2GMGOThV
	 +507O2CdRzD9c09a9f1CQgt9AeeAef6YzXVujyQGOG0fKgmJa5faJjDXSMvCyjbBO9
	 vIc/lABmbDP2h758551qMUmty4KCqRFhAei1NLfcLYwyo9+fz2nhSfIQmim+pIJqgz
	 O9DyX6LZ95vNYc68PYx7s+I1MX2wbXhzA9z4OQyCb3Wl2R4Glf5rd20nzTPtmaNy4B
	 FZutkhY2/zplg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 13:35:50 -0400
Message-ID: <20260616173550.3401658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061505-another-sensually-b0cb@gregkh>
References: <2026061505-another-sensually-b0cb@gregkh>
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
index 2908fbb88f59a2..5431afcd577a39 100644
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

