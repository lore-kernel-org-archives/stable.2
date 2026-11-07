Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794045373;
	b=IPOVYKKejqU02xuNJhC19ORwzvMD1Xp2X1YeLDueH4TdkID9BCBacUumKU4o5IcvTSz+
	 6IQ7gjLl03+DlacQR5DZd7rViS0NqbdjUWWtGwV8NeriINaqKxSQ1zQt9Omo4rB7zcb9v
	 9SkZRbmXs6L/p3Fl4NN1t9N73XsH46cEOEun4Q2/I49+qFUcvlGkbQ/PbiYcyWV/4Ho/E
	 6KDW3u4boQHXiBm32TR9BSs7A6ji9h6ISVlYokdOKnq5svExpqTr+KSVqbUYoUJ3Yos/j
	 d+KU0koEj01XY5JiYGkLBMitLrbmzt0yZx+hZ0mefFNFcF/XbqjJzXLdhLumndigbQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045373;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=erJHVq1MTvN2jO0IKVA8rHbv7vdv5ifoU81jf0G4rAg=;
	b=0rrlWqpWW/ShqSmetQQ9tBSQ2rv9W8SdCYevnWM2SXj/X7XaU7lTDnRhX1XVUd4XgDg1
	 mh7jSaoymeWpy3onwiQCWmfj7nYpUXTthZzA/fJhernIfpcAy212uOoXwCdmf/24TnGRo
	 nnD31zGVrT57lq5+1uGY5RxJocd8+wOCfMM1yc2wcuAvhcSp0YAr2KSqO0IqnqnMehigL
	 MT4338Ome39Wcx4715IFk9t0tmSMbyaqAsWvLbOw2oLiqByeHV8KNr7fucZrYNc7GH37v
	 Vo4TIW92Tbi6zWC9N5bAJH19/Ev0PSpQj/rX0IyF9wpLXUuku4xNDIffEVq/5Q6/oww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfvhgwMZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB3606A336;
	Sat,  7 Nov 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfvhgwMZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794045372;
	b=mYaJ5IJLt1pUdqZPmVo7WIpdA0xpNqPjJ/075EkG8JrrjJEnPdWuPzlOrVIiPFDCHuBp
	 Dd0r6Ehe3fPOUS3NyRciMNd6KfcB1BEFs9608l5MD2qYcdHE2xFJfYb54Sooi+Vm8RUvm
	 9ZJF/1YJsa05K+63qY89COfW9T+Ia41s7yWIZUIPW186QSvMJ46K8POZKWf5Ic6T2k/C5
	 DAbj24mGYJ7QLyhgYBq3BsuBn6+SnIRa0wFdR/KXEmPd+TwtMeMzG7OFgVbH8feTDG1gk
	 mQcorhFSdICFxtXeuIpHFgv2kNni/nuT7dAT4utk0/ZXbujGOaR3UckzN2CupPGcl+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045372;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=erJHVq1MTvN2jO0IKVA8rHbv7vdv5ifoU81jf0G4rAg=;
	b=rbkRSVDPs5iiQ6UYl2W7SVvLcIegd0tYQDSSmRG8xZeCsczQJht/8W1C+yyeKyth4dWd
	 5j1wkzKAmLfJ/MK+3ln/XL+xTqcwF9TMs+CPjcQZ29BEU8yOA4EQQZU1Tgfzh0YzDGeXz
	 EHBJp7Wz6N9WGmv8UwyqbktygrpRDHMg5BkBUTQvwitUsK6S29yJYK0ozc1gpOjnQkOiJ
	 hBaZkV3+s637QAT+l4X8IPgbjtJs1RRJrTnd5FWP6Wbie1aCQmA2x201Sl/YTVNNCaXV6
	 9pMhVCwo1M/YVKDLhcuQ5gU/YmkDX2zFEgyP6Jielc7n984P1Ks2iAiyinhLuNjsiUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 461D11F008A4;
	Sat,  7 Nov 2026 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045372;
	bh=erJHVq1MTvN2jO0IKVA8rHbv7vdv5ifoU81jf0G4rAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cfvhgwMZJUWKZxLVNVrys9Ct1H0Z0RKpP5j71xHcaFB+ej14TI7Yyp+PlpDwbA0tO
	 QrKva+/PW5R9K/XxOA/jGFBWBGvkh/8W8SvfJh2jqIqGoXhs/koBdOEqB+Zp4IhTXC
	 u8zGP+61tazzlJYGnuRAOJQ7LwFPUpGE5MDzmJ6PyuIaiF/oxEKHrUxFtMPDdvYnDW
	 VFp/DOMGR+GzKtxumyyKT7XOVvc/V+Wc8XOcoegFJKLMJrgBr9eW2O//B/dyzwn3om
	 MwujYAeKH1Ns9gotidSl/SwuKx9e70AwYw6Invp5zJwzgQgd30P7AARMXmDNzn0dRb
	 YPH0zgGhWmSTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C4D8147B55;
	Sat,  7 Nov 2026 09:56:10 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 17:56:10 +0800
