Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30F3D88E0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663693; cv=none; b=lgtXgasCUhw2aLY8dcrKlj4PfYCtFNGl7dKMblBIq9vczZuTOJZM9dY/udZnbzVfu9cMoz2QB7yB/kQfLVd4KcrHE9X/QQzRpovwTW/EfNldXmed03kAUG6SXKn4ufvANC/DqOpQ+1ZyMmubl7pjE4C3EbfOJIRQts1PD5oZ8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663693; c=relaxed/simple;
	bh=NsWSON0WhxFwV9d3Z/uhgkyuTkws0Vndf4VcKSaP2eE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rUsabxt5dEq14TTfSnkleu3YT9VFISk6t2ou6hwkq/jRJkmcf3X+1KtgNNs122onB/wcl87w4+7oqYfDvxCxUrdsiGEASJQ24NStkuUtTp9w8xLGjto9ewrtVxKSAM3iwL8r/EvPDoNyON+qkmZTMKTlQQpKD+r7+fRMQCYKSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SR5QBWF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SR5QBWF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D51F00A3A;
	Tue, 25 Aug 2026 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663691;
	bh=tKE+ZHa6sJA7rxq3rwKXCQ91qoLKDbtqI0v+ZMdgBZM=;
	h=Subject:To:Cc:From:Date;
	b=SR5QBWF9PIK4DsPSuC7ahBRP2hJO/mG89IWG5s5efTcT2jLdXAWq1jbHkMgjmaqyo
	 ckog4XRtcue7lmykTb+5wZ0afapA9GuZMe3mzBa0hArx+5xAzEOTwsqsuO5NeYDsQ1
	 xujMyrypz+gj2keF2Tt2vOfb9dexXJgzwH/PiaEU=
Subject: FAILED: patch "[PATCH] HID: nintendo: stop device IO before hid_hw_stop on probe" failed to apply to 6.6-stable tree
To: yijiangshan@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:14:37 +0200
Message-ID: <2026082537-drown-acquaint-6edf@gregkh>
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
git cherry-pick -x 1f74d3bff6fe04a64e02ab3661d2e0d554565aa6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082537-drown-acquaint-6edf@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f74d3bff6fe04a64e02ab3661d2e0d554565aa6 Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Thu, 30 Jul 2026 11:19:27 +0800
Subject: [PATCH] HID: nintendo: stop device IO before hid_hw_stop on probe
 failure

nintendo_hid_probe() calls hid_device_io_start() before joycon_init()
and joycon_leds_create().  If either fails, the error path jumps to
err_close which calls hid_hw_close()/hid_hw_stop() without first calling
hid_device_io_stop().

hid_hw_stop() does not stop device IO, so hid_input_report() may still
run and access driver data that is being torn down, resulting in a
use-after-free.

Add an err_io_stop label that calls hid_device_io_stop() before
hid_hw_close(), and point the two post-io_start error paths at it.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index e7302ec01ff1..0db553528826 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2736,14 +2736,14 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	ret = joycon_init(hdev);
 	if (ret) {
 		hid_err(hdev, "Failed to initialize controller; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the leds */
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the battery power supply */
@@ -2766,7 +2766,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
 err_ida:
 	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
-err_close:
+err_io_stop:
+	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);

