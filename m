Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762087;
	b=LrDc6yGpQI8rDpt9VqznhM5k+jCpQa0lZ6foWCBb14pmj1ef9qM5htQZMZPKSL1MXQRp
	 O0N8Lf32GTEAweaqm3JmF53CrgG/PhovrtaB8KuJda4T17yXZYgMxJ9ONZs0nvx1wQ/Mt
	 MiUXU/h1RF0KO7NdNd8zeEIO9hPLGczaZdK84QnVPP1HcfDfkk067mY1fZHds+yMHbFuU
	 opU2NO4vqj0AE+l6LVBCYVCj3jmP8g03sMK7n9Af/UEPwmTLSmvmshEu6M+Wge4ezHLPd
	 oUqEI6RpfgEmpbIDlnmk1+pI64e1ed2pT5h+tt2lAb8DnU3x5zEK1EbSVT2JF8tePgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762087;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=mFMAfJUyv5fMJSPeR0DdyM+SciuBdAnE7Ia8wiTHRnQ=;
	b=0r20VAe1eUowZf+JwRzexRer4SPJYKdu3Ljxqzsn3o7QucWws8bY97lzOxIh+NqmFPBz
	 wbZaixEgJliylw3A9es0mTK1quL/O3faEUvVmFhWbmZq/LEc+sqAQtR/HIB5TrLe1S00U
	 0iiTteOXdMOZ1SNayUJphT06TYI96UXUXcHbjW72suz9MHAYwJCLu5AyKwxs/uZPZVVGw
	 04wAbC+qbdErl9NkcEAihafMuyKG+xCWX4UP8gwTXJklfn9sdM/AuJcfG1TPpb7qMEne0
	 moks5YpzaKnvkMyWO7xCEm5KljcP+9ZtHV/QrK+ukFhtb2y8WUBEefRubrkVgAU6sNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvkMOYU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D7606A326;
	Fri, 27 Nov 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvkMOYU7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795762086;
	b=vAKrVGbewsXQvW92F6bswf7tFBUOPXJbX2YP9BYwWNU0/VLbYKrC4h4MALnyFWROHwPq
	 9E5Zq9xcCjdU2nNZhssXiDr3rhYJ8OLCn3eYNERbHiTmhVUIzIoSs7dNbXX0hEeqAIeI7
	 SWMmwl6cXQFRTDO/6fwO/jlrfac4rFTBvy/64FBDIjKFkVXLGmolINIpTWKjv9F+NI8Zp
	 kHSrcnnuzyHw93VYi3BY0L4imN07qd2VH1Rr6GJEpoJwuE2XJg0TAaDBLK8vQtJVcDKxO
	 xpJYPbAE/6Rru0bDbAb3Q+GjfXEnkd9Fi4pHO/dA7XPUbngG811hn8KNS9by5YKVe3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795762086;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=mFMAfJUyv5fMJSPeR0DdyM+SciuBdAnE7Ia8wiTHRnQ=;
	b=iDhqJfD6OheLIMBFQogYIkxxdCcI9U2cl0DI3vRiuZ0mvN/zf7bqjicRyTEPiHVy3R9S
	 jvqYCd8GZ6gLr2afEzMEMHtx90562C6VmBEoEKa+aKwvETMER0BZnOZmhIAwYuwnBOiLF
	 9SgwLLx+xReLlg6K0CGMS3aOA1MlDDmmAqBHPBeL2dTnIcZU3MrJjENPklOOTMqrUcu9Y
	 48tQEkFlMe+FemkmIteTXwRRokBBnsSPymtw0hDqdERUq+E5YIPWPmCSXrfYjg+wdywM8
	 wU8ZiKDSS0hd0xzEJ0Mp1EWdMS988RuOLetD8FcbfFxax7vUv9G1WsBTk9jR61RxQxg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2BF691F008A0;
	Fri, 27 Nov 2026 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762086;
	bh=mFMAfJUyv5fMJSPeR0DdyM+SciuBdAnE7Ia8wiTHRnQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=SvkMOYU79rjPmH1xuzLGx1IEyJHxjsGwALm0sjnNuPHJeGMrMgG5vgMy/gNdEpdyt
	 trzmRIiZil5kTXg7NUYoTuraZzZot2xiH5EzEm9YWgOq/5SbZnAgrD7fqoHSFYSCHi
	 Eb3wFKCdEa29kKp2wJouiMoQKTsqq7l0dv+R01wfJBWw2MlvkvGnGDcyfKrJesAv+H
	 RaoFID5OFzI8jNVbZwj8BzT9Ul6DyLTfMSxWG0zUM2g2gwMCGss1XhqK4vvQslh2PF
	 2YgqZyl8ZPeSBQsUWNUIsoc+kl5cefa1sfh6KbAJ2tojfCHJoLNAMj0K6Fco4GyR5H
	 N8G8FR/iuG3tA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 026844B5ED;
	Fri, 27 Nov 2026 06:47:48 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 06:35:09 +0000
Subject: [PATCH 5.15.y] PCI: Free released resource after coalescing
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
Message-Id: <20261127-so5-pci-515-v1-1-58c7cedf2a45@certik.com>
X-B4-Tracking: v=1; b=H4sIAJwkCWsC/02NzQ7CIBCEX6XZs1sBQ237KsYDP6vFGGjYajRN3
 13Qi8f5MvPNCkw5EMPYrJDpGTikWILcNeAmE6+EwZcMSqhOSnVEThpnF1BLjQch/NAPvhedh7K
 YM13C62s7gW6lbt9w/nF+2Bu5papq0xomtNlEN1XEFP2S0h0r3/9dwLZ9ADz0FIOjAAAA
X-Change-ID: 20261127-so5-pci-515-300d989d806d
To: stable@vger.kernel.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795761308; l=1901;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=Q3ipk5VBhPFIagCrOUrYLKD41qorDNeCk/xbTMJ0NYs=;
 b=g31RX7ICmsUEZ+CZFUWSl48NbQylBjFTR0E9pdvUexHT7lguAnw/pRaFit0c2bLmDD00pzQKA
 ZO7cswPFJrxC82GV/aHHstfGnnqpCmbQhufcf0GThnzs31Beef2+CXu
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit 8ec9c1d5d0a5a4744516adb483b97a238892f9d5 upstream.

release_resource() doesn't actually free the resource or resource list
entry so free the resource list entry to avoid a leak.

Closes: https://lore.kernel.org/r/878r9sga1t.fsf@kernel.org/
Fixes: e54223275ba1 ("PCI: Release resource invalidated by coalescing")
Link: https://lore.kernel.org/r/20230906110846.225369-1-ross.lagerwall@citrix.com
Reported-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org      # v5.16+
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.1.y and newer already have this fix. 5.15.y has the coalescing
prerequisite as 26277a425020.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of drivers/pci/probe.o, base vs
  patched, no new warnings
- booted the patched kernel under QEMU/KVM. I didn't have a PCI
  topology that hits the invalidated window path.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1403b1e50142..d5db12f13a22 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1001,6 +1001,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		res = window->res;
 		if (!res->flags && !res->start && !res->end) {
 			release_resource(res);
+			resource_list_destroy_entry(window);
 			continue;
 		}
 

---
base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
change-id: 20261127-so5-pci-515-300d989d806d

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


