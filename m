Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587014;
	b=zotCDJr6t7JWh1EAYuzC8I+plb0dR5lCJuIsc7vI/25HFZ1nzXZwbf4A+ynWHcb3ZG9X
	 HsmK0otZQOBSmRYW+zDzU8J5f++iZB0WL5YA1UyXgjD92eWb+j5SPCcFtFfTadjb6UU/r
	 h3qRRtUgWh1egQvZkzly3bZ8epC/EDeu9srvCNbKiGLB1cML3yEqFLGRLkl4jSLXiVPMt
	 khgKFUsg6/GVLRwTkYFb6IbFubkhPQbLx1geoklyIzkEp1x+LPpIDTRYMwpkh/+CAvV1I
	 zQ6u1r1dBRWKKJmbO9PGvSxHhgtT9sPm5KGWnbwJAhKluei4yHgVMoSfLIeQe8eWNyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=;
	b=tkoMieownH24EVrW8DelZQtv91nvci/jGlj0pCAU9ra2h64sMNGOohUs/mRrPCmzD4Zt
	 xkM0/ZG3wxGRtQWbBlEpSsrQSrjGURl7pCEa3r3Dq4zYHfsQXpAJIxdaQ3fP5iomJomft
	 O8/B7NLh/9O6cxuj32zj0L8O5VYH3j6B96GkD6mkaKV/MlM9QkRg/c/ey/HaBwNQm192+
	 aGKXFw8Q5dHn6qeaxjd+SDKTDc9Jsf444zcvIqCxMYPig6QwNYpo967qnmlfpVya/D683
	 WFbdsp4+hTGIjytYDS8jGQ++1lCZ26qQdVOrDuJ5Cb+TJk+/nmEAJFxPeYzO7zm4iUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVIFoIit;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52244606A337
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52244606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVIFoIit
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso911927b3a.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587014; x=1794191814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=;
        b=BVIFoIitQxf9mhi4w8vrQpbXZKLwAd4TnrCcOEkYIa3lik/Jk4Z5ea2i+TKFO/T12t
         0utblloiZfXy6iRaVTrldCQ1Nt4/a3PCsmkry2w6kysci6qpii8eMQ0JCN8SnH4/ZDO6
         gZLx2HY87uwnXbhhr34gqSt1aGLliQj59Z95zE8vReH0Zo0vSqURawMU2P98ISreAGYd
         Xg9OFbFlbOuhORaY6sw99zjHgH5Yujtp6qwS5pa6Yqz2MjafCR5yGVhT10OEfFo4OHiY
         TShD3yMTZE1+0LJ+5BdPSqvmB5ezU4187XNnBykOx7NJ/66e7+suY99aVBpOtMabs2Td
         MGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587014; x=1794191814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEEAk/Q46YxnwTmxNKxdH+qih83wDE1j0UFvCl3PWms=;
        b=kZojITNoWjMyJ9dgo0rirIaG80jSOhBWu1wZs17e6TZSW6HNzfQgcd4RHzgYHlpkTM
         wGGzmX0jfUiwEnzrpXDqRRCKoUuQrlMoOAMv7xGRYCiDLA4xxbkYKLNI9Bymb1tPG+iU
         2be7Yjq0+iWVL8dFc5PprfWqvAaxm1dt1aNTrHPkAiKycoSRGFfUBWY4fbJ/nqKe3Mcc
         Tbm9UeifhpIRc4SL0Oz7Rttc5631jqZvHZU1/foiWXT0fqOtb6JhqKcOnZwyOGWAjIH9
         0Cn982h3x76utzSblBBai7vUZ0OOl3QSMMBKkYCJQL2v3QBCqAPKCt7wGKKOJ20EkzaT
         XKSw==
X-Forwarded-Encrypted: i=1; AKwUvBzYSDYxxGhQ8EWhqgjWsdXzf3E4aS67U5doo9dwAnr/AnmnaRGAmSdKwPk6x5q6Vj3l2Lcsm1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ew2R9dpseP3Ty4oHrKxKsFYZQY/6j4sH0c0Ja96kd5bXzkPyf
	L7zqVZ8s6kCowvU3yOuuoiFI8zFUvQKUf7kkklZp/D6Z23bc6yDuHJSM
