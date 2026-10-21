Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595291;
	b=YOZG8rvGtqjWVppN14Cq+WlgPtqkp12KPq4mghwfSngjsZ6XC5isi0nPctouewPugVRj
	 My+6r7nyg2gFeh3wvxWOMJcYR8mAVffVqd5KoZ+sftS4urfuASNfps5w9Hdsu3vqm5tX3
	 edyI2GoNjw9JrTNWY4on2cxMU821WUSP4rMWGgP5xTC8SneBvS7z7Cc6K1BxazA1JEzA1
	 JThCZR1ZnmBt1DnPst2qJwxOY+h/zHWKbwq5XXYdwSQZyDcH/5NvTD6xgvQXXckInPLDp
	 d7BeD+4ZTY90Wnq1vzGdVJ1Tzd8NvhTsTQAlIBh2yfDEx4isQUdwUuTx/ZyW/jO9aXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1xd2G1a6EwVoj0fOyb9t0PAej9iO13m2addwjCedmFo=;
	b=dWVBBvG0QthwtoZ6P/m7xuMlj6nAPKUbIPrk81ZvFeZ5XGhaECe/Lf2aHPqj4IfqdLcE
	 rTyx9mjXYHRA2GErdydWohIfX6/FNcb7WcxmKsbx6D9LoQrYg0oCAwp8vpIFOIgAPLJnw
	 uI30Qhsg6Ozq4ec5ChEdsQ70TELx7HwFuWnRtpNAVF08KGefpL1MghYm4yy3zst6GFPOs
	 J76O9B/x3VQTEZpuvIxU64nJjOFRf9xWbuoNfkZ5KxxXF/0NEWwCceM4djjDMbEQyKvOU
	 xujcruIpBUy6NkNXQN9hMI9TwXAHAw7fgu3WpXN2RnPu4w9tqtfD4Wl3Y//CecCq2og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OL5xFrtM;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8F606A334
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E8F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OL5xFrtM
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7fccba9c675so2571579a34.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792595290; x=1793200090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xd2G1a6EwVoj0fOyb9t0PAej9iO13m2addwjCedmFo=;
        b=OL5xFrtMjErJRdSKQEUBMY60T4dNxi1k0X6hw3RVvRjMS9VQlsTv383JOK/OSFND39
         e28RtA+s9BYZdiFdelXqqP1mTMVsqyg6ddIO4dNMw1T66yImgMoEJuoHGfe6tTPMIxlM
         LIS0jEgdk34C5pCKZA0eOmIL7viX9PvCYeWaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595290; x=1793200090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xd2G1a6EwVoj0fOyb9t0PAej9iO13m2addwjCedmFo=;
        b=CoDusdDWmLY4suDdWxhwcFSEwOXCIY0WEpVFavfehpD1Wgh0i7VBqqRq+ueZXKLr9m
         TeGa+M9S2bXYSkIYOQt47EsqK/J54F5yRmvZK1qpcOeT+DV0EyILMdACi5aK2x3xrlF1
         OKmrjU8/NjwY48i4tTP1l+GbDTZ/A0zsgBQg8L7v+uouiyGoGaZn07x8KSj28Rvnksjk
         +4cSMrUYu6F5tRA+lMMY/GxQTkYE8WJr1BGM7+lqLihe/xfim1FV1iKlas3Xg5rJHTT8
         QbdzLT8eyb7a6fpAqsh8NZIifqykjIze7OyeAXQV9hue/jZvQEynRT8ek0pn0tJSEdP8
         5SOA==
X-Forwarded-Encrypted: i=1; AKwUvBzVwYN8YDT9Bnkg6cSHZWZFCOSVf9Tql72GE93nHEoBodd3MQoZg8w0Mplw90dM5SwRvFr031k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK83ZJGxSnkf0K65QOoRrq5SBo/HKFcxFW+l7x7y9xxLyTkCNIn
	ApqgjtNjD8edjLttCEKAYFlT7PHs6FQVfqRcUQ/N2fWOjwvQ8GwX5zrb/EwED/75PFVEx/ZQWYx
	oo9HBpQ==
