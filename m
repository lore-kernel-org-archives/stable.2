Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B33515C0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964715; cv=none; b=rlBH0HBjDLBKGofnzPnXJ2GGqnA2doyyMrasEuD7xJWjhCiAicxKYh0lCgRVaBy89TD4odQ1UL6p4l53Bk06hDSCWuI6a7iNdFJsPecUdd/mqg8LR2Hul0L3sIC1Lqo+KnEIAz09ihgHimWdqZpPzyifSqUkbFa0W4zDjNh8UA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964715; c=relaxed/simple;
	bh=qDg5vxfsG1Ujb0tlV/p+bz1qiSIh8MXo1JQEGI6gjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV0PcW37dkGGShqaGpzUjSWxAjX8HDpEMB+FymGMhcYHTCeVBt0QhMMjT1zYsokv/eKymGvSJzBchCwryOeCncffa9uxAp8cI6dxWoLoqmgSAIK0daxx5GnUDOgtiF+IfKj3sf/KH9uDue1o2TNq+8d37kbb7mA1Vr75zv+SZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn3qBOPe; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn3qBOPe"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so398790a12.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964713; x=1790569513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFedONfdsfWRRZrYGPfCHTniDDR5y58Jm72BIyX2Ebk=;
        b=Bn3qBOPeAFzjniEAiNVlFiEY7WMtINXAY1epWMTuULYNLK80NTQ5k0INptyu6P/fu/
         H+lLH5Ti3rIKeYrxZBcxRTYteb0R1c6ktQcz31uMI4iIoujQL2o5heidXBO+DgYSDtbH
         m/t296KmeZ5Q68jAzo53q6bb2VKnZSdQWIpNLfewPMAETkc7z2IuRt9HCoRtfqbWAbOl
         pzvE3DCIhXPlQC2bsBXa6gACxTM8kbjw1gVYYEKKP/WIIRTDWHNBdfCNwYCdWDbJrFDj
         qVjbrMfnsZeajmXdlaZuRoJH4uLCis8461jApN1eU2W2ZDxVLjSNvHmticgM6aWpGe3h
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964713; x=1790569513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFedONfdsfWRRZrYGPfCHTniDDR5y58Jm72BIyX2Ebk=;
        b=wr7lBy9DhsYA7vN39Lre65cdpoxL5VyFWBs5+T6M089wQSuvH0LspdO3lxPbjlH8EV
         bqNxH5d4mBdFF0whlD4k3oacc83bKS4gyR5ZUnWsunvEAJiuNLJcEKVIBNvQgZfamOj7
         DvDhZb1+APtmRKDxntg2scuZclMP2NLglHRRoolQes7qb2uJPu89n87t6jMY1i/TNiuX
         o8J7mdS8RXjnxH2EuL9gU1gxoOPIOuj7/2sg6t6JMYW+9aEc0PIOk9mQ6M5pMWsZX3Xy
         1/mJ5CTWU1SrU2cZPyEVjqUG4NbSi5R04VyGS9nsphRHxBrvQ90wgILINJqAeYRJvmBn
         Hyjg==
X-Forwarded-Encrypted: i=1; AKwUvBwbm2pVHXqFYN/FJzLYu1W9w0/zsT9BKeH1L0H+juqFXZ/6yiWUoSJ9B6B0cBhxrOQ8g17B618=@vger.kernel.org
X-Gm-Message-State: AFuF++kjrwzo6VXKsoevx8AU6BK2V3T8yDxDMJQPeGCWgf2mHsHqO7/w
	8LsgRtZmvg6pGhPSQiMscqPdcWZ/829CQ/akGoegtgFqPOveukCxSbUi
X-Gm-Gg: AYBFou3+bGpzJtzkSiVMG8qGALKXwruTOmStv2Z7Uvg3yt9wHi1p6U/O9r7T85g/RTe
	FM7UiEn3z2yAJERabP94x/1J8C1RnCr1+SAoIVkrxLJXzKyJAjqUmdc03SpekS2Lf+sJATFyvug
	cejxKcGuMquTtEqicg7mDFDax16+6u7Hd6HoJrBm+ImR9LGDstyINz8Jgly0mNNgvtzCIwqUEqg
	H31/yAn7c2dFmNaBu3O3X1WAZRnFrCXkdIURwC+xT5fhLoBzC3XkGEaj1ax/6n9zNl48TIASdjM
	p5XPLXawdhKE8K2O56B0qCj21UEh6jb/gKzM/rotXB8hcBesFxjxPFRD4eUAGYmnN7R5Qay4WS0
	2qStMsY7EBBvC+scdvQVp5lZtYml5j2yb/VWV4jjSCURm0KIhRgpAL42b7+TCDRiZenjmY0/l/I
	R4OVHxYBqgC0B8ABWKwasQsgxYS2S9XYerEDvD2A7fvpLQ0YWoWTWfH6TkomhnJkMQ2rPwi5Z7Y
	HVoqCL9Jrb1sKEJcB0hdSBusECQs0bC/e3dDNTm+wH+Lk7SK+slukJ1VkFfXTHi4aX3SvMnHPAE
	KdMzmWyINg==
X-Received: by 2002:a17:90b:184d:b0:39e:6a7f:6186 with SMTP id 98e67ed59e1d1-39e6a7f63ecmr5905503a91.23.1789964713209;
        Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:12 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/6] qnx6: validate di_filelevels in qnx6_iget()
Date: Mon, 21 Sep 2026 04:25:06 +0000
Message-ID: <20260921042511.1473629-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_iget(), raw_inode->di_filelevels is copied directly from the
on-disk inode without checking whether it exceeds QNX6_PTR_MAX_LEVELS (5)
(unlike sb1->Inode.levels and sb1->Longfile.levels, which qnx6_fill_super()
explicitly checks against QNX6_PTR_MAX_LEVELS). When qnx6_block_map()
later computes bitdelta = ptrbits * ei->di_filelevels, a crafted
di_filelevels value (e.g. 20, giving bitdelta = 200) causes a
shift-out-of-bounds in (no >> bitdelta) and out-of-bounds indirect block
traversal:

  qnx6: superblock #1 active
  Buffer I/O error on dev loop0, logical block 4099, async page read
  qnx6: Error reading block (4099)
  qnx6: error reading root directory.

Validate that ei->di_filelevels <= QNX6_PTR_MAX_LEVELS in qnx6_iget() and
fail with -EIO if exceeded.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6
filesystem image with root inode di_filelevels = 20 on /dev/loop0: on the
unfixed kernel qnx6_iget() accepts the inode and qnx6_block_map() walks
invalid indirect blocks ("qnx6: Error reading block (4099)"), whereas on
the fixed kernel qnx6_iget() logs "qnx6: invalid filelevels (20) in inode
1" and fails immediately with -EIO.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the v1 patch into a 6-patch series (one patch per issue fixed) and
  remove Markdown formatting from the commit message, as requested by
  Damien Le Moal.

 fs/qnx6/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6de49333acad..13972c086673 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -560,6 +560,13 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
 				sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels = raw_inode->di_filelevels;
+	if (ei->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("invalid filelevels (%u) in inode %u\n",
+		       ei->di_filelevels, ino);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop = &generic_ro_fops;
-- 
2.49.0
