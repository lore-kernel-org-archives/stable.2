Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0243D4E9;
	Tue, 16 Jun 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622546; cv=none; b=CX4WrNfRdSaC7b4vUDK4XouJTqFa9VxtK+Osvxhj4HPYEihVvQxPiWLqiWBmoPZNp7t17i/JfvtR/Pg0eWeb1SdSNwv15383+8OhOWOix/SQLHnc8yonzaoT9pljSYiYCpYGzTGil+11c8oG70NL/kV3R8dqAsk8cOWNFMPcHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622546; c=relaxed/simple;
	bh=acW7hktPrkjmeTJ78kWIZn3k7sRe6LTbhZJLe5QQPwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K43/EwOeosQddpFxwjFqtKigSHhmHJ48UrtJ3JzuVSlaAvufFK3Gd7qwYf21YYJ8OAqzuUxivTVVdMVJ+RwGeaLV/ml+gxvR0wv4RpL0PJnZMQdI3Yd0+NzMUqAc3uR4Wh0KT/dkciuxcTAhUs313rWx43XvdW7Jl0r3sJ/cd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAD3K1Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAD3K1Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BB1F00A3A;
	Tue, 16 Jun 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622545;
	bh=00MzoIwtac4VFel31/R2yWbFIq9F4yBooTF10PsQck8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FAD3K1Md6YPb/FpZc7cRnt2LdPzWoHZVNpKj1Fi2O7ixVXExB/n8X/V2RWXs3KfRC
	 +JiZfdrK9FmXXISraXz7Px/hRnj0PaAL631T1+KiQty2/HqHfOePJ1AmZgRmCh7e0v
	 YCB0N08ZURLiUIR6qoEdFp3iiQb9RRjHHH4WJ0x/KoK7REOLi4nI2lL5pR39LCDqVY
	 8Yo51gmlzavLMXy1PWF+2vnqnIM7e960gHlbQCC9lQJ2MyzT9Pdr9mtIPK9UPXEQJu
	 kBKhCpYsnGNffF5BG613VMupeTblYkWwYL4GcoPPZVquWc9tsBIcXkkUKS3baz2mBs
	 jQAZ8ei42+GoA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/9] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Tue, 16 Jun 2026 08:08:41 -0700
Message-ID: <20260616150844.88305-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme action destination directories by adding
kobject_del() calls.

Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 737638be84f15..108f6de32f8c1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2148,8 +2148,10 @@ static void damos_sysfs_dests_rm_dirs(
 	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
 	int i;
 
-	for (i = 0; i < dests->nr; i++)
+	for (i = 0; i < dests->nr; i++) {
+		kobject_del(&dests_arr[i]->kobj);
 		kobject_put(&dests_arr[i]->kobj);
+	}
 	dests->nr = 0;
 	kfree(dests_arr);
 	dests->dests_arr = NULL;
-- 
2.47.3