X-Gm-Gg: AYBFou0LB1WGvhWVfUmaZuwjA/Px4d0Xgi4XEeoyYNGoSrCKnereD33Mab/Yxm7/19p
	ccC/0aRTGQDzji8X2i3fnNB2h+iV0JHcwsqtJ1X8uk7gdnOP52g1itRRrlwXpwY9o8NoWUJzlGz
	5u3E6Zg4cXnY23H6IHlDU+77Dx0AgRg4QbDKzoiDxcHfcASAaigvAjzgirYSbkAhIwetkL4Tl4T
	NWNAgF7XiBYzI2GIdnwR92lVvAkcgwHfvUajzyjx9R36G1WELYePu60I6lfc0Uq6fKXDXGzK/tu
	KsHj3o5Kq6strPFcYKCyhuU2VU9mdpmt4+nSl5lJDe9iZ7UZSd2ne3FRbFyOSK6VvgantFc8aLz
	qI3+GhrK6SqySyhUiQ+s0BGnrbbWT9DZsrsdQzn2vrEDAsyHV52JlRQu58fbl8V8b4G3Zco2D/m
	MMdHL7DW6K/tXVt2x8T5QCBh0E+Z745FAXconn1+80K1sm9DxQZRo70ENj8AU4lQuwSz7qbgZTu
	tYyvLvxRrVZ49yW60RTnXl9tOhq+s6K+MxTRsbl7hJLNQYh+pp+EIaWt2wu5qS3tyJ8t14wvFiq
	d7p8I+3SX56cJ2tiDjGsdIjILmQWp/PaSEyktmUZ/yKc4g==
X-Received: by 2002:a05:6a00:2389:b0:880:74b9:dcfc with SMTP id d2e1a72fcca58-8a9bddc4237mr7323388b3a.16.1793587013513;
        Sun, 01 Nov 2026 18:36:53 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8addc705868sm167812b3a.35.2026.11.01.18.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:36:53 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: lihongbo22@huawei.com,
	sandeen@redhat.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] f2fs: fix use-after-free of quota file names on failed remount
Date: Mon,  2 Nov 2026 10:36:46 +0800
Message-ID: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

f2fs_show_options() prints the journalled quota file names without any
lock that excludes remount, and a failed remount frees the current names
before restoring the old ones.  Reading /proc/mounts at that moment is a
use-after-free.

Read the names under rcu_read_lock() and free them only after a grace
period.

Fixes: 4b2414d04e99 ("f2fs: support journalled quota")
Reported-by: syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e818dd42ada3b583bed1
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: Added Chao's Reviewed-by.

 fs/f2fs/super.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1071059f2cc2..510df7998c18 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2325,6 +2325,7 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 {
 #ifdef CONFIG_QUOTA
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	char *qf_name;
 
 	if (F2FS_OPTION(sbi).s_jquota_fmt) {
 		char *fmtname = "";
@@ -2343,17 +2344,20 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
-	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
-		seq_show_option(seq, "usrjquota",
-			F2FS_OPTION(sbi).s_qf_names[USRQUOTA]);
+	/* Remount frees replaced names only after a grace period */
+	rcu_read_lock();
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[USRQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "usrjquota", qf_name);
 
-	if (F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
-		seq_show_option(seq, "grpjquota",
-			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "grpjquota", qf_name);
 
-	if (F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
-		seq_show_option(seq, "prjjquota",
-			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
+	qf_name = READ_ONCE(F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
+	if (qf_name)
+		seq_show_option(seq, "prjjquota", qf_name);
+	rcu_read_unlock();
 #endif
 }
 
@@ -3151,8 +3155,12 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 #ifdef CONFIG_QUOTA
 	F2FS_OPTION(sbi).s_jquota_fmt = org_mount_opt.s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
-		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
-		F2FS_OPTION(sbi).s_qf_names[i] = org_mount_opt.s_qf_names[i];
+		char *qf_name = F2FS_OPTION(sbi).s_qf_names[i];
+
+		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
+		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i],
+				  org_mount_opt.s_qf_names[i]);
+		kfree_rcu_mightsleep(qf_name);
 	}
 #endif
 	sbi->mount_opt = org_mount_opt;

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

