Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583232;
	b=er0G080X/BiVf/10gMjYUxOK5YbexLEV8xrES8m2125IzWe0swQ4cAXhTb7xwIz+IEjT
	 hWRa9FvR6q1aj+MlKCDiGaUdp2FiHubvqt42uthdT/9uLTQsbZ3MsjRwg5+DXQ4yGiOkn
	 LG5lkZC9iQPq/qMFBU/p9eLYsEmi7J2Jqskket/xKIVjtfupfTS8IpUbtzrg2OfBVI0bL
	 gtnx6VEO8UcwB/GjGFF5Ks0H21obC54OEWoT5sygV8ZkHmxc8ICmZJwqlIUx3dYWONyyh
	 ejk0GBqGU23TCdfp71nYvaA9FP55WFOQTWetfNCABk7UT1Sed6qGEykiASv1wQE3ytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583232;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xBhaq+Hp/Y6GG0ueDyyTHNNwzS/qSmC+5sxCYqoNHN8=;
	b=F/P+eZeN8iZgbzl9ClKcFLJYwirSb+l6iJ48LHk0vmbwSbM5ga5HPXN6ifZ12rUUbmUw
	 8e8TLmMUxjUacbEKTFdOibd2GMns9C/eOV+csE8PRoPJUItJqYQ7fzi7axtVqok0FAK58
	 YOBptarOow4NeU0RkzLr+Xynbpp+39/4qUpDg+2ohlYPuCgAi7qEEi+MuKZ1i6dihAEbN
	 rZvd0glW3gDhqElEd6BUQfIP0xbObQPK+EFLLdueD0DM9G8LJexyoM303EYYgPGtnINKP
	 jcxGojV/thth+bYMjBGfa5E/B+oInf9pYKrlqoKkBzygA7NY+fVjuM/kQ8Hfe6t0uUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg4lEghL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813F606A32C;
	Wed, 21 Oct 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg4lEghL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4EC1F000C4;
	Wed, 21 Oct 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583231;
	bh=xBhaq+Hp/Y6GG0ueDyyTHNNwzS/qSmC+5sxCYqoNHN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kg4lEghLeRSllYG20475Yf8QiziSosCP43YiwoDC1OX+ONw0KqlsR/k6+np4qlrLz
	 kP2o1H3S+8gkIM29E9lcOIx5ovyaCSt5bW9LCvf6kHIc2TphQ7WiSazLBDfdiRoISS
	 Miz+0ELEC1Gs2Spu066eChpT9UYegOhJUTATtUzPbw4AfniqOTmN6/58xpXKgpt/qx
	 fQ/7q960B96RrR2LAQL177k4icUUbg7SMio2gTU6VMKcoDg3Y3Vif6YE5uzznwbRZQ
	 RQZYxl3zDMrdr1TDtG/3kqddIyGIVpKusOJtimeIXiILn9qjNZXdkPxvmsfzOsbUls
	 zmt8NJQFHl6VQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:56 +0200
Subject: [PATCH 3/6] listmount: don't wrap around with a U64_MAX cursor
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-3-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zL2mGinbLKzrfxLe9+IFadCSq8H9JbpaiFIaP+FSnio=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGbc2550KSG54O66hw7MIuG5cpOORO9saKyf3hB35
 XFJuv7ajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInc+sjwvzbtn9KVg9UWs9Z4
 Lm67cUXKedp79r6sgp73b7aaKehkVDIyPL81Ne/Miv5TTLrPEhe5JjoJlQfd8/p7anlgbUbH/ZV
 LWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_listmount() takes the last mount id the caller saw and looks up the
first mount after it by searching for last_mnt_id + 1. With U64_MAX
that wraps around to zero and the search finds the first mount in the
namespace. So a cursor at the largest possible id restarts the listing
from the beginning instead of ending it. A cursor of U64_MAX - 1
correctly returns nothing.

No mount will ever have that id. Mount ids come from a counter that
starts at MNT_UNIQUE_ID_OFFSET + 1 and a caller that only feeds back
ids it got from us can't hit this. It's still wrong. Nothing can come
after the largest possible id so return no entries for it, just like
for any other cursor past the last mount.

The reverse direction isn't affected. A cursor of zero is special-cased
and anything else is larger than MNT_UNIQUE_ID_OFFSET so last_mnt_id - 1
can't underflow.

Reproducer, unprivileged:

    #define _GNU_SOURCE
    #include <errno.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <sys/syscall.h>
    #include <unistd.h>
    #define LSMT_ROOT 0xffffffffffffffffULL
    struct mnt_id_req {
    	uint32_t size, mnt_ns_fd;
    	uint64_t mnt_id, param, mnt_ns_id;
    };
    static void list(uint64_t cursor)
    {
    	struct mnt_id_req req = {
    		.size = sizeof(req), .mnt_id = LSMT_ROOT, .param = cursor,
    	};
    	uint64_t ids[8];
    	long ret;
    	errno = 0;
    	ret = syscall(__NR_listmount, &req, ids, 8, 0);
    	printf("cursor %llu: ret %ld errno %d", (unsigned long long)cursor,
    	       ret, errno);
    	for (long i = 0; i < ret && i < 1; i++)
    		printf("%s%llu", i ? "," : " ids ", (unsigned long long)ids[i]);
    	printf("%s\n", ret > 1 ? ",..." : "");
    }
    int main(void)
    {
    	list(0);
    	list(UINT64_MAX - 1);
    	list(UINT64_MAX);
    	return 0;
    }

Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM:

    cursor 0: ret 5 errno 0 ids 2147483651,...
    cursor 18446744073709551614: ret 0 errno 0
    cursor 18446744073709551615: ret 5 errno 0 ids 2147483651,...

After:

    cursor 0: ret 5 errno 0 ids 2147483651,...
    cursor 18446744073709551614: ret 0 errno 0
    cursor 18446744073709551615: ret 0 errno 0

Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com
Fixes: b4c2bea8ceaa ("add listmount(2) syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6c9c0cdbe890..dd60123a0cb0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6253,6 +6253,8 @@ static ssize_t do_listmount(struct klistmount *kls, bool reverse)
 	} else {
 		if (reverse)
 			first = mnt_find_id_at_reverse(ns, last_mnt_id - 1);
+		else if (last_mnt_id == U64_MAX)
+			first = NULL; /* nothing comes after the largest id */
 		else
 			first = mnt_find_id_at(ns, last_mnt_id + 1);
 	}

-- 
2.53.0

