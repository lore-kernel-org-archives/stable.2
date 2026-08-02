Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619E2DCC1F;
	Sun,  2 Aug 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687657; cv=none; b=kq/du0nKFZrpQt0s6EBZBQ4z6wuq9Mra8qYe3z4srOk9yloi6LQX64buxB459FmiO7ZRp+gCGozVhaC4h0rNQoyQIyBbKqNEO5Z1epBTojTk2h/IZKOd7A1rH1/ZbJjAWVA2/0jx4SybwsloFF1CqSlsqs7a1eHCdUcJj2P1TJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687657; c=relaxed/simple;
	bh=Q0v6oBqJnprpCl+GF3KlPsvL0/dRSIqa6WHx4vAGg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J52F8nFOvAy7YelCLp/2EU7R8DWtS4heTLNYkzho7NbSLh8MMVxqpZma08cn8m3U/y4oEvtgMuXPITnOO6Qv1PEsEGT1yq2xQZNOK7sdrAq8VWulXGbsROTTUoxaRWxyi85IKWmfU/CTiPdXtovxQsLPJR/qFoV6Cne5qmLcB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG91hedU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG91hedU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E741A1F000E9;
	Sun,  2 Aug 2026 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785687656;
	bh=EeL7EexGcxVGO5VVZMxodiz3XY6WPJZIVBQfHZICIwc=;
	h=From:To:Cc:Subject:Date;
	b=bG91hedURWN2K+cf8RTj9098FPlOiDM3pFA4pF4o9OqjQSzKnJlqpUec9dClXUI7f
	 vz/pbyNwzPuxDMrXz6BWtN/Bt7H6T3z8TITa3iCpAIrzA/yGjfjxHzt4U/etzF+j82
	 8MfyAQ7GROCmZL4KUXISbFvR+4Me9ctLRpYkhRQ8Vvs9T/Nxn1ZgjjdhsOv652G3iI
	 y6gX3Yk1RiI2nzNm+hbakReUPqNT4DBj34Mozabv5WaTj676sIYbDOQJ9A14mCYbnk
	 AE/WG2rjb+Z3e1xgnHKQ0oEQFs02lPT51cmUV3MQfMrNdtnbr5M/2A+idcDFUt/X+J
	 N6JmLNZpHoTgA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/2] mm/damon: avoid division by zero from damos_quota_score()
Date: Sun,  2 Aug 2026 09:20:47 -0700
Message-ID: <20260802162050.89477-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SAMPLE_MTIER and DAMON_LRU_SORT allow the user to trigger division
by zero in damos_quota_score().  Avoid it by adding parameters
validation checks.

Changes from RFC
- RFC: https://lore.kernel.org/20260801211315.2456-1-sj@kernel.org
- Add a fix for DAMON_LRU_SORT.

SJ Park (2):
  samples/damon/mtier: error out for zero quota goal target values
  mm/damon/lru_sort: error out for >10000 active_mem_bp

 mm/damon/lru_sort.c   | 2 ++
 samples/damon/mtier.c | 3 +++
 2 files changed, 5 insertions(+)


base-commit: 51d61cb34d137b13957ce83455c1f596d39e8cfe
-- 
2.47.3
