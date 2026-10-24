Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792862424;
	b=hZJ+woTje8d08WjLMRENQif8KPywnRbLfeCJhcMrP1jtZV8N5vsqQlQhpzmMyjLszBOy
	 MoU1l9sXrNqL5qv2cgC7wmFI0PKAFcBkvTzoxYHcrCSa80skxvTeENebwI5IDLAdQk3n1
	 se4EXxmMcIoD36BCZ4v515cMjp4un1JC3jh1iQnPPXZ2zqnOm3iWa6GPWg7lJd2EUZTH6
	 IMR08hwGD0NZLdbc4xthwqHVJKP9Kba5z5S9VMDu0qLYi/d+2laRzRPBlA9r4laOkwccL
	 9pTEKYyM8qEQ6biTW9CvlY3jjmGc6+YzUJHMQCqvIQMKJW95fqBwXxUNpx20Ova3C7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862424;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RGVmJ2lFA2gfgXgql8Rn0xxSJJgTsAownRry7w6u7Wk=;
	b=Oi0lxjY+8CYgjezt5pb2u4gTrFapLWc7eCqEXZHz8N30YPxTmq1JuhdrsN4XVVLADDoz
	 i5/qdSiJkqJGpLHyd24OfmEC5BwQRmGSvQFZHVqy5juQKB7VOU2abaCnaCQUpZAKWDXrd
	 ZP2bRnaZicFaAM6xyvopxOIB2Eb0dkSXfFEna6ffdYlpnIzMdBJISwIozGCFsphOb+4rI
	 jNXh9GMDCOD/kVj9ppBb9JM1kYy3O52sptDpGgluBd3IqEdWCddgjwsUGhwnkn8swHQOH
	 W/x8z2aeUbSBhoBrnywcZTZ7BddE/AkZuZ2vFbZ5qdpEa9DxsXLYlS0q14z11YRDSrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=SgFe3PF2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jTy7nzHq;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B042606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 17:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B042606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=SgFe3PF2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jTy7nzHq
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E921EC0188
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:20:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 24 Oct 2026 13:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1792862423; x=1792948823; bh=RG
	VmJ2lFA2gfgXgql8Rn0xxSJJgTsAownRry7w6u7Wk=; b=SgFe3PF26dqJYCYx/J
	RhDeBOIhddOlXAAKijwb8Vy8wdHGMNCLnZBuyhjMVXtCLTCav+E37VcUJB/tamAz
	KB7zJttcMUm/NwINhgjM70OyORb1oy5Wo1rlMorHZ8QYX7cnfxYauXuan1QECwKd
	/VRzwbKngb7YJ8FXEaiXsAP4/TAyu+0FmtsRoQU24obUq6J2HGCw0hPACUBuNA7k
	6iCbvheZ+BhEEQKbs2fMsx8tF+x9D+VcbMMJPH04ONrvE8Bo5cy6dZu6hFU0Eoii
	+ibPvRU2kkr1okSJ/6l7QTge1tvT/lo+Hhu8x2irzTrQ4HnYvextysFMPZA8OUdl
	GJNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792862423; x=1792948823; bh=RGVmJ2lFA2gfgXgql8Rn0xxSJJgT
	sAownRry7w6u7Wk=; b=jTy7nzHqlw7jZptH9I2RxK9RzBW6GYIXgvwd2wUmv7NT
	QNyiXqpSN9ciqVCaMR2tRIbXNr32qeA1cg50PVOYN1vsKzBQSKUJ3jmqV1hEIZZo
	1tDhlEr3wzx/juoO2KVRNdwhdJwIjAs20xzdydf3PIjPB+eBeuJmarwZXGbqPAJT
	AIC/8zc0Y+VHR2jNTbv8nKYMqFlasQIw+wC9GJJkGUyOhti0N5+DP5qPTDlfnGwH
	DePikNuiwak4JarV/mxOCHJ8finvZTHPJw4vM0Z5pjYI0xDWqK64dfjR5PNOmH4C
	Ga2zRhIzOOFTjDo1qLxtKBk7qjERm9S+pnRirOWbMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792862423; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SqLgC1a1N6QWqfP5nTksJVKB20X/eeAkS6k7SYPUxtBFgHT
	wa8/rKNBV0VSnH0dPOTIX4pmg0H6ypjNQhYDY61u7e83+lekSBNPXTGWbT4ySZoX
	xK9+5+/o2ko3o1Qu/w2A2l4AYcLbYCo9n4ctfY8VtAY7UBMmCn3SE9jilbBHGQH2
	1oFS5WUmVOA7BpeW4GWeb7DjImwJHBcfxTszD67z8GFdekFhjh5++frHDAPHLdvW
	3OElU391o2zHjH1agS1io9EorQ0msZKAyLkyr4iW8TdkUbCq+7l2MGRYiBSzEr4A
	BSMHgsus3dRodQ98IVYvK6A30hWuOHgY3KVyASg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:MjjdUjD1TH1u8FR4jM1dnnIhA67LmvEfPVf+2sRrAt0=:bnGHsEZ7pQqFVIzWthCEWF1bKp6VPeCWDVQGvmuTF3g=;
X-ME-Sender: <xms:1ujcaiRqpIsfZ3uU4sG9rhjKABy01FRmqtfy7XOzM2-Y4y64c3UgFQ>
    <xme:1ujcatwAkBZN1cxQ1FeA9M3KuHVGGnQPDxyIqqK-dC0qkvj6Fli7CeoS39gqGzOYP
    cvCAeSxyit0eqS6eod-bxaHi5X90qzrItTuogzKPIe-nlsGca_Klcw>
