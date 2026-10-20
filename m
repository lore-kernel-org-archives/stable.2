Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507657;
	b=PhnK5hjnMGeMUQSSSH0Lt8hWspdGi+4uzDN6quyGZLHdo9ET1h3vqICDIYHrD9XhIpr5
	 ZhQ2Mu1aBdY0nkhvzEY5LDlWw27tvXPmL+X/HByyRdtsTvE9LPZrGTG214YQKPnBQd3E8
	 5+INYuNrbIJrrwpYAx7gWOF7sZr8IfdLyaeXs10Phjhh3YDom5+klyLWtmWQ/Tt1xMQyv
	 zbmmiK1cFMAcMYgNRqM/+PtLX2AreSj4PoVXd1A41ukGdj/kBFYLyGg8LvxbbLJ3Nv3uF
	 9SqqumoHVr0jUIoCHRjpcL7CQxMBdyte7E9eVW9eVBl7Hx9DXisnyUpRC9t0yj6DpOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8KLZGYnTaZZfWo0UwCu1ph7Ozc8pVIN7vRMc1zsSV1g=;
	b=xwJj61EIAutixGwMppkUANHBVXYDrprBhBe+5ljsOXwS0sXZ4Usb1KssKOQXR83nz+qX
	 jMJO4nLZ8GQGhqX/U667PsD9O7i6mkgTN7mx5hjw4DKSxCo4D5Qg8b3Mj4l7PAs1JMxuJ
	 5BrEGg2oX26qCDYYtfm7JS9LhlAj2tVxEAsQ9JHxISPBX4walxQF/uL/M7gQ7RfQREjQg
	 j/fmswSHgJ5VMgdFVCb5mtRdHcijzyHITfLBRQZ9PKTtlMz2YgHMYksy/GOysUrMldyeR
	 1eB5PFZmZEKwvURPybhFttdsTgs3KGSmb2hYnXvBmz+qvNOkRrseqQHxpP+RmZMR6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D4MT/KgP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81181606A319;
	Tue, 20 Oct 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4MT/KgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48FA1F000C4;
	Tue, 20 Oct 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507657;
	bh=8KLZGYnTaZZfWo0UwCu1ph7Ozc8pVIN7vRMc1zsSV1g=;
	h=From:To:Cc:Subject:Date;
	b=D4MT/KgPVeIyRqW9ieO8UoVRz48J1VsRFefiD3x9nDNdAu62Mkrvbh9F4WY8uzk1L
	 t+zUAqjuIjRc8S4m425jmJFCAUoXO10wl8OCTqVtBc5LE7WvffRUYcLQwFwBMKaoZx
	 1QIzJx7T1LS5Jq9dWWJO3igUYuhuFvob6iZ6y+EJa7Wwgaxi9RDKsv/f2xDWbmaEkI
	 1AIkuUwrmE9zqQHCQboXcQ8ic2izEQoKZB99XWR/yfXW0Ny8Yzvbt6nKL5fLRjJsdl
	 +JyjHbO7FAA+nFX+djkxpiYKUjzE5C0Jck79FdHXf2VEXBo9svXkGJDY7mXLdbbM+N
	 daaI6ENhhxiPA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()
Date: Tue, 20 Oct 2026 07:47:25 -0700
Message-ID: <20261020144726.88978-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Remove a race condition under certain use cases that can trigger
divide-by-zero.

damon_sysfs_add_quota_score() setup damos quota goal as user configured
and pass to the core layer.  Because it could have a race with
damos_sysfs_quota_goals_rm_dirs(), which destructs the files that carry
user configuration, both are called under damon_sysfs_lock protection.

The damos quota goal setup disallows zero target_value parameter because
it can be used as a denominator later in the core layer function,
damos_quota_score().  Otherwise, divide-by-zero can happen.

For the zero value check and final assignment,
damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->target_value
twice.  And user can update damos_sysfs_quota_goal->target_value via
target_value_store(), which doesn't hold damon_sysfs_lock.  As a result,
a time-of-check-to time-of-use (toctou) race can happen.  If the user
sets the value to zero between the zero value check and final
target_value assignment, zero target_value is passed to the core layer
and results in divide-by-zero.

Fix by holding damon_sysfs_lock in target_value_store() while saving the
value.  The read side, damon_sysfs_add_quota_score(), is already called
while holding the same mutex lock, so it avoids the race.

Users could reproduce the race by writing zero to the target_value sysfs
file while DAMON is starting, or online parameters update is ongoing.
The issue will only rarely happen in the real use cases.  It requires
sysfs write permission.  The race window is short.  Sane users wouldn't
write zero target_value.  Especially, they wouldn't do that while DAMON
enablement and/or online parameters update is ongoing.  That said, the
probability is not zero, and the consequence (divide-by-zero) is quite
bad.

Closes: https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
Fixes: 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS")
Cc: <stable@vger.kernel.org> # 6.8.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8f083611741fd..55298a17b653a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1355,7 +1355,13 @@ static ssize_t target_value_store(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);
-	int err = kstrtoul(buf, 0, &goal->target_value);
+	unsigned long target_value;
+	int err = kstrtoul(buf, 0, &target_value);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	goal->target_value = target_value;
+	mutex_unlock(&damon_sysfs_lock);
 
 	return err ? err : count;
 }

base-commit: 33560dfbb2df9b2d1525fd51ceeca3c1167431e3
-- 
2.47.3
