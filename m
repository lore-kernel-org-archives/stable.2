Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972A264A86
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465036; cv=none; b=AtC8i0Z9MVgvM+EkMIPT+fJgBq0GdtOQzG77s1mPbI+G1ecVG+rY4pAlLx7YhoXB8j2bhlB6jqwfx5idff6yLRflx2CnduSqI4ulBPfcfuto7/dOoRg8F1XGzq3ocR9E+3UmQvQbo50+9aAM4v8RbJ7HPU57Y3kaGyK6FAbE/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465036; c=relaxed/simple;
	bh=owZVE8Wq/4Gs2v50OotS3hkEUZ1DLUfv0RhEFg59vIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qulTmhlR5+i1P3P7RCaoSyvSCDGXhHgmA5A0Ean/TxnFpk5kSfs+i3FZbdkbrYbw2ZcQdspJeRkYSfPDcCAKcpGD6wRxDfGCnOXA/Hl8+Ap632tPL3JuzstD9M6Ph6Wo5N6zw9MYuuX85fhh4yWzhHfYQ6kpXn1q0MHDt1OUWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbNP61e6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbNP61e6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8409F1F00A3E;
	Sun, 19 Jul 2026 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784465035;
	bh=DWvDAAY4IsTZxT/8KAjIrOwKNo20+QWXP3SXptWbfgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lbNP61e6EYgoSLIz8gOrU/Z9j84pCQ9MW19+wqBmUeqP5EaT7IwAEm1ySzO75hJ4o
	 a7ULfCKCEWu9WnwfCUcCNMK3eJaCH6NhH+3fHcniX5/o9sX/pcW9hOZIgnpz6yCVSH
	 399f/P1F2QWuBLyokTXwe/71HfNDsqAoS5reG660Lh861dwKiE3cDlnPLtQ1L5e/pZ
	 Z3D9f0YTVf/Z1WeJixa0R1nV/y7cE/ZANfGyBaUwUsTFb/WXNPt5ja824CKZYLiG9z
	 BYPvN+shwxyXV15l1ntsqiYaVvD+rkIa/LjYuCQyJl90G/EpES1cU4CTUJ5ly0HCy9
	 sRbMfkqzuE9Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] usb: atm: ueagle-atm: use dev_dbg() for 'device found' message
Date: Sun, 19 Jul 2026 08:43:46 -0400
Message-ID: <20260719124348.3646001-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719124348.3646001-1-sashal@kernel.org>
References: <2026071427-sulfate-await-a368@gregkh>
 <20260719124348.3646001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauricio Faria de Oliveira <mfo@igalia.com>

[ Upstream commit 05c5075c3115010f97434c53d353d9a0d4b0e64e ]

Convert dev_info() to dev_dbg().

Per 'Documentation/process/coding-style.rst':

  13) Printing kernel messages

  ...  When drivers are working properly they are quiet,
  so prefer to use dev_dbg/pr_debug unless something is wrong.

While in there, correct the verb form and add 'with' for clarity.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/all/2026051628-squatter-stature-c0e0@gregkh/
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260520-ueagle-atm-cleanup-v1-1-010c8bc7b214@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/atm/ueagle-atm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index cd0f7b4bd82ab1..43d966c855fa0a 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2589,7 +2589,7 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	int ret;
 
 	uea_enters(usb);
-	uea_info(usb, "ADSL device founded vid (%#X) pid (%#X) Rev (%#X): %s\n",
+	uea_dbg(usb, "ADSL device found with vid (%#X) pid (%#X) Rev (%#X): %s\n",
 		le16_to_cpu(usb->descriptor.idVendor),
 		le16_to_cpu(usb->descriptor.idProduct),
 		le16_to_cpu(usb->descriptor.bcdDevice),
-- 
2.53.0

