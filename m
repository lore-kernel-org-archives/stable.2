Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F5495ACB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069491; cv=none; b=FNVNhEX/ZFwaIx1TAmWkSPmlfBrIh3bHP4lMFcPuU+A38+upYph+A86Pb90GPL705Y2NkCRZEdZjOELGZiSvHU5E+BdPiQzxXy/sYLbWjD+vrLiv8IM+z8psnZ4S+Fpg6/TgCR6K+opqdhcmECSc4T0eGs10Ql+hSHias1e6a3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069491; c=relaxed/simple;
	bh=i4OC9tNxEONK3UJ47m/89liS/etDNEUy6A3P8O2bP9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh1Se77Y2CBUpvfL3NaK2V0IKZnjg9mqb6LkLfX0Q7FMMyHIJkHj2oaSpdwCasYrAt7pl0UvpZC+JWDN7nBawB8uXoSLzVuQ18odP9MpnTD1DkMBaRsekRoPZyWR/3yx7/NZHMNZsjztOh2R4FRMdyTZaQwDGcdUrLsNSrnp3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPG7OrNw; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPG7OrNw"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2d8fdc579daso43624875ad.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790069489; x=1790674289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeXwpq7Q2HF6GXy21WP33oJct9TNeHbmlRru5hr30uc=;
        b=ZPG7OrNw89Ql0ckmyWb9BU/lSS28OdBzUTejWW/3dK86of03atWQFNDFqZ6H/xQchE
         DhrRDrEpwypyrmveiq+G4IvA1lU1/yjEJMRidqmKPaIx6wGsKALxeIh2oTP8tTptaAxQ
         q5BJA4q79fypzdY2S8UNEk5qPoV+BAzwhC4fysqZOD489UAITFIkQC6NufMZ2KQBanqe
         Muzv/CYAna3z+mS1QbTIf+z1pHhLbkw9wxFAdMdySHjVnk9xeF4MEEV3B2g3/vY3eLbI
         41BU0wCINKKJJ8QfVeEiRcoC/ZTADV/yxwx0uQ15/LJEGU3sQc0MzvdIEKr1rzin5Nhb
         WXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790069489; x=1790674289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeXwpq7Q2HF6GXy21WP33oJct9TNeHbmlRru5hr30uc=;
        b=rPHkMR8cxfJZR9CaQC6YZzo7CFEDfVZ9ViVE4P0SD+qs1w5ZtSzfVcFoazkiDBN4jh
         3L6Ohacyy07pMWl4Ndx4rtxnZVTm1+16XyjuX8+SZI6neNhH4RVDwZLAbflqkM3IZiSY
         3Ytd7xnzmyissoQ3YBfRKc+KRwdy9W73Q/0DtH38M2bypNUApZCLREzQt/jZlmF5IXh9
         IEhS7ZpCV3z/OUb/4oGkKYb+jfDb9k1w74y03ZMIhU4K9EN+wAgxet4V4GmMYhZ3MDOz
         VCNXj2zkMmA4fraFK3IxX2mcCZ6WZ1CPidq68rdqQuO4gU1XkN7livmVw7qjqZ/IyTlt
         2P0w==
X-Forwarded-Encrypted: i=1; AKwUvBwKIifhCNN/cW1cTR0TVcjuICJfmEJ9VB4gQ2/ANmKCQhAxkfaScEL5d+ibHn07tJr4tBaysZA=@vger.kernel.org
X-Gm-Message-State: AFuF++lblcynXXqTJU+bjDuhXGBEaJrWYWcZgztBoABYz0Oi3y81F5nG
	/9pWZIY/sgFB4NteNgtraZ2704nYJNdFmuod3qUSG4yQ6leRM3EM9BDQ1CbI9PY6
X-Gm-Gg: AYBFou0eM0uGLuBCC5mpZNomWMNwQptCuF+BbKSXisEwURKYAB0tgx7XOk7IU7qt1pV
	WaNUs4zN9UaQ9QitLRqieA6bqu8QK0IcYLFqn/lq0wYq25zcsi4dW326VqyTQMmYmZK7FIhTzH2
	Vc1/2GBHGrW3X2U1VgUqv9EwlOCmm8hlieY+9CCRPBFL952ugIVto/xkLERarfw00OiEueUWuh5
	bApoDAIBJ9rD/CSdv1UeQn4dVpb6SwqNiMVHhwUUnDXeNy3Uze1KzzXyYsudlrH+SoruzDrIGjz
	yDZ1I/jsDYRQAGIAjrFhzSZG3flRPXQu5+JogNFT1v1BWIVi5zlqksb5zoGN/q5KZry19SiOZtk
	LCE+rpbB2Sn0iDt0L3Z0PSLFviEJiXFAL3KbabkXSdHrxb0tx3bCnioR4KzsyxYl0nLM7eGr+kn
	em9mrZzQCJNOZywNvVvFlwlaZfM5W8A0o70eXjow9DkSZt5RybgDqvRn2faPdLLz/y1925cx+ob
	J99wU0bzGGoTLKJDJezkk3fKOM/lzlfezJ1ORiSPndj4967Gy3+3+xJyxQPsyx2GLziJcJRISr8
	rsFbH44uPA==
X-Received: by 2002:a17:903:8c3:b0:2dd:c100:3133 with SMTP id d9443c01a7336-2df60b640ecmr6299945ad.47.1790069488860;
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df63a22f54sm103915ad.61.2026.09.22.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Hui Peng <benquike@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Tue, 22 Sep 2026 09:30:24 +0000
Message-ID: <20260922093126.141969-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922093126.141969-1-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
bytes into hw_attribute_value without checking the caller's destination
buffer capacity, overflowing level on the stack when hw_attribute_length
exceeds 1:

  BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
  Write of size 16 at addr ffff888001907780 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
   ca8210_get_ed+0x9c/0xf0
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 48 in frame:
   ca8210_get_ed+0x0/0xf0
  This frame has 2 objects:
   [48, 49) 'level'
   [64, 65) 'lenvar'

Initialize lenvar = 1 in ca8210_get_ed() and return
IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
response.pdata.hwme_get_cnf.hw_attribute_length exceeds
*hw_attribute_length.

Tested in QEMU with KASAN enabled by passing an oversized
hw_attribute_length response into ca8210_get_ed().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 2/3.
- Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
  and an upper-bound check against *hw_attribute_length in
  hwme_get_request_sync() as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index a990a0f..8aa7ffe 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
 		return IEEE802154_SYSTEM_ERROR;
 
 	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
+		if (response.pdata.hwme_get_cnf.hw_attribute_length >
+		    *hw_attribute_length)
+			return IEEE802154_SYSTEM_ERROR;
 		*hw_attribute_length =
 			response.pdata.hwme_get_cnf.hw_attribute_length;
 		memcpy(
@@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
  */
 static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	u8 lenvar;
+	u8 lenvar = 1;
 	struct ca8210_priv *priv = hw->priv;
 
 	return link_to_linux_err(
-- 
2.49.0
