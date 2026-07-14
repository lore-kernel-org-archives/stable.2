Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C8492519
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041098; cv=none; b=lHLktNF1hCHKfthb3Y6W8L/QkdbojYDmCx7JSyCuGxElVV9jyfz/Er8+//F4WC54xJqslS57vAx1OqXe+AW4uYNWj6nkPkXnsc+jptmLJcXlgFPwP8Fd6f5LjmF8kOuOyJ+YNHSmfyybDg13yVUKdqaY8t91CchlfoleagJIOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041098; c=relaxed/simple;
	bh=lnP4aBeUdynixOMY52VhZTYhRGsXi8NFXOYDVkjW2tk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cLrq3HPmWosMCzWZZfnR5CUQMH7HUQlOssSYomgSU/9/hNFRU6fmvQ8QXVRYZgLvHPAW6/D95lrE3uZcv2su5W/WfO0rp6u/FTnmL3X+TC8x7yo3iBjuotYB6ElzQaS8XIwibZBXa5S+HaAihDTDxuiu6jqaKPkGmUb85KwSXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jY8P6XyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jY8P6XyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED48F1F000E9;
	Tue, 14 Jul 2026 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784041096;
	bh=e44p2w6B5c9cv3Or/IPj8TYczG6q36YC2hN/d7uv4jA=;
	h=Subject:To:Cc:From:Date;
	b=jY8P6XyIqToRWCqGD/Eo5DVgPJelKW9waLlh5Wx8A4bTFlQETNJbVegKQznFfFzJ1
	 LzsACvn15O/3RNIIaGtANvNaKxb+Kr9enE4t3niSkK5A78rlLk2l7ktMZk2u58Igqi
	 /HEJeq6/JsrIiLyJyqza7wIiLx+WDBCXXmgMdfOU=
Subject: FAILED: patch "[PATCH] HID: pidff: Use correct effect type in effect update" failed to apply to 6.12-stable tree
To: oleg@makarenk.ooo,jkosina@suse.com,lemon.xah@gmail.com,oroundtree1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:55:45 +0200
Message-ID: <2026071445-promoter-disburse-fa77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b251598b8bf37300510868f739a79e07800d41ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071445-promoter-disburse-fa77@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b251598b8bf37300510868f739a79e07800d41ce Mon Sep 17 00:00:00 2001
From: Oleg Makarenko <oleg@makarenk.ooo>
Date: Tue, 9 Jun 2026 19:00:27 +0300
Subject: [PATCH] HID: pidff: Use correct effect type in effect update
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When updating an existing effect, the effect type from the last created
effect was sent to the device instead of the updated one.
This caused incorrect reports when a game creates multiple different
effects and updates only one that is not the last created.

Fixes FFB in multiple games that create multiple simultaneous effects
(Forza Horizon 5/6).

Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: stable@vger.kernel.org
Tested-by: Oliver Roundtree <oroundtree1@gmail.com>
Co-developed-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index c45f182d0448..5f4395f7c645 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -522,7 +522,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	pidff->set_effect[PID_EFFECT_BLOCK_INDEX].value[0] =
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
-		pidff->create_new_effect_type->value[0];
+		pidff_get_effect_type_id(pidff, effect);
 
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
 			   effect->replay.length);

