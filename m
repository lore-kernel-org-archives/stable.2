Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025841D658
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059377; cv=none; b=dpQvURWrGTY+RequAzGR2Dvx+xqgZ2nJZo5+fSAGUUFVb/lOGIZj4DwK5rYfq+CnOcDcpKcK1ChBungVHNmnuvTMZWl/ptZxydGIav64Qv59OIu3Hm3YKKQ2s6xysQxDZHgZN2zPMVHqD3ihhWqrPBeHhQM60DAWBl2PKH9uuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059377; c=relaxed/simple;
	bh=K7H0b0yEuXbBzeo1u7dspGiRZDbdJtpfway09cQv0YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXBNtctGqUufbbZywe+fIi8qX0GjYvt8PrwOwN5CBaOehi7tGzX/kA6RpUvPFT378WJdEN1Iv8Kv02Pm57O5FYxQr83iJAGopL4jApE2FTlTMneYV3FcIMIG4n4pm8HpzAsZCWem/ExdRig/8jpHJBqdWu5ltpRmWC/xIbo+9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh/CdPDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh/CdPDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8466B1F00ADF;
	Tue, 14 Jul 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059365;
	bh=ltsWr9fKajSUzTBhbjiR7kEbLKiR/K9TXn/b9rkCdy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dh/CdPDsKsQ+4hAOmKHDzqZU8G/JNloq38eIJJ2WxZBQ7XIOfx9L7o7MCurpcFfYO
	 HGa6Rxzl9IYO4rPVKOGgeKDiMbwakVucx3Kl0DW/4/KQgoDBxRjZqLYHo2m0OuInqm
	 4ANa7ChgXuyDPiYg9bxEwVRvTVhOkM4nJvd2WqZ9hQzhzNaY550+65jRIli8SBiUPt
	 bVaFts0/45wEjusYP228KDpglvXstjtWoB9Iw/1hq1U3yN+lyPlQJhKIWThEc0iymC
	 9SkXSw2LooJfoJjDagBlFhMncrZaA9AuXxSrFsz+wlK8SrssUWRjGgJYHIu4I+xhFc
	 aYLW3vgkVzzmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
Date: Tue, 14 Jul 2026 16:02:41 -0400
Message-ID: <20260714200241.3154071-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200241.3154071-1-sashal@kernel.org>
References: <2026071335-fool-faction-0f5b@gregkh>
 <20260714200241.3154071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit 5a752a616e756844388a1a45404db9fc29fec655 ]

supplicant_ie is a 256-byte array in struct security_priv. The WPA and
WPA2 IE copy paths use:

    memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);

where wpa_ielen is the raw IE length field (u8, 0-255). When a local user
supplies a connect request via nl80211 with a crafted WPA IE of length 255,
wpa_ielen + 2 equals 257, overflowing the 256-byte buffer by one byte into
the adjacent last_mic_err_time field.

rtw_parse_wpa_ie() does not prevent this: its length consistency check
compares *(wpa_ie+1) against (u8)(wpa_ie_len-2), which is (u8)(255) == 255
when wpa_ie_len = 257, so the check passes silently.

Add explicit bounds checks for both the WPA and WPA2 paths before the
memcpy, rejecting any IE whose total size (wpa_ielen + 2) exceeds the
supplicant_ie buffer.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-4-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index faceb6e592f030..edc34f93102216 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1482,6 +1482,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1491,6 +1495,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
+		if (wpa2_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-- 
2.53.0

