Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB833E317B
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872940; cv=none; b=W9T4dnD3ly+kbf/eGlrC3rQMGsbwztn4ZaLg2XVIn1txfR4SYQYgkC6R70nX8nUU9tNm93+u9TisHQ8XLyA9vpKRNxhNZRgjuj7qdUJD2LGf37MOTQm83kUet2wM7NMr6ZL+dEmIs1q5Br9KEAqesDIsHg3XczTLv0X53p7wnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872940; c=relaxed/simple;
	bh=EDHXUIjjM6UdMy4A+k4tbeIVtiVh/qfCZjN8Dc/wE4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckv+e26Z0s7CSSJRapO8EfZdbOcAaHkfBUk9AjwzgRWwcVkv7qP73IRThKoUcFdimla/81eB7AEAV/iI7wGJFOrUPkq1CalfiB6RjIL8WoXzbCLKM+oSw1wt+9R1Q6ATTd0xlCASQnPTSlhZsHgDc7tcvcDAkY5cLNwjAA8yj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRsNp+38; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRsNp+38"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81a86afd781so3044554a34.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872937; x=1791477737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ErsgCdjJpA/DlSdvk3QC3jh560CNo6DjQxt2VzypIM=;
        b=NRsNp+38+1f6jJTaAh3BwgF3pTKrDJAvW6nHzh3IdzTl+X5ToYoPOtCI5B5wjHJU/I
         ROtctn4BUNuy+baTk701YHxydq1f4YRKNg961J9+utw7SAk9mHhlhNQjVfpMEkTWAEzz
         NBbZPKVI0eKP864vZSgnOz4q/Ubc9rKx39JojmsczQGc2OPxk82gNL4hLeEMKYN7bbIz
         ndqORyA2CALdCsuFQ+wT0o/JvKZ1SF+GNiGVzRa7nCg5JPBwtE/eLpEts2Xx2SRBEGY9
         fvBftY1JiIKaMTaK/Qg0qMDtrauSScX2t9vCG+Vt9c2hwFLr4/SlYyckj1UDCJgn/+VN
         W6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872937; x=1791477737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ErsgCdjJpA/DlSdvk3QC3jh560CNo6DjQxt2VzypIM=;
        b=jv9igaRJSMfKjJXc0vaBf2ob6sUviJwz8oPX0qeBSp6GigTzb9JhqL7p5V72dsbRCX
         JmSCtO4+V2mbr9wA3xVt4FYdxFiK0HS6vDw2WSx3NgJJdFRnAcdzYSMmOBa8iLLpdKHh
         5i/zzod3UPfJoSpCNomuYuodU70KVpgp+kFjKnBpsb3vYQwXyh68ejULPgkl7ssd8BZK
         0AjwHMItiRil24os/Wi3mlS2iTxIexSsmcsZhB10+LYxGwvKJrgLXddeu2WxHLWyqgSC
         9D84p20U9fge4Chs/DdCaUawJn7bN93udUtRt1VJfBmO/D5O4g76uz1SCgEz2NqcS2xN
         Zyyw==
X-Forwarded-Encrypted: i=1; AKwUvBzX+f8DQc5GMf1aP3NHCIAXgMOsCzH/sFwCIcyw1cpiCri6/In7c7vdPeUkqZiMzatvZzu8GaY=@vger.kernel.org
X-Gm-Message-State: AFuF++lkPoQtU+Fnl+nmyn2JPSq+sFd0eQYPjkSh/wG3IZCX8aZ7RjdY
	KqTvs/Sp75uJDlOUR9N5BD4Rq95ActCGIUKi3E1LAiPNZd/Ysv3bdXkX
