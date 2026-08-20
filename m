Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4F415F1E;
	Thu, 20 Aug 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222883; cv=none; b=oo4MY6e8fljN4ekdJYgr3kRPw52hBOE4VD8LsTwm3sjy9P7ASIKOqZvWSBF5ZR3utg4gG3nF55/vGhCJstwOxhBYnIAk+tivG4Jgc3xbTm32XE2K5Cj43SXXRwHZdBEF0CKpYEMYkI04LiQdfvyPHavgbudcljhxrIUjsAu8TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222883; c=relaxed/simple;
	bh=hNT7pS9AEoulxAZUxymzHoju9b+YzeJDWDclzjJAUVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyxIBYRz8w4tbOaSnQwgLE9X1X2vqbzFvztYR+SejaBbphCR6yTXDMjv4mdA0nHdPQ32J2sTJ0q/b1e7dz2IdNOBvfi/PyvUXOtFlgPF8yaAgJEt8dFt+bwNYaNnUUDAojvV5MhBm0gMf0dP7bBpuDwztlrkfZO/I+Y8ywybAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=eH9+X3m7; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="eH9+X3m7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1787222873; x=1787482073;
	bh=aOumxHCEc1nr9O4cF/Z08xwo3x1H1Mc9T+I+iEa73gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eH9+X3m7dwbwuMSMDGnor3ENpkPcSfGEFsLDnPxVvcewoxWUFygh7OmlvDX7plu5y
	 yPrQmuDfg5A2DWKnnKRxvowlJ9Pl13P1JS40WHnnNfnU4XvSYGq45BxGDh+2d2e1BK
	 Utew1nsl9RG60MjpAunBZqrwRMDHOI6ra41bJ/yDJNmfLhkQV8LQhOQ+qDm6I/mIzP
	 EMjZM0vRrZR2Zkx49qum+/IU7ZLWnPb3HyEVNrwhMAtTbUCxXIi3WOBf6lJXulcfwU
	 IFOHlEQx9Q4r0TC72Sg7Gn/W2dNupfKpusoyITufxn/3NMIO4SbllvtRol4o1ryhjD
	 4Azf3IHR0l/3w==
X-Pm-Submission-Id: 4hQgBX6mJvz1DDLh
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
Subject: [PATCH v2 1/3] media: uvcvideo: Let uvc_parse_frame() report a skipped frame
Date: Thu, 20 Aug 2026 13:47:22 +0300
Message-Id: <20260820104724.191119-2-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820104724.191119-1-natalie.klaus@runtimeverification.com>
References: <20260820104724.191119-1-natalie.klaus@runtimeverification.com>
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

