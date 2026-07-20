Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD45396D03
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561833; cv=none; b=dpkVEUDAUZn0gkNrVj3kpi+RpIyme8iPJK9iQ0IaTKJcUhLCPQOl+vYYY6yv+WHBb1WiTdpOEY1LRlRVlb1NgXGdHk8iWm5s3H0X2GQktG5MbnyOim4I9Pq9a1nKYp/PyRvHwMJcZEYfa4nMO+Ld7rz5Qh3Yfm3k2XYOWy2QcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561833; c=relaxed/simple;
	bh=EyYBzAgVU9asi2fzBCDfP6O1he2cKC85l4t2oqzgtsM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nj5JObqkKodyX2WyjFDqQku7+CF5G795Zl8odK+OLkh2Y9HtsiskE3ID3/z0sYzSDj9RZB48fLVNTnaH/KQOqB1pI/BpsBhdJRSMem/Wqj6cTVi+tfI7JEaVHmMTWsQRixJiC2604T2u49J0gk9o72ViH1PhL4qC+VjsuqLQ6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXjWPH2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXjWPH2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDEA1F00A3A;
	Mon, 20 Jul 2026 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784561831;
	bh=heubwWXx95yf0+OltvV8qQy7QlRSETEB2yfxWrq6P+4=;
	h=Subject:To:Cc:From:Date;
	b=PXjWPH2wArATI7eQEUWhlV3ZgBgJNtqTGZNKfXtvs7z4ibz0d288Bjqqfstkx0XwA
	 pj8lbQKdZ4U0SJMm6XMF+xSvTpDCojX10XfF4oxMthxCTzeOZXQQSbX4eAVCtFP5Vy
	 aahgBCAqt1gt3m1pVYl4RjqZ5/8YifHnDgRHlrH0=
Subject: FAILED: patch "[PATCH] scsi: xen: scsiback: Free the command tag on the TMR" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,jgross@suse.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:25:22 +0200
Message-ID: <2026072022-gopher-wound-0ca6@gregkh>
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
git cherry-pick -x 66aefc277ebb796ec285d550305535dc3fc0179f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072022-gopher-wound-0ca6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66aefc277ebb796ec285d550305535dc3fc0179f Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 11 Jun 2026 08:30:46 -0400
Subject: [PATCH] scsi: xen: scsiback: Free the command tag on the TMR
 submit-failure path

scsiback_device_action() obtains a command tag in
scsiback_get_pend_req() and submits a task-management request with
target_submit_tmr(). When target_submit_tmr() fails it returns < 0 and
scsiback jumps to the err: label, which sends a response but frees
nothing, leaking the tag.

Impact: a pvSCSI guest can leak the command tags of a LUN's session,
stopping the LUN, by issuing VSCSIIF_ACT_SCSI_ABORT or RESET requests
whenever target_submit_tmr() fails.

transport_generic_free_cmd() cannot be used here. By the time
target_submit_tmr() returns an error it has already run
__target_init_cmd() (so se_cmd->cmd_kref is one, not zero), and on its
target_get_sess_cmd() error path it has freed se_cmd->se_tmr_req via
core_tmr_release_req() while leaving SCF_SCSI_TMR_CDB set and the
pointer dangling. Letting the command release run target_free_cmd_mem()
would then double-free se_tmr_req.

Use the same helper, which returns just the tag, on this path too.

Fixes: 2dbcdf33dbf6 ("xen-scsiback: Convert to percpu_ida tag allocation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://patch.msgid.link/20260611123046.2323342-3-michael.bommarito@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index f324732eba7f..c7036e0e41bd 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -658,7 +658,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	return;
 
 err:
-	scsiback_do_resp_with_sense(NULL, err, 0, pending_req);
+	scsiback_resp_and_free(pending_req, err);
 }
 
 /*

