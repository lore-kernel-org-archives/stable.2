Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7183431F8;
	Sat,  1 Aug 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583862; cv=none; b=OiLUxRYEYWpMvCSTuNlLpLW4TITX6tryEieSko2hZSyqQVkkQPDnYDMB61MirhbwfPJq4H1Ukx4dvTnQv5EJapATXO0Jfpnhz8aSPWhuGKk8i0dUN8M04I2hOmej3qB+tRSkhKrNf1hpE47I/pX9YP1dkVLILAZLs0Kl0pkc4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583862; c=relaxed/simple;
	bh=I9BSQ5yobtw432mT3LjiUw8ce0CbJt0O8LAqe1TnoGw=;
	h=Content-Type:MIME-Version:From:To:Cc:Date:Subject:Message-ID; b=iA6xtGjl+vwnE7dVtDzJdzVMXlFVrMRWZxOSuzSddfpT3NIs+dcZUtUjy8DpN9NoCT3MNHj3uTjgA3cnBgk/MKshpcaLv4NxlUq1PDTCsDGnXbKtX3fCG/UUfmIWXbp6dRAsZ9mU9eFuKh4MDvN3WOcRHhPUcVl019HfilwLM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com; spf=pass smtp.mailfrom=sz-huijia.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sz-huijia.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.900714|0.6600377;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.579744-0.000312291-0.419944;FP=18446194795494400235|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=hj117@sz-huijia.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.ibC4JB2_1785583849;
