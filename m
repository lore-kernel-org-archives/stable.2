Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E63DB309
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134556; cv=none; b=MarKbG69i14aQ68iuZe/FR8EzKIw/sT7euFf4ax2TrIiowkkSzJFONqRXhpXw/MaF6rrLgWQkPXS6yiQpUn9MypSmYHHoHkrub5CXiYjDmxqKotvawUWIBiVOcYFWgHMeWwp5zCFFhzAsi9KGPBG28mA6HpPvSXTtGb8WrHMGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134556; c=relaxed/simple;
	bh=+m0zdBu5/ts+2IyJqXW9aSlshtzUwb5CgVTjDsTkIKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DS63B1nhC11jBIzOMnlKziNlqYI76FBZCaHH58E1sK3USL23OfLjcn3dD8SLqRl1OWSyF4noA5yS8LMzbWhHouRUA4zht8UVlAeLRwL5URqEIYOvlk407eaevEO+2vdZrBA1qLB8zxD7gO7MPSe3/BA1cpFvFaifnscHjNNE8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=yZEst0I5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="yZEst0I5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so28662935ad.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785134552; x=1785739352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IixglYEm7G+4GcyJJRAUCqerJmEAIojYlRmU2MgKqo=;
        b=yZEst0I55QkPDp2YFX7rg/eRYZHOA5RZXEYTAGvQv78sSwBInXIP3GOJckMSPzUbcv
         ng8uhfG+7DtM+6S159oFz5Pmd4CLvMeOUI/4EH+5F+7uiZAzugNUKFDI80/pWUqcXBVC
         8VsFjpQq40qnccnoKVmnGdlWhTXQ7Rs59nQ8Ai7CnDhRVFK2ymIO0bskAseDi1xAj5Yl
         DDKCBl749dYfrXumXoGKPwL4xAxFgU/LUEsGEzZ6M3LeiH7FcPtK7mC83kk4QgXm7kmO
         KDmKsRXOS+d6JtpJagCjINYbDHtLhb2c1XKs01tgUsGeSn93ypK0EmeDGT5U+WsFY/hg
         zmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785134552; x=1785739352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IixglYEm7G+4GcyJJRAUCqerJmEAIojYlRmU2MgKqo=;
        b=EvtTOqF7M6pxeQAldrmAO/WLWdG0hhbL13usrqH24xeM3T8vk5dH/99O13A8voDPPH
         c7QJdXMyQOYSSycVm1XLj1VrN2GT5kQCFzuoGuvltBEdeIfzy8mKWgYgjKovVfrUjgzQ
         dc710b2g6OJhjZiKBC0H4EuWJX+IiFV2W7CwNxtCXCCfxX9LGGVIJog0pqLx81xrIQmt
         meooBngSHBjr1jI3hXjPj2sYjQKCjhbFeJADVmjpeMQv3qXW9ZyxRggoliYhrI8z2Of0
         BuzU/E5c5wvzLR6EW76BO5Q6OIiqkT7NHqJv2qZJKM2beX3PJtnmcsEX8K7l9lJFpIfP
         w74A==
X-Forwarded-Encrypted: i=1; AHgh+RqzxSWAos4zHXxT9V05IiLmpDjSMgwk6j9zZqCfFR/srO1KTquncYA09bNkkHhbbraywS8VHUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6YBvFoHy/XdFZ7vsx5LW2lVoL/AW/AGZ6ksYBdr3NQ0Grag4
	oCCZUPoGwbWt12l2KFWX/34hllwYOJsssSqhkNry0bymp9BkFj/lQZjWhMMu3IzphvY=
X-Gm-Gg: AR+sD13Ex1JQu6nR5KZMW52uwCx55bGDPNmfimYTpdI6katCCW8pepZViTya9r6HEvI
	2D2yIBjXxMT67t/eh3TFP8X+2kzxV41DrNDZEoC04OAKb/hrS452QhwCKRUFI1MNCVr21ddYh0f
	JzP1jbiPORD3cPwxzm4LRV5bYHnzSJJQUrR1Z4e8Y2bu/FFLzppWaUAJ8shXs2+t6o0cM35s0+8
	+DuDUVZPZSVr3IqeWNOiaLF+Ol+8J1zVtnFyCzQfxby5DxhI5mlmZrXEQNyzkcqQ5BmtgU9sCCN
	OIJPIjBhU+kPrQMyleFQzr5lDpTYaNgqSD37nn9xN0MDqiMddYBOS2o/OBsbG4omOMrh7ynxDr5
	pN6lBWJM/sKt4Cx5n76B6x2s4O9XUJny/ZbrIhnjLXNwZwArUK8ByHjC38ZTUpoNkRqiRpv58Tm
	zaeh2r8opvzJHccvIkRUiNnZc6DTATmRwTsaeX3f0WWLgdDtX5FYajN60i2F8UFRbEBiSrU5uaW
	MT3X7ZslAZsWaD5wiLfDcjbvz87vXhA
X-Received: by 2002:a05:6a20:a128:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3c67d9b3d98mr6944920637.15.1785134552562;
        Sun, 26 Jul 2026 23:42:32 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm29043443eec.29.2026.07.26.23.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 23:42:31 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: pkshih@realtek.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
Date: Mon, 27 Jul 2026 12:12:22 +0530
Message-ID: <20260727064223.61836-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb passed to the rtw_hci_tx_write() is expected to be freed when
the function fails, but the error path in rtw_txq_push_skb() does not
free the skb before returning. This can lead to a memory leak in
rtw_txq_push() where a dequeued skb is passed to rtw_txq_push_skb().

Fixes: aaab5d0e6737 ("rtw88: kick off TX packets once for higher efficiency")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis

 drivers/net/wireless/realtek/rtw88/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 9d747a060b98..8786bbb421c2 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -619,6 +619,7 @@ static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
 	ret = rtw_hci_tx_write(rtwdev, &pkt_info, skb);
 	if (ret) {
 		rtw_err(rtwdev, "failed to write TX skb to HCI\n");
+		ieee80211_free_txskb(rtwdev->hw, skb);
 		return ret;
 	}
 	return 0;
-- 
2.43.0

