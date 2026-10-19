Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEC448BAF
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380943; cv=none; b=ClUWsqDSSbhCdlMO/bl8hWOAobYEPUpDJt3TClbNgRE7+c0f/op92bEL4qJF262NMo/X+5tOozHVpwvRYy2cpXMLI9VWa8YlZ9B4FO3naVvGPxVU/ZGrxcMXBHzr97VM1fJyiZy6MwV/xzn6B0s9JuyvVKonFVByFBpnjEFzdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380943; c=relaxed/simple;
	bh=cvuvWuvGv9Z2Lk/0KigTFd9FadnFFHEycgAfdzJtmgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDgpLaZcfuBsusiw9ZJpEDSSuuiZ6nUtdZQn9dNnfkZNmmwSD4kSOj3vFtQT1aUKQcD7G2MhozCVYU3UGpYdZ2DiZJ8fcKLDz7PgKzXXaG+RvBwOgdbklRMLYAEMrgIEJETCI3rmnDHLxzYUOwYcpj2iE0Ew6fOsTGTEL4pSfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M22mcz+G; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M22mcz+G"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05b210703so341496b3a.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 20:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380942; x=1792985742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WIXgzDkcDaZz08s4IW9pP5BfYLuDRW0ADUF3wvX19Fg=;
        b=M22mcz+GrKOvc8MzD83mg7JUIfH2n4Sm/vuJ4QDoFEyvjYCZ0M630bKVCy//UWT9a9
         2Ae8GJAo168iez7YT4RXzjYF6PSq++toYlY9e92Xqs6o8KYj1Y5bm+Zq53EvLl/tqvCF
         t6ijQZRVjpWbpkZknqhgZobR5sVE4Au8iyH6lBZ0gIenpP0fHcdChPUcu3WYk5HA7DqY
         8oZyBfqDnnj9QfU7n518JMgQP5kZrCqOyQYa9gMieYquvqsa9fdstleEVwqnN5srsomI
         gBV6hXPYZjVOX9+RzQxypn4eDKlLq8BW3szrZtvcAh7uxxokAo3jj6t/sDTODBhVoG+b
         nNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380942; x=1792985742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIXgzDkcDaZz08s4IW9pP5BfYLuDRW0ADUF3wvX19Fg=;
        b=FH2wn6s2bhWvgv4RojmHPw2G/dhIOKvd4VdPJBr94kiwz8rf+MTFQ772w8VSGN5mCi
         Msmw0VuY23OBYtTrCcvvVvpzpRitkKMVssTstT6l3wjtQM+MKbCk0HuUgMxZga4UWR+U
         ASUwhX/215DdHFAzlm1TI/WBZJJJQzFnZgyg2wvy9JtEU4xtJsSNgR9Yi95vKzwWCCet
         lgEmBx0he54vwushsknlpZByi3a9wVmrMLDMKXniF5bsoNd51xXhta9AlDpMCcZ+F9/6
         PivHnzR0iu8I9/UjWSTiMKcqNOibRTqwy8T/NnJM2qTDDgewiNltS/q5j/u1M0wK14nq
         nKCA==
X-Forwarded-Encrypted: i=1; AKwUvByKBSjFC2ciK5VJf412zaZKht1RDqrnlkoCD7fV5SXe+BQ5w0jfwKzdt3e6TZlTCYzu2Q0twbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFrp2uYUj8RwSkmmdBpx4QQI8hf7gknSHHjpEVES8MYNvBEwEU
	ZlZ3mle4iQqbML/8/GJtXrwakubqqUDsqNX0Jp6EfPgSZGd5S/jPtTp8
X-Gm-Gg: AYBFou2WBfKi3+1stFb+toADG2yQjOzFYYqoJPDjwKm+uUa6E2Wv0r0Kyzs4hdyXQx2
	h9s0FETeBTO1bPFdYy/DhyBn4GaOHmMIGb3iPkfQs7D6Kd21PuGt3t0gx7cpSoFbj7UsUAUGcRX
	npfXQ0WtMrAr3WHZIYQHvt4o+hJzuEmqd+DWJXdDXCtjLFDXsEDbhx5e7bm5ngFQi4BrzIMrEZI
	hyk87efZ9DTYUpuPkZMZ0mnQQEpNZlUF5n7tvk93QzrCYw0FYb+Ob70DT7LWhGZD2RsNS+VsrkW
	KUQlQyGXjkUvAcA7tWGplSABloya9o7/xBQYznLwHqszDD02AT329/8kVnk1HXJ1GNPRyzhfV8F
	mZyEz5oO/Eiutm3ljXZHbiHLT/dCoVYJnpwaGt1eoc/tN1Fkfpnmd6CQYJIXxUV3epalDdapFwf
	nvgPjW7PSAbOKZevCDkPkYQlBwMXevU4jy+2UxYH3Z61+Yde9H3BDPMcyGD3LtX+ZysMiIcRDhq
	JzvfwXItHRMxnt/AoRA07ug9C1Ckb5JjBMSJT3bLzgM8ZqVYWtNKGSNGlcEl0Q/HbMwgbtYP4Zx
	WrPBYNRMYMXRkYh6X96puVE6e8HipKiuyDRDHsBtbpYobcvE
