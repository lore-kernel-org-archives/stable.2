Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130148A2B6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330145; cv=none; b=JLS8qq8pG4v8uTJaueUgkh+72pSSD5BlEGL141bp8Y4YpShWcGyJpAHT6aFpNXRjuL0AKsulC5bJh9ldsKlAZ2G/aUqnA41VCfC+3Lj7wIPtRWXb5N9VBEahR5aBn9VdpdPihAo7gC/C1fnJXDziNqj3hLzemEZvIXIRJaTlzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330145; c=relaxed/simple;
	bh=10bxfeXayOEglsSwQoHRKoqCut2/CD0kTOod39WHPNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=asScl4nimt4Ui2PuGrQUPId7dF3NNfkS+yPWc62srURv4d342dR+b5Y9dk55xb7RqJed+bUyJb4BafbFmwhLdU9r9ne4wWylnSyBUHnKLZtrfezG/nwIQxY4HjcehcQWmEueFsbDJM0uXhiNKYXOu5NKdmWDZ7sd7dIzGrEqnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1K0/VzL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1K0/VzL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0CE1F00A3A;
	Wed, 29 Jul 2026 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330141;
	bh=QfxgYI6x4As1mGEYj/epUp9Xw6IbpNqQqkDpWmW+h7A=;
	h=Subject:To:Cc:From:Date;
	b=1K0/VzL3WHa/ak0txjgCesDKgVvadNsZBAe85n/vl4BMSeuFJpgV8bCFKe7vyNEKW
	 VPXn6EzXC8yHfUgT09HyCnal5NuefMxzRAePCYw9fujJxb3dWX5CoX22imHizoOgg/
	 MeB8dIcovYBml6Wb5E3Eav+0os+408C+3YuU4joU=
Subject: FAILED: patch "[PATCH] media: v4l2-ctrls-request: add NULL check in" failed to apply to 5.10-stable tree
To: s.shtylyov@auroraos.dev,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:02:04 +0200
Message-ID: <2026072904-rudder-unplanted-2d55@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x caced3578bf9f104a4aaad8f46c4c719e705d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072904-rudder-unplanted-2d55@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From caced3578bf9f104a4aaad8f46c4c719e705d9a6 Mon Sep 17 00:00:00 2001
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Date: Fri, 1 May 2026 23:28:31 +0300
Subject: [PATCH] media: v4l2-ctrls-request: add NULL check in
 v4l2_ctrl_request_complete()

If CONFIG_MEDIA_CONTROLLER is undefined, media_request_object_find() will
always return NULL, so its 2nd call in v4l2_ctrl_request_complete() would
fail as well as the 1st one and thus cause hdl to have a wrong value (at
the top of memory) and list_for_each_entry() to iterate over the garbage
data located there. Add NULL check for the 2nd call and place the error
cleanup at the end of v4l2_ctrl_request_complete()...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: c3bf5129f339 ("media: v4l2-ctrls: always copy the controls on completion")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-request.c b/drivers/media/v4l2-core/v4l2-ctrls-request.c
index 4b7e6981b8d6..5c2fc767c6a6 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-request.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-request.c
@@ -348,13 +348,12 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 		ret = v4l2_ctrl_handler_init(hdl, (main_hdl->nr_of_buckets - 1) * 8);
 		if (!ret)
 			ret = v4l2_ctrl_request_bind(req, hdl, main_hdl);
-		if (ret) {
-			v4l2_ctrl_handler_free(hdl);
-			kfree(hdl);
-			return;
-		}
+		if (ret)
+			goto error;
 		hdl->request_is_queued = true;
 		obj = media_request_object_find(req, &req_ops, main_hdl);
+		if (!obj)
+			goto error;
 	}
 	hdl = container_of(obj, struct v4l2_ctrl_handler, req_obj);
 
@@ -389,6 +388,11 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 	mutex_unlock(main_hdl->lock);
 	media_request_object_complete(obj);
 	media_request_object_put(obj);
+	return;
+
+error:
+	v4l2_ctrl_handler_free(hdl);
+	kfree(hdl);
 }
 EXPORT_SYMBOL(v4l2_ctrl_request_complete);
 

