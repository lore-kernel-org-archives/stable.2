Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BF544891
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872152; cv=none; b=UZmHQfDSWX074q3p36aogPZKt8IOMUElChwLj3/npx2QoaWi1UY1T3pCIn/XdkPmI1aIoU0DKtoo3lgUVFOr2PKIwBbFMTMqkMpfgTSW6tZ6sx889u5GNVQQqyQ7LPs3lW5PGCtHN8al8ySMupKz/WIb/aOK7ZJSlRqPb+W++mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872152; c=relaxed/simple;
	bh=nV105UxiQ0fvYgk3RSb6fZMKM+Z4y+jQLjz4O7lXl2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nyvg2xkE2szDVWowflDztbGubbs6lM/V1VA+xiWTHMDNNXjZjuvIwW7GnuYYREjweedA7By4BMKBC8AboopjwVyd8vy/mQTflWu/E6s5i7Gbq6yhhTFnqCxk4aPOEJR5dREKGjnMfkYBWncko8rX2NRxqtdZbm8Est903thOPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ta8+9zTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ta8+9zTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D800B1F00A3A;
	Tue,  8 Sep 2026 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872150;
	bh=LLhtQL/Xd3JLQpG0Gdv6CLrLDEZ0m6ItyKQDpvjY4f0=;
	h=Subject:To:Cc:From:Date;
	b=ta8+9zTjrwpmzfeJxkEwaQFinHkdeRR9szQgS1JeM6DD6rCnCmOa7aI12VnHEZyIT
	 usrkvXRPIpmz5bdO+fzgLMuvK7CBAKgfSiKNjUGX3Mvfqdddugc6BnmAWRBno/33jB
	 9kVHRicMFq48slLlo0CzsZsAUdRqmn5LtN2wUnOc=
Subject: FAILED: patch "[PATCH] scsi: sg: Report request-table problems when any status is" failed to apply to 6.6-stable tree
To: raoxu@uniontech.com,bvanassche@acm.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:47:29 +0200
Message-ID: <2026090829-peso-deceiving-bb8e@gregkh>
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
git cherry-pick -x 11300f8ddee301dca9914561f24bea4168de076d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090829-peso-deceiving-bb8e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

