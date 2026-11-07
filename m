Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032393;
	b=P/V7r1pjiULRWnUXdDMwSxWAtTcjR0iRXnKM/c1FHeAqKBWJkmkm7eZhDSSOrCTqLDZg
	 T0p+ggJ1X7QkDB0qGizF1uT68mspiq2ExQF1soGsXyejbt3J3F2yVaCN/FKeIgnQM/VG/
	 /FmXZJgUeNiWBH5nBe3jOMuL9l95Ug0E9uK4EZHfjTy8YxitlIw6xhSiw69UDsrjXWfKx
	 Nkfl0k+ciu3T/7xjjRid/WHod6eDrOSMDwT+bBJMLJ0hdnLyYC64jPQt7fTxN3nmCFW30
	 aPokefqky7IBLjN1Xl+nozeIH6XIWcx6H3iL7n936qdHd26lTN+g9jbrso46yk7fApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Message-ID:In-Reply-To:References:To:Cc:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xd/Rrz6G4skAqcLMMbmw+5Mcc5fzjjR69xjLDlk4KFE=;
	b=fvqrnmXWayipNUJs5bu5r1jqM38ut7xhLYB/m6DhEDf+lDv2hxY9eWdbJNbuwwUXH6WT
	 SDNldBDNmI/o6JuGbEYeod18nEjAAbQt1crHWwb4hYiMwb0BWn+mZ6b93TrVuxcWtRbpQ
	 y5HJ3Ilycae+AFchpASBbm5WAbr6iGueY6aWaIIr2i7YVydenVlrawTdAjlkI5vTAfB9q
	 xNeFAoTWcOASE/cdgUVXeimzgnf5DBjG50yUBx1AL9XOQApMuaqp2Ig4ICLrJmfiGVAOB
	 RWRjoz90hLvkznkifaCR9UYGVBaOqdOMC8P5s6EXVszgFnzN1b9HRdcedjJ4UOVE1qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xM39QFfm;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA65606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA65606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xM39QFfm
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso883279a91.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032393; x=1794637193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :references:in-reply-to:message-id:subject:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xd/Rrz6G4skAqcLMMbmw+5Mcc5fzjjR69xjLDlk4KFE=;
        b=xM39QFfmL5VNXqLMzTHC93dvkKOjGy9Blq14oR6uSU78duG0WHfSRREWVtVdJjiX21
         RCE1b8LlDmE1Ev0rJOI0HfnA2f+ZjSImwBFHqlpxHsO66apI5S9nWje7A14ni1VAzoA7
         s83OJ8ArbCpoM3W8r7XYLGZd3L224XiOgyjgGGJvk8aHcqtH9+xYBFKX/JNntClI1hYy
         U7l5diPC7ahbLNNQEveWdkYMyyTIZ2ho+AM3fjO/68N0QR5/RctVoD7MAZ7mef2cC6bA
         RUAIi1beAMDmRcUM21/2hOy4ISrRQPUQDyO//WII4yAWic9VsjiJRgXNQuT5KGHtGVRi
         9MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032393; x=1794637193;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :references:in-reply-to:message-id:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xd/Rrz6G4skAqcLMMbmw+5Mcc5fzjjR69xjLDlk4KFE=;
        b=jl37+jAEGTEp4a9bpqu/7m6ZDpEPhwG0RFNLVyadgVVHc6/7b6f8NvEa0CTCl925ak
         HlR1ZwRJxRue/7M+SlBKiI1hfwmdGYtwi++MDhUs3wTLoq7A5TvlrVUl8ju8z14CiM5Y
         JlcmHokWTw6OZycb1nDUyDWdrCJNCk9QibXNRenVG+ZQuEdA2WmGIpbLasHS5KsAYu57
         IQOn0qOVj2cp1r/k9CkFS2MAcn9QDrWpHXN3rL+wWIjOv3uaOQh9roCDgDcfkOK+i5Ez
         va5Q4vN4g2cEqwoyT5xndbfpctqSbkTuL+wcaBV1b6e8niHdeYY2rKnmzRTreg+Bt6JT
         4bEA==
