Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860427;
	b=dsO4v09sPzAgPDOsfuX8ZrGpIGPCFa1bOKmqULAD83DOQp2mUdjxzAhQ4A4X9lXE+34y
	 UugAyW/EnNaDUj4poNCEjj0kzpvL3tdCRDiYvE1O6GULZK4WwbtOw0dzJu7pk6M6sRypK
	 Bm8hbtVdqcbJ//xWcapXVSaOdV4wQH8/7C/N8lazY3tfG2JrRn9zfr8nyuWIDn712moiD
	 3853MWFXSM530qvVah14NSpInrugBbjMNxC7GM2xZk70SjtxoWHgLduzaIl/VtVRl5AU6
	 7SWIrzeUVsRtQhbnQveD5K59HfHHhl2f3sfg2LxoExR52pLZf949a2oNtcTFn4bOPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860427;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=g3jJ/aniX5kGUGfAlghqlj05kG4xZJjBRp+ULqjc2Gw=;
	b=XI+xg0Av6dKH2QIixoACNoB6+kSuhHxTrqzPnSijB6qh+sD5A+4GY+a51C/S9WBzo3KZ
	 bquOB4ujhykRwKsiiqdpC8KFp/pbRiVa+nlAoWwLQfoRK1CIWocgVowLhS+jo+j9EBLZH
	 +lzoNzAIQxV5ofxeOvAGRL7c9kovdskbFXdzKrkqv7ckv4d3+elsPU7POqsubTbrPx5nq
	 8ZL78eGzlnQ8ukFTG/QRPhtFlZ/rf3sKyzu0Skf+3hms00uISxBJVrw7l10B6SyNPQGhU
	 yAHzOpF4V/pA1qtk16YtoYhSJNSiTjBP7dFQhOkmx55vh0hPoRkesJdi+OA89xhfybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=temperror header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=JYk8KFES;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y9rEqULr;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B479606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B479606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=JYk8KFES;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y9rEqULr
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38C3814000F1
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:47:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 24 Oct 2026 12:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1792860420; x=1792946820; bh=g3
	jJ/aniX5kGUGfAlghqlj05kG4xZJjBRp+ULqjc2Gw=; b=JYk8KFESW9t3uw6qBy
	hI/PwK8AqQ6yFbUahVBIP3PjU6CXfJXb9WPnV7uu3tF2oOc7h19sWTe5Vn+uepxK
	+g3XKFjl/uh6IbtXhJ8v+WLl9sO9rkqghmOBYePhoMfUDLgb6tu0Fcz8YfzGUi5k
	ziD0/WwbVb2b9zlbSTkqjOIYf9M8KEtVsoh+smN8WaE0HQ7zeUwfHYD53fYR6s0I
	0PwWW8IxsZ8lqDoWOK8GQr0QvIiDvoAjtuBuurVixNJIC7rBFgkQrdkCSiSmSdPO
	q8dV620jP+99WrraFbAvTMLJpzKu0oMX17uE9kiP1YJWYRdKPh7gyMrNhc0ZjHaF
	BtgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792860420; x=1792946820; bh=g3jJ/aniX5kGUGfAlghqlj05kG4x
	ZJjBRp+ULqjc2Gw=; b=Y9rEqULrYK0Ug1f0iANDinyqNxnGSkCXSHIU9Na5/SGv
	z1d/4jjs6CEFnUvsiqHefkTjD6j2SYY/sLClTWH9/7stLnstl5XAx2ZLwy1Zz6k0
	/VvthJlQckvYmlCVr4s6VGuFW08jjsJ1Up088kzVdOnVgMHpr1QmAZ4Ap3Yd9+fm
	ijPs0g4CG4WJ/k0MDQLESaAJIkIQanAoVnQHYYcK8JJ19QKKXjFvm2UpNN3hxsun
	dlEqKRFno179Vav2JEllVqisjGqd7I9Doq5eh9k1vkrAy6VEiORQCKhceeISDzoX
	EARnXgPaCEoAmnFHGQ4Jp5i0GdWTeqZK21vuWiLcww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792860420; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MYPsjWfQUvXudVlV/8LS3r1W+eqjvqGiTpu3+1yWjv2DeNH
	ZsYiPB+sgjPNnceCpQyshLUnU2r0M001fb+8bBaUVQwEzDbnSXoZZErQoQ7ps42m
	2UEZTK9hxbtnvtK4IG8vfKghnpBGtpZGVYq+aaasDA9+LRglVlsRtuHL/gQ1Nc13
	6bD9JY43ol34/1EdkOcAlIyY06r+y2gWpn9gVR6k2Iy3H8AAfqFHobpTepJ+PlsQ
	WC7jYDoZCxQEyVa395L8mf8zOcblxYpjw77gNJ8PyqbaC33y2swaQn9muLjoHFWT
	aOIASwKuljFklPyGh3ZkodBAyrxLNv0kganLK0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:2V7vfyQFvagtebhP31LBhTs9FJNOAs1HcL4UqvhRpTM=:ETcdozBN6Ckqw0KqFUtuQqq3PRcymZDjEiff/o5nYy0=;
X-ME-Sender: <xms:A-Hcar0r6yysYVq4VsjiXryZ_6TyMiEWaA9aZBHCj05-Y05FhOCy5A>
    <xme:A-Hcal9AjpiUGToQub6dA0TsiPl28k7m08W1LQ83cTjPDiUyUch4W4uX3HgynSXbC
    WBkKFhcAccel-uIt6RSVNQZ-25WJBwC4sH_Z4t8imkVjScvaKKUvspM>
