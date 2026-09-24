Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4A3195FA;
	Thu, 24 Sep 2026 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218463; cv=none; b=oOvVq8enjkgmHChZWj7UMFvTaYmf7VV9a2LLu8ryMC6AM96PL+jvQMYFyD+5WXqTQz2GHkZe2zULwd9I9GA3EzNG+rEzZxBP7DB+ssf6QN8pln11G2ZYpX47sN5a29OE6Akb0+RRTS4e7OS2Br3l2NzNvuxbmBeqIZfSMwfUhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218463; c=relaxed/simple;
	bh=nSMyFFtfvLIAGD1/igwmsQORCSS04P6Y1knsV1Dk7HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMOcecC+AudmP8Jkq5WiodUFDAb9EZXiimbhTripK3m0WvkbAVVKxwqJEp22Rd2cmMpBMNiDN8ISQNuMtXfW5qn80uqmHg9r9gl9f91lNrDHDnBwZ7pEydemX79iYsCC/s3eav6aBrGU2kdw2PO7xymZGFv5QEGgv+/lf7YcmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=W3xteY1S reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="W3xteY1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=8XCQNesK4qZ4HvreArsJFnHXx6QAZswAwM
	x3VKTnJ4g=; b=W3xteY1SSH9SD9qkPaDZVh0A4dAkPoOEVNbHOAnMUS3MKFcIMn
	McAgXOz5QR82ZxWQitrTC5MLFj9VOidYkwubB3FD7kY26hTgD8dZOgs98EyWj4k9
	0IUPiYhMAe4cPpG0iuNXmhdbxszghl6IBorgAXhJf0dhzWjrghGbv9yDQ=
Received: from localhost.localdomain (unknown [113.200.174.5])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkB2WTjPkLRqQVM1AA--.5783S3;
	Thu, 24 Sep 2026 10:54:12 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: sean@mess.org
Cc: mchehab@kernel.org,
	oneukum@suse.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuanzhe Liu <25031212351@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] media: rc: igorplugusb: quiesce callbacks before unregister
Date: Thu, 24 Sep 2026 10:53:51 +0800
Message-ID: <20260924025351.122-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260924025351.122-1-25031212351@stu.xidian.edu.cn>
References: <20260924025351.122-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkB2WTjPkLRqQVM1AA--.5783S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWfJr1kKry3XrW8Aw1UWrg_yoW8XF1Upa
	y8KrySyFyUGF48XF4qqw18tas8Aws3JFWUCry7Ww15Cwn5GasxtFyxta43Z3WDCry8Ary2
	yw15W3yfuFyDCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	CY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUniSlUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2qz71dk4QAAsp

igorplugusb_disconnect() unregisters the rc device before poisoning its
URB. rc_unregister_device() stops the raw-IR kthread, but a completion
callback that is already running can still call ir_raw_event_handle().
This makes wake_up_process() dereference the kthread's freed task_struct
and triggers a KASAN use-after-free in try_to_wake_up().

Poison the URB and delete the timer before unregistering the rc device.
Poisoning drains any active callback and prevents resubmission, while
deleting the timer stops the other URB producer. No callback can then
reach rc-core after its raw-IR kthread has been stopped.

Fixes: b1c97193c643 ("[media] rc: port IgorPlug-USB to rc-core")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/igorplugusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index b5117ee..42e05b9 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -241,9 +241,9 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 {
 	struct igorplugusb *ir = usb_get_intfdata(intf);
 
-	rc_unregister_device(ir->rc);
 	usb_poison_urb(ir->urb);
 	timer_delete_sync(&ir->timer);
+	rc_unregister_device(ir->rc);
 	usb_set_intfdata(intf, NULL);
 	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
-- 
2.45.1.windows.1

