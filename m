Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007E32D7F1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663697; cv=none; b=F98eyiqJd2RjDumej07Ic/+skVeDFIFN6NHUC5iiIyrteRlqhTns/vN7DFwOiCfz3Wl5VFco1gwG+v0mxpWbaIJnTs5IzidsrKlT/QtPZAGT5r+CNaqOmcBOHoLSQFmCHvGjjei9uA6eol2ff39V6MF5YW7+XUdCcqx+P3BT81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663697; c=relaxed/simple;
	bh=ZcssEL9bZIv0WPe8Nt2US5CDn8zdnCl205MQqjwMYZA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kZsGbonjdSoxTf6lZGW9VHIkG2TNeRCtlLe9IwlNCM92yVpL3/eyF87E5pm5emFKMY/q3VHQZMtWTDbGdEggjY1LuGObnmHonX7PCBGzmF+ah7JZ3dJOsXId91GVhHtuvp3Aq4WZkbgCIOs9xVdZPVCPsNOpOZLrWKBkn0MkJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfPrEITg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfPrEITg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976041F00A3A;
	Tue, 25 Aug 2026 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663696;
	bh=Jjmb/FmcBm+OA+NYnLn93DDkysWOtlaSMLQ4LBAu+QQ=;
	h=Subject:To:Cc:From:Date;
	b=IfPrEITgSuopXqtc0CgtD4eu1BUgGXUc9gxZCacLzNWHVe43bA0UxFyhIgbCZVc3V
	 FeoSUz0w5ikqjMfhu6/CGY5TXlIiojh2jICUEvyNP0tK6l0jEFiGwZwklg+Te3NpL0
	 l25a9hAdRUhvoiRS51HZqc0Mw4i4Qhv29Ues/8mU=
Subject: FAILED: patch "[PATCH] HID: nintendo: stop device IO before hid_hw_stop on probe" failed to apply to 6.1-stable tree
To: yijiangshan@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:14:38 +0200
Message-ID: <2026082538-busboy-cannabis-7578@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1f74d3bff6fe04a64e02ab3661d2e0d554565aa6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082538-busboy-cannabis-7578@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

