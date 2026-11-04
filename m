Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792742;
	b=B9B6bs0eivYp3CyHDOPRm0Ka9GJf7I4eWxXTn3Sl95CUEzS/8OJmwQkjTTwAXi5KnVhG
	 PV63wpjIWa+v613GLWV4k5GIB7cotVC9p7yvO2T3IRbdtnrbkFW6UWVLNRGQ1RLfKIAv1
	 Qj3hKE1wqoVPSCp20RaU5cpMXGOYxWSY5jKd/GbxwQXDsLyEC3HJar2DhzkI2IrSb/1c5
	 Bnowjdg8TbiPMUCoFnVm186iqYz19Pwdrom/dBrem+8f2FZ4sU4PkR7AIAF3VIMmmHeN/
	 RrQuMMYPel5ygsVC83EclhOxMV7EtCPW1Fs2o2HwQwmN6k2xt+/piYTySNHwQQeN0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
	b=MYGbLqpX+KxyzxlYT5mVUSgO/s3GOA9LC3u2BG9UcvxH5VpwOxXvh24jX0LYvGQIAb7K
	 railcqpHGWGZnbaNEj8iuC6MVlnGJlu5olQU9zP79Wg5n3zqOgYx4qdmETi4L8KQnl0jC
	 viD8OhkZb1/BtcfLsZMNfmbRoKJy42m2oCEAmhpAPOV5YNWFCuA9sxEvUIYWSKNL4xXof
	 DnB+VR+I1dD/VXKKkt9LP3tBctWpD6TOTyecMrzRKmDSeDb8B2kQOUr33tBOspKZV2d+h
	 z/dDpb0YKdbFgmGihEoXqriArt7dfIPXdc/8f61unpunEW30AEAlWVjm6dw6g78+wNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tBpCPDuY;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27E606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD27E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tBpCPDuY
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d73027aedso112684eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793792741; x=1794397541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
        b=tBpCPDuYI/hM4RRuv/X9ivjp8uwRT0bT1oHFC+ZhGKs/BVl+YqfWsv/kGE4+2ifIVK
         URPFAItPo0HPtC0jkatlNWamLzuDPrhdoq+Ient9NJI/oN1a9q+Htup90DzK7h6LLTNu
         /0fScZyZnGv1BXIWpbgyEyLjbwJMPdSpYf88Ryn550n+TOOhZjLjiFy9lAd7ZstHDT3z
         ckVpYYLM0iwMsh6VCLsUGP2sW6VtLt46PAixIR5zVP8pWGAdP/dmQ5/UTtiSk+FSMsFT
         LJOBjBl0SDy2AUzvAPl9N3eT+lFN172sgoZ3V/EEFh1we/OFrXiKi3Mn2SxINm1j/itC
         LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792741; x=1794397541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PycSAvgSc9xONqJbh7SrA9DU1TbX+LtklIzj5asGTnI=;
        b=wP5Uq7U+BVa9GX+loOHemLMVS2dDZiiaO4k41j/XspKdXItoO0Dtd0gLRSvJdpKpsw
         TRSQZ8WlgeWbtiMyzfk4DhUrRPw3dLgToT4m0On6KXjApIAwsX3+qfAB9cxWcJnEfN/0
         VWKegOjBeGeCuBu5MpWAf/g9cQ/6xVbOvSAqqhVR3cVWvPB5W+GC08JnvBuZAOlNCrav
         1tnTsGiyRJN1SjYNhTubNHfv20lXCpAEoptvoqUDMpo7xhQuOyFTouiz+mQ+/BP9YXC5
         e3dVMpvIQwsp15eR7uWGoSopma6m8X56+0+W20gQwZWITvZHwSGae8NSiYgPq1FKOaq2
         Ce6g==
X-Forwarded-Encrypted: i=1; AKwUvBw4IQ2ZkiAGobV376ZKv8SCOGwEC3SWvifch5gYGUB+wvmueEBPitvtwflj+ZbFVEpY4pxrziY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dJGoRAwic5pZUxK8OhrDXBdZ0QUuY9lBhg+xM25mBrSWsl1Oe
	GtunyetYyCHhmV+mSsep4VVTSyzwbvFA7ugOvfX6nrWgN02hFKrw7bSk
X-Gm-Gg: AYBFou0yBcXHEyFjVtlwiO8P3JYJXIQa9OkxIjHgA1FxmSkXIXHST9lm/CUUumY43+F
	DD7fZfaIhS3InLZ7+bmSiamVi3hYd6Y0jqgs+QMwzpklDPIZnAI4prd5CmZ0fEMAnYuCoRt9HKX
	ew1v4UwHktxoACYQjvaBGH4ZSXZleHrairhL6uhubj0kynjbYJW8nR3Qk9uhk6bvtedLyCA5gKQ
	p9oHKuyeLMKVsmqiO6nsjukTIjpqZQinz6YgCFZ+KraiKbFLkFyV5ydqr8GwBJrwNkAvpKG7XmX
	JlKpJlGF25PVrlE5vRq+iZxsir7NJ7jUL4V107VFzmzj5fdyjpZ7f/tTVpyTFEzfCv3OkvR69PJ
	EVA6xsskxyxf819BzzY/2hs7RSylDFYGRLAlWhT0nA0sZr+RL1jQwQtOdZfB/Li6Mk+CQ4u9uGD
	qqa5vyiKAlqDHizmSNhxxr0qOFK8ZvfAsMtsknwGLRZuqkbSQ8tFm6noYDOXro7OONl6PFkHQsM
	J4GWXaiHHQDHZ9e3W/HBNjG7y2l2Ag9WvD5uq/lXzOd0J5PYJZikujPrAAxd0jqBLuKosnVnF/Q
	5YAyAVsjurWYPThMBAs0zfOVkbzs41y/HG/f9ZFP90328Odgdp2W4NbgSh6qvHz3cmzT9N9Prjk
	+CtgyQ/nEXAT+biAGgg3Ud3m2KJ+X3mqB+kFNaKiJLvMdK3bhER5IlMRzgSc=
X-Received: by 2002:a05:7022:1706:b0:1ac:7044:2bad with SMTP id a92af1059eb24-1ac70442d69mr20667069c88.36.1793792740829;
        Wed, 04 Nov 2026 03:45:40 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm7467199c88.9.2026.11.04.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:45:40 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] omfs: reject unsupported nonzero size changes
Date: Wed,  4 Nov 2026 11:45:30 +0000
Message-ID: <20261104114530.30536-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

omfs_shrink_inode() only implements truncation to zero and returns -EIO
for a nonzero i_size. However, omfs_setattr() updates i_size and the page
cache before calling omfs_truncate(), which discards that error.

As a result, ftruncate() on an empty file to 16384 bytes succeeds, but
reading the extended file fails with EIO. Shrinking to a nonzero size
also leaves the old extents in place, so a later extension can expose
data that should have been discarded.

Reject size changes with a nonzero target before changing i_size or the
page cache. Keep truncation to zero and requests that leave the size
unchanged working.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/omfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 79a413f1dc0..a4bf45d73bc 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -353,6 +353,9 @@ static int omfs_setattr(const struct mnt_idmap *idmap,
 		error = inode_newsize_ok(inode, attr->ia_size);
 		if (error)
 			return error;
+		/* Only truncation to zero is implemented. */
+		if (attr->ia_size)
+			return -EOPNOTSUPP;
 		truncate_setsize(inode, attr->ia_size);
 		omfs_truncate(inode);
 	}

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