X-Gm-Gg: AYBFou3w+z9y8sj+yMKZwayTyVSZ6uebVdqOe/2DMC9p5PwYvjgShYqAw4sLo5vtcoT
	zcooQGGOEV0ETwKUDrYlLmk5EA1CCPPH7PbWE2Q77brUan+wfggdPmuEH8dOs0Gl2YzYlITEBrU
	3GLpWZ3EclNSgO65QcHDOD646FAN2EpZ6Xl1LfLdEwUOUtjepRu6XtSRYDRh13HP7uiLXRVaGPS
	JnNrjrhtT5g1c72u3p+79BuL9UoHPWdXY9gQpzOwhxsYI70hzhTABLQf6ypOS3gxdU2tAlzp3GQ
	p96fNjp2sQuTb3gWyf4UgfIFXMCYGLncyQED6BfFjpACeRGSOSE2QhU/7+FG8IbwItxU8tnrDHD
	kkqOzU4HOJGaM4pS3exBZez8PXS2CblzIDzkCi25MHIdEFweN17qFK/EdIKxjucM1Q0EZ7OFDoB
	etrBBjBF1RluwrdSkbGvT94uGOu3NfsIwZvpIyyYdAc62QPpD63cB08cjunUesCztXqnv/93XSi
	oibPzf1BlpBZsB8yoD1d40bBeDPw93UKmy3xAc=
X-Received: by 2002:a05:6830:3498:b0:81c:5aac:798a with SMTP id 46e09a7af769-82284552ff7mr195697a34.13.1790872937467;
        Thu, 01 Oct 2026 09:42:17 -0700 (PDT)
Received: from cachyos-a.lan ([216.212.36.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a16aaadsm304424a34.18.2026.10.01.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:42:17 -0700 (PDT)
From: Patrick Lawler <patricktlawler@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Patrick Lawler <patricktlawler@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath11k: require unique station addresses per radio
Date: Thu,  1 Oct 2026 12:41:39 -0400
Message-ID: <20261001164139.370144-1-patricktlawler@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1e744bf218b5 ("ath11k: fix duplication peer create on same
radio") made ath11k_peer_create() refuse a peer whose address already
exists on the same radio, because the firmware asserts when asked to
create it. Commit d673cb6fe6c0 ("wifi: ath11k: fix peer
addition/deletion error on sta band migration") reduced that check to
the same vdev, so a second peer with the same address on another vdev
of the same radio is sent to the firmware again.

This happens with several BSSes on one radio: hostapd adds a station
to the driver when it receives an Authentication frame and only
removes it from the other BSSes once it associates. On an IPQ9574 with
four BSSes on the 2.4 GHz radio, Tuya Wi-Fi devices trigger it while
they are being set up: the firmware asserts, ath11k logs "failed to
find peer ... after creation" and every following WMI command fails
with -ESHUTDOWN. Any station in range can do the same with
Authentication frames from one address to two BSSes of the radio.

ath11k registers one ieee80211_hw per radio, so set
IEEE80211_HW_NEEDS_UNIQUE_STA_ADDR: mac80211 then refuses the second
station with -ENOTUNIQ before the driver or the firmware is involved,
and hostapd rejects that authentication. A client moving between BSSes
of the same radio has to leave the first one before it can join the
second, as before d673cb6fe6c0 and as with ath12k. Stations on another
radio, the case d673cb6fe6c0 was about, are not affected.

Tested-on: IPQ9574 hw1.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1

Fixes: d673cb6fe6c0 ("wifi: ath11k: fix peer addition/deletion error on sta band migration")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Lawler <patricktlawler@gmail.com>
---
IPQ9574 support is not in mainline ath11k yet; this was tested with
OpenWrt's ath11k (backports 7.2) plus its out-of-tree IPQ9574 patches.
With the patch, re-adding the device that had crashed the radio gave
29 refused authentications and no firmware assert, and the device
joined its intended BSS 39 s later. The cross-radio case from
d673cb6fe6c0 could not be tested here: IPQ9574 has one ath11k radio.

I used the mac80211 flag rather than restoring the driver check from
1e744bf218b5 because it refuses the station before any driver or
firmware state is touched. I can send the driver check instead, or as
well, if that is preferred.

 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ae91b57c8..a7574803e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10518,6 +10518,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(ar->hw, NEEDS_UNIQUE_STA_ADDR);
 
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET) {
 		ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
-- 
2.55.0

