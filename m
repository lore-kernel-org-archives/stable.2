Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E742F718
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579759; cv=none; b=AjdImct+fI43YY2u6G5V9QE4laxHRr5F8ReXJlkA0Su4UzOLPY8v03IIoApo3m5I+xBS065m8/kbpi0g7W+tGlnBkHtQVD0llOUr2Nx4Gf9URnfU0ZjObwhUDtiIGa0c5r6TCWLTrNpH2TFIix1HKc/SAdF1SFbO2nSamndMdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579759; c=relaxed/simple;
	bh=anNHvv1K44RevnBk6CsZNTiRb3xHd+fhANuv/lRDNks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tBh2R8bngUC4Mecc7SHkgoh4BGYv8+5r1HRJK+anRkXFFPmQZkyCfZFmA3jIy7xb6ws++coBPl8rfrHvKSfeaebV9pvD8Miq0FbvNVr3W86v90D//eqNGjuSm5omgzlTL+Sgp9Mgws+T30lMbXQx0CLQgQfnOTb0LQRT4fnUHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T5InLg2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T5InLg2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBC1F00A3A;
	Mon, 24 Aug 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787579758;
	bh=UU0gA1BrqAc4+23HJap7Ery3txZN4F9EuZmO9PD655w=;
	h=Subject:To:Cc:From:Date;
	b=T5InLg2JwILR/yV8DfyiDe/2E2Td697dwV1YRGxlrLAJ+MRaT8XgIjQIpYiMtLoy/
	 LQxqobw+jqGiViH+Y/hvc1d3400hoExNDtolrLazypsgulT5xe2ZjP6VoAyLHg3sdb
	 I9ZzZvRvq1yfmwJvs9uw15AHfIRtTLTpF3XbTybk=
Subject: FAILED: patch "[PATCH] nfc: nci: add data_len bound checks to activation parameter" failed to apply to 6.12-stable tree
To: hexlabsecurity@proton.me,david@ixit.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 15:55:54 +0200
Message-ID: <2026082454-almanac-viewpoint-5985@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0428fa2c22e2ba0cff766d3b80d461e149102045
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082454-almanac-viewpoint-5985@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0428fa2c22e2ba0cff766d3b80d461e149102045 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 12 Jun 2026 12:50:25 -0500
Subject: [PATCH] nfc: nci: add data_len bound checks to activation parameter
 extractors

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

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..8bc3adbc5b6b 100644
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
 		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
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
@@ -806,12 +822,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
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

