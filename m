Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB83019A9;
	Wed,  9 Sep 2026 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924132; cv=none; b=Qge7B/O5gABPJXSbt7QlLzpHppwF4OrVIfZLRUSoGcdFrhx1t7Z+XL2aDpj6rLwp/CkRsMSeh3H3bBdYEvqIp9InoE/cXTczZFfC9xWQJDjzrVxKoV8t7fsuxLANwi9AMsoV7rmVD/7JVsSuchOKxa8wDbgyCja3Mdk91z1VHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924132; c=relaxed/simple;
	bh=O1z0Ka5qMkUbQRoWXg+QK2LvuOW27PIgbEXIjf6kySQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS7a1Ulud462a+v+iaHd4fhErAZ6fMJMBLBNvo+pO8JLRop9y32Fk6pYyfVADK7Sb1LdW7MlE02XcsX4ctR1Ba5aSt/cIERtqfVx3t7YStEd7G+bniISm/6JzPxRZlgUweaFf85hsGpzj4lou7LMhKesNVw55Hoy+pv2/Taf6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaxlVO4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaxlVO4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16B71F00A3A;
	Wed,  9 Sep 2026 03:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924130;
	bh=kGEFJZ/BG5s2iSF5fW6GXrJzUtrIb/z0f3Xtu7APSKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gaxlVO4YIu2G/AxaC0gIFer1XtfOUPBgMi7rK3LmsBdk5AYNaTpPHiaulVj1WFZmP
	 C0TnuTgf6EyxExONblzY5LckvSLChKYfrcY7Ev1XzAgP7G5rwClp1Q36M/AYZ2xx6K
	 xxBDeOVBgW9e/wGS9fdBLuGO0PGi09DbtSSxxJ6kGYUwvztHX2AcdU4KGD/UCQAEV9
	 JOv6TdMD16gqsSfhhuT3ZQp+qQM6qE2lzuKb9FZ09yogt5T1rIHa0Hcvp6rAF5/Phg
	 6UrzcPNlWdna8zzmssQrNmwJwkHgXQvOXXh0hf/xIc8cj6VRMfdolukf8E0JJgwMUu
	 ffEFrg4GzFqpw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Song Hu <husong@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] Docs/ABI/damon: fix typo in intervals_goal sysfs path
Date: Tue,  8 Sep 2026 20:21:55 -0700
Message-ID: <20260909032155.118089-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090815-crane-crease-f5f5@gregkh>
References: <2026090815-crane-crease-f5f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

Patch series "Docs/ABI/damon: sysfs ABI document fixes and additions", v2.

This series fixes typos and fills in missing entries in the DAMON sysfs
ABI document (Documentation/ABI/testing/sysfs-kernel-mm-damon).

Patch 1 fixes a path typo, "intrvals_goal" -> "intervals_goal", in four
What: entries; the documented path points to a non-existent directory, so
it is Cc'ed to stable.

Patch 2 fixes two further typos ("WDate:", "manimum").

Patches 3 and 4 add ABI entries that exist in the kernel and are already
described in usage.rst but are missing from the canonical ABI document:
the 'update_tuned_intervals' state command (patch 3) and the
'tried_regions/<R>/probes/<P>/hits' file (patch 4).

This patch (of 4):

The ABI document spells the DAMON sysfs directory as "intrvals_goal"
(missing 'e') in four What: entries, but the kernel creates it as
"intervals_goal" (mm/damon/sysfs.c).  Following the documented path
therefore yields a non-existent directory.

Link: https://lore.kernel.org/20260714140117.94147-1-sj@kernel.org
Link: https://lore.kernel.org/20260714140117.94147-2-sj@kernel.org
Fixes: e2b23dc62369 ("Docs/ABI/damon: document intervals auto-tuning ABI")
Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1b492fc82368399123413c937f13da6ed312ee4d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b6b71db36ca72..ee111f632ed85 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -105,7 +105,7 @@ Description:	Writing a value to this file sets the update interval of the
 		DAMON context in microseconds as the value.  Reading this file
 		returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/access_bp
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/access_bp
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a value to this file sets the monitoring intervals
@@ -113,7 +113,7 @@ Description:	Writing a value to this file sets the monitoring intervals
 		the given time interval (aggrs in same directory), in bp
 		(1/10,000).  Reading this file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/aggrs
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/aggrs
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a value to this file sets the time interval to achieve
@@ -121,14 +121,14 @@ Description:	Writing a value to this file sets the time interval to achieve
 		access events ratio (access_bp in same directory) within.
 		Reading this file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/min_sample_us
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/min_sample_us
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a value to this file sets the minimum value of
 		auto-tuned sampling interval in microseconds.  Reading this
 		file returns the value.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/max_sample_us
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intervals_goal/max_sample_us
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a value to this file sets the maximum value of
-- 
2.47.3

