Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972243AD526
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983257; cv=none; b=KkXZeaJR8T36O4GK04umUwc+sWwTJd1krSQ78sSjB4SiTZCrL0Kle5LRN63LVZu0jVsQGFEWDfNDVzIrq+jNoii0XRczoKyGgjehP9aKWIjwSXiqrMmGxZ2A5mqqpPYZ7EmzqrpL7IhZRd/gvNzfGwduObOZdq24VcKDxrVXUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983257; c=relaxed/simple;
	bh=mWYaaJ95WFSIgwaj7DsE8799Djlnld1MLckIrfE585I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqN2Wk3xbklaF55X6XfJYPsPCN9k5GvROLkwPvlnT8gZDMLR7488BaGDW51ecmIgBrbzcJVxs5aNzM8sKtkexn3c8ku20/5mGwpSkh4fJE5BxofD9rxjmsK/y3ZHRsrvFIep2XtgV2qrL41ELb+CtRiWP/k+iL7ewGvUg7hwPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPb/+Ylt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPb/+Ylt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so99722185a.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983254; x=1786588054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hysdgtb7wp/8HlGZYxSnsEh9b9oJvSSZRpXBcjKX6ew=;
        b=sPb/+YltBgId2YtErMZpO1BjQeXqOy9tSMLfM1UoXrhKR+TfRxxz1ZFg2kF/rEdYcW
         vNQQT50sSsdwIGbf6UEQW/oAnOy0LB1IrpzKbIF5U1NlfFdcLAmwBfd6xwGEUpHYESfV
         CYFFzpBmixri9Hb4gky2l7xp4AK6KmAjInF9IyRm4lpc4bZmGotrbX/dSvbf5S8hbqZV
         BGywAfGbdp1boikENpvsR5Wk2m2sb9rrQ6hgsl2MQF0/LtMFatvvFRdGVoaKLZhFplEr
         TBxLyu5oAXCsmyPR9eCAGg4FzHI9LpDsNFSwx7IpgR0wI12VtUvhOGjm0hWV65UehK/M
         Goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983254; x=1786588054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hysdgtb7wp/8HlGZYxSnsEh9b9oJvSSZRpXBcjKX6ew=;
        b=GurqiV+B5n7oLe3O2MnWxg7IZzhenE/1MBRlVeTH+5xPUUMjVtsPpepdQTuPiVnr7b
         Ne1lZUrUJQ8GKMgLqxPNPyh+AnL81qjYQqG7UTDjx0u1dbWXg4JZYNYg3s9jJRRrr8jg
         fXTFgLW5rRsd3fucLdK8WKOB2H0aciwCmYsk5TcSJigrja36EuXncahMHOr8Lco+hfGM
         OTOV1NLkK8TxDXhY5Zn0TbGVbSVRRQPbpBJV5wXfPjq7v4rXj4GFDXC/JEF+qXcbrzQQ
         tOxONjUj+kb+GapVSyPq1Tm+M0IyV7cnqAFrT4zeo8o6xdIGmnvdU2xwVg2nvF4QRAe4
         89AA==
X-Forwarded-Encrypted: i=1; AHgh+RowUvNfD5vRmte60UM1DACwunbcsBDtrTy+ecqbXFXmqzYoZW9QYJEGcuVNNaX0dMpmGh89a0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmMW2sHyMrdD37lSIwcH2zijb3cQx+1+BxQCWAXGKVE8fVyEI
	UYJUSLdc8NxfGgJN3Oo6tWbMKGBPdAJquWGJhwXSjxka33RolyDmcZre
X-Gm-Gg: AR+sD13qMMZLHJ78GBo4iUtnmT+bUrGll2iJc86fXF+bHuRB7LNThvUzt5EIlLrM4H4
	IFYhWpUrScftwTHJ36F4tlQ/muCdspI3m5b1MG5Bktgdb1KAJ/LSNnbYEVfyARgsraNGeA/dcyr
	dPLgWeIDyntw70ushHTXVt2OQe+0AyZpRg4FlUPP/WpVX7+d3l1uq/XagHsfX3j+wwUmxrNOjGJ
	xQGiJZrz3XaOsJ+8kQhyZ3VdNdQfnqGH9R675FHPwk/8q70VkgXT4JSIsuiV1s/7HjJ26y345VR
	bhjucFTjBBKmL3J7qE/b/QGgLW2d2Y66R8e8fX2cOZZZ9n1W/x+XKldcCmkYwC/txK/jRVyXZAv
	ouqcDGIaYr3uqLMCQCScZtSrKrN5S69MCfOAqGGPhO4deBhn95BKc8dS3ZD7sA8ZHOEUTEmuDai
	vrkLfImk2kCIt5zpDsT/x5VoMPHRwneSVfCOvNoRfAMxTwX3ltEqv9NpR9BZA0u2zb50lA7ET6F
	ifpwI6BDl/6ccgvrw==
X-Received: by 2002:a05:620a:28cd:b0:925:56bc:b8bb with SMTP id af79cd13be357-93648fafb5bmr1088990485a.9.1785983254432;
        Wed, 05 Aug 2026 19:27:34 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93657630fddsm157474385a.8.2026.08.05.19.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:27:33 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Fix use-after-free in eventfs_remove_rec()
Date: Wed,  5 Aug 2026 22:27:19 -0400
Message-ID: <20260806022719.375354-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eventfs_remove_rec() recursively removes the child at the current loop
position. After the recursive call returns, list_for_each_entry() advances
by reading list.next from the removed child.

If free_ei() drops the final reference, release_ei() reuses the list/rcu
union to queue an SRCU callback. The child may be freed before that read.
The eventfs_mutex serializes list updates, but it does not keep the removed
child alive or prevent the SRCU callback from running.

Use list_for_each_entry_safe() to save the next sibling before recursively
removing the current child.

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..93bc4f83b73e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -822,7 +822,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  */
 static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
-	struct eventfs_inode *ei_child;
+	struct eventfs_inode *ei_child, *tmp;
 
 	/*
 	 * Check recursion depth. It should never be greater than 3:
@@ -835,7 +835,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 		return;
 
 	/* search for nested folders or files */
-	list_for_each_entry(ei_child, &ei->children, list)
+	list_for_each_entry_safe(ei_child, tmp, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
 	list_del_rcu(&ei->list);
-- 
2.43.0

