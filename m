Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FE40F75F;
	Mon, 27 Jul 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158363; cv=none; b=Dzslf1zjf9GrNIBxISQLLADGP0G94yTIO3lkIhmyGpC2EzyLoh4zT4NZWNS4M2qn+Gh9N9yLyYkniBc2sWLCoEInZVLzbnyHTWT8QM4aYWT+aMgOkOUFMu9eE/7qLix7mBx0MbEMfx3TYfIye5ceHXgQMuaIto/Rk0R65G00zB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158363; c=relaxed/simple;
	bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRP52CHJJAQZfiWK2k92Ew4WECls/qIb3bO7xB+RRP+LpoQozgAm7UPL3ir6IC5Kebh2RNb93Aw4TxYApVPCL5beKknePks7P/R7s8+CR5otxy5TXS9SdtnAhAAV5Hws6GDfaP0seIEcetJM6VWMe1Ct+whxwWp2eMOEdmVx1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=s7RNka83; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=YbHK2+Cf; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="s7RNka83";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="YbHK2+Cf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158354; bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7RNka83HYJQpenFCHP/n65+dJf4pYnesKC2eTme/hhld5qpMJpVc0DihN53N6nbt
	 7cwEZPNzjczaBW1Y17uAqRD4P8OGXUeYWis4CxkIfjkJUkuHrLHnydMN7nO+DLFiTa
	 SJVfouGvLes8Fp8R6l4H3XUAiGqnn2DLjfQadjxp0kGlt6vsbuu+NYmlMzN1e9nrFX
	 oBR8U3oK/bgxt8EsXbMRFb7gz37ja6KekAlrjvXjkuTay8AedJaaVJtwYH/H/qKIiX
	 Sjygf45LGfSkaKeQxFtpWMCY04FdzDK2IE1M/5RexN9lnt4sRgMN4iIMTFjhSss+Ig
	 wu8IC+q5N8HAg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 71E7D42532; Mon, 27 Jul 2026 14:19:14 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158353; bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbHK2+Cfi9Z7miLpzUB6T+UBL5QsurCX5ilQk3Izgd7SYrAlGgRwvxSWujO5l+3B4
	 BSOM87ui4IJe83APGGSIUk6flo1NGQfT08TLa1KeIxj01Qor0RBtsNGqtK905798Ue
	 JOnvh9ttOMErzPiAnTPwVfwYpFieO1caAaeANEv9NuVd7EmqXkFWx863j8G2hdEMBS
	 X7gHvDxEJvVIvvxqgF6N05UnxXjsPske1Pgo9/x+PZAXO0WDImf+vl5mggCa2PLO0P
	 QTXfz+msU1XOXmm8XZM0SAhxHfJoDYWEnYAvUWMLNKshiFsZn6qB6lAW7SDb23YlYN
	 H5GKRJ/Pngk1A==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 9C03342532;
	Mon, 27 Jul 2026 14:19:13 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/15] media: redrat3: Ensure all urbs are suspended
Date: Mon, 27 Jul 2026 14:18:47 +0100
Message-ID: <e599d9b8f7f52c0de46f7c8a543439dc03a5b78d.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the learn urb is stopped before suspend.

Fixes: c49fcdde38cb ("[media] redrat3: enable carrier reports using wideband receiver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index f86efcb74e6e..994d4864520c 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -1170,6 +1170,7 @@ static int redrat3_dev_suspend(struct usb_interface *intf, pm_message_t message)
 	usb_kill_urb(rr3->narrow_urb);
 	usb_kill_urb(rr3->wide_urb);
 	usb_kill_urb(rr3->flash_urb);
+	usb_kill_urb(rr3->learn_urb);
 	return 0;
 }
 
-- 
2.55.0

