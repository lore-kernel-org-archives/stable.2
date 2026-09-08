Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E653AAF40
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872155; cv=none; b=KO+TXtSdLgfdXq0yKpBxgIe/v/rOxRiSXyeYHipwrYXF84m95IOC0c+nOy+L+AKjN91ZUy5aNF7X6g1SbSH5jV8DHh3enZvXu80891Cw8wJQFLkmjTR9m8zIFX70zJOMlGrpA8ddpWwfU09oVuzlcJQpGYkPCwtUgYeTdRYojnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872155; c=relaxed/simple;
	bh=lzDoKYBsKd2fn5cyWa2l45fofnD396wOzhNT/ms/4UA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DkaySekHCWpB3FKSyUMrKw8Jw/WxLNP8c1sBjk7/w2N6H0ua52R4xhM1pb61WqsgfJqr3rzO8e+utdt6Bn80m2IzUl/0B5AvpEfZNUpYYzKgWyqJFEy7E7pBd2ZKPuhGNyEELY2tf5g6ubV7Ee4v+9bLEM1D3ts0A8Bz8oOaoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXCqGyHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXCqGyHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25AB1F00A3A;
	Tue,  8 Sep 2026 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872153;
	bh=yw5jz+AMOoqaqhUvhWRH6w+G9oTpJTMqonkrBEZ91iw=;
	h=Subject:To:Cc:From:Date;
	b=VXCqGyHBZw+AcApP/5H52MYSQnoIDem4OzL/CrDK7yYzqzoa4NCM8jxts+b2/8Kfz
	 ZvDc0C2YvHaYVewSnF9kUB/1FsprYZaDE3tCY8Vcq/QidrREQCg6bzqfddToqzHPxl
	 e3N8AvQQItUboMNa3po7tyF9wHxao82+Gja5heCQ=
Subject: FAILED: patch "[PATCH] scsi: sg: Report request-table problems when any status is" failed to apply to 5.10-stable tree
To: raoxu@uniontech.com,bvanassche@acm.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:47:30 +0200
Message-ID: <2026090830-wrongness-upstroke-5f0e@gregkh>
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
git cherry-pick -x 11300f8ddee301dca9914561f24bea4168de076d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090830-wrongness-upstroke-5f0e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

