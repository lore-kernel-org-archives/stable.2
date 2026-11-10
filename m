Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340535;
	b=L3Kz5qJOfrxAZwTwJtZGbjbVntqzV0riVazCdU/96GjxU44F0YGpYYkoPZtKA2NTr8oc
	 YN4sk1Nhk4qilSBp7VzXdw2Xq6LiSL4ts2m5DlkuL1r0Ae+3+AdDiV88ZmFen9jQBXTXD
	 DYvy79DkchjPI5r7YXBPEAiW8W7d52cJK4ebUVknHOuDyrBuFd53MIKY2p0U1IaicViDX
	 zjU/HnIkoguZz2H4bN74Cn35+3n/l/nbiLx8c4Q0Nz02AgmcOH9KLxVAi27Jg0LRYT6gp
	 Zul/w7lD1m7K1K/tBNB6RsdCDW9Ru4tbAXKVDOabcmIeEXOV4TteMbrTLSh2SY50/pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340535;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9xaw7vJ4IMcFpzmVzaj+rBBe4xVZOARA4vNQChdcK1A=;
	b=lnuITf7N9qAjrrurGXy8vXsl7G7oWHWQ4e1yIg7aM7nRDnz2xIju/tpZCiypB0PuPLn/
	 tuPKcbP70ej2bJEPH8vqpLheDTXs9tXzR9/brQJlgH9RIp/cg6p/vSIZNL7HV6wGcMRAS
	 1oK7OruF0wfLhh85WZvz70n/iOSjcIApbYKf2WhuonNkzZQA/v7LkD/L2m3wL/OWFafYK
	 Zij2PNmg8dq1dr3p0+FA6OaPEaNA9RevUcaU6ugs6UFMhsDXjBXbmB8hpJfVlvbVcHiZP
	 xgCWLxvqyH11LbOua0BjpnH4IRhDffdtYQfTTjTJVKUEEemaCHXdsekquKS4PisD7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aTUhDPAy;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 451D0606A33D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 451D0606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aTUhDPAy
Received: by dvalin.narfation.org (Postfix) id 99EAE1FD16;
	Tue, 10 Nov 2026 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794340532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xaw7vJ4IMcFpzmVzaj+rBBe4xVZOARA4vNQChdcK1A=;
	b=aTUhDPAyPY36ZTFZKDuOPu86XWAmBI8or6Bf2JCs0I79FbjPJMxxX72uN1wWplY2QYs6RP
	rpTqRO9SjlOMPgZGnd2h5esBzEILJU3PQHnHLcg2vAx8CmCTgubQUsQznfLYGF8N+HVJFI
	oxEfbedlky3JV13+2SLNlp44JRt2pXI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 20:55:29 +0100
Message-ID: <20261110195529.429081-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202528-failed-5.10-aff4d5d10f2d@kernel.org>
References: <20261109202528-failed-5.10-aff4d5d10f2d@kernel.org>
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
index 23d34e1b48eec..1065003c99dfd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -776,7 +776,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
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

