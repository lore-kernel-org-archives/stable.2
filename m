Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69041D4F1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230974; cv=none; b=DhcLS1zRWtwuyKOCWdVLcIKaGBY06vjke98dEy6CQ50/+erxRd4JudBzbL3qcHtSi4lrDLsTOs/IDsCZGsAxx/NzIas/pcCSaQbyCZk3O5e6pPMCkrpybV0edY+S6DbqpDBEDi5RKtxlVIuGPgpYco2QhfYnyiWbR6eWbLIJOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230974; c=relaxed/simple;
	bh=8n4IhzxLjYl7HTSiJyo9dgWou+NdEFWkn0ApdKjkeKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcdXWJW8jmqdkrlE9Pyfp56BBXwfA5SRNWRz0Z9HbbLAgZ2pm/j1Y8PCG1uR4BmqJiTXCFbSpg30ubfHubfBCyaMsqPDa1WbCnTxf6xQWcqajbhd3kyRdzS61atzd+6btiptKgf9TJVvVQNG5JcwFEokFPaVCwxQ9fcubKbX/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC/H0ge8; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC/H0ge8"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so8869285ad.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230972; x=1790835772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpjVkotq4ymVbBexed9Q2u7FUNUeANInboIGD5bfseA=;
        b=bC/H0ge8fDsK0ysUJl9/byLQuvrvHGJ8NuP1qacm6OVynVBjOMy/NzpabE5rLboeMx
         fVlWedAkxlgcAfGSy4LWoMj2G8Glz0Pp+38eSzm/N5T1tu8/o3tIw6MMchYfYj10sSsQ
         4fh2TNAnxmJO+1GQ4jCMvcvK0VYu+b2KTVxqj+Y/rLVPiQQ6z8Ddkq1x3jvSYXPcS8w3
         5iCromf0Jegrp0G7acWGpqs6cxq2I1U2kj7wKzpUGzVZ17Lp25poskFzhWZxnz7x7Re1
         7Y5lDhhPDSvVWStawxTcjRYsr0+NbfufefApZj4cH4u5HUeuU3Pu6ajZxPkpymOYq7kh
         Daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230972; x=1790835772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpjVkotq4ymVbBexed9Q2u7FUNUeANInboIGD5bfseA=;
        b=CJ1Hqf+luA4+sCRd0qMe6uFiVhTFhOlt4a50gFwxMfBf3zdFOXzU7uee4gvDSjlJZ1
         OINsQdISE4ISHZW8qaQSGPtqu7CHRTZqOVCBT012DEec3yPs3eajL1OmH9Duu3+boySY
         V16z4ofiakH42z0H9Qn1iWwGwl+OfHSFYY+yPo78AOZlbfToCOiCnMLT2JRt3pWU2Zx2
         GyUGQvRfEySmE1R5l5SRHDoRCY+85cy+C0KcHETo2kQtEASXLgrT7cY3JyELQ5sANwpE
         hNW83toDOPfeiui9265bg1GoCx9GnfPzol3+XTaKdpJmXyU4vbO5SNKerZf/z/hQDgO6
         +hyA==
X-Forwarded-Encrypted: i=1; AKwUvBy8fWISa/JTp6F00leuMUQZEGHzPfelJfopiXqOJSV6OpP1IR/4NNBzEuAloxFrTmisCQ1Sjuw=@vger.kernel.org
X-Gm-Message-State: AFuF++nw5mDX4F2a4fTtYTqysrTbRGFoIfo0vSHHOCdNvOIBnvPjuBf0
	Dsus3FnYxMocme0s/pOHQuPqX44k9TkA2sUxD7ClsURzNwEoCqDn1Ta2
X-Gm-Gg: AYBFou2OR9FOlYbQGs7xRLvIAryzmFHtRO5U0RKZrDKa0UbvLkwkmYB1T1r8K7KV6KW
	Bi7a2W5maL+IlA0/CjmtzYKuKH3GWhV+/u8iWZ1HbcNQxpm/4EIi2PgoEAb5ciVDWncpCQrJgdh
	KIg1QMROrZcHmiVbdlg1TsqZTV8zVJqIeKuMnFMlvW1GwDMkQwBFy5rdExE0yLGbTuaztFaA+ol
	mdXcml1M3sgmc4pkqEL90tUcu6taWgiACjtwsZvAt6CkwaGgl6ez/JfPE8KKQ8qCgo+84+nUQBV
	Ze+abigIl6BZVGCO2KYX12cJn7UgoUM40H0CHIpx7rxnRbeyYgrliCOsja7FCCqwcF1AsPa3hCU
	N1moE+QyB4hLbT20aZuuAk9XfDQ3Iad5EGpAZSV2+ntqjdaMydrVrPo1ZsL4lPSVhssCX89B3ZD
	TwGJqrDHPeDn3HKouxVBT5PIBb7bmZvz3cOtXxvUtZndUhYGoGKSObn0k03nJT2SE8GW/YX8AkY
	urJDpVuaNruVY4S2mPjyhR0gQn1geWQu3uMvVhumyeGEjnIZghkb1XLfHuqsBPY3sRkVIp3IPe1
	UZ18Wnx7cjw=
X-Received: by 2002:a17:903:1a0d:b0:2dd:76b1:34f0 with SMTP id d9443c01a7336-2df7da428eamr14725105ad.11.1790230967939;
        Wed, 23 Sep 2026 23:22:47 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm21220615ad.48.2026.09.23.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:22:47 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: h.morris@cascoda.com,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: david.laight.linux@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Thu, 24 Sep 2026 06:22:43 +0000
Message-ID: <20260924062244.2444225-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924062244.2444225-1-benquike@gmail.com>
References: <20260924062244.2444225-1-benquike@gmail.com>
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
