Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892C3D16FC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674752; cv=none; b=DA72pyz0CFNERKO+5Y5E5KWuwczrB7Vc6Fzf9oq7cPD41fW5z9d01iQRFmRC1xTkzv5Z5iuaASSc5/sGRC+Ypf8zXUpmzPBZJdKt3PYR30e2j5Z8YjZr6tR+Fo48RlA35DwCM12Wdh9KvQ2Gph8dSeUMGr7Z1nC3kD19SXErpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674752; c=relaxed/simple;
	bh=gHKV4tGfCuULRJPQ0YKAfVkBE/QL8mLW3hzAgiuXsUM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RDEQWkE5wKq+W4JwabP+OwoZu2Icz6Z6DI1Y3vOToICNLRBMSPmb7vVC6sNa0uzw3R+rPeUdIXEwxdNr+LBvN8KwCIR23jzWvDuhgYqG6I74eXbNL5dX2f6A5YkNcHgHP3yhMiCv4YUD87B4ChLxpQOWzfJmL/pWCrCkqfiQgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esI/dBva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esI/dBva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ED71F000FF;
	Tue, 29 Sep 2026 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674750;
	bh=1AqG9LgLZFDnctatHtXyQq1762kZnPuAAvuH79zhzRk=;
	h=Subject:To:Cc:From:Date;
	b=esI/dBvap3qPh3/c/YjAnlWb+oY4lLL8RYUfPAF3Rb9jHL5Zgq6iPfBQiR1rK0scA
	 cEzTmb+hXokv8qDK2fO4HzWdXUZxBOMgNg3GHfMx4oJHFfAASZpIDzaVGvLtT7CHse
	 16/xvDvnH9ma+oceia2hzjHWgRXZ84AVK6XgLicU=
Subject: FAILED: patch "[PATCH] net: usb: lan78xx: Fix URB reference leak in" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:38:57 +0200
Message-ID: <2026092957-launder-virtuous-f28b@gregkh>
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
git cherry-pick -x 17741334d00bf5ebd37f8c1c36bc9c146a351deb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092957-launder-virtuous-f28b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17741334d00bf5ebd37f8c1c36bc9c146a351deb Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 11:58:11 +0000
Subject: [PATCH] net: usb: lan78xx: Fix URB reference leak in
 lan78xx_submit_deferred_urbs()

usb_get_from_anchor() hands over a reference to the URB, which the caller
must release. lan78xx_submit_deferred_urbs() never does, so every deferred
Tx URB keeps an extra reference: the counter grows on each suspend/resume
cycle and the URBs are never freed when the buffers are released. Drop
the reference after submitting, and on the path that drops the packet
instead of submitting it.

Fixes: 5f4cc6e25148 ("lan78xx: Fix race conditions in suspend/resume handling")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917115811.2150119-1-vulab@iscas.ac.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb782d81d84f..5655941f1478 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -5239,10 +5239,12 @@ static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
 		    !netif_carrier_ok(dev->net) ||
 		    pipe_halted) {
 			lan78xx_release_tx_buf(dev, skb);
+			usb_put_urb(urb);
 			continue;
 		}
 
 		ret = usb_submit_urb(urb, GFP_ATOMIC);
+		usb_put_urb(urb);
 
 		if (ret == 0) {
 			netif_trans_update(dev->net);

