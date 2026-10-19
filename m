Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438433;
	b=Mh1nOTbReWXwRhbxNWkPzEwugApOMseINdUMt9DdfsL5dDbW7x5TjH5w2z5Fb4DJInu0
	 NsQAoi4+GMo0O0ESHh4jMIRgsZkkb5cBIkM8+ZGv7x4UeKA5Q6dn6h15YZ08pKqcTm1kI
	 OitEXVkMJapbBJhfyqjs24SsBmmUsrnFoLpcT1Ub4hN2N2HYlj85ybKncipn3fu+4gBti
	 PV+HLoKhcfU9Grnc3+/RrU2lN1Bs0bIdGQUothyVSAyfjF6oIxxqRrn+YdrvvFtyGbiGU
	 LWT3mQW1W5t0C01c+at/+JQws5nPKm1o3qxP06PgNS3iIMMccNfUG7t7yzzML8MfXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w4dX1JpC9mAcUr8L80SoNaK8rqXYkTomomo1LuY3oOI=;
	b=hOD64HCOV1RWzHBHPfkqb2Va6cmog+ccWim4JpfA0h/oqZYN2IIMkCnEwYDBK6oC1fn7
	 Rnya3g18oJuuidOXkmrRF9TxHaivj8z5Z83kVg2jwTnrAnRKuPW6XieN4Bvh54MIemYP1
	 OKBZV3YW0AagNLr5/wGcywJZ+09nCf4xSV0bx07xenbs/bw8pABytnN0/cMCK9tJYP0z+
	 9BiIBy226oy1ULTVusdrCmxpWmIKAva3qBMPVV/cb7t8EbiNsZl3Oao1UWh7RvRmz865J
	 PpzoDidQKQaZ2WQn+lDVL4FEhhmy53JkXRvuifL3ietsxcCIXaSkqDVJ9kLwiZVLEGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emmdxGEf;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F33606A328
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F33606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emmdxGEf
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48de72fc832so1881847f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792438431; x=1793043231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4dX1JpC9mAcUr8L80SoNaK8rqXYkTomomo1LuY3oOI=;
        b=emmdxGEf+H6lEdV9aSLGsbZdA9h6g5E0s0zjMsZw6fN8z/BfHvZb5i87mgf3LGtN1G
         KEazRFlI8+kzSEZIhzi93a3b5axfv4s8C8qePFhktToSwiyz+9O0NHa0KmoT2DOqpZgM
         tUDrWylI4mq+HPGDQu3EoVL9MKbocYT496uW28/gftlFIYKsUw3/M67h0IBaYvXEncTi
         HxP7+gSjXQDONzGJ/2GM9xYubqm+f5yb56fPO+LRHTibqWul1+H99njgKCgiKyx4Tiy+
         mggaAjUasfcNetrdu7ioiZEtTFnAiiamvN4fIrbpv1KaVkNqSW1oQ7xyP5Ap2bp/jOTA
         pm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438431; x=1793043231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4dX1JpC9mAcUr8L80SoNaK8rqXYkTomomo1LuY3oOI=;
        b=S8NS+cUsn1psIwZMWrSzsaEoUelvT1YEu4iH+wKVsynjote3hg4dyGcRaKYAhLonki
         weybOxa385rm291fmQB/RDOguQUz4z6yqfUIZe6lgSOvxlpQIn5XgeAxpG0wnl/PmDra
         iQhNopXE029wtGKsbTMeDQaZJeQL0GLsS1nHtRfyeM6qbxvo+83jcA3gQ+ssROGgHncA
         W+a6uZ3C/Z72B+l0D3XX0KkFdJKjOWAz/vCIlrY/xF6VDpeHgagg1dHSDAoNPziReOhk
         /0RrdLyOGsueMJGwbo1hG5iiAfLYzKbbvQBhkgmLR20j1GV7lBWTCEUY2jhtvDly+CN2
         Bo9A==
X-Forwarded-Encrypted: i=1; AKwUvBw8m1HYnN7NEZ5meFVROs630k2LHdIl1P94oMcx3e3pBgw/XdITjCRfZWzRRLWwmYRygaOB0lE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPgEAo3G8IdqqlBDbIhSUY4vcPiUeoOkCuEZ2K+zx/seror3Ct
	GXpM2mSESj8ilIibLeuBqmG9nSGsoqyDCbNfYl8vbhb+MABKv0URbjxdsor9
X-Gm-Gg: AYBFou3L3usUezuGb3yD+zUmxV+r1TL2F0nEV8/LzJ1jA0h156LyUOcvJYwMIVkIC3H
	3oyKlWFVds+EjOidWBcaJ4KKROkVfR/69BfvzFmaHDBrPkT7pcGZ9z/Dk28/Pzvfcw8o7eqMghv
	T2WnApdMl3sRpCrXsXX3Xwo3wpVlRXHNdcufDyvHcsPv0XqMmXtJbbQ3aeCTm/PzxIjhiO76ahB
	UMFEMyNVtOy7v60D6xWlT/t3WhUt8ZSZAfpGqRRiFlDJIQ65AF9vB+aR1J/o/w59tiAMdi+vFkG
	RAgq3Ar63Ki6AvKToI5J93qxbCGzV4tkU2cJoWMTzZvNooDefi9rImPXq7RegF9VEJjdnCW/Mf5
	3hi2FsmFXazCvmWqu3aFrR7Im4q0tvkEZKD74QWrSRoTBssb9V9G33BfmArjejoe93rKMmS7a89
	jv/LP/ECADVMfJ/s/eSTmPAJe+DupaSzx7V7Aqutc=
X-Received: by 2002:a05:600c:1c0e:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a1d7462e34mr199327485e9.0.1792438430846;
        Mon, 19 Oct 2026 12:33:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d81035csm904816f8f.15.2026.10.19.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:33:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] scsi: ppa: cancel delayed work before freeing on detach
Date: Mon, 19 Oct 2026 19:33:49 +0000
Message-ID: <20261019193349.1176493-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

ppa_detach() frees the ppa_struct without cancelling the pending
delayed work ppa_tq. If ppa_interrupt() is still scheduled or running
when the struct is freed, the work function accesses freed memory via
container_of().

Add cancel_delayed_work_sync() after scsi_remove_host() has drained
all in-flight commands and before the struct is freed. The cancel is
placed after host removal so that ppa_interrupt() can still poll
in-flight commands to completion during the drain, and no new commands
can be queued after scsi_remove_host() returns.

Fixes: c4028958b6eca ("WorkStruct: make allyesconfig")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Moved cancel_delayed_work_sync() after scsi_remove_host() so that
  ppa_interrupt() can still poll in-flight commands to completion during
  the host drain. In v1 the cancel was placed before list_del_init()
  which could stall scsi_remove_host() by killing the polling mechanism
  for in-flight commands.
 drivers/scsi/ppa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 8a4e910d5758f..d4fc8eedc29ce 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -1139,6 +1139,7 @@ static void ppa_detach(struct parport *pb)
 			list_del_init(&dev->list);
 			scsi_remove_host(dev->host);
 			scsi_host_put(dev->host);
+			cancel_delayed_work_sync(&dev->ppa_tq);
 			parport_unregister_device(dev->dev);
 			kfree(dev);
 			break;
-- 
2.47.3

