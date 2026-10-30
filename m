Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345070;
	b=XD9Cdsh+qN7yyz+nvusL6LK0m80aDuPHl6QC2b15D9KuhlHjYsfjgjiLp9cirA6Jo7BP
	 jMqN7nxbn0psrBYD+PAJjeXaSXLDQEvnAue7scGhx2buqs5Yo1uZwNdEe4NMJ3vGCQgJi
	 ChCGBl8ckQrInNntIiaULQIebm+V0l8yo5dm765A8OZhlgbYS7A1vGkmQdwW7KRRSA7nE
	 2tsTjvYjvzAufRC+YfvKcVLaVbi4Ir2LjAHq14LmSdhyFb3BvP6tGI7udn5iJc6hw0emp
	 /Wn/x3ZRrmJv3paCtP+rypVqTZPw6J0fvijsXnqWvGMyV/7mNS9tnq8kNVduYgQungw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=;
	b=yKO0C2e0ojTqTcOvzCGkfZtyps6zAnQOEWMvBwA5UAI85NthAdycG5jLB9KyLNnamkap
	 tPVK+cAn33qQJOqTYhcyih9jSqnGNwivclkmlFso1gO67AlrhUbglsfP50NkrxziOg8VZ
	 +fva24Uu33GO8LChvppN9Tzx78RU84s9bAvs50xJNV8Ypu2XRLacy1slsT34EEpM7c2sU
	 NS0FbMWTlbU+TRhFL+3AkrFCv6TLPzjg+8kKgslEhrWX3RB1LdDi8zhBHeGGXz819CmVc
	 cdTF4eyxnjuU0ifCj9x0apT37EmtRGjX17x5QiTz8DbXI9AxgGwFGRHYaGzh/Le/1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xZ0W2v/m";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F9606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZ0W2v/m
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so304580c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793345069; x=1793949869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=;
        b=xZ0W2v/mgNa2gPXp1oXlehPwfMfTmGYGAdJQENx5HTREQCRxXNEX1KHS74Lex/LnKM
         SkK2oL41vipMN9lKXIRb3q/xuj0tNPsFytvo4uH9kb3LTxf8BstDq0RhqzodY+4JpYtf
         qwua2IzMXsOlcVxOxf/oBgRZP5VnYhxEPiKH5Snx31EFauAa6StdvIwfnexfa0AH6r/L
         yJqcX+YCbQDtLD1bIhG4HR4mg0WUV3Ze09SVGHP6GbguA2HUWuvpiMnYT1q7TSmYKtL7
         D7ccfT8y85dLD+hlF2A1zCuQI+BEcLdMSNP//ET2lNi/nx7PEbOUpHs9ZOt5Fp/MwTiD
         R62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345069; x=1793949869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TC09uNuPonGXjl/unVFttCF+flEGGGYAyLCGtQa6eaw=;
        b=BFbnv0avQ6nAcgyLWZACcP4zY9WY/b8vlKOTuAx/Lc12E3e6DDimRSNLjdLM2FeOb0
         77hmherMfel0EQEJRYmnnXPUCOO25ApY6UUB/Sk0V1RG9UM9vbxivYj8qt1p7x181T5z
         isM1NKtMYSL+vNvpM7AqRT1nTKr61TSeP5mG1MVn39P+Km842LWn2jQUEuwI2HJgDLAX
         ajZAkWrRyS1qpZAauYFPXrnGk/RhkvFPwAPd77MRuI2OhIbFRKImoICC483hKy3GSR+t
         V5K6kOvn8VxLhYQ0X7C+Wd9iLAivouwBWjb6buDcNkfX5Mdlx2pgkEZ5j3ZWEVW7majU
         whuA==
X-Forwarded-Encrypted: i=1; AKwUvBzOckjmTWC4M8V+q93mHU5mh1lLorNPUcyJxaboFgh+Wkb91uM/n32OBo1Lb+Y9XdNvQ4i72H0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlXZiBcTE1Doc47hqIgXKo0C9Q3d0VdkVQvoMZSR+aoQ/SJo/3
	LqL/EOpoJdpzXvuIlIQi1CSk7xMbUomsTUh5DDidfeWZhXIH35sEXXyK
X-Gm-Gg: AYBFou2nJ0Of+32fuiAZhhKMV2si8+hAVfPQBBDTDv8fXSpljbevbf2H5/u8HR6Wuiu
	Xkf/QQQH5CQtCZ7qMW2IaebCczGZBos8S2z6q3sMtQuLs+YkBUkqmvbyYnF/B/6C1MWHs59sTGj
	+2/bOdrFvPGgGWFgMZSbjr0YuTqgNQsRy+QabndW8wKNN63QmhHsS+Zij2pyuGhID7H6Ylya//Z
	/kVv8rG/FAxfPIJP2mXGFBOZMqeQDdYaisgrSttv1L+PvEp42oSaTdx5MTTNd4z75LKlWNsIpT/
	Xcp5Pycn5AY5Xsw9FAq8fZsVh1KCHYFuU5E87HY0umCj8Gfr+QNlF8kWfIlucPmfte3826cfJy6
	g8upuaA+hP9kMd4tiuu+AsgGyll9DxfEQgjnFNQHmfU0fkj5/aeqcu562FQBZ68UtP1CWHPLBB+
	IPnAdt6Xp0qjyRrHkj5JtBtifydgIXRLmr/WWHuMyDpB9YPsjzxsW9iG/pA0Y8yjLSdAs8PmV6A
	G7KC4xMVnOHcdrWSllLLIQcS3Dq3kmMrwsroqDa4Hzzc3xRxV7Vd9DqZxqhEO1oU/Od5DXqEDxb
	OdsyPL7S2sEt6Hwm/rQ+VcPE8TqABk9AnFHjUeQzWH8oOg==
X-Received: by 2002:a05:701b:428b:20b0:1a3:dfb6:e593 with SMTP id a92af1059eb24-1ac5eea3690mr2126468c88.27.1793345068566;
        Fri, 30 Oct 2026 00:24:28 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm4462883c88.8.2026.10.30.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:24:28 -0700 (PDT)
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
Subject: [PATCH 1/2] f2fs: fix use-after-free of quota file names on failed remount
Date: Fri, 30 Oct 2026 15:24:22 +0800
Message-ID: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
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
---
The names are not marked __rcu: every other access holds s_umount,
except is_journalled_quota(), which only tests them for NULL.

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

