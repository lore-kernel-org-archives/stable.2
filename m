Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE33DA7FF;
	Thu, 20 Aug 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219820; cv=none; b=KH4uxx+Q6XuZxQe8pLhcR+yeVcsglwE79NJ1YrUur6JDdyMrDV9PRFT8urKVK9eyKsbK4YpBTV7wfNaillz0k1SwrvjWXzi0DaVQCMfWO8bgwtoYIAKuPN3CLQ5015ic/8+u2hT8vlvHCNJFpLyqYcC6OFFvJrqwlyOEvPgcVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219820; c=relaxed/simple;
	bh=brLAUlIgqXAA9xUmFpKE5vSctqUbZtB1Ig6g5p2n/xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNduJl1WFWDEPYypeaEVwIMwDzqHZNUjxMlW/YV2ai1LvGQIaR0HPXcBGaImZYInPfIpFl0fGL6irwWPC9BzdlvVtCMdqDtcUpUXT93eogadssLD8tw/4Je4uUWDThov3IblCBJwk9lv6xFb7iM4kvnmJ4Pg4NZCL3kuXj4ta78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=b2vIFa3s; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="b2vIFa3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1787219809; x=1787479009;
	bh=DVX85waZSypvAQXmlDJIDX8nSLj5KISJWV4+AF3As0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b2vIFa3sVBagVD/GMQkaifBjITJZqrBMyXHyQEM+wljAlBwe6YEYcm9f7RziuUY9n
	 Qj2W/rGVViBcqM+mZ0Gzm/c+mPOeFFrFKyWH3qkdyWvbbZeOVjrxN4ZRDhYHYJP88o
	 XIM1mflxUvz7K1C8uTs3dRNh3eDQFYuOJ0ggThrtLuLej/OgNAUP3TCt83ORtaz3Gg
	 0Dwm093ZlrNbK594jNxSCRSSo1r2xA3mJ6NrJI9mP36jD2hC9QN4ze9lA9a5dIvYlp
	 DBAiINnJmqSthlj4UiouRyagFMv/qQgsCz0ZczJtvb/afoBASxLBMHhme8vwIAoeI2
	 WlMVJILOFlHEA==
X-Pm-Submission-Id: 4hQf3c3gZLz2Sccw
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
Subject: [PATCH 1/3] media: uvcvideo: Let uvc_parse_frame() report a skipped frame
Date: Thu, 20 Aug 2026 12:56:24 +0300
Message-Id: <20260820095626.111196-2-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820095626.111196-1-natalie.klaus@runtimeverification.com>
References: <20260820095626.111196-1-natalie.klaus@runtimeverification.com>
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
Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
---
The Cc: stable line is present without a Fixes: tag because this patch is
a prerequisite for 2/3 rather than a fix in its own right. Stable needs
both or neither: backported alone, 2/3's -EINVAL would revert to meaning
"discard the whole streaming interface".

 drivers/media/usb/uvc/uvc_driver.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e289cc71ba98..0cc0e351d139 100644
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
+			if (!ret)
+				format->nframes++;
+			if (ret == -ENODATA)
 				return ret;
-			format->nframes++;
-			buflen -= ret;
-			buffer += ret;
+			buflen -= buffer[0];
+			buffer += buffer[0];
 		}
 	}
 
-- 
2.34.1

