Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4E38E8A1;
	Sat, 10 Oct 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613856; cv=none; b=NjtdubDHIUs/gtC81GDJQvoNA6cdQ+UxJK0piDgLAFGCD+QD8zKebOJyY4SlKubpM5nstd+veMS++ZhVYX/GHD2O5LH3ZkpEW+Z/M1jPYFjU/Z7z+g61eU4t1EMeTJkJbBrPh8kc0lVGOl20FV9P/XiOhV295Geb4jHsKG8t8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613856; c=relaxed/simple;
	bh=u744gPTMCv7dcMTRBvlKNawRjRGB6cQ/1dFegBMHAfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwK47Iv/EcYuAojWfDjCAfRD8vTrUadNRK9e3/aiibhzCD+Vg7myxUsGySjp/D93CPqbVAf1OOIF+jARdClcEsQZ/lfWBBIoCkyqGyOuR7NZLB5g5ly5aS2Kjj9LRFTsmmy3CoFj/WjxTDoioEfM+6SEasBKmwQl5TMI7hSVgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT8X3uUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT8X3uUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206E21F00898;
	Sat, 10 Oct 2026 06:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791613855;
	bh=G+mnsObY+ioZmPoMABN3HuXQwcmD+MN4Nhlncu6gDdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cT8X3uUG+O/AAISctcKYT+XiBYOHEh0aBwFB5XcnfWtUXj7jhxVhm8Xw6+CkjkQKm
	 2PWP2E8GpWHYYU60cciMrBVGyL/GMRvJk57TQdTe6CZ1Qiceaq1qEI2+tDqRwdG8rg
	 oF6hdOEibO8WuBk1LiB7LwqzZYB7F8p/Z0XqY7bI/yLP3JsjoKiwStSeJOYWMBQrkp
	 +IdIVe2/KxrRwGpbIjef/2KTPF8hlgjl8gXgKMIKWrCUkfMnfLn5c3kcF4eM7o6d2X
	 56xHf+DWvL32a8/ejK4Pb2f+QL3UPdNBNL7izY/4p43bkYfd4AUjY1SxO3XHiHXwFI
	 uJsYnRmEmNL7Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>
Subject: [PATCH 6.1.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Fri,  9 Oct 2026 23:30:40 -0700
Message-ID: <20261010063042.8611-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092949-surpass-thimble-02a8@gregkh>
References: <2026092949-surpass-thimble-02a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
out-of-bounds memory access bug that was found by Sashiko.  Patch 2
fixes a bug that categorized to be backported to stable@.

Changes from v2
- v2: https://lore.kernel.org/20261009144808.18317-1-sj@kernel.org
- Drop the safe region traversal workaround in patch 1.
Changes from v1
- v1: https://lore.kernel.org/20260930094853.52736-1-sj@kernel.org
- Fix out-of-bounds memory access bug by adding patch 1.

Liew Rui Yan (1):
  mm/damon/core: fix unconditionally skip last region

SeongJae Park (1):
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)


base-commit: 5f9615e6a3b5f768df8b69ab622454fcb3af0a34
-- 
2.47.3