X-Forwarded-Encrypted: i=1; AL+hErH66YvpGNabFuLquXmFIHy4l0bH7AgWiNFiEUn++KBVOFWMbezw73JWvkPNu9frP8OhPRJDlsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vdd1OuAyTemFjqeIBqKSRGsjqmqkklyRTP8RQCmvFCZ+bu6iM
	hEKo2eEe9WBricU2WNavBxPm+GPEhJhbKnD9hq/K9u7UquMvu8FeatH4
X-Gm-Gg: AYBFou3EWqklxYdYxKSUt/nsgzokRPEKiW46j842edMWqHuAAE8j61dj3AJKvbtF58S
	/Hi6wwjQ7W83CTyfrE2w3ndBsW4/w4UUKpIEpphmio0INa0l29yCQJSg4TYgrYMIhUqYluKLX4N
	WLF47HTCqsuEI6c6VGs6wH52mO/xdMO+gG21NcXCgnRADkPo4oFFg25fJDwNfIeTDgX+u6AQXfS
	LGYb+Uv1NyXdLt0eXRV397zNkAd4WFcigWzhnrbke6lJYaRC3TKS2g0up5esYRps5FGvAariQsk
	/CnblcQOBrEQUKjS85TYjdzLExMWIN51AqUeEOwGO+0qvDs6bDYNnjiUjKX430zB7te+lpD0E1X
	ICXzhMl0mrP20H0+aWtBoY5jn7Nv+5wT0Yn0n48QWWWm27/F6SswmCA0mCfPOUFv87+vMCJFDxv
	KOBRWTTjG+zLXPByNzGZnnuYbUf+2RPLy/2gADus6QEs8Ob1wF7XQBFuiadjC+z/6uu/ZxO/zsY
	8Z3zASKOp0N94T/qbG0PXGUTp5T0EVoSLq0e0wTc7NeQXgi747EugvW7NC7LoWBrZvIu5M99gTk
	ZmFgCjhMKMRKxWBVOXcDttgR5EQZbZ+fq6fW0ZJO6dvZ3+oZv8lZEl3WmPTvaEBENFC8oKYVInf
	59s5LN28=
X-Received: by 2002:a17:90b:540c:b0:3ad:adfe:5854 with SMTP id 98e67ed59e1d1-3b0db6e4757mr4779195a91.40.1794032392625;
        Fri, 06 Nov 2026 22:19:52 -0800 (PST)
Received: from patch.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm1965794a91.10.2026.11.06.22.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:19:52 -0800 (PST)
From: Yuqi Xu <xuyuqiabc@gmail.com>
Subject: [PATCH net v2 1/1] nfc: digital: fix use-after-free in unregister
Message-ID: <20261107141910.549465-1-xuyuqiabc@gmail.com>
In-Reply-To: <cover.1793112510.git.xuyuqiabc@gmail.com>
References: <cover.1793112510.git.xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>,
 xuyq21@lenovo.com, Mark Greer <mgreer@animalcreek.com>, Uwe =?utf-8?q?Klein?=
 =?utf-8?q?e-K=C3=B6nig?= (The Capable Hub) <u.kleine-koenig@baylibre.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Escande <thierry.escande@linux.intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Date: Sat, 07 Nov 2026 14:19:10 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

nfc_digital_unregister_device() cancels its own workqueue items and
then frees every queued digital_cmd. A command already submitted to
the driver remains the argument of the async completion.
digital_send_cmd_complete() can still assign cmd->resp after that
object has been freed, which is a use-after-free.

Abort the in-flight driver command before reclaiming the queue, and
drain the completion work the driver may schedule from abort. Once
the nfc device is shutting down, do not queue or submit another
command: finishing the aborted one would otherwise hand the next
queued command to the driver while it is being freed.

Cancelling cmd_complete_work does not run it, so a response the driver
already reported can be left without a consumer. Free cmd->resp in the
cleanup loop, and free cmd->req for a command that is still queued and
was never handed to the driver, which is the only case where the stack
still owns it.

Port100 and nfcsim invoke the digital completion from a private work
item, so flush that work before abort returns. trf7970a completes from
a delayed timeout work and from its IRQ thread; handle its MD listening
state in abort and shutdown, and cancel the timer only after unregister,
so no submission or IRQ path can arm it again before the device is
freed. st95hf's IRQ thread can observe that remove already ran and must
not call back into the freed command.

