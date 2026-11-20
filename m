Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190506;
	b=CowUE7NwWgxPvYfVuzsHe+rSJRxKnCIB0Xm5pUrQeOYcRU/gb7W+YaNFIzHDwKqcYc26
	 zS0ciSrm90Ga/b21rcYqNjzCHBLa4+FkVGY9n0oIz2jINIZSPo4tNgs6tOQRWst2Wh9EO
	 YulleHTmnc+U2I0QISuy4+S77OCAkKxjGZc4X2eMeaFlKfM+JUXm1jkESV5biI8CLo8h2
	 pakZa5F8v1rGAj3nOXEOqfF/YOehJKiwAzFgjvCQE//tiPB6yZlMdIy8bEtV2pRv/MKuz
	 7HK5GFG27LOOzMSB2ld3wqwieaXuuGCh2fwdiVRqFLk3LcdGPHHreUNv0cH2WwzDryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=NtVw7HJE+FU9DI3xWpl8Pyt0L7yMJpDS2sfT356C23w=;
	b=dPft+KqNeRH7UlEfC/aPZA8fTt/Vj0fTfEpKtk/h29tzXvu6KT8B5cPHKBbdUEMOfRZs
	 NLiGiDg3mv8ibx3v413qgr/DOqBQ5PDryB+fsxdQOIeJ6Op7dRW4R0Te+nGzuamw557rI
	 89v0SoofEo0fg9iZBx7b4paNdYVqrLKCTVj5wDmFphd+2ijJ0BqyEOHbf1ZeoRcPcObE/
	 ssaRi5aTU0mznm8RgGPyIrIt3ZQiYlPZS/0BqDku6ENQ98ZspaSAztysXMXEwj1kHIffc
	 ND7YpF134bKaI8PLc5akJ1GCDi9R2Q7Rrhz0nkH/rxC/+sE5bBBhfTgYPfgCC58LKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAXUnE15;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C5606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556C5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAXUnE15
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-862df509d48so746513a34.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190505; x=1795795305; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NtVw7HJE+FU9DI3xWpl8Pyt0L7yMJpDS2sfT356C23w=;
        b=XAXUnE15xCXWUgDbFmuMCBMg4ffNmK383G4cW2vjVWZ0Y96B6uK1rt7PtSzIDEEfNF
         DoSZDtVwTnHMSjXSDZbYSen6XFgwdJ11nlfGjRTbFg+2b0BNg9Y9nZ724IgwJfq9Nnr2
         G7SOupfYUkuyQ4k560TgLLrWwgnAC7IugZNqvCeoCiEwGkdXnlqPVxvHkYjC410LNW22
         512PQtAiYK68Wa2+nldfJZLooBuwx89dFBhYXzeLW75NlK0F1MAN9EiXx4MGqc/jYXH1
         WulTezX3aDXms0TkxfSm4r66RKifVn59DH7QYvhKh9o7Xb1z5K38XMFLPFXUCuQHBrPL
         IIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190505; x=1795795305;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NtVw7HJE+FU9DI3xWpl8Pyt0L7yMJpDS2sfT356C23w=;
        b=WYoyW8frYghU3r2k2mIbIMxYc7EHSUVSXao4r+w+15Ym4lwILVQV0TEKJrWI3d0MTZ
         ZKYyIVdusBPbMVtW42ZJMOwzk1VVP+TknBHy0AgQb0BLbRW4uX2FCXj6Vr0wDYo1HewK
         FiVHKBc4jpz9ohXzljp1AKR4Oh5p6WJmPQtGFCLyD5JKlOylnTOdpbtkQiyOh5TON9F3
         ceT1k06VRfeyCj3uW4Iz+cn+02OmqMSyBvsrJH2W3Vzrcu5FsS8KENe3G5jlfEukruDF
         gPzi98AfmQzLcDmqLgs7KdP8ULU/RF+w+2YA6dDbK52VJ26FpMPmXaiU9ph9CdzTkMdK
         ecaQ==
X-Forwarded-Encrypted: i=1; AL+hErF2jpaYbkTZZV7Xjq/UmwBoWft0uezvF39ZBRr78CwU6kI3/et61HN68h3DoTKWxtenOkG2ovo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XtaQrTeQJjMOfe24iEad4qTdPief93DE+XyvuOrTHjqw5s14J
	37qtN4OfH05qB54H8v1sygjyoMgnvUZ5pH9bEpD/ruFxvCUDvyZ0hbkJ
