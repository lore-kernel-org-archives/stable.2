Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAC370AFC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194575; cv=none; b=AxYkJiSHD9c+45P1hIatAa7fFds8dBxn653cAMUmeJmaXu1VHvMZklsM4GUPSf3Kz8YR6om9vu2wqwi34z6OzyyA/k/VSljXJDElcL5dJB2efvxZ3o+Yi5ByIoHc4UoOAfBVA3+sf0Fk1NgefiBGCMfbGK7DkHOADdwGkqFugs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194575; c=relaxed/simple;
	bh=09KcHo8QARdoasI0t/QztpgwPkOymD9K25f7JbuQ25U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj+W5BnHWOvCx40ZoCZ7Sxxdp+SYDbhcK07EtcjBn6fMK4LMC9zVJ3F6R5v3n2lpRLS6ISLG6h6igDqzWG87Q/rbTWO7r6hxEmppDLv6r7oM+yQT90XyJrir7qwudOceZ5tUI5X/RTsQjdvXrAMjb914ECPVjM7q2AZ4fR7gDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGVcYvqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGVcYvqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9431F00A3D;
	Mon, 31 Aug 2026 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194574;
	bh=PovDNS0uQB5OrVkMxPSNaaebpb3jxntZ3SG57FP/DBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGVcYvqyjq+qRU4rpf5HvCdAdeEmZbzS9eJ8T7KSo3oCZDkLfUcHt3BDrmA5jCiGi
	 VuPJARBXSDV8bSOGPX4AJEf14fQpq9Kz/1hRmX64sH9vheuG2ETIwErn2rrU1YszTr
	 KCrXr83wWOmFRbapzgJgIaP9VswJ+RmZmTEyNkUVEnNkcLYQPt0oRoHhwKOgTlZ4Id
	 SDB7VnNZhkQbaur0Bq1oOYKKDknMWcn0rLfc/DqGtR8K0EeoO6wKhF/7rlpjQ6Wum/
	 tGWJSKGRLyA73PtLOG9CfBGyAT03YH32GSfVbgT0ooD/PSHdfgioqrO0HKssAj8JMJ
	 CdYe75fCVmUjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] fuse: fix missing barrier when checking io-uring readiness
Date: Mon, 31 Aug 2026 12:42:50 -0400
Message-ID: <20260831164250.269934-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831164250.269934-1-sashal@kernel.org>
References: <2026083142-tingly-scarecrow-e145@gregkh>
 <20260831164250.269934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit edb310bc27f0ad83e7fd558a3caf1a94ca511654 ]

fuse_block_alloc() reads fch->initialized and then fch->io_uring.
fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
read barrier between the two loads.

This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
and skip the check that blocks request allocation until the io-uring
queues are ready. This can reintroduce the lock-order inversion deadlock
that commit 3393ff964e0f prevents.

Add an smp_rmb() barrier to pair with the smp_wmb() in
fuse_chan_set_initialized() to prevent this.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ renamed `fch`/`struct fuse_chan` to `fc`/`struct fuse_conn` and `fuse_chan_set_initialized()` to `fuse_set_initialized()` in the comment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8a38a263295fe..33e01d67e5151 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -172,7 +172,13 @@ void fuse_set_initialized(struct fuse_conn *fc)
 
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 {
-	return !fc->initialized || (for_background && fc->blocked) ||
+	if (!fc->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fc->blocked) ||
 	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
 }
 
@@ -212,8 +218,6 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 				(TASK_KILLABLE | TASK_FREEZABLE)))
 			goto out;
 	}
-	/* Matches smp_wmb() in fuse_set_initialized() */
-	smp_rmb();
 
 	err = -ENOTCONN;
 	if (!fc->connected)
-- 
2.53.0

