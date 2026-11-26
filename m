Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702046;
	b=XDsQ4GYo4kSjYgxJG746VjWzPWvqy0jat6BA3+O6Yu2LU5FLVCxKZsyuF2gCG96e/4KF
	 mSzVYz42YSS3z3JdPRVVEiyw9k0diLJnhrV1/2p52eWwk2+kS1wltBA0NEGCPnAbQrmo7
	 F98xBmlwzQxFx7twKCCLbp0ETWtv2T+37PTvcR+s5xyhOqZ6SjPITbaGlOlMqaeFxHrlo
	 suMIP14D1vTjyE9blpgBG/T0FzfUZzJyX9WyyrDzGBM4yZ4Cq4QiX0EQY/LdHldXeh7PM
	 qsRkC7bBAm+Dc0gZSayjjkHKRt0Dzh50o9CUGFVc9aiyfArUDiupeuaSxmweOEePMXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=P5axP4ZoFMQOvUPT3qXP/BTPlVRHrSaZRcY6TvgIIO8=;
	b=iOP5IMHm4y3wv4jwJe08bIpnn7/XtvZblY/6tu5PKuIptT+O5soaSnVHdFQ2fMQMI1PT
	 1i5lZSA033iVLnpUK2DUOz0rUZs2Ce8dX64BHjHGfUv9/WFuD05kT60egR30ew5cNvNN9
	 sxjEM4Y7un4AYRPMw7DMnbQxbuLY3BugOfpbByXLzkaxLutnqoIl/gSOK2noy6Go5/LbQ
	 5+n8ALSLEUXFmCXii0MIkxTJPZ4u8V8HPN/qGBK2PMpW0pPgE6N0iJ/13wL+jqXe4Tulg
	 kS1mYqaJoKLS1ERbpYO4R8rxAcBui0dXdf+jKi/ZkueN4XIrrEPXHA25M973K1IPHzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f52gD6Zj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CF606A31C;
	Thu, 26 Nov 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f52gD6Zj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795702045;
	b=bx0PR490NwBd+nYCr07+SbHOqws6Vvq73YMWBLCnd9OMABiBGXpYGQM/KhpAZKz5RZMh
	 BaEsWhgSggRm6PrHvwhAcrmZcwa9TRBIl4JnBagxfvgEQI4+862gR5hmR1g9msfePYRwd
	 N7mrfZuRUZdcBpwRANUVbInZ79VG++Q/SjCB5dHWa7hhmNpkgebN/yPZqDfpUBzxuk/DE
	 Jz31uy0B7hpHYTVsahipt6hsEWAt3aYPKdfhrbJ7MHUvaZvYlZrLWuNicFJCrGy0FcRIl
	 e1k2e+G2qV7BARU0ODS/V9cvZxS/gC2Qwwf8JeEcnVWl/wYme3FCSJwIETSn2yP3HJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=P5axP4ZoFMQOvUPT3qXP/BTPlVRHrSaZRcY6TvgIIO8=;
	b=GfVfoPHrZbLYqDqLNF/6CDClgFeNlL5133FFvhRPz18gTeSotMUYPve+IEsjZzUUAHEZ
	 C5VYRXbDgRr4n2KWB8bsTyGCoS370BCLCk7EYVMCkseHcs8I1re9zHZECXIl4vl88Mh/v
	 TglMe0wCgitXyElpDJ73NOIzrWTzxKyOqRk3zIonsdSl9+u9Jxr+joX7+sgxdAIhHXZ1n
	 bzVGU92fWT4bsUri91MzTTqFWl5zOX4QtxSs9q/+SMgr6nLWfGU7B7mxq1kZAZlCzkSq/
	 A0sMabF/oQ5HdqJUaZSRCVTH8bTJv5aiJSoKg9nWrDMGys5PP3pC/bMSMKKp/4EKWFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3018A1F000C6;
	Thu, 26 Nov 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702045;
	bh=P5axP4ZoFMQOvUPT3qXP/BTPlVRHrSaZRcY6TvgIIO8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=f52gD6Zjme4dH9lxcTObA/sjBN+/GQNmj7ZkNfbTq4fbxlhIE8tonXGS57ZjATtm1
	 Wys2CWEV2cHuDg1j4SiKDIDp0azqQUIDyChrCBO/4w4NknSd1NuJzJhNb6E+e1iRwl
	 WVea3/dlMN/v8NCvV17RwaKdcdwcuvFBVkm0qPwyAJXHpHWxzzAWSg7PqTDVI7Hnju
	 XKa2yydbo9Z8h8rJ9ZYRqA2ZrsyqNmbzDd5p9mRSqjFHk578IRDJQ8WAoARDS00f0j
	 wi2GRcYFd6bN+yqNzVmfguBevDqmSZVz2TZzu93dk+QU0tszi0oZVpiL+O6pzeD6NY
	 pAyJKv075+Q7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B07EE4D55A;
	Thu, 26 Nov 2026 14:07:24 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 14:05:01 +0000
