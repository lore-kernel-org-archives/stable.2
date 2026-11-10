Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339031;
	b=RJJnELJ9EKOJQqxFzmJVFlwPt2uk8MvAzzbth1JjVdnPeYzJkKMxvbZNPsFOIWBiAddJ
	 eIHFiBC60XXK8MoyZCMlPPRP1nFiuXnDIKYSf0SU0hLQuLDZaTWl6wO4vzgEZV0C3WtxU
	 JZna601EhJgtFMbG3Z5xIU8gs9AMePFXlzow5bvniL/57Go4/bsRBwLfrRB5kQT8T0Txf
	 /Pd6SWFdZtAZfq7Twr3Bu9yhrJ541cjh8jjV/rwGFiDSNiegy0KWKKP3NaOjU2klT345J
	 LwVcdjQPQ0LbaomeG0Zb5EKftg9bTomL1g5uOtm9X3u/H03V6ExlgXrlU5XXRVSdvOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339031;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3vfetRICya6PZJyABvRdhZynx3I9ywbecXzF/ydNf1I=;
	b=qSuOtF/vUMBdrz/ILPgQ1dqd1aE5RxtdW8g+BTG8pVvpfWiCPnD8kMNUs+rmqpSocbcs
	 DwlXJGodylNKcmPoWu+GR0Wm4a2IJJTTag3magSszMTu+6dqSpIsK5SiRQX5oQstQRWET
	 nOxGF92NIi1M47ZVPTk2JECeYBV+NLV6xJCs+TXttGVAUSWWEbod3KFsSZZAzvUGD9C3A
	 za/0OARuLQ+owmTHLr/hdInU4h7T63JxAVT7OEMSb6ADkp00fHvVcY2iMbdWiWvZfk57T
	 uG+e78WwA4uwH4K87bN/wxQY3eQuajlbishrfMKAEaT5ByE3aczF8NPE8qlZsLr3nYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=baLbWAii;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 53D99606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=baLbWAii
Received: by dvalin.narfation.org (Postfix) id 84ECA20292;
	Tue, 10 Nov 2026 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vfetRICya6PZJyABvRdhZynx3I9ywbecXzF/ydNf1I=;
	b=baLbWAiicn3YW+6GDhvhupGgsfbyPscqdxAsMeJ5OphYsh9zO3ot5kHUZ2D9OnOExgyL1Z
	gfZhjRMErY/tJu07QCGVdBl6Fmik+mrE4kxye+a7j5exeagzrnpF6R9trqNGelvFli97df
	fp9nha5D3OddKfUYmb2rGbL0zdyo3sQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 20:30:26 +0100
Message-ID: <20261110193026.243218-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201526-failed-6.1-aff4d5d10f2d@kernel.org>
References: <20261109201526-failed-6.1-aff4d5d10f2d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit aff4d5d10f2dcb4a9b604e27414dafa1d51b6406 upstream.

When a ROAMING_ADV is received for an announced local client,
batadv_roam_tvlv_unicast_handler_v1() creates a global entry with the
BATADV_TT_CLIENT_ROAM flag set.

If the client sends a frame again before the next TTVN commit,
batadv_tt_local_add_roam() is expected to announce this return via a
ROAM_ADV frame. But this doesn't happen because the global entry (created
by the first ROAMING_ADV) carries BATADV_TT_CLIENT_ROAM until the new
originator announces the client.

Let batadv_tt_local_add_roam() always handle a roamed back client -
independent of the ROAM flag of the global entry:

* trigger sending of the ROAM_ADV frame(s)
* remove the (with the roaming) associated global entry

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ adjust code still in batadv_tt_local_add ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6e41824db11c8..a2b38e5980615 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -775,7 +775,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
+	if (tt_global &&
+	    (roamed_back || !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM))) {
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
-- 
2.47.3

