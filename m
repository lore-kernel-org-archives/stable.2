Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58315437FD
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872164; cv=none; b=A5fNE/WgKP0qkay0JItijMu5oDVkIW34Yp7sWZVZmP7oCPj+NawZtOFmHHjq5/q+aTVIzBd5+H10G8pnfFzyGKlnE8ClooC5sqlNI+sUP7xPfzaDudXtodbBc8GKsRSQR1CKTVRGfbgKdJBrpumHWoTaWx0wUx88zzFVJ5dZL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872164; c=relaxed/simple;
	bh=Q4IfE/Evixoth7MhbatmCPO4URr6cWcPTLZ3YNztGb0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E8Fv5shRvtfZf2FIx/h2w+XLQsmhWMUf9CsfTd2OIINM+xQa/RsP8qRxYbReT5OzbnYrKWTVljRWhxE+5X+eQUoFawVi7c9rhog5g7JFt6jFYkIrNNFRK9A/Fy4ONJkDyAMV6UbbL5zx6ZWolcD2M2Xmzlf9gNWqyJuSoN1x9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yn4WsvAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yn4WsvAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404EF1F00A3A;
	Tue,  8 Sep 2026 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872159;
	bh=9DBqk8GojdM0LaEyQF8B8iw9ovdEqcKLl8tNJYevAXQ=;
	h=Subject:To:Cc:From:Date;
	b=Yn4WsvAN0P/IMNX1iIglNUvXi+4nLbAmWKQ5dqTxenv0Eo42m+Fr8ACRGj44TOa4v
	 oz1ff1vZmec1lqj8RfwYk/aQvnpBHEnGpr6NZy5ma+7GEIuFcefO+6AhDZRmZVgcod
	 pZ+jNWxh7ZFw9/cossatcNQoVeeGCd2ashZoqiQc=
Subject: FAILED: patch "[PATCH] Docs/ABI/damon: fix typo in intervals_goal sysfs path" failed to apply to 6.18-stable tree
To: husong@kylinos.cn,akpm@linux-foundation.org,corbet@lwn.net,david@kernel.org,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,sj@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:48:15 +0200
Message-ID: <2026090815-crane-crease-f5f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1b492fc82368399123413c937f13da6ed312ee4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090815-crane-crease-f5f5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b492fc82368399123413c937f13da6ed312ee4d Mon Sep 17 00:00:00 2001
From: Song Hu <husong@kylinos.cn>
Date: Tue, 14 Jul 2026 07:01:13 -0700
Subject: [PATCH] Docs/ABI/damon: fix typo in intervals_goal sysfs path

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

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 907a504fb64c..a8269123b423 100644
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

