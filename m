Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099498;
	b=5dbKvKbQOrh38N1OrXwiypQ0IhvmFpob1SJgf40T5v62rU30uNXhPAaQz0ZcIwyV6mef
	 Ns6w9r4AE1TZmr562m0kTIMVazCXVWc1wc1Wu8j1lWBfWkrLEEnISL0BswwXUNMmOWurG
	 v9dQNg4MLVk4Oc1B+tNn6uYCqOjYVMvM05Y3UFrDuix+OlqBJoo5d53GxF+wqcg/wVSZ4
	 Fx4WoFlq/kXDMFgEO0VUBy00bZIzTZC5dTEGQAU1ibryy2/ks40kq8+4Dy3wALGL0L8Hn
	 DzDii3UjTao9BFKJtNKnsch1ciGDxiLmjFTTgrPNcH/6cSHZ8D6UzU0RBgNqpfTNRhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099498;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rKThV24HW1veN5Zp/zLmPe5+vW3IsKHoQQgpGDbJtHM=;
	b=CuZ8y3TWwXwpHQ3v+k4IW2IFAXO/1B/YRMLxdSr9KBIozxu0riajWhZFop7cqajACZRA
	 Te8HrH8K4AD7vvKPDaxubKkAqY0FMjRsp2c9jRMPs6+EaH0zKJGzw5fmRBsulvtRwV6GA
	 woxuGQ5pEorAa2k3MB9YfXftT1HMfy9Fl49XlWIoVbW1/uwl7F6w6Uh6quXUXOh1akbhx
	 n+v5GjWFNplJMXtaXPZl2xJp+sVdPBctD8s4CuSmav+DM0TLNfZLzPUUgbpuDMcPaumz5
	 ZtngF/vI4giHLa7N/9/NymAZLiI9CsLnSvdaewjAFe8p8U0clcmApCN7X7e6mqflpGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=runtimeverification.com;
	spf=pass smtp.mailfrom=runtimeverification.com;
	dkim=pass header.d=runtimeverification.com header.i=@runtimeverification.com header.a=rsa-sha256 header.s=protonmail header.b=n42NRKLc;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699E606A31E;
	Tue, 27 Oct 2026 11:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5699E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runtimeverification.com header.i=@runtimeverification.com header.a=rsa-sha256 header.s=protonmail header.b=n42NRKLc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1793099495; x=1793358695;
	bh=rKThV24HW1veN5Zp/zLmPe5+vW3IsKHoQQgpGDbJtHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n42NRKLcr/ufkD2QUrT44cgOjkBkrJGdunD+JfiksvQ4hC4NCaGx4D2cwYqzsJJ7E
	 glXoDHDdICYvSSHJzruqD57ywS+YvkccomYPAFvMisyuIkAb+cXiwjXhBJN+DtJiXe
	 nvpIBu23BKEnr3NVlUdYmrWpn8H8kH57mMRgaUdc+o11fWKazrvz6ke6DXdBaOew0c
	 CSxJJEOjN/kazVUt+xSIky3JzqSU0q6By56V44dNIEwh5XQfADYTKlVKgIidksbe5s
	 6dHTv2tMjkFI33uFE362zDDsyoQj9IYV82tQB6OIoFR/0AUOqMUCvF2vaLgkNb76pG
	 1wRw/Ql0SHJUQ==
X-Pm-Submission-Id: 4jDSVW14dlz2ScjF
From: Natasha Klaus <natalie.klaus@runtimeverification.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	mchehab@kernel.org
Cc: ribalda@chromium.org,
	noambs2999@gmail.com,
	david.laight.linux@gmail.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Natasha Klaus <natalie.klaus@runtimeverification.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] media: uvcvideo: Let uvc_parse_frame() report a skipped frame
Date: Tue, 27 Oct 2026 14:11:14 +0300
Message-Id: <20261027111116.119182-2-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027111116.119182-1-natalie.klaus@runtimeverification.com>
References: <20261027111116.119182-1-natalie.klaus@runtimeverification.com>
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

uvc_parse_frame() returns the descriptor length on success and a
negative error code on failure, and uvc_parse_format() treats every
negative value as fatal for the whole streaming interface. There is no
way for the parser to say "this frame descriptor is unusable, but the
rest of the format is fine".

Change the return convention so it can. Return 0 on success and let the
caller advance by buffer[0], which is the value the function returned
anyway. Report a truncated descriptor with -ENODATA, which stays fatal,
and leave every other negative value to mean "skip this frame descriptor
and carry on with the next one".

-ENODATA is currently the only error the function can return, so the
skip path is unreachable until later patches add checks that use it. The
one behavioural change is the truncated-descriptor diagnostic, which
moves from uvc_dbg() to dev_warn() so a malformed descriptor is reported
without the DESCR debug flag. That leaves the local alts variable
unused, and the kernel builds -Wunused-variable as an error, so it goes
too.

Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/linux-media/CANiDSCue8yyiGubzbAybRqSUTTFuB=-Y2TZy6yvOx32SpAASWg@mail.gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Tested-by: Noam Ben Shimon <noambs2999@gmail.com>
Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
---
Changes in v4: rebased onto d135ab453a74.

stable: no Fixes: on purpose, 2/3 needs this patch. Both or
neither.

 drivers/media/usb/uvc/uvc_driver.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index cbc14569716b..14ab4cc28c40 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -230,7 +230,6 @@ static int uvc_parse_frame(struct uvc_device *dev,
 			   u32 **intervals, u8 ftype, int width_multiplier,
 			   const unsigned char *buffer, int buflen)
 {
-	struct usb_host_interface *alts = streaming->intf->cur_altsetting;
 	unsigned int maxIntervalIndex;
 	unsigned int interval;
 	unsigned int i, n;
@@ -243,10 +242,10 @@ static int uvc_parse_frame(struct uvc_device *dev,
 	n = n ? n : 3;
 
 	if (buflen < 26 + 4 * n) {
-		uvc_dbg(dev, DESCR,
-			"device %d videostreaming interface %d FRAME error\n",
-			dev->udev->devnum, alts->desc.bInterfaceNumber);
-		return -EINVAL;
+		dev_warn(&streaming->intf->dev,
+			 "UVC non compliance: FRAME descriptor is %d bytes, expected at least %u.\n",
+			 buflen, 26 + 4 * n);
+		return -ENODATA;
 	}
 
 	frame->bFrameIndex = buffer[3];
@@ -329,7 +328,7 @@ static int uvc_parse_frame(struct uvc_device *dev,
 
 	*intervals += n;
 
-	return buffer[0];
+	return 0;
 }
 
 static int uvc_parse_format(struct uvc_device *dev,
@@ -492,11 +491,12 @@ static int uvc_parse_format(struct uvc_device *dev,
 			ret = uvc_parse_frame(dev, streaming, format, frame,
 					      intervals, ftype, width_multiplier,
 					      buffer, buflen);
-			if (ret < 0)
+			if (ret == -ENODATA)
 				return ret;
-			format->nframes++;
-			buflen -= ret;
-			buffer += ret;
+			if (!ret)
+				format->nframes++;
+			buflen -= buffer[0];
+			buffer += buffer[0];
 		}
 	}
 
-- 
2.34.1

