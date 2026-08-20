Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCA422541;
	Thu, 20 Aug 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224582; cv=none; b=lHMiYzeHoelKJGBski3CD8kDwBd21TUGPBtPpLxvBIdWAk2VZ34Hyv0UC1lRp3j4qjxxED5//6nkM0Uma0YsGNmCIZ/gtkv2D8geWvMEFSUUo5CaGJpQulYRldd+Ux5yUD8olP7GYYhUS2owhR17LQueQU/DmixlbsowK6MHjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224582; c=relaxed/simple;
	bh=i1YRnDEs7RKAczXpM4GNiorJvmoYtNBtPMjrYFo/qNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLiBJ7byj5KGzms3mB/v4WWZjbgCpNcdUt4fewCS9rFH5MzpyEnAt0Lk08MjaA3FBGeS7OrRpEhQ2YSm6KS9EUxyRpv3S/Q8RqCzzjG4U+KSe5LhXzv3ZY2jGvx2gsZDk//HcDpC+ans5xBgohlVGeHjJ0Tl4ugl8gRrWSqnmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=JfRx1o8o; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="JfRx1o8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1787224578; x=1787483778;
	bh=LR78WkMGrhZNAj6P4HYb1ppkVtN8Zbi+rJKZgCG+z3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JfRx1o8oW1UYmiggTowPyX8z3RYJ3TccEejiWR3T0hilPdnf+NgOiJQC6hlhDbTP/
	 tdVuc48IvWFpH4WApRe2YqeIUZBrNN5k8qiercbyayl+FSePBkObWnu5D13XOJjJ9D
	 fwrQhAJ1MMGC8SEq0RSVcT+fQ6CwrV9fYn3RkFs4ER9JGkw+gkKkGeYr9zJAEysi2C
	 bKLpE7XuU43ghWevT98Z7H0SyMjbGifaA/z9v2mSVXuX+/WsxI7VAFKxKTh4mHRj7u
	 oQfmcF+qfUP76GCffc4ndTJ5fvqrfXvblFCL4TFv6gnlaLYIjJGbCIXY0daIBqw2j9
	 ZCY0nvgxbY6Jw==
X-Pm-Submission-Id: 4hQgqH5gPvz2SchM
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
Subject: [PATCH v3 1/3] media: uvcvideo: Let uvc_parse_frame() report a skipped frame
Date: Thu, 20 Aug 2026 14:15:54 +0300
Message-Id: <20260820111556.232652-2-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820111556.232652-1-natalie.klaus@runtimeverification.com>
References: <20260820111556.232652-1-natalie.klaus@runtimeverification.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
The Cc: stable line is present without a Fixes: tag because this patch is
a prerequisite for 2/3 rather than a fix in its own right. Stable needs
both or neither: backported alone, 2/3's -EINVAL would revert to meaning
"discard the whole streaming interface".

The caller checks -ENODATA before counting the frame, per Ricardo's review.
Behaviour is unchanged either way, since -ENODATA is non-zero, but the fatal
case reads better first.

 drivers/media/usb/uvc/uvc_driver.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e289cc71ba98..b94fe5366e55 100644
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

