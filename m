Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06492476072
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196063; cv=none; b=pThw2C8rq7mTMChC2F9yBq3eEFSyLmr3bmjgbSy6kQqIhZxlTbqqEWVY4Ml59Pe2Nz+CjnpkkN3jLluCwLL7Sn+vMK34xSg7uq7Pts8sUt4ohN/XqiQWCLZ1pa/bh35dI0YJaqIm8kKlv9rFrQ6mfjhkV1uOnC4umkPDQo54L30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196063; c=relaxed/simple;
	bh=ziNYgPO37s2yZvDjUJt1KkLhe3EemJ8mSb0KXcZJZj4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DAIBnZ9Wgkk332h5jKViHzeXw8ZDgU6rucxYNM1Lem4+U1W3rGs8dtJeULDXtscKcf0LomKSAq6Otbq/pwYo7ei/DuojEEJvYe1De/P9/s8e7woSAVO1iqaNqC0TUWUE+3vYumBz4HOlcjOcDhDAjLBzzT57eOWm7dW532xmvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1AgFhhoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1AgFhhoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637641F000FF;
	Mon,  5 Oct 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196061;
	bh=TE1Qgki21vfZbekbCEjIlcWGFGvjERGiRyCiPed+T+8=;
	h=Subject:To:Cc:From:Date;
	b=1AgFhhoMomlrKLRazUZXRZeJcoWo2XykpAXiabquVzWb2kjJwEZtrAWOUZUq15iLK
	 ZQpvbGyXolLg3sVE8phVXoYj5C7fQJ/tjsgaemo3SkihwtlwjxLzkjRgdHhcHEnzj3
	 jZrGet+PtamPOGD17y35Yihee6ywa7H8URFg21mQ=
Subject: FAILED: patch "[PATCH] EDAC/altera: Fix memory leak on dci allocation failure" failed to apply to 5.10-stable tree
To: dinguyen@kernel.org,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:27:25 +0200
Message-ID: <2026100525-punctuate-diaphragm-216d@gregkh>
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
git cherry-pick -x 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100525-punctuate-diaphragm-216d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1 Mon Sep 17 00:00:00 2001
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Fri, 11 Sep 2026 07:06:26 -0500
Subject: [PATCH] EDAC/altera: Fix memory leak on dci allocation failure

Sashiko reports:

"If devres_open_group() fails, the function returns -ENOMEM without freeing the
dci structure allocated earlier with edac_device_alloc_ctl_info()."

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260911120627.2634225-4-dinguyen@kernel.org

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f4..ccdfb35178b6 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1516,8 +1516,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;

