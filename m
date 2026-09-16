Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D64A7C92;
	Wed, 16 Sep 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577975; cv=none; b=gm/hlpriXPpSn85gibWPV7Cq+idCh9sfjgSjXmd46rApGMDakh89HuRyivbKi5zoaJyTlDuPHVFhMhtDvmvDhmyO4aqFgc/zt5PQLORp82uUrBI4/MDRE7kDk7rDynl8lN3iOr+P9a0K2iDQyR+3AoJnVRsrPb7EIlR8oZmpr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577975; c=relaxed/simple;
	bh=D77SfbkO3bRqpC5zx9bLQd0YEqgn7ITaYDTvJiVXdRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5kio5ZO3zA8TeS6n7Ta8Kmon/0NNsE0F9XNg5J3AFqVVpVTE9vUaxceKb9JeOP4lQhb9+KptEchAcpWo0+B8lPainUTZNguE1MOBChr1yi0cttApkKZS9fSlPRAV9lmnjjdo4wsn3B3deO1zX/Mfe9t5pwwnVC0JGC++PPEbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACX_znhyqpqNB1uCA--.22848S2;
	Thu, 17 Sep 2026 00:59:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mjg@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: usb_wwan: Fix urb leak in usb_wwan_submit_delayed_urbs()
Date: Wed, 16 Sep 2026 16:58:46 +0000
Message-Id: <20260916165846.2085791-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_znhyqpqNB1uCA--.22848S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45tFyDAF45CFWUWr47XFb_yoW8XF4Up3
	yqgrW8tryDJF4ftw47Aw43Za4rW3ZFkr9FkryIv3yxXrnxXa4fGa4SvwsYgrWUZ395t3y7
	tr1jgan5WFWDK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UTnQUUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUMA2qqok9gFgAAsX

usb_wwan_submit_delayed_urbs() takes a reference to each delayed urb
with usb_get_from_anchor() before submitting it. The reference is
never dropped, neither when the submission succeeds nor when it fails,
so the submit-delayed urbs keep one reference forever and the urb
objects are not freed when usb_wwan_port_remove() later drops the
port's own reference. The urbs are not anchored in this path, so the
USB core cannot drop a reference on completion either.

Drop the reference with usb_put_urb() on both the submission failure
and the success path. The urb stays valid afterwards because the
port's preallocated out_urbs array keeps its own reference, which
matches how usb_wwan_write() submits the same urbs outside of
suspend.

Fixes: 0d4561947b8d ("usb serial: Add generic USB wwan support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/serial/usb_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 2c46330f10da..e7566960a5c1 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -587,9 +587,11 @@ static int usb_wwan_submit_delayed_urbs(struct usb_serial_port *port)
 			err_count++;
 			unbusy_queued_urb(urb, portdata);
 			usb_autopm_put_interface_async(serial->interface);
+			usb_put_urb(urb);
 			continue;
 		}
 		data->in_flight++;
+		usb_put_urb(urb);
 	}
 
 	if (err_count)
-- 
2.34.1

