Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736673;
	b=iP4b6EShDSoR1G5o/lvuwajDywHJPdmf5POnJ8NM0gYXN9gHVUF1rIADYh0+2dYeIN8G
	 GdJezrxdb6RNtIs1Fgs1p/OlxFssKP7GJtk3aCUKUu16f75rjnc+gIskAe8sbZSMgn444
	 bnPmlBg6rKc5/TEuQM4Hp+a3IzukuFnN7mZ88kuOfhfGTVoCJwBv0Jq1MaAck+nj7Oeag
	 02UjmQe5c92PdpHTryYpKptX6oWBSQOiS5zel2rnv8b9jBhAaSskxf68r2DK+SCwyHOnZ
	 8a1LYJO6a9ScSoVs4aclgFPMUElG8UUI4p8VL2hA/Ve199cSZsn0vMf4rwl02k0HUdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YFogAghw+u3F9lP/XQuAT19xwMSCcRBlcmsKI0cgtyw=;
	b=5Y7kSOpqIK29yMfsSMOwSB70cP6Q2ChnFWMu6YR3yvxfJ9w6IXPfemnh10CliS9QUDiM
	 HxBwscUZzWBz50aKkzkK7Pcifmn4/GSB3lXAtS82WADwC4kKIJWp4eixuX91lS/2M4JxX
	 DJ9Jk+dssWUdc5T7D2fFN/IEWmnHAEUYK8JQP3XB7zyN1Gjr3Tv/rV3iT8okxHclCPgvA
	 NYv/slP9I0mOJwuCxzvY/Hp1xVc2XF+tn6cn+obTqnJXiL6saP4PMacCX4TqIutuLjgJP
	 vgTb+5U37oR7PXWsaFB8hqCUFwz4PJjs6hRESG2QzTWd8p2vXq8klaXQLi9Jiia69+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="EkOqKp7/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBF606A323;
	Sun, 15 Nov 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FBF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EkOqKp7/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6AE812059FC;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFogAghw+u3F9lP/XQuAT19xwMSCcRBlcmsKI0cgtyw=;
	b=EkOqKp7/eNzTAhlkFW8nusNwlWWg1Cvm4yOraWyivtFM4jDK+PdZ6hYM+l/dipGkoebd3A
	TktUEe0eWeuiCm5K7zbpAVw6dNOTwMxn4NY/+SZxlYe2zyn0DbkkfLMF6f3nSRwqj9pvQ9
	9n7LrX5EReXw1RvSLoPCMC4BXKhGZlLE2aQ8C3o+pCXmCdhn/AZZxzPnjRc///5rpPcw1l
	GkYsvFBjy70oY+TQPQvPnMCK5qwVHM/sNso1zbv9d6gtH8IMkwl/h20nF1ELNh3hKSZOqO
	Yqv5SdFaFWsUPRoux1Oq7ce4AGC9Xem0vgHwqoS775C5HzHVNTKYVjFghKm7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFogAghw+u3F9lP/XQuAT19xwMSCcRBlcmsKI0cgtyw=;
	b=HGBBxiDbalnsDc4p4PMAGZHaLfyon0vdC2GgSqQVxbgTBz0Ehv7TX/v5YlaYN6XRiWCRrM
	VPu29pgAFz6fNlpjCUz3d2ga2BB/evpcw0mGQYph5OqLxvFSKOYN9xyBVK3IvONEaEMTwy
	yPwKFhUJGp3LMROYV7/vNLJVdTeo1m/hkghO6jFM4HMSEmFdikCXvJY97zGMDMR1mdrMeR
	rtKEzwOzQCJgJojLRxpL/DdzUmWhDdsSz8N4PE7FnboGZbKt4zC58F7EcGysTDJOT6xsDP
	ignQlWvEksZtt76usbQf+VHDhUcFbQQMtqlZtC1ucdql+COrVi7hTxHrWRTFgA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=cKr16O9zDU0pdzloTUUXaHcfA8oSsnq+itGw+HATj0h7cn0R676XYil1kc2WKRVaglx/aH
	xXDQ0LnnbP0qlGA4smSMHbCs1zsjWqiJvgSoDBIg4udfG4441vGfCSML2vo2jmcrzf4jEn
	31c5C0KHwNQYSVJmtk+6CxWqEtUZPP9PrkrwI/K30VeSKdcNIhxGTSWf5M/8ZskaKTr/nA
	toLvIVcqtEeOgPoNlKsyWF18/wGCjqpRvNwCZthF/JpXyQWBCn2WXfae0l9yMWnvAB43Gr
	Y7Cd6JS8SgJU7frs+fYi9QPnfIIPb+d9s6L0MgV93GDkp/lFEjTDzxqzVUBovw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWI-11;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0CEA45EC24F;
	Sun, 15 Nov 2026 09:57:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/9] can: netlink: fix static FD-NON-ISO mode validation
Date: Sun, 15 Nov 2026 10:54:54 +0100
Message-ID: <20261115095746.709371-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
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

From: Zhu Ling <zhuling0805@qq.com>

The static CAN_CTRLMODE_FD_NON_ISO mode does not have to be specified when
CAN FD is disabled. Since commit 6742ca18cb41 ("can: netlink: add userland
error messages"), ctrlstatic_missing is calculated before applying this
exception. Disabling CAN FD on a controller with static FD-NON-ISO mode
therefore fails with -EOPNOTSUPP.

Apply the exception to ctrlstatic_missing instead of modifying ctrlstatic.
Keep the original static mode mask and restore it after applying the
userspace mask, so a request that disables CAN FD cannot remove
CAN_CTRLMODE_FD_NON_ISO from priv->ctrlmode.

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/tencent_3A964832542399A780E646D6A6246335C409@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Notes:
    FAQ:
    
    Q: What about netlink payload size underestimation in can_get_size() for
       the IFLA_CAN_BITRATE_MAX attribute.
    A: This issue will be fixed in a follow up patch, to ease backporting to
       stable.
    
    Q: What about netlink payload size underestimation in `can_pwm_get_size()`
       when PWM capabilities exist but `CAN_CTRLMODE_XL_TMS` is disabled?
    A: This issue will be fixed in a follow up patch, to ease backporting to
       stable.

 drivers/net/can/dev/netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 081dfddda000..0cd55613a616 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -332,7 +332,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
-		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
 
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -357,9 +357,9 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
 				    CAN_CTRLMODE_XL_TMS);
 
-	/* clear bits to be modified and copy the flag values */
+	/* clear bits to be modified, copy flags and restore static modes */
 	priv->ctrlmode &= ~cm->mask;
-	priv->ctrlmode |= maskedflags;
+	priv->ctrlmode |= maskedflags | ctrlstatic;
 
 	/* Wipe potential leftovers from previous CAN FD/XL config */
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
-- 
2.53.0

