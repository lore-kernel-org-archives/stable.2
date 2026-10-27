Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793073591;
	b=jHxc8/KaU1inOF8rbKA7/sX/ykCykpj78Ep2v1Rqdv/dlkBP13H9UT4aFYyL6+4Etkt6
	 MWhShlR1Sof4ceFxiLisDQRZzpeidyvzfYZY0nqsy2dRd37MR7XClMaSBKRrCwhFY9mlp
	 03hgpQSL+9p55jYO8dhS3cP/NaxcgXAvMfs9VajnNGiUvbj08sqrjF9taTpSvnpHCR4C1
	 urCFS2e0F9imQKz8QkErRaMT9ASZKR3h7oZ1Rchqx4fa9p+p+WS3ETpmZSfglvUjHPo+c
	 TJAIQvNU7zKN5GLuXy6gZI5BUZDR4wgiCe5lSHx4OPgxEbdsvZNwdwp65MeB0CnbwYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ow0G93l9e0EmY6URJd2RDSyzRNeAkWxjCkJmGzeQGzA=;
	b=PYfuUg+k/0nzuqdnrWx4liGV+Rza3kxslxKQFL/TysrZNr14KwTp7RxxbLvmBTEr4dvv
	 nyceUzkdY3BTH1rKw56JkrNLFxowMnbfoHH3x4zQXYYXPlbJA+Z5lpmBX05l24cXCsjCU
	 wc2yCyEWKzhxzdoKtzuQYP3Ou3ZHP7dZEd216iYXQMnUswNwn/tfLZXQdNhSzevuGpplj
	 zjsB7UNP+JKips1COIsnUSRe6g9A7aX7O7Pp+vAEoLTOmCXCaUItSzZdcrk+KdDBWm5PK
	 9cHA0TobAr+PgsL7gTTNBP6V8URwvICUzZJ3Wx4rFzi0y+Wj7Ir2YZcAMk2Nq2OBA7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="aMwh/y2f";
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5E606A326
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aMwh/y2f
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so2206527eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793073590; x=1793678390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ow0G93l9e0EmY6URJd2RDSyzRNeAkWxjCkJmGzeQGzA=;
        b=aMwh/y2faS/js83YQ/KEeWIzD4kvOPqz2TU3afqpyyDp1Xs/QMPIUVv3dXmtkk4rh7
         ZLxFlVOCJLFzJYhI7oiFSCfiPQLskB2qIB0Cl/2H/ZEHnrEiZJC9RkDW0NdP4t6mVqvJ
         yrdo52st4GLaEGCCV36JmGMIV9WDuHTqKmBF5SbNQaoqLpQGgsyPfZ6rsHAkmm1M0LRa
         1OUMz+QUhySL6M0FC6oUa7i4M/xOYqGjFvnt3pUv6z61ZO/ngNDiWW2DC/2sHeQMPZpI
         wavf10DMzbXZXKyUA8PeFHipSfLDXz4X2U5iwLWXbQYOko09ZctwzsUnvy5HphzbDr7c
         iJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793073590; x=1793678390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ow0G93l9e0EmY6URJd2RDSyzRNeAkWxjCkJmGzeQGzA=;
        b=Ur1YgT2NxV+A80pLhgLJamkg9MgMctSaU+WykcjeMS9TaO7YcgNmHgpDFOPDnjk1d6
         uKOh/iV/8fxEuWVhHL76B901npoxs0S7AEIltK0cofsVsrNA+r+Z2wx44M82fTZPhB9e
         4uEP5vlQmXTW30vSaRfDETDBeiT1aJFl/7jk/oUhtqx8VaHkcpzt03QNdqOJbRnQ7Hj+
         7bsWTzcJ+IQzDDNUhQfWR3KWbE1ZoO7wHzAsfdSnfPzvgJLluG+WmsYk7tKk5XzExiuL
         rYnusb41wEERd6vQ9JDRIrcfxZNODYiaerr0prqwSi458bFq/zKSpZ5DNwMIFP8ykmth
         z8MA==