shutting_down is read under cmd_lock but written under the device lock,
so mark the accesses with READ_ONCE() and WRITE_ONCE(). Document the
unregister-time requirement that abort_cmd() must not leave a completion
callback armed or running.

Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/nfc/nfcsim.c      |  8 +++++++-
 drivers/nfc/port100.c     |  7 +++++++
 drivers/nfc/st95hf/core.c | 13 ++++++++++---
 drivers/nfc/trf7970a.c    | 11 +++++++++++
 include/net/nfc/digital.h |  6 +++++-
 net/nfc/core.c            |  4 ++--
 net/nfc/digital_core.c    | 33 ++++++++++++++++++++++++++++++++-
 7 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index f8e5c4da3b13..52d1fbf8e532 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -239,9 +239,15 @@ static int nfcsim_send(struct nfc_digital_dev *ddev, struct sk_buff *skb,
 
 static void nfcsim_abort_cmd(struct nfc_digital_dev *ddev)
 {
-	const struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
+	struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
 
 	nfcsim_link_recv_cancel(dev->link_in);
+	/*
+	 * recv_work blocks in the link wait and then calls the digital
+	 * completion. Wake it and wait so the callback cannot run after
+	 * abort_cmd() returns.
+	 */
+	flush_work(&dev->recv_work);
 }
 
 static int nfcsim_switch_rf(struct nfc_digital_dev *ddev, bool on)
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index e769a30b8b5c..738acb87f19b 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -968,6 +968,13 @@ static void port100_abort_cmd(struct nfc_digital_dev *ddev)
 
 	/* cancel the urb request */
 	usb_kill_urb(dev->in_urb);
+
+	/*
+	 * The URB completion handler only queues cmd_complete_work, which
+	 * is what calls back into the digital stack. Run it before
+	 * returning so that callback cannot outlive abort_cmd().
+	 */
+	flush_work(&dev->cmd_complete_work);
 }
 
 static struct sk_buff *port100_alloc_skb(const struct port100 *dev, unsigned int size)
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 4d772a308bff..b39a5215dad7 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -856,9 +856,16 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
 	kfree_skb(skb_resp);
 	wtx = false;
 	cb_arg->rats = false;
-	skb_resp = ERR_PTR(result);
-	/* call of callback with error */
-	cb_arg->complete_cb(stcontext->ddev, cb_arg->cb_usrarg, skb_resp);
+	/*
+	 * remove() frees the digital command before dropping rm_lock.
+	 * The completion argument is then gone; do not write it.
+	 */
+	if (!stcontext->nfcdev_free) {
+		skb_resp = ERR_PTR(result);
+		/* call of callback with error */
+		cb_arg->complete_cb(stcontext->ddev, cb_arg->cb_usrarg,
+				    skb_resp);
+	}
 	/* up the semaphore before returning */
 	up(&stcontext->exchange_lock);
 	mutex_unlock(&stcontext->rm_lock);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index ddfc58c29964..87c833abb36a 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1903,6 +1903,7 @@ static void trf7970a_abort_cmd(struct nfc_digital_dev *ddev)
 		trf->aborting = true;
 		break;
 	case TRF7970A_ST_LISTENING:
+	case TRF7970A_ST_LISTENING_MD:
 		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
 		trf7970a_send_err_upstream(trf, -ECANCELED);
 		dev_dbg(trf->dev, "Abort process complete\n");
@@ -2017,6 +2018,8 @@ static void trf7970a_shutdown(struct trf7970a *trf)
 	case TRF7970A_ST_WAIT_FOR_RX_DATA_CONT:
 	case TRF7970A_ST_WAIT_TO_ISSUE_EOF:
 	case TRF7970A_ST_LISTENING:
+	case TRF7970A_ST_LISTENING_MD:
+		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
 		trf7970a_send_err_upstream(trf, -ECANCELED);
 		fallthrough;
 	case TRF7970A_ST_IDLE:
@@ -2230,6 +2233,14 @@ static void trf7970a_remove(struct spi_device *spi)
 	mutex_unlock(&trf->lock);
 
 	nfc_digital_unregister_device(trf->ddev);
+
+	/*
+	 * shutdown() leaves the chip powered off, so no IRQ or command path
+	 * can arm the timeout again and unregister has cancelled cmd_work.
+	 * Wait for a handler that was already running before freeing trf.
+	 */
+	cancel_delayed_work_sync(&trf->timeout_work);
+
 	nfc_digital_free_device(trf->ddev);
 
 	regulator_disable(trf->vddio_regulator);
