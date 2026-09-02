Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8A33D4E2;
	Wed,  2 Sep 2026 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324992; cv=none; b=c88jG/eoJGjKqZM2JoOKTxnvzhebaTwS1XwL1YZWH9aPG7QLYOaqu5KTY7zPWf7p/h2q0Rs82TsYAUSz1AjKmMLzoNAdGeyr4hOWkAoKD2ewiMX7kBy9/ITw74KnPyBHbIw84PwAKGtzEys3To2pyZOiH2AiV65XrH21D36K6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324992; c=relaxed/simple;
	bh=9H2NsKcatxlkN4UpoKa0kMyWhmzXbWvQuSasJ4GGAF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QvHWpqcNnV/ctCWeUE1u2WX4dg1hI3ylHQa93cuL5zbf+2zbT8yiN8eVs7jfGWsW6wlLEUzA38ovQv4BnL9dl7cDOdbMDn6FyAOw+uEjSRgUBiXzCuFFzzjuFC/55OxJyYdcqF1ECv8+8SLMrCtw2JQIvqLjwVG4dTbj/YGqukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LspGvBhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LspGvBhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 789D7C2BCC7;
	Wed,  2 Sep 2026 04:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788324991;
	bh=9H2NsKcatxlkN4UpoKa0kMyWhmzXbWvQuSasJ4GGAF8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LspGvBhQMh3gxx0Q+YxJPFKRO/6MarOn3OU5cbgXRxTobMe5cyetBtGXAS7AqqpM9
	 uPMNsu+z/KghSP4qXxISBvvLxLFGQsc7GM6s3Z72ote44VMOzy65EN/OTkHbTWdD25
	 XViqNLDSOj6BUyVSyk6lOgIO3/c2DfcaONwaj2RXsDE3Wml6nT7w+sy4oVdpbgJ3q7
	 yFZ+w69PcfUwKOOPzKpcd0bQcZZbYpgdUsS+Ld0gVOv5r3PWtEk/PAy66rbncDlJ2s
	 TrYchX1x/mFSa9Ltt+dm2JkTqb5FAUEs2awS5C94EWdh35fxXxfQxRJLZ9r8D5FYgC
	 iRwjEnfMG24Kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F59C61DD6;
	Wed,  2 Sep 2026 04:56:31 +0000 (UTC)
From: Sperrbert via B4 Relay <devnull+sperrbert.proton.me@kernel.org>
Date: Wed, 02 Sep 2026 06:56:13 +0200
Subject: [PATCH] wifi: iwlwifi: mvm: fix VHT NSS reporting for legacy RX
 API
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-master-v1-1-a2cc0a65ce12@proton.me>
X-B4-Tracking: v=1; b=H4sIAGysl2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMj3dzE4pLUIl2DxOQUgzRzk5Q0Y0sloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0A+QIyhWoAAAA=
X-Change-ID: 20260902-master-0acd0f74df39
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sperrbert <sperrbert@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788324990; l=1903;
 i=sperrbert@proton.me; s=20260902; h=from:subject:message-id;
 bh=/4vIsjR1iXuI+GVen+yjkyDz9ZsAQbCF2/9KiJ5Y6q4=;
 b=ZGRpShq2jaDCmTRs/2rwAYCGEwyDQ+V0mYpd3peVBHM8zxMpbVdIrRzZoT7VpP7vJtiyIj5wR
 45Pnal/sF3HApAcor6gbCdTTd5dJsqsW4vuShHEBQp6/YWyrBxGWSxJ
X-Developer-Key: i=sperrbert@proton.me; a=ed25519;
 pk=I4XYiGGbh8WAF7fk5prqJ3RawLcpmMRrm1y+qO0YOf8=
X-Endpoint-Received: by B4 Relay for sperrbert@proton.me/20260902 with
 auth_id=996
X-Original-From: Sperrbert <sperrbert@proton.me>
Reply-To: sperrbert@proton.me

From: Sperrbert <sperrbert@proton.me>

Commit 774302d2d3ad ("wifi: iwlwifi: mvm: clean up duplicated defines")
replaced the explicit legacy VHT NSS decoding with
RATE_MCS_NSS_MSK, which was equivalent at the time.

Commit dabc88cb3b78 ("wifi: iwlwifi: handle v3 rates") later changed
RATE_MCS_NSS_MSK for the v3 rate format, where NSS is encoded at a
different bit position. The legacy RX path, however, still handles
VHT rate_n_flags using the v1 format.

As a result, two-stream VHT RX rates on older devices can be reported
as NSS 1. Use RATE_VHT_MCS_NSS_MSK when decoding VHT NSS in the
legacy RX path.

On an Intel Wireless-AC 7260, an unmodified kernel reports VHT NSS 1
while receiving about 460 Mbit/s. With this change the same connection
is correctly reported as VHT NSS 2, with unchanged throughput.

Fixes: dabc88cb3b78 ("wifi: iwlwifi: handle v3 rates")
Cc: stable@vger.kernel.org
Signed-off-by: Sperrbert <sperrbert@proton.me>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index ab1eb2eb0c3cd..124a5f52c53d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -502,7 +502,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->nss =
-			FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1;
+			FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate_n_flags) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;

---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260902-master-0acd0f74df39

Best regards,
--  
Sperrbert <sperrbert@proton.me>


