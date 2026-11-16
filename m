Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.130.186.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844610;
	b=MPSecR4kxMeO0EjPqsobjPLlrZSq9QimifrxuVYoLSVA/Xd5MzE3S4NldKJaZ/Ku0uET
	 SjhoEYPDl2wg39NIeCKYzL2RnMrpeNKApFWKkvJ9PLnbsHkpiAGGjsS7KPuDQERhXurGx
	 GFQ1NJ5fO0VoAIxdCAASWWXpMf+FMiWhnAcmDTs4hZXKNoWfF9FP5UC8rmzduf+2twFpp
	 r+vgeA5GNdqppc6qTUqqK8LgmfI6jBWTii2fQub9uoCpYxJlm3uzphT9N608BKJfpcncj
	 uOqUNotdoEAfYMFxQViu+/nrOxknPRW3WuMaB9KGBsFJMBs2Mjsm14s9r9ZS79Ealvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844610;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y9DYKsYoecSdNmX9SvDsJrsO61W5/drf8na13hvzLUQ=;
	b=kB6dLWm41VYxYh/Zze9gF9D1CylCxXVm6IZ9m68yAGQCSXcutEZbjE5AC8XMCKuMkzSq
	 Broe46jgczlwbtIjRyLlvff+OwzaZynbiMILp251TKxaYt3F37Tqg/l02W+nCbY7NOzYm
	 eoHa7DMlhb0ZDDuU1yUCTAjxgOl40707SsNdmu1l6oTawuOP3J83rptRZYA2pV6LxXeJj
	 9XjLXCMKFn1oK3gAjatpsfWBL7Kf7PfWy5bMYzY+f0gK6TSJGubEIb190te3dSM2B43c/
	 pEnBtyrSCUAJb5lnC6H3SVdsn9r0adQgfa0I8yRqCzaCyr1VuvnV1wKr9LbSZT5AAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hardeman.nu;
	spf=pass smtp.mailfrom=hardeman.nu;
	arc=none smtp.remote-ip=94.130.186.121
Received: from thor.hardeman.nu (thor.hardeman.nu [94.130.186.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445E606A323;
	Mon, 16 Nov 2026 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C445E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardeman.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardeman.nu
Received: from thor.hardeman.nu (thor.hardeman.nu [IPv6:fd27:2a41:8fcb:2::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "thor.hardeman.nu", Issuer "Hardeman Internal Mail Relay CA" (verified OK))
	(Authenticated sender: nullmailer@mil.hardeman.nu)
	by thor.hardeman.nu (Postfix) with ESMTPSA id 4jSstJ2YZmzFpkF;
	Mon, 16 Nov 2026 16:56:40 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardeman.nu;
	s=202608-ed25519; t=1794844600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9DYKsYoecSdNmX9SvDsJrsO61W5/drf8na13hvzLUQ=;
	b=YcX//DQsPBRLrEGpfAGwyO2xclAuP/hIrImlChwWhjTOUN/adyMuNw+A+xWONud4xzgRIP
	MQMZyiCxIKG9/PAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardeman.nu; s=202608-rsa;
	t=1794844600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9DYKsYoecSdNmX9SvDsJrsO61W5/drf8na13hvzLUQ=;
	b=m/ZVc+u4iXqWLbr6tu1Fs77TWbbw67tLWDcVl8UR0az0XjF/3hSrURacv6XpJfYek0Eikq
	2eAqGQLSFfJTy5ScjpmxthK3EcRrpjm/7VVM3z/3iUi8rAdkBOxEBCcJlWXuVK13k9vcXa
	1EhQxRgOBbM+TAKeHHnpXdubFEmYyI6bdZPNWdRNsbjMGPCThm51cVNYZ5TiFbsb8Fklp4
	lejLUQnxsrFuxxw5GxNzaNMDPIM0d20y8GzTIt36+3inEmxW7Ry2Udx5YRQZQDxikYrnI3
	f/Q2wOxdDyEW6mKgFrF4FNxOb4eICEXqFzlHfsoh9ZK+vQ/N/6KbfDVH5pmaiA==
Received: from mil.hardeman.nu ([fd27:2a41:8fcb:2::f])
	by thor.hardeman.nu with ESMTPSA
	id LlefErgn+2qQ7igAWTs42w
	(envelope-from <david@mil.hardeman.nu>); Mon, 16 Nov 2026 16:56:40 +0100
Received: (nullmailer pid 535621 invoked by uid 2002000001);
	Mon, 16 Nov 2026 15:56:38 -0000
From: =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: iwlwifi: mvm: release frames before one beyond the window
Date: Mon, 16 Nov 2026 16:56:08 +0100
Message-ID: <20261116155609.535595-2-david@hardeman.nu>
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

If a transmitter gives up on an MPDU of a BA session without sending a
BAR and keeps sending, it can send a frame with SN == head_sn + buf_size
(or beyond). The firmware then moves the window and reports an NSSN
past the hole, but iwl_mvm_reorder() first stores the frame at
sn % buf_size, which is the slot of head_sn. iwl_mvm_release_frames()
starts at head_sn and so passes the new frame to mac80211 ahead of the
buf_size - 1 frames before it, and those then all fail
iwl_mvm_check_pn(): one lost frame turns into buf_size lost frames.

Seen with an AX210 (iwlmvm, 7.2.15) on an rtw88 AP during client
background scans: bursts of up to 63 PN-replay drops per lost frame
(two such bursts back to back when two holes were close together), each
starting with the frame at hole + 64 (traced at iwl_mvm_release_frames,
e.g. SN 447 PN 0x1bb3f0 passed, then SN 384-446 with PN
0x1bb3b1-0x1bb3ef dropped).

The driver used to release frames up to min(sn, nssn) for a frame
outside the window; that check went with the RSS-sync logic. Restore
just the window check.

With the fix, the PN-replay drops in that setup went from about 280 to
about 12 per client scan.

Fixes: ff8e3a40d78b ("wifi: iwlwifi: mvm: simplify the reorder buffer")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Härdeman <david@hardeman.nu>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 77a3d8dcab5..c2fdc3a5155 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -899,6 +899,19 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		return false;
 	}
 
+	/*
+	 * A frame beyond the end of the reorder window means that the
+	 * transmitter gave up on older frames without sending a BAR. The
+	 * firmware moves the window (NSSN) for it, but the frame would be
+	 * stored in the slot of an older SN and released ahead of the frames
+	 * before it, which would then all fail the PN check. Release the
+	 * older frames first, as for a BAR.
+	 */
+	if (!ieee80211_sn_less(sn, ieee80211_sn_add(buffer->head_sn,
+						    baid_data->buf_size)))
+		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer,
+				       ieee80211_sn_less(sn, nssn) ? sn : nssn);
+
 	/* put in reorder buffer */
 	index = sn % baid_data->buf_size;
 	__skb_queue_tail(&entries[index].frames, skb);
-- 
2.47.3

