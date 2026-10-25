Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946901;
	b=AFN8yiN0lnpbp5Xv+o66DL2ZVT/kFJKkKJKXRAQ+9C2p1Sasz90eAvTPk+o4UDIpQtYR
	 pAx4iQvK06TgeFvzOz089FlpjMW8E8OliPnF4Q1eyaqPnTcOvCcsjcJsimuV7b0utlNYF
	 J9GH7gu888PLERoVhQXy31NId42I0KT2NFEDhs7ZPS8tnvUdRwdIf7E+SpV2XPfTHKyJ6
	 S6/oE7N0OkJ+KgrkZ9bsnqXDaJpz0e1/sq3dB4x3teT/XBi3h0IifrAVWQoFjpRhS3hYU
	 y41420m3kzG1PUDvmQGmG9w1hDrspNw8+q+lZaauDnZgu1WLHZ5ML9XbOdXh8lFwMsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aV53s/thMev0qSzH+ayYeyKX09O6kEW4ly1bV0/xJfs=;
	b=33zFA/MQU9znGPLNCoMg5ZBR51j8OyRqrXunE8TQqRIbRzyxykJzInNYcBgO4dRi/Odp
	 LPbQp9dVpnOWCCC1E/wiF4BEKGzlHDJcGi69uuQN6X1Jj++0r+MA7+/gaFSaRbDODMaQG
	 T6xEJQLnDTg+FrRb64eBcULIx4/qPkzzBZoyvqkxUAjLyv9sfiu/rXYBK9bZM51+dKZcg
	 XlZbXv7faoLtsOJ8sCPXPuZxr5zmgfnsIgDWA1KRGUSjhKPQqe/0vrj/Shc0QxccdSl5x
	 2IQrxPxF5a/rfeFBYxvR7KmefVPDal+YJkg0NkdMO21BmCwV7wUG0uOIUpp85TFgNDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIe4dQ9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8F606A31B;
	Sun, 25 Oct 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIe4dQ9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6C91F01829;
	Sun, 25 Oct 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792946900;
	bh=aV53s/thMev0qSzH+ayYeyKX09O6kEW4ly1bV0/xJfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIe4dQ9qRQgWpsb/mRrXjKCjVVbAKxbT6CyYHEfHil+iMfY9QDQpl4SnqHqhXa3ZN
	 d7Pjd5laCwnvrJFS3zP5mPQL9NVXYkisr6Z4fJD8UW11XmKAlkrlNjzgKCR3DwdmlP
	 d8Tw/x4VxMpdNL5pMz06JQetUNROL7/E+wYHHsqt0g0OZ4xivpDk7u2C/bD7cFoqk1
	 WU1JwW8YyN1Of8fiPpEyAJvjXi6sjsh3RNu2ZuP4GxQSWCCmi0yQ5lfqUYSoasHI2E
	 ljrX4OISIStTzZfidTBBU94ItWf/q3DP0E7911YIJYRowJL+fJl2Tj1aDXPpgkbr5Q
	 yXt7XVHdPRgQQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
Date: Sun, 25 Oct 2026 09:48:04 -0700
Message-ID: <20261025164808.152048-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025164808.152048-1-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
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

damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->metric
twice, once to set damos_quota_goal->metric to the value, and once again
to set the metric-dependent damos_quota_goal unions based on the value.

target_metrics_score() can update damos_sysfs_quota_goal->metric between
the two reads.  This time-of-check to time-of-use (toctou) race can make
the union fields incorrectly set.  The incorrect damos_quota_goal will
be passed to the core layer and make DAMOS incorrectly behave.

Users could reproduce the race by writing a new value to the
target_metric sysfs file while DAMON is starting, or online parameters
update is ongoing.  The issue will only rarely happen in the real use
cases.  It requires sysfs write permission.  The race window is short.
Sane users wouldn't do such writes while DAMON enablement and/or online
parameters update is ongoing.

The user impact is not very critical.  The race is not easy to
unintentionally trigger.  No leak or crash happens.  Nonetheless, DAMOS
could be unexpectedly more or less aggressive and does not achieve the
auto-tune goal.  Because of the nature of races, investigating will be
difficult.  Users can control the impact from unexpected aggressiveness
using additional quotas and resolve the issue in runtime by
re-installing the quota goal, though.

Avoid the race by protecting damos_sysfs_quota_goal->metric write in
target_metric_store() with damon_sysfs_lock.  Because
damon_sysfs_add_quota_score() is called while holding the same lock, the
race is removed.

The issue was discovered as a part of a bug report [1] from Sashiko,
which is partially outdated.  In more detail, the Sashiko report [1] was
mainly for an outdated bug [2].  But it was also mentioning the issue of
this patch as a similar class bug.

[1] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
[2] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

Fixes: 85fcf0ffc460 ("mm/damon/sysfs-schemes: connect damos_quota_goal nid with core layer")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8f083611741fd..637f1bd0c950b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1310,7 +1310,10 @@ static ssize_t target_metric_store(struct kobject *kobj,
 
 		metric_name = &damos_sysfs_qgoal_metric_names[i];
 		if (sysfs_streq(buf, metric_name->name)) {
+			if (!mutex_trylock(&damon_sysfs_lock))
+				return -EBUSY;
 			goal->metric = metric_name->metric;
+			mutex_unlock(&damon_sysfs_lock);
 			return count;
 		}
 	}
-- 
2.47.3
