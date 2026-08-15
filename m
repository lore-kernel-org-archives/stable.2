Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272542A15A
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817599; cv=none; b=YTVKUsztNxs01U7OcTKrkmh5/ucztuAfBY4gau99MbqyIH1eRSjaDKUNe716Mi7zV/NzdSM5R2mF2TQrn9Ty97lWHQNzWek3KVH+8qGvLjk/oyylnW5orr6CcT58nQ+CveQGmCVVHnqZkFX2VpFyBNsI9amdyWJSxkKFQfkvD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817599; c=relaxed/simple;
	bh=AEno/8kJE1dDO+zyyZE4ZuQtK5pId1vsBKGwv9wYw6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDOLQWZePorP/78inm/t3fqxJD9mYtlpDRD7geigaQ8yMUbj6VpNIjTlGyo168nymTMSgJ7zWvlC02AM7IYyTq5Z8m8ujCmDFi128QpjggD9FN5FlwmD4ic/MpFM0vXMpl9vCAjGRkA/A0QwmA1QjDWiu9f5TAXQgdAuLtfs+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPNEHXWc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPNEHXWc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2207293a12.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817597; x=1787422397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=bPNEHXWcL3cTBBHq/xuIj4vGgxmCtkNecbf5R+bYLpfAV8l8zQdZ2kJdslFq3OwF/K
         JFfKABreQjaJFEl6BAJe62vbz8mkC2CKfmDtxGRl/XF0F9cOnwipqBBe29n3TK5fODVT
         rs5VL9yDTO+SFa2pfvsYeVZyaBx/ukCuFiOee99QOdhT024SoFeEvOUvbWsp4etdpCj0
         Lpp15VlJpmWDBr+t9mpZ+eU+gig3+khiHWK4lbl3eLzAPjpR7BtE5YoU9zGt1loUg3n/
         PiAjgH8wsKhFJ0OR0L0hd/pJ9DidigVS8tZPb7lbd53xKrhMIF0sD/OlE4rnahPKBvY/
         3moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817597; x=1787422397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=KPm7JiA5LSyFoWQW1QN1d/ePi90e0Bm4FijAGUqE293fDumFiNoaie+kBBkjss1+4G
         ZdTHGVTevFcpcNfu/zufD0nWYX8riZoYXH/2Y+bCtwVuRhR32qvpEw8G/KZcjLkEpoyb
         zoRZUQ1234OCRCuUXLCUk1wTMSqwMBE4Porq5rSmPf7OTy7UFR18+vCcFuk/9XKCKx9G
         ZrzzbjuMqLdlWhwewf4IGovcyd83exrL1GYyLOmGvN+r7OZ3rO9EieHemuNlgMKtxxFo
         AWIXSHJacXED5+ugdJWQPu7+AfI3YJzPSRQy1A55zpqe10nqG0U2KFixnqqvEY6H8ecv
         cUJg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7mbxL8wYyqUTQXCfXOuECZ73L4m3vyhrho4t4rgju/w1d15zE01ooMrsewZTW/xejyD7dJpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8xyDl0Lbc+M9/IaEGkV/CxxWUSxnYlSqAp326mu2iQXI95mI
	t3etmum5LnNoSAiPVJM67TGPb2MwSht3Th0soNm3GHlcMSPcNjKJ1CDQ
X-Gm-Gg: AR+sD13I1x/Q+pFAopKLvtE9Vdd6VJLjP0kX8K0jJDKuFEH4TnAJM906X4hNdPHvl59
	gDeUcWZNZ7mVH3/Ku+S2eFZq6dRFH56uCpRohPD5fRKH4ssFXCp2LjxtqEvjpoP0Kf/za+zFa/1
	HilVUG/35e0L1y8MPn2fGm6dHZxP64L4kCrW1m8bq4J2RrjAh9Kbxew2lEquhm1fNHSSQd+tg2A
	JC30YhPjpR+QRvSv2i0DELoyznWprxzKTn3Hn5jbGqYmUENDYrX4ss+TyrFwaMRRGqSRJg28WwD
	JrQb9saRIZmTeajx44z9NFPKhoylnPB3XPFW54+nfnDwkBGQeZuTYhNCF9kTgPrMd6quHWUnaj/
	Cbiua2CSLduZJizu5yQcHbpPoiItmTh+w9iF0fpes0pnNJeagu906mzDnZY0nUj+7RVzp8DxEN4
	dp+KCsXpOvtu1YazBKY+P02dyivOwqpGwjyFcGnEM+nULX4EBOr+1njCSXbHiVbfcgOXR9LGdHz
	D5Y/GLOPbnWCLGs5NiovLZ8DWg=
X-Received: by 2002:a17:90b:37c3:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3933afb4ba2mr11589304a91.7.1786817596734;
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk,
	npiggin@gmail.com,
	chleroy@kernel.org,
	grant.likely@secretlab.ca,
	neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org,
	wsa@kernel.org,
	stigge@antcom.de,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] i2c: ibm_iic: fix device_node refcount leak in iic_probe()/iic_remove()
Date: Sun, 16 Aug 2026 02:12:02 +0800
Message-ID: <20260815181204.2321-4-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181204.2321-1-dragonliu2018@gmail.com>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iic_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor iic_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (error_cleanup,
which covers the i2c_add_adapter() failure path; the earlier error paths
jump to the same label before of_node_get() runs, but dev is kzalloc'ed
so dev->adap.dev.of_node is NULL and of_node_put() is a no-op there) and
to iic_remove().

In iic_remove(), i2c_del_adapter() clears adap->dev with memset() at the
end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on ppc44x defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..5c3b973c40d9 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -751,6 +751,8 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
+	of_node_put(dev->adap.dev.of_node);
+
 	if (dev->vaddr)
 		iounmap(dev->vaddr);
 
@@ -764,8 +766,10 @@ static int iic_probe(struct platform_device *ofdev)
 static void iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = platform_get_drvdata(ofdev);
+	struct device_node *node = dev->adap.dev.of_node;
 
 	i2c_del_adapter(&dev->adap);
+	of_node_put(node);
 
 	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
-- 
2.55.0

