Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A920DD51
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938681; cv=none; b=h5eAAtdcNqd8prLynxsTmIYGXagIHbj8IkD3ylew9F8i9cEA5eDngCDbElK8ga8d8yRlB0BL3LnE9AoVRXBVLOHJMn1GjDs3ueyBQAJvKsTWf+UL2MADpgcrh0XyTFcXd0WC7IfmHZ8qdO8n3j46lkRf0zXq+RxHtCy0HsSx/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938681; c=relaxed/simple;
	bh=wme4A//9f96PFXXeZt7PMWTk1y4VdPHJPcAAY9OATZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmuFaFNhMsQ4YYrU3XV3Jlq1Lden9+HrGlz/LRblbvPcL9eSOYcWKMel/q0cyku9g2qm4+eB2/wdfZkXsnjQ2hTet6aDxMagiLfMIqrKC/vP5OgVf9BxMlLLa7dSTlblJsoQS+Mo6/h8rYY7S16fyn/+tqGZOmjl6MlBr0Ikr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6vC8TJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6vC8TJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE9B1F000FF;
	Wed, 14 Oct 2026 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938680;
	bh=JDIr1q3jmT3U3PUD47hToEicZMMIKq8UFX8nw8P/EJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6vC8TJEqO06YROlu0EHSExJKf6GIR0AemB+kWIjHXba3v5PgvIS48Mi2sSFBVf1Z
	 ZTWRw/TKto2yeJ0kcKZkiPeq4upXdj3StlEY8bSPtNmjsOVUfNz58tnp03FWK2/oIQ
	 FUyVjP82aa836fs+jKfPVTah6cbA71Y6Cxa2AvV9O3VriqTYEQnznEeaxmx+NvfCaV
	 Yv6Hr1LP4M7zbDvKncmMN+5MqXtNDpJqK866WmL7vhuQZBL0V67gUBgKpibiHgmEP3
	 XU/uMvqDehWcS1IwNr6NeMpd15EWSMLzFc/Kc5fol5sZwyUQn33Dl26k1LWbKX3sdQ
	 l2LTFRnmPhCPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] fs: Split fcntl_rw_hint()
Date: Tue, 13 Oct 2026 20:44:35 -0400
Message-ID: <20261014004346.1478485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101223-sprinkled-coming-7d84@gregkh>
References: <2026101223-sprinkled-coming-7d84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 1505ba06e52e701600172bccbc3aa7fb9bd5d0da ]

Split fcntl_rw_hint() such that there is one helper function per fcntl.
Use READ_ONCE() and WRITE_ONCE() to access the i_write_hint member
instead of protecting such accesses with the inode lock. READ_ONCE() is
not used in I/O path code that reads i_write_hint. Users who want
F_SET_RW_HINT to affect I/O need to make sure that F_SET_RW_HINT has
completed before I/O is submitted that should use the configured write
hint.

Cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240202203926.2478590-4-bvanassche@acm.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: b0d1022b9bdb ("fcntl: refuse F_SET_RW_HINT on an immutable inode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index ee4699bcfc4d3..8e1408e8a5853 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -277,32 +277,33 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_rw_hint(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	u64 hint;
+	u64 hint = READ_ONCE(inode->i_write_hint);
 
-	switch (cmd) {
-	case F_GET_RW_HINT:
-		hint = inode->i_write_hint;
-		if (copy_to_user(argp, &hint, sizeof(*argp)))
-			return -EFAULT;
-		return 0;
-	case F_SET_RW_HINT:
-		if (copy_from_user(&hint, argp, sizeof(hint)))
-			return -EFAULT;
-		if (!rw_hint_valid(hint))
-			return -EINVAL;
+	if (copy_to_user(argp, &hint, sizeof(*argp)))
+		return -EFAULT;
+	return 0;
+}
 
-		inode_lock(inode);
-		inode->i_write_hint = hint;
-		inode_unlock(inode);
-		return 0;
-	default:
+static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 hint;
+
+	if (copy_from_user(&hint, argp, sizeof(hint)))
+		return -EFAULT;
+	if (!rw_hint_valid(hint))
 		return -EINVAL;
-	}
+
+	WRITE_ONCE(inode->i_write_hint, hint);
+
+	return 0;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -408,8 +409,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
+		err = fcntl_get_rw_hint(filp, cmd, arg);
+		break;
 	case F_SET_RW_HINT:
-		err = fcntl_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
 	default:
 		break;
-- 
2.53.0

