Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA528469A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047739; cv=none; b=l6RMhgyNmkpDEtURNooXQFZMm7+RstrSb/H8hdSrI0HI7JkvmASoUNZEastjHk3ciJ9P8Z08zyqPBY79Uivn6b6nJp+9+z41ofdNwQ/KKZPM9p+1Xs/n0LEd6YW4wSCZ1OqleVCB6Jq0CAAQmDe3qgU9bkE17QzBLh6jppn/GfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047739; c=relaxed/simple;
	bh=SM3S5uHCJoKfiCu1haIL10jOb2NELSgUVCxRdMhwm4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JA/ZcWr/e/hMlitvbT6SpNg3gsUJcgQYUCvMwMx2k8JnGtdCDHciI9t2SN9uY5pMFtb3kh7V0BAilCxq2t9UzthrRvUgMWerQY7BV8G3I7lTp6dgsI+Ba3mnbTtGbQ/WVaqDM2C+A9RkPxlpKIrBq5SBThzBUACJBuBpQF1A1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRrNAc0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRrNAc0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466BB1F000E9;
	Tue, 14 Jul 2026 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047737;
	bh=SXY9OpoxZ+bzMA+VzyeZXk1Y0H0SCjVaPNhNccVQ9vY=;
	h=Subject:To:Cc:From:Date;
	b=PRrNAc0ISX0TN8cz0wxxmnawpB7kIpIwhoFPPbzs0AFG7QTmaK6opd/ZmvUr2I4Lr
	 WUErXy7iovs7OkV98+8W69NhcrXBSLiFcoaOd2g22izOBmAktmd7LC2E9eBODHIub/
	 b9bSocr1zftzObS5zJiqDsjeH67UDxGbTPRecaPA=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: Fix VDM type for Enter Mode commands" failed to apply to 5.10-stable tree
To: andyshrk@163.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:48:39 +0200
Message-ID: <2026071438-zesty-cringe-ce8c@gregkh>
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
git cherry-pick -x 9cff680e47632b7723cb19f9c5e63669063c3417
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071438-zesty-cringe-ce8c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

