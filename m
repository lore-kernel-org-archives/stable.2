Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795701782;
	b=vzA8XVZwxLxSZUg/spdKPEyKJqtrW47hEG/C24ZgzoxjuDC3Qe8knwZ+M7FXW9zLmn6C
	 564q3NcJr3iGHjfRM+2IpXXMqC+zAG9G9Xv4gVqn6E1o0OARHLb/bxl+SIVPccFQh4TBZ
	 7kKsVDX3Ohxhq/jz+xxQlTpLmmi2nEFD4PRwIseoJ2fIPsPVeQKo36RKj2T0CTjUFgMWn
	 w8U9je+Y3IhqPKHCYOU6+UxpR8PiMt/PA5uBYkp1xCCP8pm9VmGdUms0D26qDvj4hNLwL
	 5917z+McwqOjOLlPvZlBbuk1cG34NCTd/Uu32x+nsH/DUQ2yhWF2p/E30YJYBUsC1dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701782;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=usPorDLSGLfvveq9O3zFWXHFtoe7dXXggMKyYE6g17U=;
	b=oW4Wwt5KCcl5oPvVOIPWhsH3qlez1y1IFJbdWxcZOTl/eC/m5b8t/22i+wFPFk2HeQ2j
	 Iy3KcAsa3qxRAExj7V8XKPgnBd6NCMlM1QWXK/CyI5yHfi4hBClcMeJfmo1xvmztg+MzU
	 YU0Mh6pBXNHufUK0/7GCo7YhjCXnHi6ToFAux+0RfaJBa00LVZJltri4EefTYFJLNMWzw
	 A13VAG+K15wX9vwzzxMJ3YhofK9mDJjG6b4vZEJEG2ZdutvSbgNvSiHPwbTuYr2SDx+tY
	 YWHZ0vFK2R9UaqnieoYp38fXHiz8Vv1jmq3V6+bheEDo4V90edkGRJaq+szAv1RKOow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akRzkLBS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60759606A31C;
	Thu, 26 Nov 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akRzkLBS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795701781;
	b=wcFFWqgg59hD86/98oaNPZ3WupYvBBGPCqOOro9SqVAHARO1bzNJYT+6gXRULR/148kG
	 dT5IZT8WLB2iOch4tWsspfFwtlAybifCabFPlC8/u573bKwzRQhl4PSRVbHNLfN7zxN5i
	 joftfWUyHRWOrPIxQPGWPs+yZX71Ljh1SZse/eGW67bG0OpO6fefvQC4e9OTkke6Hojg7
	 ZuRARSznPddujG01VweQE9AAotE326+n0eZzzGwfu0CWrbsYaCxVwwiJQ2KI1VOWrpNlq
	 JKtL9ft0UJqfG5QqiIC2ZQpWnriSC/Rt3Jc9qa6AMVhvUdQhyEGx6VUrCqFC2xY+WJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701781;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=usPorDLSGLfvveq9O3zFWXHFtoe7dXXggMKyYE6g17U=;
	b=ZcecAuovdcl3pPOVGc4X9anetOhmm3m2TpjVO9G3ML7QGMzTvUHe2txhoUW8SyhdKyh2
	 9+fcb9ZnEsNiEZovrHoG0i7AXSINPovmwA9B11CmZp2aEOYTJEr+uoIN5C/B3sD/jEw5R
	 RHcqg3QhVzPg5lPeCGs9xAY+lW9axkoodZCk3NhMSLxgy2+mmsAl8gCatQg/yQ8HoK+ME
	 0wkRUSt3jyVOjWPK3DS4gkO2QVKbR61vBy14uG3CWrd4wwrxWziZLcbjAKmgCFl/azcnD
	 eYzXpjxCmtklWgnzhhB1ZY+ozIwMMYaQRQRy56uVIiet5PH7s8QgiHAttJhnYhqNXow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A87051F000C0;
	Thu, 26 Nov 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701781;
	bh=usPorDLSGLfvveq9O3zFWXHFtoe7dXXggMKyYE6g17U=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=akRzkLBS6uCzT0xMLP2uzlejqljKCOOjdbW95+FNtTbrDLMKKRTptytdsONeQsO4M
	 t+X715245QonV0eiS/ai6ynusTvhq/MxdTbmJ3cLNHKYlaWILqv7pu58d94Mz8raML
	 HnE99x3sD3oJO+N37dUsPjJUr5VYhkY++JK1c8K7Scl9aovxKR+Sz0S++8ipaMZroD
	 Pu5brYiBlf9em+guya4KEY3xIFfI0JseIgXFAw6MuVKaz6ZHHbRszQCMLL8dqXsLK5
	 z5WdsxfbcnMsiq1uDsZvpMcuLHo217GAkqLIg3ecY4N73XHPV/1sP6EfYR1FhJxLlG
	 Vq/6xRWYdlL3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C7664D556;
	Thu, 26 Nov 2026 14:02:48 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 14:00:31 +0000
Subject: [PATCH 5.10.y] staging: rtl8723bs: rtw_mlme: add bounds checks
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
Message-Id: <20261126-so3-rtl-510-v1-1-4c22f41706db@certik.com>
X-B4-Tracking: v=1; b=H4sIAH47CGsC/02NwQ7CIBBEf6XZs1uBWqr+ivEAdLWYBgyLRtP03
 wW9eJyXmTcLMCVPDMdmgURPzz6GEuSmATeZcCX0Y8mghNJSKo0cO0x5xl4KNDQcdmavXTcIKIt
 7oot/fW0n6Fsp2jecf5wf9kYuV1VtWsOENpngpoqYwphjnLHy7d8FrOsHbw5u7aMAAAA=
X-Change-ID: 20261126-so3-rtl-510-ae794a86c370
To: stable@vger.kernel.org
Cc: Salman Alghamdi <me@cipherat.com>, Luka Gejak <luka.gejak@linux.dev>, 
 linux-staging@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795701630; l=3127;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=V3GPftrUasuRGRSXywo9YOVzZnazbn9fCfCl0Gt8TVA=;
 b=hi6hubty2MowvZbbN+TZYZoR2veLkggcyuMBGp8Onqe/TpjgY7rPBHOcaeCVivjQeVCEVqE3m
 4u5jNH7IgNJCJy4FhqPyVkZd4y1atv8gxpXPip8y/27wq8f6/TV5+Ti
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
[ adapted to 5.10.y: use IELength, IEs, and _RSN_IE_2_ ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. This branch still uses
the older IELength/IEs field names and _RSN_IE_2_; the added checks
are otherwise the same as upstream.

Tested on v5.10.275:
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
index c7fab90550f0..a172121b8171 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -723,6 +723,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
+		if (pnetwork->network.IELength < _FIXED_IE_LENGTH_)
+			return false;
 		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
@@ -737,11 +739,15 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	    bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
-			if (p && ie_len > 0)
-				bselected = true;
-			else
+			if (pnetwork->network.IELength < _BEACON_IE_OFFSET_) {
 				bselected = false;
+			} else {
+				p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
+				if (p && ie_len > 0)
+					bselected = true;
+				else
+					bselected = false;
+			}
 		}
 	}
 

---
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261126-so3-rtl-510-ae794a86c370

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


