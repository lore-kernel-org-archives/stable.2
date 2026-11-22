Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380705;
	b=DXV3CFWEzhXFTiyeI/wTESw7oEmL4JMRxmwqQb91A2iF9z+ksfeXBEpsCq6C+Si5hC+Y
	 ChGF40w7OvldHYwDu+i+12wj3pyB7Kojtm4S+VgN/cGRaZuTmDmDUo2nbyTyB76sXfDGw
	 0o1xZxjTarkjs2/rT0ExQLuCtwBKBbPFkCepMTPwcwCGVHbUiAbM/I0rC5hrBdS5g6QQ3
	 X0Qsr741JpPJAYuX8ajzF4icVIwZ45Bmh7LGFkgQ9LX+1oTRALDQ+jV/5EqQ/bml/Frvz
	 lFU8mvaiND832WJdEF1P5ucWzY7B8GQ2XJL8ZOI104BEqE0nfTPGdL7k/wYCaivTBsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GCgci+wnkegUNNmVPyTdmFkRnQkKXTGlvVX8R+FAXAw=;
	b=CudA9PHsQHnslGVQaXjpqHL9vISau0cfZy1fQWBD3S2R2FjFc4kvdF+vWldP3+oNFUjF
	 CsxhFzaGiM2TLnO1GDtQ+Nf4v3TO54e7KpltjExp53DaqsLW+lHMGGrPsY8NA2Vrr67rE
	 91PbcyaDt8ivPibNXtuCJL25BOso3C2Svxpgze2PqVl0w3BrTCb1AnxHViNOTe+Z68hV6
	 rHd5KVtbEnxLS56LW2rq0Uyh9H4ncQkm1XhsPpiw/5yAb5OpJkdTlM5O7gPhByXvEH2Nk
	 3gLvv6c2oNF7wiLhFHw0SYSs9LbR32Mk2k9kb1yPeCD49JfYWNrFCi7KmtKwaqu/bhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HnUix/va";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE3606A690
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BE3606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnUix/va
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so24121045e9.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795380704; x=1795985504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCgci+wnkegUNNmVPyTdmFkRnQkKXTGlvVX8R+FAXAw=;
        b=HnUix/vahPIIPPg94n21bSwADW5XJ2R4f/ruRTqMmI6tIIzR4e6LqXv4evpos0RRK5
         jXSmRZPACpd13OmIbBBkA67aYZALiuR1jyZ4kUvB0LS6LE8iRytOClCFlxIsaTg3920e
         Rw9GTqEof3NzSz/Z4Z2idg99g9IjDNxpYjKPObuZiQRCrInfmYQrX3/kNeNCUClCO9sD
         fvxY0ryVj1AFagtDNCWJhhYPVxbjXZskrqC0m/B5UZDNknzg6jvLDsZQ8+ovJxZT+g0H
         ZzT4Xlq055C2HJ7sFdqBfFzUx3GR8ZoIbt86FZXE+BI94qdBhF9ShibmX9JSsRIYbh39
         g0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380704; x=1795985504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCgci+wnkegUNNmVPyTdmFkRnQkKXTGlvVX8R+FAXAw=;
        b=yhW4p03ry/BNWF6Xn4yy/6sA6BJH/NcDd3TOLoEuRX7otBkXScBcF72M+lT+4+7nNz
         Vfrm0Xs2D/ecmzmjmegj19oHNyZixkc3DJBwmKtRh+6PDLu/RFSOfrUmyxELrBLc/bvK
         +3N/FvbMJTv1QvyPx9EHUjCVV9uIDgQ83NJncwBH4sphZxVqHnIi26C+m8FlBhPJ4HCh
         L8s2SQnytu4w6FruvevVSoLFSYdT9iLeWYYR37LHCJ9pflHNjtuLAlMaQCAoRI22+9Yb
         844Umi3Li33PdJNKwCqPGq52Ek6q8++zI2f9sn76jFCuZii8O3x/hIPzEaXczB6dANG0
         ZdAw==
X-Forwarded-Encrypted: i=1; AL+hErGRE7/kg67wBd4c5nEDlDzLYIusG3yIQ1dPsP4QfgB9uUd/EGYhEs2TTul56ejbLUXM48WjJGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R6LGwNtprPN2+Sps6gXkyHG2nWHYdWwKVNOCGqZ6U7pxMq7L+
	KcDRgPCPW1Ns/V8nbJ1jsly8RPfpFR//ssEamiq6/hlsesy+oEaJyKas
