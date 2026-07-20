Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7534433BC7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562231; cv=none; b=J/aJuhrcpLQ0ZESUVUcTm2lx9Q39IXGjCPFhEYU0h3WcldAWfX/QC3OYe97QJxVgGbM9D2g/g5iDgyPf6WhMPbBe5rBomjZ9ifFnxcBu6f1k6RYhr15wBLTjtmH22Dxbtg4MPSudprmZx96utOiRbEFB2WE/BdE3Sp+vaO+6/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562231; c=relaxed/simple;
	bh=4MoA9QvKH5F3kIWvlq76t0PNHkOCxoTFvpUYNVA14Vc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HLz10GGDYqkA8Wx7D3pcZvjTx3B9irVYlZCcgfL5oGwatvN5X46PKz9k2zEF/s6arZ8qyu0bBY9eGg9wrXVC1ryvUvGPZm8V8E1oLljdKRdoAMy4JaX7zTIwCA4FusUcM+Zvu2WjF+8Tvr4CoKP+tZnwYFsFmE5zxMQwY8zu43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kXSrEC0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kXSrEC0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB451F000E9;
	Mon, 20 Jul 2026 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562228;
	bh=/YafLLpm1kermrMSwHDZlI9pigRtOzKF5QxzhgVoaxw=;
	h=Subject:To:Cc:From:Date;
	b=kXSrEC0jHHtTYFkCdV2kcDyi2OpEVNvIkX9TG5RoX8zT9t7t/eNvDRgsZi4DTNH8J
	 sL95T7L6cbk0+kpL4biB5mMuO088VeoFEVic+axiGX1bYjl4DDobyRNt1Z1GICd/2U
	 ZSd+F7TnPyLtt5N1IpVKjLvQb9NH3YE3av08QCQE=
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)" failed to apply to 6.18-stable tree
To: krishna.chomal108@gmail.com,ilpo.jarvinen@linux.intel.com,sivasli-ahmet@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:29:00 +0200
Message-ID: <2026072000-unfitted-elope-1652@gregkh>
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
git cherry-pick -x 56b7981c6f21670c0a1a62e6d2f9afb380e2596d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-unfitted-elope-1652@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56b7981c6f21670c0a1a62e6d2f9afb380e2596d Mon Sep 17 00:00:00 2001
From: Krishna Chomal <krishna.chomal108@gmail.com>
Date: Mon, 8 Jun 2026 19:12:55 +0530
Subject: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The HP Omen 16-ap0xxx (board ID: 8E35) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_legacy_thermal_params.

Testing on board 8E35 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Ahmet Öztürk <sivasli-ahmet@gmx.de>
Reported-by: Ahmet Öztürk <sivasli-ahmet@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221523
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260608134255.36280-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 079db53bf10c..8ba286ed8721 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -265,6 +265,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D87") },
 		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
+		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+	},
 	{},
 };
 

