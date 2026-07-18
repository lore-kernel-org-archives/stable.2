Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12139339708
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411437; cv=none; b=m+Vat6Ab8h0RyMrOl90tKitIixKYeyiS6y2SLhbSaTTVwwdRGbS241G8lN0GB41DDisZDe2adaSkTXmXz26O29hxp8Ps6EV1gsdza4CRrU3TvkeLo+orqJelk/MTuhJlPbkFMZp8t+oPQ3BNRF6UeghJgieBhROwwSnEMt9L1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411437; c=relaxed/simple;
	bh=vfyazkwtvGlkQ7JxXjx977GwvliQh2if27DOCdLJ6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyE3DGX9pkylAf4gv2oQu2DLd5ltuptrcbL58USGxP4fzo52P+ItrzdeqUDdYw2XLBeAL81z+yPy1ftVZx0xllLgIZxgPHCYHQXWujcPxrLzIkUJ7xgmkDuSPKrngul+Bss6ZXXauDZlqzCsJxElW2JTbA6EzdXVX/dNiLuw3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Truuuk4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Truuuk4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E61F000E9;
	Sat, 18 Jul 2026 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411435;
	bh=RoUQIhsyNhsLxTvajSUx0uKecAXtZN1YsIfyns9ML+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Truuuk4vufvwq8vrX2HR2n2OBgsE06WlZGy5EzrxY1T2LoA5IK2mePkIK5/Dxbi63
	 /Fx0krH6seNW5FjqfLxLYGwWsFdhkhgKSOo9X/DowVDPRB4Zb5veBS7tAFINaGP7NZ
	 bEAVrpOB/ojQnL8QfgG4IHC+pG44C4sWmt4LqezASQUbsrdgnjEeC6qr+1/N2DSipa
	 aoZR4GyjA9H1+xxPfdudZM3rjZhhenALunx47JB1G2q+dKCq3fWI5ez69gLSZekM9T
	 hcSnXr9wl6HAwZwwdzBBo+XHiDt0Z0qCsyTzounfVHVubce3ZCT0kVoHlVJtR7v1Wc
	 kVk2ztS7K0LyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] usb: atm: ueagle-atm: use dev_dbg() for 'device found' message
Date: Sat, 18 Jul 2026 17:50:31 -0400
Message-ID: <20260718215033.3447737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071426-neurosis-lumpish-e192@gregkh>
References: <2026071426-neurosis-lumpish-e192@gregkh>
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
index f3ae72feb5bfc3..71559a934133a8 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2590,7 +2590,7 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	int ret;
 
 	uea_enters(usb);
-	uea_info(usb, "ADSL device founded vid (%#X) pid (%#X) Rev (%#X): %s\n",
+	uea_dbg(usb, "ADSL device found with vid (%#X) pid (%#X) Rev (%#X): %s\n",
 		le16_to_cpu(usb->descriptor.idVendor),
 		le16_to_cpu(usb->descriptor.idProduct),
 		le16_to_cpu(usb->descriptor.bcdDevice),
-- 
2.53.0

