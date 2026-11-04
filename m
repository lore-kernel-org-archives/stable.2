Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799881;
	b=TJO4bTObd8B0qXS7vswpMLz/byg6prKnl7eoF5y5FCci2xJC0G/ef1x0+y5zzXVNoaNz
	 yhsAhu4xwdZMcbuiXL9t+pstUVVM5ylnpQwqDhr+7IzlImNheTxyGP6SSV4BUeBC7eGkx
	 Y609w7yS/RbFkbBgF/D5lR4FPsCWEHk6iiGhZ7Vw1NOTbUeUlbXr0bUTAmUtWTj1/Gg+D
	 xche0JO5rvwXBUo77H3bNf/PYWnauzZO0HM8rhhQSqjpeTA8wyWRf+GdvrrMeuEsm9j6L
	 sWbYzDyeoOcawV5f2IBaZPZN29F/mQ81czDnwpCxx+o+287+J30JqRmDAyfx0Riy1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799881;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=haQveJfmTqpt8tNfzWBuQ95IRx/Z56KrtXuIwDInVmk=;
	b=5QVpXkvcAp//4NneAf7E9D5jKh8ktVei1J9naklUQ63yCvcOxcoYauYEsB51PpuNWd7W
	 e6VmKhHaG5dpDL4weK4Wzrsd7ajvb8qlfm4oTAPiScuKY8GlhJpERUuPWjD0I5xPQEzuj
	 hxvxcbJxjI7ZKKXkJx8GeHqDrdPV2euslug+gck9xtibvdhVj7qRQHW+9KlQbL5hh0cp9
	 7KFoYDjIPOxIewpWaZcVGJSpMRafF1w9gs6NPRwQID8DOTAi2KQ0p2KNZZfuHjcW1V/he
	 HKO5hLmEnTlaQ/qcOu78/aqTd/YYY4JybdEXbYn7VoCPx746e0rYqiq30Q1QGCOKK+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="ujBv/qBh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB6606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ujBv/qBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA51F000C1;
	Wed,  4 Nov 2026 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799881;
	bh=haQveJfmTqpt8tNfzWBuQ95IRx/Z56KrtXuIwDInVmk=;
	h=Subject:To:Cc:From:Date;
	b=ujBv/qBhHTlZxCE0JxORpmouQi9n9PXZ2nZcf7tVhjfuAwLmUsh3EKPNmCe3IWMxd
	 pczKjwVqNlOmHJuB4e03CSAvPkge5kzg5s3FSSV8W7PiPROPodFZuDMqWhgFZX653s
	 XH77CAvoOPVvEhYJD5wRdsb1ik2UTjyKhvovizHU=
Subject: FAILED: patch "[PATCH] HID: wacom: Write shared touch initial status only once" failed to apply to 5.10-stable tree
To: ping.cheng@wacom.com,jkosina@suse.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:44:38 +0100
Message-ID: <2026110438-reexamine-jubilant-7940@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x cae3031c691dff0be61a26bc64e31a6939010d5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110438-reexamine-jubilant-7940@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cae3031c691dff0be61a26bc64e31a6939010d5c Mon Sep 17 00:00:00 2001
From: Ping Cheng <ping.cheng@wacom.com>
Date: Wed, 7 Oct 2026 15:00:27 -0700
Subject: [PATCH] HID: wacom: Write shared touch initial status only once

For consistency with how the shared has_mute_touch_switch is handled
during registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {

