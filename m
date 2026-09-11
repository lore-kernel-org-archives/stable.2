Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B940E8CD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109936; cv=none; b=B3D9iQ4EPExn+THn/KLlvYkGxc8F+p6iZCqroxxzbRH2biWLUkc8tythflDhX25feP7lfXNygPbSenoDqtqaczlx7wVTWWh18bWe1cDC3oaKpvBc4RUzyr7z2dJKu4xOuf7JAwwIv4ilZse0/OcWsphmc3/Y96SIy1xdp6Ujt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109936; c=relaxed/simple;
	bh=a605jU1pvQWqUiL7tcAWYklt0O8GbI56dhq13ru7r/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jy2/4K0GuWNOstFACfPCrPC5bEDOB/GnrgEigmEfc1zS0o7DGlKjAXhkpQPKYM+DPfdaAi0AP1ivKd5MIE5oCk08S82lew/232us8N10Md1TzoxvWE6KReNlxZI+cCvh7tqSJXs3D34njCwGEiJGXSaltgsYOHZmE2TBg+cO0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5ZIm9HZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ZIm9HZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d715f4a587so7405575ad.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789109924; x=1789714724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJmAEC50POxoDcN++SEhq+0rid1s+953+Y3vycFEQyk=;
        b=H5ZIm9HZJYAwpXJDQjioWAlsQ3Y3qlgYeusOH3a3tmeAi6JA/O2d5wiOfpsEA3L/HQ
         jd/nxcbRZFDi5lIbWLNQ2OeBTlYPsUzzKL+Vfkwmnfy1IO4/1fGnNKm0ifLUyz0KbLqL
         m7AWAHko95vlyjCAvtQ7cD8JoHNKLs9U1WtwzXDfnLXYSn810SEErxT0iRLzNqJl1ekP
         4xoY5CKx9Gf/DW//yo0ZFIx332UybVtHvBN+EWr6qzd/yVmDVcFDGyTyM4hoGiFUACjw
         Y99mqYfCylBcBKkcDfvibh3C5pGZ85wa4uq4Kd6NHpCJfpVeKPPcyh+XhAFBkyfifxHo
         8PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789109924; x=1789714724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJmAEC50POxoDcN++SEhq+0rid1s+953+Y3vycFEQyk=;
        b=V29Zn4ixoiYulTmccqCsZtWbLm9OFHzIelc5+IWui482DLZj1mhPfbaZ91jqkw7h1+
         Ah7UwdBV+B1fqSvM5CBMpNMcA6C1GY+fsfnevTkvcOmtXvuc91V5lvaaQN0fGHqqKq0m
         lH/oOv7P05AgLkC3KoiQ3fJoBc9MgHxPQ+vi5RgvnF/nazUpYOLJBJIsu8Be0UjzRpme
         4TzRuHuHBUJjuGex1mSLV1BHcRQ3odILs1ogafpASFLKjegnOABM3q/k8MpcNiMnRbj6
         AWi+6tklHzsGiHYHDAKQQXFxikrcR49O1RrCb4/lVSCFB+Kx4PVou2Fx+OMsIm68orNY
         UAFg==
X-Forwarded-Encrypted: i=1; AKwUvBypJFui3dtL4B+rzzQh4p2+ULur7nhb60ObrHk/I3QJy2tSTr7QiouiNwREpptjUQc9ktENW6g=@vger.kernel.org
X-Gm-Message-State: AFuF++lc4OShXq/XsP8im9edLtzXNQ1/cEVPlfNjxXD236JBs9yNpiEs
	3RdbZmPT53gIHrY+1ik2MWlYDbk3K+d1dJe1UJfVMW4tIz4nRekxgvgs
