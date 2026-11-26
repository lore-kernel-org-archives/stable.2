Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702019;
	b=aGMAl0GBYIc/57Ach7rkOPb6xEVmqzwSkn/jCd84hV01i8Wv92sMdUyHtoxrwiwnksal
	 ZfzhP/5mMGz3FMIMdWJ+uuAPiZZDNzl9EFFz5KBxWhzPiYeKxwQqhJKDlmYZc3sDTIy5d
	 SsSVwiDnXqU+b+ZEXeYrrM8IrN6QJy1aSD2BGCct9ofutneVU9H3zd4ZepLhSDPO/hXtG
	 1P199u9R8y19akQQVaDoPz8fYQOPpmjDmW92XzWtI3uDKwiBHjbGDgIEBdMLWltM8Fjvm
	 86Cy8yiV3EkTFS4FEIkw5JTYx2aOPbig9YEOCNBnaBeyx3hWcNpwUJjrcml9FpAiB8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702019;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=MGU8wC5IXaP4BXUUigo+8F9FFrHbjACaFYZZTDbbovw=;
	b=EcqcLmejE0eMQKWyMOC7Bgpsj6CYioNl6CGzdCkj5XTojFMG3cL93EaZezAQ/v/Zv0rZ
	 MKPRIrvT2QAbhKRcVBorZfZuqDgw7oPfqE8lU2wojP170bk8EdU1JqPl3coBLwjRxh0w4
	 uMcO3rSQ4pVdhULP88GnjdvSCBA/yAnDTen6wTGpqHgzw6UQ47rUrgRekPBsbM0Li1rnY
	 pNCJeRRM5ljk+lDcHNqUJULH7nuFR96aXQjh0OAsJgd0cHYw7/C0pzoABLYd0J4MdPvbJ
	 +2cLb/KDucEXsHgYYb7fztxVyKFlE+NgVJz7MBk6OH9WTaxlPazN8czlxjhM6s1M3IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOza6h7W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514AD606A31E;
	Thu, 26 Nov 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOza6h7W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795702019;
	b=bnaAMBa5Gj5Giel4rv9SVnUu6yPG95D8uOS6mA11bizVWEzhXvjIV2/Lp/5cZTuMDLN+
	 LJClFVVjzHyGL5Is6TBwHOpUOB980XjxaZ+Nj9+M3mu4HETGuRnKxAm8q/+FjIKYQYojf
	 ZNoXtAC7QyBgdlXc4o4cBn7xWKqVNcJniBD3TQE/wySMgOD8XVB7kRl2Pf1Clr0kiVYaS
	 AeCQsWboV4oNH+o3BXFdgaW2yP8RF3ych83fDPmubeiID89w4smgBmKjTrg1UOF6qqMgf
	 ffrdNtYmO+txQXHWiBw+yrEHJu1l7+fRgTOmHT+j8GpAu+f+MJqD0AHkAxpdr1JTf7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=MGU8wC5IXaP4BXUUigo+8F9FFrHbjACaFYZZTDbbovw=;
	b=PNUu3fHETIaDc7gAjOL6yYVRTXl8NWnFrb/fwUCyOETY4LTywMSQskpSCVxd/B3ZBEgO
	 f11C+nenA/3+j/SHnNFatlrPxGLeUKO+J6vj61ehoc6jSScGS0FVlnt1o+BGtv/ZAvarP
	 GUVGzZW/IAAOZ85lyQVdePhnKBaNFqOgVSte8rdMvJN3qlS90iNoyK8sh0wpm0CGS0tTs
	 VLj52BycMSuvnwPWy1Vm+mFQUIssai1kzRDgXguLhlNPGmT6cfeovFIQ2ja28r4bJ7kqw
	 BiKxOmE9vVT3HyKUzncXVeSzuSJ7ujIvqsy7jf+SiMNh3vTm5hxybWVre2M4YQk8/Xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D44851F000CF;
	Thu, 26 Nov 2026 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702018;
	bh=MGU8wC5IXaP4BXUUigo+8F9FFrHbjACaFYZZTDbbovw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jOza6h7WiXlqRraZu4I+1asEP6LupW8Q57QEnjEGt8p+HEebLio4nj6h84LESIstZ
	 MO0R+o1ILXM3QL3ZAEN9nYT3n5dCxJ7bu3kCn+0dVjy6ojPR0bJyAshMB0V8KwNpQv
	 fqUubXafAHhkpyZewNSxLbLBJyzf7iKouT2sBqqr3rd04kgGuttZhIjOCg0Y+py0S0
	 TWyT1tE+VME5C+edR13YjXYQWNdw5VbDqivStset/OS2NRpst44GGDZ6pSfr+LywD/
	 dEqWyzwQenmKIPH7g4vWBDPiO+KptsmXug9Giu09XQTTFWjoXn2J8SFs8yT8Wk40Wk
	 ymUT4x1vAbCug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E71B4D55A;
	Thu, 26 Nov 2026 14:06:57 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 14:04:40 +0000
Subject: [PATCH 6.1.y] staging: rtl8723bs: rtw_mlme: add bounds checks
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
Message-Id: <20261126-so3-rtl-61-v1-1-96e1a9756c6d@certik.com>
X-B4-Tracking: v=1; b=H4sIAHc8CGsC/0WNwQrCMBBEf6Xs2a3dCCn4K+IhSTc2UhLJpqKU/
 ruJHjzOY+bNBsI5sMC52yDzM0hIsQY6dOBmE2+MYaoZ1KA0kdIo6YS5LKgJzUgDezUqTx7q4JH
 Zh9dXdgHdU/+G6w/Lau/sShO1ojXCaLOJbm5IOE4lpQUbP/4PYN8/IDVoAKAAAAA=
X-Change-ID: 20261126-so3-rtl-61-a710ef272f1f
To: stable@vger.kernel.org
Cc: Salman Alghamdi <me@cipherat.com>, Luka Gejak <luka.gejak@linux.dev>, 
 linux-staging@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795701879; l=3160;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=Ys/Tq/5BzFedQ5FeXcg5z6hbVsf4FzrQ3pyU6hVxDVo=;
 b=Aod7ceNg2c2M1EeuPXDQYQ14tfANlBzgEBeYhzCujpJepWpDLYaqagFWS+09GdG9mlk7ovGuU
 Yd8FNfKNqv1AnDa+lBpn3yLHNqz6cmBLb9Rt5bi27WG2qvUGmOVdrS0
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
[ adapted to 6.1.y: preserve branch WPS helper-call spacing ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. The added lines are the
same as upstream. The WPS lookup next to them keeps this branch's
older spacing, which is why it doesn't cherry-pick cleanly.

Tested on v6.1.193:
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
index ac3a08e6727f..8a83d1fedeac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -658,6 +658,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
+		if (pnetwork->network.ie_length < _FIXED_IE_LENGTH_)
+			return false;
 		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
@@ -672,11 +674,15 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
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
base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
change-id: 20261126-so3-rtl-61-a710ef272f1f

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


