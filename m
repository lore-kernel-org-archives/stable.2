Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794637127;
	b=Q/YiZ8IQchs6IrsCcfEpOb1jV/wYNPi6YHStdv5So8uutJyTBkouob08YITx0/WFWL9+
	 OurspFdIGHUg5rrDNd+pA5B5myxR+14jhHgxHNw7McaELWlgSJ3HtOR8F/JtdjEtbwGMv
	 xNZrj+4RZDZohbqXsfH8pMXqswuOLRxcZhZ8tfE6UzaQ3HYpezfOAuE3fuBjlw/RGvl2G
	 AAsrGVa0N3n0RypR28v1CSq79UbpIyYquOf2D32W79ja80T7Qi2unQojQKMYE4FbRvPGk
	 +xdI6tCC3EdnIiHd7lsJ8XOBcQw3JNha2ppwrl2trMdSqAzTR9hbhMQ1XE9SIe115UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637127;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D1K6RfjHoexUQDlwziF7IfSFXpdog1+jA0jVKoSQJww=;
	b=ODbqkLvi224ypueCyde22RBq+3fGel4ORBNfanq1LaS6aHkL+TxDwHcYg+RAiVN6dNl+
	 K3X2QpRUTrMxicdMWU8tUyHASQPaadNfTquJCjTTyFf4tVpys3VLLJ5zzZYv6BKxM15nJ
	 CswszbMTGFki7p+TM69crteAm4MvZXRjqQ0JzeKMP9+k8n3MZ/F2/WFTW+7oEaDcMuMN1
	 UMQFE8Mkr/nTiDi6JQhAIZeWvkvKI+jo430K2BYQDEDkQCiarRaAn1LKRmKIB/My3tYba
	 3Hc/jEjSsE+kzN9/KV0T2PUmmN00ZmXmYx423TZLQHrDxoNg9cYuV2Hp20kNpP1sZhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgtz2kky;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840F606A332;
	Sat, 14 Nov 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgtz2kky
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794637127;
	b=hgWhG0BxKpvRCL7qsJHO5rGxvYnHUNXpbAZV6vfXVYLx8wQaeftejWroxyT5E+sk9BYk
	 zmtrfTW1hRyqGvnOVhY+aBoV0ia3NbwlmJpJuCPCJW1MtAVLo5ZIzTBv9etBeFiqDY75X
	 zN+1jZDEqf8Y+gREJzIjkR31O3oju3SfPWzuLjUBJcQ0nMmi6s6ddtGw4y5gSS7OkYPGO
	 Co57JAhnBH+E1XKuUMqv+RFjQp03SFeK4oE2b7guY0PvuM0SlEY7+91BtxcFHHzZN5J6K
	 CNRXGotZHRrC0m3obqXh0eTC7CjSZqbEbSd7k3Jry0tRUtAM+c6KxWeFwB4OnMqojgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794637127;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D1K6RfjHoexUQDlwziF7IfSFXpdog1+jA0jVKoSQJww=;
	b=Q3Zax3x6s+1SllQQAucI5oj3kDmH55JoFFGqo2Vw5vil55LJG1lNlMGGBHpJqMT0k3aj
	 tgZ3uJKB2meMo5jBFjiv0ZrTcaVkr2rgZ4wHYq8rGUFjM5hKhkz9PEgITxg8IQ1T0kWYl
	 vwNeyy6r7hjOFe7QIntLJP24vT3Avsy+/zKKDQhR9D0tZS5cv6nrIlG+mqs2Np7Scscpu
	 1nwtf9gkrWABPxT6nMPkmthXCl+Xk2rD72aq0lXPrEUVNhDry+PuBvehqDnO2+E1PDLtM
	 thrWWq5i1WAn2YDXxbDpeUYJN41tz3dXhE8ZWypKRS9aT2m7WXs1rpwpZjQoxny7phg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DD0D11F000C4;
	Sat, 14 Nov 2026 06:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794637127;
	bh=D1K6RfjHoexUQDlwziF7IfSFXpdog1+jA0jVKoSQJww=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Tgtz2kkyOS0WERxqyJqNWzH+nmIHsqwO+qNfVzqoY86laYfDjtgVd4zeb4Xf8Jon5
	 46IeWLV4D/8T4O+gSILFWvys/vQiZvn3e5Wn20OKMPAqHSz3/+9K2PGXGuh/caYly7
	 0S8I7uN12jpray6S/txQwXdEb/S/rLVvZ7x1Q3PNSrbODESMsrj61L05+hKoMK9GFx
	 zhnjcmDbVrs5cVh/5xLK+ddXg8bbuhXdGRsNfDa2fhGkm71IwpQxqMa5/PHnR/3VWS
	 G99cu/7WkAX6ueVp6VdAiQnwYuoZtG39hMNj1buUPyUVurDNdEVaxgp/ahJFhUacUN
	 vO7BNZgwg2Lmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6DA5C49CB9;
	Sat, 14 Nov 2026 06:18:46 +0000 (UTC)