Received: from HJ117-PC.hjz.lan(mailfrom:hj117@sz-huijia.com fp:SMTPD_---.ibC4JB2_1785583849 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 01 Aug 2026 19:30:50 +0800
Content-Type: multipart/mixed; boundary="===============2822691185236032729=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dongxu Su <hj117@sz-huijia.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Sat, 01 Aug 2026 19:30:49 +0800
Subject: [PATCH] Input: xpad - add Voyetra Turtle Beach PC Rematch Gamepad
Message-ID: <xpad-pc-rematch-gamepad@sz-huijia.com>

--===============2822691185236032729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

RnJvbSA0YmU0M2M4Y2U4YmZhZTIwYmM2MTI2ZjhjNmE0YWE0Zjg0NDQ4MTJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpBZGQgc3VwcG9ydCBmb3IgdGhlIFZveWV0cmEgVHVydGxlIEJlYWNoIFBD
IFJlbWF0Y2ggR2FtZXBhZCwKYSB0cmlwbGUtbW9kZSAod2lyZWQsIDIuNEcgd2lyZWxlc3MsIEJs
dWV0b290aCkgUEMgZ2FtZSBjb250cm9sbGVyLgpUaGUgVklEIDB4MTBGNSBpcyBhbHJlYWR5IGlu
IHRoZSBYUEFEX1hCT1hPTkVfVkVORE9SIHdoaXRlbGlzdAooY292ZXJpbmcgdGhlIEdJUCBtb2Rl
IFBJRHMgMHg2MDE1IGFuZCAweDYwMTYpLCBidXQgWElucHV0IHN1cHBvcnQKd2FzIG1pc3Npbmcu
CkFkZCBYUEFEX1hCT1gzNjBfVkVORE9SKDB4MTBGNSkgdG8geHBhZF90YWJsZSB0byBlbmFibGUg
WElucHV0IG1vZGUKKGJvdGggd2lyZWQgYW5kIHdpcmVsZXNzKSwgYW5kIGFkZCB4cGFkX2Rldmlj
ZSBlbnRyaWVzIGZvciBhbGwgZm91cgpQSURzIHRvIGdpdmUgdGhlbSBodW1hbi1yZWFkYWJsZSBu
YW1lczoKICAtIDB4NjAxMzogWElucHV0IHdpcmVkIChYVFlQRV9YQk9YMzYwKQogIC0gMHg2MDE0
OiBYSW5wdXQgd2lyZWxlc3MgMi40RyAoWFRZUEVfWEJPWDM2MFcpCiAgLSAweDYwMTU6IEdJUCB3
aXJlZCAoWFRZUEVfWEJPWE9ORSkKICAtIDB4NjAxNjogR0lQIHdpcmVsZXNzIDIuNEcgKFhUWVBF
X1hCT1hPTkUpClNpZ25lZC1vZmYtYnk6IERvbmd4dSBTdSA8aGoxMTdAc3otaHVpamlhLmNvbT4K
LS0tCiB4cGFkLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCmRp
ZmYgLS1naXQgYS94cGFkLmMgYi94cGFkLmMKaW5kZXggZjcyNmI0Mi4uMDNjYjgwMiAxMDA2NDQK
LS0tIGEveHBhZC5jCisrKyBiL3hwYWQuYwpAQCAtMzE5LDYgKzMxOSwxMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHhwYWRfZGV2aWNlIHsKIAl7IDB4MTAyYywgMHhmZjBjLCAiSm95dGVjaCBXaXJl
bGVzcyBBZHZhbmNlZCBDb250cm9sbGVyIiwgMCwgWFRZUEVfWEJPWCB9LAogCXsgMHgxMDM4LCAw
eDE0MzAsICJTdGVlbFNlcmllcyBTdHJhdHVzIER1byIsIDAsIFhUWVBFX1hCT1gzNjAgfSwKIAl7
IDB4MTAzOCwgMHgxNDMxLCAiU3RlZWxTZXJpZXMgU3RyYXR1cyBEdW8iLCAwLCBYVFlQRV9YQk9Y
MzYwIH0sCisJeyAweDEwZjUsIDB4NjAxMywgIlBDIFJlbWF0Y2ggR2FtZXBhZCIsIDAsIFhUWVBF
X1hCT1gzNjAgfSwKKwl7IDB4MTBmNSwgMHg2MDE0LCAiUEMgUmVtYXRjaCBHYW1lcGFkIChXaXJl
bGVzcykiLCAwLCBYVFlQRV9YQk9YMzYwVyB9LAorCXsgMHgxMGY1LCAweDYwMTUsICJQQyBSZW1h
dGNoIEdhbWVwYWQiLCAwLCBYVFlQRV9YQk9YT05FIH0sCisJeyAweDEwZjUsIDB4NjAxNiwgIlBD
IFJlbWF0Y2ggR2FtZXBhZCAoV2lyZWxlc3MpIiwgMCwgWFRZUEVfWEJPWE9ORSB9LAogCXsgMHgx
MGY1LCAweDcwMDUsICJUdXJ0bGUgQmVhY2ggUmVjb24gQ29udHJvbGxlciIsIDAsIFhUWVBFX1hC
T1hPTkUgfSwKIAl7IDB4MTFjOSwgMHg1NWYwLCAiTmFjb24gR0MtMTAwWEYiLCAwLCBYVFlQRV9Y
Qk9YMzYwIH0sCiAJeyAweDExZmYsIDB4MDUxMSwgIlBYTiBWOTAwIiwgMCwgWFRZUEVfWEJPWDM2
MCB9LApAQCAtNTU4LDYgKzU2Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9p
ZCB4cGFkX3RhYmxlW10gPSB7CiAJWFBBRF9YQk9YT05FX1ZFTkRPUigweDBmMGQpLAkJLyogSG9y
aSBjb250cm9sbGVycyAqLwogCVhQQURfWEJPWDM2MF9WRU5ET1IoMHgxMDM4KSwJCS8qIFN0ZWVs
U2VyaWVzIGNvbnRyb2xsZXJzICovCiAJWFBBRF9YQk9YT05FX1ZFTkRPUigweDEwZjUpLAkJLyog
VHVydGxlIEJlYWNoIENvbnRyb2xsZXJzICovCisJWFBBRF9YQk9YMzYwX1ZFTkRPUigweDEwZjUp
LAkJLyogVHVydGxlIEJlYWNoIENvbnRyb2xsZXJzICovCiAJWFBBRF9YQk9YMzYwX1ZFTkRPUigw
eDExYzkpLAkJLyogTmFjb24gR0MxMDBYRiAqLwogCVhQQURfWEJPWDM2MF9WRU5ET1IoMHgxMWZm
KSwJCS8qIFBYTiBWOTAwICovCiAJWFBBRF9YQk9YMzYwX1ZFTkRPUigweDEyMDkpLAkJLyogQXJk
d2lpbm8gQ29udHJvbGxlcnMgKi8KLS0gCjIuNTQuMC53aW5kb3dzLjEKCg==

--===============2822691185236032729==--
