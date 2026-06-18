Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47F17A30A
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815183; cv=none; b=g/AzF3xJiEkgSCRovWc+993M0v+0+qEUGIuu38GtTQop3zLnkirnwRE2N+hvvur0Bh90VMg3rdiLl+Tfr9AtRL90nMuaH9IXiXwuxzaeZmWnxXluaDcLUw9yDY0MhO2e1bwj8edXFxxf4pf9249vpdi90jjsHownJzSHoWH9I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815183; c=relaxed/simple;
	bh=M9LBS/ykrSXaem3QI/ctUlIxV93Y9cVlTJizburNYaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqsMuuMxh0Mh3KUlWdhU4kf1yw44yCA6/0g+Pt4zALWnADT2JnReGxyZDBS7E0A/kGck8azuZVcCW0GZeQXdrw6MAMjULBte4DsLm/w0HzMK/IxrWcA7ZgfzFvySXUQCHzNeUMeV1MceHBzo4963ji4OjB/zgNzurmgMkL9I8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DM4/sCA4; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DM4/sCA4"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiE424006057;
	Thu, 18 Jun 2026 20:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DmO9GzfxigGJbMOIimnlbWahga9E82v7iGfH0q2ftsc=; b=DM4/
	sCA4WgOrDQTTzIC4My4R9Xt/SMvbtK3kzWK9/lta1ofh0E/TmxWaBMheP2+D+GJW
	1uzqDUkp93GJgqYG+RWLVqlYrHwOOXQQUyJk0KzVsq+bDHgmgDsOlADkkmE1yt2O
	8DdaZ6XuZCm2IQ1NEHeOkr/CfyqSl5Ti0lffkb4s3o+MCFMKOd6KrH594bYRU0JY
	aIMd4xYaQdzBkC1kwKcuBb0z/EuHKBKD/f1YkWUYrtMTR4ylhOORbheODnU4z4Qp
	1ddnmSvUMwZa15QYuEvgqqrdz74EgK/RXLxloxeH/0OUPz/jAnEHrFYF+ys+WQr1
	9+HgtAOxsT4sRp9rsw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg806-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:36 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:34 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 22/27] ftrace: Do not over-allocate ftrace memory
Date: Thu, 18 Jun 2026 16:39:00 -0400
Message-ID: <8903a4475ee0044f3c5c7236db3abdd0171e3897.1781814154.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX9thDrFr6+jMK
 Y6HwDJJc3NHN5McpPP6PQeFzAHtoH6m3QddkDT3/D1Z+46DMvcuN5e+CuvWMgkMh/ds7KQgkLlA
 wG8hCfDzGXjPnpLIDWMywwjCsMr9izmGjTaNxu5Hjpvks3AsNxTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX1v/kmWf5YBl8
 CqV3+VViygI6S2PEkGQIaS3wgaR5lrKV+Xy87CovUIo05d/cOZQuSobVOKqXtn0SgUHkxxF3t9g
 ALIwTfg3TgyjJ8bGhKJQxteKX1UhVLuPy/3U4TqP/UwiJQCjaLW0edcFhxylxUAVWnhxnPupx57
 9T1yBC/it9MQIvcGVhfcbIo2gEApz9Deua7Dufzpt7O3JRb+buYdx/x9rj3rp4oxMBOEQYCfbUw
 VubQlHneJ6tBbAsOJYBxvhE58YwcCKCLIaFo5KXdh4yLBAcly2uSj1Hmohk9XWUftxCP24ihKm4
 aG5uM9NnvkKPR2ceNctnsacNrz6KyslLcvzeNIHB3A0bkHlgpcmuN6b2w2Ry8ywG6SW7Oa1i6YX
 fKW9dfgPBgVBEagNIXavfL9kpAtYx6BOTKT195VLg0KTCZfElQMf4c1Te0JgbkK1s3q4HKQn8lq
 OJmtj7ODts+3bv+bC1A==
X-Proofpoint-ORIG-GUID: YMcCvcgI0fJb_DYnVKyanvJvfmTWm2v_
X-Proofpoint-GUID: YMcCvcgI0fJb_DYnVKyanvJvfmTWm2v_
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a345788 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=bC-a23v3AAAA:8
 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=QdOJ7KTZQxLTXGuSCPAA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=nlm17XC03S6CtCLSeiRr:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit be55257fab181b93af38f8c4b1b3cb453a78d742 ]

