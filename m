Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C848642A
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890770; cv=none; b=ZdXPXyqkp71RmQeK0E1XN4MEgPvwwChaxoTUDE0RpmIPib5C2dti4rehu3RP8eGqQxxzMJZGOln7HSJ2s8GawzfYnW6g6/XeAK7TeaE+hj5B7H/RBC9FxZFQSmrPOZEqAvRHrtQk43r1Bxvj851lmXHayaei4NfW2Xwad94OKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890770; c=relaxed/simple;
	bh=gDKKtoRgOc2mwHpU67r3CAZFBnZ509JPuMOdDP4lW4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDicfFBc/1HNaFhMQLj8pZFKlOXxjkhoFKP6YrbqrUzD4lYVVoYeepX5Tih36pFGRjgAis8KsNQSRh0EtzTmj9YWsKj54AQ+b/lvhlAO+QeKPc7/gFIO3oWohTK8qhU59Gh28AJVzIXBiYXtSR1Liq0sa89FJ+gEq4ZVNGvYaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgmJkqJw; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgmJkqJw"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145047ad220so2406612c88.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790890768; x=1791495568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjoKekcwBJNkR4L4zqB/WIDVT2DDhiDC9WEOFL1a4lY=;
        b=jgmJkqJwIykmr8oaHDYAREDlheCOemdpErGkQMKNFY53bqpVHw1M7w53wuir83jFa6
         EIeBErp5KDX6fYiup3r9ry3AyOiF0chOUv4akgcWoUy+SCegt945fChJmdrptB9XZeho
         tm0HzBfvZoSKd4xuUJKVmbKRKTOvzHaNGDu4AUE7qhndSlHrCnhzgoT5PV7YZeei2amx
         JUoeDu17QCbk0SP1+NRAMIdHCTh8FqD/83OLiNlr+TLubIs7OGb4lfwpBEb/z1J9lB9t
         cKQIOePZZmRTFu2jE8/IEaWO9REUl0CUA3W+U0xtQKNCuM4IGby60kb2M1zzZrXjCGOJ
         2+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890768; x=1791495568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjoKekcwBJNkR4L4zqB/WIDVT2DDhiDC9WEOFL1a4lY=;
        b=ZHAihDLuHvfub+xWDVQLDW0efx95NaViXMBDTnGcyRZ5EqKE9zqM3EtfmiI2mm2t9F
         HGkHBMH0IAMSzJ7A058Y6mG3oPjTuq3bN3u+na56WXl4bCD8yoeN5/cjNVwgSLXZ8fAX
         Z7ubz1rpxSlo/eQ04my2bC9RBVUez779GEMXfEAUIY3iwRG8MZ+J2dA9jdvLRB/oHeqj
         NOxNwmdAQGMEe9iXmQhVLCoGIE50fK0ASGT4i+aGwXMfu/TntC9vCP8aAmneDKGnvoie
         M5R3XhgsEN12HU6Bm0yS/GLm35jxFdwxYkXxrV4MDTIrbkpyCHNZRzfAFJSB1EXZdRZw
         vP8g==
X-Forwarded-Encrypted: i=1; AKwUvBzySDazVFwMysm0HrR42Ro076qsknc/AnCDLPIgqybwo6UbnaUZEZGgz2LnYJP3NoVOzCQe9uc=@vger.kernel.org
X-Gm-Message-State: AFuF++nPidLsAw/0mKYQVOnNYPHcunjbhxNc7n2bZCxdi/r8LYxpoQNv
	h+ABZYyOEpA2tW5BvnISQVazhhPXiHYp0ytnBlFVjGgMF120ObE0n5au
X-Gm-Gg: AYBFou2hhN6ADAZJ/o+ZFN0QoGxFZomQ4PPyOhHdCWwsiPPp5GjGrQTfitym+CAzf9n
	AurbfUDJnmLVNStkLa+NwrpUyIBGKcHrLd8vSb32TdwSH5gja3b2oUTNNnARtKFyq8wDn7KHeCR
	vGt71/ZShCMf+ZerpuPpAh6D025na/sJfKaR0DlpvNbHwdx2GwCxIwE52VmKwNBPmneTkrtyAor
	SRokIoOyHJD04J7uDedIT3M+Sa1Te6GPK8AkkzRPMAomQjSI/EfQEawL88oSKh9AkyUlp8jWUTD
	20myOH+m2ibMXvMZi9GxZ+W1YrqK1/aWLKJQ78dahbjRGiQllUO4kRSheOkW4NQyVoLRatj860z
	pmbP+QJU/1igCvcN6xMEyWQ4PISrWt+GCFSWtPLXkfvRPPlP1fafxSXscII+IUameGa7ACD5CRD
	PeLhV6HCvjRcr7aKPfLzUfwEptwG0d8MFQ5ijS7LUSfYU7TluOfmmsy26fjvERqAClg1rZ+Zvan
	w==
X-Received: by 2002:a05:7022:f90a:b0:143:33de:978f with SMTP id a92af1059eb24-14f5d5b569emr444638c88.43.1790890768146;
        Thu, 01 Oct 2026 14:39:28 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:1620:60f3:83ff:8ca9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm951950eec.13.2026.10.01.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:39:27 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Subject: [PATCH] ecryptfs: validate auth tok payload size
Date: Thu,  1 Oct 2026 18:39:15 -0300
Message-ID: <20261001213915.1326602-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that a key payload is large enough to hold a struct
ecryptfs_auth_tok, and that the password token's
session_key_encryption_key_bytes fits within
session_key_encryption_key[], before the payload is dereferenced.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
 fs/ecryptfs/keystore.c        | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..4315c18ba1cd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
@@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..7f2dbc81fcbc 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -477,6 +477,13 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
 		rc = -EINVAL;
 		goto out;
 	}
+	if ((*auth_tok)->token_type == ECRYPTFS_PASSWORD
+	    && (*auth_tok)->token.password.session_key_encryption_key_bytes
+	       > ECRYPTFS_MAX_KEY_BYTES) {
+		printk(KERN_ERR "Invalid password auth_tok sKEK size\n");
+		rc = -EINVAL;
+		goto out;
+	}
 out:
 	return rc;
 }
-- 
2.51.0

