Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB248AE39
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025845; cv=none; b=Q5nB2B9dPre2RvSb88vvGGt/ItVWCgtxHTaoKhWipc1iuNOTVEq/haj7bszhXjdM5tagGcqAuOZ9Qjt4syJhTnMWvIFFSbrIGPSRtETtAgEji0sbJmcQAYaKBRNuRR+RmG9p6jETcLXlnMiPgvQvrGghhZQKyxPgN/ZozhnqjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025845; c=relaxed/simple;
	bh=4WIQETbdd7ZVgqTHQyb8NbGqFO8RlIZ/rrczYaaOPrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMIYm535MBPx8SyLgGMMWDgxaTHQA2uNoaCbx7vHf6nT7pC2y/4P7YteS2D8PwvR4Ya5QoqmN2Nnvr4+NSRN5KanMFRbrZFp2IGrjjpCcC0bv/AUUy/5OFOapcp2CtfgVEm/0VVkMXZgRHn2Qro1ZAMQNZk1nU15by1a+1JLLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOsLRsXo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOsLRsXo"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa6863327fso5034523e87.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025841; x=1781630641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNDHPL4QZCBB2D1DReJErdxEUGCSQvUdM0eZQrbXxbw=;
        b=mOsLRsXo4a3GQD5Jx9ZiPj2za1E6m8Vc2Tu6wVWnD7zCGAI+iUpGTJEHr56GUJn9RJ
         d4Kh2B+XLjMzoHaP7XJakbQKsBhXTT1re9bqUKP/o3IWneTjKESMauyLNXSxNZkNONEa
         e0QQXLflRRS9Uv5AmNnjcWZ05lD8uFJVgjYDey4defHYgbNmI5jrPQZH9MWYFSzG4WUT
         ToT+0ddpjyeTuPoRsZUG/2cCwZwyfnF+glJy1J+J7NkOhRLR7VOQw0ekXg21H34y1+w/
         kdwosRG0yyYKSLL/VOBKRnTPzjqkUskMBLogdcmdcXEHsXMijwgXnQT9ZGZZqFZuG2H8
         Vxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025841; x=1781630641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNDHPL4QZCBB2D1DReJErdxEUGCSQvUdM0eZQrbXxbw=;
        b=l51pDIF3czqr3bDJ6qtpeXUTGCGA2wfpQTFP+z9+2sOWplrEeQ8pLFxxdOQKoVCCnl
         kO+rFQldU8Xhjkz6zLQBOmbvNJY76VaPtn78+8gT80pqU7+Y+QoOk/LNzaXtsEDy6ql2
         JhS7ybeEge7LMj/pqPSEXTgDFDnTomJhUVMW/lCVrG56x0Y/C+rkxgOB1HlLOm2TKEpr
         ghw4D9+0VIFLaDR42u4K4/32w3f3NQbqHiL6yzWoRwUV4Ypjh6HjzKKGMuMKH2LASAvA
         G06q34jk+p5qDoerP6juVl8L8R0liUcMzNh7zcp5be4YHu+JxXQ0PAyPgM1H6bRHckR1
         8Fjg==
X-Gm-Message-State: AOJu0YxXIviksFfdWoPLkJWLQV/T7DAfQSwrr/hUg7o5PV9mOhD8Zd3q
	KACH9iCc4+xTl8BeY/yZEwBti2be+2y7zW+aW8d4AOb+5v+d8VcTPr0SbMxv7TkV8h0=
X-Gm-Gg: Acq92OGkYXsGuvl5F9ZlIv0OL9jPky5C61m4K6ft1s+RmiFKt2UJ6RUbFamLL4pzo9R
	u50k7sQgtVaC7dn3ScxFJvA/LA+vX8NjLW+5J97uwQ4cRPa8JgELOYLet1XNhhaqF+3jbTPbDB4
	OoMuLeIO2M0KFS5Pr6USzyw6fDA/KDrKIoKleelRlf/t58MTrkakF5cBaNCgfh6bk4XWGBNGB2t
	S5yhyZS8VESjXJCnURe/38vCUm/pfk8UgoZRfp7mhpsiDKyY+lcn9C4l1cqUOlspjxAn93WOoSa
	YxinYfh/7Ncd+QLz1Ppx8jNhn+MTO56XrVoYhNXmMyjg/5Jaz3fTcQ7otGNTO5lrEhynqzE3AM4
	IpniANf7vAlMfX1EQEDKAJUelzYtAxvzccyinjfgkftkV4GkqCvfpNreMydHS9p0iJyn3dI+6uj
	aupCJWrQmNUEqcxzICPRtWoesSM6VRq5CXG7v0RN6sm/EqZTYK8gWt9efaqzF8gwBUKirNO+fDf
	XFiTUA=
X-Received: by 2002:ac2:4e09:0:b0:5ad:a51:20a8 with SMTP id 2adb3069b0e04-5ad0a512258mr1135766e87.18.1781025840827;
        Tue, 09 Jun 2026 10:24:00 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm4729939e87.78.2026.06.09.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:23:59 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	lvc-project@linuxtesting.org,
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Subject: [PATCH 5.10/5.15] nfsd: don't ignore the return code of svc_proc_register()
Date: Tue,  9 Jun 2026 20:23:54 +0300
Message-ID: <20260609172356.1887-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b upstream.

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Cc: stable@vger.kernel.org # v6.9
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport fix for CVE-2025-22026
 fs/nfsd/nfsctl.c | 9 ++++++++-
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ba2eaf3744ef..cc0dea883fbd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1460,17 +1460,24 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_program;
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 
 	return 0;
 
+out_proc_error:
+	nfsd_stat_counters_destroy(nn);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 7a58dba0045c..6d1c6067c80e 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -113,11 +113,11 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 14525e854cba..b9329285bc1d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -15,7 +15,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_counters_init(struct nfsd_net *nn);
 void nfsd_stat_counters_destroy(struct nfsd_net *nn);
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
-- 
2.47.3
