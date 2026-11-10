Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337479;
	b=5Up721UJPQxeY6z2YZuxFgClv0cFVrKSRu9qdXxDHrcNciGzxX3RRsJTe9EH7XGcr2sE
	 /pUZAWsDCs3y7J3gI9sFyv3lsj+2PZ5/66ucTl5RDgP1T74D7pmonIPklf99/6la96fUp
	 sDa3+wZJTXV/2OnC+hyjyTHBGcqGum5HDJLVw2jQktx7r/j7bggN8zjX50yKAZm4dh9u5
	 KwEENokkviLmCa/0AAynC9XtIArHaYrcjLZiPziXck1nZ1Tq90neSxQ4Dqm4gv+nCy4Or
	 MFoXnLy4ZjzgToLqSoDQ1Cha/iP1JObiS7pxjSQRCd2adOf32ez+Qn6Gk3IE90nqFnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337479;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+N7M84MMU0ljtzUDOHHeGFShUAoYwwkXbGlI6rHp15Q=;
	b=ShAsv6flfFgoRiuIwECeyj7NLx46d2P6Vm2c+se/XL1Hi3X5NJdo9qbZM2QOviNJYSJq
	 y7iTY9EOqXXTNaofbgB7rY/v4tncci55SAamzZfwtIn9zKEh62qQA3BRqHy80YsCDxpeX
	 jCX9m8wVunu5FzQpNY9ScVrMh2d1c26LlWlfV9dLeIF9Y+TLDHqat4QOH2rBpWhoogeXM
	 EKQc0HiEtbnZNh23o6fLMqQQEpM3fvW3dAiuciePf8Ng06QKZ/UyVRcwAFGkoCMV0t2ah
	 FfnpJtIYimQfgLsppk9l+gUib9OlFolkkP3xj0KxOkMcC9s6MyQ4aUdjofhs9rdMPmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=JAA4AuHR;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1F8C360A2639
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8C360A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=JAA4AuHR
Received: by dvalin.narfation.org (Postfix) id 52CD41FD16;
	Tue, 10 Nov 2026 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794337477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+N7M84MMU0ljtzUDOHHeGFShUAoYwwkXbGlI6rHp15Q=;
	b=JAA4AuHRlmgDKw/nIjzQZelcMf3ohuHwq+qVPKWqhtKO+nRsEzUjUfr2HqIOGGV55SGw+W
	FGltyD/Al074Ic3k2ORWBBNbNBj7REeP+0Pkh7fLMa1cEVf6NfkGY8DVrrsd/0Abv8ET3w
	gxaOffS/zhfk974fO+jdIzb/5ANC6IM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Tue, 10 Nov 2026 20:04:34 +0100
Message-ID: <20261110190434.114342-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200625-failed-6.12-c5d68abe6e7f@kernel.org>
References: <20261109200625-failed-6.12-c5d68abe6e7f@kernel.org>
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

commit c5d68abe6e7f1dbd132a602cb696fe1fff0389eb upstream.

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from populating the global table with a temporary ROAMING entry
which is not part of the CRC - and therefore causing a CRC mismatch.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8397b9edb5aea..96d67ec1a8af9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3339,20 +3339,29 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 {
 	int i;
 	int roams;
+	u8 flags;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
-- 
2.47.3

