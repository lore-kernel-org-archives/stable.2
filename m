Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471641;
	b=SvAtu4Tq4+ETQtsYdma0EfKnYz/X/vx1CjpSS1DPZJvmjNYriX9GWL2UDNydQ6m/8YfG
	 nZKs958rOPXUfLXdg/GwFKtUuKyU1ZtfPBLpQgEA3VDy2XEO75uBBu5b9ZHKAToswvLx6
	 JYMlpw+mqVpniNMnN3zNFqiZ/7P6R6QGTkMWxaJHGv7ww65RsL78M1HNjfNfT4bc+U/m3
	 uoV2YNaOVCbwKMeY6VOMzsMf61mwKgN11pRRNKRPi2MXNViY+6lWiGtgTqd5F6Llq9nBY
	 OrToYJyPNetDeprOQbckxoAGBEU32jaCJMuO28F0+hjONPlMVneYLlgRaGuyZ4LBokw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471641;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=zmhn5X3CWYTsEkK58Y2ANNa/NCUnPop7kpMt3Yw06O4=;
	b=PqvsLYNx+DxQm2o0qUNiSUU1IzBD15SJS2Q4764RDL9xMGSIQwT+8ZPcwX6bCASi3Jm5
	 bH3FxQUiiBLYbXSzhJOPraIEzkCbmH0EIKT23T/F6fJSnxO0WlMqKjISRgeaZRY/h7fxN
	 qo8WEZeVGA/TGFyPzl77PYiToi4b6BBiwjNbAwH+zTpt8Hyjs7eEi57ViOX1KpdbBRVPF
	 8dT3MuEtjZrgVbZ/I1iA/YvNBu65ayd1/QGNbmdjb+2lwE+FR8PBcp0QM42pwMLNIDJg/
	 vfwNj425yquH52HfWZgv+jZnx/jCWYSH7sJ46Jz6lsXD/T+817I8E+IU521KLaColWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=PPphDpcu;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B6606A32E;
	Thu, 12 Nov 2026 08:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875B6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=PPphDpcu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794471631;
	bh=AP5wjuHCPtVGPOsgE6fooYfAbISUTGES4rmrzmf3upk=;
	h=From:To:Cc:Subject:Date:From;
	b=PPphDpcuG/Wc4LBIPzfaFmd4dGKGlovLd63NQ6wE52lUDkVTberAXUx63/5svPHAj
	 BBEPZKSR+U+yr44XulXDUpBpjvStSOsE20wwjmaXWmPf/1da0mpqhYUf12I6A9lLjv
	 3mYUnAugMzLV9Z9+JchIMK69NsgdQfPC7DOd78sTS6mqo+5ym+MpS7b9uLdbae2rii
	 Mw0/E6Scln1k1T9Sk/WiJs1RRphTXUZFh4XDjVN63zD8+IzHSan9gLT7MUK9+Zz28y
	 pZxkHnqAkgVwtiA6ypKnzkyEAfBmsiJevyv5QflLQbpuYJqvZvCCxdViz4oiKMNapd
	 TZb64q+13X5Lw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 6436624AAD;
	Thu, 12 Nov 2026 11:20:31 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 12 Nov 2026 11:20:29 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.52.220])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jQCxn3VPszPL7;
	Thu, 12 Nov 2026 11:20:29 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Jeff Johnson <jjohnson@kernel.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH 5.10/5.15] wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
Date: Thu, 12 Nov 2026 11:19:08 +0300
Message-ID: <20261112081910.560-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/12 08:07:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207423 [Nov 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/12 06:40:00 #28854651
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/12 08:07:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

commit 7a246c72132eb943b5844ba79dad597b47429dba upstream.

Currently, in ath11k_wmi_tlv_mac_phy_caps_parse(), kcalloc() sizes the
mac_phy_caps buffer as tot_phy_id * len, where len is clamped to
min(firmware_len, sizeof(struct wmi_mac_phy_capabilities)). The subsequent
memcpy() destination advances by sizeof(full struct) per slot via C
pointer arithmetic, not by the clamped len. When firmware sends short
TLVs, the second and later slots are written past the end of the
allocation.

The reader in ath11k_pull_mac_phy_cap_svc_ready_ext() also indexes the
buffer with full-struct pointer arithmetic, so the allocation must match
that stride.

Fix by using kzalloc_objs(), which derives the element size from the
pointer type, making allocation size and pointer stride provably
consistent regardless of what len the firmware provides.

Compile tested only.

Fixes: 5b90fc760db5 ("ath11k: fix wmi service ready ext tlv parsing")
Assisted-by: Claude:claude-sonnet-4-6
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Link: https://patch.msgid.link/20260728-mac_phy_caps_parse-stride-mismatch-v1-2-27a9c1a3fbd0@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
[mdmitrichenko: Replace the existing kzalloc() call with kcalloc()
 using sizeof(*svc_rdy_ext->mac_phy_caps). kzalloc_objs() is not
 available in 5.10 or 5.15.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-90398.

 drivers/net/wireless/ath/ath11k/wmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6434d3ff0ac6..64178ffdc1af 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3645,14 +3645,16 @@ static int ath11k_wmi_tlv_mac_phy_caps_parse(struct ath11k_base *soc,
 	if (svc_rdy_ext->n_mac_phy_caps >= svc_rdy_ext->tot_phy_id)
 		return -ENOBUFS;
 
-	len = min_t(u16, len, sizeof(struct wmi_mac_phy_capabilities));
 	if (!svc_rdy_ext->n_mac_phy_caps) {
-		svc_rdy_ext->mac_phy_caps = kzalloc((svc_rdy_ext->tot_phy_id) * len,
-						    GFP_ATOMIC);
+		svc_rdy_ext->mac_phy_caps =
+			kcalloc(svc_rdy_ext->tot_phy_id,
+				sizeof(*svc_rdy_ext->mac_phy_caps),
+				GFP_ATOMIC);
 		if (!svc_rdy_ext->mac_phy_caps)
 			return -ENOMEM;
 	}
 
+	len = min_t(u16, len, sizeof(struct wmi_mac_phy_capabilities));
 	memcpy(svc_rdy_ext->mac_phy_caps + svc_rdy_ext->n_mac_phy_caps, ptr, len);
 	svc_rdy_ext->n_mac_phy_caps++;
 	return 0;
-- 
2.43.0