X-Forwarded-Encrypted: i=1; AKwUvBzaFV65+RivrWtHntosy6Qwc+LtcD604szeG1qmWA5jUo/QH+JZvLIbScymyQEZ4S6pphmr5sU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBPN/SSa9Sgnw4W77WEb4OO1JQ+UKTRzYX46sEez4FBS2/SEVd
	uv7soBve0O+aBTKsAvg7TRTv5x9JqTIm4SHiiMcX4jfL07QiR5Xq2P8m
X-Gm-Gg: AYBFou3oIJj/ZN8wvBYDIqsMWZcp7V2Gq15oSTUsJ9sTwmsRgVn/04LUIcj3OU9ckpD
	ocydZfmLR7m4F+VywoEhoOWI4yHNeTtV0o0c5zS5EsjFd3AdsJuNEMTgs6dwnvJnRY7RKc1vAtg
	jfELZ8U9Nr7vf/spFS867XfT2sONlo8rs7ouJGxVMmbyUupu/PfC0ucAq8+CZL4ZPKkYPM3/4RO
	DuHvXreBtA0+BGqUpoDFBphG+HddWg7BWonM2mbaL8JBW7/Tc93KtPG0S6r4/ItyEZrDNsC0XLq
	qTmDBBah/bPj5CVzIF6QhJ4uERYU7X0uPtm7HSDdag8LMbJsJ+GYgt4QXoTONe5d7FSB3OFEVTC
	2uxq7uC3i2Hc/5ryBIIsMU/pMp/LAsbZq4390kk0MWOYlAms6e7ays5EgmcAj7Sm0+oKXGQ2YTB
	csEIocbeafG8Gcd2lbJcUsehlCvJpaLc6OEoWrkFORQbgcC9uCDWScActbyj+0Fk2FfU2vqGsFE
	y1Q2sy7i35aGm281GpDgBgti7K8ewwzTk+6pRYBPo3rknjt4xLWDfKuRXjegQr1IH2UV9tTOPA6
	JEWbFRo=
X-Received: by 2002:a05:7301:18af:b0:369:f937:9a7a with SMTP id 5a478bee46e88-36a12d7efc5mr979215eec.34.1793073589608;
        Mon, 26 Oct 2026 20:59:49 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm36899329eec.16.2026.10.26.20.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:59:49 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ext4: preserve force-fsck requests across unmount
Date: Tue, 27 Oct 2026 03:58:57 +0000
Message-ID: <20261027035857.72265-1-dennylin0707@gmail.com>
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

EXT4_TUNE_FL_FORCE_FSCK sets EXT4_ERROR_FS in the on-disk superblock
but leaves s_mount_state unchanged. On a normal read-write unmount,
ext4_put_super() restores s_state from s_mount_state, clearing the
requested flag.

As a result, a successful EXT4_IOC_SET_TUNE_SB_PARAM call can be lost
before e2fsck runs: after unmount it treats the filesystem as clean
and skips the requested check.

Set EXT4_ERROR_FS in s_mount_state as well, matching the state handling
in ext4_clear_journal_err(), so later superblock updates retain the
request.

Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ext4/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8e579498c99..3e444e245c98 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1384,8 +1384,10 @@ static void ext4_sb_setparams(struct ext4_sb_info *sbi,
 		    EXT4_FEATURE_INCOMPAT_CSUM_SEED)
 			es->s_checksum_seed = cpu_to_le32(sbi->s_csum_seed);
 	}
-	if (params->set_flags & EXT4_TUNE_FL_FORCE_FSCK)
+	if (params->set_flags & EXT4_TUNE_FL_FORCE_FSCK) {
+		sbi->s_mount_state |= EXT4_ERROR_FS;
 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
+	}
 }
 
 static int ext4_ioctl_set_tune_sb(struct file *filp,
-- 
2.43.0

