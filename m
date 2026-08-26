Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52B3C3C16
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741869; cv=none; b=ZEvA4gLzAlvlL1aq2P9TbpzqVnmTMjqNaHCLTNH7oWURcABgMzV2B27rvBvNzdpej5ENNxgkCo2eC/fRZ7cGifU7mxrMKNDvDiywMKIiDgVZXUL6nwGRvmVIvkDe8EmQl2QMZvlmXZ+9Uj4gXAIcfFRvEa+F1MSCLVnTCiZ4210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741869; c=relaxed/simple;
	bh=BacKFELyEFpOmVu8pcWp3VTaRmnfXqCkMNRKQbLpiEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+CPH99zntgpWDusBVzuJyTyBLbr93EMPAcUEv4tgUYm4DwUh083yUCseI9dfvi00MvMktdVddjWG5X4q+hJc3KHzBWiKPc5dQAPYnx4Vu3kM4TPVNxiBQ0yzNDZMNwJxfav+K4YSbjBGufdQqIaljitcitIWCMEhYp4EEXS+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y41I4BcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y41I4BcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725F51F000E9;
	Wed, 26 Aug 2026 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787741858;
	bh=/T/qTAGgakzq9+AKeBg6nnaeHOYNlwifZ6He/Kp9X4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y41I4BcKy+jYHDAW+izTItZjlr+fiYqOLjFlS4u+Q2oJGRxx24TUppNR8eTspFCe6
	 GMot0CUI+BNp5dfJw5QLJzoHx4bFYWd5C4YdnW2tC6Am45qFvYlpXTn0oEIH5KLm/h
	 EbLpLyriNyLXHfpHEPstrsqopu8VcnQbqo9ZxTwNOID2PUAFnRsGJ722djDJFQ8v6M
	 lN8acJBphgehRucYgh/DT3O86xpfnxR5+7sdgODj3dAAGmyLMj7qn28L/RoozbCFEG
	 WVJ497e0TFclF7pWCw8WGBCJHE5EWXaGb3NqmOsEVRJEHQLz/4m41lMKod0ocL/FCc
	 uWA/XXtZi/gyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	David Heidelberg <david@ixit.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfc: nci: add data_len bound checks to activation parameter extractors
Date: Wed, 26 Aug 2026 06:57:34 -0400
Message-ID: <20260826105734.2608614-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082454-almanac-viewpoint-5985@gregkh>
References: <2026082454-almanac-viewpoint-5985@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 0428fa2c22e2ba0cff766d3b80d461e149102045 ]

nci_extract_activation_params_iso_dep() and
nci_extract_activation_params_nfc_dep() read an inner length byte from
the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
kernel buffers, but neither function receives the caller-validated
activation_params_len.  A crafted NCI notification with
activation_params_len=1 and an inner length byte of up to 20 (NFC-A) or
50 (NFC-B) causes memcpy() to read that many bytes past the one valid
byte in the activation params region -- a slab out-of-bounds read of
kernel memory adjacent to the NCI skb.

The sibling nci_extract_rf_params_*() family was given equivalent
protection by commit 571dcbeb8e63 ("net: nfc: nci: Fix parameter
validation for packet data"), but the two activation parameter
extractors were not updated at that time.

Add a data_len parameter to both functions, guard against an empty
region before consuming the inner length byte, decrement the remaining
count after consuming it, and clamp the copy length to what is actually
available.  Update both call sites to pass ntf.activation_params_len,
which is already validated against the skb at ntf.c:801.

Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260612-b4-disp-6d52d8b0-v3-1-e26221f8826d@proton.me
Signed-off-by: David Heidelberg <david@ixit.cz>
[ Replaced `NFC_ATS_MAXSIZE` with the literal `20` since that macro doesn't exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index df0f1200082cf..9ed908c1230b6 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
 
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, 20);
+		data_len--;
+		nfca_poll->rats_res_len = min_t(__u8, nfca_poll->rats_res_len, data_len);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 		break;
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
+		nfcb_poll->attrib_res_len = min_t(__u8, nfcb_poll->attrib_res_len, data_len);
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
 			memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll = &ntf->activation_params.poll_nfc_dep;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
+		poll->atr_res_len = min_t(__u8, poll->atr_res_len, data_len);
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
 		if (poll->atr_res_len > 0)
 			memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen = &ntf->activation_params.listen_nfc_dep;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
+		listen->atr_req_len = min_t(__u8, listen->atr_req_len, data_len);
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
 		if (listen->atr_req_len > 0)
 			memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -784,12 +800,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
 			err = nci_extract_activation_params_iso_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_NFC_DEP:
 			err = nci_extract_activation_params_nfc_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_FRAME:
-- 
2.53.0