diff --git a/include/net/nfc/digital.h b/include/net/nfc/digital.h
index bb3e8fdc0692..d5ae45da5a33 100644
--- a/include/net/nfc/digital.h
+++ b/include/net/nfc/digital.h
@@ -131,7 +131,11 @@ typedef void (*nfc_digital_cmd_complete_t)(struct nfc_digital_dev *ddev,
  * @switch_rf: Turns device radio on or off. The stack does not call explicitly
  *	switch_rf to turn the radio on. A call to in|tg_configure_hw must turn
  *	the device radio on.
- * @abort_cmd: Discard the last sent command.
+ * @abort_cmd: Discard the last sent command. When called from
+ *	nfc_digital_unregister_device(), the command is freed after this
+ *	returns, so the driver must ensure that its completion callback
+ *	cannot run afterwards. Completions delivered from work items, IRQ
+ *	handlers or timers must be cancelled or flushed before returning.
  *
  * Notes: Asynchronous functions have a timeout parameter. It is the driver
  *	responsibility to call the digital stack back through the
diff --git a/net/nfc/core.c b/net/nfc/core.c
index f521669293f0..af2c9bd1fadb 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1133,7 +1133,7 @@ int nfc_register_device(struct nfc_dev *dev)
 			dev->rfkill = NULL;
 		}
 	}
-	dev->shutting_down = false;
+	WRITE_ONCE(dev->shutting_down, false);
 	device_unlock(&dev->dev);
 
 	rc = nfc_genl_device_added(dev);
@@ -1167,7 +1167,7 @@ void nfc_unregister_rfkill(struct nfc_dev *dev)
 		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
-	dev->shutting_down = true;
+	WRITE_ONCE(dev->shutting_down, true);
 	device_unlock(&dev->dev);
 
 	if (rfk) {
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 18236221d898..376dc78b5b19 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -162,7 +162,11 @@ static void digital_wq_cmd(struct work_struct *work)
 
 	cmd = list_first_entry_or_null(&ddev->cmd_queue, struct digital_cmd,
 				       queue);
-	if (!cmd || cmd->pending) {
+	/*
+	 * Unregister has already handed an in-flight command to the driver
+	 * and will free whatever is still queued. Do not submit another one.
+	 */
+	if (READ_ONCE(ddev->nfc_dev->shutting_down) || !cmd || cmd->pending) {
 		mutex_unlock(&ddev->cmd_lock);
 		return;
 	}
@@ -244,6 +248,11 @@ int digital_send_cmd(struct nfc_digital_dev *ddev, u8 cmd_type,
 	INIT_LIST_HEAD(&cmd->queue);
 
 	mutex_lock(&ddev->cmd_lock);
+	if (READ_ONCE(ddev->nfc_dev->shutting_down)) {
+		mutex_unlock(&ddev->cmd_lock);
+		kfree(cmd);
+		return -ENODEV;
+	}
 	list_add_tail(&cmd->queue, &ddev->cmd_queue);
 	mutex_unlock(&ddev->cmd_lock);
 
@@ -846,9 +855,31 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
 	cancel_work_sync(&ddev->cmd_work);
 	cancel_work_sync(&ddev->cmd_complete_work);
 
+	/*
+	 * A command with pending set has been given to the driver as the
+	 * completion argument. Freeing it here lets a late
+	 * digital_send_cmd_complete() write cmd->resp into freed memory.
+	 * abort_cmd() drops that exchange; the driver may schedule
+	 * cmd_complete_work before it returns, so drain both works again.
+	 */
+	digital_abort_cmd(ddev);
+	cancel_work_sync(&ddev->cmd_complete_work);
+	cancel_work_sync(&ddev->cmd_work);
+
 	list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
 		list_del(&cmd->queue);
 
+		/*
+		 * A command that was never submitted still owns its request.
+		 * A command whose completion work was cancelled above may
+		 * have a response that nobody consumed.
+		 */
+		if (!cmd->pending)
+			kfree_skb(cmd->req);
+
+		if (!IS_ERR_OR_NULL(cmd->resp))
+			kfree_skb(cmd->resp);
+
 		/* Call the command callback if any and pass it a ENODEV error.
 		 * This gives a chance to the command issuer to free any
 		 * allocated buffer.
-- 
2.56.0


