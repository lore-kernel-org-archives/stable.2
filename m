Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CF2F25F3
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206804; cv=none; b=oesz3wLAU91LMTp9hvl/vHhMvTt7JXM/3wA++mMjtPUIEWLlrZx3R9RuzDA4JdwWn14HvrMviaG8cHupiub5ZvNbUaNvRJw0SwQTqb/PJKMniGR1BI3gRY0D+LlnXKr4OvgfZAbSUhsebWG+X2uNeLg6r05drHRP64ILCvXC+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206804; c=relaxed/simple;
	bh=Pir6115otUDez9Ue8l4G3A3hU1T79t3HMpFIYqugucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA3tqrwO30VhB9uFI0GcNGEUD5NFmt8f0rkmubohmHOnEHIpJ3m8q8atQRN1qRcxiEo7mqgWYy9Bk7yqYtW3Ktg/4M20hyxbKW+QcBPPxC22EKMj20Xkb7bjFKhTYYla/4xTyTSiX/zOusL08/21l+olPzjcP+n0VQJlazBSZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJuc4fNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJuc4fNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299D51F00A3A;
	Tue, 28 Jul 2026 02:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206803;
	bh=q3VhJzM/r2USKmMUGjhWZK7pSjNUZhwoLilzQ4O8Kys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJuc4fNk7TSDgyOPLWqFa7ejx+jLU8rkV6X5jpjZPWqoe9ApwNQsuOVXvzjudhvU4
	 YE+uFRpbRoD3Y4dKfNipcX6XE+UEpi0TV/QTHZmlhdD9kDSiYcY/xlzX1T2FX/IoiV
	 d9ugHE0hGr/Qq9VxVhNfkEBEBQybNuGQo/HjQShaj2qVXuuwVH7z0Sryl+s5xBNNZK
	 mRdZdQr6hSqEfS85h8fJnGN1fzR9DrMTPCTRaV/BrqqSQ8XQUYiqKic8Oceqiun4Oe
	 NfAnEUsJgqz9oSgWuYTlFRKQja8VpbtQX59elASa/TY4pSOr4rk7yJNSdpQYXauvlh
	 qvLMKnKP3YeaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1.y 2/3] mmc: vub300: rename probe error labels
Date: Mon, 27 Jul 2026 22:46:39 -0400
Message-ID: <20260728024640.3058357-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728024640.3058357-1-sashal@kernel.org>
References: <2026072047-sliver-vagrantly-00bf@gregkh>
 <20260728024640.3058357-1-sashal@kernel.org>
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
index 4000dc80f81af8..63286a3a7905ea 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2116,19 +2116,19 @@ static int vub300_probe(struct usb_interface *interface,
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
@@ -2345,23 +2345,25 @@ static int vub300_probe(struct usb_interface *interface,
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

