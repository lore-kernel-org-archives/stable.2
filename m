Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D372749C1
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560923; cv=none; b=QKMBmaT5ChasoCaxCSYTRCvOvhT0SjQ1QaGmRWLXr/54vUN+QzxKkXUGNv4OtuaXTbLd2lBa4wCSE3e58GiBDvVsKwVVYJJcPZ9GEgoqoaJA9c2XYR6DNR3b7zU25Iz7NSzlZlNPzGBGWgAhKtvSQqu523WRE8NyOo5DGpAOrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560923; c=relaxed/simple;
	bh=UlQKIyg7vWS4w8fY2V+V34lHIBqTnTAu4fOeOWiVaOM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fiikTaYMSl6uHjuaEFRDBhoKezy/3WEhPYaV/rDlqwmYOVHnpLqMIKuACbD51tkepBwBj7ql1W+NNUqsFpI4qQGkAzUF72uRUR8cukRBnqBreN0lqOnSYSxTEtPkZlxhIsJf4kW5DGv2/jUv6MnwF1whvWSgQGP5rXLKiS3s51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJNwT1O9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJNwT1O9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E44F1F000E9;
	Mon, 20 Jul 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560921;
	bh=5HAZolM+jK2s/gD12PrITY63BLfW0f0EF0b0t+l6mVo=;
	h=Subject:To:Cc:From:Date;
	b=YJNwT1O92QY+Ebx7qr93u8X88PUsHGglRLaAe/3xcVJ3w5V7TSnrX8WXuSu2UyMQm
	 Knb+lwERHAvdgY+CWkfKcWiNloKdX1ksdS86FfyuYY6kNmdQzG6xNXGS19GF79I13x
	 APUXxy5a0+HZCOzv1eMvpZ2tmcXujFqpHFJYDWC0=
Subject: FAILED: patch "[PATCH] scsi: xen: scsiback: Free unsubmitted command instead of" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,jgross@suse.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:21:52 +0200
Message-ID: <2026072052-ignore-sharper-eb94@gregkh>
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
git cherry-pick -x ca978f8a93d4d36841839bf2847d29b88c2591d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072052-ignore-sharper-eb94@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca978f8a93d4d36841839bf2847d29b88c2591d6 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 11 Jun 2026 08:30:45 -0400
Subject: [PATCH] scsi: xen: scsiback: Free unsubmitted command instead of
 double-putting it

scsiback_get_pend_req() obtains a command tag and returns a vscsibk_pend
whose embedded se_cmd has only been memset to 0, so its cmd_kref is 0;
the se_cmd is initialised (kref_init() via target_init_cmd()) only
later, in scsiback_cmd_exec(), on the successful VSCSIIF_ACT_SCSI_CDB
path. The two error paths in scsiback_do_cmd_fn() taken before the
command is submitted -- a failed scsiback_gnttab_data_map() and an
unknown ring_req.act -- call
transport_generic_free_cmd(&pending_req->se_cmd, 0), which kref_put()s a
refcount of 0. That underflows it ("refcount_t: underflow;
use-after-free") and, as the release function is not run, leaks the
command tag.

Impact: a pvSCSI guest can leak every command tag of a LUN's session,
stopping the LUN, by submitting requests with a bad grant reference or
an unknown request type; under panic_on_warn the refcount underflow
panics the host.

Add a helper that just returns the tag with target_free_tag() and sends
the error response. It frees the tag while the v2p reference still pins
the session, and snapshots the response fields beforehand because
freeing the tag can let another ring reuse the pending_req slot.

Fixes: 2dbcdf33dbf6 ("xen-scsiback: Convert to percpu_ida tag allocation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://patch.msgid.link/20260611123046.2323342-2-michael.bommarito@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index e33f95c91b09..f324732eba7f 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -611,6 +611,25 @@ static void scsiback_disconnect(struct vscsibk_info *info)
 	xenbus_unmap_ring_vfree(info->dev, info->ring.sring);
 }
 
+/*
+ * Send the error response for a request that did not reach the target core
+ * and return its tag.  Free the tag before the response drops the v2p
+ * reference that keeps the session alive, and snapshot what the response
+ * needs since returning the tag can let the slot be reused.
+ */
+static void scsiback_resp_and_free(struct vscsibk_pend *pending_req,
+				   int32_t result)
+{
+	struct vscsibk_info *info = pending_req->info;
+	struct v2p_entry *v2p = pending_req->v2p;
+	struct se_session *se_sess = v2p->tpg->tpg_nexus->tvn_se_sess;
+	u16 rqid = pending_req->rqid;
+
+	target_free_tag(se_sess, &pending_req->se_cmd);
+	scsiback_send_response(info, NULL, result, 0, rqid);
+	kref_put(&v2p->kref, scsiback_free_translation_entry);
+}
+
 static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	enum tcm_tmreq_table act, int tag)
 {
@@ -792,9 +811,8 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 		case VSCSIIF_ACT_SCSI_CDB:
 			if (scsiback_gnttab_data_map(&ring_req, pending_req)) {
 				scsiback_fast_flush_area(pending_req);
-				scsiback_do_resp_with_sense(NULL,
-						DID_ERROR << 16, 0, pending_req);
-				transport_generic_free_cmd(&pending_req->se_cmd, 0);
+				scsiback_resp_and_free(pending_req,
+						       DID_ERROR << 16);
 			} else {
 				scsiback_cmd_exec(pending_req);
 			}
@@ -808,9 +826,7 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 			break;
 		default:
 			pr_err_ratelimited("invalid request\n");
-			scsiback_do_resp_with_sense(NULL, DID_ERROR << 16, 0,
-						    pending_req);
-			transport_generic_free_cmd(&pending_req->se_cmd, 0);
+			scsiback_resp_and_free(pending_req, DID_ERROR << 16);
 			break;
 		}
 

