Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91637DAB9
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534800; cv=none; b=kaJk70TpDw+EaaaEXc5yUVlT1ZSL/5/sNpdgAeoE/O+RSZTrhlNof9ai4RakrRmtGjFcx3+1mBO+vGHI3tqWU6y/9gB6UTdjPrjh57fktaTa91RU0UJzmPOS4WnreOpFh4byM8AeKtkmSzfKar17aT3TYv0Zf58FiezB3LWD8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534800; c=relaxed/simple;
	bh=26cWHBatxWzcpxbkae0DbrHl9jDKT/wK6DoJog/8mY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tHjh7IR6bV5rjrZ6fujPVZtSWwngmkFx59lNa7q4RDZQUGHx/6yz5hGWRjcj+T8TKo6d+P0bmS/+NoKb4JBQvyo22K4m3ScC7eDYiJpoLvpbOPl+apwznBzT2du9SsiUNwgWO6cC0/ooOWm1abQ2uBgurehc+8a1x8UjnHTzfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pl46ZSrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pl46ZSrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FD61F000E9;
	Mon, 15 Jun 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534799;
	bh=dUZPAX5IFP96WEysneC3w3GNNas53FfMEX32gBRx8f0=;
	h=Subject:To:Cc:From:Date;
	b=pl46ZSrtMl4wOV8GExchM8f53abH6JKKDvtnr/Ow11rH4cdN3qAKTPsXoUZm1lumP
	 CkG3ywlue3JiLyx+ilCeccWDvayQkwQbDoOA/EhLqty1nwGZ23vrCW7Yxt4MeYLbpu
	 5seFKe+gqVpuDKeNPZ8jUdJKxjPbZfBxHOLUIEDI=
Subject: FAILED: patch "[PATCH] hv: utils: handle and propagate errors in kvp_register" failed to apply to 6.6-stable tree
To: thorsten.blum@linux.dev,longli@microsoft.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:33:01 +0200
Message-ID: <2026061501-ambush-comply-071d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3fcf923302a8f5c0dc3af3d2ca2657cb5fae4297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061501-ambush-comply-071d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 
 

