Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E997521203;
	Wed, 16 Sep 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577681; cv=none; b=fDuVPOdYjwNhf6QDV7bkkRwnxRCxMpVxe2aJ8OR+UPPdKMzGRWo3oPFVNDwhzcJwZO3qWO+bj3DMtIMy9WgjoM4E4xsB1zBtVlQNGmcwsFg52ZZm1E8LS91nngdS2pzRyQz8sugKY7B3/FwzksTf5nU0PdpaD1DqTZZTLRx9S7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577681; c=relaxed/simple;
	bh=6e23mqm25si6H1wh1ucL0DzKHh3dU3bcDqWPZtiZtbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYHv0+1Tt1fXjIKuASmuBr1C8naHlhcKjILtJE4UxjhDT86buB3XKfqFMaszBJAi+S05W8hh03aLvACW4Of3l+fFWD0rFJbC3LI+L7EJ1ZN6/fg067zcdIGv4xWiM0b2Xbi96sVAAk9KSibLOF/Rrt/wxM1SdbYOnEO0IkVb/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkC7yapqoQhuCA--.22465S2;
	Thu, 17 Sep 2026 00:54:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	oliver@neukum.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: sierra: Fix urb leak in sierra_submit_delayed_urbs()
Date: Wed, 16 Sep 2026 16:53:52 +0000
Message-Id: <20260916165352.2085480-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkC7yapqoQhuCA--.22465S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45Cw4fWry5Zw13uFWruFg_yoW8GF13pr
	WYgr4akr1DJF15Aw47Cw15uFyFvanFyr9Ik3y0vrW3ZF15Ja4SgFy8XwsIgr1UA397Ja4a
	qw42grW5WryqkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2qqpVhUQgAAsi

sierra_submit_delayed_urbs() takes a reference to each delayed urb
with usb_get_from_anchor() before submitting it. The submit failure
path releases the reference with usb_free_urb(), but on the success
path the reference is never dropped: the urb is only anchored in the
active list and the USB core unanchors it on completion, leaving the
reference returned by usb_get_from_anchor() dangling so the urb
object is never freed.

Drop the reference with usb_put_urb() after a successful submission,
matching the reference handling in sierra_write() and the sierra_close()
drain loop. Skip the rest of the loop body with continue on the error
path, which already frees the urb.

Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/serial/sierra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 6e443aacae07..c11259a8e66c 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -977,7 +977,9 @@ static int sierra_submit_delayed_urbs(struct usb_serial_port *port)
 			spin_lock(&portdata->lock);
 			portdata->outstanding_urbs--;
 			spin_unlock(&portdata->lock);
+			continue;
 		}
+		usb_put_urb(urb);
 	}
 
 	if (ec)
-- 
2.34.1

