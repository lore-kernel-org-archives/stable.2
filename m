Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16521E9B3D;
	Sat, 27 Jun 2026 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782531476; cv=none; b=dexZZkqgChuDKqlHFW7yfgp6X3+b96KgJRsqHeljnajQLgDSoIxSY0SoHLaXbFnwj3u4GLnbJIjunAWkSMjetSzhe1Gt7ituwivwud+DsvZEcvswELrnsjiRCv4bvj2JMwoYhjrauVNysX7agXu4/Vs1J2pBL09naa3RQare6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782531476; c=relaxed/simple;
	bh=S1YAOTyzB3b5IEoTAX29GhRA4KiIBjkEvAt10XEXbmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e375myAbkYpkApx02NEO6PBnctkEuuhbAiZGZ0Hh6DSLe2hsus4ydIZIkqY8yKq90lyp4rMmpgqxPeeyApyiblIumK1h8yjamj502ANgCw8HusnDykgeHGL8Pnq5MGfARZ97L4B5JrWhzS4vYD1KoxJVFhXGKGAsl7Aq57KQpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowADHa9SORT9q0DiBAw--.10803S2;
	Sat, 27 Jun 2026 11:37:51 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/usb/serial: garmin_write_bulk: urb freed prematurely on success path
Date: Sat, 27 Jun 2026 11:37:48 +0800
Message-Id: <20260627033748.58960-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHa9SORT9q0DiBAw--.10803S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW5Jr4kKrWkZF1kGr1Utrb_yoW8JF47pa
	90g3y7Crn8JaySqw4DJr4qqa45Cws7Aa9xKFyIk392vr15JwnF9FW0qa1Ygr10qrykJrs2
	qr4q9FWUuF10k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe0PSUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggLA2o-DDp2NgAAsl

In garmin_write_bulk(), usb_free_urb(urb) is called unconditionally after
URB submission, even on the success path. When the URB completes later,
the completion callback may perform additional operations on the
already-freed URB structure, causing use-after-free or double free.

Move usb_free_urb(urb) to the error path only, allowing the completion
callback to properly manage the URB lifecycle on success.

Cc: stable@vger.kernel.org
Fixes: c4ac4496e835 ("USB: serial: garmin_gps: fix memory leak on failed URB submit")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/serial/garmin_gps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 7205483a0115..775959e0188d 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1029,12 +1029,10 @@ static int garmin_write_bulk(struct usb_serial_port *port,
 		count = status;
 		usb_unanchor_urb(urb);
 		kfree(buffer);
+		usb_free_urb(urb);
+		return count;
 	}
 
-	/* we are done with this urb, so let the host driver
-	 * really free it when it is finished with it */
-	usb_free_urb(urb);
-
 	return count;
 }
 
-- 
2.39.5 (Apple Git-154)

