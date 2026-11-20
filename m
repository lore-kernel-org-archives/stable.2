Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795161947;
	b=xuKZcotE2dUkbic6y2b/O9K/2lxHU+mAQ1/PFcM3as4JZCXoiVBbEq8pjt6ebvY/2dSn
	 ZTUrFWEs+YhPxsANoO2IbuhEDJyQBk3gmfcLakDTuziinEB/ptcB44XLbRnezDNnVpEIQ
	 gjaVw6GUPFAzAfF+PxnvVIBrpJsrgCl4X+lAwy4+oSnCbCNb5WX5J7GJ/l7IcY5Z/jc2J
	 0D3oFh/eU6mrssoVsjcOFSK+JMhcYvYlvOBMomupYbxDucrJ1jR9LvVqoW1cYEw6Y8ohP
	 c/dxycpVFUjVpgUNMMGmbbDeQZh+z6pYPB6WYHQ0KfVJT0O8/Ku3vm1/lC1PXGLNgvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161947;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=klX9V4N0NJIfuTv1ZGxX5kpjpJ5Sm8VJJb672nNfkbo=;
	b=RMxgP0kwsOUM7Ivg/z7Z7Dy9RJwxlw8H0l8VM7vhrkTDv37Ph8zFEdN7KPPty0c5ogME
	 o9KtF6G1S1DML9gAIMeDGplpziCVtHdZt7KGRE52LRPrto86YY+HbcUN7jY49QeOjT4cB
	 H7VmEq9Ieh9unerrIaQ2VTCI8hplBDkB3erONz9OVIjIjBaxsxQp5MEwR9ICcDq6jAZBi
	 z2gD0GcIoHLLKZOAPv5GLEF+OLVht94A0/UZuQALAxZU6DlGkVHGpQJLMcrS5tw0jQRmw
	 U+pzRDEEggvrxsSXkqrwE/tr7wQEb+XaHCrmD7JYKOL5H5NtEO2FpBzk/PbvsY0823A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F376y3ON;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F7606A338;
	Fri, 20 Nov 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F376y3ON
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795161947;
	b=M1jwbbmVbXsRexYrMvMQgwMMRTpuX+WuURqcNlPDOmEttFpHXavYLmXa2jCMSZkN5Tnv
	 S7xNeQiz3HUOEbW19k+jrdos5/ApAHqnBc4xafYG6d3xat7499qEXYkGUov+H0ua96F7l
	 EzHDHHJdP2KoNiDKrNjYvpE3X33KIXRug3x+diSMbXYmr/LSawIt5S1QLFXU6JnplUpLO
	 L8HmtBdcaQb7DrONWYL3hsCYcthoPK/SZRwU7xtvXV3WLh0g8nYIxotRCv4INZz+f3hHA
	 s8RRgjsKQwEqOsx9JzjxzPAGir44h98+Z8CRC65UDUCTPBYggvtFcNIBx4xSX9O1A2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161947;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=klX9V4N0NJIfuTv1ZGxX5kpjpJ5Sm8VJJb672nNfkbo=;
	b=q/HV0PzZy+7mRfwlFLjhZSnyB8FBYd5iXQEWcsix3k1QsnBHvp2nxUO/zSvwzx8VzaZW
	 +CIKEAv21hmqqXH0XNTz7rp0rYky2HN+MiWvFOiZsJ2+OjNIUbEDSk5+7DErozu5KjSYn
	 Xno5OraXoktHjs6ja2Y9J0ttZRSO/gQeVLZHEIBKACkEvlnOlnxli/B7W4ATyHyuIQPsW
	 IAGP0HBQOe24V4YLmR5jF0rsVQBTSXj0CMn6YqMgLHAQGGNs6T7q9+cWK2w+hnztBb6Im
	 rfGIk6/7B43y1VpGZ3DXdxqzf7rYsruwydEkZE8Ev8KTiY0LCK5R5FtWLUbzbGGDcfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B93701F000CA;
	Fri, 20 Nov 2026 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161947;
	bh=klX9V4N0NJIfuTv1ZGxX5kpjpJ5Sm8VJJb672nNfkbo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=F376y3ONXm1yanDIi6eMQi1EvbmS23XKtXeRBkO6JsUdsExms+tB7lOXOmwFjdy+H
	 0yO3DlBljVFvRE/gifFOekJa+FqnXP6Dnc8fMJmmIqynoNfsHKyEtQjl9nIxaBpn1e
	 C2Zj2cR0ZtMCTNmiru1oMRMmLRr3P0TuVQD2gcWQ5iFGHoKYguGblfNszTxbO3MWUH
	 mMUd1Yg6VoZreCRqVYhXMCrId6OgW7rwehUjwf3oyXvEDmzwQsf2QUv0oQU8OrOHX8
	 gLYBWSWXJqfRB4OpGfO+MIS7i5e6Pw4Wu6WoAbxmKy3/e/B5WOx+oViiwJbwd0oGPR
	 JWWWJCZbIVI2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35B3549774;
	Fri, 20 Nov 2026 08:05:46 +0000 (UTC)
