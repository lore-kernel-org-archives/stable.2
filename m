Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795812838;
	b=uK6fROpODhu65P6lLxoMqlzSKgLPpmBqH4GLP7F2RB2yTa2BSw4qLJce2W6uDmyUpej/
	 t2MvT6jSMSl3FBxn02esG2E1OEki0w9vyjbSf12vQTkIvQ6f4/D7EPEzSo2xhc8UnIbvk
	 pPMOkHSsos9FxeWFVvxBS8fAge7jPb3d4kcTIJFDTCzYEkyO9oEXoLyMSAIYZqeRak5jn
	 9Kad1URwHaQZzcxpnkSwoJG2/WaGHt36EnpOq6mzgUdoW5olLen+29oR09zLCya32Xg6V
	 U0E3vsOXACzUwwbGt7SQirawXpsDZJc0SSCWHxc+6KTk/Fy3VaYvd5VNTYBNpJhse+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812838;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8a0jvKYMEi2X5ZMKqw8TIBpn8gvuieErgynCPu6/Kac=;
	b=qFGTlpnuq485Lzva9yZZfAQvWN0oGptYgrIwEUhoTKN9PQqXYmyr11Fq+3Bfuq5jIK9l
	 Q5y2bl/mbPraLs0hUXuBJ95VncJa7V54v84kc7UNesUPeWk+wdREwIn+ptryvGCFwC/pH
	 Vq99E4R5UYyWluuEOLcYOWniVF4jz3VeZ2XIO24OUlsHniA9VFYtFWSKId2PnFSz9QCOs
	 /KfqVskgHyoJusIEl9nFelywCpFec3xzFCxW8kmUm+35qkoAn5cCFFDYbgQluHfqzilMK
	 XJpjFsRrZVp3ihbkAPnWK7L4h4pilqq+lFKFEtwmZEHeuFKUrIQnSEPT/qwUIHpnp1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9nySGlT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168C606A32D;
	Fri, 27 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9nySGlT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795812837;
	b=yxTP/CwkOr4T3htoYQtGlMODxYU+gw+XTQfDFSuAfF8VDvuswpqvev7ulERSwkrPcF2e
	 kHccAW7BJCS+D46ViRN4S7/zb4+h7uQMARLLovTfdxsnv0Gm0cveW46AtcngWyqtv+m8N
	 ogdtCNQiKnwQAfYIiQz5HRLiuJWh23mJkFfYicGNqvQrysAEhcVLnyE4WtXkFfzHD3OTR
	 Qi/OYSkDxxh01mWAKDRYz5P02yD4SPOPp7fJvsEzrWGIQL/4I5A4tGvFpp6kTLZFtYu6k
	 d2kcRh27t1zzQaUyDBnLv6ThzDhEjEKyAW9oVbGDfscT6MvdGFy9NB5zUbqlPYu0YpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795812837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:In-Reply-To:References:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8a0jvKYMEi2X5ZMKqw8TIBpn8gvuieErgynCPu6/Kac=;
	b=YAbyP/EqlphoYpLc6ScjWqxvyGTBuk0BlUpwR85FBg42VfCJVqUDnzxpT8vRvbB6T9OV
	 jswip/BOcZfSjJ/I5rB/NHRFwj59wrrNWDPSoVoWgz2S5fUGIJvZXAlpk4g4oFZl1VCmW
	 4tkbu4h/fFy0jKL9FzSHH3dPgirMagbQ5BZ90TdMjynJleSCKtMsm5EpSZdsPM08vWC9P
	 iC2PXN0YtZz/0LcPvm3QBuELMPjsCiTDnVqS5VYcHT/s3tYYnwAHAz8EQp2LWnve7L1BB
	 3RNHbcbljz1aQOKWJ3Shv9F1IrEZTmO8EScLXRHX5icjK9dfTU9cp5HIFQZZGxFcwyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0C7A21F00899;
	Fri, 27 Nov 2026 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812837;
	bh=8a0jvKYMEi2X5ZMKqw8TIBpn8gvuieErgynCPu6/Kac=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=e9nySGlTTEPXkQDn0Dh7u3MPn1+soYnFgcPIqVVQNC3ywaGUd9BnrvCWuw2uucRdi
	 yb06sjT7cP9RoPQqFiqP4xgzprxQY6dMvvHq4jMFiEBXzO7b1qVYtAcCoRhE0h11Ea
	 QqCwLTPVd+GK3xiSW7Yra7PR8RlcXSn6R+L+LYtE/mPdNWgidtS5SsxY2lkzE8zBUh
	 hkDDF1IN+YLmfcOvQLXYVugTxotXw2ELai1OMTjjsz46qGAlYdrCmwJ2twY+BmGnhW
	 k/k8BfFTshsjGxX6G7cLbaamtU8kP5kb5GU4lVIvKniiSsafJqIuY08NgigOZikkL1
	 ASpUTEh1s+jrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8918E4DDF4;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 20:47:03 +0000
Subject: [PATCH 6.6.y 3/3] usb: typec: qcom-pmic-typec: drain
 cc_debounce_dwork if port_start() fails
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
Message-Id: <20261127-typec-66b-v1-3-6fe3a0983e5e@certik.com>
In-Reply-To: <2026090807-unbalance-starlet-1c55@gregkh>
References: <2026090807-unbalance-starlet-1c55@gregkh>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>, Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795812420; l=2076;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=nBrPMxZDVb3jytbfrX3GVoE3b8fZwhurQBLseC2gUPM=;
 b=tRYhHn/o7+N91YSWuBhi2UyWTbZP9B7LfUTlRwvh3yA0bUcnfoM+Nh7UlM7nmLC/NY5EivA4r
 bEWhIfmsx3pDOT/hk4QPDVT7aCsmRPqOiVARZhhRL7D+iDMOUi9sORH
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Fan Wu <fanwu01@zju.edu.cn>

commit c9273c83885835dbd1e8835d5665dfb8503d65e0 upstream.

cc_debounce_dwork can be queued before port_start() fails:
tcpm_register_port() runs first, and its state machine may invoke
set_cc() or start_toggling() from the TCPM worker.  The error path then
calls tcpm_unregister_port(), whose worker flush may queue the delayed
work before devres frees pmic_typec_port.

Disable and drain the delayed work directly at port_start()'s error
exit.  Do not use port_stop() for this path: its IRQs use IRQF_NO_AUTOEN
and are enabled only after a successful port_start().

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable <stable@kernel.org>  # v6.10+
Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260820135307.153773-3-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted to 6.6.y: call the port's debounce shutdown helper ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This reuses the helper from patch 2 at port_start()'s error exit.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index f0e5e8ab06c0..8e6507ce895f 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -502,6 +502,9 @@ int qcom_pmic_typec_port_start(struct pmic_typec_port *pmic_typec_port,
 		enable_irq(pmic_typec_port->irq_data[i].irq);
 
 done:
+	if (ret)
+		qcom_pmic_typec_port_disable_debounce(pmic_typec_port);
+
 	return ret;
 }
 

-- 
2.43.0


