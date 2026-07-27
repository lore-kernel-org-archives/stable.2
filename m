Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655B231C91
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157999; cv=none; b=EvWqVgVfJMiQD1N0IDLqsivdpgZMTRv6N2iCerX85Eh7zY+UfBdP+wAQBt112BbptIld16YAD28BqVgpVQJHeujzbLbts2JQxTWrIbJO+yoWduTI/4CQH28UdPxtwg8BIJ2xfGekYWKvUT87Ydewpmt1meCa3IPNamkRQVXeBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157999; c=relaxed/simple;
	bh=+MVbzHjYzsQk7pRtK0Uj15dYLgL/GI2OZPcSipDlOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef+F8PQEb38QSBAFWuKw7CRqrM0w49UcUx0Qq5jSxvCuDVjx7d1znWQ4J0v7slOMSs0K/YH4en3zDsCXw+71wtm+d+527tJX4r+pkMMi61DPnjR0cB/MAH3IXCSbQHZolrfQXOYkjJJ6pNl9pvMDfaCVllQF80TsckQslh4gJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG+q3j94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG+q3j94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E51F000E9;
	Mon, 27 Jul 2026 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157997;
	bh=3vFG4PRjKpBxkI9Z0nu7Ru+LlaajGsJsriMkjU86j3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NG+q3j94m9uM+Y24B3hPuoplyhn8r2K3i0h5KzWR8kaAZv6k1UkKarWzvjyByRJm8
	 00UwyPTxIlZbbYVmcs56eBJF0bA/nXUKR2L8RtUUkoSSPgrXmwW060lRQ7ry+29N9A
	 WaoK3Vp1HjzL2FPSjYb5aoQ0eNwMKjIrj78Gd8UucF8rZNI7JAZFjE8Grj0cTuKtvX
	 rgTfttKqs/hJCvfmRWBXcLw6QNZXbbtkelbvt7Qo1rHw9CXz8idr9RIpliznhNgEZq
	 9oH5vfk4n4uqV9KOOK1yL8KWnB7H+Pu1fc3G/jEoJCDl666HuLUfowMw+Z5E9AF9w1
	 2gJl0P8vE4vwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] can: esd_usb: kill anchored URBs before freeing netdevs
Date: Mon, 27 Jul 2026 09:13:14 -0400
Message-ID: <20260727131314.399083-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727131314.399083-1-sashal@kernel.org>
References: <2026072029-exit-twerp-6461@gregkh>
 <20260727131314.399083-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit c43122fef328a70045fe7621c06de6b2b8e19264 ]

esd_usb_disconnect() frees each CAN netdev with free_candev() inside
its per-netdev loop and only calls unlink_all_urbs(dev) afterwards.
The per-netdev private data (struct esd_usb_net_priv) is embedded in
the net_device allocation returned by alloc_candev(), so once
free_candev() has run, dev->nets[i] points to freed memory.
unlink_all_urbs() then dereferences the freed dev->nets[i] to kill the
per-netdev TX anchor (usb_kill_anchored_urbs(&priv->tx_submitted)),
clear active_tx_jobs, and reset priv->tx_contexts[].

Reorder the teardown so the anchored URBs are killed before the netdevs
are freed, matching other CAN/USB drivers in the same directory such as
ems_usb, usb_8dev and mcba_usb, which unregister, then unlink, then
free: unregister the netdevs first (which stops their TX queues), call
unlink_all_urbs(dev) once, then free the netdevs.

This issue was found by an in-house static analysis tool.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260709164159.497640-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/esd_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 1430edf8898386..253cb2a50a5173 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1151,10 +1151,13 @@ static void esd_usb2_disconnect(struct usb_interface *intf)
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
 				unregister_netdev(netdev);
-				free_candev(netdev);
 			}
 		}
 		unlink_all_urbs(dev);
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i])
+				free_candev(dev->nets[i]->netdev);
+		}
 		kfree(dev);
 	}
 }
-- 
2.53.0

