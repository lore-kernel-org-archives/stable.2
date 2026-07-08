Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2440960A;
	Wed,  8 Jul 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502328; cv=none; b=KS7xfoDu7NR43u5qhVRyRlINmZcmX77nhbpM4JNMOweoTif9h6iGbV5RGSnRy8tRI6l2G07OwlSlF2hdJIG4mJ7NpEohCfj+kk+HR9laNG4ocPOq7tXpRzrAD/BU2loheBkWLyrdtKfLmSh5c8mqElwsiWIQm5L/mqq1b7jZVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502328; c=relaxed/simple;
	bh=MUiT6sSKkPf6yigCLCZNekpAZH4pZEOgUWrAgBdFUtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJfov1RJruJMn9HEQpN82ZpYX9HWvJ1YN9i1/SHiBtXcJeRJVJ0HDz1yPMiazb10l1+pYDGcaSLnOKCc6RANJk0EPhFAe1cm6k3Y96E8NEDQ3BbxutbTmzKblBu3qUWL3KnuQpt88jBn5MO9TK18iAy38IBDWtBh1dv/WFxcCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=nqnZQX4z; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="nqnZQX4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFpl7pK3uTWz21nbIM7Bm6WBFUQXvhGQVbOYY5GDip8=;
	b=nqnZQX4z5ROHJ+k22LirLdDuCstF4g31h8fMI0/Nbgter3bg7D6mJ3zwo92wWyivEtJfWP
	FiA8o8zt5b/A5SRdTOCKDPiTa3k+h5vGMtb9X31J9a2PnY+/fEUmYnfGGIvnYN5JuDyfuz
	SiwcZLdw39gKp3Kxzed/isMmWEnCiig0a78U6GKeNk+tzVjTBOUb1d7H03laG2ZESaudNp
	4PEjOv/ubsMckI5Me+UMvU6NTSVRQ0kNhxEcW117t/cKlGy2ASCBuF5xloEI6NFbR+JZ+F
	M4O/zWLem6VFyk7YV+wZYdDtvGItGSSiFzKU6U3KRMJrczVs/UXfd8g3xUzr3g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 5/9] batman-adv: tt: prevent TVLV OOB check overflow
Date: Wed,  8 Jul 2026 11:18:17 +0200
Message-ID: <20260708091821.314516-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

A TT unicast TVLV contains the number of VLANs stored in it. This number is
an u16 and gets multiplied by the size of the struct
batadv_tvlv_tt_vlan_data (8 bytes). The size can therefore overflow the u16
used to store the tt_vlan_len. All additional safety checks to prevent
out-of-bounds access of the TVLV buffer are invalid due to this overflow.

Using size_t prevents this overflow and ensures that the safety checks
compare against the actual buffer requirements.

Cc: stable@vger.kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index aae72015645a4..dae5e1d8c0385 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4033,7 +4033,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					     u16 tvlv_value_len)
 {
 	struct batadv_tvlv_tt_data *tt_data;
-	u16 tt_vlan_len, tt_num_entries;
+	u16 tt_num_entries;
+	size_t tt_vlan_len;
 	char tt_flag;
 	bool ret;
 
-- 
2.47.3

