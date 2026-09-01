Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE7456DE5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247076; cv=none; b=guT1jcbqJexK7/HdH2rJ1JCar0yaSC4pEyNLAaEfBvq+jAVl5QqsB4HG9OJKsLr1Q676zaGFTvrhPWYhEo3Ei6YADummzTf439ogyy0f6h71OMYSNk6RqiYj7Gu1dXHf1ItkhTQ2BxYtPjGWtbkRmx82OoeMQ4hQoQ+nJeqzUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247076; c=relaxed/simple;
	bh=eePa8gIAyEHJm+MotCOpQWW7AgJTnxDuR/tYWKstBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnfH9yJJGJK2OuCqQ/opwdd81vmRNwARI2tu39N7vNxp6WmSWgaL2zP1tsrOrWSzcCn7Q3AAHpOoEeBVYIj6KuHevp/Wz4lv32e48Oh63DgFad98iDkFPlhsDEyX8Mq/m+Vy3Ykq37mzaGu0wrDIFax+pVYEk+XPnk0O/8rB45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=badchecksum.net; spf=none smtp.mailfrom=badchecksum.net; dkim=pass (2048-bit key) header.d=badchecksum-net.20251104.gappssmtp.com header.i=@badchecksum-net.20251104.gappssmtp.com header.b=ikDq0yqw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=badchecksum.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=badchecksum.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=badchecksum-net.20251104.gappssmtp.com header.i=@badchecksum-net.20251104.gappssmtp.com header.b="ikDq0yqw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso62191115e9.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=badchecksum-net.20251104.gappssmtp.com; s=20251104; t=1788247073; x=1788851873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVjB4yIvGa1+kod3YTrVQGswl2TNWOwiBWvoOi0j9dg=;
        b=ikDq0yqwbQmHC2RkBRKFgiE1K3kb/kq5ZNTfSjCGzMWM4mreynQ/bu43W7QSmkW1hN
         c/DDG8p9eBqGHAMR2fwL7W2Pyshegs39d0H2UBMrbx0pR4ZZuSzh+ski/Zaj+DtAhkWC
         ER+aSYWcWQ6szcKKt0m0tNXNiPOHvcwryp8eraT2KcC+YHNb3uj3MF8WIvMOmU+GrNqo
         5DiVRdw/RXmclxhCFMUrerBK1Ans9lwZIT1ClX/2RLoqQo0WQl0I1Wlmb2zmKiGf3Zfb
         veP68lLXjg5dNLpCDZnEd+6K6YlLqD5mmse58ZaLoQJ96Yx5i0rXRh8y+SP+bNfK/utq
         +NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247073; x=1788851873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVjB4yIvGa1+kod3YTrVQGswl2TNWOwiBWvoOi0j9dg=;
        b=Y8feGST4QiW+h+hxTP0IXWGORqkdQcDR/wUUSTf8S3HdudPnnVwC/l9snQ87b3UfKn
         px1TFntizXixN6C/+484I9y40OHZMbqBu/mWBFrhdmpdCcmAmTFgtNMk68ecHn8oO710
         yf95vIaI6E5mS8lDpgjOrSjJ7iiK7mXX78ZZ3YsvqVKzvipUDEqqIFatmrxAjDHArOBX
         0FtCxQSMUVQxNuuHM/a9IWG283bYV4JA71Yc8SxYtq3i5S6Ei0zRaaMtPGBtzHz2rBv2
         5mMSeQ2msX1CKRHTiHYarbW2Vem+4FTnsrEjSQxalWRbP3yeBKCbmIomx0PHYX7o7nJw
         v/WA==
X-Gm-Message-State: AFuF++lJQdWnVc1G7a3OkMz6zKVU+3I3ym7ulDFW1JArYpPdM5JdJ+fi
	TISTKZoTQ1W2/kAcu3y1u5wwnUOsp6zGZiXxB2/2FmHrCzM/x1tQl9TzxKS+Qq49+9uZkwGw2at
	QzCWUew==
X-Gm-Gg: AR+sD13Wk4hEsJilnhag+lK6QAr/02NkgpgwltVjCApmL1pW26t0p0FgZmQT7Dbqv20
	jgfZ0eSplygt4noZGnTZ8GojqPmJ3FA5viLio3IvwakvxT6w+nFiL3Mp+DUHdgZxmozN6WjROV8
	11r108qhs92THROyL3Pia96yk3qqSK5nWkMGi2mGSNeRUDgpQpSzUn0erDXZiXUaMUF2C6Kt/qZ
	Qg9Y/F4KtjahZaGn6VmiJvmpn3Zw0CqpEZ2Tf1T+GoIdYmXTO2mRKy4CwGq+umxtS+P+rkvRTzs
	P2LH65Njmw9mB638NKdn9rDdC/6lsMWQ04amBg2RLX02uqnjPmXdbmKCulwnIkf45Y0falD5vTd
	b9cq6tHaqzShiW97mHdwkZTrLzmgnseEXDvqSBoobkE/o8732WmaPRp2UmVH6Sv3g/+GRUmtXyD
	E1QxQ1Y1FEy8pBmrCDpwAZ/+Ay2uv+FdOFjEFUlELn6jdGfSbyMR2Y+PrWY0eAdDV0tDa9j7nYB
	dGcyo7K3EFHh8ofSbQym+eoUPlI+w==
X-Received: by 2002:a05:600c:a012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cd81887aemr174466565e9.11.1788247072661;
        Tue, 01 Sep 2026 00:17:52 -0700 (PDT)
