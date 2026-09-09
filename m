Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2B4C6F08
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953283; cv=none; b=PhwXckVvSRn1rT+ODwDKiiuLevEjwniv90UzZ94R6KpgdL3VDE6oQ7etzwjRQF43/UIfvxQ1Gqz1JthYoyOhDp1gU6KkW8IfDFCNukI7pQIBM+QPN4TWLB1yo6Jovvt1KzHSDDcfRB9hvXR/Jn8dja/JqCapykUS2lU6FRQVypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953283; c=relaxed/simple;
	bh=prJ3r/AnN5rbqHj1BMqzKsP7VE4nf4GxKZKk3u5TRyg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJNRcPwDkpAo1DcvrsPpu8RatL9NSm19hRpQhzJXddelTJmr6tXX4ZD/0wliEklcptGSrCJtRMvPtFkgwEwD50KzvVBleU6tmbBTNLiTpK4GzKqmDk4RKyTdflXV+PC9O2j7WSz0VshwkZWKVUrDbvvAqLUOUvEDIQJWvuS7tQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qCDfK1Dj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qCDfK1Dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EBC1F00A3A;
	Wed,  9 Sep 2026 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953282;
	bh=kTMjmVSaB0Ec8bT3/Ekt1XEe+gdpo9TdqmBldNAON50=;
	h=Subject:To:Cc:From:Date;
	b=qCDfK1DjzKuLtbMdaW7BvVqJe03AvGz1zKOY1RA3AOb2T9a/Og0nDfsffwXhh6Ew+
	 i1mWCKOZVrUEIfR4MsOoCpoh9t+WQJU1h7W1eHThzYiW73OXF1M8UuyU/a78udveP1
	 GgtLo/WOXRIkEM2vytSmW0i5vi+Row3N6hXp668M=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS" failed to apply to 6.6-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:22:02 +0200
Message-ID: <2026090902-deacon-ambiguity-eafe@gregkh>
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
git cherry-pick -x e46160a5d4fa59bf4d5f3412b6b5cb79edb967dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090902-deacon-ambiguity-eafe@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e46160a5d4fa59bf4d5f3412b6b5cb79edb967dd Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:31 +0530
Subject: [PATCH] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS
 reject error

qla_nvme_xmt_ls_rsp() obtains uctx, which was linked into
fcport->unsol_ctx_head by qla2xxx_process_purls_iocb() and is still linked
when the NVMe transport calls back to transmit the LS response. On the
error (out:) path the function frees uctx with kfree() but never removes
it from the list. This leaves a freed node in fcport->unsol_ctx_head: the
next list_add_tail() for that fcport writes through the freed node, and a
subsequent list_del() can corrupt the list or panic.

Unlink uctx with list_del() before kfree() on the error path, matching the
other free sites in qla_nvme_release_lsrsp_cmd_kref() and
qla2xxx_process_purls_pkt(). qla2x00_rel_sp() in the failure path only
returns the SRB to its pool and does not invoke sp->put_fn, so the out:
path is the sole free and uctx is always still linked there.

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-27-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 28a04e0ff660..36b742f73abf 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -446,6 +446,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
 		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	}
+	list_del(&uctx->elem);
 	kfree(uctx);
 	return rval;
 }

