Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.130.186.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844610;
	b=vEVpL/ETwepvXjWToUHYHvidd36VyqiG/JHAe+086z5ABZmEQfiepYTA6mdZ3CPQ/B1a
	 2IU/3Tm47R0zULUCCdXbkJKtxDh6FcWmR9JXq6izvzsdncx84BZfRxWrEhq/CWT3FFcUG
	 biK5FJKsuUpL7ihp2VT0ihpXl0GR8xRxGxvfDLOWqUv2aAoX7gUmaloQUG73pXErBO4gr
	 UTI+4g8R/69GzrSAKUkLCoUrRvg77SQoZbEHunT6ddn7mC5EApL6E7A3mpFdcMtgzXKXt
	 6Gpnqzpg7ZWC67RWi832gWyT57mjAWjpsVxNSYzkNPfC+SVkKDswIb8H7kX7HZEydkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844610;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=21TPJL4SKQfCDZ8MGkDhevT3r808Op4LN0xtYduXQVQ=;
	b=AOslbsXnMI+6YFYyDubqhE5Hw7QWSvqEEGRARLtRJ66TyrN7wKCugYblbTpGkjZZYETf
	 FjpqHPNVnPAf3IULr3m0LP8wP7ZWtCTRBRfoiLd8aUiducywJ/S9bu58z2gytK5cFnqKl
	 oZYO0OpzammxxKwPx/WGdL+fOghuuBPVRCozNEbCbiAuqO9JhPdlvc992P94Yu4J3sFOj
	 Q5ToKpanL8Hsa0T+qbYBg6SdzjGw2AlHHJxdwQUwbJpZ4r/uVHsiWYFBTEQNg83Maj9k5
	 5MRskBk2ACnc4RRQFNhZ7XavHu9eKn+PMuwazjIgdUnwbYEluclXjUlCRy6lqEaN3ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hardeman.nu;
	spf=pass smtp.mailfrom=hardeman.nu;
	arc=none smtp.remote-ip=94.130.186.121
