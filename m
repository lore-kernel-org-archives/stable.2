Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA347D931
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254197; cv=none; b=XRY2ZyY8G7HtAA8VWoGlkfEO1iyVrXh+k+Xuru9pOBP4ldVFTem7v62WMNFJ8rlQGbXrttF7DZXeJDAcZ3I90/PM+ALpojo54GIsroTy8AVnZSKMkZS8ERgl4cG6khJErwyKi2YAfDlAalkWMrEJCuHr7MUlo9xxmZ/2i20jPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254197; c=relaxed/simple;
	bh=n/XsUE7Gx26s3D/sGXyNDOn7kihXXXhDcnFSXNoy74g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1pz34DlF38t8tPtdaijJ4yCBXCFImIPUrQTUpCf5YkDfqT1VAU2ojL949ZSybWN2CC793/YKQuZr1bGqP8Q+SYYHC4CCI+aCcCq1Q5D5hKBQuxJX2H6UgAQtcYnhzhDXJBSLV+jpTge80DJ/vn5sAbUfuEli6E47wh3gBq3J68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyEoiJ/6; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyEoiJ/6"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so2742177e87.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790254193; x=1790858993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2q/mdgPycUE8ql0R016J++ZYLmYbGYSCmSNkPnI+ws=;
        b=OyEoiJ/65HeH4ay99vQBX3uRPVofGDzw/iltdPvmoJzEL1BaEXXxa03hnGkJ1KMAGP
         dnTJF68RNAuTz4exPnme1M1aBjjXkeIE4MgO2O4n7ficJvL6FhnE7LATypQGWhpylk/z
         XGg3mxmVb0HXkOQMvqMJgeV66t4P2dRsGHrCHtC7cJHf+99i4x5569PTctljy6Fqt82j
         rz1/RDd5xSaDZYBna8jObh3JE95eU4bePmvDE1SecebIcDGCKPdvndzXNa9kbjkRykDW
         NXekA3gOiEtDux7ySxH7KblWTb2gOYJFF9t17FO1UrSYzkVi7chVnxGuPkKD3IEsIv2V
         skCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254193; x=1790858993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2q/mdgPycUE8ql0R016J++ZYLmYbGYSCmSNkPnI+ws=;
        b=XY3jRjfTiGPQS56QjeOMpgEhi6qJb7wdVg9YCZSOmnMgJSikPKCYp5BY1bMfR09LfD
         Y1+Dh9h+CT3rkrSP9TLBKgtdQ+U0jQUiWxo6hJUXdGzflRzUJ7Yw+uMv313libyKdD7L
         ee1PaU2nbkoGZpezxSZgdrHmtyxKu4l/8HBThqxO6ctRllYB3uAdmaOUbSYMfQpsYHkA
         yC8rhtPVRtZrVwOZtoTSMCh8LVnWRaXWkwL1ZGpTTek1yDijaLcHKpE3NzQT6yrI39Ig
         rfzAUuhrzckqaPmPLmbApCFaaELdzJSyNXrHC3+Bh+I6c4RSpdIwlr2F8T5wz6MrIhNy
         uBPA==
X-Gm-Message-State: AFuF++l9NdkThA76t35Xql6sl68qf4zfCjlNDmBedYthZPuDDQhOpnMs
	D8k8bvnW7Ai/ImTm57NDQN3H2Eyuck1TzsTmfvnoFfho0hn4XLag02bAwMfzGmbPA9ThQA==
X-Gm-Gg: AYBFou0r4yeEijUCREBdGE3R5cz1qvsBnDgXs0xyyaQ1JaOsTePP+FAFowoVt/64QDF
	RyX6LAfjxTCr3o2BDM6EeqmHmdVp1LTM9NtxV5Bx7ErAxMG7j/aAuNV4AR9gPtFNhC3geHuwQ2j
	N+I3hzTeUlaKwudJc1nZfyhRHkH4TkWTD7aJP4+9j6dVeHpvRLVv421F3HxIpa2R4AF4otkphd1
	p2UuOl31PZYtaRhATiT0jV3aPouSo6DSHTRkA/KjH28aJTO5XWvrnUnOCjgRJSY7W+Zl87OFuoC
	pCViypMjYbyYy3CQAIA2kDLkqwNXg+RDQC06jw2vxGzCiiGK7ETRkpFxaut4ZIEwGYUs9xRA77I
	vFooDhk/xTwWe1NIadr52AOGy+8d07Hsf5sUnQ2acXcSI7y7dlDejOgIOYqe1yEHkXFRY85XT3q
	xghHs6mJbGHbnlzupCwOu5BYqGPM+udidMoa2lEv1NVYwcHkjRF/rOcI7Xo6c3ZlX9zVr7dGPKF
	lRQBlQHS0yz5XI=
X-Received: by 2002:ac2:4e15:0:b0:5b8:9f19:7363 with SMTP id 2adb3069b0e04-5b8df07ab74mr906775e87.36.1790254193213;
        Thu, 24 Sep 2026 05:49:53 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d859568asm1406880e87.77.2026.09.24.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:49:52 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: stable@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	apparmor@lists.ubuntu.com,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [6.6.y] apparmor: pdb leaks, two fixes missing
Date: Thu, 24 Sep 2026 15:49:37 +0300
Message-ID: <20260924124939.276438-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please apply to 6.6.y:

1af5aa82c976 ("apparmor: free the allocated pdb objects")
8ead196be219 ("apparmor: Fix memory leak in unpack_profile()")

Both fix 98b824ff8984 ("apparmor: refcount the pdb"), which is in 6.6.
Neither fix is in 6.6.157 or queue-6.6. 6.1 predates the pdb refcount,
6.12 and later have both fixes.

Without them every policy load leaks the file pdb of each profile, and
every freed pdb leaks its own allocation, so memory grows with each
profile reload. kmemleak on 6.6.157 (Debian 13 userspace, 107 profiles):

  after boot:                76 objects from aa_alloc_pdb
  after 10x apparmor_parser -r /etc/apparmor.d/:  2258

With both commits cherry-picked (they apply cleanly, in this order):
0 and 0. KASAN, UBSAN and lockdep quiet on the same runs.
