Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9E3ACA7E
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462979; cv=none; b=hv7MGFm/R9mojhpfH7OIbXUeBEB6rQ/472avPpc/YiDj009Qhq5eVX9Cp4JLt2Zhu2rkVYAXWzUpSleTMWbu0s31niPTrlJknKY7zdwEitIDZ0VlLuUdIjmImNQY66D4d8N9wRh/IwLH5Ygg454D5lyqQsaYW/LrdMWXnohIWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462979; c=relaxed/simple;
	bh=WHzBXw3Vfp/jx3HNdEqzwg/ei+fttabtBIAcfjiy6Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDJWOi3VupKaONJp+l4AdFnIA3Zm/hdJ0sqn/ByEG8wh/QVjGsedqNUkJxZJYKhyVxT+oWxyppxTzBYdcyaxuElOBVfFES5QCsiT+hQoQ7nnFcPGuSkI2xjI9gO+5iMqcnIaZ/q7Sk0HbmBpH2oe2Tq0+xnwBididgCqSMc/1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfK7t6Sq; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfK7t6Sq"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so7963166b.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462975; x=1790067775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=chLjM5CTnb50HHVQx65I0WAjKAwm9kU8MWpPfnwKwJY=;
        b=AfK7t6SqrhvJNGvaT5XeMxcFQ7vRkJOrN8YQ1NATGlhuZ5sBt2jPARvZe6RNeka2At
         29/6fWT/Wr02orRNuebvHyZMyz/WynCUvdLyteq2rCn4e0lfB7Yj9I7bm3qHZmckoeXc
         +5AEZvMmwr0xjhndzUZeHYM8KwfsXqDsaRehdoJoDYBn10h1wYCHG9Wl9EiYtx37spn7
         ZkO1y4Rs3+0UiCH7taognZx1+sbF1UEgIryTredC0xTaFXEBPaNkp5WoaopnBPZEgM4r
         /J/KRVAk7UaPbpgS4fhFen9rEP1i/S2tLd0lQ2/Db1Z/QwlAga3MPaHXUOTLT4t6ZuMA
         iO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462975; x=1790067775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=chLjM5CTnb50HHVQx65I0WAjKAwm9kU8MWpPfnwKwJY=;
        b=OVV5ZML/sNsxOVqt71ucPzOhXPGg6HVn9EX277A48omNptrTyr5M6jis4oQN1xXZ1P
         YdUrZjnpOfHB6dyMbC0ZbvgUkB1uxEPwBZTnZN3ZB77YcZk+sKDKne64JEDTcGDBTCYb
         YSKbZvc4HYZKTUro3DZs3ec/7/gHAo+0IY00Ilmu6SiiMieWfZ9pERwM3dZbn4Asqk5Q
         bVwjXLc+wLS2r0HmLi/M4dwTpLD0XQFfRLp7JFDK+gaOv6/4qdhZ26KEsVH3Hy3oTF0G
         TDCl+5IcL1MmNXLaEWKMQLrkKg4B8ZoCW4nantx85FbuAl26pnQte2pSV3EX1AA5XB6G
         j/RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFN/gHJlVrCAeQEkr2kugighPH6VbEJowK+ZQg4tQxknRLK2pcMBPAkY0/Ug3k0ohlOYxgDPo=@vger.kernel.org
X-Gm-Message-State: AFuF++lMF6uCPs8LnCPN4xBdjAO2wuv00r0iahCW4u7AOdOgPNJddfjv
	EQ/yStlpa6O7ElvowmumBMe3K13yKlKbPLxkJPwVEiykg+xMIIZFFx5M
X-Gm-Gg: AYBFou0e8Da8VAiFnOXqzOxVp/5wR7hY6ozcahgmO3QsL8aLEa8EIZJGmsIQQ4mPuBk
	4KY4YPnyEGiF0zzHRDKGnRuKdLRN1+bzhUqRFlamIEYPksEGzT5r2gbDeSQTbaHDVGe+7SAmJqG
	at5AyISeTq5Fojwid2Grq+GAvV3JHbM6s5fZc9lt1mv9423vCRFt6UCHkZwoxbNwRshvwRrrIv8
	rIBLPcVvKRQQewbkj99R8V2dLRR1CVUf87D4G923TQekshUQVHksjG1NlkB27+2Xd6y8/spU2y0
	HeGu5gS1FFAaNfEJiLkO+fDUHFU7YgqMJbyX52uYYKq87mitTL7bG084mHOa09b6pqyoUbTWMN/
	5ugGl3/hSJXS/F4VKpMxssopmGGTl1NF9Ru2httqAi+hA70ZntETObLOseQEPt3apWOHSbs9bby
	59AGTkXNNOoHGh2z07Ej156Bmu9gg3TcI2y2KWTSdNvRp0qkU/fJsPQqxhyOU9cV9OIhDdNXiZO
	zGeJMRq1sgVHsy06kxwT3hMePTw48Dx3DwXag+JFS0nFxp6eKlefvKnaGLocFTfKrKBar23EYeq
	BpAsB8Pak3cx6SkVePlDN3w1QRiBH/nKRvoKVczZnzYbcfoH+aPMxHeE1oAk0O6nKwUetV+Chkz
	S9gfeIhUsBLsMuoh5d6jfEn23jnqslZV5+YAwfLn0x2HcyBmG74BPnvUEd4Pm8SFNXKz3rBkvLX
	nwV2JbnfbJ9pn144SCBxdCAsXv33G0ngVtTW0P3GZ5cqcPOWptjACdCQDLTldujIja7dFN7KQvw
	53puUM0ybE=
X-Received: by 2002:a17:907:948c:b0:c29:49fd:c98 with SMTP id a640c23a62f3a-c29d7926fbfmr13664366b.32.1789462974448;
        Tue, 15 Sep 2026 02:02:54 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (88.71.12.34.bc.googleusercontent.com. [34.12.71.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm546369266b.1.2026.09.15.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:02:54 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/6] usb: core: add missing pm_runtime_dont_use_autosuspend() call
Date: Tue, 15 Sep 2026 09:02:18 +0000
Message-ID: <20260915090223.1346-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915090223.1346-1-joshua.crofts1@gmail.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fail label in usb_new_device() disables pm_runtime on failure, but
doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.

Add the missing pm_runtime_dont_use_autosuspend() call.

Found using Coccinelle.

Fixes: fcc4a01eb866 ("USB: use the runtime-PM autosuspend implementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/usb/core/hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3345b3298daf..dec6d5c49759 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2745,6 +2745,7 @@ int usb_new_device(struct usb_device *udev)
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
+	pm_runtime_dont_use_autosuspend(&udev->dev);
 	pm_runtime_set_suspended(&udev->dev);
 	return err;
 }
-- 
2.47.3

