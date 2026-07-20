Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEE435AA4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562227; cv=none; b=GeQGfOidXCSkepNCkQPVb+hq27ak/INx6/dkUIwExSj54pS+FvkNVkV8JXaDqJBU95DWQ9TNM/hF2HkOKEh4qyM9u02h0NtvfG5YIs1wRQ93AAcmdqnvqsyrwNewFBGa0QB0wDh9CvMYXXslFJjvA3alRxrJLdPig6NSG5pI7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562227; c=relaxed/simple;
	bh=Z2ynaCbuV5H+pHTyUe5Edp7p271uDWNUPKSOLr8U9SE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t7aK65TGOeO2z+yANiyiLYnyvkBQzGWIP3dP8XPK1lK4I5sQv+JDqOTgx0+kSXs+84vcu+3oc4vNPuOCjLEsLZfz8TywWPsuHknKzYoirikbRXR0WsupDC58St6C8GcMYCf0QBuL8+twZSOHOOV52e32hPN3blduObCjvJ+kGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAJs+4vZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAJs+4vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93ED1F000E9;
	Mon, 20 Jul 2026 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562226;
	bh=6QvyuWUWGoKcoxCO87E6jXaWA0QgH+sS8xpZ10Jtt8g=;
	h=Subject:To:Cc:From:Date;
	b=hAJs+4vZD5ivLkWZF55yUeLGK4H92eUBr+iyh0HbrZXvpOnxHYiAU+8E+Va5P2WDP
	 +pfzeBHKPMKhsdJ0o56g+rCmE6kiddR7BnqxrY0TiiG8YrAH8+wz+cOquDD/IQEobz
	 ZWi4EwZFgkcM3DunJ0Vvp+2uxJtyLJMkbDjgVqbQ=
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8D26)" failed to apply to 6.18-stable tree
To: krishna.chomal108@gmail.com,alberto_e_88@yahoo.es,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:28:21 +0200
Message-ID: <2026072021-said-startling-e2c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0aab31d47c2e857ca05028d718d1e0d239e683ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072021-said-startling-e2c4@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0aab31d47c2e857ca05028d718d1e0d239e683ad Mon Sep 17 00:00:00 2001
From: Krishna Chomal <krishna.chomal108@gmail.com>
Date: Mon, 25 May 2026 15:52:26 +0530
Subject: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8D26)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The HP Omen 16-ap0xxx (board ID: 8D26) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_legacy_thermal_params.

Testing on board 8D26 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Alberto Escaño <alberto_e_88@yahoo.es>
Reported-by: Alberto Escaño <alberto_e_88@yahoo.es>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221514
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260525102226.56300-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 5042d124dea0..079db53bf10c 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -253,6 +253,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C9C") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D26") },
+		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D41") },
 		.driver_data = (void *)&omen_v1_no_ec_thermal_params,

