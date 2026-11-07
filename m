Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046890;
	b=3J4+DIEzkYGawkiHow/oCgY7ut595o8tcL+3d4DnoXaeqrzD1u/RXp8dvY3IRPkXMdmZ
	 rws3huOjiTpi3U47AsqbmaDVDcIa31Fg01tjZ3WE80aCl8J7z5VDm1VtWdP7+61nyY1iz
	 6w13H/24EPHl46Mqi7RRG11TGy4XEGc02mDnlLwqUxkImNUNydWX33BecF3vRPX+2yLWn
	 /ee7gLs+sA61szCMSSojkvs23eGZdbC2lq5Qy0vrNfteCk58jlvT9wMGq3SJ4SwPma12X
	 risxo2Cpw954VRlW+tzr4VwMw/g8RqRcT3mYNFdCbVOvekr+DLynLijdxfaImNltY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ugg3FuoEk8VZLvtf1jfToOjKx71PLtjoqn27J/L+oB4=;
	b=zJcZLY2gfsN1YjhLe3u/3m0Xx+eblwbRcDRkW4Z8nemAnbSZiqFI+XUY/rM4nqDEFous
	 jRbhKWbD7Oxxb7qc3Uz7UU+eBCRlN9rDkOfjyvyTTlL6YZ4ron0BrIhNF5KL1mw0KGz0X
	 6nAvoi1KF0bDCZZOTzkruGd7Xl+DDQ36w+x/MSjPb1CzyiDULSqFHTkDPucoE7vxUoJ0J
	 Ll69QfgTL9IrIQV1310j8upzuE4aNgzWMNr5YWoolEu3UMACvr9cOs2kARBQ5gAaBLZQO
	 KWrEV1/RzR5aUy31GFeWg6GLwmpnunXmNKctfNkSJbXG0/joDJSj/6KaropQn7Ia3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDBd6pvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81D606A33C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDBd6pvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A911F0089F;
	Sat,  7 Nov 2026 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046890;
	bh=ugg3FuoEk8VZLvtf1jfToOjKx71PLtjoqn27J/L+oB4=;
	h=From:To:Cc:Subject:Date;
	b=QDBd6pvcSSTHaRIXDLdyCXfKdKvplZCEfe5+520tyxdos0s4cZkuu2hFJKWDmR65w
	 vf4bney/8VL0DcbY0ilf9wNvilRggVrlNU9PvstqNw7XmuP73uHgla2gbEtDsRAvsY
	 Lztucv+G1blq8ikblyk2zo7lbZBZ2DupXAW2isN9ToSlAjlCDce6c+LsS4yuEwqMiX
	 xHrTaX0N29zrrQQzzOtJMQfuq7NqylM6c5Do8H2/CQGWjDVyr1qTg2UH6JyEOzTnue
	 tV62cdI1cR6/8lNBQHPX9t2SoQzZEffxZEPEUDlQ+acE/1HPUv2efWGMSwpR26pzYd
	 2G4h8mm/s+gNw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:28 -0500
Message-ID: <20261107052128-failed-6.12-1bfb9384ae0e@kernel.org>
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
git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052128-failed-6.12-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1bfb9384ae0ed52d61eb601b655014b7815ff849 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:21 -0700
Subject: [PATCH] mm/damon/core: disallow max < min damos filter range
 arguments commit

damos_commit_filter_arg() receives range arguments for a few types of
DAMOS filters.  It allows any range including max < min range.  It is fine
for the logic, but makes no sense to support it.  Actually DAMON sysfs
interface is doing the validation on its own.  To avoid duplicated
validations in multiple DAMON API callers, it would be better to do the
validation in the core layer.  Add a validation of the given range.

Link: https://lore.kernel.org/20260914142327.92510-5-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1932a50252079..5fdacb9dcee5f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
 		dst->memcg_id = src->memcg_id;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
+		if (src->addr_range.end < src->addr_range.start)
+			return -EINVAL;
 		dst->addr_range = src->addr_range;
 		break;
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->sz_range.max < src->sz_range.min)
+			return -EINVAL;
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
-- 
2.53.0




