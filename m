Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049473;
	b=H5KIi6rarmFKq0L8ypo5OflzAoerrh+m7agv7rwLj3/FQtxf4Fw82K99H+Z94xitrxRK
	 UvwXeMKlX3GiMqiHvK5TSJU1RHKpaJUUgJN+63szfS6XiXnstMksJUx/C8wmdo95dgBUO
	 5ZZZwrBtrhEmp/ZAFLZNWZZOnEdjQHKPEmWWS/+PTHXkAmFsr65bGMAFAMmRgHZUXUHH0
	 ehLC0Y4zt6Pkf/sD4c3IWmTl0F+42H3CMQVgp1GgkNDvXsDrx4Wf6SsJiddDD69Mum0vB
	 E8Eatp/EhWRpyJ7PQjw4khd3UAmVvN25lRMcDlZBupu2AC51Hs58vBwxuqXfuszRiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fB2iM6pKiFfzMEBs9IMArNnTUXBNSIX8bxqo8YS9b6E=;
	b=ySEa0AKginydxqlRbg4/eUpKmwtWgYiekcG5xBbXQy9tIPpZ8ITcCvCjQVR+U3v9Umpq
	 b79zLP1xMNQW7R7YnnLZ3Na9AThezLJsA0ct7ny3ZeoBCxPwgQDdj3DC8Y7bN3bpqVaR/
	 JNZmHx+NavPj7yUR6ZgwBJrU28qb9y380FChFDI72SdzX8oZE0+crrxdSCYGzkooOVFBS
	 K1/Nq4XC8b4wmYduC+Igl3cnGAN162eb66R0CX8w8AD0ofpwKTGYEcdcXUBAdJ2t9mU08
	 nwr9OWUdN9UeAdY3FXGF0eFt/iPSot/PqTFC4+EeRNltRRFk2tdHbrPLi+++z+zM1hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POUkYtfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POUkYtfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC19D1F0089F;
	Sat,  7 Nov 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049472;
	bh=fB2iM6pKiFfzMEBs9IMArNnTUXBNSIX8bxqo8YS9b6E=;
	h=From:To:Cc:Subject:Date;
	b=POUkYtfJSnqjLSxa5XhCB3VWwmAjyHX9+BRW9pfP8MWRBMyOXmiAeJGv9QvRBiPjb
	 oxV/hhq1WgB4v60UsARYjHVUEYnB8AGNTdvwwrzhk7uSCyogX3JS77tDmt1OSkhLDZ
	 KjzVpIFjjZTMsNqUoDFqR8VLyp1DGBIdm6N/DIwPNTkor4xS0GcQDlBb9SycLeAU8D
	 9U82NeMo2SOcNatuFOZwE5wdCaRmR+UrFg8+NUnBboHdEOazj3+Wx9x3oEvTA5Bp8z
	 0EsTB19zN5cyVtGKXm5GgiIPRXRTXH8BWqclvcPNUQQTFOTOjdDbORv5/OPF0icqHq
	 SJuk8PpfIeq3A==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:30 -0500
Message-ID: <20261107060430-failed-5.15-1d2397b2c414@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060430-failed-5.15-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:22 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg
 validations

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Link: https://lore.kernel.org/20260914142327.92510-6-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.53.0




