Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B29367F31
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005587; cv=none; b=tH9+QF9juadR4x9D0p8r2SeVPGvb0mN601Rp5Lx7n5P7Un1p3i52/bJd4WSBYKyZ/qAdVY1EJPFo/AGecerm9y3roEWOOAP8NgtqYqRg6K99qahGokzfFgTCtYk63172IHRv8P+9dK9+o6FKmrhic+6qZcAnGdhcyR65ss1x0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005587; c=relaxed/simple;
	bh=IaIk2IQosx/h56aHBvb1dmYfPLpodhU0q+8MTD6kMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzsH1xsg9/Sx3LGTXJbNzJqHStE2HncLEGqOtOyJQHvUjhHfDJ+U4o7WkaiM5p368aB8rAz/6ydSSXaUTMtxpV5clc3aJYG/A19qCOLbZzCdljwqaP8Gms9NP308C8/oh13kG0Drk17eI+gcel6DrCVxVnAyBvBwQTncnzh0pC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQcNBhLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQcNBhLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A78C1F000FF;
	Thu, 10 Sep 2026 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005584;
	bh=AevA6saFGdrtRbN5x/w21/6vccVd43KaktrP2sdWKWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQcNBhLFI55rv/84HehUdwDBIyLSW3mUGc+kNZheOCDORFX6uABvS2fEH3U6zDeb3
	 5eFxqI3/AU9N5tLbu5i7DEnJuV/Mdux4tu8SeNWmY0aysf/C/HH6wCa44dLE5E/tfR
	 nZZUJAOBMcuiTwd7Y71F2EAq3WY5IPCNmhqBLK2tGUH4nXKHzRnprmJI0zIHq6bz2Y
	 H9bvMC1LTTxeO2qhIWwtA+D3uhtHhgS+dxyzv60FCXm33TTEaofgO7HEfJNDFpZiWm
	 jxmPzwQnmLnWA1BzOg0tXU5+5kvBQgpfpReFvgL9Gl88SabHRHskSkhztdTodT2aZv
	 1elsBjN5+KA5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: storage: realtek_cr: fix use-after-free on disconnect
Date: Wed,  9 Sep 2026 21:59:42 -0400
Message-ID: <20260910015942.3954058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090831-splotchy-crystal-8959@gregkh>
References: <2026090831-splotchy-crystal-8959@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 4ffee1aebb0c0ffcda9faffd17834ea9b00d42cc ]

realtek_cr_destructor() calls timer_delete() before the chip containing
the timer is freed. The timer callback may still be running and can
rearm itself, resulting in a use-after-free.

Use timer_shutdown_sync() to wait for the callback and prevent further
rearming. Do this unconditionally because ss_en may be changed after
the timer is armed.

Move timer_setup() into init_realtek_cr() so the timer is initialized
before any failure path can invoke the destructor.

Found by static analysis.

Fixes: e931830bb877 ("Realtek cr: Add autosuspend function.")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260727123414.44700-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted the timer_delete() removal to the branch’s del_timer() spelling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/realtek_cr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index a026c6cb6e684..de82d8260d729 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -915,7 +915,6 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	us->proto_handler = rts51x_invoke_transport;
 
 	chip->timer_expires = 0;
-	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
 	/* enable autosuspend function of the usb device */
@@ -933,10 +932,7 @@ static void realtek_cr_destructor(void *extra)
 		return;
 
 #ifdef CONFIG_REALTEK_AUTOPM
-	if (ss_en) {
-		del_timer(&chip->rts51x_suspend_timer);
-		chip->timer_expires = 0;
-	}
+	timer_shutdown_sync(&chip->rts51x_suspend_timer);
 #endif
 	kfree(chip->status);
 }
@@ -981,6 +977,9 @@ static int init_realtek_cr(struct us_data *us)
 
 	us->extra = chip;
 	us->extra_destructor = realtek_cr_destructor;
+#ifdef CONFIG_REALTEK_AUTOPM
+	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
+#endif
 	us->max_lun = chip->max_lun = rts51x_get_max_lun(us);
 	chip->us = us;
 
-- 
2.53.0

