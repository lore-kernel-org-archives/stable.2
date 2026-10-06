Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D73559F8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272737; cv=none; b=SiAJRC7oxl4+hVBW13h7UgCKpqJxCdhNX75wnlVxhfUElpp6IssHRr2pq6E0575t8s+IIKCWiSU7YXHwFBkiubBkoDayHXa4dtNWmE0YPX+17bYc1HcddMdohZ5UlTJMsZ/muAkN8v8k8oT7Y2NiuybD10MQILe/xlFIIvc7RQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272737; c=relaxed/simple;
	bh=p3grTaivKHkOA3zqE6qsbfWSLnEnRkE0UN+s0fd0L5Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G2SNIKY6nJN6B8glPrxRehGXI+ZtzvbudJZWEwDggn9al7e8WQyc3KlbkGJJkv0L1yIiBfPLJL4w2tZOvt01tQcE/gLtuo34LpJqJJvJTNjjypUhkVQpuu+12sCOYzn6dePkhQuCPht/7WfLyufM0HvCRFW6iI0mXZB6bKK2iUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaR4E1KK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaR4E1KK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79C1F000FF;
	Tue,  6 Oct 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272735;
	bh=iW4o7YINyreCqeBNGeTorcbA/dTIHRQS8vEjJaz7k98=;
	h=Subject:To:Cc:From:Date;
	b=RaR4E1KKnvUgs3rsLpNONlPnjhn2V/bulYPPMd1GuMtPO1fUOm3y7jdApI9aWDVwN
	 /L/cdxaI2LoEBgcdGFTQZSO4zZp/Urn+BeAq4odKvz55YJpniK0EavVsWJfIdUfHgK
	 Jidfs6fGZhP0DTuL9BOhTBavrafyjMosKof75i68=
Subject: FAILED: patch "[PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the unmask" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,dlechner@baylibre.com,jonathan.cameron@oss.qualcomm.com,sai.krishna.potthuri@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:45:33 +0200
Message-ID: <2026100633-subside-encroach-28c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0f3f427076240e75ff265e61645627a71ca4918c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100633-subside-encroach-28c4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f3f427076240e75ff265e61645627a71ca4918c Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Mon, 3 Aug 2026 08:03:43 +0000
Subject: [PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the unmask
 worker on unbind

The ZYNQ XADC alarm IRQ handler queues zynq_unmask_work via
schedule_delayed_work(); that work is cleared by a devm callback.
Register the devm callback before devm_request_irq() so the devres LIFO
teardown frees the IRQ first, ensuring the handler can no longer queue
work by the time the workqueue is cleared. Otherwise the handler could
re-arm the work and run it after the xadc structure has been freed.

This issue was found by an in-house static analysis tool.

Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index cab66bb8cc1c..66202b3a3abb 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1401,13 +1401,14 @@ static int xadc_probe(struct platform_device *pdev)
 	}
 
 	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
+		/* Clear out any work queued by the interrupt */
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
 		if (ret)
 			return ret;
 
-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
 	}

