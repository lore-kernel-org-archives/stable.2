Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227753F6613
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756051; cv=none; b=ugZH4Mp7JJVWf7LkRo7TZBXAKNcL3yJa6vCUSch1B0dWJTWPqTi3e0x0VTFB0a7YYgaalPN7w4Uq+G+uJZCPAHoIc6vbZhxZaZoi/nkHyc1xUSkJV4Kf9tC9fYpXAPFDGgidtfXkB0wtb6yr4IF0ooawsXjvYoXXcp2abewNDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756051; c=relaxed/simple;
	bh=vYr91Jzuqr6ZXi11WKR30nnv2ljkHTHC9j4LI1+++5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAqab/s/o/RLKp2jeofYgM08aYZwPeI8ssfXLgWvI/vAaly7IkQjDrN3Ipfwi0AAcJNj2M+QNbbm9YWokQ2Es6U/8plLFpcusJ7su8RIyYBzOxA903iuwZYB3+cEt/H8HxF5tdBTiDKeplY+A558+a3Vg/TPuHiTAhYyUGC7WL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXfk70rB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXfk70rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842801F00A3A;
	Wed, 26 Aug 2026 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756050;
	bh=8Di/QAttjn474wR7eVAa6Dnc1xQv+b599MX0FEVykQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXfk70rBY169KQhdJ1akWaW+Mw2RCDQ1oLNaEFQLRjU4y0B/9W7jZrQLcxcosFNgo
	 cD6Vzw3/qmqXyrYD/s5cri1uLBxKqS2oFRzRVTHBLFYmUngGOVBNpFAo/sFSzlhe1b
	 0GBovAthfyiF3O9TF05oC/NSq/NnCJcte75oZQRR4hSOieNntMDBItRy6ymIrtawhF
	 TT5rJbI9QiL6FYEq6rNtqxQ/BB2oec/9cQMUpWXsqnB7okbrcyNGyoJzpIOVE3imSb
	 1O4sOIQGOrFDP6htK+YdCsdmGbJ2+Y4WRyQdSSf90GXdJzNdHgvHH7pTs9C6eypzvx
	 jZi9/LH+6uWcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	David Heidelberg <david@ixit.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfc: nci: add data_len bound checks to activation parameter extractors
Date: Wed, 26 Aug 2026 10:54:07 -0400
Message-ID: <20260826145407.876854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082456-cyclist-thirteen-0fc9@gregkh>
References: <2026082456-cyclist-thirteen-0fc9@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/ntf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f8b20cddd5c96..4710c0478e89d 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -371,15 +371,20 @@ static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 }
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
-			struct nci_rf_intf_activated_ntf *ntf, __u8 *data)
+			struct nci_rf_intf_activated_ntf *ntf, __u8 *data,
+			__u8 data_len)
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
@@ -388,8 +393,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
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
@@ -407,7 +416,8 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 }
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
-			struct nci_rf_intf_activated_ntf *ntf, __u8 *data)
+			struct nci_rf_intf_activated_ntf *ntf, __u8 *data,
+			__u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -415,9 +425,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
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
@@ -425,9 +439,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
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
@@ -597,12 +615,14 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
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

