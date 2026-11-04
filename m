Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817965;
	b=CNAu0Iv6Xc/VsREAbJGTmjRH8jKyPCiBNDHidy4yMGz8kqKwClzmrA+eW9IL0jS6JQUf
	 JamWXdJNKwUzZy0UrBAexDk37xLBvhfgg3EMX5j2dDSWAkD/6K2fx+gycOlY8QroB1LdS
	 MuwJXTW7ta5PxuRa8SBQu/oVt4LkYHcORtAQ5munwjAailzy7gdGNiFRb/Ihl/r/0fjGQ
	 zluGltDnYvhjsTDLxnYlJC9ObH3sbfUMy+bxjTaJ6Tk1rS+idguB+PyAjyoI1ns26Xk03
	 +/uqQlbO5f8F8464jQ763o/iEFbHRrnQhZJMm9e2dRbFHAHvp1rMdrjj+8C2YmdzuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=38Qizys+jXdkmlwnr7b3/HVrcBj+lb1Na9/a8RmfPTs=;
	b=O/ZsN0ntXi2oODEtEm7o3R4kmsh0OqyqnRYxUByFwMynpxSqQUKFtuToIBK08abZD6kB
	 0m/3jjp2uI2thr5If66g4aFn8ThO0la7kSWXorxSSutMlbXwPnLVAZkV/dGwuvBEAM8Fr
	 tPJp5n+EAPuDd3CU+sYKQ5GQPdYMMI2VKrpfdu7dQl0EFqH2L6o/QILyvIEI1smt0wmm1
	 LIcmLxwR5+yaOgZx1A/gWtMv1N4SL7CnbGY6Qc5uaB6VEuIBtaHaUo4H9FjhdRaabI74d
	 jM/a1CARgT8aFWzkDT7ykPl34ElrhIA+XlQcf0a3plp6IFIGrqvfoMvbIqis3TLPKrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKuWKdv0;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E71606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E71606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKuWKdv0
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so9658275e9.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817964; x=1794422764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38Qizys+jXdkmlwnr7b3/HVrcBj+lb1Na9/a8RmfPTs=;
        b=EKuWKdv0bzUv04O6RZn2v1q9rQZ+7ENTfUyypFcqPGCy9/xggXi4QLOeu8aUvwrtkN
         Nqg6lh6RgAzWHc2B6F3XCr2hY5LcJyuSf3r2QoR9vmuUVMtlOSkazWsPFZpnrM3UWF1p
         Dv+rlGdqXk4ZK1coTJhLwVcuoZGnBL1rEPFyPGsafC2poMzJogX5Qg+WolLesruHExWd
         yp+JUvjwv7watN1afuDuE7fO7WzJAFfJ00zIho1Ln8XG53VYIAL37q019+ilmko63iKf
         b51EXup6Oyig3kzNMQ2WAXrfUFP1yQh5a2na+wBJnIdGMWG9Wp8KEr2zSDMGkjVi204+
         /TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817964; x=1794422764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=38Qizys+jXdkmlwnr7b3/HVrcBj+lb1Na9/a8RmfPTs=;
        b=pBnUpPLNfskZJsqGH5rPGhR0jOe9g4hxd7qadl1HJ88B3mualrzkxznHUAItUXewVG
         bCgJHFn2zcggTpEPXiA6cNdL8Kmh+7SFbj2HFis3O9iT/2CLj7/OjmkxeVO6OZa+akpF
         21GCENuX4ePr0SO7UZNNJdaxptB4QId10s5qAzMLv2pC+NaGru/jMOKequaEstemepbo
         JfhR3EdPT5wMyAGoXxPjpe280oBmnxjGrMGsZjWdkaZqroBWkYFZ37Zw0avix7NNK3jI
         14D9zW2OjdTl2NsRyC/RvAnvaq5ambtdNgkRG1xCCJNB6vTm0V0fMUlUBKIZi/XAbmgC
         Fvog==
X-Forwarded-Encrypted: i=1; AKwUvByLEoH43/2e3UpCUEjwbbOTKs9QQO7Mgib1lwufseykM5zVsApBHJCjVKeeAddukVEuLaqgeHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DWeQLdSYStvE916YlzMdktaHwCdYDOKXaw1tLOQ7F+p9G7fCU
	ORkGxkqljUJzNPcPUKS2GBrRc66H4iM/40yTHdcbO4MJHTlOlKxpCy1i
X-Gm-Gg: AYBFou0M7oz5+z1TsbzvSAiRFJ86/7sIQNjw7gyGG3aLwjhJn0r/tuGT/j0wbwOlonJ
	DK/9WtgUeosaukWMs721W0WE6x3HiuJzIH76Q3/ivbMlvqpyaS5PiRLUwOMwZrYRiUuMZIH6Cj/
	z0vgxyi7tBHqTO91qqKmt2bR46VvGIzZSCZ54HFmNtM+ouj4BehAHv0haCo1SHknzqi+KD/hAxF
	TzQH+SpHdyBmgtskZ0/8riMFrQ2ce//kc1wpYtR5S8prRZykktIJCP3z5BWN54fOLedvbTScV01
	gJWJ5mHnsGYbj+SA4Kwcwwfi395vnRIpAgFoeaGEMdf/5ZT5JvUUbFBALBUJBRKfOMeNGtNTQKc
	r/HC19Jh55+6kMituXydu+Shz5vXYZGGicf2sShx5eEMTdtiRFZbx1Nj0un8S8sTp7epd4frMps
	wNwK8RWjWHD/rp8sf6/5alR5hLG9QCc/vs3cTssLks1LF2nBqpG5nLmS4JD4NKeDpF3A9UEIqOc
	K167kPYkrUMO5S01NzLAwfsejyLT9lGTIhxzEjQH2vIfvJkePwo7dF6buhm/lbQ6xQz41MV30Sn
	AjYMM+xHvLuu6Ldl8P+YyhVMrGtHvzECIRCjuZEHn/RG0MN9rrPC9uIScHoqVR03tXo4pAP+aIs
	kP4twC4uWxLlr
X-Received: by 2002:a05:600c:3d8d:b0:4a2:cbe:beac with SMTP id 5b1f17b1804b1-4ac18a89393mr360447985e9.23.1793817963616;
        Wed, 04 Nov 2026 10:46:03 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fee968763sm5328119f8f.56.2026.11.04.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:46:02 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.6 2/2] ovl: use the pinned upper dir in ovl_fix_origin()
Date: Wed,  4 Nov 2026 19:45:59 +0100
Message-ID: <20261104184559.3630145-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104184559.3630145-1-amir73il@gmail.com>
References: <20261104184559.3630145-1-amir73il@gmail.com>
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

commit 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f upstream.

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
[ backport: context: ovl_fix_origin() calls ovl_set_origin() ]

 fs/overlayfs/namei.c     | 6 ++++--
 fs/overlayfs/overlayfs.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -883,8 +883,10 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		return err;
 
 	err = ovl_set_origin(ofs, lower, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure_dir(dentry->d_parent);
+	}
 
 	ovl_drop_write(dentry);
 	return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -492,6 +492,12 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
+
+static inline int ovl_set_impure_dir(struct dentry *dentry)
+{
+	return ovl_set_impure(dentry, ovl_dentry_upper(dentry));
+}
+
 bool ovl_inuse_trylock(struct dentry *dentry);
 void ovl_inuse_unlock(struct dentry *dentry);
 bool ovl_is_inuse(struct dentry *dentry);
-- 
backport
