Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CD233935
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047725; cv=none; b=YZ67G3Hvxt/HR0y2t7wajyA4PEpQ21JNsUZW+keqU7+19sNAm9HZeJQt/tJpJ0SDcs8/TqFHXexZBWye/5eoRasaBssjIiVR9Z+B9bJ7rNIbtWULwwd/4BdWbjqIZYkS9NzATOTltizlnFcYm/fsSql7Ar2n8/GqHufWuDoaDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047725; c=relaxed/simple;
	bh=aRuokypdO+y7Ex2kfuc2jc/yG9ZZAqFETX+v3Cgrw/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LmpVe9smqypWrch1ima9q7W4DguKZWd1M93RwwAPWsftAdCeHoDWmQoTW41+wfrNuE4rNy+ZcRHu8T02bPwluytdktqa9uowhTuZ18s+G7YLR3krjpwOJjitAak6tb0P3e98LULFm0iYfjW9aS638OSe9OaWMzvGfPCVHb6/jIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x8qjPRR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8qjPRR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD1C1F000E9;
	Tue, 14 Jul 2026 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047724;
	bh=CKkmzAAiip4uanRcNEIqDUTnBdWxIziqQegOiytRVIo=;
	h=Subject:To:Cc:From:Date;
	b=x8qjPRR+UBd2V5IEMsuoyXEvPwv0dqMmcwNPmZ1SXDM5Be0hG6z4QGSp7//kSCGTL
	 2W6uHBi78k/+ZmS8+UbAw+vFttY+JyyBEk1SLjjR8yzbZbS/+aOgszvj2/9mltx3eI
	 eR/DWFC+B5t5ZSmDlflmiFJzGf+TeXunOMl2atPA=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: Fix VDM type for Enter Mode commands" failed to apply to 6.6-stable tree
To: andyshrk@163.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:48:38 +0200
Message-ID: <2026071438-irk-imbecile-3d77@gregkh>
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
git cherry-pick -x 9cff680e47632b7723cb19f9c5e63669063c3417
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071438-irk-imbecile-3d77@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cff680e47632b7723cb19f9c5e63669063c3417 Mon Sep 17 00:00:00 2001
From: Andy Yan <andyshrk@163.com>
Date: Thu, 4 Jun 2026 18:50:24 +0800
Subject: [PATCH] usb: typec: tcpm: Fix VDM type for Enter Mode commands

VDO() second parameter is VDM type (bit 15): 1 for SVDM, 0 for UVDM.
Using 'vdo ? 2 : 1' corrupts SVID low bit when vdo is non-NULL
(2 << 15 = BIT(16)). Enter Mode is always SVDM, hardcode to 1.

Fixes: 8face9aa57c8 ("usb: typec: Add parameter for the VDO to typec_altmode_enter()")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260604105059.18750-1-andyshrk@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bc531923b1ca..89eec20a2064 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3093,7 +3093,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
@@ -3141,7 +3141,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);