From: Alexandre Rapaille via B4 Relay <devnull+arapaille.atlr-engineering.com@kernel.org>
Subject: [PATCH v2 0/3] msm8974/wcn36xx: recover Wi-Fi after a WCNSS crash
Date: Fri, 20 Nov 2026 09:05:44 +0100
Message-Id: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com>
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
X-B4-Tracking: v=1; b=H4sIAFj//2oC/3WNQQ6CMBBFr0K6dgxTgRBX3sOwKGUKY7SYDqKG9
 O4WWJvM5iXvv1mUUGASdc4WFWhm4dEn0IdM2cH4noC7xErnukLEGt7Wi8C+ghnBuaLq2rw0J7Q
 qrZ6BHH+24rXZWV7tjey0ZlZjYJnG8N1ezrh6/+vpcjBV0dWasMTWXcx0D0C+Z0/J8v3Rjg/Vx
 Bh/vPMC3MsAAAA=
X-Change-ID: 20261118-wcnss-series-v1-ff46db05a31c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Luca Weiss <luca@lucaweiss.eu>, Eugene Krasnikov <k.eugene.e@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org, 
 linux-wireless@vger.kernel.org, 
 Alexandre Rapaille <arapaille@atlr-engineering.com>, stable@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795161947; l=1635;
 i=arapaille@atlr-engineering.com; s=20261118; h=from:subject:message-id;
 bh=V8zx3VibnXSuUNdUrf1O+xzW97DEkNrO4W7jOoPrVv8=;
 b=zi7O5UNapFKo5i3SLpIXYAdq5DBOnd0W7Ir1xiZXrGw8NDdAQ3yruJPt5HsjHIoMf7HFMD/+k
 WM1pWnN3Y0ODjYLCK3LpoLTNclfCi3PqLpX8nQLU7odqJXTjjTM94cI
X-Developer-Key: i=arapaille@atlr-engineering.com; a=ed25519;
 pk=xskH/sIiNU/aZCeGeBB1TK/AuiG3MXlX0m2wMlbMl08=
X-Endpoint-Received: by B4 Relay for
 arapaille@atlr-engineering.com/20261118 with auth_id=1560
X-Original-From: Alexandre Rapaille <arapaille@atlr-engineering.com>
Reply-To: arapaille@atlr-engineering.com

On msm8974 the wcn36xx re-probe after a WCNSS crash fails on an IRQ type
mismatch (DT edge, driver level), so wlan0 stays gone until reboot; seen
on deployed Fairphone 2 gateways.

Tested on a Fairphone 2 (6.12.113 plus this series): 10/10 forced WCNSS
crashes recovered in ~20 s; unpatched, none did. Build-tested on
next-20261117, dtbs_check unchanged.

Patch 1 is for the qcom tree, 2-3 for ath. Patch 2 needs patch 1 on
msm8974, or its WCNSS IRQs would turn edge-triggered.

Signed-off-by: Alexandre Rapaille <arapaille@atlr-engineering.com>
---
Changes in v2:
- Patch 1: Cc stable; picked up Luca's Reviewed-by
- Patch 2: explain the failure in the message; drop Fixes: so only
  patch 1 goes to stable (Loic)
- Patch 3: say why removing alone is not enough (Loic)
- Link to v1: https://patch.msgid.link/20261118-wcnss-series-v1-v1-0-a64d82e151bf@atlr-engineering.com

---
Alexandre Rapaille (3):
      ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt trigger type
      wifi: wcn36xx: Do not enforce interrupt trigger type
      wifi: wcn36xx: Stop waiting on a dead firmware during remove

 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi   | 4 ++--
 drivers/net/wireless/ath/wcn36xx/dxe.c     | 6 +++---
 drivers/net/wireless/ath/wcn36xx/main.c    | 1 +
 drivers/net/wireless/ath/wcn36xx/smd.c     | 8 ++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 4 ++++
 5 files changed, 18 insertions(+), 5 deletions(-)
---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261118-wcnss-series-v1-ff46db05a31c

Best regards,
--  
Alexandre Rapaille <arapaille@atlr-engineering.com>


