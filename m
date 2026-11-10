Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339146;
	b=3azKV05ScGQj8ehdlSyS4ruCk1xLkAVzO9P1YJq04WzSuHCUt0wuveDyenhKc8LF7jxP
	 Jkx/9c730DhZIgc4y/hDbHUdf7q1jBl1eESA5pr0WJTlFOS2a2pqiAikCrb8iHXOQnxG1
	 oRbaW9ia6niikNkgOUTWvEhUuv1a61ZTMnQxJIeyKQUwbhQ8DZ7WyXZez0SSh1jWZvOj6
	 nmHeLj+f2kOWUaD+J6JxJlolb+8KSlciqeuywNiPaI6meFxkBLBCXINq75eglTbHTpa6d
	 UvOUF/uT0zgj1KrTjr00UlUHlFKsPmKXFtlM1ps6SvJ1MS6JNg0rXgnLpu9gx4yZi3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339146;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JPLB8f2K3yHQlQjNvkp3sPDMx1e/k+IxNBI1w3uMSto=;
	b=bWvgohuYwMeFd4RQeMQQiwpYNnfqcKRlh8yVdVjCa82hNc6tNrHm6xOJcGMrFl4e9kpA
	 lqy7O28iLZnWcuMkTPgCc8/6uhDuwSe4957u7eehgzBOtIGHDeMg1HCBERxwWo2k3vxEP
	 iinvGM0wO9qQCLxF6EOStDpQkE88fWbOb2zUdZ8Zdig54sVl3O54qyQVABCxRdv2HVpiA
	 1WGT/5IQA56FgvSS1/3qQH8H/hAFXQhSuSjnZduwk/muorwWZS42umu8MsfEfYx5UL00N
	 eXGk00r4XTHDPhu1Ea6BFEmuYNcRIxcnWXPb8J8mRruObkkmQOrYm/U5Xs89qDvpFEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=JzsPIOiO;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DA9A1606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9A1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=JzsPIOiO
Received: by dvalin.narfation.org (Postfix) id DEF3120292;
	Tue, 10 Nov 2026 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPLB8f2K3yHQlQjNvkp3sPDMx1e/k+IxNBI1w3uMSto=;
	b=JzsPIOiOS54gpEv6xzYgOxCUbVqOH3S6dNGhRc1d9JrRS+5anvx0YvYHdf1cqN3E8W2dAD
	KHp6R3FhDoCRXXPLu29QpCerqFbe99ulLlXNONU9F3/MfB4cAPFsZMOwHthQzuzCaWSo0X
	xvbXydUo+gvDBzKcRSUZzpPcQKUZei0=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Tue, 10 Nov 2026 20:32:15 +0100
Message-ID: <20261110193215.248474-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201522-failed-6.1-c5d68abe6e7f@kernel.org>
References: <20261109201522-failed-6.1-c5d68abe6e7f@kernel.org>
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
index a2b38e5980615..8ff98e5dbdbb3 100644
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

