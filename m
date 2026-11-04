Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791420;
	b=1kIPc7osmrLK2o30EdnrTYUXfHyodfIYTPi0bTVVQb0tvA+c8uqkbRnjpChS2Pipullj
	 CRm1+sT+tMEh/daQmrT1nZjUXJUBQblupD9BAVroyokQiYX0GIRwf3vbf6AaS2o44y0Ho
	 eFvV29NqSBbNdpV1CrXdZryBtiw6mObQysgFu5fF5GiojRR9l8qJw6KRch1rB29lIaqn9
	 PT78Oj44BcPyiMCL155DHeyKrqst56qISAlzPFjexFrIaRlDV4K5u4S6UOZwumKjWRvJc
	 A3CQItMbTt970tQsQcH5wf+aF5LGem/gAUoHVv+0yPojI92HxcLpix7+93BMOTBPm3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
	b=mKOmcZ9XinZbtVR6UQg9axmbmVFeTyqcivYLUasclir9+HX+YY7oC1uujh8Uhmnofzl2
	 jCE63jpK8YPVk0nRoI6qBbe215yipA/BMrJ3ZEyjzcdUGlmjskSqLM2I0El0pIhHlqamD
	 M3r9shiVwrJUE2IbwAaqFRVI/03Zs5Xy0IM28PRHeQiQWKe/MU/NUNGzGr0oE6VBvl0s2
	 oBOYyWAzq4N26DPw50Vi4QrZt2KJe0tx7YWOucod9kI6nvlv2J7rOCusPAFGU0tEHT+zl
	 Sb+TlOGAWdf0SWb1sDN7RNzBTzYUcg0/ZWlRms0YYk62CsG5Pj4X5q9C2IN6hkE2c9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfGwjTFd;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDA606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FDA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfGwjTFd
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so348399eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793791418; x=1794396218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
        b=UfGwjTFdJc2f/tcsb4Xgjtx0MV4UR/nA4OIZHI2G3C7kk7WlTFFZhYr0DCwmCwQQOc
         706kQH149rwZCeRGAVCHn55ORHE1Q6CtmH8Ub7X8OPGaHouQWSo7lmgLLrVg/kta3E69
         CLf4YQSjmZXrXWCRKQuISr2JAit5Vuc6QH8RZejYUtcvPUuyNKOYjEYu6lk6IlORlnzx
         6uRjCa8OOV8yJWpXX7Lcl5Y2Rs44pl34byuPTJCZhw2wyuRoquqjud3iFYc0vbXu41ZZ
         eTSNMGDiwthZ/0TRpH8uZeBS18LekhySohteGd9guS4hlj7o5bBfgDLjsYWmg/PpW12o
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791418; x=1794396218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
        b=FhElmQ1pq5uQE/EOyIG7cEdpQncjp2bO53SCLAOpLOzNA7tFxccjzu5jM9liDqrG1Q
         FSr2Cvorqe+zFqcFRm9g9Pmj5VXIylAOTw/+uh2evZvgGOz67SId59NANE0t/+7tqDe9
         3R5aYZXfC5GzexAUEXbxj6lKo/YPWBU96kaRWcMb4N7GNEmTFDfFGxPHUNfE6WPdhus/
         NKvXN8QmHAr3O/mmi7o+uE/NVAGDx9+3AXcFie6MwJlo2knNWrbJEjcEW6y1g2SyN7FJ
         Lv5MiJE4o21guF138CREmgTtafkdI67YYNoyswcx3hby31fSZTmLp+NZbvxTTzNVj1Ax
         WMAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLALlad56K5UMRK0mlzJH8At9TFT/CFjsqzkieLy0B4TXOf/8rIGrjDngZ1KFV7ZEkWk7IjGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DldW28a0HXDIaq5t6l2yhCILOAf4qpYhITtFFffjORiewrLfB
	l7iq16wjdhZ1jt+2ad0mtEsRlme8pN3/Ryf2HgDx/8WD5Wq+q3aRBk9Y
X-Gm-Gg: AYBFou3RV8VLlkvOOg1QwOdR7pPFCbKvg2LAlNvjfMBBHXb7cH9cQKDJWNxDlzGz1t3
	3KYG5TSgorXxin4hXuHrz3F0XUB1UYnHaH0i4k6ddrJ3y48TH6uANfPguw+eXgRqubi9dccg6rD
	h9iHr/4VSiw0OJl9E+jDDswE33rmPB/kZcZRj0SHI0hhdz1knrYpn+ULYKh3w1iMSz7sTmhA9hd
	OQqmUDQZzpZtMK1cGDxprsgnzoT97JYRP+5rSsFQfLxUpamia/HYEhcm8X+2kv0SDCWc8tUBNMM
	F1OItynqErNY1LxhQGmyD7OlF4G9bk4Z1HD6KzsS8SLCkDRwMXdMShJDmeEjbkWMzHu0oxH5MFo
	ERvgrli3dEGrzyneBfiA6VOT3L9ETC0dauwotXhXy+H6tAqME4DVEFU4l1cycRT+TDigvYThQOW
	u3BVMojLf64Xb4J0keN+D7hlQyhJS7sd/XluTHpKPeTpf72+0PSJp8MaTTbdnKdDTjLqk15VcZf
	aRqnJeyIuUAk2LfyOQg+0hQI79jn+bi190dMgQ/Az22bJS9zsQMPk7ysgXAFD6ApEpvGB5E2B9C
	DY8F6zNMmTe/qWXbRNvlO6BHcmNy6o2kYgbIQGD19cBy881KGKnQKY1lH+Lei5Ze1QfGP/FIQFg
	PBwGopxCWxz/jL0wbxAPQ9Tt3QneAxJPgG5SXww==
X-Received: by 2002:a05:693c:88c9:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-36a42444bf2mr25229379eec.19.1793791418192;
        Wed, 04 Nov 2026 03:23:38 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm6285277eec.29.2026.11.04.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:23:37 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: me@bobcopeland.com
Cc: akpm@linux-foundation.org,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] omfs: reject writes starting beyond EOF
Date: Wed,  4 Nov 2026 11:20:52 +0000
Message-ID: <20261104112052.5604-1-dennylin0707@gmail.com>
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

OMFS does not initialize gaps between EOF and a buffered write. When the
requested block lies beyond the allocated extents, omfs_get_block() grows
the last extent and maps the write to the newly allocated block without
accounting for the skipped logical blocks.

A one-byte pwrite() at offset 8192 into an empty file returns success, as
does fsync(), but after remounting the byte is at offset 0 and offset 8192
reads as zero.

Reject writes starting beyond i_size before block_write_begin() can
allocate or map buffers. Overwrites, appends and writes crossing EOF
remain allowed. Gap initialization can be implemented separately.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/omfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 79a413f1dc0..82c15756671 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -317,6 +317,10 @@ static int omfs_write_begin(const struct kiocb *iocb,
 {
 	int ret;
 
+	/* Initializing a gap between EOF and the write is not supported. */
+	if (pos > i_size_read(mapping->host))
+		return -EOPNOTSUPP;
+
 	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
 	if (unlikely(ret))
 		omfs_write_failed(mapping, pos + len);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

