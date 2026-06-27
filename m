Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B76191;
	Sat, 27 Jun 2026 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782534597; cv=none; b=WilsUSEAiHeBvTqQNeCcr7LsybnLuTeaPGdiHeRJk3H6o2uWLCQAu42Riia1OEu3DmKZHUVn0C2Ma2Bl/s4GjfgTvUxNGipDVYYx04TqPhcnJmaJRSoGYUQepvsMeNaEIvifYb/Lt/v7y0vuhFKhUKyOYUZ42VAa92/GdmKJJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782534597; c=relaxed/simple;
	bh=dmJnvUxzFP/MTr+jckVqDWjuR4DJ/NCXGQ6/R6dO+Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euJTYrXdp8eU4SKrFz+drZfPa7ah8gD2JcRsYT2qEq6svK3/59WKadowx3wD1J8Vz0nYTtcj3vUzZqNDw6iD4vkIaeWD5aOYC8/wbH9Wf/WAWXFjxYztlRv2LZg0daJDoN0VFVEOnEuTSad8az2hs6SX8uOJ7gXYe6yCOpl1UDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA329O_UT9qc8CCAw--.43398S2;
	Sat, 27 Jun 2026 12:29:53 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: ramiserifpersia@gmail.com,
	vulab@iscas.ac.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fix: sound/usb/usx2y: capture_urb_complete: redundant usb_anchor_urb corrupts anchor list on each resubmission
Date: Sat, 27 Jun 2026 12:29:49 +0800
Message-Id: <20260627042949.61767-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA329O_UT9qc8CCAw--.43398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1xAryUAr45tw18ZrWUurg_yoW8Xry8pF
	n7X3y5WryDXrsayF1DXrn7Xa45Cws5KF9rCayIga15KryxJw1xua4Yy3WYgrZYqrsxCF9F
	yw1jq3y5XwsrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73P
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgILA2o-DDqMPwAAsc

In capture_urb_complete(), usb_anchor_urb() is called on every
completion callback, but the URB is already anchored from the
initial submission in tascam_trigger_start(). Each redundant call
corrupts the anchor's doubly-linked list and inflates the URB
refcount. When usb_kill_anchored_urbs() traverses the list during
stream stop / suspend / disconnect, the corrupted list leads to
use-after-free.

Remove the redundant usb_anchor_urb() from the resubmit path.

Cc: stable@vger.kernel.org
Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/usb/usx2y/us144mkii_capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mkii_capture.c
index af120bf62173..fa01da98151a 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -302,7 +302,6 @@ void capture_urb_complete(struct urb *urb)
 	}
 
 	usb_get_urb(urb);
-	usb_anchor_urb(urb, &tascam->capture_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_err_ratelimited(tascam->card->dev,
@@ -312,6 +311,7 @@ void capture_urb_complete(struct urb *urb)
 		usb_put_urb(urb);
 		atomic_dec(
 			&tascam->active_urbs); /* Decrement on failed resubmission */
+		return;
 	}
 out:
 	usb_put_urb(urb);
-- 
2.39.5 (Apple Git-154)

