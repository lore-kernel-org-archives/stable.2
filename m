Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196878;
	b=FL/uqCQ0BxX9zTosD8LU4gl77xtqo28onQff/6/jOQ1VuN6+m1iLQKMe7zJpTa+KB3Jd
	 cl43oOt0Pr2xyZhRxuD1tL4pRUrjj9hXpiJgpLuvzk0nNItB+g4HK91pD8HiQIwxupbs4
	 tr+SI2M3Z5rOz57pmJ5s3i6YPyl6n6lK7fGSv5ntDcjeBSer20FWpuoWBfpgYACesai24
	 ydzrNUuN7m9eSUR58nPzd41X0Oe6zA8yjUiIcthcvLExI5On1WVabaqOCzPEiNJeNlcXk
	 5BNRgKjla0Kvh8ADEGrT/lKG8QjVgJ/aQ97vy5aKhv51eX1oReqeSQpNuEFX8hFcE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dcLt9dyzwjAnym8V24jziGssbE22lwtpvcDh5iVGI4s=;
	b=2c6xHY3UVr8BCWYTodx7Zzb0peRyCYYHxTTVcPGV6ho/kbGyIRoGSi9TS9pFzUX/2FVb
	 St75APnkIYjdgDLmxdrk7DYOoo2hkK1/c7J2mtbUbxQMs+uO/6aT29pgLtY5PZkQDHZn+
	 gzdOhoZ2PcB36FcKz/mzQVXSRigm9bf6eWTeAgf6CE/UB776r063O92sCNVBBFkxE4Bvz
	 rd5p05PalcBKrxLmJY/cPHCZJl+Ooy7kbZlIjX8GUDGR8j4UDcD9UePx6GbuLHGXmdjRV
	 yl5CP+uMYSqFS0gHNhFwyFZ3517BCMn0U2og3FyJG6avqFrG6U8jVASTVZ1qcEssVKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/8uDbQC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DF606A31F;
	Wed, 28 Oct 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/8uDbQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26B01F01825;
	Wed, 28 Oct 2026 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196878;
	bh=dcLt9dyzwjAnym8V24jziGssbE22lwtpvcDh5iVGI4s=;
	h=From:To:Cc:Subject:Date;
	b=E/8uDbQCjA7y8LJJBJHSLyBMSNFEaxjqo2hQNv37R3TQwDGE38lfwf9/ACcypC0jj
	 s9wPJJisFGfZf4otFZUnHJw3qsPEXALmFsv6HWy74yD2dlBIupoFi5jhynMaphokcu
	 8XB81Yf6OIAh8mVWC1zZ1eJPfFb60eqKlfRCK2P4yohnA/9t64dCOxD8sAxoEmRJMc
	 W3wnE52M2JR/jCHBittrGc45mG1GSuwURqLILSGqGfM7W7Jazh5xKCJX5S+xXpDhOb
	 Qcmb5DlMqEuturIl5kG7giJSjg0stSdpdJyWV80ARB9yRaK8v7ZVZDAV+i9WjbiEbf
	 8qxvi/osMdzwA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Wed, 28 Oct 2026 07:14:27 -0700
Message-ID: <20261028141430.161175-1-sj@kernel.org>
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

DAMON sysfs interface can leak pids due to wrong error handlings.  The
issue in the mainline has been fixed with code refactoring.  The
refactoring is done with commits including 7114bc5e01cf ("mm/damon/core:
add cleanup_target() ops callback").   Porting all the refactoring
changes to old stable kernels will be challenging.  Hence submitting
this non-mainline hotfix series.

Changes from RFC
- RFC: https://lore.kernel.org/20261028045902.148624-1-sj@kernel.org
- Drop RFC tag.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: e242a25af30b4e817ad5b8ecb336201e386a87ea
-- 
2.47.3
