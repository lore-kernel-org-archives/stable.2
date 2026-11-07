Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047151;
	b=nlvUY9Y58pkYZbZvZyUWNGI31PfuckuwRBizTWNn1DGeIqLR75YEhTZ5pzEkmNmVHxUx
	 468EmRCHbW7JJvqgzVUL7OMVCG+yaOmbt9+jeu428SGF/HPXkMDTjmxNXTXL3s2voIcWF
	 TqoKYLosZ2GZxR6ELxoAImy0mCja/lIw+7Dd1XG0V3E4RzwW02U1oJ+EpKlKJZsuWnS+4
	 GMgNqi/55dHRQIZRTOB/+yP376vZ5MbuRnHndGDVLfLw8zMZA7ObU/hiPlO97Zm9H9eI9
	 dmb+YtAnLUuqKFW9cMo9Vcbn1I7hVmKd20di0nLy2bbqWAZZlpJAqKWLyfCF75mDX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XKeFpZjHVhkkye1Wk8FGXGDbY7yTrxxRHWFB/NbtFfQ=;
	b=p7njzpsn4nm+1DqKyOWT+3mgaxKC3uscCFZBljDICywoBOF8VQC6fjw0c3JGVA+PejbS
	 FhUpHAP0gXcK6Kw2bHhCi6Olbp4pCBwv35Th3QYkRdrGLUiBcgx1lPQy08D/c1nDEyTlW
	 sqKJzGjH15AVgdUYlOFUf7CIceZV2DEj3pKTd54ZF52AlELRzWNZSm9aavD7ZHcfnvleW
	 PfX7wWx6Pv2UpGKDp44nqyEalUc9H9Wfo5TrADzx++AVswVrkhPUSLxzCnidIvyl5ub78
	 9Y9f8PYOGXu3MRU43HL1ciPwHiJVdOx59xcepdywn7swuj8UxfDKImsU+OiaWxP+kOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASNz72T1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASNz72T1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08461F008A1;
	Sat,  7 Nov 2026 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047150;
	bh=XKeFpZjHVhkkye1Wk8FGXGDbY7yTrxxRHWFB/NbtFfQ=;
	h=From:To:Cc:Subject:Date;
	b=ASNz72T1NdfKXCMlXnRfTUkbDg+2SxGTF4zjxdpUKX2q42V7i9VET53b3pKYDCtXw
	 41+q6tPxtcFFMjUTDhg8Udo+vr0T7di3Jeh/26j792H3w9Rb5+i8lqYE/t8cI3edUQ
	 TOk3tM1i3xjDka+wQ9J9r5QioPAY4B95jc36NbisequNvQx3LEPd/4ghURLJv+oUhs
	 aned5D7Bm0qtl/Vu23bSrgcowzt844KSSzfIORN8uGyiEKfPNPG/puLrHYqUB74Hn1
	 DzKw09H/rquWyd0EDy8aroCExGEe9sdlrsmhHDnk3wWfjEiK1KT6LkSDUnEarDNu7n
	 guEeq8W3LYvCQ==
From: Sasha Levin <sashal@kernel.org>
To: ckan@cloudflare.com,
	mfleming@cloudflare.com,
	akpm@linux-foundation.org,
	elver@google.com,
	andreyknvl@gmail.com,
	mikhail.v.gavrilov@gmail.com,
	calebkan1106@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] stackdepot: stop preallocating after the final pool" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:48 -0500
Message-ID: <20261107052548-failed-6.12-8f56ea8e0706@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8f56ea8e0706d92774603260779c7032f03ef3ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052548-failed-6.12-8f56ea8e0706@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8f56ea8e0706d92774603260779c7032f03ef3ac Mon Sep 17 00:00:00 2001
From: Caleb Kan <ckan@cloudflare.com>
Date: Thu, 22 Oct 2026 09:33:30 +0100
Subject: [PATCH] stackdepot: stop preallocating after the final pool

depot_init_pool() decides whether another pool is needed before it
increments pools_num. When it registers the last allowed pool, pools_num
is still one below stack_max_pools, so the existing comparison clears
new_pool.

With new_pool cleared, stack_depot_save_flags() can allocate another
order-2 pool after a lookup miss. depot_keep_new_pool() retains its pointer
in the global new_pool, so the allocation is not lost. However, pools_num
has already reached stack_max_pools, and depot_init_pool() rejects every
attempt to register the pool. It remains allocated and unusable until
reboot. The non-NULL pointer prevents later saves from allocating more
spare pools.

Account for the pool being registered in the limit check so registering
the final pool installs STACK_DEPOT_POISON and prevents the extra
allocation.

Link: https://lore.kernel.org/20261022083330.3159793-1-matt@readmodwrite.com
Fixes: 31639fd6cebd ("stackdepot: use variable size records for non-evictable entries")
Signed-off-by: Caleb Kan <ckan@cloudflare.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Caleb Kan <calebkan1106@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index dd2717ff94bff..90c52f2e0d3f4 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -323,7 +323,7 @@ static bool depot_init_pool(void **prealloc)
 	 * NULL; do not reset to NULL if we have reached the maximum number of
 	 * pools.
 	 */
-	if (pools_num < stack_max_pools)
+	if (pools_num + 1 < stack_max_pools)
 		WRITE_ONCE(new_pool, NULL);
 	else
 		WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
-- 
2.53.0




