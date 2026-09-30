Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50C36F419
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738169; cv=none; b=Z+COC6SRfCqavD14jgAK+fIK96fhB+miIttsSgucdiseLmpUMN8Y7N934I0i4A+6EMge+glM4ex4wgi+DEanG43gJLHiGGXTwT4QC9ilCQJHszwFGi9EuYct9LHWGGNjzDoxN0+fGDCwzWDc6HzWXUKK+n8oC6r/5SELvXPy/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738169; c=relaxed/simple;
	bh=8wNFnaCc5+jMJWBgF5mE0Q+7753dPekI7+Vvl9kv3j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVlyCTJURY+bCyplKHEBdmDxf3zkRNhfzpcDJJNr63Y2SwVbQH7UwR6pM+oHVLDySzr5kNgnME7latoui31y55ryk8+bchSzVrw63wfrWmNqLFg8y5spSMJTrph9XCCPLPDIj7qUeNQERI7BqZ3kEz/rc0fyct1yd6Cav3GIDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZENIbVL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZENIbVL"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3525773a91.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738167; x=1791342967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeIWmkzMqAkIeZrxz8PymGN696feWU6nZ+MlW18uxhs=;
        b=rZENIbVL0hyFMkPI8F5qzoSdsjG8HG6WiDE/Hch/ife/F7zd7qXZV+NMlFgxdMC+Xm
         OdZytzy20vzVOl+4+ec6K0OFKVMu91NATNNGKEzDhqh6nIQqQvVj0V0qupzQqKw49ih3
         CFj+Qm4Z3Lu+Bo2L1ju0NC7M79MMcMGK/lnpk9uwrerOJSEE1MCCqUsaFtLbP4dTf0U3
         gX57y/M47O+t4s24CSrYI7mTD/B0Ygws5wjCW4rC8sufE9v5qaPFtFPOqJDatKo9Vv7i
         CzZXtYvD0s7wlM68F5kSwHKi5fkydJztSjp2sSNvzC7VDYJPbYtLzp2Kk7Ml/37GcM6E
         YP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738167; x=1791342967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeIWmkzMqAkIeZrxz8PymGN696feWU6nZ+MlW18uxhs=;
        b=10zVG0sHx02y2tVUrV/2oMVK27MbW+FJ4mR1yOrnc6kAxoOs3TSsMLq3FyWdchWS8k
         soCnc6EyH2QJBbHKR/ELA2kd+xFnkaMF7iHm4MoxTX71MnLs2ILr2YX8v3d60Stk8e4/
         G5NwaLkcvyerw/euhWYMTtJVwG0LB/FHCUWKumwFj1hGQsYPfNoRY1AKy202dEqOhqcZ
         gfFA0q0EEFPn5B3wwY/aqFEW0wcnbL82QwoSMc1DPRxdBT544TIYYfZieUWiRPe4V1sa
         5+4ftC00OQwGmUzO5MA7/f0ULHXggqa/SLJsS9YLXkkd9/TuaxAOqeRzd6gi3Ow4GLgZ
         RUtw==
X-Forwarded-Encrypted: i=1; AKwUvBz42V4IFlW8OV12JCbofBRNKA/Wc70UBhffpAjGk1b/hSE4UWzylrQnNwe0ieT2v1VVSIvRl4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8+EFXIq3/6HZFb+JWdXrnb2K/7p5JVzgEY5w4U0VnxxMGEYRp
	7yVXB5WcCjhZeTEhytXJud8se1E0gV84PB709a/05soQ+sjscRy6Y3hL
X-Gm-Gg: AYBFou2MIL3W2ZjHFloibE+nvCnyUQgGbR1Yo4RNfIBHdppKl4Nyx+JmhJ4/jp8uh45
	TcsPgAqkeEP46+hu6KybNRjDEq0R/1fj1TlQ1RAxKG4JZAJVmLXm21YUQZwGHM9NxSdQSxHcPmn
	n5Dp67RoFzsD7Qp1+p3tlfmY91aFP6m88Ovb00zo/UpZt/EljcaRpiS/gJ1unUic108V1CuIrH9
	1+tt8YigX0IdqXr9byshTiBb729OoEpVXIcJN7UrNYzNmvMPsDXGRi9zmxFKAzr256DZ0X4eER9
	rYfc1Ik8FnsBCmIm+4dEizLyNkvtz1iysjCic/WhI5rJZd0jsG54yFmUrHWDgzHAIKFS2C6VJaz
	2for6OUAjXNYKFsprkwwGH9bvgHVtdJnrkl9JS0LsAoGavCi/z5efxN3/4dwwufAPXGXZLyAP17
	owPf1ty9Zynbg5SriAul6Tc2Q247Pt0cgRbRJz0mroMV8CLdbeqpSF3CRt351guxMTjZxFfPGqk
	mAKvLUtHXf+C+ZPFNvTWul35xfyU3gbkDBvDuGqwK6ZCPd4NU4wWeVxST7tNxRP9AZTXwfepDPL
	krmWeFlVrHgN3tL/90Ae
X-Received: by 2002:a17:90a:ec8e:b0:3a2:aec0:6bd5 with SMTP id 98e67ed59e1d1-3a4d193fc3fmr76912a91.57.1790738167369;
        Tue, 29 Sep 2026 20:16:07 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 1/6] qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
Date: Wed, 30 Sep 2026 03:15:59 +0000
Message-ID: <20260930031604.70544-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_iget(), raw_inode->di_filelevels is read from disk without upper
bounds checking. If raw_inode->di_filelevels exceeds QNX6_PTR_MAX_LEVELS
(defined as 5 in include/linux/qnx6_fs.h), qnx6_block_map() performs
out-of-bounds reads past di_block_ptr when dereferencing indirect tree
levels.

Validate raw_inode->di_filelevels against QNX6_PTR_MAX_LEVELS in
qnx6_iget() and return -EIO if it exceeds 5.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting a crafted QNX6 image with
di_filelevels = 20: on the unfixed kernel, mounting triggered a
buffer_head refcount underflow warning ("VFS: brelse: Trying to free
free buffer"); whereas with this fix applied, qnx6_iget() cleanly rejects
the corrupted inode with -EIO and logs "qnx6: bad filelevels 20 (max 5) on
dev loop0, inode 1".

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.
- Updated commit description to state QNX6_PTR_MAX_LEVELS is 5 as noted
  by Matthias Goergens.

 fs/qnx6/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a15bb03f0ec3..e61c33f2e146 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -561,6 +561,14 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 				sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels = raw_inode->di_filelevels;
 
+	if (ei->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("bad filelevels %u (max %u) on dev %s, inode %u\n",
+		       ei->di_filelevels, QNX6_PTR_MAX_LEVELS, sb->s_id, ino);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mapping->a_ops = &qnx6_aops;
-- 
2.55.0.1082.g2b9226bbc0-goog
