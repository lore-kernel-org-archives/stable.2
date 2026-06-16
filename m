Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC44779B0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635041; cv=none; b=fW4irZT5tlqAypywsetAf7tBfiqoHZZT9cmkXCKr5/oFR6qMNMbYirqCdGgRfYg+TOrXGrjBFLfUcInVlVoL8lUaVy/+ARFNeSpGZiCeGajgd+JQps3dO91RC2PV6AehCE5eJl9Aai8orF+XLDmyFnitLClJV7pA02ljYOJzYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635041; c=relaxed/simple;
	bh=rqHt1TBdy8jvl9+zQx0b3NHba1fgF2IaMEXEFE//r0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKGQbIgzLasL8aZDt2xtjEDWe+HtdCAT1kNWXhQB/c0Bc/ZGTAHoDzVZ72fIJWdn/u2xisRSOT5TJjpdHKq5f6gHcF55jIQyH868YdmpYu1nSe3JF2flb547Lyy/1RZcFBhhTw2iJ72ACGEsh7cDCmkRrB3LdS9fjttebbtd3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO1HFWRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO1HFWRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DDC1F00A3A;
	Tue, 16 Jun 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781635040;
	bh=dSkMniTbt3BDBl7aB6X+JZ0lkKodUJ+bBJw4S8ab0x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bO1HFWRBr9HlPvIM0Bw+IFV7KqPeshVMI8I2MzMrwwgqFx6H638LR9H/LGEdugc4Q
	 X58Rd0HsWVhfvmk40dWCBh+bkOEbKcVNeCXV7dcE+pal0xGG5Qt5fYqlzT8VXEkQeA
	 G2EajfW+1MSle4hZJ2Ph7EGD2jr8eL87147BEFCcAnwxJiKgrJetDg11uYkZYyaD72
	 GvsFBi6YI6vIhUSkS9f3iYvZyggYgNJ8XAy1Yebrn5xCyNOJK6Jd3EpUbmWCcHYx1r
	 tA7oBdTWdhwzdWg71eBmITa7VCnOTGc980Ylhu04XoMSOxyY3gcmM7Z9u9cDHSLuxK
	 heyvoepIvTgGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 14:37:18 -0400
Message-ID: <20260616183718.3474794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061507-glory-shudder-5c56@gregkh>
References: <2026061507-glory-shudder-5c56@gregkh>
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
index cbbb3190d85e12..beb237c8f41ba8 100644
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

