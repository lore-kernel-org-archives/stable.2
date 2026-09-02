Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0E38B135;
	Wed,  2 Sep 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376803; cv=pass; b=Rgp7rIsGFCpYiev7x+0jRZ+jIRjrQv/TZCgVkNy4Ka972T1zEd3Es1j+pezZvUS5S9O3Y0D6wnYhop6hjdkoTL7vyr2e3arpcVsiTbS8E52VsWi6IPbdUU9Psr5J2gg0889jMS7a8sfE2EEE5sphpeuOQS+NZiqqV/T8ewN4gxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376803; c=relaxed/simple;
	bh=qslwtQeUUaTQzvPKju50nUmCLIw2Z5Yl7UxgaSsqaG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bpnhp+NM6QyKh7SUwu31fb6XSG4gz2VPXjypxbNG375fCXb2LRKQtXgYcVhiCWGSufaILu/adqLpQEFQeda9V2LYBu/75x5L33nc9GgwCUZ/CD7TnXQEqrTGANm6X0aeBVFhyVBO9gFFOk/dCOpQvz8Z3x2tlA8R49Fjg0wakrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=VgB4OwTj; arc=pass smtp.client-ip=165.173.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="VgB4OwTj"
ARC-Seal: i=1; a=rsa-sha256; t=1788376792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Auc4NwNnwNXT0bwwNezyKkbt5uVQrgc62phXv9RFWr27oAmitf1ZxvE+Ae/lKuqhCDkJinaMpqWnXhJO79Opn/VnSEgBjDi6ibho2jg6n1cZ+ZBtuFHQ+O9aN2Q9sWjt0fUPD2PqFoKOpermP6DS9t+ZjyA5lXJEJY7EHNADJrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788376792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A4TN0EGlAixn51ctK1pBKOTifz23t1iEOGpO04/pP0Y=; 
	b=i/KevU9mzFcK3C5mhDKMur/OPjdt1B9MhqLP6Kw2wFGaW9OzaX88RBFo8afsmJrWzzDDjbPPr50qjeL0ksKKzuptZ0qjW+R1haukONZolPIyDIWnyPvKo7q9E1NWA1HK2/ENrx6F1A3NA/Yw8IwHSeRlTaaIEWY5piaAqZ7QpNs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788376792;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=A4TN0EGlAixn51ctK1pBKOTifz23t1iEOGpO04/pP0Y=;
	b=VgB4OwTj/aCNRtXe4b143D1gFt0WP0kZ+Zb1M/g2bQD6fjRigxcykELXHnquOLsZ
	CkXMYIleq0ASzSAwd/H3ATNjozuYRVr+6uUBHLRqEbKwwcaZ+LvT/V9uOXPRW3nvBAx
	vSAtHPLY7DhHQz0hDvKq5ejyTbs7tn3PhwDNcBY+Q83rDAbr+pkN2kDG2C5FV9NXOqA
	72AFBp8h3WmI4Gni5whBqMf0NmbK+TJp0+C/cwDCjiQwNYJnE1epiPE+eX8Z/6O2DQe
	IZtJETzEF8Fm0sQcYw03XbLQcMjZRpma/4v4wSan2MW2v4/BdBesT3RJXww4blsIutC
	THwb6Or5lg==
Received: by mx.zohomail.com with SMTPS id 1788376788790480.32971094536117;
	Wed, 2 Sep 2026 12:19:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 03 Sep 2026 03:18:59 +0800
Subject: [PATCH] Bluetooth: btrtl: Don't leak return code when parsing
 firmware format v2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-btrtl-fix-patch-sec-header-rc-leak-v1-1-0ce37e2149bd@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMBCE4Vcpe3bB2HrQVxEPm83UREstm1SE0
 ndvrMcPhn8WyrCETNdmIcMn5fQeK9yhIY0yPsApVNMR6i5BPPtiZeA+fXmSopEzlCMkwNiUB8i
 LXXtuOz0F6fpANTQZ6n4/ud3/zrN/QsuvTOu6Aeeu8bKGAAAA
X-Change-ID: 0ec19dab-btrtl-fix-patch-sec-header-rc-leak-13534c2da4fd
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Alex Lu <alex_lu@realsil.com.cn>, Max Chou <max.chou@realtek.com>, 
 Allen Chen <allen_chen@realsil.com.cn>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-1f2f7
X-ZohoMailClient: External

When key_id from chip is zero, rtlbt_parse_firmware_v2() intentionally
ignores all security headers. However, the implementation simply breaks
from a switch statement and leaks uninitialized return code `rc' (if the
first section is a security one) or the previous section's `rc'.

Fix it by really skipping a loop with `continue'. For consistency and
readability, also do the same for the default case.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/bluetooth/btrtl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 03fa9409e3ee..d29813331603 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -591,7 +591,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 			 * headers.
 			 */
 			if (!key_id)
-				break;
+				continue;
 			rc = btrtl_parse_section(hdev, btrtl_dev, opcode,
 						 ptr, section_len);
 			break;
@@ -600,8 +600,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 						 ptr, section_len);
 			break;
 		default:
-			rc = 0;
-			break;
+			continue;
 		}
 		if (rc < 0) {
 			rtl_dev_err(hdev, "RTL: Parse section (%u) err %d",

---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 0ec19dab-btrtl-fix-patch-sec-header-rc-leak-13534c2da4fd

Thanks,
Rong

