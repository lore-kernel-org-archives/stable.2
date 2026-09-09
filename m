Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D93CC327
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951317; cv=none; b=IaRbQuHgO9vA8x9s/m4s7KT7GKBjYbOuuZuyYAlxZ9saf5kp38Hj5mJwcxL+K8jmW7mo/A1k9bHf2Gv9KfsU+KtqRnb9ZPG/OrYje9gjW7u9MrpHiEMPiOvr4HNYT0vFeHxgSDPjb4Qn4McCaYf3wDYBMGUsc2Yq52PifXmY7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951317; c=relaxed/simple;
	bh=55ldDWfENmRnHBDQeYbfSK45GaMaSKal51fpojoGsto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sJ57cg2G1ulPfBHSOm14j+DZuilatz0x5NNs7vG+1HiKxfmT0wTP/DNvoJdFsScKXZEuUH+HFmXCdllfT7hF6nrtQsoZjdbXR/QNVBnMuLzqOR/v1xbepBC5egVrx4MLK/gWb7SbfluKKnci0zDU7G/RY1+UhMyJy32JxzWFjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rGGNwaZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rGGNwaZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52781F00A3A;
	Wed,  9 Sep 2026 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951315;
	bh=I3z1B0gAOt3CpStLJzxXi0PEF6+pYBfW7c4HAzsih0k=;
	h=Subject:To:Cc:From:Date;
	b=rGGNwaZtTrqHAo+cyx3Pybj1XrFssG5pxceLpNjI3n67KLiBw/khYZynV0KGoFYB9
	 vggSevAXmPneEDNNLRMuuxxDCYiCGnM9QZ0sXlTk4rQzvrSZr9ExvAEDd1atYgMk3O
	 Cqct2G3BbZMHJ/9lq070/Kpcum2+gcg3z9lmuiGM=
Subject: FAILED: patch "[PATCH] media: rc: sunxi-cir: Unregister rc device on probe failure" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:48:10 +0200
Message-ID: <2026090910-petal-cupcake-2b81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 479aa6fa8c50f1052f1451326ef7d4d586d340c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090910-petal-cupcake-2b81@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 479aa6fa8c50f1052f1451326ef7d4d586d340c3 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 13 May 2026 16:11:03 +0900
Subject: [PATCH] media: rc: sunxi-cir: Unregister rc device on probe failure

After rc_register_device() succeeds, later probe failures must undo the
registration with rc_unregister_device(). The current error path jumps to
the allocation cleanup label and only calls rc_free_device(), leaving the
rc device registration and resources created by rc_register_device()
behind.

Add a registered-device unwind label for the IRQ lookup, IRQ request, and
hardware initialization failure paths. Keep rc_free_device() for failures
before rc_register_device() succeeds.

Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index cb4c56bf0752..28e840a7e5b8 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -344,22 +344,25 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	ir->irq = platform_get_irq(pdev, 0);
 	if (ir->irq < 0) {
 		ret = ir->irq;
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	ret = devm_request_irq(dev, ir->irq, sunxi_ir_irq, 0, SUNXI_IR_DEV, ir);
 	if (ret) {
 		dev_err(dev, "failed request irq\n");
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	ret = sunxi_ir_hw_init(dev);
 	if (ret)
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 
 	dev_info(dev, "initialized sunXi IR driver\n");
 	return 0;
 
+exit_unregister_dev:
+	rc_unregister_device(ir->rc);
+
 exit_free_dev:
 	rc_free_device(ir->rc);
 