X-Gm-Gg: AZFdTZem47pmWP6f9SiEbLqBvLtEQfapTHYPttxvzyRBN6IX2ome0sqUDvvW/J5ivnC
	bWg9dEXT++SzBbSvK1j4+u57D5zRYovAQwsPW8/OKcaIjXybRsTUC/WXviG5jhJqnh0e499rlnc
	8l1iFlJNymxBdTM6fPK+JvC8l+MGoPmfROEym90KXrUFK/0Mmmgyq5dYKUAReQ9Rp5OmXdakmc6
	aO1WsInw/daXbJEt7AoWq2vNBGVysqRjct6sAf+J/UhdhfTpGNPgwoLuoUb/PDGaO8pPjRFYa5K
	imy4ylxLVEcb+QEF1+IhNVphMkwXRs2R7y9FWfNtV9gk0K3sOjyv1cH9/kvj3vNyxuNYfYxnG3n
	xthuDbMb2QI9to+HZh1snAHtaBMVC65jdOLlbvct/3eTPW5fxSYH/B7GiM7rMoHH0vsZXCC7KLD
	9CtvGFStNqEZN3lr+PeuC4o3OGBzkmMwIhoV3W19ruX8AI4cfl/fVJD8+ZYrApI/GrDMKc4LhmG
	9nlDhv6oM7Fy17YPOwvhrMNziGGau/Q8XYYCuse8Ue/mG16wDoKf0MwsuUWtsiz9kbsoqGjC3hI
	eQugNJEUTVKhhSDLu4B3wZUi5joHClduhM3CeHpSbsctFDy0wE5ih5Zb
X-Received: by 2002:a05:600c:154c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4bb8881c378mr209100495e9.8.1795380703662;
        Sun, 22 Nov 2026 12:51:43 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm338371075e9.7.2026.11.22.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:43 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH 1/2] media: em28xx: defer media_device cleanup and free to em28xx_free_device()
Date: Mon, 23 Nov 2026 01:50:27 +0500
Message-ID: <20261122205028.41222-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When a USB em28xx device is disconnected while a V4L2 device node
(e.g. /dev/video0) is still open, em28xx_usb_disconnect() calls
em28xx_release_resources() -> em28xx_unregister_media_device(), which
calls media_device_cleanup() and kfree(dev->media_dev) immediately.

However, struct em28xx_v4l2 remains alive until the last open file
handle is closed, and v4l2->v4l2_dev.mdev still points to the freed
media_device.  When userspace subsequently closes /dev/video0,
v4l2_release() calls v4l2_device_supports_requests(vdev->v4l2_dev),
dereferencing vdev->v4l2_dev->mdev->ops and triggering a KASAN
slab-use-after-free:

  BUG: KASAN: slab-use-after-free in v4l2_release+0x325/0x380
  Read of size 8 at addr ffff88800787a260 by task test_em28xx_uaf/53
  ...
  Freed by task 30:
   kfree+0x162/0x410
   em28xx_unregister_media_device+0xa4/0xe0
   em28xx_release_resources+0x70/0x170
   em28xx_usb_disconnect.cold+0x107/0x2a3

Split em28xx_unregister_media_device() so it only calls
media_device_unregister(dev->media_dev) on disconnect, and move
media_device_cleanup() and kfree(dev->media_dev) into a new
em28xx_cleanup_media_device() helper called from em28xx_free_device()
(once the last dev->ref reference, including em28xx_free_v4l2(), has
been dropped) and from em28xx_init_dev()'s error path.

Tested locally in QEMU (x86_64, KASAN+UBSAN) using dummy_hcd and
raw-gadget emulating an EM2820 device across open->disconnect->close,
repeated disconnect, dual-fd open->disconnect->close, and normal
open->close->disconnect scenarios (4/4 passed, 0 KASAN reports).

Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 1d4f30cba..d8f2e40b7 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3773,8 +3773,15 @@ static int em28xx_media_device_init(struct em28xx *dev,
 static void em28xx_unregister_media_device(struct em28xx *dev)
 {
 #ifdef CONFIG_MEDIA_CONTROLLER
-	if (dev->media_dev) {
+	if (dev->media_dev)
 		media_device_unregister(dev->media_dev);
+#endif
+}
+
+static void em28xx_cleanup_media_device(struct em28xx *dev)
+{
+#ifdef CONFIG_MEDIA_CONTROLLER
+	if (dev->media_dev) {
 		media_device_cleanup(dev->media_dev);
 		kfree(dev->media_dev);
 		dev->media_dev = NULL;
@@ -3826,6 +3833,8 @@ void em28xx_free_device(struct kref *ref)
 	if (!dev->disconnected)
 		em28xx_release_resources(dev);
 
+	em28xx_cleanup_media_device(dev);
+
 	if (dev->ts == PRIMARY_TS)
 		kfree(dev->alt_max_pkt_size_isoc);
 
@@ -3997,6 +4006,7 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
 	em28xx_i2c_unregister(dev, 0);
 err_deinit_media:
 	em28xx_unregister_media_device(dev);
+	em28xx_cleanup_media_device(dev);
 	return retval;
 }
 
-- 
2.53.0

