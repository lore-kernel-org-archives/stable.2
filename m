Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032014;
	b=Ks/gmCRdiEMcYdMs5pAq7WTSUn9VbN+zOdgDtkvTMeScFXGeZxIulIoIYXSPgzqUnnQQ
	 rdTzA+wOW0GipBHUgDgaK7gmQ158I6fM5vDTQg8dWnvtaX3X44MIdyMIp31Z102gPBuD8
	 HXyqVYF5sMYCCxi9iea4Pqnb0Z7et/xWPGFperdlzl1RHRq2S/faNtGlV2G4fCvOkyMxj
	 JHdAG1GhVenTjmIV56+JX3Sh2NtIEQbTaGyYDTsIe0mO2EMM1ynWl1mwMzL/GsIcMR186
	 Hyrp4/UUw28QVzugh9AX0EMVAa/kvg1Xub8ZMm3GyBJo2QSepezhPH3kBQXkirP8JIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032014;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sEwMsukM+NGMDLoapPF1juXWPBPDoxNj9MJPHnWMM9E=;
	b=3IABQTRf3k6kTL+w/XZPwhKAMnr6HdQoQRX7DghMkdtu0aRTcYn28egYBqWSEa+khdBo
	 tQzkhq50cup0mjoKW3aQsZemApw0dXlOhwmXlTTSLQDtkbuENMKwEWkBdwL019Tvf9t+d
	 ls2BX7kzb9rPzV8kMzukwSUa9HZSvZMKZVHIHicBR94JX51Kfse+MpkCOnd9sHJgl6n55
	 IvGrwV1+GS1/xZQmWJBNvbgF/ohpANTsD5GYRdD0AOo2/sXutvzqY8rFNsu6qUqJR6xtk
	 omLHrA2dVFJIXimEdjDRaS/fUsb3qYs62v0KsS3svvYCoAdpmcN/2UhWbPnrQ6pPQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=DGexzQV4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mdArlIHU;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93E60A2619
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE93E60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=DGexzQV4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mdArlIHU
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4616DEC0AAB
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:26:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 12:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793032012;
	 x=1793118412; bh=sEwMsukM+NGMDLoapPF1juXWPBPDoxNj9MJPHnWMM9E=; b=
	DGexzQV4DFrtjWFBWFx57iRUNmk9EFmw70SUsJRpDQEwBpURHERzdaTNL/uPobD4
	LVDaQSf5qGIrKESaifZJWYvXf33ZOfZJsI1+Qn/HpVaMvEO8+W24Cc12y2wVHEJu
	edzdjuUMI6yaCfk/gOBqhrAiXmM/0AOROBQOw+Ut7Yp0aJcnqV710z7bfvschxw5
	joPWaXUGiO/lcdnBc+QfYpQVtyw84VbHyQSbfLc1MWbWE5ZKmgJSJwKfimtEvzwg
	76T1b+MiwLTsObzWft7wU/JsXq4P57WwY1DPEIwDKQZenkvrfX2y8BGx1AhhjvVi
	ehwq7NfZnp/0wnuYbajZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793032012; x=
	1793118412; bh=sEwMsukM+NGMDLoapPF1juXWPBPDoxNj9MJPHnWMM9E=; b=m
	dArlIHUVeNb/eDaqLy096V+tX7xZVOtIzZmvnznmymY5ggYwizoXvEIs39s7dyqc
	NvE6sHpxCbxZ19/Rxp9o4GLe1hlfv48Jk2QMdd9Zr0YPywhTJSR1POTPpRIGVLgG
	cuLjbGN1kIJ4xGk4rc9D+G1BOpfZ7YbqRFvYr+OrRxi6Q0j9YhCdWU3KMgSuIHl4
	yBNWesj6V6EOjH3EGhedaZzBmltfh8/OxzKMB5W6G8fJDwWVKuen920SL2yNHDzG
	VNLdB26HHXivoN2moyYeNGaTgMHuhHbSNg4qTrvwTuynjlgZz+TuqvTO/2sr2TNp
	vsyoarZIE5Y3QKwmbCJuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793032012; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FbZ+qxBUyBeX6Z+wXWdvd56BUdZp+g5B1qg+QGf9VcxMjxf
	iaPbYLOb/M7VbEqkBxq7lwtGpnAzpapSc1Y8neTvBZ5fl/0HtTEb0Dik/ud6gSRu
	Jb0cJhM0KX7O0M34HQwWUvOPlycDPKeGIruZ1xN9XgJPn9JCQY4+0EHUOKvOmENc
	97vjd3cTwTUUXG2J0VqKvN/kMyMfLkI+/H7y18miKg3nfxK7/t4NkZm10qFOgWgN
	WXmAeH7R+URH7xUywAUa/neG1nBL8WQShOnxgeZ4wm7Y/dMa0Zm0YhueU0PDmcWW
	gCm3BFs3XiRj2bGEpJ76Bss6OtnAjv2YKVuZevQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EgsGmdBzLGarRomk7+anGwgnA1vX1Unz7Rp07YmORnk=:5FPZliX/UHzTA0pASYAyzT9D3A0nrhVaBVcKamAcVfk=;
