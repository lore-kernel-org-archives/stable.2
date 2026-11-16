Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824664;
	b=2mEL01NYMleYWxOJooMYbpfOFvNSG0Xa20hm3+8TCe2I5Ad/KcmyftcDtNdWMdeK0JNF
	 kgW2s+ZLDqGbumt19cGHWJ8pgbbMsJJ2Ej+t7tYAJuwX2Gz/6mhC+0TrmDR9FQ1i1Aqgk
	 MciMwZX3QiEUW/+YHvbZZm0RW4MjFVZilSPW39QyOUFoAgI/yMo6PP6A/NqnlqKfgFhEt
	 ZapYZTAos/XLphJNWb8Uojc+87LLbAkjtpOli8Gce19brXD9AefvaXOliK3iYvl0H0HgD
	 LteaiVyj57QZIR7bBs8dSEr5DVM9/9HEDL97v9fq2omiWaIgs2Wy3+EStzLZzeSl8tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
	b=PGgIQsa9JwJS1qvjmvxtEqFYRQ2JU4TSM9rdpUHX0+g0fByTO7RsJfWxqDlkjeqYhGhO
	 SaEVZwqE9HeXXqFvRqcjKx90w/iqeADM0Nvr21tfqNhqsRY5Oj7Dj1piGpCaE7bc/uvVR
	 IEf7K5/0ZZU+0lhHyrtmhpj0P6DPRhZpyUEK3eJN0BndrVVjDkyJN8+HzLIAwZweu3ncl
	 7uyY1d4LsT+NVmJvn3DsHsXN3h+RxnnSC/6by5PTsK0jW5CWcgURAce400t2r4Ko8Sqip
	 SfiPWUOMlmSbCXSbaFRK3V7PYjeSsNVTETaw6vZzKk9m70NXq+xx/jnSCgG53hpG0qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7jQ3tuy;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315F606A33B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5315F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7jQ3tuy
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so23189755e9.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824663; x=1795429463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
        b=e7jQ3tuyVlS2RTuK8llltk8GsHFeKcYBPGKIbGVzrTawX4qSYVi1Nncil1+SOrLmCh
         7YBlmuYE/tfh0Vo10s0nnBX1APjph2Iml6CdjQVt5tpuhRDQFzH1UdZ2k+oiIHWhsOTZ
         BEbcKxR83hhr7gsSa/dU4sN2VCyJXxAKcy0tlyjjDO4S/kbLO/Mf0Fcu553gc8Ylhhbi
         8GdtX0AutLEKuFvJIQ8DAq0zgF/uvWjCKiHKu/oXO4uq2xiFigFECwqKKl+72+ICZFxl
         lDaJVWgF79Uan9sMtpB54vo13yh4xxt+iKWfAGpFo3kGl7Qv3FXFMpqdLe+y9rK3j4Lv
         UWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824663; x=1795429463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
        b=gGiO+H7iDDEjemT+ZsEDNN9x7xZd1oO3ahXnrvziidxNS2UF7lZGsJfe4KADN65V5z
         3i1SF2tceNc867GMdTSTr42aJoiY6Qdjp1X0BOieKWv9/8WJXX0AOGZIKzBqJxrc3l1v
         ha3Lclt25JqSy7DTJDH+PssVdajEDMLeKXdQ37I83LdrAaFXjuGrxS6z2rMm0I/psLGZ
         ZZmSeMxuB7w2A+qBvLqU2vVvFcbyRqO4iJy9g3uE55GBxLQyF9I2MTQua4kRD1GMKnHE
         4FJ91+zx5mSv8CKG1l1jWjIxSIitY16p1CaGvxpWkOab3XrmyZdPL5ygWRvMKNLC/jSI
         cJ6w==
X-Gm-Message-State: APuU4Z8X8cc41nnXxmgp46bxpsIxJrLJlK/X+R62dksEgezq/1zRR/Hy
	jkAlizLCyxIzgYkwmaM/I94C9O2oEPgdZWl1tetrFaKUV6Dzz9+94celJfGVJraO
X-Gm-Gg: AYBFou0fy9eZvnVb5To9gTo1H6d3SrMoEdQJ0prtefuvkkP6HV7DAKeMHNp5CwDTJhP
	fxgqka4Xd7GnhEnRGCAlaVbzRbkHTzj7qaKlICnidxunknFmCwHfDSgWJZHkrMOasKf/Kg666th
	MZn4eoNmvjspRpX4cePRpMT0MOAsrn9UHTF1R2W2zahARJiyH0HYuoQKqAEe51mzAyr+kyqjgn1
	2UowKFKWu4ChITcJhgjv7Ba1U7SWWT6CMLiSFz2nqvBU1xCZb2X4p6G/ciALP2K37Ldxm75gF7u
	YFfh6CyV0j9KUsw2Cd0gjt6VZoHMVClvVzmz4kmxnsuC8ahy4l8uiysVP4/XK46uKavKl9ORwuG
	dn2RywIfRxp0OHQ1ANyzzhcw6DChpPr/HZOViCZLJXaUkRLrRuxIWyVt3Tv7kL0NcaACHBNuCoB
	o5rwG4gOSocYWqO69eCSVXuTFFdZ5ZIHnalsc8Z1ctIfJzIgsq3Bb8uVglOfXKoE2c/jlLjNNZC
	wrcQOSMVUCg6HZSqPLjmVzUL7v5B6YIkw+SIK9tJkOdMmUpSFNajYztLAIzlWqFiWuYBlv2OeaY
	5i2cr9pM7U7xRbtYxBP7
X-Received: by 2002:a05:600c:1989:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb66fdaeefmr125267505e9.14.1794824662652;
        Mon, 16 Nov 2026 02:24:22 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm191536225e9.3.2026.11.16.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:24:22 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:24:06 +0700
Message-ID: <20261116102407.81232-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 04550c0ba540..74a774dc4eb4 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -195,11 +195,14 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