X-Gm-Gg: AYBFou3gqLrV4xz8As2os72tAOw5s5/GgoxUG9Q0paQGijr4qVJKOb8EPzA2AZEdWV1
	b/nkgtXY/tYKqvsY3JeVfmfL0q4/7PO7RZpg5PeS8VFarcXRqa143BHj1QUzX4zmiuBrQSoTD31
	dyj5khuFQQhK9yXSm9J5THe6Zjwjfxe3Z3rb4o5jUdEAEbJYbCPnJ19yvx4DMMu3gYRy27+ogsZ
	TG7RdIPa3MgngFpepEtG/7Gw21nPEm+Gq5jGnAG058gVmlxMQEaqCd/mguAI4/CJUEUabnI5C7D
	DsMt5ZD6zBNSEPn0sIDeg2T6yANiVoMYRytCuirsLD/MQMsfZPzB1sBpkRQf+aLXHxEs9mHpkAB
	5Ds68a67G0cXNuUydGJCDD+YmFF5E72zNj9gH5i99yfAv8Anqz8KELAwckVpeiQYELR5d4q3TBv
	RLVcwsFS48RSQWAHl4ons71RAP91jQnivN/aWSG8Oa611PmG3Owhsbr6mvQq8m1d62dtqA5aZma
	Fk6kJp8cgxB6TbP0dLVw1Va3+p+s7IOalbKPSGqI+E=
X-Received: by 2002:a17:90a:e710:b0:398:d843:cad9 with SMTP id 98e67ed59e1d1-39d9c202f33mr5190127a91.19.1789109924394;
        Thu, 10 Sep 2026 23:58:44 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm3061850a91.13.2026.09.10.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:58:43 -0700 (PDT)
From: henrymei <ljp1205831794@gmail.com>
X-Google-Original-From: henrymei <henrymei@tencent.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: n_gsm: keep DLCI 0 object across mux restarts
Date: Fri, 11 Sep 2026 14:58:26 +0800
Message-ID: <20260911065826.3515170-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

gsmtty_install() takes a reference on the object occupying the
gsm->dlci[0] slot, and gsmtty_cleanup() drops a reference on whatever
object occupies the slot at cleanup time. The two are expected to
balance on the same object, but gsm_activate_mux() breaks that: on a
mux restart (GSMIOC_SETCONF with a need_restart change) it
unconditionally allocates a fresh DLCI 0 into the slot, orphaning the
old object which still has install-time references outstanding.

When the last of those old gsmttys is closed, gsmtty_cleanup() then
drops its slot reference on the *new* DLCI 0, driving its base kref
from 1 to 0: gsm_dlci_free() frees it and NULLs the slot while the
mux stays alive (dead == false), and the old object is leaked. The
next gsmtty open passes the dead check and dereferences the NULL slot
in gsmtty_install() (dlci_get(gsm->dlci[0])), crashing the kernel.

Keep the DLCI 0 object in the slot on reactivation when one is still
present: it can only still be there because open gsmttys hold
references on it, and gsm_dlci_free() is the only code that clears the
slot and only runs at kref 0, so the slot identity can no longer
change while install-time references are outstanding. Re-take the base
reference that gsm_cleanup_mux() dropped via gsm_dlci_release(), clear
the dead flag it set, and refresh the per-object config fields exactly
like a fresh gsm_dlci_alloc() would, since the restart may carry a
config change.

This also restores the invariant that dead == false implies
gsm->dlci[0] != NULL, making the NULL dereference structurally
impossible.

Fixes: 6ab8fba7fcb0 ("tty: n_gsm: Added refcount usage to gsm_mux and gsm_dlci structs")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 drivers/tty/n_gsm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..2ca7e18addc5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3186,7 +3186,29 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
-	dlci = gsm_dlci_alloc(gsm, 0);
+	dlci = gsm->dlci[0];
+	if (dlci) {
+		/*
+		 * gsmtty_install() takes a reference on the object that
+		 * occupies the dlci[0] slot and gsmtty_cleanup() drops a
+		 * reference on the object occupying the slot at cleanup
+		 * time. Replacing the object here while such references
+		 * are still outstanding makes the cleanup reference drop
+		 * on the wrong (new) object, freeing it prematurely, and
+		 * leaks the old one. Keep the still-referenced object in
+		 * the slot and re-take the base reference that
+		 * gsm_cleanup_mux() dropped so the install and cleanup
+		 * references always balance on the same object.
+		 */
+		dlci_get(dlci);
+		dlci->dead = false;
+		dlci->adaption = gsm->adaption;
+		dlci->mtu = gsm->mtu;
+		dlci->ftype = gsm->ftype;
+		dlci->k = gsm->k;
+	} else {
+		dlci = gsm_dlci_alloc(gsm, 0);
+	}
 	if (dlci == NULL)
 		return -ENOMEM;
 
-- 
2.43.7