X-ME-Sender: <xms:TH_falyLCD81VAUGjyrUAhnSKQ2Zsz6r3bj1aOonAk2D7HEh8p3aJA>
    <xme:TH_faipnaFiNDOZp8RmDUtnjgqTNfCpKT03yIjGmiJDH6cDiHFwPQHX-COOchP23p
    598-89QIlJoEjXxfoUP4vyKyl8ooo1frIP2L7AI4QYI06qF-7lGqIfOwg>
X-ME-Received: <xmr:TH_fao25TbqgHy9F-dRzMaxej6AdVz65KlDMit7NQtYcOo-HJyf5X2Zy_th-ij36EXspn9btAU8oPbF0b0AWwXGyO0sbcstLgqo>
X-ME-Proxy-Cause: dmFkZTEWkkLBT9rP3p1Wyz0X+m97kuBUnCDDnSBjZXGE+danOKcks90ZCL1x5kFWbQEwZQ
    C/LOTGnj005YKhoS9HeAw+Erp63RPnpthbHBHREmt9p/MFMd+Md/bpiYc1niUxBlZqQhAK
    59b6OQOTULM98lp1jRF041mVOgzZ4rG32mzoyxZ3yObBAyJagwqWtbE75lg1fpvOcZ5lbO
    nDixwRUg+66OBd8I+jfqYKPPDFhGEMx/7qUc6gwNZAe7hEqt97Wi99Wzb46e8o3Kmh6jXZ
    p7pCYaQY1WTE98lsHtyLyqqoeFi5HqK2hSD36I5k4XGS2xKmyAM1EHIH1fqMrzfu8JsVqM
    TI7mogVM+X/Ywfr+CFT1XxBTDmY91qE93bSYSqQm2mEvMAPfqk9rWh6kpf5s9MaqD7lH1J
    ct2ADenNUdSLNPcJNHtVPqAMyU/62a9TgCzFac6pQbVS1VVWET/mIE/WknUqDRS7dCUOwl
    6/oSSTJ/xUOUQTlhL+h9aq3nX8bmVr37Yd69eDxTZWri9pyJ/avQ4JU/sKP5U0miRsTgMo
    1W3ecmo9Hk5YvAHZb5QvHTl+VtzniUgwJwRqwc/MbbpCkz/PUnd+9i35C0UHAW/+OceXlL
    o5gpIJbY2Yr8kpLeSY6wF8bni7eRyFSYgc8eR7Xczoh+KuIOTZzvHO2Rqvbw
X-ME-Proxy: <xmx:TH_faixxQwX5p4TtFSnnw4RZ7wUaBhfuGDLGVgedQrXlpBIjo2HO_w>
    <xmx:TH_fasg9bbR-axru02r8dm5gAfFbk9fxtciRDd0Bb6gjosIAH0JdQg>
    <xmx:TH_fatpBs1N8VfShLTgV2qolhaK4hHZJAHUGjwXDW6lV87ob2U7JTA>
    <xmx:TH_fari4WWjSUo-wBs3i5mB0JdkIlkZTkanjFWxFcHlSahYltNMLYQ>
    <xmx:TH_faglEz7JB_CCpm01PPDZDuNc_EE7nXgpWOpLaRp2oLQ1uxDIT_Sus>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:26:52 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 26 Oct 2026 17:26:40 +0100
Subject: [PATCH 2/2] net: atlantic: AQC113: Limit multicast filters to
 avaiable slots
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
Message-Id: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-2-d72e99b69583@jannau.net>
References: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net>
In-Reply-To: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=5FPZliX/UHzTA0pASYAyzT9D3A0nrhVaBVcKamAcVfk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqz79a73eT5656Uy19kcmTtX7MFehYYPatv6/9YrOAXWh
 QUKhW3sKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJHMOob/9au/f1A8lFzeUVLa
 niVSGW7JtDLreMq8K3OEU3Nu+D74wMhwvN8quDU3q0xCaWH9h8uR/1YoPvFatevPFR7XyfVSn64
 xAAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Since commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART,
L2 filter slot, MAC address") hw_atl2_hw_multicast_list_set() uses L2
filter slot above the firmware-assigned L2 filter slot for the MAC
address. The count is still limited by (HW_ATL2_MAC_MAX -
HW_ATL2_MAC_MIN) which could in setting out of bounds filter slots.
Limit the count instead against the firmware supplied `l2_filter_count`.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 82be3bb2e76d..41c653c14e5a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -780,7 +780,7 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	int err = 0;
 
-	if (count > (HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN)) {
+	if (count > (priv->l2_filter_count - 1)) {
 		err = -EBADRQC;
 		goto err_exit;
 	}

-- 
2.56.0

