Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795812837;
	b=IyRcYN/hwoN7gSlp7CXJJ8ukp/+YIhAbLM0PDXjWG7GxeHutt/+GiHxEXyaoNsLuJXIc
	 1BXCyQfwf3SD3r5y5fXKUopXz1zyWlsm7PlA6+iwXQeP3YENiY/Acjai00n0JzoMc10yQ
	 pPDzQxRyX5wyqwRoo5+YJrZi/iNQP0xE2P2NnTpIRubhjf7mwYKgsHp+OU5Er84Z82inD
	 B8yC6XB1LRtvLiBVlFlrLkdoq5iRbaynDjLquDzvZUYXH8Js7R7tQEuJvgSXZTQCMEtqj
	 fx4gglxW4oUZNIRhVMgtvA6HWxj/H33jC391WZCKXKVb5/YAAmcz1Wh1eJtdzikllqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Vs3QaIl6orcFV9c4EkfLhNMNsPuhzL5TH7YDV9Dp114=;
	b=oxIvgJ9xR1WovGa/HIV9v7NCHEkP3BkbtxGYwxbpoHXCJ0r0z2coE6MVjFn/8LobFDGA
	 PqRo4WT4IzHQDyWwFnk/1AmgsKaC1riU/Ys+6cq3uGkpMhf2VGncg7IFz2o1Vx1JmPB0I
	 wvb4PhtD451D2uvQ3OLbNff/X0o8GbfaVfcUyD3lZSKwuoOr+eTWQMg9qQo2QPFlN6WY8
	 HT+D88qPmK4tvG/++jdFZokDw1wLiMf3HaR2tvxpFMQWp7wNjwH5Bc3ZBpuaugcMngwfy
	 xvHAqjQITVm8HrF0qTMAgIUr24KjY4wJw/rSGG2sq5okIiKWSnBPiTJ0Nfp+D68u54Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcEho2eW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918E606A31E;
	Fri, 27 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcEho2eW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795812837;
	b=trrumW7QpCt3fmqxPEtTxECksUyRxnD8b1O5PQrmWct5Tneue7Lx7ferZPrjsqMqTWGx
	 000Lw3C4ke2B0sBlaw51Q6ZnB0XgwwHnDH4fvn3BFcFdleI34CjX72KutupK1X0h6VGNE
	 bhWfiV8h/7ToipX3VKjoR1R6v03Y+q4bqDDrYUmFiLpkTRXQaPdZv1LtN7+1q5ng7Y7m9
	 zOsztQ4W3URwWWnephxqWvUKRNtmOzJ53EXAU2zpuir3EEc/P5gzxbzSEDz0ur5QQgOUI
	 R4pkhtvQbBIZSNEVEN5jgiEBHTiQQhN7jyqyXnhDMgVX43ytOAk+NsGwsTImPnKuRRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795812837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:In-Reply-To:References:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Vs3QaIl6orcFV9c4EkfLhNMNsPuhzL5TH7YDV9Dp114=;
	b=hkjHWMtgAymePSjQ0LXV0iAiR5wz+az9apTjWKjQ3gAIinTBGP8sVHe7+lm4cqJuzL1r
	 M0AF7w8U185r+Hhi8vAomY2Miyd0T6fP90EuZBbdJGJDO7vkJJBMRt/beCR1T//46qiF2
	 qtoh61mkv+flcf/OrSev5VglcZ9sMJuTPz5I1ASgMExWQ5mbTH5wvRlGUzdpDW0+eqfRH
	 XBX/UyVl03PDbXKxTrz06GaFNBVocQ/aUhtgFhEh7MjZ9ycROsbNkcTdIg5hJmY4osBv9
	 hBpTCyFY2upesIY9EAgmPCA9FGb68SNWXMdMNHEEjQ4rXxEn883ZHjDKWxxHTVLBvaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF5A21F00897;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812837;
	bh=Vs3QaIl6orcFV9c4EkfLhNMNsPuhzL5TH7YDV9Dp114=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=UcEho2eWMMDUIf5zGYPU8QKY5sMhMSOna+6OXTxIhPNBtXFC7j7z14o0iI9Riwukw
	 Ltjbp6IC4Vii5Vzq3pfcnxDe73+JwdPxKA/ET3KTi2IsErBeT0URnF+oo65XscWJvJ
	 9rOvhfkDJNiroP2VCATRMrx27Cm/nk6TbcamnPD8yykIr4kuX73jcAKN9783s7a71b
	 bh3p56t2XXdYkSCsWr4YTxQx+22QwOV1F7ZP7giJ1AwmyV6vJ0VqfwSlL2d4Ey/PgM
	 ofeWq/iwsG8yr+RUCR7I6AjeLnMUXE1x74mKXEJ0rylUd8jzEZ1QHxrQJr55agEpc9
	 O2eZgAEOsYhHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 485E34DDE7;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 20:47:01 +0000
Subject: [PATCH 6.6.y 1/3] usb: typec: qcom-pmic: fix use-after-free on
 late probe errors
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-typec-66b-v1-1-6fe3a0983e5e@certik.com>
In-Reply-To: <2026090807-unbalance-starlet-1c55@gregkh>
References: <2026090807-unbalance-starlet-1c55@gregkh>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>, Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795812420; l=2149;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=3+jRieiIiLtkEBFh8rjXnHAz91HQKwbqmAEfeXhAQGU=;
 b=fRUIE/RbUYn4YbVOAI8nGW7LIguH2UDaMptsjlGU52TyK+kKLzwk47eT31c85v33VTwVDHbuG
 A0TIXjqaoP8DrcE6dP8lBgKzaRB0oaeIr8HXErA66yLmTJT0dj3QpU3
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Johan Hovold <johan+linaro@kernel.org>

commit d80eee97cb4e90768a81c856ac71d721996d86b7 upstream.

Make sure to stop and deregister the port in case of late probe errors
to avoid use-after-free issues when the underlying memory is released by
devres.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240418145730.4605-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted to 6.6.y: use direct port helpers and fwnode_handle_put() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
On 6.6 the unwind calls the port helpers directly and keeps
fwnode_handle_put(); the tcpm ops layout upstream uses came later.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 5f67925a19d3..a8fc86099f32 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -258,15 +258,19 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	ret = qcom_pmic_typec_port_start(tcpm->pmic_typec_port,
 					 tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_unregister;
 
 	ret = qcom_pmic_typec_pdphy_start(tcpm->pmic_typec_pdphy,
 					  tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_stop;
 
 	return 0;
 
+port_stop:
+	qcom_pmic_typec_port_stop(tcpm->pmic_typec_port);
+port_unregister:
+	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
 	fwnode_handle_put(tcpm->tcpc.fwnode);
 

-- 
2.43.0


