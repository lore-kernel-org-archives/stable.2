Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172364;
	b=NtqU/SmhxcAmX0UzVLHbT3f91j4DolaBN0vUVV0dzoHQVo9pmimxgsqUvVJTF6U7vrYT
	 XX70UEABgPhdAoCNZVOtDINY4oJ7s7jj0571wgg3cGhBOB6KjZJP8qnLYmlwiUi8Ofqe7
	 WwO4Jy4qWIi3eI/ZCyT+ym0AsXX2woiva3nodyuhkMqQRbmuRczzQi+4q39POBDgcVmmn
	 buaZxPxg/LatKQvEWSSJfriR7q7nOK/imwq6Pw/7NwRq8sxoFNVu7lplS/OLqupRKWa1j
	 174GyJv+7uuFSyQsrY/6R8jRBEs3dqs/PyKPiYcc0VliFxG7xVA9v+dQLRpZ1sQ8w4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=qlC9xsQzooMGZMAFZeEoUmEZJVGfQC5/v/wrYEO4uww=;
	b=smdTBb8PjGhBeE9PWaaAmbh2CQ+HyRIKwk/q8+jtV9mXlK8peUWCKz32ZSMZv1J+LXIn
	 p+LI/aLIkc3KLL4n0SvP2rw5BIssI2XR4VELn+yO0mCBSvHV4YmkI2X3JMTX1mrVWkEgX
	 YYNwk4HUqFcUbfvok3NTF/ouNSVcIZcBFetx/0puku3kXcyB/qOsK1epwnTiJywUqzMto
	 I5MNk79zPWAkT5n04UYDd7sigNq1JMEapgoDn3qld/AfFRL7yxSdVq54krICK8jH8G8Ue
	 dY0TwprCu4CkoVqiWSKw+Lco+oiqD7S1Z/mimdHSc+a8KB1LRcrEYjYWHC6JvMeVKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvHBd2Wn;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8E606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C8E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvHBd2Wn
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f488ba6e90so75720b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172363; x=1794777163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qlC9xsQzooMGZMAFZeEoUmEZJVGfQC5/v/wrYEO4uww=;
        b=zvHBd2WnZWXeDe9JkWAzywSWt7dKpPAcjChasIheOUl5zCg5ZT5G3xq4yAswh4TVaF
         mqyrpctY6l7Ezhi/rOn9jXmN2vNwjzZolobNFUkwcffXZWPI48vfD2fBz45bCfHi53fR
         bxQ41vDSAoQKvHyoTrQ3Bo8y6EwOvEwXKhzjgb8kTMC8/iU7GZqAHwcMfDTowrdbmY/V
         BKdXwzhtG9zgIYEw+IzFVmr0m+b9juTpSudTdxzfZftKyoUAj5VKrtqmsZWH+1Iu3JAz
         O/uePUGJhFPSzKMgzjfNoReZMKy3eMlbRprb5UJOqSvNzjOqL5zZtz47iX0BNs/x2Bn4
         l1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172363; x=1794777163;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qlC9xsQzooMGZMAFZeEoUmEZJVGfQC5/v/wrYEO4uww=;
        b=XqJ2lgT+mDNv9mj+Y5CxwcBnzqp8WLWN/FPhacoY63/oE41mYfki5hIFYTfhd7Rvjw
         zTqYlL+rJOkAnw+WbF7SrWUP4lgDawjXvuEU08f7QOPARiKFTKk7zxPAXpr4tEAaVM0t
         4h14CNI3XlYNGS/LNLSUxWYsQjMMunp0n49gDawk4OC78QOXAH0h5kp0EvSggY4UAz+J
         Pbbnt5KIdgSqNbmb08AWEDJFF+Lgrdb4EfO9NfIGmwJx6PsHe1VXtbcW6LbsjSGBIKYq
         Ys5HMJC6dSs76c+Xe8HFczBR6ovezQnsdm/27llpASbXL1s+lOhr07gwsm6x7n5JIl2h
         axvA==
