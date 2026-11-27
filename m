Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795812838;
	b=nbGFqABO2r5mqo67K9H9fuJjv9C+nr4QT3ulyc0+HBzP8SzgjW6dyaPWyhCTQ+7F/9OY
	 CbsQZnMKcTE9Ufyxa4K/zse1QbcraqpPIZ97M1FT+atammtufEbhpr1DX2GATjXl+P7xy
	 v87MVHEPbeTSC8TVE0p7HdjGqgAzvGHWA91JuBNPat9A3eQ7OZInE9NT6EtJTZ2qDFXDR
	 aPj7n5b0vSRnvP3U6ACVA4YD8HQOOAe2y0wW/21CXakxBiZVP89hOM8pAzKBnp5UXv2bx
	 y5Bo3kzrfYrdPIrWd4Fp1DQjfAxmcGL7QG2hsJGoC/y89mNjCmwP93BYj04EFl163bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812838;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LBvMdnhkbrEn7f+QFLd1tbXFIQcUqSUHqscqnsNY6F4=;
	b=0BgixvY4fihcHABNRbFwz6RyqBgO49jQkU45oopm7YrNh85WEQY724v/FAo51SC1CDIQ
	 3Jum0R5jQ7TDzJlHHAynoWk+n9521sKyYTHIpagOnUUwRWJhtKvE90OicCjkz+hb3XV2B
	 mipK4tsPZRG4PVN4lWEvP3joyzwNJ4u5sMiWS6rm15jDZGmTJOxN+jcAxFhdvgFti4t7C
	 hkaWhWW0pf91B3Ev4PLVdOXmBf0enO28UhiZST2IaVZMkYfn2i3GpPXangAg6o9X5D0+j
	 8QwLVZYUaW6rLNVNTF9QLqAyarwu+f6xlJEMecx5/SDZ/XNRrwZp/YSBOA7+escnKTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdrTf4Ac;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1657606A32C;
	Fri, 27 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdrTf4Ac
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795812837;
	b=yHJqVc7X789qB+sRGRbBeNxGIui1QjPU/h7HoRHuWuSB9X+8tN8lY0IFQ+KiyHnXq0ET
	 VBdPf6Bb3AI/h6XqJADXmf89+UDg1WJsWflcpt2pt7v+vVsNzLkdk1FBdIyPYDHhowWDF
	 rFP0PWjGtg5CCaLfzJoVntJnRTEISrFvR8jVrW6pJz1l9J5EjWlUdkCZHGHMxRu8gT6DI
	 ZQDeBQh2MXHI8g4CbJ0gw8phbAryjebLkNC09rC4YRMQIL7oiW4qWUuNEP0dkue/hpZ80
	 +V0j/YNast5OwBJocdKXMqs+xl4EpW5czpHGU7Xus/rkNodKWiiNBykXavp7wk5H+Yw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795812837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:In-Reply-To:References:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LBvMdnhkbrEn7f+QFLd1tbXFIQcUqSUHqscqnsNY6F4=;
	b=wGecvHyLC2m0+NP31A8Tet9VC/7cHPCmC4x9eHVkIUDmZkRYmVGHi8wadp0DYMzDU/pO
	 tUdAUrb2OPlN2XxwP6W0/yQzCOB9jLsA1RaUSR4JxYHH47p3HE2I4OZDTehfXruu3gOsR
	 SebMNhucWXHFcoMojpXAuNGFDeQLsXr0pCliHVV1Gj5RNC8RlwJK2aU5nVlQOpwTxrGJU
	 +rQDDYYHXfdt+qTQAk9b6xIqyhhZhJEt6/+2yFtkHRXo2jS65zmKlankwSXxU/Xm2auNp
	 hONuXhT1iEF291OXUhE5ZDd45VIaHKP6KvNsWDIDzi4O92yA0jF+br13N85nY/ROoSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E11C41F00898;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812837;
	bh=LBvMdnhkbrEn7f+QFLd1tbXFIQcUqSUHqscqnsNY6F4=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=kdrTf4AciyWdihANIPFm80cI5rb6Ajf1+eqYEUfLQxjeNuBA/3/vkPhLGLLqa3QZH
	 lXesCBaRth7MZood184+ziXM0dN43sp5tJJQ+AyU8cr+vudLsjOq7x4yqZ35QzfCSL
	 qHwVyHbPpaQP1mRbzAiTEZhwmk+F7AaRvsHMRyMjcXYKRe5u2hYPGcHsOvQotDsIiR
	 68LsXojfftntIjOJ2Fg3E/jwDB85CN95lWcTnhz6qFTr29BsxZmT2l5gjPhUw3YPTM
	 XRu83ADAfFOHfn9M78yc9vAalfpABx3EzvRXOsNmOHPU1vi/3o+I3Cws4F2WyRO9/P
	 PPCD2dk5tWh0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 69B054DDE3;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 20:47:02 +0000
