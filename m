Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368F3FBED1
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534816; cv=none; b=cQYYGRkuNpFxUTKyci488ZZQFDni5TiQa92wxksV88W+hFegMPWXc5KqCyP4YB8HkIOB8KsK7T0/mwR450244rhNNYR7eCjDMkC5Y5r8l3TtDhAW7Pvdl8RjWWVNUtZ4INRNYrpPvHwDiZ4REKFdSL1xeUQKRRb0V6Rr3PKy2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534816; c=relaxed/simple;
	bh=eawIhCh30wyuE4xf6v4IZzdvTKB6IMGHAzhzMadSBwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WA0XJs0tvRcD9sqyjQ4A1+exFgyqBdaC1GfIRhNfM2dmnX5DyLB0JRw7dfMUfNusyV0Gd6Ux1Uk/OtEyjPm5Sl+iACsJSjDWFQ5mDktDDsGTRuwpuI9tWQfXn1ajK27aoczzD5KSEOVfprXsyFCj4wjZa4ZNclxNH0qgKJCOFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HpC5lroO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HpC5lroO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E941F000E9;
	Mon, 15 Jun 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534815;
	bh=X5LY0xzie/uOBsBs1IURTvWsiJFPPR1UaOV8xXb35zM=;
	h=Subject:To:Cc:From:Date;
	b=HpC5lroOv1TPlo5VuFvu/5tFy+TfoODaMltuWUSJ4c0nfK6BvIqzBaNCGau/v45KH
	 k1ECBynVxBKVqKPUCs4042hHQeDIP/Fr8s6+U3UVjRhymyvbcIjpMK5Y3sV/oWukTy
	 NWJJtN3md3tRhLDJXbpfOznM72li5i1jc5CN6k+Q=
Subject: FAILED: patch "[PATCH] hv: utils: handle and propagate errors in kvp_register" failed to apply to 5.15-stable tree
To: thorsten.blum@linux.dev,longli@microsoft.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:33:05 +0200
Message-ID: <2026061505-another-sensually-b0cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3fcf923302a8f5c0dc3af3d2ca2657cb5fae4297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061505-another-sensually-b0cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3fcf923302a8f5c0dc3af3d2ca2657cb5fae4297 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Tue, 14 Apr 2026 13:10:08 +0200
Subject: [PATCH] hv: utils: handle and propagate errors in kvp_register

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

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 0d73daf745a7..6180ebe040ff 100644
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
 
 	kvp_msg = kzalloc_obj(*kvp_msg);
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
 
 

