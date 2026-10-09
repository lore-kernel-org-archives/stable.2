Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF849D59E;
	Fri,  9 Oct 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549079; cv=none; b=UW8xlwNXk5ypdzuHZ4h+DA5xjvRTC6yaDWo+YB1t/RFbVHKk+bzrv0PHeO8IcHDpMns0c4mGC+8KgtpSs1xfxWHr9BbQeyWQCCigWdagTMHbQqOFMt0hnWReBqQZOftUFiwTJiaJ/R5RUD9y9FD1h0UtuJ7gY1nYFpTDO+hX+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549079; c=relaxed/simple;
	bh=gCGrVX77w94m9nRQ3vYl6kbT9kZy8kchqweQErV3Tc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWougYAiZZDT83QbCt/NkGliC/KX7keIwhOBjdpuVUAmCIdq07NBOHcQz1hKovzoOnY4N75XElpi3sio1YtBap9UeoaKOuZmeWx6N5tHhA8UpslxzJLdcuD3B/aOvHFG2UjohGcUZsdyEXU2BKEEVIoxP3uoCAzL9h8CEcQOrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnp3uvj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnp3uvj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A771F000FF;
	Fri,  9 Oct 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549073;
	bh=VQy6cB5NdQa9uOsHGYNSmFahll0UpOpTKyEvMlcEPyU=;
	h=From:To:Cc:Subject:Date;
	b=Gnp3uvj+4oXd3K6ZwsDWJgMrE8kKjwq3Rs/zCPw44ic6n1lCQ/9nWQpgU3WuZoy+F
	 66Qb5hBkjk8rOGIp/ydx4RDGCWIMOElOBmrn3FDo4IZuNfKYAJc2ZozqQUaeErzaQL
	 7kjRjHin+0HAGdOngzfP4vU10/zNSM/AZWavkMde22fRq3FhKd79bNrl6v1EVr4q7+
	 f4BpsJVc6WWSJF0NALL/k0QTsNhHxZl9GHwUzSm46vyO5oUnrcOBgjuYDQsfExJm+g
	 6LrKiKX+H7rff0tYFP+fOvjAQBoQ1Mi+u9ZNDjJNZjadq4bi3E7L3trJVbYmZUjbY3
	 +u9kSVWOmwXWg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xF9kl-00000001wos-147v;
	Fri, 09 Oct 2026 14:31:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: cdc-acm: fix urb leak on disconnect
Date: Fri,  9 Oct 2026 14:29:34 +0200
Message-ID: <20261009122934.464142-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken by usb_anchor_urb() when removing
URBs from the delayed URB anchor to prevent them from leaking when the
device is later disconnected.

Fixes: 140cb81ac8c6 ("USB: cdc-acm: fix broken runtime suspend")
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/20260917161217.2161883-1-vulab@iscas.ac.cn/
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7bc5329fa3ed..140e4f241b7a 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -783,6 +783,7 @@ static void acm_port_shutdown(struct tty_port *port)
 		urb = usb_get_from_anchor(&acm->delayed);
 		if (!urb)
 			break;
+		usb_put_urb(urb);
 		wb = urb->context;
 		wb->use = false;
 		usb_autopm_put_interface_async(acm->control);
@@ -1705,7 +1706,7 @@ static int acm_resume(struct usb_interface *intf)
 			urb = usb_get_from_anchor(&acm->delayed);
 			if (!urb)
 				break;
-
+			usb_put_urb(urb);
 			acm_start_wb(acm, urb->context);
 		}
 
-- 
2.55.0