X-Gm-Gg: AYBFou1b57xKNckzgreY/4/XEA2XptXp9m7xb2xIcup5DNklVTZze/6DipZ48P/N4Dm
	KhQtyC56x3k5lu0fdzOUWnRqjuj3VMf/i/BfFjiDjrU4eXIA18O32h8HtlhRWqEr1tO/Kw5vCr/
	OyeWFSBivCFXsPiD/WsYvJE9ChOhqWWlHzRXA2A44jjlycjDrmgv9hpVl8c9ZqLkEAQUjZp06su
	go5L34ZFi6au/R/RBmuGLuLUyIcQJAYJdSzhbnj4SEaftkrAJO5u7VozqFPSKAGUDM0ZPIiR39f
	Q7iaxA3z69hq0TaJxTay+VZ6XzB+b/r/uee/vSAS4/O/fDnRCN1eM6mU4RhM0m9WZ8gJjOg7VL2
	FamiDiMLIBi9bggyR4O+Y6vy7iAln0Mgtz3BuxXHpTl6g7XF1Zir1gA/EXh9s134BG/wvHS3e0s
	K01+u0IBLYr0k69JJNEvi5XQ//Itup6zbaTb3hFvh6uP5ow3uMuvBaR4QMt8m6IJSbSUjZ38Zd0
	HIHxR1ACXxenF5kqdaGg8AB+v357XO8lDerq7A/u9okdecNi+b7azvgETiPerFQr8ovrH6wuTbn
	zrtghPJo/KCP7eHp0dKsKgOqKjQSkYfOEAGA9UJtM0DW
X-Received: by 2002:a05:6808:1a07:b0:4c2:a312:f0ad with SMTP id 5614622812f47-55353a9aef2mr1312261b6e.8.1792595290146;
        Wed, 21 Oct 2026 08:08:10 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400bd39sm2023922b6e.6.2026.10.21.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:08:08 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hongren Zheng <i@zenithal.me>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Raul E Rangel <rrangel@chromium.org>,
	stable@vger.kernel.org,
	"Brian G. Merrell" <bgmerrell@novell.com>
Subject: [PATCH 1/6] usbip: vhci_hcd: protect urb->hcpriv with priv_lock in vhci_urb_dequeue()
Date: Wed, 21 Oct 2026 09:06:56 -0600
Message-ID: <20261021150704.3129446-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021150704.3129446-1-rrangel@chromium.org>
References: <20261021150704.3129446-1-rrangel@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vhci_urb_dequeue(), urb->hcpriv is read and priv->vdev is
dereferenced while holding only vhci->lock, before acquiring
vdev->priv_lock. However, pickup_urb_and_free_priv() in vhci_rx.c frees
priv and clears urb->hcpriv under vdev->priv_lock without holding
vhci->lock.

If vhci_urb_dequeue() races with pickup_urb_and_free_priv() on a
completing URB, vhci_urb_dequeue() can observe a non-NULL priv pointer
just before pickup_urb_and_free_priv() frees it, leading to a
use-after-free when dereferencing priv->vdev or priv->seqnum, or a
double-free of priv.

Resolve the race by deriving vdev from urb->dev->portnum (matching
vhci_urb_enqueue(), and guarding against portnum == 0 in both) and
acquiring vdev->priv_lock (nested inside vhci->lock) before reading
urb->hcpriv.

Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Cc: stable@vger.kernel.org
Assisted-by: Gemini
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/usbip/vhci_hcd.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 39e8faf4c18c..3196ea80e7c2 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -704,7 +704,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	struct vhci_device *vdev;
 	unsigned long flags;
 
-	if (portnum > VHCI_HC_PORTS) {
+	if (!portnum || portnum > VHCI_HC_PORTS) {
 		dev_err(hcd_dev(hcd), "invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
@@ -899,34 +899,35 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 	unsigned long flags;
+	u8 portnum = urb->dev->portnum;
+	int ret;
+
+	if (!portnum || portnum > VHCI_HC_PORTS)
+		return -ENODEV;
+	vdev = &vhci_hcd->vdev[portnum - 1];
 
 	spin_lock_irqsave(&vhci->lock, flags);
+	spin_lock(&vdev->priv_lock);
 
 	priv = urb->hcpriv;
 	if (!priv) {
 		/* URB was never linked! or will be soon given back by
 		 * vhci_rx. */
+		spin_unlock(&vdev->priv_lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -EIDRM;
 	}
 
-	{
-		int ret = 0;
-
-		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
-		if (ret) {
-			spin_unlock_irqrestore(&vhci->lock, flags);
-			return ret;
-		}
+	ret = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (ret) {
+		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vhci->lock, flags);
+		return ret;
 	}
 
 	 /* send unlink request here? */
-	vdev = priv->vdev;
-
 	if (!vdev->ud.tcp_socket) {
 		/* tcp connection is closed */
-		spin_lock(&vdev->priv_lock);
-
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -948,8 +949,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* tcp connection is alive */
 		struct vhci_unlink *unlink;
 
-		spin_lock(&vdev->priv_lock);
-
 		/* setup CMD_UNLINK pdu */
 		unlink = kzalloc_obj(struct vhci_unlink, GFP_ATOMIC);
 		if (!unlink) {
-- 
2.56.0.212.g129ede20d9-goog