Received: from thor.hardeman.nu (thor.hardeman.nu [94.130.186.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AA606A31C;
	Mon, 16 Nov 2026 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardeman.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardeman.nu
Received: from thor.hardeman.nu (thor.hardeman.nu [IPv6:fd27:2a41:8fcb:2::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "thor.hardeman.nu", Issuer "Hardeman Internal Mail Relay CA" (verified OK))
	(Authenticated sender: nullmailer@mil.hardeman.nu)
	by thor.hardeman.nu (Postfix) with ESMTPSA id 4jSstJ6w4QzFpmb;
	Mon, 16 Nov 2026 16:56:40 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardeman.nu;
	s=202608-ed25519; t=1794844601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21TPJL4SKQfCDZ8MGkDhevT3r808Op4LN0xtYduXQVQ=;
	b=r1iQJ6fvGpi7pYaUh85XT56sE0X3IFX5TH5O0vjL2nhckhlQfx2glqqWIU+dAUyom8Xf9g
	JODlt3HvoIwcqcBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardeman.nu; s=202608-rsa;
	t=1794844601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21TPJL4SKQfCDZ8MGkDhevT3r808Op4LN0xtYduXQVQ=;
	b=dm3WUgn0mC9xRhU8rcgpc2rGc4ZQfplZwZTL02njFFTr3LXzUH1ICqvfj7Ky19dhDHNcIn
	gI3UJlbK1xIkucKys8SiMQWLaNvbDnwEHV0dIU0EblKLbXhUWZaqzy/DQoaSCS5MggNLkz
	YlUo0UE18YzqGMHqRcoq82pRytLseRW8zI+EsKTdW6jwkIpF90c0DJFIAH+PCIo5yZAuUF
	8WfKsIL8Lo46nnyN18frttp1x3c/WW4XfREdf3dk9cQaRuRKKW49FTmh942nlc+qmwtjvC
	RV6AjLpVMdzzR5/Qo0aZKuRRuh2+OCkIQpqFLVz0/IlDSmryRkdcQ4oD62SZSA==
Received: from mil.hardeman.nu ([fd27:2a41:8fcb:2::f])
	by thor.hardeman.nu with ESMTPSA
	id L2P7N7gn+2qV7igAWTs42w
	(envelope-from <david@mil.hardeman.nu>); Mon, 16 Nov 2026 16:56:40 +0100
Received: (nullmailer pid 535624 invoked by uid 2002000001);
	Mon, 16 Nov 2026 15:56:38 -0000
From: =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: iwlwifi: mld: release frames before one beyond the window
Date: Mon, 16 Nov 2026 16:56:09 +0100
Message-ID: <20261116155609.535595-3-david@hardeman.nu>
In-Reply-To: <20261116155609.535595-1-david@hardeman.nu>
References: <20261116155609.535595-1-david@hardeman.nu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iwl_mld_reorder() has the same problem as iwlmvm had: a frame with
SN >= head_sn + buf_size, which a transmitter sends after giving up on
an older MPDU without a BAR, is stored in the slot of head_sn, and
iwl_mld_reorder_release_frames() then passes it to mac80211 ahead of
the frames before it, which all fail the PN check.

Release the older frames first, up to min(sn, nssn), as iwlmvm did
before the reorder buffer was simplified, and add a KUnit case for it.

Not tested on hardware (seen and tested with iwlmvm on an AX210); the
new KUnit case fails without the fix (SN=164 is released first) and
passes with it.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Härdeman <david@hardeman.nu>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  | 14 ++++++++++
 .../wireless/intel/iwlwifi/mld/tests/agg.c    | 28 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index ea1f02380ad..6b3c311a3d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -305,6 +305,20 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 		return IWL_MLD_PASS_SKB;
 	}
 
+	/* A frame beyond the end of the reorder window means that the
+	 * transmitter gave up on older frames without sending a BAR. The
+	 * firmware moves the window (NSSN) for it, but the frame would be
+	 * stored in the slot of an older SN and released ahead of the frames
+	 * before it, which would then all fail the PN check. Release the
+	 * older frames first, as for a BAR.
+	 */
+	if (!ieee80211_sn_less(sn, ieee80211_sn_add(buffer->head_sn,
+						    baid_data->buf_size)))
+		iwl_mld_reorder_release_frames(mld, link_sta, napi, baid_data,
+					       buffer,
+					       ieee80211_sn_less(sn, nssn) ?
+					       sn : nssn);
+
 	/* put in reorder buffer */
 	index = sn % baid_data->buf_size;
 	__skb_queue_tail(&entries[index].frames, skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
index e9efe2996f0..8fec274cc25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
@@ -426,6 +426,34 @@ static const struct reorder_buffer_case {
 			.head_sn = 100,
 		},
 	},
+	{
+		.desc = "RX packet beyond the reorder window, release older packets first",
+		.rx_pkt = {
+			.fc = FC_QOS_DATA,
+			.sn = 164,
+			.nssn = 165,
+		},
+		.reorder_buf_state = {
+			.valid = true,
+			.head_sn = 100,
+			.num_entries = 2,
+			.entries[0].sn = 101,
+			.entries[1].sn = 102,
+		},
+		.expected = {
+			/* 1. Reorder buffer contains SN={101, 102}, hole at 100.
+			 * 2. RX packet SN=164 = head_sn + BA_WINDOW_SIZE: the
+			 *    transmitter gave up on SN=100 (no BAR), NSSN moves
+			 *    past it. SN=164 maps to the slot of SN=100.
+			 * The stored packets are released before the RX packet.
+			 */
+			.reorder_res = IWL_MLD_BUFFERED_SKB,
+			.num_stored = 0,
+			.head_sn = 165,
+			.skb_release_order = {101, 102, 164},
+			.skb_release_order_count = 3,
+		},
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(test_reorder_buffer, reorder_buffer_cases, desc);
-- 
2.47.3