Received: from h4x0rl4nd (244.red-83-44-244.dynamicip.rima-tde.net. [83.44.244.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce171c3sm49617225e9.8.2026.09.01.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:17:52 -0700 (PDT)
From: Jesus Olmos <sha0@badchecksum.net>
To: sha0@badchecksum.net
Cc: stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: bound WPS attribute copy in rtw_get_wps_attr_content()
Date: Tue,  1 Sep 2026 09:17:20 +0200
Message-ID: <20260901071720.360209-1-sha0@badchecksum.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_get_wps_attr_content() copies attr_len - 4 (the WPS attribute's 2-byte
data-length field, up to 0xffff) from a WPS information element into the
caller's buffer with no destination-size bound:

	memcpy(buf_content, attr_ptr + 4, attr_len - 4);

The information element comes straight from a received beacon / probe
response: collect_bss_info() copies the frame's IEs verbatim into
bssid->ies, which reaches the scan queue, so attr_len is attacker
controlled. rtw_cfg80211_inform_bss() and two sites in rtw_mlme_ext.c call
this for WPS_ATTR_SELECTED_REGISTRAR with a one-byte destination (u8 sr /
u8 selected_registrar), because that attribute is a single byte by spec. A
frame that declares a longer Selected Registrar attribute therefore
overflows the one-byte stack variable during a scan, which happens
automatically (NetworkManager/iwd), giving an unauthenticated adjacent
attacker a remote stack buffer overflow (at minimum a stack-protector
panic).

Commit 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(),
rtw_get_wapi_ie(), and rtw_get_wps_attr()") added a bounds check for the
attribute header in rtw_get_wps_attr() but not for the attribute data
length, and did not touch rtw_get_wps_attr_content(), so the copy remained
both an out-of-bounds read of the attribute data and an out-of-bounds write
of the destination.

Reject attributes that claim more data than the IE holds (fixing the
out-of-bounds read and the latent memcpy(buf_attr, ...) in
rtw_get_wps_attr()), give rtw_get_wps_attr_content() the destination buffer
size, and clamp the copy to it.

Found using mwemu (https://github.com/sha0coder/mwemu).

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jesus Olmos <sha0@badchecksum.net>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c  | 17 ++++++++++++++---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c   | 12 ++++++++++--
 drivers/staging/rtl8723bs/include/ieee80211.h   |  4 +++-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c   |  5 ++++-
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 66f476a46aad..20ca2388329a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -741,6 +741,10 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
+		/* An attribute must not claim more data than the IE holds. */
+		if (attr_ptr + attr_len > wps_ie + wps_ielen)
+			break;
+
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 
@@ -768,7 +772,9 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
  *
  * Returns: the address of the specific WPS attribute content found, or NULL
  */
-u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_content, uint *len_content)
+u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
+			     u8 *buf_content, uint buf_content_len,
+			     uint *len_content)
 {
 	u8 *attr_ptr;
 	u32 attr_len;
@@ -779,11 +785,16 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8
 	attr_ptr = rtw_get_wps_attr(wps_ie, wps_ielen, target_attr_id, NULL, &attr_len);
 
 	if (attr_ptr && attr_len) {
+		uint content_len = attr_len - 4;
+
+		if (content_len > buf_content_len)
+			content_len = buf_content_len;
+
 		if (buf_content)
-			memcpy(buf_content, attr_ptr + 4, attr_len - 4);
+			memcpy(buf_content, attr_ptr + 4, content_len);
 
 		if (len_content)
-			*len_content = attr_len - 4;
+			*len_content = content_len;
 
 		return attr_ptr + 4;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index e965133d94ab..0616ed03c6a1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1123,7 +1123,12 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 			if (pmlmepriv->wps_beacon_ie) {
 				u8 selected_registrar = 0;
 
-				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
+				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie,
+							 pmlmepriv->wps_beacon_ie_len,
+							 WPS_ATTR_SELECTED_REGISTRAR,
+							 &selected_registrar,
+							 sizeof(selected_registrar),
+							 NULL);
 
 				if (!selected_registrar) {
 					status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
@@ -2131,7 +2136,10 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 						sizeof(struct ieee80211_hdr_3addr) -
 						_BEACON_IE_OFFSET_, NULL, &wps_ielen);
 			if (wps_ie && wps_ielen > 0)
-				rtw_get_wps_attr_content(wps_ie,  wps_ielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
+				rtw_get_wps_attr_content(wps_ie, wps_ielen,
+							 WPS_ATTR_SELECTED_REGISTRAR,
+							 (u8 *)(&sr), sizeof(sr),
+							 NULL);
 			if (sr != 0)
 				set_fwstate(pmlmepriv, WIFI_UNDER_WPS);
 			else
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 9f421e4875b7..2eeedd52454a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -710,7 +710,9 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen);
 u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_attr, u32 *len_attr);
-u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_content, uint *len_content);
+u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
+			     u8 *buf_content, uint buf_content_len,
+			     uint *len_content);
 
 /**
  * for_each_ie - iterate over continuous IEs
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 3468d4114f60..b9f74f61b0ca 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -244,7 +244,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		wpsie = rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (wpsie && wpsielen > 0)
-			psr = rtw_get_wps_attr_content(wpsie, wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
+			psr = rtw_get_wps_attr_content(wpsie, wpsielen,
+						       WPS_ATTR_SELECTED_REGISTRAR,
+						       (u8 *)(&sr), sizeof(sr),
+						       NULL);
 
 		if (sr != 0) {
 			/* it means under processing WPS */
-- 
2.55.0

