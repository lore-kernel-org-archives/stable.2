Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AB416842;
	Sat, 12 Sep 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789206070; cv=none; b=hXjcbyGHSz1u2IroadJunMtYAaMCpKAm3XHr4A8C3nR2Ba9gs/iNQ6DZsRw7ocBrCBt9OdLplyXvRQ4I8EQehebbcQSQH8PaO4Th6RL4TwkBvR/+iSm+2SWpe05BvOZDfilG3FIsPg2fMRiRzMzDr5YV1E+N2SW3QVYm9hbrWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789206070; c=relaxed/simple;
	bh=ddGcxI1iJxi2m2MhRVKWXwBPpir+KlK0dMvBt9NihKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WZJTGc7vQjikNQM4xQ8/UU/rcG2YidN9L9Wvx7ysR/ZuOOUQA+B29+2sD4Zp4gEZYwllQCrEcwcKjWswdxSvOs2g8JLz468mvOHjInC94nb8RQvQ6HY1BBNg0BRLLp3qqN7KJkyEQtXbXDT8WJyxcJHJ3DtMO1PyvBoXpR71xDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=bf7Y37Bf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wbI5F+KE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="bf7Y37Bf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wbI5F+KE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 33163EC0092;
	Sat, 12 Sep 2026 05:41:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 12 Sep 2026 05:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1789206065; x=1789292465; bh=hg
	elB1aNZIxrLEiIkWEq3TlDBqZxOBKRli3gG0SLtmI=; b=bf7Y37BfiRHP4lQkTk
	j9gtd0h8bVr6CJyisVl2Q5PqvijKSybxvV7vr5OjM0XzLhnmeOEAqJgOtLZeDtwB
	S2YLmwG9ueGf6MdJOMXu7PBSce7f2B0VONzbOFLp2UsyPg6K8Z3UsSx9iMRFqO7x
	VLMDO3iOa8F2EALkDc84RexHUfhHTSGLtoD7vXEm29HOfSlvETqMOSt7knW73Oz6
	9kh1cNct0fhFSRe3llUd5ObIwwiIoo3Hh75QkSCjCM0weEI3Ygn9+DzxcFw6qFQe
	1+arzcAFq1uuxOVDwZipsSqtFu/Mc/j3EAGVgZNwY/EOI3QK7cGruIJy4Txj2wGC
	MwYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1789206065; x=1789292465; bh=hgelB1aNZIxrLEiIkWEq3TlDBqZx
	OBKRli3gG0SLtmI=; b=wbI5F+KEnfOi2BCL8e+RcTVonaVA4FSrgcHr/dQ8eOnY
	w1Atf7aA6rRQXUwstvsWBN8iyV2QLeZZAJhBn58ibw4nYDx3wYzyRW6L2uHW7w55
	0WEn+iRuUrynPZHlZvvsRoTm0QLqPhjCCY2WNMF7988fSCq6MdQIwPlA4DX3hbRP
	Of8gqZSY7kzeyt0tQc/8UHUj2Na/NTzQC6/tboj2WHWtiqDbifYbO7JFbinKJZZY
	M355HucrUDXGKnhIGejlS6igo4r7yVQIF6yXc47ifcCnVegsvCr4SBVqDOT3/wlT
	aYNFseZlQcqSmgh+Wo6muCKk80dCVisMkdWR6tPqow==
X-ME-Sender: <xms:MB6laosLFTmM9uvmL2mozEd9LJ7w7ypu51LxSldHyhCaRQC0xec2Gw>
    <xme:MB6laqoT-ZTWaZadFYFRSbPmCLpouKVEuzwqn8i5r9lW2nGCVU8MIuQP9__6j2hQP
    RPvwVuVkxK2bj8nG2gz5yMPhMyqZ2FzLT2LtEBmH0YEgLYS27pyYRw>
X-ME-Received: <xmr:MB6lanKj2uFwtv9aPk1QTQPrRKMeTmwyBIipffzBrzvgp-TmFonbX7fiGP3hNnRSP__N0kbzqniUZ9OQiptbuCF1edojXxChR9yzXA>
X-ME-Proxy-Cause: dmFkZTGMMXxsWH1QA8Yl0LAzl/pT4bdCejj2Kw6+qtO58AApVjKHspXnqQhgwf2GP2kCJ6
    AWZpTBnfySAXQUTWeBOifuFmR0WrLuTnzTavcovK63y77UMk7exYrU44UVWz/tzgneH6h7
    XlM32+xqTqxJRK4OGRK0KG1HoN9KKCuv18DjEJZlvEnGPO2fsjS8XjI49W0KUtb8/FlqY5
    yMVGyVfoltZFC3FuavBhr5e/KfKmlVcnsnYZ2y0d5blQirggJqcso87oKaM3sCdVChw5wT
    OlVTpUIFQzgrqZ0e90NMewDqIsxeAr+T/gB6c33/uzTHNjksqOl/d2OEvoUsm0aHNkiGk/
    umj68XXlUq3TiXFeGN87pSEnDNSSzPyxTSwRN19nmdT5nzBfAd5nfxNiLDnjVE07CTUJRf
    VQnDBv1NmrC6srdTuhke3muqchoqPGbTvSk/Abm8qcSU/AIrnV6o6vjDlw2+XQl5LLSbbK
    uDPy3x6CkXZH8uqcn5kW7BkAdSJc+KuYhSCaaykHZQqbpTv2SkTwhwFIx8tLiA9Obj9buZ
    bAIYoh9IG/VAjPGTDHtGrO18T73t2EUQVJzacmimMIt0sEe4Dk7NC4uSkAu4fd9sppLa8C
    ZIKr9UHSPSTc2Rj5sTMTn/cn9JsADF01i8TEzY2XKxPNCkYHLY6MaIS4BHpA
