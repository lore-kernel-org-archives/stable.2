Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707105;
	b=3jly16LRpCTLJCpfBxdU2iuE9U2lLZ5a5YQC8VZWlzQ+agp0TyaGpSGj/BVq0YHHRQ5Y
	 mU7XF8vm7VEB0XdKH9bZK5b+gUiS9apmW8Ol9g8DVqqO2GojXu60Dgm6xt53VxTZ1foio
	 0sYJM4/W0S13kW9dg9Dud0ZjiaWbEEpOpJH9i5KIQzHA50IzD8EtwZ+V5wN/GCcvi+1R3
	 LZuCxpkaYeq3RnvpUJlJnsrQay8quhrOfNUY2aP6SxKnHaTyyaqrwBeDNDX2yLVxC3VN1
	 FwaCMw1AyKZcu+Uf7g3DVW/SYc0DAFpTz4v8mYl2D3Dyu0SKqtnHoZLDpSajLL4qKQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aHz0GoEJDXlU9lcHIo3h9szXx/6VYSD56o+N1aYihas=;
	b=dRUswVOwVJzRYjL8fTkGAryrlft/5YX4UxLjFHOaFKxCQuH4LXRJPVYjmofv84ymiDTK
	 4kMMaALyMf2xr1Dt6ZnIZoRB6h2hOeQDY5i/br+T2BjTG3TevJ9BRBwD6vTOT+KqR/IQx
	 3+/kItonYhP+95yKgd84w3+uyBJ7ZzCCjBAlSlgVtV/vww9j5xAca17nYXwORhiNvfZjl
	 8KhMFneanHbcUsLUOADZ5BG5tBB4m+TB2ZgHzetTzqslE86fpARx/UPI0pgm+JmGAFE38
	 WPokB6i3Qzq8f3nxpB1IMwfg/09+FfjXczeACRPoTAHF/cPlka8lUqtiSxY+F0Ze0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjsHfZSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BD606A682
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjsHfZSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB04A1F000ED;
	Thu, 26 Nov 2026 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707105;
	bh=aHz0GoEJDXlU9lcHIo3h9szXx/6VYSD56o+N1aYihas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CjsHfZSR6KMpRWu6D8/xDgUXRGCobWLtBLVAU7Qik40LWkcEAcD+zRSHfm1WZrCw4
	 q6orF3Oh1GntQ6PkuF+myK/EmXQV4wc+gJWEnOyZqZTUBvoEGJXwk+QQPXRnHFhXLr
	 pArKOrguJwxlhcbjod6GWuXuThYm/dT4QH/OTfLSnbAwnb77tUGOSfPZFexMXBj/2p
	 PJ5PBtBgMzyZBzCO79vwOBPjKV8U/iT5YbtvcRCTSCTxKpYyDCX0GUIzYXs5BUBWIY
	 +7lkFYrJs3wd1mCWSpPWsvW+9AsbkcUFOAZsbVrJdQncuzp+WLMjKO25deVjYQGQNB
	 fhI84o/ESIO9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Brooke Basile <brookebasile@gmail.com>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Colitti <lorenzo@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] usb: gadget: f_ncm: remove spurious boolean timer_stopping
Date: Thu, 26 Nov 2026 10:31:40 -0500
Message-ID: <20261126153132.2453772-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126153132.2453772-1-sashal@kernel.org>
References: <2026112552-crinkle-hurling-1987@gregkh>
 <20261126153132.2453772-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit cf4e2e880bde13af103d229be261e8f80c37921f ]

It is equivalent to ncm->netdev being NULL.

Cc: Brooke Basile <brookebasile@gmail.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20210701114834.884597-2-zenczykowski@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78585f90feb3 ("usb: gadget: f_ncm: restart the TX timer if the TX freelist is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ncm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 558ecd0331a80..630b131422022 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -73,7 +73,6 @@ struct f_ncm {
 	struct sk_buff			*skb_tx_ndp;
 	u16				ndp_dgram_count;
 	struct hrtimer			task_timer;
-	bool				timer_stopping;
 };
 
 static inline struct f_ncm *func_to_ncm(struct usb_function *f)
@@ -891,7 +890,6 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 
 		if (ncm->port.in_ep->enabled) {
 			DBG(cdev, "reset ncm\n");
-			ncm->timer_stopping = true;
 			ncm->netdev = NULL;
 			gether_disconnect(&ncm->port);
 			ncm_reset_values(ncm);
@@ -929,7 +927,6 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			if (IS_ERR(net))
 				return PTR_ERR(net);
 			ncm->netdev = net;
-			ncm->timer_stopping = false;
 		}
 
 		spin_lock(&ncm->lock);
@@ -1159,16 +1156,19 @@ static struct sk_buff *ncm_wrap_ntb(struct gether *port,
 static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 {
 	struct f_ncm *ncm = container_of(data, struct f_ncm, task_timer);
+	struct net_device *netdev = READ_ONCE(ncm->netdev);
 
 	/* Only send if data is available. */
-	if (!ncm->timer_stopping && ncm->skb_tx_data) {
+	if (netdev && ncm->skb_tx_data) {
 		/* XXX This allowance of a NULL skb argument to ndo_start_xmit
 		 * XXX is not sane.  The gadget layer should be redesigned so
 		 * XXX that the dev->wrap() invocations to build SKBs is transparent
 		 * XXX and performed in some way outside of the ndo_start_xmit
 		 * XXX interface.
+		 *
+		 * This will call directly into u_ether's eth_start_xmit()
 		 */
-		ncm->netdev->netdev_ops->ndo_start_xmit(NULL, ncm->netdev);
+		netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
 	}
 	return HRTIMER_NORESTART;
 }
@@ -1386,7 +1386,6 @@ static void ncm_disable(struct usb_function *f)
 	DBG(cdev, "ncm deactivated\n");
 
 	if (ncm->port.in_ep->enabled) {
-		ncm->timer_stopping = true;
 		ncm->netdev = NULL;
 		gether_disconnect(&ncm->port);
 	}
-- 
2.53.0

