Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197053;
	b=uh4mOr719w87fmb8PFYGYa0J8TmTCNPEzCTVePHeL54QiZ+M/Yp24lwms+QO+QaZjFXy
	 vvkJxpg1dYYhiU4XzX1y8lQ817uGDVBDsBJ/n5Wh4rHwXmkRtXoMRezayTsbIExiZCM3i
	 Vnuj+IkkYfMqM2eUe28uC8qPK5+SABYGnYE7Jv0Ut4zkprSoKsYradms++JRKsdzib0uW
	 gbPy1kFEdaTYF1VOM0gdCVCe0IpdFTEBXyvZUn4IcfiCTY5XIu3hUKVOC1VwI2lulolVx
	 pXdN1MK1jT3tCvcXOh2rtettBqOXoThx0o0efBSmlRx6nVOu0DHTv8N1zE+un3W83nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J6f7JSuYXknDVja0lBd4MS98hOKm2HMrf95+I/iqXAI=;
	b=sv8NIYr0B0AZ7tJnYJcPonb1fejRYDX3MRQE+gn+K580HMaWhBPPzhHM1B688E/XhQZ0
	 efDfosu2DrFKDBoY7yMtymJq1YuUUCUBFYLpdeS4wJrqfMC+MG/9cmwPEL6pTkiLP1U3E
	 ntlhBfIuslF+XnWhdeDmwOsyTvJ7E/amzivmiQKRZgR3hJg05B+DHWSZaOK54hkEELmAu
	 +nYPEmmxLgtbQMdWKZlKC4+/cVc76t0FuETjMdwNn+V7FmQe4G/TRxtv6YqBJSIIhdN1I
	 OcDivj4PvGvA4EqjA1NEEzbbjN/qqj35PlVKt0HKHaM1AJIWLvpNpRSwEhM1kgfEXlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xp27y3Qk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F4606A33B;
	Wed, 28 Oct 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xp27y3Qk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5999A1F031EE;
	Wed, 28 Oct 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197052;
	bh=J6f7JSuYXknDVja0lBd4MS98hOKm2HMrf95+I/iqXAI=;
	h=From:To:Cc:Subject:Date;
	b=Xp27y3Qk0/PcLRDFNJOilMflz/3QlpWLyj9/vbuUvfYRpFHjWc6PrYiqmDoRdMdKH
	 m+WGfcoGVYmZL4m8HawHgUSPWrrmeMDWWOMWy3X3PcXfNO6QZ4VaxebIZdvByTji0r
	 aeFDjWXZI5BllWJ7C1wBFtdDfhzNWXkxZGdArLp5+etlqxbfBtXxCyXY8sI6Hjt2mG
	 sfFOicrqrd2+N7MjWs7QzSh4U8Iwy9TCBf+U8QuItwC9OA2xc7IEka7Ssr7Zz+qL9d
	 jqYBhr2bnSnkb9N/DAbYOIjbIP7bvFv4Y73r5Z43z8XswxkbMMmSKiqPILclwVhy5s
	 XfJ8aUbb1iACg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Wed, 28 Oct 2026 07:17:20 -0700
Message-ID: <20261028141723.161776-1-sj@kernel.org>
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
- RFC: https://lore.kernel.org/20261028051104.154232-1-sj@kernel.org
- Drop RFC tag.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 2d552c13645b4174829d2e131c6f6483a5111b6f
-- 
2.47.3