X-Received: by 2002:a05:6a20:9184:b0:3e2:5624:694e with SMTP id adf61e73a8af0-3e256247190mr664484637.39.1792380941823;
        Sun, 18 Oct 2026 20:35:41 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57268ff1sm3352670b3a.22.2026.10.18.20.35.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 20:35:41 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: fix list corruption in core_alua_free_tg_pt_gp()
Date: Mon, 19 Oct 2026 13:35:32 +1000
Message-ID: <20261019033532.73575-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core_alua_free_tg_pt_gp() moves every se_lun off the group being freed
and reattaches it to the default group.  For each lun it removes the
membership link under tg_pt_gp->tg_pt_gp_lock, drops that lock, and only
then takes lun->lun_tg_pt_gp_lock to call __target_attach_tg_pt_gp().

lun->lun_tg_pt_gp still points at the group being freed across that gap.
A concurrent core_alua_store_tg_pt_gp_info() holds lun->lun_tg_pt_gp_lock
across both the detach and the attach (via target_swap_tg_pt_gp()), so it
can move the same lun to a third group and re-add lun_tg_pt_gp_link to
that group's list in the window.  When the free path then runs
__target_attach_tg_pt_gp(), its bare list_add_tail() links the
already-linked node a second time, corrupting both lists; the lun's
group pointer is also overwritten and tg_pt_gp_members is decremented
twice.

Writing a new group id to a LUN's alua_tg_pt_gp attribute while another
process removes the LUN's current group (both via configfs) is enough to
trigger it:

  list_add double add: new=ffff8880055a64e0, prev=ffff8880055a64e0, next=ffff8880055a64e0.
  kernel BUG at lib/list_debug.c:35!
  RIP: 0010:__list_add_valid_or_report+0xdf/0xf0
  Call Trace:
   __target_attach_tg_pt_gp+0x9b/0x190
   core_alua_free_tg_pt_gp+0x22f/0x3a0
   config_item_put+0x89/0xa0
   configfs_rmdir+0x42f/0x5b0
   vfs_rmdir+0x22a/0x4b0

Re-check under lun->lun_tg_pt_gp_lock that the lun still references the
group being freed before reattaching it to the default group.  If a
concurrent store has already moved it, there is nothing to do: that
store holds lun->lun_tg_pt_gp_lock across its own detach and attach, so
the node stays consistently linked in the new group's list.

The store side was already made atomic in commit f9793d649c29 ("scsi:
target: Perform ALUA group changes in one step"); the free path was left
reattaching without revalidating the lun's group.

Fixes: adf653f92f38 ("target: Subsume se_port + t10_alua_tg_pt_gp_member into se_lun")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/target/target_core_alua.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 10250ac..3a085e2 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -1746,16 +1746,23 @@ void core_alua_free_tg_pt_gp(
 
 		spin_unlock(&tg_pt_gp->tg_pt_gp_lock);
 		/*
-		 * If the passed tg_pt_gp does NOT match the default_tg_pt_gp,
-		 * assume we want to re-associate a given tg_pt_gp_mem with
-		 * default_tg_pt_gp.
+		 * tg_pt_gp_lock was dropped above, so a concurrent
+		 * core_alua_store_tg_pt_gp_info() may already have moved this
+		 * lun to another group and re-added lun_tg_pt_gp_link to that
+		 * group's list.  Reattach to the default group only while the
+		 * lun still references the group being freed; otherwise the
+		 * bare list_add_tail() in __target_attach_tg_pt_gp() would add
+		 * the already-linked node a second time and corrupt the list.
 		 */
 		spin_lock(&lun->lun_tg_pt_gp_lock);
-		if (tg_pt_gp != dev->t10_alua.default_tg_pt_gp) {
-			__target_attach_tg_pt_gp(lun,
-					dev->t10_alua.default_tg_pt_gp);
-		} else
-			rcu_assign_pointer(lun->lun_tg_pt_gp, NULL);
+		if (rcu_dereference_check(lun->lun_tg_pt_gp,
+				lockdep_is_held(&lun->lun_tg_pt_gp_lock)) == tg_pt_gp) {
+			if (tg_pt_gp != dev->t10_alua.default_tg_pt_gp)
+				__target_attach_tg_pt_gp(lun,
+						dev->t10_alua.default_tg_pt_gp);
+			else
+				rcu_assign_pointer(lun->lun_tg_pt_gp, NULL);
+		}
 		spin_unlock(&lun->lun_tg_pt_gp_lock);
 
 		spin_lock(&tg_pt_gp->tg_pt_gp_lock);
-- 
2.43.0

