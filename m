Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB82466B4B;
	Tue, 14 Jul 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037688; cv=none; b=S6/JVYzy9nm2stqQZiPQx985lq6jfqEjpcYX8i32Zg/IWddSgeDDl215O6Tc3N2ee6D6tUwldQSs/yj/dCIE0TJQBnyw9MMRvNrdjShDDw8egX66jcHXvT6gXC2jEO/EPvoYIR9ymoMTHKPTtm7aaVMvdhAvSva2HnQ4Iah+his=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037688; c=relaxed/simple;
	bh=cwEe3GMj8wIH2cfCAEdSUb6Zz5PnDj3MlNBurC9ROJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0zGOYx6ojHqeIg0JiJYgWjjHrVkTA0wFuOJI8n/5LojHW6Tp0JR5KNDhPLjTNrANQXjV4vlC2+RSXeyWnOw1UOu59UI4x7SjhVeAC7CtYFXvQA3NjGqrMAbCCiXvXrW7KS3gjffrbLZH59k1Ia2PSI0mylkVBdGzFsDGOVBOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpXX+MXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpXX+MXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1C1F00A3A;
	Tue, 14 Jul 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037687;
	bh=S/jz9927dvpD5avqF3TGJEv1UpRwfeRrTrpzU9XDfBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RpXX+MXdKkQe71SzGUVmEz4k5XIIG0ZX3M3umvXkQ0LjXr9yBzoEptFInp71ay5Oy
	 87h1faAOXLoUVfhxjjaQxnFbPAjprhMRqqqbj2XC1KNz6kJAz//9BBc5xt7/wQJhRP
	 9oMpQTkGk8/oMIYz59RfEBzsBvcZ720SxhVnqvV7PaatzwR63v5xoJ8n4GG7w9PrQg
	 gviVPEDbq1QQo0emxb/k8duZhNQSEpZ3Jb8EuNdfQAHX8wunwWE5JVupUvN06MW6uG
	 wFOdYUFcZ5jwDGcnF4tcQR9Z9YiTWBMT1KMGfTA016d6lsaLn83XYU4iApGCthInsj
	 dsX8Fcky9J44A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Hu <husong@kylinos.cn>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] Docs/ABI/damon: fix typo in intervals_goal sysfs path
Date: Tue, 14 Jul 2026 07:01:13 -0700
Message-ID: <20260714140117.94147-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714140117.94147-1-sj@kernel.org>
References: <20260714140117.94147-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The ABI document spells the DAMON sysfs directory as "intrvals_goal"
(missing 'e') in four What: entries, but the kernel creates it as
"intervals_goal" (mm/damon/sysfs.c).  Following the documented path
therefore yields a non-existent directory.

Fixes: e2b23dc62369 ("Docs/ABI/damon: document intervals auto-tuning ABI")
Cc: stable@vger.kernel.org
Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 907a504fb64c5..a8269123b4231 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -112,7 +112,7 @@ Description:	Writing a value to this file sets the update interval of the
 		DAMON context in microseconds as the value.  Reading this file
 		returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/access_bp
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/access_bp
 Date:		Feb 2025
 Contact:	SJ Park <sj@kernel.org>
 Description:	Writing a value to this file sets the monitoring intervals
@@ -120,7 +120,7 @@ Description:	Writing a value to this file sets the monitoring intervals
 		the given time interval (aggrs in same directory), in bp
 		(1/10,000).  Reading this file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/aggrs
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/aggrs
 Date:		Feb 2025
 Contact:	SJ Park <sj@kernel.org>
 Description:	Writing a value to this file sets the time interval to achieve
@@ -128,14 +128,14 @@ Description:	Writing a value to this file sets the time interval to achieve
 		access events ratio (access_bp in same directory) within.
 		Reading this file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/min_sample_us
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/min_sample_us
 Date:		Feb 2025
 Contact:	SJ Park <sj@kernel.org>
 Description:	Writing a value to this file sets the minimum value of
 		auto-tuned sampling interval in microseconds.  Reading this
 		file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/max_sample_us
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/max_sample_us
 Date:		Feb 2025
 Contact:	SJ Park <sj@kernel.org>
 Description:	Writing a value to this file sets the maximum value of
-- 
2.47.3
