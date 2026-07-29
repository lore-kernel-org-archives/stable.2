Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAD486BB2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331914; cv=none; b=g4C3bBntjeCKy1D+vkPa6Qur584wyeDlJjGBwXMqJsfm4LEgZTHKtUv+4rFwhi1v8Z+jsyCW9DLqD7z/ZsO0cF6GX9ZjhxuekAFDWBbRyxnnAGu93aT7x9jdAl7hnRNGeO9AjQ4FYb/HBwAUvNPxienHCW5JDLi/3D97auHRSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331914; c=relaxed/simple;
	bh=OBq9SuChFAY/bfFSZ0c4cpbO2JyE7U84ZNbEi7bnIuY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eab5rVp+nc5AIsXpHPAv+E0+JYBZswhAJ5zl2cPVzfBUK1YXzfvtS/ELGvpMB6+oKtQZzL3FilEUMG6q1QohSJjxAZG8DIAgsgV6Pnv4OG0fVOYA2t9lBV5Xuy2ksWDA0ua3Q+bBlGHvyCSfu+jaAM4zMRZF31E6w+L9nbFDaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+WrlHsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+WrlHsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32A11F000E9;
	Wed, 29 Jul 2026 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331907;
	bh=N2oBcv0ueGslaHcY1Fgl6fmZ8CPOVoNqp2dzhHT7ksc=;
	h=Subject:To:Cc:From:Date;
	b=f+WrlHsYaEu3I8gXxC77ny86rrIfivftv1SuixK8ozTvn/DXcsVyFuAjzxIKgfwN/
	 8s4NfaI3UKFbRlwHDvNuJIv87ldV8zzFZvMh97NilqDfEftMWncoHNVFsG6R+tB3W9
	 06Xr76pAfclK/oELdzPWMrt+iiUmc3gYXnpRldj0=
Subject: FAILED: patch "[PATCH] serial: 8250_mid: Fix NULL function pointer dereference on" failed to apply to 5.10-stable tree
To: yijiangshan@kylinos.cn,andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:31:26 +0200
Message-ID: <2026072925-designer-willow-bfb6@gregkh>
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
git cherry-pick -x 7fb13fd7e9a59a37cd911efff83abe19e3ee029d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072925-designer-willow-bfb6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fb13fd7e9a59a37cd911efff83abe19e3ee029d Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Wed, 15 Jul 2026 15:35:46 +0800
Subject: [PATCH] serial: 8250_mid: Fix NULL function pointer dereference on
 DNV/ICX-D/SNR platforms

Commit b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected
platforms") replaced the dnv_board setup and exit callbacks with
PTR_IF(false, ...), which evaluates to NULL. However, the three call
sites in mid8250_probe() and mid8250_remove() unconditionally
dereference these function pointers without NULL checks, causing a NULL
pointer dereference (kernel oops) on any Denverton (DNV), Ice Lake Xeon
D (ICX-D/CDF), or Snowridge (SNR) platform.

Fix this by adding the missing NULL checks before calling the setup and
exit callbacks.

Fixes: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Link: https://patch.msgid.link/20260715073546.1875083-1-yijiangshan@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index f88809ff370b..82656645b8a6 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -318,9 +318,11 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	ret = mid->board->setup(mid, &uart.port);
-	if (ret)
-		return ret;
+	if (mid->board->setup) {
+		ret = mid->board->setup(mid, &uart.port);
+		if (ret)
+			return ret;
+	}
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
@@ -336,7 +338,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -346,7 +349,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {

