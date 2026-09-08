Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830553FD2F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872133; cv=none; b=NMfdxKAg++/QpLO1GpDgGkHvCgKBX5sLuDptvUFGROkaws27i4HueIYW7U+CbaN3TOdvJ2EKzSHGpmiFZPZoZSztbjpaV5VeZdKfiQEu/P6GJ+6MpLSyx3XDOb4KwN8+tVOMedSzw0hqkrvGPGo0PKmNT1QAuhxOW4LBezafFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872133; c=relaxed/simple;
	bh=UVUlW945U6bY7CK39TqyJP8sDvkGWIJS2rrqa3/pyGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mI705urALjohp7akbJaMXuIGAVAOypdy8Jkbx/AA+BWl9KR/pCE+bQUU1FYmM50dNVEI3FcGM8svESDl8HkZKF/Lh9sRznZm+HUU2P7JVn/SKtm0BCLQs/6WLuJJY07stYTVmpfER/OztMpIDfCjUjQooIYKyaXJyfMn3aRzovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC71F00A3A;
	Tue,  8 Sep 2026 12:55:30 +0000 (UTC)
Subject: FAILED: patch "[PATCH] scsi: sg: Report request-table problems when any status is" failed to apply to 6.18-stable tree
To: raoxu@uniontech.com,bvanassche@acm.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:47:28 +0200
Message-ID: <2026090828-daughter-playmate-c3a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 11300f8ddee301dca9914561f24bea4168de076d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090828-daughter-playmate-c3a5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11300f8ddee301dca9914561f24bea4168de076d Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Mon, 6 Jul 2026 16:44:43 +0800
Subject: [PATCH] scsi: sg: Report request-table problems when any status is
 set

SG_GET_REQUEST_TABLE reports per-request diagnostic state through
sg_req_info::problem. The field is meant to indicate whether there is an
error to report for a completed request.

sg_fill_request_table() currently combines masked_status, host_status
and driver_status with bitwise AND. This only reports a problem when all
three status fields are non-zero at the same time. A normal target check
condition, for example, has masked_status set while host_status and
driver_status may both be zero, so the request is incorrectly reported
as clean.

Use the same condition as sg_new_read(), which sets SG_INFO_CHECK when
any of the three status fields is non-zero.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/26BF67F369E2123E+20260706084443.805598-1-raoxu@uniontech.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 74cd4e8a61c2..5408f002e6c0 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -863,10 +863,9 @@ sg_fill_request_table(Sg_fd *sfp, sg_req_info_t *rinfo)
 		if (val >= SG_MAX_QUEUE)
 			break;
 		rinfo[val].req_state = srp->done + 1;
-		rinfo[val].problem =
-			srp->header.masked_status &
-			srp->header.host_status &
-			srp->header.driver_status;
+		rinfo[val].problem = srp->header.masked_status ||
+					     srp->header.host_status ||
+					     srp->header.driver_status;
 		if (srp->done)
 			rinfo[val].duration =
 				srp->header.duration;

