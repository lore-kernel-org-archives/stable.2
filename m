Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA1328B7F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053280; cv=none; b=jS5Z5zpUDEUmZWSSg8nWVtCYiKZmjhafemweBbMJFQvFQdOlAPST1XTwQ7w0veWC0b6t+1yhzMZ9Qwk42Fm3Fr3NKrnElyONGPNI9ZhlwtLyb0FjnW7Bju2KVo+tc2mAXjIVICmHaIlaBgowPooTE47pFZrLS0zi5wU7nPCItYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053280; c=relaxed/simple;
	bh=EcZh9Z+DucgKzjTYOvfzU8c5Nr0B3IKythY/Zb35TxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxvoa9YJU8CkJtSWy5pTlXnPC3dnvP+fVjdTjDMMWRaMxKqJxaMVLzxQw8NkAhRMtBtvMiYgczD3oJl07HJmqQqVZaAqq0IUEdBvxhwNVVfjx/7mbjWG2/XCkmYyJkGyvVWpZBcMKHiFVymxEOOQV3YG10575zXb22cM/o4chAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuvWZf5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuvWZf5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F3B1F000E9;
	Tue, 14 Jul 2026 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784053279;
	bh=1CeFDlk7QuWs24khlghhoWuTIT9zhp1YrTuKGrVnD28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuvWZf5NTK4z00BhzFccz/WtqAxuxYTbnw+2zxSH2M92uDyYvJDCU/Yw/U/UtnTgk
	 TV7h/WA6UyuoszL0UZJWrltt95GHVgSEFsK1KKAqmKEaCOF2IUcp48FiqaMGuzkMcB
	 OgKxj+9JlI/+RnkM3B6hEHpNqOv+7DMKIDRH/v7oHvd5QnJmPset2R9Q/W4c1RLBgq
	 PTkmt5Er6EpIwSnIZE3gb525yqsbU7TWxHsxdZwiOFsR6/TTJwLecz5YiyipGk9fSu
	 sl8ShnZj2YTnCYfuvD9aFqXf7oAYDfCkL33EaIO8144syIBBcFAOuPOkMCQhqrSc7Y
	 ZsC2hNJF71I/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
Date: Tue, 14 Jul 2026 14:21:16 -0400
Message-ID: <20260714182116.3081947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071347-polyester-drool-f66a@gregkh>
References: <2026071347-polyester-drool-f66a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit e8da46d99d3710106e7c44db14566bf9b57386b5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 76ab5eb6d7f2bc..455f1e712024a9 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -212,6 +212,8 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
 	return 0;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client,
 			 const struct i2c_device_id *i2c_id)
 {
@@ -257,6 +259,10 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -274,12 +280,9 @@ static int rt1711h_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
-	return 0;
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct i2c_device_id rt1711h_id[] = {
@@ -302,7 +305,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1711h_of_match),
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);
-- 
2.53.0

