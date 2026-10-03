Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E589370D54
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791069780; cv=none; b=NkQUr5BdgORbBmM7Zx7oypkK5C/a5Yf43wvUkHcc5DA5Cyg+whMTX5B12gGeqcy/Nqw+6IkexKHgBRHnWcRF1pH3ko1ekTPMSQNO63xp3pmvW6hlI4vlYg0VSnBAvxcVDHkrXigYEOSVe+fyn4fjL1DTyPpTYQ2J3gREojShMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791069780; c=relaxed/simple;
	bh=Mlh+XHuVXZbDZDVydCwkE4Oa5xGCB9h0wTyM4NfYqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4INlwpTKhwZltqkAcTYtrKH8l+zYT8khsG9rW2dFoeZlbaWP2QKAgk4gxLTBOJie0uMIhvsH+APnEcLeuVSo6Hlwlynf0h6c2e9Wy7i9fMr2Xe3W5fV989/l1SnNjEdR0O930N2V4IWRnNwxHneRq/wRnooAWdnnopdEgpz0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVIOuBXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVIOuBXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266911F0089B;
	Sat,  3 Oct 2026 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791069777;
	bh=OJA4Hbxmf6G3Ko0Y5t4g/35qgDmTVBTSiVnmA8ccKUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aVIOuBXpAijkO/kUB15x0AgTf1yFoHXWWojj/GguMd2B+DDZx+X0utBdk78SEWs/Y
	 2f1483oHyhRjqGFnK/VWxJqXKfdjLSc4RUO6VhCKzdWaSDSnpkZMMHOGkmfHOZ334z
	 yymLbfdP1zT0FQqqPwwE3lZXa6N69RRHpdy3BB/LGqVz20eS0pT0TaFkUirhQD9Tuo
	 3n06nZSidMeuIdmzzOcQMoS03zLwYbaj9NzrpgZxxbq8ff+ZeCiwtBNsCLr/qVg2E9
	 dF1hHfkWh4KmtUYDoo7DrYFPWTeziMyPwgi5vWbQnfdR1EQgaMlkO+SbtUt2+5X+tB
	 nt4XyuPhurHgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] HID: multitouch: stop the release timer from being rearmed on remove
Date: Sat,  3 Oct 2026 19:22:41 -0400
Message-ID: <20261003232157.716281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100301-attain-football-023d@gregkh>
References: <2026100301-attain-football-023d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 5acb2dace582f061aab5e14c399ac9480315f44b ]

mt_remove() quiesces the sticky-finger timer before stopping the
hardware:

    timer_delete_sync(&td->release_timer);

    sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
    hid_hw_stop(hdev);

timer_delete_sync() waits for a running callback and dequeues the timer,
but it does not stop the timer from being armed again. The transport is
still delivering reports at that point, and the report path rearms it:

    if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
        if (td->mt_io_flags & MT_IO_SLOTS_MASK)
            mod_timer(&td->release_timer,
                      jiffies + msecs_to_jiffies(100));

A report that arrives after timer_delete_sync() has returned therefore
leaves the timer queued. td is allocated with devm_kzalloc() against
hdev->dev, so it is freed when the driver is unbound, after mt_remove()
returns. When the timer fires afterwards, mt_expired_timeout()
dereferences the freed td:

    struct mt_device *td = timer_container_of(td, t, release_timer);
    struct hid_device *hdev = td->hdev;

    if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))

Simply moving the teardown after hid_hw_stop() does not fix this on its
own, because mt_expired_timeout() calls mt_release_contacts(), which
walks hdev->inputs; the timer still has to be quiesced before
hid_hw_stop() tears the input devices down.

Use timer_shutdown_sync() instead, which additionally makes any later
mod_timer() a no-op, so neither ordering constraint has to be traded off
against the other. This is the final-teardown pattern the function was
introduced for, and hid-wiimote already uses it for the same reason.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ sashal: Adapted the patch to replace del_timer_sync() instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4481bf5c9133d..422172ecf2bb2 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1895,7 +1895,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
-	del_timer_sync(&td->release_timer);
+	timer_shutdown_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
-- 
2.53.0