X-Forwarded-Encrypted: i=1; AL+hErEbsMN+tik4B3eLg8ebbpzcrw28vAD+p5x6nQabfWTkwgWT5vyBMouYaOG822K2HmhCMqHlbK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E/zL/v9cNrUpkfrUCuo4fWiXNxu0Lyx0SemQOA07R77VxsiIw
	MBaHzyGadmRfOCPSV1lCsimYybTT6rGZgg5J9ScYmmJemvrli3lzRDy+dodrpg==
X-Gm-Gg: AYBFou00y+Vuxm54/+9d8XeOgtZpWuwOAkg6FXhlPMgjtFOJX8p8sxAfRLBxKVY3Lv0
	yy18uqoybrqDr8DguhYo3jSaFGwUlLhNf3sHLqimtvSuj3LM0lvutp3FUG8fld/cu9ne6TuPi5d
	cHQuE2g2zq0Qhinm96g6fboTpIA1N9R9Zjznz+3Ea6xyOxIJLFx1xhedDybfoO+noSjuF1YIl6E
	gFYSJESce4wYdd+JSom+nj/Ki0bh9asVWoXdy5ah2uTGdjnayw4wYg5rMU8LWkeTpUtENOoOqF+
	IEbhZ5gU3ewZq3IMuy2hSivt3nNTo/TSiktZEgiV7jExIUODPYVThOKMZM7BrfhYhz5s2Vb9oY8
	vHyWta2yxAEM/H7kUtZvqMuMIpgBRfdIAdGMzIqgyfUHfE9lC4ZYqT/jCEtaL58xGwM14G8B2I8
	F7piU2S0sIpjhAQ8gFXxD2FkicnjA7tsA9P5jHBqysDfvJ+uBaocnrlMJhrtD19ZDTuG03D1eqt
	CXtEN83lJ+nX4KZkc6uegRdinNkxFy9ap4/G+jY71djrh+KrjyojqQIHGodvgo9arHaG5kSVk9l
	f2y3/BH7pJCw2F27WfezPQTIcfFuIp/YAKL1yxO3yHavIg2tH79v9hqxX03yXWARzUL6ng34zgA
	tJjuNfiqfb1DHgaQaNKl8JRUI0D/l2pTT6CTlWSLAF/K5T0N4cvypl2Ao2HeNVPHzz7bCrYbDP9
	OyX39PnVtN6FAku78agLmqEgYItgoWcvtiT4alJiag4pQjNGLguSI=
X-Received: by 2002:a05:6808:2211:b0:551:eea6:9397 with SMTP id 5614622812f47-5681463f7b5mr1400461b6e.59.1794172362919;
        Sun, 08 Nov 2026 13:12:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac62d0sm2795191b6e.2.2026.11.08.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:12:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:12:39 -0700
Subject: [PATCH] mtd: take a reference when opening an unpartitioned master
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
Message-Id: <20261108-submit-mtd-master-open-reference-v1-v1-1-871aac8c6e05@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1JljUVTQYu4Cuoin4EaKWkVhwqp6
 t1J6MKLN/Y8b0qQGKLuzaYSVhaeYwF9apSbTHyB2BdWXdv1Wrc3ko8NnClkT8FIRqJ5QaSEJxK
 iA62ajLbDtffO4zKoYlrKlr//L4/x4KJ5w+WqrhfWCMgmE91Uo2I/1zla+/4Dh3SPI6cAAAA=
X-Change-ID: 20261108-submit-mtd-master-open-reference-v1-a1b756dcde47
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

CONFIG_MTD_PARTITIONED_MASTER controls whether a master is registered
alongside its partitions. Without that option, an unpartitioned device
is still registered as a master and can be opened directly.

__get_mtd_device() skips the master while walking the parent chain and
only takes its reference when CONFIG_MTD_PARTITIONED_MASTER is enabled.
A direct open therefore leaves the registration reference as the sole
reference. Unregistering the device releases its device-model and NVMEM
state while the handle remains open.

Take and release the master reference for direct opens as well. Retain
the existing behavior for partition handles whose master is not
registered. Decide from the original handle before walking the parent
chain so get and put use the same condition.

Fixes: 264725e35fbc ("mtd: Clean refcounting with MTD_PARTITIONED_MASTER")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..444615804236 100644
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
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261108-submit-mtd-master-open-reference-v1-a1b756dcde47

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

