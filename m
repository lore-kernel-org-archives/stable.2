Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186925;
	b=EidAwtNLweIjVU396A/4AHseg5BLkxrkG3XtXgoXl5vDZ52kzVOY4mxTgiO91kKcTWst
	 72PYyZnGGc9UgtfFMbTafBwIjsckxgX4tI66fjlSWl7i4ko8972Wp4aAyB0kpfd/QfdaI
	 7Wsr15GELGL+be9mU9EZeLik6pGgag+9RbwBJNxTe8r3dDW39kJOgzEXGjb4Lky1tYuor
	 Mlt1ogHVC08ejnQuuBX+u+Bv04YmbNDc4NOa/Z2mamxUH5osUVQHkg3lrnGny4x/yTjEn
	 5C/OGBlYOIudiAw0l87W62Z7Pu9FjCIq8wUUOzJJZrm9q5g73IxTeKQTjIVHfcjuzlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186925;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ScY+xnBbziyHwDb/c7EhNE2QbKqHrh2rXWypNNv2ExM=;
	b=Hetf6VEzFwIkXUmsNcCoUYov6qoQCviptJVNjQEa+yWS7pDP8tEGhRQ8zXmPZFqq/3/1
	 7hTUSmKQHbAjWtwNFaW0FzEDaq6plF8gUT1NdwIINDvp6qcfHJorQJzrQYaNXAesQRW9m
	 a7B8UmU9VQz0gS6hWxlLHVUyDDFalTefkLIEleKLX3PybcX5OElRdHhoeRHZWUfXBQO/b
	 VY8Y6eZA3BhCJpkTQQ9ubBnCgd2ue089IBJQEnbgju1b8KQVXukttYMYlQTuP4AZB12Kd
	 lIBbA+EviZ37/Jnvbzs5BPBc1KsayMSSVCudSVBeUu2W7XPmCvGVi0QTfeYxRc0vk/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE0606C878;
	Fri, 20 Nov 2026 15:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CE0606C878
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ScY+xnBbzi
	yHwDb/c7EhNE2QbKqHrh2rXWypNNv2ExM=; b=P1yYhomN0ZDq9horRAdMqutpRj
	lfneJKRrbwDP6GcmBKwxdjAzOsLlqcYKhSGl7818NfWnNjVw7LJBqGQ13xILJ2WR
	fQCURMehN6wrx6LPjjHeuTq93K1eLsmw+B88JuYfFV+XLLzVKuNwuN7C15rMP/L1
	rY1rDWeeeD7zLzauk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBGagDYYABrtGLzAQ--.38114S2;
	Fri, 20 Nov 2026 23:01:46 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] usb: ljca: fix NULL pointer dereference on events for callback-less clients
Date: Fri, 20 Nov 2026 23:01:43 +0800
Message-Id: <20261120150143.2591-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkBGagDYYABrtGLzAQ--.38114S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47XFWkAw4fZFy5KF1UGFg_yoW8tw4Upa
	yUJFyYkF4DGFsFva15tas8Xa4rC393Za4Dua4UC3Z5ZF15WayvyFyYyw1DKrW3tr4UAw17
	t3W5tFy2kay8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUcmiiUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2r-E0n0kQABsg

ljca_handle_event() dispatches an incoming event message to the first
client whose type matches the message type and calls that client's event
callback without checking that a callback is registered.  Only the GPIO
client calls ljca_register_event_cb(); the I2C and SPI clients never do,
so their event_cb stays NULL for as long as the adapter is bound, while
they are present in adap->client_list.

A device that sends a message without LJCA_ACK_FLAG and with the type of
such a client therefore makes the driver call a NULL function pointer
from the URB completion handler:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x0
  Call Trace:
   ljca_handle_event drivers/usb/misc/usb-ljca.c:217 [inline]
   ljca_recv+0x651/0x850 drivers/usb/misc/usb-ljca.c:295
   __usb_hcd_giveback_urb+0x238/0x550 drivers/usb/core/hcd.c:1657

Check event_cb under client->event_cb_lock and skip the call when no
callback is registered.  The same lock is taken by
ljca_register_event_cb() and ljca_unregister_event_cb(), so the check
cannot be invalidated before the call.

Fixes: acd6199f195d ("usb: Add support for Intel LJCA device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/usb/misc/usb-ljca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index fcb627b49eac..36e01783252b 100644
--- a/drivers/usb/misc/usb-ljca.c
+++ b/drivers/usb/misc/usb-ljca.c
@@ -214,8 +214,9 @@ static void ljca_handle_event(struct ljca_adapter *adap,
 			unsigned long flags;
 
 			spin_lock_irqsave(&client->event_cb_lock, flags);
-			client->event_cb(client->context, header->cmd,
-					 header->data, header->len);
+			if (client->event_cb)
+				client->event_cb(client->context, header->cmd,
+						 header->data, header->len);
 			spin_unlock_irqrestore(&client->event_cb_lock, flags);
 
 			break;
-- 
2.34.1

