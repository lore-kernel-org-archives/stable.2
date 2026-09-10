Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEF3AA1A9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084477; cv=none; b=X4CPBlucdaKHEhLhrRdnUa5tT7X6omTgOWUtNDKmjjKLBOULRp7u1j6t7IlpmoxJoMTUmmDCFhp/OpytzXchaLaZKxb357fJb9krRiRhdK7o0v+XglWO0+Ehazj+vvxXLHIotSsJL6+lXyt1dfrlJKxXm+EB69NXr86NQblh1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084477; c=relaxed/simple;
	bh=Nn4Ptuj8Cpmwpi6QuWhGjH0tnJrjo/sXPNOtUF2QonU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4TjX3xlQu/UM5ayiVQY9eTFljkvlBJQ6e0iXtFU/TRDxarGP6yjH/gs3jJ4nYECsGCangc0uaUX/oak7+kzfR3QkKkeY15rpMU15XPqfnHyQ1snwFh7Y3tE5zMiMuGF47hbn80YhEKB1kJDKFQdong3kAS45mZuxRD6OGdCAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldhjssNh; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldhjssNh"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so3337166d6.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084475; x=1789689275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEJC8ovy/jeEI3H151lIUXdkoPv4NnE0mIQL+cpW8Yg=;
        b=ldhjssNhDNZSRL44J0gvm7N1HygxUF5u8xfhovLW7h+MEo59NswSXM2UAJa0eJ60yl
         m7cHizF6hGtyABW8Axn0ItPztgFjEhqtfrt4J9AX00vneJDzuCr096r5SDSaq2I9QxUa
         XRNagJwaCh7rCHcCwb5dDqv0O8WR6AbAlYUHtZVLeOiy0/KtWk4JdkGiQiyCyXz0BrJW
         a30r2x+P+2f+HiG82YQ28aCqGI+AkTioxj9ppUrn/kZKVuK+A8w7cMCXOHvmRg1DEzwH
         lULFwbwzfL9rfSvlVMbyGnFc/IEw3jEAGTiHuqJst+BSKVJJGRcBHKyYeQPRPIsZnFmK
         6ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084475; x=1789689275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEJC8ovy/jeEI3H151lIUXdkoPv4NnE0mIQL+cpW8Yg=;
        b=bc+pdOQA8h8wQbbTz7O6Iq02700wWk88DwcKC1+fMwUjuI8NX7HY/zo8kPyLZx8Fcq
         y2VLW9VR/eLDlgsDTBBPmzFqRvvUSXBiQWPl8YUj0MzRFxp+lgRi1UC3y2Zw/tUq/J6c
         spx6RfD0pRAzP+ol2j4afWYL47gYdbjS8n/ctdi6YYNfVmr05ZbBmJOlu7OnnpX7TeYF
         i6aNVMAY5tDmnbMi567IS6sq+i3NaoBpNSmM7FkjpZqHfSgwr2vBMNw4HPKyJA1/y8wH
         2e68EU45hVrjDjpgSWcR8XKiq5pniyVyNBMBG5Mn3EoX4lTigieG1QDlaVPQjA/etfH3
         G+tw==
X-Forwarded-Encrypted: i=1; AKwUvBwCJhwZvTV/1v8YAHZVTU59qUB3gvfCxPCKYMcnI8ZBEka3shKh3Yr+YxRORkqtAp/nwLVMyQM=@vger.kernel.org
X-Gm-Message-State: AFuF++mmoYZd3IFDqHx0MKQ5wIFWp9C8UnZ/V6Y1ucrmirPq4eflEwJf
	fQRBsF+dzeUL6G7R+GqUi2jrLzUKDjWVU6Eb1NjeDP5z4Q1gym+ZX7A=
X-Gm-Gg: AYBFou1yTfh3T/fMSESWIyeaAChHt/KS4Yp+Ax+hd0fYCVSCFFHYtYZzYdgYQbas5f9
	jvgjUTHzisTQmavjayccYMaTvxRoYSEOGQmj1Re/r7Jdf3DFH0wAzuYtBYvg5h+hTjx+gGHqnqU
	lVQ/i1hC834dGkh2btDS5CCmWKnTvtopBOGdiK1yJXDeUTS7N8+AHuLEhZJ4hQVys0/OIIlk3cE
	UCuDQyUbv8eB+fIDINQMp5h5WY1Kaadg7JsFC/A5Vs9McjD1tGIzL0Jy6u3cAMNWu2o84iYqNRQ
	DeqNvoVwJJL42dEO1JcAnB9KrtLIsbU9icpWmClckSZlnoOwaZQ78SXc1/vFWTi+bQGhDTiSP1M
	1kR8cdBNwDn1b8jWT8Yux0MKnWoYk58DFy/+yAIGO3bGvV57ee4vPDLaQ7rEzF+KEYgV5GuaEGV
	M2HDUu1GRV3EtcDCjZBdA5iwNTX5cpne/6E0cEcCUSLqz64Fvk7xRV6m+/D5l1L6EPm2DzxP6kr
	UOrlX+d2yifPtvn1amHGszxbMucYm+DTPgJdbUToD2BmdGS03aNBulKf6PXDe0DQ0B/SaDzLZaE
	IxzrUeHVnc19DT42DWddmc5DwGEJCFz1pg==
X-Received: by 2002:a05:622a:1a8c:b0:530:b2e3:86c0 with SMTP id d75a77b69052e-530c877ae0dmr35072231cf.50.1789084475199;
        Thu, 10 Sep 2026 16:54:35 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/4] net: wan: fsl_ucc_hdlc: validate protocol before starting device
Date: Thu, 10 Sep 2026 19:54:27 -0400
Message-ID: <9cdca816ef561fec983c79c39a3bb9564d4a0e06.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uhdlc_open() starts the UCC, IRQ and NAPI before it calls hdlc_open().
If no HDLC protocol has been attached, hdlc_open() returns -ENOSYS. The
error path then calls uhdlc_close(), which calls hdlc_close() and
dereferences hdlc->proto even though it is NULL. Bringing up a freshly
registered interface before an IF_PROTO ioctl can therefore trigger a
NULL pointer dereference.

Call hdlc_open() before enabling the hardware. Balance a successful
protocol open with hdlc_close() if requesting the IRQ then fails. This
matches peer HDLC drivers and avoids running teardown for a protocol that
never opened.

Fixes: a59addacf899 ("drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f56..82796452e54a2 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,8 +34,6 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
-static int uhdlc_close(struct net_device *dev);
-
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -705,12 +703,18 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
-	int rc = 0;
+	int rc;
 
 	if (priv->hdlc_busy != 1) {
+		rc = hdlc_open(dev);
+		if (rc)
+			return rc;
+
 		if (request_irq(priv->ut_info->uf_info.irq,
-				ucc_hdlc_irq_handler, 0, "hdlc", priv))
+				ucc_hdlc_irq_handler, 0, "hdlc", priv)) {
+			hdlc_close(dev);
 			return -ENODEV;
+		}
 
 		cecr_subblock = ucc_fast_get_qe_cr_subblock(
 					priv->ut_info->uf_info.ucc_num);
@@ -729,13 +733,9 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-
-		rc = hdlc_open(dev);
-		if (rc)
-			uhdlc_close(dev);
 	}
 
-	return rc;
+	return 0;
 }
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
-- 
2.47.1