The pg_remaining calculation in ftrace_process_locs() assumes that
ENTRIES_PER_PAGE multiplied by 2^order equals the actual capacity of the
allocated page group. However, ENTRIES_PER_PAGE is PAGE_SIZE / ENTRY_SIZE
(integer division). When PAGE_SIZE is not a multiple of ENTRY_SIZE (e.g.
4096 / 24 = 170 with remainder 16), high-order allocations (like 256 pages)
have significantly more capacity than 256 * 170. This leads to pg_remaining
being underestimated, which in turn makes skip (derived from skipped -
pg_remaining) larger than expected, causing the WARN(skip != remaining)
to trigger.

Extra allocated pages for ftrace: 2 with 654 skipped
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7295 ftrace_process_locs+0x5bf/0x5e0

A similar problem in ftrace_allocate_records() can result in allocating
too many pages. This can trigger the second warning in
ftrace_process_locs().

Extra allocated pages for ftrace
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7276 ftrace_process_locs+0x548/0x580

Use the actual capacity of a page group to determine the number of pages
to allocate. Have ftrace_allocate_pages() return the number of allocated
pages to avoid having to calculate it. Use the actual page group capacity
when validating the number of unused pages due to skipped entries.
Drop the definition of ENTRIES_PER_PAGE since it is no longer used.

Cc: stable@vger.kernel.org
Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
Link: https://patch.msgid.link/20260113152243.3557219-1-linux@roeck-us.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 477f7b848..c8ae58c41 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1117,7 +1117,6 @@ struct ftrace_page {
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
-#define ENTRIES_PER_PAGE (PAGE_SIZE / ENTRY_SIZE)
 
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
@@ -3245,7 +3244,8 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	return 0;
 }
 
-static int ftrace_allocate_records(struct ftrace_page *pg, int count)
+static int ftrace_allocate_records(struct ftrace_page *pg, int count,
+				   unsigned long *num_pages)
 {
 	int order;
 	int pages;
@@ -3255,7 +3255,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		return -EINVAL;
 
 	/* We want to fill as much as possible, with no empty pages */
-	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
 	order = fls(pages) - 1;
 
  again:
@@ -3270,6 +3270,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	}
 
 	ftrace_number_of_pages += 1 << order;
+	*num_pages += 1 << order;
 	ftrace_number_of_groups++;
 
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
@@ -3298,12 +3299,14 @@ static void ftrace_free_pages(struct ftrace_page *pages)
 }
 
 static struct ftrace_page *
-ftrace_allocate_pages(unsigned long num_to_init)
+ftrace_allocate_pages(unsigned long num_to_init, unsigned long *num_pages)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	int cnt;
 
+	*num_pages = 0;
+
 	if (!num_to_init)
 		return NULL;
 
@@ -3317,7 +3320,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	 * waste as little space as possible.
 	 */
 	for (;;) {
-		cnt = ftrace_allocate_records(pg, num_to_init);
+		cnt = ftrace_allocate_records(pg, num_to_init, num_pages);
 		if (cnt < 0)
 			goto free_pages;
 
@@ -6535,8 +6538,6 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
-
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
 	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
@@ -6549,7 +6550,7 @@ static int ftrace_process_locs(struct module *mod,
 		test_is_sorted(start, count);
 	}
 
-	start_pg = ftrace_allocate_pages(count);
+	start_pg = ftrace_allocate_pages(count, &pages);
 	if (!start_pg)
 		return -ENOMEM;
 
@@ -6636,27 +6637,27 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		unsigned long pg_remaining, remaining = 0;
-		unsigned long skip;
+		long skip;
 
 		/* Count the number of entries unused and compare it to skipped. */
-		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
 
 		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
 
 			skip = skipped - pg_remaining;
 
-			for (pg = pg_unuse; pg; pg = pg->next)
+			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
 				remaining += 1 << pg->order;
+				skip -= (PAGE_SIZE << pg->order) / ENTRY_SIZE;
+			}
 
 			pages -= remaining;
 
-			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
-
 			/*
 			 * Check to see if the number of pages remaining would
 			 * just fit the number of entries skipped.
 			 */
-			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
 			     remaining, skipped);
 		}
 		/* Need to synchronize with ftrace_location_range() */
-- 
2.34.1