Subject: [PATCH 5.15.y] staging: rtl8723bs: rtw_mlme: add bounds checks
 before ie_length subtraction
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-so3-rtl-515-v1-1-4a4860c4ff9d@certik.com>
X-B4-Tracking: v=1; b=H4sIAIw8CGsC/02NzQ7CIBCEX6XZs1sLFRJ9FeOBn63FNGBYNJqm7
 y7oxeN8mflmBaYciOHUrZDpGTikWIPYdeBmE6+EwdcMcpBaCKmR04i5LKiEwlGZgzL6OEzWQ13
 cM03h9bWdQfVC9W+4/Dg/7I1caarWtIYJbTbRzQ0xRV9SWrDx/d8FbNsHq6J0G6MAAAA=
X-Change-ID: 20261126-so3-rtl-515-35a45a690fbd
To: stable@vger.kernel.org
Cc: Salman Alghamdi <me@cipherat.com>, Luka Gejak <luka.gejak@linux.dev>, 
 linux-staging@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795701900; l=3165;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=6UeFlLleWiTIa8ypce3Y897LteBNHsXxh9xJYKGuAZg=;
 b=DQ+AR0L5K5YgqF5OyGT+9czaFiHbNBqRbUYrHH1y4lKIl87w0JVRABjQMJT3hpeM9Iafcquam
 gSeKS01ijAKBnE6aYrVwBF0lOLVo3qPEqkua3CE6YkkQHJtW38iS8G6
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Salman Alghamdi <me@cipherat.com>

commit 88e994c57a79f62d5338231d8d37ee8dd98baffe upstream.

Add guards to ensure ie_length is large enough before subtracting
fixed IE offsets to prevent unsigned integer underflow.

Fixes: 2038fe84b8bd ("staging: rtl8723bs: fix spacing around operators")
Fixes: d3fcee1b78a5 ("staging: rtl8723bs: fix camel case in struct wlan_bssid_ex")
Closes: https://lore.kernel.org/linux-staging/DI2H39EAAFBZ.3KI5NWN02AQ2S@linux.dev/
Cc: stable <stable@kernel.org>
Signed-off-by: Salman Alghamdi <me@cipherat.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260513203455.31792-1-me@cipherat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted to 5.15.y: preserve branch WPS helper-call spacing ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. The added lines are the
same as upstream. The WPS lookup next to them keeps this branch's
older spacing, which is why it doesn't cherry-pick cleanly.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of
  drivers/staging/rtl8723bs/core/rtw_mlme.o, base vs patched, no new
  warnings
- booted the patched kernel with the driver built as a module under
  QEMU/KVM. I don't have rtl8723bs hardware, so the scan path wasn't
  run.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 6480252a5ade..b31a1fc964ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -656,6 +656,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
+		if (pnetwork->network.ie_length < _FIXED_IE_LENGTH_)
+			return false;
 		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
@@ -670,11 +672,15 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	    bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
-			if (p && ie_len > 0)
-				bselected = true;
-			else
+			if (pnetwork->network.ie_length < _BEACON_IE_OFFSET_) {
 				bselected = false;
+			} else {
+				p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
+				if (p && ie_len > 0)
+					bselected = true;
+				else
+					bselected = false;
+			}
 		}
 	}
 

---
base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
change-id: 20261126-so3-rtl-515-35a45a690fbd

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