Subject: [PATCH v3 2/2] usb: gadget: gadgetfs: prevent ep0 event counter
 underflow
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-b4-gadgetfs-ep0-v3-2-62089dc0ec07@gmail.com>
References: <20261107-b4-gadgetfs-ep0-v3-0-62089dc0ec07@gmail.com>
In-Reply-To: <20261107-b4-gadgetfs-ep0-v3-0-62089dc0ec07@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jing Lin <kayano050408@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794045369; l=2870;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=gg6AtEtNRozQ3dqRLHDDz9k+7o2eiciGbgBgfvIVd7I=;
 b=/jJ/G3VRaOusJLupXWFdQ1XqtIFzjosJwkBySKwNE4/Kvefe3k27vULCS9+lNwIdSqOBhuX25
 P8FwJf8VjJZDM+PRaDO6hAXhUAH9EPEsynQpG1IjtgWzi8QaXWwDGrY
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
runs, and subtracts the snapshot afterwards. A concurrent disconnect,
connect, or another reader can reset or consume the queue in that
window. If the new value is smaller than the snapshot, the unsigned
subtraction wraps and the next read walks past dev->event[N_EVENT] or
the event purge memmove uses a huge length.

Count queue purges with a generation counter and skip the consumption
when the queue was purged while userspace was copying. Clamp the
subtraction for any other concurrent decrease.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 87aff568a..6db3b7879 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -126,6 +126,7 @@ struct dev_data {
 	enum ep0_state			state;		/* P: lock */
 	struct usb_gadgetfs_event	event [N_EVENT];
 	unsigned			ev_next;
+	unsigned int			ev_generation;
 	struct fasync_struct		*fasync;
 	u8				current_config;
 
@@ -1174,7 +1175,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 scan:
 	/* return queued events right away */
 	if (dev->ev_next != 0) {
-		unsigned		i, n;
+		unsigned int		i, n, generation;
 
 		n = len / sizeof (struct usb_gadgetfs_event);
 		if (dev->ev_next < n)
@@ -1188,6 +1189,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 				break;
 			}
 		}
+		generation = dev->ev_generation;
 		spin_unlock_irq (&dev->lock);
 		len = n * sizeof (struct usb_gadgetfs_event);
 		if (copy_to_user (buf, &dev->event, len))
@@ -1199,12 +1201,16 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			 * concurrent ep0 readers may lose events.
 			 */
 			spin_lock_irq (&dev->lock);
-			if (dev->ev_next > n) {
-				memmove(&dev->event[0], &dev->event[n],
-					sizeof (struct usb_gadgetfs_event)
-						* (dev->ev_next - n));
+			if (dev->ev_generation == generation) {
+				if (dev->ev_next > n) {
+					memmove(&dev->event[0], &dev->event[n],
+						sizeof(struct usb_gadgetfs_event)
+							* (dev->ev_next - n));
+					dev->ev_next -= n;
+				} else {
+					dev->ev_next = 0;
+				}
 			}
-			dev->ev_next -= n;
 			spin_unlock_irq (&dev->lock);
 		}
 		return retval;
@@ -1252,6 +1258,7 @@ next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
 		fallthrough;
 	case GADGETFS_CONNECT:
 		dev->ev_next = 0;
+		dev->ev_generation++;
 		break;
 	case GADGETFS_SETUP:		/* previous request timed out */
 	case GADGETFS_SUSPEND:		/* same effect */

-- 
Git-155)


