Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCA44CAD3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677332; cv=none; b=QuKDQ1DoqrSEWes5kuhw2QhUyrcwju0yn1pI9+TdEQml1Ar0NUosffRmW1pXfWGCphHSd43b12wkLXTcJ4aQ/HeojuYD6sYss0/AakjKJsoj4rXPd7vEIFPyt9iHQymfZJmYGy/4V/vq5TsEpreRTjkPSBRoKe+E5Ok0j6m0mnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677332; c=relaxed/simple;
	bh=lfsKa/6nWd1WeNSKQEWCORZMu18sdg3PgeSTNTGJNjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl6osbNOOLzJ5S3XVgfb35w+9GpkxgUj+JI8BrphVZoyTPUoFU3RACCjZIedQ4uCZ1XF/eYDBgABOAS7VeTor+D+sYycL6SKntI+9mgv2f44+KNtJ83J3/JkG7gsEs0q0HyDevw1h/CDJXEjKfdM2nfIRCjwTRrlgnY0fPn4+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQmMK16y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQmMK16y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf41bab353so60884285ad.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784677330; x=1785282130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcCaNVJMRbgRqDGVlIVjG45ESGz/FOCLpttKwD0Luz8=;
        b=YQmMK16yepWFVog/ACOP1qOwYgvwXrVYNou3Lq4pOG1AzOSiZh97QqIoDHPWJhpV3F
         jeltmSxU6eSAzJ5W2xcoixSFH5qoYY3fxu0eUT8ibrDSKtZiMOY2qXfyyktko2/PwFRt
         xeECt1WXasFTSHY7l5vuBXKc6QvKxJ2MVNPC4xsO5W7xe/bPV1y0zk7KRlmbOoSOzbaS
         QQjnK2uQV2bH5GtqgwVwtSW1LlcwYTEwP4trSVcUg2X+vWBV/on9iTT0Zk5pP64JM8vf
         4qVAiAUy7dwXy/khiRZnr21YstR0zpH01aHpmlgHGdU1x79kaoia+MLfoR9QT1391s4m
         nERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677330; x=1785282130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AcCaNVJMRbgRqDGVlIVjG45ESGz/FOCLpttKwD0Luz8=;
        b=V/BhysER/a2voJiJvYVjVmfKRnpkcfxfFd2UzHCAZQJPTi6S6QbS4OCORb1Zyq+IZ7
         f9KK5Fk435Ou44wOXXHO+Lv2MSJlqzuvkehaFDrnfoNNP9wMKQnCudowZT8+RZjcJ/Ku
         S4SFg0G09Iqzua7dMCXj9pGdjZRNrlET4GsNK3bmMr7kCJHKGpGUpQ8KrKDmyZVLz+8q
         Lz5/b9TrQ/RGGCQCMEUMMdM2lb+gUCkwbY7pdKef2ripPcUDWkzLwWENs6lGR0MA29XT
         xBkJz8xYz7Pp2DJvHx52H954z7W/1tAt6AgfJ2oEdftwF2Fp2cEMmpSdWQfqg2gQNajD
         2VCg==
X-Gm-Message-State: AOJu0Yy9TM3Ncm8Bax/0Hg1UqUvAAR5rxmtuWMdVN07LjRs77aTnfEFw
	LMeYXRCWxCUhtSnPcR5ikmj9bRzEkju6CsNAGVFhct8y39iB+rwQ6CMNm5D617+puxc=
X-Gm-Gg: AR+sD10VlFTadGHjN2/UMa2or1OshoHby7ldQe4qZO/gxFCMb2/m1daTn+mkWfQi00q
	yhe1D5iB+6pNujGM0CuO7I3OEykGRKwzGBHVnmRLfjjDaI8lhaqA5TPeckgevwIn9QjCv7meiy4
	w5MLUQI8wBDWL20HiCoFMJrnLrIi0YIi3plXc1K8S47B92QhNmGgN+KanUyA/iTRY5fA4UX+q34
	03feKxnJqOd2jPQB9Pn4GdK6jt+2VEqOey9zCdLFfX11tAOqUt/mh1QA7XGKKyrFCx5SpmqiWmD
	X1Jzt2W8db5PzqOhzKTXjsgo1n8PwQ2DdmPFI71ByPuWYHkpAuolohVJHnG5SXcM3ysWGSglIfD
	RBNo9zwBnV+HlyZuqSe6tkNfQOrWO9ae9mn1whuTOOatSy9YID236l6blUXLjPAqF/AOeI99kfn
	H2WM08Lj204BT0XpAeU9ndbShn
X-Received: by 2002:a17:903:458d:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2cf3484bed4mr206563945ad.1.1784677330499;
        Tue, 21 Jul 2026 16:42:10 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3bbf58sm4119325ad.82.2026.07.21.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:42:08 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] macsec: don't read an unset MAC header in macsec_encrypt()
Date: Wed, 22 Jul 2026 08:41:53 +0900
Message-ID: <20260721234153.3480447-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072122-thriving-elevator-16fa@gregkh>
References: <2026072122-thriving-elevator-16fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
(skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
bytes forward and make room for the SecTAG.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches the macsec ndo_start_xmit() with the MAC header unset, so
eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
bounds: a 12-byte heap over-read that is also emitted on the wire as the
frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
build flags it as an unset mac header in skb_mac_header().

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), added
by commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
macvlan_broadcast()") for exactly this purpose.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20260703083634.2035145-1-4ncienth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit f5089008f90c0a7c5520dff3934e0af00adf322d)
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index a8fd213b586d..3a672655fcf7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -666,7 +666,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);
-- 
2.54.0

