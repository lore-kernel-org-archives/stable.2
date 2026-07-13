Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F100425CEA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949057; cv=none; b=ElJIm8Ajl2868crp858hYljPCJeEzEV42wyrKcNtxxLIWhFFWnO4tTBORDAcRL3SX0vguaDcbSyUsqo0MUmediI3XJHW/ze9rtLHBUrK9YnHpXqsNJE3OwDF368jTtVhfhn+NiXp/EvMMFbhoHQuisXCxWwB39GCBb3fNGXD4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949057; c=relaxed/simple;
	bh=5TSmIGMenD0raIjHdK70kmxMGFXh/yUdweC2IqhsFb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SblP/J5ijMROno3s0nEEvs62sJRoabESsj1zoQ69EWq7T81j5VfeJX3J3X7hdrITNsRPShUPOj247KwRUKtvHTLfGdsCZ6U2U31JDx9mf1Mo9gxFzOlORXi9Eird5fvxebmk5TDugw7cd3DKk2FVKFHeVdsNv3D7N1okMe6+FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4hXlzuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4hXlzuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8A41F000E9;
	Mon, 13 Jul 2026 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949056;
	bh=P2PgSODwZQaSXorYRRsJxfRDsw3O7Ru0Y5UdKQh4HsI=;
	h=Subject:To:Cc:From:Date;
	b=g4hXlzuj0ykkLrnZQ+sdqPQta/o82jrHv7VOpbwA1hH9L1eu42OkNbO6v1ttXFTrq
	 C1KCo7RK5akNWq0XpKxhXnN5MAVc1T+yiE6bKpGqzDas7WxZqjBtQPjIyfzDNXo7gQ
	 h9O94g5E0wUp4oGyInm0pN9QMAmOcMA+PBR7kswY=
Subject: FAILED: patch "[PATCH] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:14:47 +0200
Message-ID: <2026071347-polyester-drool-f66a@gregkh>
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
git cherry-pick -x e8da46d99d3710106e7c44db14566bf9b57386b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071347-polyester-drool-f66a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8da46d99d3710106e7c44db14566bf9b57386b5 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 6 Jul 2026 23:53:12 +0900
Subject: [PATCH] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres

rt1711h_probe() registers the TCPCI port before requesting the interrupt
and enabling alert interrupts. If either of those later steps fails, the
probe function returns without unregistering the TCPCI port. The explicit
unregister currently only happens from the remove callback.

Register a devres action immediately after tcpci_register_port() succeeds,
so tcpci_unregister_port() runs on later probe failures and on driver
detach. Drop the remove callback to avoid unregistering the same port
twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 302c570bf36e ("usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260706145312.37260-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index a8726da6fc71..20037ef130ca 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -295,6 +295,8 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 	return 0;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
@@ -340,6 +342,10 @@ static int rt1711h_probe(struct i2c_client *client)
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -357,11 +363,9 @@ static int rt1711h_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct rt1711h_chip_info rt1711h = {
@@ -394,7 +398,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = rt1711h_of_match,
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);

