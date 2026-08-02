Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D403B19BC;
	Sun,  2 Aug 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672869; cv=pass; b=X+DhsLf25AGenccofAz38rVljbpFMeRsJJxNIJisPEqLuMiWWENITjdGIkAd8QpBJOxg7nEBnaTgSuFUyi5F00N4y7qnstRfh/eYVXoVEG8QcZ+bHExpHFIm9FQxC7Z0JqrGsLBipDCWC7QYIzhbjGKwtNxI17FglJVtNBETVWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672869; c=relaxed/simple;
	bh=OPbLElIkHo/wqkPmMFVscbCIHgECPNyFagn14aio6KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOJSM/yDCsay+bxQBADiTZJB4E2U33s8fKz8Bg4rZrYU/LTOKCNUcPAor/XMAoyDu79AGZjBlLbQerT5ODTRwwv7qGuFqjy1oe69HiVVo0D4hRat5oBBaT0dEkfZxvfnTcL0AiKXJQ+2+wC/2GfePYm9LZWGjEkZugZUjhsZxlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=BKTRLrUw; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="BKTRLrUw"
ARC-Seal: i=1; a=rsa-sha256; t=1785672848; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N+uma7GOM3V20tXQFo1SQEr+g76aIRr0+5fXkOTMQRedqtgF9rHjc09CxkAHhOzkoXwx2t1VUBCcaK0IfJNmYWXZ+n6A4d6V67anbevL7pnGkonkLtARbPJx1ucSwJfr2/VbGggF+OehScuJf1bxRVfdSR34u5HFGUT9Mn8vi3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785672848; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hVfIqyAxZc11cL68bNSZ6AEkiUZdqHgG8bCKLzr4WVo=; 
	b=NWhneQlxkZFQ49t8Sq30J1HeP5cYAltFyS7y51/3QCVyiLtctzNcfUi7TJuW6A6nommxcXvfJO8uIG+xUqpx+rgMLGRFA4QeBN1Be374SjULgDk4xfIOyE43xaGnkB8xGKX06hS/VxlhlEmi3PZ+4Y7kCyqPC5uanOoEmSvySdM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785672848;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hVfIqyAxZc11cL68bNSZ6AEkiUZdqHgG8bCKLzr4WVo=;
	b=BKTRLrUwXyLEfpEe7HSvnWsKwndA9DqvxABxhTlpwnKhYjCiac5Q4dMugz89Tlzi
	WlBgijNPo6gITSl5awrRxvLV7kaHaLewuYSmjCby69/XsHEQUAGSZ5/eiSeeyztkWI/
	7Fc6YuLnVYPNXqZIHgbOjH5w/36tLmnioI0ZZ0M8=
Received: by mx.zoho.eu with SMTPS id 1785672845983951.2405778335522;
	Sun, 2 Aug 2026 14:14:05 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: validate HT capability IE length before use
Date: Sun,  2 Aug 2026 12:13:54 +0000
Message-ID: <20260802121354.14245-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

rtw_get_ie() reports the length byte straight out of the frame and does
not impose a minimum, so a received HT capability element can be any
size from 0 to 255. Five callers only test that the length is non zero
and then cast the element body to a fixed layout:

	p = rtw_get_ie(..., WLAN_EID_HT_CAPABILITY, &len, ...);
	if (p && len > 0) {
		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
		ht_cap_info = le16_to_cpu(pht_cap->cap_info);

cap_info is 16 bits, so a element declaring a length of 1 makes the
driver read one byte beyond the element. rtw_update_ht_cap() goes
further and takes ampdu_params_info at offset 2, and
rtw_check_beacon_data() writes back into cap_info.

Mostly this only produces a wrong cap_info, because the element area is
the fixed 768 byte ies[] array and the extra byte is still inside it.
rtw_check_bcn_info() is different: its struct wlan_bssid_ex comes from
kzalloc() and ies[] is the last member, so a beacon that fills the area
to MAX_IE_SZ and ends with a truncated HT capability element reads one
byte past the allocation.

Require the full element before dereferencing it, which is what
mac80211 does in ieee802_11_parse_elems_full():

	if (elen >= sizeof(struct ieee80211_ht_cap))
		elems->ht_cap_elem = (void *)pos;

The neighbouring HT operation blocks read infos[0] only and are left
alone, a length of 1 is enough for them.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Found by auditing the IE parsers in this driver for length checks that do
not cover the structure being cast onto the element body.

Tested by lifting rtw_get_ie() and the rtw_check_bcn_info() caller into a
userspace harness under ASan, with the element area as an exact 768 byte
allocation so the redzone sits where ies[] ends, and a beacon whose last
element is a HT capability with a declared length of 1:

  HT cap IE at offset 765, body ends at 768, area ends at 768
  ERROR: AddressSanitizer: unknown-crash
  READ of size 2 at 0x7d028e5e037f
    #0 in main harness.c:106
  0x7d028e5e0380 is located 0 bytes after 768-byte region

With the check changed to len >= sizeof(struct ieee80211_ht_cap) the
element is rejected and ASan is quiet. I do not have RTL8723BS hardware,
so this is the parsing code exercised out of tree rather than a live
driver run; happy to redo it another way if you would rather see that.

 drivers/staging/rtl8723bs/core/rtw_ap.c        | 2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 065850a9e894..b3c14e62312e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -802,7 +802,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       WLAN_EID_SSID,
 		       &ie_len,
 		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
-	if (p && ie_len > 0) {
+	if (p && ie_len >= sizeof(struct ieee80211_ht_cap)) {
 		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
 		memcpy(pbss_network->ssid.ssid, (p + 2), ie_len);
 		pbss_network->ssid.ssid_length = ie_len;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 863ddf846218..2e66a6e86a32 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1094,7 +1094,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	/* get bwmode and ch_offset */
 	/* parsing HT_CAP_IE */
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
-	if (p && len > 0) {
+	if (p && len >= sizeof(struct ieee80211_ht_cap)) {
 		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 		pnetwork->bcn_info.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
 	} else {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 1196ec011455..03dd4b5e94d6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2416,7 +2416,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	/* check Max Rx A-MPDU Size */
 	len = 0;
 	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
-	if (p && len > 0) {
+	if (p && len >= sizeof(struct ieee80211_ht_cap)) {
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
 		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a443b3530fb9..c884700d6e0d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3934,7 +3934,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 		p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_HT_CAPABILITY, &len, bssid->ie_length - ie_offset);
-		if (p && len > 0) {
+		if (p && len >= sizeof(struct HT_caps_element)) {
 			struct HT_caps_element	*pHT_caps;
 
 			pHT_caps = (struct HT_caps_element	*)(p + 2);
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a4de538722b5..7fd032b89429 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1130,7 +1130,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	/* check bw and channel offset */
 	/* parsing HT_CAP_IE */
 	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
-	if (p && len > 0) {
+	if (p && len >= sizeof(struct ieee80211_ht_cap)) {
 		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 		ht_cap_info = le16_to_cpu(pht_cap->cap_info);
 	} else {

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