X-ME-Received: <xmr:1ujcaqpupiIfASvhwY9LEQtHAFEjYtFPaS33O89i67YhpoWy-AjvMkvOk8esVCvOgmq0jTm1F13S4cx3XkBNVE7S20av14WA9gI>
X-ME-Proxy-Cause: dmFkZTFQFZYiDCjVoB0mM+FknsDb4uzSDQV4OYgeIXaKM3oOz3w3kfT7x2bRm/9casA+3R
    QKLMXO1C06dwbXqPEanqqziKkWXacuUxzU0v4Gu0+c7EzB8DR8nKdiN1buKMN4i6lz49hu
    2CVTvVME7aFXf4UQyCHvgww8R5GIzrzG7PGFZgM/Ck9x09tWESRbTlAFg8CpOdlO1N9F0p
    7Tju3NfAN6KN3zMk+ghkCqkUiJxA5VyzxYg9FDNFYWTlHqf/Q8oJUevXlrRHHtZ8axWwft
    NQ3VOeCKiYUjbe0F8OHOVblLNwObWaKBaAktjdqXSGV5z7D/YATUOjS0ES7RKyDFi///eH
    5STZNZmV5LrZM99gwNSilJ2kfI3hegPrekgmbiZulVCDfrfzkccTpdvwaMYswI5Wwdu6lu
    kHtpQMQ9rjSOe7MSYSHxZ4Px6yRM09oKF/wsH8CtJOpIs6aGg75ouuUzaB/Wc+tuFp31tE
    U01soXg32sdRZEC81fWNk6aKAarTqCcwsKlhd1nHyOGXn5grxRF/dUUwg8s5rmSRc6SlhC
    TjSTdAsR5UfTgYyjHdRVgvQcabdRSbjfUP2ON4qk3a0YxuJueX8c0g/ujSMzfaCgqfagcF
    aA8/YKSNemIBY1K3CIpwdSBbSbDqSAJ9ucEJsVcWpFlYbAm/T0MAjEVRWAJA
X-ME-Proxy: <xmx:1ujcag3rc3vMh2fGKMnB995VqJwdabn-X06vy-szgPs2u6DjgsvyrA>
    <xmx:1ujcaqyE_zRvSovXMkFeOzjjYaZJrKwqe6wlDYcwquQNXesUJiRTOA>
    <xmx:1ujcakiLBvuP0QXeeKaUTpSNyzVV5h1Q734ouLoNjtLiKTW4bSS1Ug>
    <xmx:1ujcalpBmpDgDcfqEow1bQBoQwFrVJ_3KKVb0qph0GNRc-JBm98Jqw>
    <xmx:1-jcaoNUlE3UdH2zyy3CPWiAED7-vSLUjsoeFFr52hqhIvk4CBYhy7xb>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 13:20:21 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 24 Oct 2026 19:19:59 +0200
Subject: [PATCH] net: atlantic: AQC113: Initialize struct hw_atl2_priv
 fully
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
Message-Id: <20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBAFf6Xs2YUkRgV/RTyszWtdKDFuQhFK/
 93ocQ4zs1GFKSpdh40Mq1Z95Q7+MND4lDyDNXWm4MLZuxA5o7G0RXLTkeXt/ZGllAVsmA315zO
 im6J7pNMlgXqpGCb9/C+3+75/AdXyfqZ1AAAA
X-Change-ID: 20261024-net-atlantic-aq113-apple-regression-e40f40bd57de
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=bnGHsEZ7pQqFVIzWthCEWF1bKp6VPeCWDVQGvmuTF3g=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw7Ly5I7WRfEcBwY4rq1yfma9jlmGU2+jR9jzDlns2y8
 Qv3w7q7HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZS58LwT8v78Nz6ZwcKPsz4
 9ZddIl/w5tzaRUpdvWeWn7np/GOumzvD/6yKnO4Vb750BL4wuyi/dUXAScsDvvOETAP8zC9ar96
 xlhkA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Leaving parts of struct hw_atl2_priv uninitialized breaks data
transmission on AQC113 NICs integrated in Apple silicon desktop Macs.
Commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") replaced a memset of the whole struct with memsets
of a few fields and initialisation of l3l4_filters[].l[34]_index to -1.
This leaves other fields uninitialized.
Restoring the full struct memset while keeping the initialization of
the l3/l4 filter indices fixes the regression on Apple silicon systems.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
Hej,

commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") broke data transmission on Apple silicon systems
with integrated AQC113. The cause appears to leaving parts of struct
hw_atl2_priv uninitialized. Since the most sensible fix for the issue is
restoring the full struct memset I did not investigate which value in
which field causes the issue.
The fix restores ethernet data transmission on an Apple M1 Max Mac
Studio.
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 25dd7150aaaf..5d6e81fa3bae 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -145,11 +145,7 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
 	if (err)
 		return err;
 
-	memset(&priv->last_stats, 0, sizeof(priv->last_stats));
-	memset(priv->l3_v4_filters, 0, sizeof(priv->l3_v4_filters));
-	memset(priv->l3_v6_filters, 0, sizeof(priv->l3_v6_filters));
-	memset(priv->l4_filters, 0, sizeof(priv->l4_filters));
-	memset(priv->etype_policy, 0, sizeof(priv->etype_policy));
+	memset(priv, 0, sizeof(*priv));
 	for (i = 0; i < HW_ATL2_RPF_L3L4_FILTERS; i++) {
 		priv->l3l4_filters[i].l3_index = -1;
 		priv->l3l4_filters[i].l4_index = -1;

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261024-net-atlantic-aq113-apple-regression-e40f40bd57de

Best regards,
-- 
Janne Grunau <j@jannau.net>

