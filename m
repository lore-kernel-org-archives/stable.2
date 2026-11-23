Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446069;
	b=wesbos91dhvXZxl+PpbilDGzaREVy7vvnfJRa6IAQOr0XEkigg721YM4dQL0oblxP3+3
	 6g+3e9s16DYmGxPCSbDrEitsBS24VhjC8+n7tH1WnrWtmmFEGrTzJkOdzKP00sOFYWk+E
	 pMtFDoGuawm5571GdSipfe/jy7WPQHIw31J81LN/GUMqpQ0NBbO8gh8VLxf2ZxYqeHJfF
	 hPacszKdGmvwGkvDE2s5Trt/HIiHilqMyS7+ipTksTavIuaIsRZqe4YtvtP8718YwqVqW
	 +R1nImEbk2Wl2HkUrPi1RmZfx1fZPKetbUsXjxQ2Z91jPLbiPqQBLWJ8PSQpZhlj+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8up+ChW7Qsjki9eTuIEICGRZ3EGbMsHsimy8g5WL5tQ=;
	b=ST5pla6QuMLLjYFZe+JjXKNFy5/1W1oyXVh6wSMKHMgWYW5209H5Ox0akPpnIQPz0v4M
	 N1bDhjwDWnl28MoQAoQW6aCgaOZCQyxnU6MWvp2JTDrlaA2Ii2yHnZHD3ROdHVWz2inqW
	 MUWR7264s5ZVzK+oNtzWrS2c0wrtBt8/QVtyJPH6r0COxeOEBffgo5uUhgYwtWxrmLota
	 5rpuUu1Vh4HPx5zzStDdGNL5WkdJngdZwcqo7q2UzvijKgb4DBCKzYom+Y9HvEJYOa7AP
	 YI+OGsyXNU6lXWrnYdvY+H9LyGACxxbtCott4w2lh3hLm+F+3EAzoUu7oCgk7QdhQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdmdSugz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AB606A321;
	Mon, 23 Nov 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdmdSugz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D670A1F000C6;
	Mon, 23 Nov 2026 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446069;
	bh=8up+ChW7Qsjki9eTuIEICGRZ3EGbMsHsimy8g5WL5tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdmdSugzHZZCcWuN2gDwiGu0jKBzhwbjltPTF1SlrlZ+0UHqirx6FFIS6npuQ6KDg
	 dJ/rrJ675rVKR4qm0MD9cRxuL2JyJjtBkEa/+pV8s5qdNCE80X2NqxMHdglC4sJEmV
	 czkuwJRfxnngk0ZHKJLBvJ24AEhvetCIFS2IWbUaf1DeIG9ML7C/87vda2ABPfDVNK
	 JR8QuFDKDPvYUOXuyw0GAJSFZN2td4EB6uVvnDFytL3uCY+LMbTqcrz8/eNiNr/iuU
	 FWi7SoPy2tuwp1EGz1js0ohggF11MWoGKvBEXy/dQCAyY4RBCO7wMXrIbo2OqmGdSD
	 E9dlPWTrdTZFg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 2/3] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Mon, 23 Nov 2026 07:00:47 -0800
Message-ID: <20261123150049.81317-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123150049.81317-1-sj@kernel.org>
References: <20261123150049.81317-1-sj@kernel.org>
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

From: Yifan Feng <evanfengff@gmail.com>

kdamond_wait_activation() cancels damos_walk() requests while all
schemes are deactivated by their watermarks.  But it returns without
waiting when the watermarks check interval of a deactivated scheme is
zero, which is the default of the DAMON sysfs interface.  The kdamond
main loop then runs with all schemes deactivated.

In that state, kdamond_apply_schemes() finds no scheme to apply and
returns before it calls damos_walk_complete().  The walk request is
neither completed nor cancelled, so damos_walk() waits until the
watermarks activate a scheme again, possibly forever.

For example, with a scheme that has the free_mem_rate metric, zero
interval_us and a high watermark below the current free memory rate,
writing update_schemes_tried_regions to the kdamond state file never
returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Cancel the walk request in kdamond_apply_schemes() when no scheme is
activated, as kdamond_wait_activation() does for a non-zero interval.

Link: https://lore.kernel.org/20261121025626.75981-1-evanfengff@gmail.com
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Suggested-by: SJ Park <sj@kernel.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20261121025626.75981-1-evanfengff@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/r/20261118235012.14859-1-evanfengff@gmail.com
- Cancel the walk when no scheme is activated, and leave
  has_schemes_to_apply as it is (SJ Park).

 mm/damon/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a98..2748f91999240 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	bool has_activated_schemes = false;
 	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
+		if (s->wmarks.activated)
+			has_activated_schemes = true;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!has_schemes_to_apply) {
+		/* The walk cannot be completed while no scheme is activated */
+		if (!has_activated_schemes)
+			damos_walk_cancel(c);
 		return;
+	}
 
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
-- 
2.47.3
