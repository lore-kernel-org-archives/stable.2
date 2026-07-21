Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6E367B91;
	Tue, 21 Jul 2026 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634838; cv=pass; b=rehSyZCPsRl+rJqtLds+5KpE2sX5CrAjMg4QecPerRHsP95Tf4WpjwyA8IwG3pCVYlm1n76GUwCAvrBNBFJ4RP14ZZ80myespOqESSycwEANQhXQhUSnOuLurjuPk95Vklo/iFM9RkHGVteNrccUOrxP1dYL/F+NZcqbxCU+la8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634838; c=relaxed/simple;
	bh=uTNoa6lDL951+VrXFtqB8boZt2XAVc0sPNk62nN8eHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4njzaketDZdUQVYaknYY+F8bygHZEKHj4lftq7brXBzMHdvXZZmX4Du6ZlFHOfv5G8S2Ew8/ljjZfDjnKfove16WcX6YcOZFskbywfGwipdaJQUEdaefingWzgO/1Xwu3G8YtsIgEVsLCtVZI8TQzsdLz5Uc7WL2/55wa9EQTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=TkZeXLq0; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="TkZeXLq0"
ARC-Seal: i=1; a=rsa-sha256; t=1784634832; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iTNGu6ktd4WbvC3tt7sZAVrDp1KNinmMsQdBasvI6TMD2sk8cIvGf9HQCSDNfXVbp98g3my6qPabhMoSTFTLsHYyLNfzQA1w3RAcAVeKQY/Jsz170w8MXm3vZQBl10vvdM4yv+Ugrg5vLyMcyAuCt2PDvoFCUiBwAJcrP7szL8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784634832; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rU1WkHQOb3meklTzuM7p6qtpmGsfsNjM5cpcbGKHx9U=; 
	b=ORx5V0N1D1av5NXUbihcZ+U+floAF6deiZWK5yqWdQPYOMEiE4apOPvMPuZItQlTcdzbrpSzqO485MP7V4ATRYa2mO6LMs86v+MMJzY8TA+dEvuP2XrAiqJGkB+ALP1jqEwmzOYJFHdnnfzwCmpOyvBmTQEkDqUJFejoAogVAKM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784634832;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rU1WkHQOb3meklTzuM7p6qtpmGsfsNjM5cpcbGKHx9U=;
	b=TkZeXLq0Wix7SPg6MQF1bmRta5xhhDMGHPusu39d+z4qD29Au+BBmTn2PEFh6v7c
	VuTFm0dmzpTJANlXakojF2qnsqk66d83/1bcCyqzjB4zFzOW1Uav/MQJp+ELdn60WO4
	vjKxzzNEcx6Jaaq6W7+5OziBc7wB3/6arffTAK6k=
Received: by mx.zoho.eu with SMTPS id 1784634829901515.1672491023868;
	Tue, 21 Jul 2026 13:53:49 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
Date: Tue, 21 Jul 2026 13:53:46 +0200
Message-ID: <20260721115346.17236-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

hwsim_tx_info_frame_received_nl() casts the HWSIM_ATTR_TX_INFO payload
to a struct hwsim_tx_rate * and unconditionally reads
IEEE80211_TX_MAX_RATES entries (8 bytes) from it. The policy only bounds
the attribute from above (NLA_BINARY .len is a maximum) and the op sets
GENL_DONT_VALIDATE_STRICT, so a short or zero-length attribute is
accepted and the loop reads past the payload.

Require the exact length in the policy, so a malformed attribute is
rejected before the handler runs.

Fixes: 7882513bacb1 ("mac80211_hwsim driver support userspace frame tx/rx")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: enforce the length via NLA_POLICY_EXACT_LEN in the policy instead of
    a manual nla_len() check in the handler, and trim the changelog, per
    Johannes Berg's review.

 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..836dd25e5c61 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -870,9 +870,9 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_FLAGS] = { .type = NLA_U32 },
 	[HWSIM_ATTR_RX_RATE] = { .type = NLA_U32 },
 	[HWSIM_ATTR_SIGNAL] = { .type = NLA_U32 },
-	[HWSIM_ATTR_TX_INFO] = { .type = NLA_BINARY,
-				 .len = IEEE80211_TX_MAX_RATES *
-					sizeof(struct hwsim_tx_rate)},
+	[HWSIM_ATTR_TX_INFO] =
+		NLA_POLICY_EXACT_LEN(IEEE80211_TX_MAX_RATES *
+				     sizeof(struct hwsim_tx_rate)),
 	[HWSIM_ATTR_COOKIE] = { .type = NLA_U64 },
 	[HWSIM_ATTR_CHANNELS] = { .type = NLA_U32 },
 	[HWSIM_ATTR_RADIO_ID] = { .type = NLA_U32 },
-- 
2.50.1 (Apple Git-155)
