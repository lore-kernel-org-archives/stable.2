Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC287481648
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235486; cv=none; b=dtzVp53Hxfadz0mWxo9usDWmu38V8H3hl7EKNuoNiStdIsLMuVq9emESXCvyHItT3/4Ci9sWvGmuHq3oo1n6/aePL4Dz2CeyrKNBXSqv2/rKZHxLTqUhr1YGSkK4RiKW2acWXwqtSBP6/awHVd8s/gUY8bOLvTvNthf97kdIUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235486; c=relaxed/simple;
	bh=FXpl+aOb8ZxqdMza6huuGxKQd5fQg4/v+NznngJK6Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnKJQYZwgFKCHLcb66PWB+5VUblHN3tnq5q6GuKh07NUY62eLNR5uvVsYY/3wXhycTGOft689mV9Jb3WIykRtrjHe59ePYw7vlK5nWuyVXIeMby1xHQgYQ6uwcoki6ptTolv4s16X8QvpS6K4RinzRDj+wPtO4zkIbTjlmop49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpMzd4Fz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpMzd4Fz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab2cb02816so131695a91.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792235484; x=1792840284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcF+DRWasibANQc8YNZXnJ99HscJ7q/xfWKQy6h+B9g=;
        b=XpMzd4FzbShpMX9xL2Lg6X26Bpk637HW4XS1VxztHs+YW+/JnLgq2CRmhdw+51ctS0
         EY9N57UAjaGfaaUv2Fn27ElbSUWYppxU0S3znjFi0w/58LuojO9KoivpFj8etXCMHHaA
         iOI6XAYb1+2dE4BGdyWl1Whrh0cfzNk2J6E9CAcJPwP/zD26RLqhyv6rRxFZ+MWmV8ro
         drEsMs4NYiU7SzUpWSQ8oTBkG92tpAnoE7JjLgLxFqZCh3inUenBN4SKHeJbtQ2q3yC5
         OtvhrIRyDYifXR+8RnGyF7iATDa1Bi41tVQbc49FX5JwUKxjOH2kBwUrhpkUrC7cDSIb
         jrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792235484; x=1792840284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcF+DRWasibANQc8YNZXnJ99HscJ7q/xfWKQy6h+B9g=;
        b=B3sTOoK7+5KRH0YYwXZ2sP/UEzza+b7ltcL/XuO9/1z7vV7TSI1p3veRNOttpO8cM6
         ldjJo2Mh6i2c/uThKc90XB5n5rhhYm28zGLZyBcMA9Sv2hSOGklQ0odr8ilrI12zYk1F
         9TE+aQtBnzQHACbrXjNan4CXw5q+BtqjuD8cI9U3Y9uonWG3b8eoXRj6rdp0NIiD0k5w
         lG3OU3Y1BUJ4yvWpYXJlyEW7zrjRAWIVSVqE04jCVYfFYIjO/Q8ISmdByuP/zjtt3cLy
         8v9ROe8OgW1fezFq3smty4bBI9ys3xOk+BzGKHwXvnSkordtXzb7ZBONEDAi2hQekAa8
         fi/Q==
X-Forwarded-Encrypted: i=1; AKwUvByf77Pg0TfjI+soTezqdy9sS/YHRSfcAQwuI760GU/fBhcBhNWkYP03z43giCbVwj9uVIOvWM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/rERX88KtdbHGkdO63iTDXoXkheiRKKJXlu6dcyfFGrvnlPdW
	qkFighMTV36bz0MAH1pBQQBLIpgVJxy97cjK3mXdwDk8DPUEnHju4P26
X-Gm-Gg: AYBFou2bfG0syN3cLE0LaCk0swaLtahkVDyOE4TYlnPa+q9i7XII4I1WV7Wz5nXfstz
	BIYDXCxhqSW4aN4eEoxXc3RKeeeNAzUlFyBU6noJbfZblkATTwOgN1dzI4GmxcNQ8045zq4LS7R
	jKD95UWE0ihJfzZ7GvtMpEZFXBCpveiglJcdishfzoqL8iQQ6YTfvJERIi1bfJ7+qaUu8miJev0
	BW40PB+zWStvabzdL12UyOhPGTzhPiEbpu7gir1lQzYTC60RfMDixRWbjJRAVai+c/TIQVHoxtN
	7c5mSIUsfOX8aeiDskeSw13DGSLM4UJ/zvnZR1T5TTTBorU3Am/ZhmoqqAfCTcGMs0RZ3FiI4uz
	cUSvipeOrNXDkUo+vioKa0pK8rf97FUJSOdJ7L5Cnfux6SD/JG5JoOge/OucXUsBnE8jNTgk0Pk
	G1VyX8oiM3gpi6NPzlbP/flvKb74+2urDfnG+Pa6/xqNWv3Pe/bIcbdP7X1aBngH1WL2NF1aen8
	ZZVkqKYLCsV1GktqV/C7yY=
X-Received: by 2002:a17:90b:582d:b0:3ac:9e5e:d1a5 with SMTP id 98e67ed59e1d1-3acef14590amr3620466a91.6.1792235484304;
        Sat, 17 Oct 2026 04:11:24 -0700 (PDT)
Received: from MELOKC-LAPTOP ([61.171.228.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947cf9a5sm12813154a91.15.2026.10.17.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:11:22 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: fix EP0 context leak on virt device allocation failure
Date: Sat, 17 Oct 2026 19:11:13 +0800
Message-ID: <20261017111114.1135-1-anferneemelokc5@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XHCI_EP_LIMIT_QUIRK is set, xhci_alloc_dev() reserves an endpoint
context for the default control endpoint before allocating the virt
device:

	ret = xhci_reserve_host_control_ep_resources(xhci);
	...
	if (!xhci_alloc_virt_device(xhci, slot_id, udev, GFP_NOIO))
		goto disable_slot;

The reservation is normally released by xhci_handle_cmd_disable_slot(),
which calls xhci_free_device_endpoint_resources() for the virt device
found at xhci->devs[slot_id].  xhci_alloc_virt_device() does not install
the virt device when it fails, so the Disable Slot completion handler
finds an empty slot, returns early, and the reserved context is never
released.

Each failure leaks one endpoint context.  Once num_active_eps reaches
limit_active_eps, every new device is rejected with "Not enough host
resources" and cannot be enumerated.

Fix this by releasing the reservation when xhci_alloc_virt_device()
fails.

Fixes: 2cf95c18d506 ("Intel xhci: Limit number of active endpoints to 64.")
Cc: stable@vger.kernel.org
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/usb/host/xhci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7f7babe9d681..8b9a6f88cca5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4278,6 +4278,15 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	 */
 	if (!xhci_alloc_virt_device(xhci, slot_id, udev, GFP_NOIO)) {
 		xhci_warn(xhci, "Could not allocate xHCI USB device data structures\n");
+		/*
+		 * The virt device was not installed, so the Disable Slot
+		 * completion handler cannot drop the EP0 context reservation.
+		 */
+		if (xhci->quirks & XHCI_EP_LIMIT_QUIRK) {
+			spin_lock_irqsave(&xhci->lock, flags);
+			xhci->num_active_eps--;
+			spin_unlock_irqrestore(&xhci->lock, flags);
+		}
 		goto disable_slot;
 	}
 	vdev = xhci->devs[slot_id];
-- 
2.54.0.windows.1

