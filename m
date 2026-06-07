Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BC35836A
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825725; cv=none; b=Chb93kc3T5IFxU41ajPKGDWycmskchaqOAe+nJ44At8KCUM4cJ/NJY0Ir0winhPZG+TU7YfAgMe7H1Pqt05tH/xsk8b/EXHGPjSDjgFIlmhIocePAHB80pqgnf9y0SY57KQQuTCGrVReBzluci1u3Wb2vDqlEzRISMquxGdjHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825725; c=relaxed/simple;
	bh=1rNxc1UaHTRXu5r2v0ow8mgrPehoHCYlRVkX/lQ2tCY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K+unBw7J2omOONs0R/EOs74XGIqs/D7o39uUS7mDuGdNw5NlbhTSi38P0YaHRuy9iTjMXW5hqCfhYj2MN0xu975NEU0zmqnkLCXmobgPmlbAUoqYQ4WDj+B0Fo8SUxJy1QomdP+Un4g+o2MFM7zJkfEdl7n7GT7oihatyEZHc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GZDkZ9L5; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GZDkZ9L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780825713; x=1781084913;
	bh=vQSZRMpoGuLhm10iyqcc9wChC3iOe39cE9LVFeXeHg4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GZDkZ9L5PYFKW97IaLe1KAMMkntmVvjsYUoRDA8qAwH51QrHlFM2lHZt0IBOe2EA+
	 M3pshDse/KEn4MXrFrbmluOYx60RYJxvO8/cP4Y7o+fvaKUph92tUMsOkndIUM3RQo
	 UWaGW4yAUEXReYVlPqfzzk2QlQItxCBzWRtk2KzCXiDU17EVnv1mx/kj1B1rzJkX3W
	 Z0OpLrJr+5jp4ofTjt6KuMXHhot6L+EFdZ2KtVnKsZ/21HGVpPZbFgXop87c9w/qaW
	 VvCMkl+SSqVwcnydLYeO3KY5gl4BinX8SIZDykNQxCePOYOxpQt/EdGIf94YL4YuDX
	 hZ72/2Fl06K1A==
Date: Sun, 07 Jun 2026 09:48:26 +0000
To: David Heidelberg <david+nfc@ixit.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: nci: add data_len bound checks to activation parameter extractors
Message-ID: <20260607094822.322125-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ee73fa13d558072a404361bd75a1ace81025cebc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

nci_extract_activation_params_iso_dep() and
nci_extract_activation_params_nfc_dep() read an inner length byte from
the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
kernel buffers, but neither function receives the caller-validated
activation_params_len.  A crafted NCI notification with
activation_params_len=3D1 and an inner length byte of up to 20 (NFC-A) or
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
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Verification (NFC-A ISO-DEP, NFC_ATS_MAXSIZE =3D 20):

  data_len  inner_len  without patch              with patch
  --------  ---------  -------------------------  --------------------
  1         0          rats_res_len=3D0, clean       same
  1         1          memcpy +1B OOB              clamped to 0, clean
  1         20         memcpy +20B OOB  <-- PoC   clamped to 0, clean
  2         2          memcpy +1B OOB              clamped to 1, clean
  21        20         memcpy 20B clean            same

NFC-B (attrib_res, max 50) and NFC-DEP poll/listen (atr_res/atr_req,
max 62) have the same shape and receive the same fix.

 net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..753f4cf08748 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
*ndev,
=20
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 =09=09=09=09=09=09 struct nci_rf_intf_activated_ntf *ntf,
-=09=09=09=09=09=09 const __u8 *data)
+=09=09=09=09=09=09 const __u8 *data, __u8 data_len)
 {
 =09struct activation_params_nfca_poll_iso_dep *nfca_poll;
 =09struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
=20
 =09switch (ntf->activation_rf_tech_and_mode) {
 =09case NCI_NFC_A_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09nfca_poll =3D &ntf->activation_params.nfca_poll_iso_dep;
 =09=09nfca_poll->rats_res_len =3D min_t(__u8, *data++, NFC_ATS_MAXSIZE);
+=09=09data_len--;
+=09=09nfca_poll->rats_res_len =3D min_t(__u8, nfca_poll->rats_res_len, dat=
a_len);
 =09=09pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 =09=09if (nfca_poll->rats_res_len > 0) {
 =09=09=09memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struc=
t nci_dev *ndev,
 =09=09break;
=20
 =09case NCI_NFC_B_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09nfcb_poll =3D &ntf->activation_params.nfcb_poll_iso_dep;
 =09=09nfcb_poll->attrib_res_len =3D min_t(__u8, *data++, 50);
+=09=09data_len--;
+=09=09nfcb_poll->attrib_res_len =3D min_t(__u8, nfcb_poll->attrib_res_len,=
 data_len);
 =09=09pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 =09=09if (nfcb_poll->attrib_res_len > 0) {
 =09=09=09memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct=
 nci_dev *ndev,
=20
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 =09=09=09=09=09=09 struct nci_rf_intf_activated_ntf *ntf,
-=09=09=09=09=09=09 const __u8 *data)
+=09=09=09=09=09=09 const __u8 *data, __u8 data_len)
 {
 =09struct activation_params_poll_nfc_dep *poll;
 =09struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struc=
t nci_dev *ndev,
 =09switch (ntf->activation_rf_tech_and_mode) {
 =09case NCI_NFC_A_PASSIVE_POLL_MODE:
 =09case NCI_NFC_F_PASSIVE_POLL_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09poll =3D &ntf->activation_params.poll_nfc_dep;
 =09=09poll->atr_res_len =3D min_t(__u8, *data++,
 =09=09=09=09=09  NFC_ATR_RES_MAXSIZE - 2);
+=09=09data_len--;
+=09=09poll->atr_res_len =3D min_t(__u8, poll->atr_res_len, data_len);
 =09=09pr_debug("atr_res_len %d\n", poll->atr_res_len);
 =09=09if (poll->atr_res_len > 0)
 =09=09=09memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struc=
t nci_dev *ndev,
=20
 =09case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 =09case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+=09=09if (data_len < 1)
+=09=09=09return -EINVAL;
 =09=09listen =3D &ntf->activation_params.listen_nfc_dep;
 =09=09listen->atr_req_len =3D min_t(__u8, *data++,
 =09=09=09=09=09    NFC_ATR_REQ_MAXSIZE - 2);
+=09=09data_len--;
+=09=09listen->atr_req_len =3D min_t(__u8, listen->atr_req_len, data_len);
 =09=09pr_debug("atr_req_len %d\n", listen->atr_req_len);
 =09=09if (listen->atr_req_len > 0)
 =09=09=09memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -806,12 +822,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 =09=09switch (ntf.rf_interface) {
 =09=09case NCI_RF_INTERFACE_ISO_DEP:
 =09=09=09err =3D nci_extract_activation_params_iso_dep(ndev,
-=09=09=09=09=09=09=09=09    &ntf, data);
+=09=09=09=09=09=09=09=09    &ntf, data,
+=09=09=09=09=09=09=09=09    ntf.activation_params_len);
 =09=09=09break;
=20
 =09=09case NCI_RF_INTERFACE_NFC_DEP:
 =09=09=09err =3D nci_extract_activation_params_nfc_dep(ndev,
-=09=09=09=09=09=09=09=09    &ntf, data);
+=09=09=09=09=09=09=09=09    &ntf, data,
+=09=09=09=09=09=09=09=09    ntf.activation_params_len);
 =09=09=09break;
=20
 =09=09case NCI_RF_INTERFACE_FRAME:
--=20
2.43.0


