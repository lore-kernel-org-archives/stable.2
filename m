Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C74BB7FD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448793; cv=none; b=Y3X5/PYBDnw+AibKco37euPK+ZEZEtT2UizO4lP/zYVfPmFaMkJIRBpiZ7q41+XNjGP9e+aQeLvhWDsoQikSStss0YOA8LMcVuP+aK4w5EbPj2VqP1FOrOR3EoRxBrI7uHXkEYNBDZte1hiHdj9fgeLdvbZDOT5NsLSbxEUBOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448793; c=relaxed/simple;
	bh=gmZ6xw/c/DoSCWb/lX1Lq9OB3Qt/DzpRrNriiddpTVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DMcJFW8yLXE8D10lLXZzAhOIZy+SONucB/Obrcdml7lLB7JRZmh+2xx/+IfL9UM0vlWIsW4ndBbctEiOrRBRoHR5IGjzS2DKYHDWB8ugRUxz4Wo+wezsklzD4dMLJlbquaWngYS9OaRGE5mYUdWX1S0T2oHBm4qzLDAxRuwv+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlVvnj/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlVvnj/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923A01F000E9;
	Thu,  3 Sep 2026 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448792;
	bh=AW0WwdZTqtYaff/+DOuhUNTfsnRis30g2cfZIQBIRTU=;
	h=Subject:To:Cc:From:Date;
	b=AlVvnj/Jg8yUdyT7PktrpgIJkvzGrI+9Ebt9rvXf2IIMZWkVIHHnSA3CPNo+ZNPBn
	 ZRiMrpcuYTNpgSDnLKf/pbEgInvxPPKqHtf2AubTH+WVgA1KACQxpkMuuoMLNQcAL2
	 ox14MJBIgI3ZnEqnpzMs8Zu77av5Vm76UCJpsSEo=
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx" failed to apply to 6.18-stable tree
To: krishna.chomal108@gmail.com,ilpo.jarvinen@linux.intel.com,yahmedd043@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:56:37 +0200
Message-ID: <2026090337-factoid-slander-d0ac@gregkh>
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
git cherry-pick -x a7320d6eb9c4240c948cd9c64582b3bd04cbaf4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090337-factoid-slander-d0ac@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7320d6eb9c4240c948cd9c64582b3bd04cbaf4b Mon Sep 17 00:00:00 2001
From: Krishna Chomal <krishna.chomal108@gmail.com>
Date: Tue, 23 Jun 2026 19:43:14 +0530
Subject: [PATCH] platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx
 (8DD6)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The HP OMEN MAX 16-ak0xxx (board ID: 8DD6) has the same WMI interface
as other Victus S boards, but requires quirks for correctly switching
thermal profile.

After testing we know that (similar to another HP Omen Max 16 device,
board ID 8D87), the embedded controller on this board does not expose
thermal profile which means we have to intentionally disable EC readback.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_no_ec_thermal_params.

Testing on board 8DD6 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Yahia Ahmed <yahmedd043@gmail.com>
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260623141314.33947-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0dcf2901259e..34c9b941bdd8 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -310,6 +310,10 @@ static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D87") },
 		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
+		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
 		.driver_data = (void *)&omen_v1_legacy_board_params,