X-ME-Received: <xmr:A-Hcao7dxUubB5i9BBbMeatKL7vDhjgPQcYgYPk1VWx8j9RqA6-nAE8JiZGjNIoTkCkAP9-t9Iy38NglR5VORSsbHx22Gv39fdA>
X-ME-Proxy-Cause: dmFkZTE2M4sKdu9IXP/yF3S2UenmF60GkjF+Ba+YLrK8eiTG1IZ0LHx4YFF6nwNNknF+Ep
    eH6JdyxLINrYvBw10zwWot8XIez8Ww9JXjzi05CRq++lBGhIgidceLLn2R2kBm+4TYOneJ
    5oTwS+2icLsbqK4lfMCd0uHS24aq8DV3cnbKS0aGN/ueBLbqwfR1cv+uG2P8lZtrv8QPqe
    75I6yUWPgsWW3qjQeHwOMmI7RWsN8FSHRL50sDQUEjzvY3NsK5CLJg9yPLnXJgothjgsim
    IGsq9sq7Tm9qis4lOMZW8QkDZK25JtmRCKhRAZHMOM2mpk10CcdfE5Gh50pUj6VCjHtSGE
    OFYS/yjRyCTH1Xjyrmtgwg9Mex9izuo8T0Gq3FCIABEdUg9FykWtfgqDv2e2qO6Tbmvg4a
    4hAAcB+D5/uYG3Kv/hicQzMiFpf3Xl3V8ceoUmvfGNxReB1sjI+nKj+144QvT6wG3xrnEx
    X9rlM/R4BoduovaQx78Hux9xbMN/kTQmJLtbdWDYenkMOGw/dkBtOA5xwcXeF7FtWleW4u
    QPTF+cu8kO6kp7ewtcfvGT08hrs4dUFlCFcImonrekEdWxfDC3xEvgfSp1a8U+ibuDDgnV
    6Us8lyERJO8hmpRrSTEbIFiVwoP1XtQZzcIWbbMVFQdFkYbL8r8K3j9SiqMw
X-ME-Proxy: <xmx:A-HcaltUZihd2XSitSQx6i3qr3NlO1ywXrvEUTOVK7HviKr8eIyluw>
    <xmx:A-Hcai3mkJl3njrqHBGha5El-MFmX2LT8yHO2ap3coAQkVFvHJKaIA>
    <xmx:A-HcamqsqPv9AiBaHy0eY7Pv-dq21IXoHF6KXxitCMvJ2bSGv9JpWQ>
    <xmx:A-HcaqI7-9WUj_BL0uKpSjBbdMYOwkNXveqrHixaHuZ9omAUbxUMpA>
    <xmx:BOHcajZTGZnP-bB7RKe24vnLYd-WAnXMVMIsx8QeVe8fG1jO23e_MRAq>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:46:59 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 24 Oct 2026 18:46:54 +0200
Subject: [PATCH] PCI: apple: Avoid PERST# deassertion through gpiod
 initialization
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
Message-Id: <20261024-pcie-apple-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBAF0KuEWXfAiLjIVUoXVn/TD8EMGkoh5
 O6VLt/mndLRiC7LdErDh517HZhvk+R3qiuUZVi883F2PqhlQpPZBjW0fuhq3Iuy8tBndB4IJac
 QZQzW8OL3v98f1/UDTf31o20AAAA=
X-Change-ID: 20261024-pcie-apple-perst-gpiod-init-b602ee4dca46
To: Marc Zyngier <maz@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=ETcdozBN6Ckqw0KqFUtuQqq3PRcymZDjEiff/o5nYy0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw7Dxm1Ik9o8zt8jm1keLr0xsfkaz5HXXJyZe5qvJon1
 xbUOnVWRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIkov2ZkuLGuT2y5Ce+7bx2/
 HF2yjNnXrGM/PjNrVbeBW1RC5pENhxn+Jx20r7/y4aVR4fzkD6uqmkUmbbrVszkjsTXzLH/i0Rc
 xXAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Commit 87620512681a ("PCI: apple: Fix PERST# polarity") switched the
PERST# polarity by annotaing its GPIO as active low in the device tree
via [1]. It missed to update gpiod_get()'s flags to GPIOD_OUT_HIGH
resulting in deasserting PERST# through gpiod initialization.
The Aquantia AQC113 10GB ethernet device used in some Apple silicon
desktop does not finish link training with this additional PERST#
deassert before the usual PERST# dance.

Link: https://lore.kernel.org/linux-pci/20211123180636.80558-1-maz@kernel.org/ [1]
Fixes: 87620512681a ("PCI: apple: Fix PERST# polarity")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
This issue affects only a single PCIe devices of the handful of built-in
devices integrated in Apple silicon devices. It is usually hidden by
u-boot's initialisation of PCIe devices.
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index c2cffc0659f4..a7f327803060 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -562,7 +562,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	int ret, i;
 
 	reset = devm_fwnode_gpiod_get(pcie->dev, of_fwnode_handle(np), "reset",
-				      GPIOD_OUT_LOW, "PERST#");
+				      GPIOD_OUT_HIGH, "PERST#");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261024-pcie-apple-perst-gpiod-init-b602ee4dca46

Best regards,
-- 
Janne Grunau <j@jannau.net>

