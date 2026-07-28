Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBE25A2C6
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200296; cv=none; b=QMSHT2WlkUOj9mCPqXnfly46MnxUfBYdA6wDwLBq/VQOjHBIEYDwYfaLeOtUtawl1Zbil1sEzzZkUernr5EnO23vrlIG0BWiHv69Ynrn4H9ldN988Bb6CntneG+3z6L7t78RsO9yfBfF2gh1VMR3Dy0ovYERIDejnGSJKTj8glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200296; c=relaxed/simple;
	bh=BijC++q96z9Ez58u9h0MfYLM2eHhIEZMW9LSOoIJYtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb4fu3stIuLxKIm5TsRT1mZGth05Bv9JjHCl53Qs2PuxEL7QngVLKcVcXJQaqxveJ2066FkAALwT5Mzf+wn2ZTJuvRw8TKDulDZi8dQa1t2vOcEvrS6D3aJuZi7gBCyIkfLBxsBDzcHW11j4YcpPIdBpzxVC1mmgBlSIDxcJrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUo3ZOVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUo3ZOVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F851F00A3A;
	Tue, 28 Jul 2026 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200292;
	bh=f/yRduCqAnY6wOK09mvi4jx0w/fprDmMdXsiEN2l31E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUo3ZOViACcAe+QfGLO32pNySsEjDu9LTUBj5KsybvmI3dtkPhAnmg+kcjCZiIdfQ
	 HMCQEun4kjq/Oum7oGX1guFFWXC+9O4zThvO4TogUjjpI7JgVceoUmqGxaHDJosNKO
	 lKrSkX28YOE0b5wQjxoA1CeWo0ZddJMBYq+1ay9s5wUrq2+xEndr72GyyhaewoUCJY
	 4p6EXCvZhL1vn5rzEgZFEJ6X6rNzzAynINOcK6zHZnc5uAsOP86zq4Iln/vEd4eyuW
	 MCcCuBP8Gbfo0BLy6NJtR6f6x+r7/rfxbTptKWHK1qT4OC/rR9QoFXHvkPejDQtYz2
	 oSItDC7DA79kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6.y 2/3] mmc: vub300: rename probe error labels
Date: Mon, 27 Jul 2026 20:58:04 -0400
Message-ID: <20260728005806.2694893-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728005806.2694893-1-sashal@kernel.org>
References: <2026072046-elves-jokingly-9d77@gregkh>
 <20260728005806.2694893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

Error labels should be named after what they do.

Rename the probe error labels.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 5b8b35d6f4fa758dd5e8ae18526ea1c73f6787e0)
---
 drivers/mmc/host/vub300.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 3ff40fcd62a46a..7ff7218af6cc01 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2114,19 +2114,19 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		goto error0;
+		goto err_put_udev;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		goto error1;
+		goto err_free_out_urb;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2343,23 +2343,25 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_delete_timer;
 
 	return 0;
-error6:
-	del_timer_sync(&vub300->inactivity_timer);
+
+err_delete_timer:
+	timer_delete_sync(&vub300->inactivity_timer);
 err_free_host:
 	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
 	 */
-error4:
+err_free_res_urb:
 	usb_free_urb(command_res_urb);
-error1:
+err_free_out_urb:
 	usb_free_urb(command_out_urb);
-error0:
+err_put_udev:
 	usb_put_dev(udev);
+
 	return retval;
 }
 
-- 
2.53.0