Subject: [PATCH 6.6.y 2/3] usb: typec: qcom-pmic-typec: disable
 cc_debounce_dwork on stop
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
Message-Id: <20261127-typec-66b-v1-2-6fe3a0983e5e@certik.com>
In-Reply-To: <2026090807-unbalance-starlet-1c55@gregkh>
References: <2026090807-unbalance-starlet-1c55@gregkh>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>, Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795812420; l=3628;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=cbWbV6LY06byAH3dFx0kSfTR/qyusZYU9PRseIS90vU=;
 b=icHqSZ8f+1VZT8oOu08CrMysyAulSR+Fw1+zxIUTQTQDuDzC41igT4gVhMAyNM4zi1YHu6vZE
 6gUi5O3rnOTCExsiyOma9UwQA5KtFS8AUi3CIZugK2/VMPCjk+nCiof
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Fan Wu <fanwu01@zju.edu.cn>

commit 263f7d61a4201cde16849b2d016251806e7418be upstream.

cc_debounce_dwork is queued from the set_cc() and start_toggling()
callbacks, which run from TCPM's kthread worker.  port_stop() returns
before tcpm_unregister_port() destroys that worker.  Flushing the worker
during unregister may therefore run a callback which queues the delayed
work after port_stop() has returned.

The delayed work can then run after devres has freed pmic_typec_port.

Use disable_delayed_work_sync() in port_stop() to cancel a pending
instance and prevent the TCPM callbacks from queueing another one.

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable <stable@kernel.org>  # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260820135307.153773-2-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted to 6.6.y: gate enqueues under the port lock before cancel ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6 has no disable_delayed_work_sync(). Port stop instead sets a flag
under the port lock, which both enqueue sites already hold, and then
cancels pending work synchronously. The flag is never cleared because
port stop only runs from remove and the probe error path.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index d6607491fcef..f0e5e8ab06c0 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -36,6 +36,7 @@ struct pmic_typec_port {
 
 	int				cc;
 	bool				debouncing_cc;
+	bool				cc_debounce_disabled;
 	struct delayed_work		cc_debounce_dwork;
 
 	spinlock_t			lock;	/* Register atomicity */
@@ -269,6 +270,9 @@ int qcom_pmic_typec_port_get_cc(struct pmic_typec_port *pmic_typec_port,
 
 static void qcom_pmic_set_cc_debounce(struct pmic_typec_port *pmic_typec_port)
 {
+	if (pmic_typec_port->cc_debounce_disabled)
+		return;
+
 	pmic_typec_port->debouncing_cc = true;
 	schedule_delayed_work(&pmic_typec_port->cc_debounce_dwork,
 			      msecs_to_jiffies(2));
@@ -440,6 +444,17 @@ int qcom_pmic_typec_port_start_toggling(struct pmic_typec_port *pmic_typec_port,
 	(TYPEC_STATE_MACHINE_CHANGE_INT_EN | TYPEC_VBUS_ERROR_INT_EN | \
 	 TYPEC_DEBOUNCE_DONE_INT_EN)
 
+static void qcom_pmic_typec_port_disable_debounce(struct pmic_typec_port *pmic_typec_port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmic_typec_port->lock, flags);
+	pmic_typec_port->cc_debounce_disabled = true;
+	spin_unlock_irqrestore(&pmic_typec_port->lock, flags);
+
+	cancel_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
+}
+
 int qcom_pmic_typec_port_start(struct pmic_typec_port *pmic_typec_port,
 			       struct tcpm_port *tcpm_port)
 {
@@ -496,6 +511,8 @@ void qcom_pmic_typec_port_stop(struct pmic_typec_port *pmic_typec_port)
 
 	for (i = 0; i < pmic_typec_port->nr_irqs; i++)
 		disable_irq(pmic_typec_port->irq_data[i].irq);
+
+	qcom_pmic_typec_port_disable_debounce(pmic_typec_port);
 }
 
 struct pmic_typec_port *qcom_pmic_typec_port_alloc(struct device *dev)

-- 
2.43.0


