Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172D3C456F;
	Sun,  2 Aug 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688004; cv=none; b=hWjIUl7SY2DQfQGmjq4zjjvHKCV2HN9SmwTXsopSlT4AfchtIgc39xtQX4GqP6fktoYSVgIBvKfW3xiWUdwWn+dwhPcLCsZOxEdXmXbqbz5SDO+svnC82rpY/6pwdJheyDj7H7hDgaWAxpVrAOPzL+EvO9rldwn0g9Xsc+btW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688004; c=relaxed/simple;
	bh=vtkwcz9sAeGBi+04ZC3OJfIwe/7uVSh2+/Pk5/qfBCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YucFJe+nyv/twFCw1TLPo3QOqsNAm7fkLtUl3mlUY7L3ef5ir3I697oG+5TpF416edNkM8ioYl7mp7dUV/UeSZHzV0z9UhkM7SS+tmCxHR7V0uN2/hndCMvWgz0ykx9Yy3HD8bD+C4k1agI1YNJpPCXIChVtUoRwte7UxMqXlNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdOII6RH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdOII6RH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A21F000E9;
	Sun,  2 Aug 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688002;
	bh=WiXFs5/zG+q5AEfCdPBDZKoOPM3GsSFg0ysudbMhxYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PdOII6RH9kC1nW2NlNxCkQzAaSrbwyfJm9hOsB7grL0tx9y+EU0jaKwlvWNa+mWAX
	 dk9Kf/QASWSmsRah/mGqksuXYUah1O2NAwhqWihGdMzlqRwwXOrE4to+DYCVROjI+j
	 YIo7I02SZJSR7pIGX152i4Zg7eF9tXwbyVR526HSZ5wmERG6lgz4hjB4vziS+2yo8i
	 KRBRNNGdeiqYN+IMWfWzqFE/ltGTztAM6BdWa+yqWdmkCp/vIvrrsUrd/8Y3nTWaWj
	 aMroU9gExuLwYBuneUKbcTAWg3s2L0EuIeSZhznFaGjctp8wrcTN6QeFwzBkykoDd4
	 HXu5Ytki+3VAg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
Date: Sun,  2 Aug 2026 09:26:28 -0700
Message-ID: <20260802162631.90304-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an extreme and unlikely situation, si_meminfo_node() might let the
caller show zero total ram.  That could cause a divide by zero in
damon_get_node_mem_bp().  Fix it by setting the totalram one byte in the
case.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3bdbf4fbf7147..e3f3ee75a3d33 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2816,10 +2816,16 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 	}
 
 	si_meminfo_node(&i, goal->nid);
-	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
+	if (!i.totalram)
+		return 10000;
+	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP) {
 		numerator = i.totalram - i.freeram;
-	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+	} else {
+		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+		if (i.totalram < i.freeram)
+			return 0;
 		numerator = i.freeram;
+	}
 	return mult_frac(numerator, 10000, i.totalram);
 }
 
-- 
2.47.3
