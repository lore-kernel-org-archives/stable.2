Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73D4D90BF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449210; cv=none; b=h77ELzDr99z9+mslKACuR+j25bn+d2HWt9RZt14ESCndHzCxhDX3VL8Y9S5KzCKnNVTZvkNM7xFidTrEesvXeGRCK1e1jujcvU1Q/EYD1xbw7gIcwmutYtaDFoMLrBDgkNdMO3LKNBUce5BebOKus4B4kxKY/fkOIwiWs1eSyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449210; c=relaxed/simple;
	bh=tRdKtSDhM8B0bKuS5cPQ4EBJYq6RJ0rjT47wLv8M25I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgtZFqDx9Cw+POi5o0qa6yTgQyzLnGZaC70b4ERsSFMEXTlmJJw5xiW0wjNIZ/AKBZh+P4N26Trd7a6uABjsgAVS/a5mnFoAGMixTw/65t2czJ5FnRKZyrEXGxq01QGh2uYcdHh5Ly0o6EcOZ88pX7tpr4GG65j0shEXKDq9svI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipust.net; spf=pass smtp.mailfrom=ipust.net; dkim=pass (1024-bit key) header.d=ipust.net header.i=@ipust.net header.b=wwLE8T84; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipust.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipust.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ipust.net header.i=@ipust.net header.b="wwLE8T84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipust.net;
	s=protonmail; t=1788449200; x=1788708400;
	bh=3xBIzbhOS/AH6v8O5Eezqk+PH1+CkOpknoTuBUPSIQw=;
	h=From:To:Cc:Subject:Date:Message-Id:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wwLE8T84F6+LaPAQd/AFHY9JcpViPbk4X84z8RLxkfgvEJc/fRDYQEbxTAlrGcpLv
	 szwl1WJCGhDslTg/MWK/lr3qGH+3Ph7pKm4JioaYvmMKuS5zPoCciPXZECkeVTZivz
	 LsXw9fMOorqJ3pywd/X0FG1C6WHIWsaK0fVFAauA=
X-Pm-Submission-Id: 4hbNjm4srCz2SdHf
From: Ivan Pustogarov <ivan@ipust.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Masashi Honma <masashi.honma@gmail.com>,
	Ivan Pustogarov <ivan@ipust.net>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211: avoid out-of-bounds read for empty PREQ elements
Date: Thu,  3 Sep 2026 17:26:16 +0200
Message-Id: <20260903152616.1646637-1-ivan@ipust.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_mesh_preq_size_ok() derives the location of the PREQ bottom
fields before checking whether the element contains even the fixed
header. ieee80211_mesh_hwmp_preq_get_bottom() reads the flags byte to
account for the optional Address Extension field. Consequently, an
empty PREQ element causes a one-byte read beyond its declared payload.

Move the helper call after both size checks, so the bottom fields are
only accessed when they are present.

Fixes: 8b40b1d24a60 ("wifi: mac80211: Fix overread in PREQ frame processing")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Pustogarov <ivan@ipust.net>
---
 include/linux/ieee80211-mesh.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 7eb15834531c..9e548b9173df 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -361,8 +361,7 @@ ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
 /* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
 static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 {
-	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
-		ieee80211_mesh_hwmp_preq_get_bottom(pos);
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom;
 	u8 target_count;
 	int needed;
 
@@ -378,6 +377,7 @@ static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
 	if (elen < needed)
 		return false;
 
+	preq_elem_bottom = ieee80211_mesh_hwmp_preq_get_bottom(pos);
 	target_count = preq_elem_bottom->target_count;
 	/* IEEE Std 802.11-2016 Table 14-10 to 14-16 */
 	if (target_count < 1)

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.39.5

