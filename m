Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818299;
	b=01t99/LMdOZHbwdCsIHUBD0sr+ShCsQcv0evT0OB/AI6BbeZfQZn3NMA0MlZ0ZfCtUI0
	 9lkEc0fhx4pqyasuh/Va/yFbOuol1cHOPF1NSoWYEjukGV/I0Ne7MgdHgW65FM9G4vqb4
	 5SghngVUCkxYX9zZ5lxDC2hLhLUTiWuRIpBpRidA1zK/Jsqb7Us3sLSOzq2zyu2Kt7xGM
	 HBLED10Su8pgQrsVbrsDNU9C5rOlI1HUz7tjVoV5SGO0DpGM8/T7oioQiP8aIYinM0zC0
	 3tLmgImT3CgBzwGlNejovY3uus5jODMNwFeZ/I+QM+Ofj3aOnw8luNJrsVy9SmC3lqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OZrD6W/cpe/3NMm1KlSdEpezLvbv7UoEEElV31ZkAFk=;
	b=GLKCLGqyBCo4vghAVMC0bgc0zV+0XJIFNbnDJ23RC09SpGm7FKGq6rz4b0ba/EDF2usS
	 /qWU4/zBOssizfwx9DvE/+nVtFH4z63yHPPwd6CIQ1C864rwqbf2kRC+7DsrhzB0l07Da
	 c8twm4wDmkCKt1w49KUbaS2BxR4AC2wZjlusHpMQ8qYztvurYWlOQCUyAEZAQa6aKoHFo
	 lRW6Xen/7p077Y0TUwHYv9L13tKy6cRQwuAaa0z5RcZ1yhDfjiF1U8hjpe3IKkXO2wKXt
	 kg2vn6nXZ2BZ5I5RbypzLTWNUV0q6u4tzfvtZeVFjPu2+91s4v/aY8Ua02fHE6em7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=an13JAXF;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD62606D811
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD62606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=an13JAXF
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so8973595e9.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818298; x=1794423098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZrD6W/cpe/3NMm1KlSdEpezLvbv7UoEEElV31ZkAFk=;
        b=an13JAXFqWXgby22kGqHnVxHA2OiZZ52LePA5VrOH3duaVkGwtdNJlyHsDg2pZNlNt
         EP07ECnDWiPhaQD1a/r48VfztR3g6fKqnNJ0wCiRHs/ZFGeKl67CTWWAUAMvsVIf+GX+
         SKQDg+2l6EhvqVA2R5fZMgiV7REwndXOL9tmMJzMAZS3ipjjOgpd4fdK77C1ZJP1f4MN
         Ir86LE4N19gML1UX2IrS5dUlmu87j7yt6Lo99s3ZeM/RCufI+xS2y7wUiFL+glBpHbmY
         +qY/Qd/H1jaM4vDUUH1jAL4R51xi2Mulu8w93bHh7MKmQ4yjI1e6eNY4XsLLJWtihFbV
         8vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818298; x=1794423098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZrD6W/cpe/3NMm1KlSdEpezLvbv7UoEEElV31ZkAFk=;
        b=dadxg9By+LpW3hPqG4lIKEcjAilmZ5cOCfLeq4MejpU+1oXEgAD6YEihcdWFVrrbfJ
         HtL6lg/dOu7rJDpeJoum09V7tvZ32BezgKsvR9OPryruzEP8KGHvlmDoWbvQuDXoIVnc
         oVXhSCrSnLbsl/tjTUR2DekRZ19TCbxWljl//RRTpcOKkIHAJOnCD6Ym6wxPwrbwqXI0
         T4E2tcyPyftGbSsEV2F8LQh+b8UYnj+pJfdkTsTUgqD2wu7/rLsEnqt7IK9Z5lEsmjXz
         2pFJew52wn5KPTrOzA44UUx5CcXHZB3bHVqHgLlxrSACssMRRcgWuacMWqKUgm1eJuUU
         shFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrZtSvDwTqQbl2K7HlDgmKHz1VElYP2/GzHMze1+MwnOaQR+434m8ejmvp08exvfTj/zr2vZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z967AGAxIlTxNAqEAz1EnT0Lm0EO2np5M6MGQMjrGgroTnIcKYW
	sEatk52K3vsV/9P+Vp9FerGmCVy5REGEEPyVqdFkugPYvFP9rHglh6tB
X-Gm-Gg: AYBFou1avRQ51MK0i4haEJxdlQJcPKnuyFrvRNSlby0g/Dn0nY5cXQtUgNN5D/Yb0XL
	35IDK6suFZYExI4S6TkBVzscNS4xSWcf8dDmMW8J1HwxkMfXcxR9QVgsIrXTT00aELdk1BKhwkL
	V5YA9jbVADEUgyP50gF6/emU5Wqfbh9cBjR3DWf6sZIsm+CSWxONIeW/BH7EzzlxI/MvFhPE0gj
	hgzj0yK6ZO9iMUkJaj+AxsgQ+t+yJLGWXBWyzaNM9frWy7XnYKIihqgz46UbIK3z44od8nkL6n9
	mDEPLU5th39HCtBgjvUpQcA7w6eeOxX6Y89kakJtOEkEefTPsG/V/aPWI3T5d5PzD0mPQhYmJt3
	N2q65y/9Te0opy/GP9AiEMPmkjtaVC/jbpnuaL7zQ5CbssuE5f6la4E2xcGajU7NbjjWsZW2Vi0
	Uf7awB4Fj4BTd11zAo612/7yIGOZ1z4mSzcLAhTLNqqBwVl2OkiCYJnF1UbUs/nVCQYcu+iGiKD
	3t6tUl1cMtBPrsIMrv2R3V0wG1EkS8wXwyV/bRk8kGzQCRXyBI/Mf7mnAGjOWGmZbwj9RH3eQXe
	LX3Wi6+bqPjsb0FdShmKGncUWNG/ofBdotIdbvYrG8ySsts8d9Vf0dhye25LfUjKLupknymwGiF
	ZrgLenDODA8s=
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr388077125e9.18.1793818297737;
        Wed, 04 Nov 2026 10:51:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4104d600fsm71954645e9.0.2026.11.04.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:51:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.6] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Wed,  4 Nov 2026 19:51:33 +0100
Message-ID: <20261104185133.3630642-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104185133.3630642-1-amir73il@gmail.com>
References: <20261104185133.3630642-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

commit cbec8610ec5aaf35df50094ff639febc23f20773 upstream.

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
[ backport: context: the store is followed by the unlock: label ]

 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -774,8 +774,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(inode);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -947,7 +947,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(inode);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
backport