X-ME-Proxy: <xmx:MB6laqtCJsBKIRnuV--rCgVifyycg_Xs4WxVcootbmwM1hjMC_f7dA>
    <xmx:MB6lakCYT9Jzj3cic1No8RD3G7x0sG-BFaEdTBrw8ZgLVXAb8w2Iqg>
    <xmx:MB6lai7TjSps0ZCi8fV4QxvbuYWDDgHIqYiAsF_KtX4NBnA5dSAFIA>
    <xmx:MB6lasDPQV_fx5r0HhP8-vYHp5yu_e1y1Abv6EczySY4KqnZlrS8TA>
    <xmx:MR6larFXeElB3ac3b9EM0uq9OnyT59sjcLqpASKkf8tfEvvMIvZQH4T7>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 05:41:04 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 12 Sep 2026 11:40:51 +0200
Subject: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way
 HS offload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQrCMBBFr1Jm7UCaWqleRVyMyYwZtIkksSqld
 ze4ew8e/69QOCsXOHUrZF60aIpN+l0HLlC8MapvDtbYgzn2Fq/ZzTKTw/2bvtgSXwLdGZPII5F
 HetXAsaqjyh55aYzTOMg4EVszMLTlZ2bRz//1fNm2H3DI07SFAAAA
X-Change-ID: 20260912-brcmfmac-4way-handshake-offload-authenticated-event-853f58ae203e
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Hante Meuleman <meuleman@broadcom.com>, 
 "Gautam Shukla (Gautam Kumar)" <gautams@broadcom.com>, 
 Kalle Valo <kvalo@kernel.org>, 
 Pieter-Paul Giesberts <pieterpg@broadcom.com>
Cc: Jason Huang <jason.huang2@infineon.com>, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=ddGcxI1iJxi2m2MhRVKWXwBPpir+KlK0dMvBt9NihKA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqylcno2wmmeAd0NXEvfPY6XSDE82LJYsOv6FWb3tCOtJ
 Xf+TK/oKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJGzRQz/LJ9k/JTZslopdkJM
 +bXcA/vWWZ6ds3PW2pOKxYfinolV3mL4p24Xs1ji4CGz4LAjp4svvPZVXXvs+bMitxm1moK/z8+
 NZwUA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Since commit 416386060 ("Mark authorization completed on driver
indication during 4-way HS offload") [0] wpa_supplicant expects
NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
driver supports 4-way handshake offload.
This was apparently never tested with the upstream brcmfmac driver as it
does not report this. This broke authentication on Apple silicon devices
(BRCM4378, BRMC4387, BRMC4388) and other devices when wpa_supplicant
2.11 was released [1]. This was initially dealt with by reverting the
commit in Fedora [2] and other Linux distributions.
Instead of carrying the revert over to wpa_supplicant 2.12 add the
expected NL80211_CMD_PORT_AUTHORIZED when the connection is established.
This will conflict with the "brcmfmac: add FT/OKC roaming offload
support" [3] series but is written in a way to easily resolve the
conflicts.

The "Fixes:" tag is not fully accurate as this has only become an issue
after userspace changes years later. Since the change is expected to be
required in all active stable branches for wpa_supplicant 2.11 / 2.12
compatibility it is helpful even though BRCMF_PROFILE_FWSUP_SAE did not
exists then.

Link: https://github.com/zephyrproject-rtos/hostap/commit/41638606054a09867fe3f9a2b5523aa4678cbfa5 [0]
Link: https://lists.infradead.org/pipermail/hostap/2024-August/042893.html [1]
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302577 [2]
Link: https://lore.kernel.org/linux-wireless/20260911065656.1269623-5-Jason.Huang2@infineon.com/ [3]
Cc: stable@vger.kernel.org
Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 872c48806d09..9fd0ec6255b0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6504,6 +6504,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -6528,7 +6529,15 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.req_ie_len = conn_info->req_ie_len;
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
+		authorized = completed &&
+			     ((profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) ||
+			      (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK));
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+		if (authorized) {
+			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0,
+						 GFP_KERNEL);
+			brcmf_dbg(CONN, "Report port authorized\n");
+		}
 		brcmf_dbg(CONN, "Report connect result - connection %s\n",
 			  completed ? "succeeded" : "failed");
 	}

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260912-brcmfmac-4way-handshake-offload-authenticated-event-853f58ae203e

Best regards,
-- 
Janne Grunau <j@jannau.net>

