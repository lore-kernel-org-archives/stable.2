Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270362;
	b=czHlnymut/r4LEH+fITev7SJZn4+rcqgdMl2oh5g4zGGTZg7Nn2Tzpt3yHJ5SdfzVJDG
	 ljakm77SscaWXqYyy3kVa6Ev6HGAaMikuVanwwsAy4jzWZ71hWoTMk4ZuW4Wra+ba/Vs2
	 S4RGSKGTLIOpMC1VTSADGjyDHb1bl+xY3MXUN6E9+uofmqBCLfIo+/dgNpiqWxXfo1nzs
	 kYqw9lOqC6jkhholBR9zJ2oOCnKiJSmzfpLofRmmKCrExnNvajYnWp2IF9XWAEGkaeDTb
	 LKMCU39UNd5LiygkfzdY32uR31pqq3rvKztcF9xiXBIAqZpz9NKo2jeVtTnq8c0sM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
	b=qAuPY7bQoVyr3YnwJ+CGGhLicbcIRfpCSfFrLlm89c1sWusgGY1ZGtBVBl6ecOPfEygG
	 4O7tI8ujmqevcVubNqbd1fU6jDSMiMxidPpXkchXi4DI8TkoJKaA90PhIqWFiHWozhfyy
	 URSf8yiVW2imAJXEkMC5CHpoFBiH5KmGZyq/QJ5wha3horvD4OXsgZHqZ9Dp9wI5IbaW/
	 SxpA/prWV4ELD27G1SWT6x6M/Q7uJodPOKg1FQxM0yh8w3750KKT31EkXUeHWO4gSCa18
	 wfHm5ZLgL8qXDvHIdFqTBItQHMIj2dKTGfxEMA3VJkPhHQOPRhd/W/R9ccPM1qHUYyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9tPpbE8;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D360A2606
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1D360A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9tPpbE8
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso3015586a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270359; x=1793875159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
        b=S9tPpbE89Lm/k+3k2e9HX7agXeshT4lhkQeYTxyEBUYKwVwTo99E7QdhR3EgUBR8FT
         wj6TzLQgOamvN+A80ZS5eOteN9G+qeSO0dIahTked7qGOen3K+eam4bGFN6TBYk7CyZT
         yIgB+Y6DqQ+xsLZ+VLoKlZWR9RvYMSsAIWIWkZJ8BWeJYskXdsRBrp/OcGSu0EcC4nJP
         MrcS+NCEpVGzUJZjeoiiY/C41ZVXT02mcPacK3X0/vQigo43EgIFaTA9qc4+2tUQ6pcu
         ldcN4Yrxde4bH2VaAi4kehHWDojDJB9MkGDNJNjinA7/jOt1Ahr8fRRWO4jB84ai82ht
         GHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270359; x=1793875159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
        b=TIP9fHsyHMWoPPfPObUp4znLF3OfPHab3ZdWi3wW6ZtuBlwUqV+X/BrZHlGZUbTGjP
         ADE6mm5djG5gvxR/RF1SjeobRJh+6kA0TliGsxrAGpxjaMcgd71WIc/IB2pDIw2RQRie
         FACZ+8sZr9TxtaJmTXeHhGwPM5c/vPUyzJyOINQtKN0PgBAoIrIe5iZOOrPTeFhDmRRF
         1vFNKIwgJ37tlBBCzLuiSznbjOB1i0bahlQXfPXFaKaM9ZdqEm4ZMerjPXbahpgGqXd+
         LWH0PBtk4rsMakNPW5aAWVxNe+nqOLRWKQSaneVhFREShTyu1D/jl3pIGb3ogUWbsf90
         BW5g==
X-Forwarded-Encrypted: i=1; AKwUvByDL252udyC/eNKlIj6EeBeVOZLsDdkqJ4dkRQr+f9ojlwKAGCeh5+L2Bcoy4RNiWNG2HOIzgw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAftRhkPNsLMmxixHB5+Y1/1rAP+ZkBU2qHZ+vvgqcMipuKco7
	t31DjAy0pYg8EyglKdMSoJvVlW3ZaDWCi7i7AQLlWWjr1b7DB2Gzf8rGhmpDv0VA
X-Gm-Gg: AYBFou3W1ML55KVmUeFndLK6YmDUNSaBo3fmC81rISRQcE42SQdn4q3B9Qx5rlw4Bw/
	NCVuASpVmCVbSzeWaGvsEdRMTSc/GjbN98eq31dWbyuCdnMlCpRq262VFbkXcNg9hdyvC+xpwgv
	zXz1XYz5/sKwlnB5+XyItgBeRS8lGgfVngSb3PhIO78bKJNgvMQLUYqgfLGU2G7gOfazmcOAVE1
	uEASGBMG0hxBEJqkgasmmY43fnxNWm8w+TsU7cTK8ebgb8DDj5PtbcZgfE/6mpPXypfRB7/3fN8
	tDjkCtVQqcyVtpyjlJG9DVr72jz0CYR65X8kx9AFeiiUwdcHZopgr9GG3tkYF3vM7ulq0lKRH8R
	kq98G9PBetOKCS7rU9KweJwKju7hXIk6JR4+5WcxEpoM+oG1og8Fkae+fsfS1dO69KTiTBCFLZR
	ou5cJE+rj/WlIu8jtLdA5qjnQhciiaIwAWN/oY0DtD3kyG36aoejPNAgbnLSFkpEts8iHIEPv33
	4WAMAcIzReMk8h4lt/v2uX3PYLdHuvgE0LGmHKDi6JqrdBuAHWvY47WZxRmjF5qZmCADSzFEttC
	l8u4Y6yrxKZVVXHdfqizF0DbR1UfwH+6hFRaNx7nmXI3SFC4uABYMt0mYC82KYe++S78WzO0fE7
	dH2sLsoS2E0A6AP77YRaJKyW3Q7dBvQrfPA==
X-Received: by 2002:aa7:d0c5:0:b0:6b1:b611:a2af with SMTP id 4fb4d7f45d1cf-6b49cbe2658mr2513298a12.20.1793270359169;
        Thu, 29 Oct 2026 03:39:19 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b496435babsm2437817a12.28.2026.10.29.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 03/16] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Thu, 29 Oct 2026 11:39:07 +0100
Message-ID: <20261029103913.2785828-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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
 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index eee22581b14f1..92b3d08a02349 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -819,9 +819,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(inode);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 out:
 	ovl_end_write(c->dentry);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7d6f7f6022ebe..ba542a1920127 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1055,7 +1055,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(inode);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
2.55.0