X-Gm-Gg: AYBFou0Dd3SGGUWhBycheqUr10UMssq//PsGCVyFGfgBEbyQR2U4P3lJYQ3n0nnoIMD
	nm2xdo2JhGNon7Y3NKWRznkKBv/AKhg/438j3Fypei/JcgUOwtWPcYN1WEVV3N3GJV5DMfImX3j
	lQCc+o+LVUZYpkYXYm5eEXXoMUV1CghVikljH6m31Z187M2dZ/8+NzxMyCYDHPiLCTqSvSDAaqi
	SILL4QQ8Pl9GeRwixFAfiGZBWGerb9ostYNPYefiaKOu5UJthov4Sjy/Go/WWr9qTAj1fzBJFVJ
	s192u04icvLs/8yMcjUUvTtkn+hT5Qgu/y4sIyZOYoqJ6eAv9X6gb3YrMOq90spLbf3Fjn4f+aZ
	rNJsXkdwhy6CIdyr2DM+kZZdRwaLyWcq8xlN86Wf6RMkunJcwv2S7PJZtuGJgOnRRHsUCj76+uu
	gDFkBQ7sq+IubVdWqEb7yiUyVWzAHHQW5NvMda42JW2PSy71/sIEvj0/nFwHgx35DSqfm/okwD6
	4Uzykpn0pX+tXjuRhMbKLIlGW+b5SSQ20B6Xx/vuvnf4LZ5yriFVotc41ogkNgEKHCgG6XvOYvl
	Uo3JWG2Ph71nxKjcH9Dr2Xh2w6qeSG2CTe+WcMkKvPGylLmUW+WVdTufLYPKDkVwa/n5E5tY9Ol
	iG8tob0FX+XwH01nwJxkXaImLM1FhDjoBhaCLv76AHuOx4ND7yebBVl3uGchAERj3kMRZw5xeME
	kgV/ZqaKax8aN7Jjn0q9Vt+0AEPxnWQnC9okK8h/FS3mfCCoqMKZQ=
X-Received: by 2002:a05:6830:3916:b0:845:614b:eab9 with SMTP id 46e09a7af769-863091a9d18mr3867703a34.6.1795190505053;
        Fri, 20 Nov 2026 08:01:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2307408a34.14.2026.11.20.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:01:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 09:01:35 -0700
Subject: [PATCH v2] mtd: take a reference when opening an unpartitioned
 master
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
Message-Id: <20261120-submit-mtd-master-open-reference-v1-v2-1-5c2e2ede4ea7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw7CMAxEr4KyxtBU9CNW3AN1kSamNSJJlYQKV
 PXuOO0JkOzFeOznWUTEQBjF9bCIgDNF8o5FeTwIPSo3IJBhLcqirKUsWojv3lICmwxYFRMG8BM
 6CPjAgE4jzBKU7JuqNtrgpRFMmtilz/bl3u2aMU/UKaPzRq8iQh+U02MeMf2ce79if6SYfPhuM
 WeZOf8l4pLQNlIp3eoai+o2WEWvk/ZWdOu6/gDe9JtUCAEAAA==
X-Change-ID: 20261108-submit-mtd-master-open-reference-v1-a1b756dcde47
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

With CONFIG_MTD_PARTITIONED_MASTER disabled, a flash device with no
partitions still gets a /dev/mtdX node. Opening that node does not take
a reference on the master MTD. If the driver unregisters the flash
before the file is closed, the core can unregister the MTD device and
its NVMEM provider while the file is still open.

Take a master reference for a handle on the master and drop it when the
handle is released. A handle on a partition still takes a master
reference only when CONFIG_MTD_PARTITIONED_MASTER is enabled.

Fixes: 264725e35fbc ("mtd: Clean refcounting with MTD_PARTITIONED_MASTER")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Clarify which handles take a master reference and what is released early.
- Link to v1: https://patch.msgid.link/20261108-submit-mtd-master-open-reference-v1-v1-1-871aac8c6e05@gmail.com
---
 drivers/mtd/mtdcore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b170c3144ca8..c51067ea19c8 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1330,6 +1330,7 @@ EXPORT_SYMBOL_GPL(get_mtd_device);
 int __get_mtd_device(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	bool master_ref = mtd == master || IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER);
 	int err;
 
 	if (master->_get_device) {
@@ -1350,7 +1351,7 @@ int __get_mtd_device(struct mtd_info *mtd)
 		mtd = mtd->parent;
 	}
 
-	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+	if (master_ref)
 		kref_get(&master->refcnt);
 
 	return 0;
@@ -1435,6 +1436,7 @@ EXPORT_SYMBOL_GPL(put_mtd_device);
 void __put_mtd_device(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	bool master_ref = mtd == master || IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER);
 
 	while (mtd) {
 		/* kref_put() can relese mtd, so keep a reference mtd->parent */
@@ -1445,7 +1447,7 @@ void __put_mtd_device(struct mtd_info *mtd)
 		mtd = parent;
 	}
 
-	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+	if (master_ref)
 		kref_put(&master->refcnt, mtd_device_release);
 
 	module_put(master->owner);

---
base-commit: 14b6830335eb6d70dec7a235094d66c22d38eb07
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
change-id: 20261108-submit-mtd-master-open-reference-v1-a1b756dcde47

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

