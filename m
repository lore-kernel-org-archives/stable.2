Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870439;
	b=B6BNDkUlY/KV/T8b31fXjIWyEmX1LiDOwE4iDAWK8YD54ELL6mwNpU9Y0B407mi15V7z
	 QnS9/GjZqZPDffeZcil/RWfwRAFoP2eryGQdO+0YHheJMQmVH7WFpZK0pATAC+sLJadJ7
	 w9VoQuAde8eRWaHnL6RCpdxb1ER7l2HngXErDhOU8/MCebZ9NQ4XpCP+VdnxHkcu/VsRg
	 yvhHJMpAyMhQGyAZ0L3z25R1mXWATIwE8WJlv8j2NQY1kD+Qop+7kT7coFo07kQtaTVyZ
	 6n5t2KrP2fj8HvkRr4+Rfd9ui64etsmilI106zccck9s8S0oGcYHsuwyeVZSUytaRPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aV53s/thMev0qSzH+ayYeyKX09O6kEW4ly1bV0/xJfs=;
	b=27iRfTwOy0QIg1KQhkBxSB2L2T0YzNG0hS1IZU9thvdfXJbuYDhTm0BtUdNmLXdLQV6Y
	 mtDYlo9Ax/OtZMM+YO7IWd3hA12EKSIknH6ifjANMFCzqy7jDRZ3xP46jB9RV1oaYmDW+
	 36vXmLD9AW+d/zsD9yYw5cDWShd1PYjb1jbR4LZdQ/vHqtlYSNZyzL2Cz0PfCyovcfRPx
	 G/+oS4pyjrJozE6FDLrnQkh1rdcsbSC+6y80tGJSg3q0vhsuvRweO1Rg0yO77Ssz5+xkf
	 WgWgZAFwFVe5FDwcr2zfkkbUYDnyKsDNhsq41pXJHperQ1ogCULr1cbULKSY7uleteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LACHCK6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63B606A31B;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LACHCK6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38F1F01829;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870439;
	bh=aV53s/thMev0qSzH+ayYeyKX09O6kEW4ly1bV0/xJfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LACHCK6OV3GbL6mZehTtgLpGXlnvq6Vujkxhv60FGXqZ44vgROHr+18efgaVrhvXz
	 ikQIh9QIdEGsXohV5PxI8O8jBZtfla/Covtfq35X4XIGQh10dsU1F34v02eqQCqTLH
	 X3xIN+uX5nio0NBrq1B+/ku+3PGU8of3crlz90OuqzPJYkjf90H6bYnAC5ASKWwV6a
	 kX45GCY+jj5Gy3huVbQRWe1CUxK4Ca/ShnSvPYiqQZp27/5kJkh92IJdPlosM8RSec
	 R8uz0NwGH+C5AZo0cdk2fkYD9zSdWDCK8X426JiGwUlu2CAUyNfsB5Pv0nLt1ZDGF3
	 o2yECMtxEYyLQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/3] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
Date: Sat, 24 Oct 2026 12:33:47 -0700
Message-ID: <20261024193351.87130-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024193351.87130-1-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
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