From: Haipeng Lin via B4 Relay <devnull+jimmie.lin.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 01:18:41 -0500
Subject: [PATCH] pinctrl: qcom: sc8180x: Add missing dual edge GPIO IRQ
 errata flag
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
Message-Id: <20261114-up-sc8180x-pinctrl-dual-edge-v1-1-aaa31ad633f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqFMAxA0a1IxgYaFX9bkTeobaoBqaV9iiDu3
 eLwwOXekDgKJxiLGyKfkmT3GVQWYFbtF0ax2VCpqiWiBo+AyfTUqwuDePOPG9pDb8g2t66tzdA
 1Sru5g7wIkZ1c3376Pc8LfyINYG4AAAA=
X-Change-ID: 20261114-up-sc8180x-pinctrl-dual-edge-f63c9740afb7
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Val Packett <val@packett.cool>, linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Haipeng Lin <jimmie.lin@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794637126; l=2055;
 i=jimmie.lin@gmail.com; s=20261011; h=from:subject:message-id;
 bh=ERbdkmUDz2DUlOGI3v6R0Snrh7A43j5SXlTHI6jcLqI=;
 b=gKBO3Onq4yWQLKggkZ4qhWRLO385s+dlM+JyVH921I5mfSqSsUQKN2Acus9mH9YvqKQWQZN4S
 lLKzjGm2zgfCsDwuiqJRwY3j4yLGk7FDn8mhdiAv2Hr9Oa4jskvFxOa
X-Developer-Key: i=jimmie.lin@gmail.com; a=ed25519;
 pk=3KDRF1RQ/9A7ZUVTdRVEZnVrGltdmq1bRocsOYeXezI=
X-Endpoint-Received: by B4 Relay for jimmie.lin@gmail.com/20261011 with
 auth_id=1164
X-Original-From: Haipeng Lin <jimmie.lin@gmail.com>
Reply-To: jimmie.lin@gmail.com
Content-Transfer-Encoding: 7bit

From: Haipeng Lin <jimmie.lin@gmail.com>

Wakeup-capable GPIOs on SC8180X use the PDC as their parent interrupt
chip. Like the SM8150, the PDC on SC8180X does not support dual-edge
interrupts, so dual-edge GPIO interrupts only fire on a single edge
unless emulated by the TLMM driver via wakeirq_dual_edge_errata.

On SC8180X boards with a gpio-keys lid switch (e.g., Lenovo Flex 5G,
Surface Pro X) this causes the falling edge (lid close) to stop trig-
gering interrupts after the first suspend/resume cycle, preventing the
system from suspending again when the lid is closed.

Enables wakeirq_dual_edge_errata for SC8180X. Feature tested on a
v7.3.3 tree for the Surface Pro X with this patch applied, the lid
switch on TLMM GPIO 121 (PDC pin 89) now works after the first resume.
Without this patch opening the lid raised an interrupt but not on
close.

Fixes: 97423113ec4b ("pinctrl: qcom: Add sc8180x TLMM driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
---
Hi, 

This fixes a lid-switch issue in SC8180X identified when trying to get
the Surface Pro X to sleep/resume when closing/opening the type cover.
It should apply cleanly to both fixes or devel but I based it off 
pinctrl/devel to send out the patch.

Thanks,
---
 drivers/pinctrl/qcom/pinctrl-sc8180x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
index 062cb913e5ee..fef21b2db57c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
@@ -1597,6 +1597,7 @@ static struct msm_pinctrl_soc_data sc8180x_pinctrl = {
 	.ngpios = 191,
 	.wakeirq_map = sc8180x_pdc_map,
 	.nwakeirq_map = ARRAY_SIZE(sc8180x_pdc_map),
+	.wakeirq_dual_edge_errata = true,
 };
 
 static const struct msm_pinctrl_soc_data sc8180x_acpi_pinctrl = {

---
base-commit: 135fd91896455cd1b611a8ef99c35df8ba9c17df
change-id: 20261114-up-sc8180x-pinctrl-dual-edge-f63c9740afb7

Best regards,
-- 
Haipeng Lin <jimmie.lin@gmail.com>


