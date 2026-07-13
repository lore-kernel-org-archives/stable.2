Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5A3859EF
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980581; cv=none; b=fkNhSGUQeqRA3JhGiw8/b6Es+NY59M74yIl5uR7vmhQb4kGONrOZWjtqJY0A9WdvLal00yy1QM3AVywb1rc8ho9tREgyzxPwxWa/mIGDC9TDQr/e3mNpYdxUT0Jj5o9NYZnJLXV9vFFuFHm37pUDZaNZV07istOpzV80kueGt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980581; c=relaxed/simple;
	bh=C8NuRA1bK+uMRc7JGADbgB4/9ze8opAmyCE9C/B16oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cueGPtByHHiQ8OCE56Sxnm7d2E/3dASQg2P/vjCv1m913nOyOKM3lDFJoJjqsZ61gUi8tnC2dr9GWqxcwVNLRpuxVI1DMWpOw/zKe2+wgaVQ8WxOuN8VoU0Q8ojWYBAA26Kz9JGKTHxgMmKUTuaHdMUeqrPFwBOM2dkivnGsClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrStKM1f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrStKM1f"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f360851aso64587466b.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980575; x=1784585375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SLPOn2YuKONJXi+Hnfw4ZUtdFaaFI6SU0Sk3qo96J30=;
        b=MrStKM1fCL6+FUoBZL3b/UfmtjAHu5wt98pzb5NbP4R7whCKED1hbUfBlsFPVRv95H
         4y0YsCKbV95wCDKoTTCJBvgWkO0rfTPVfOpBEkM4sQNwrJNXY7xDnmrrLrKh0/AEzD/y
         yLmlUl2JL/ZIiIk8kAT/saUeAFKHTJQlHfyPOHoaZp541s7NBxSt13O7NsP/A/KGE9rI
         o9FbBHWkh3oEvufz3Q8dzWZEbp5N6snyroaiJXQqEO90QkG3UudkHNu8TqbkDAGIWpac
         jde2LbFvjkWvL6Olx2FzS07rmSDF8T5QddKhhabqFuX01GubqgfbAtTF1O7m9/oEfQiS
         eFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980575; x=1784585375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SLPOn2YuKONJXi+Hnfw4ZUtdFaaFI6SU0Sk3qo96J30=;
        b=c0uUGUSnoLn6MOGISxyj+TZFZ5AgXHoARXPHotHwlca7tLgJxFutU219z4odHpyBMc
         GOD8AM4Y2DHHbavNmJmwJGMOAQgvuh90ePDtZbPGCyadRy4c1LdoikB1+lvh+skGAtV3
         09Wuxs+rW0Ul90mf58Ka2oME2JqATDddHq8i+tNaqEu7aAREs+UtIXCsN57E/onlD9AV
         EazVt2RKFnnJaEqwaVj9ME5dTwS1J1IpevShUCbPvUnniu1H90J7eG//U74sNX4oVcRQ
         Fwdh1GoCpQSOIzb1OxAbTWuWhnLbAxI+n+7Zotim3yDflKRNEM6Ao0j6v5dDaCyvDdDJ
         AzUw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7rg4hgB6EDt/WZDL0CfupHSgp2O+H6khem0rBz5zDe3eBcaagnpbGsvqLHKn43MaNvj+b20g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0Qoh2Wo++JLU8QH76DJAZzK/m/yvPEeszpeA7vbD1CtuU4tC
	dFy+S1pLPDzU8K4KauwUfBhjJPdnTjeXVz/RkuVZRUHugb+M9nFW6HXQl+c/uvVOM64=
X-Gm-Gg: AfdE7clt9ahy4w5nXlFtb9UyvkQqKuTgiNdxzx2cmq/iaoJ7aC8WRXkyNG7X+HDweyJ
	B7htKDmk9mlM4Yn2Vrr6OaBsRFD5ozuNDATIeCShVGYshoXeddcv7TTByOTfdszlDKNqM3LTscS
	6zzY0YsvIjLedGvkdbCGzeOfT9zxxcWIVdG7F4NbFVmUXQ/xMtTk5AauVCovPJCa+PzgR7I1bRn
	9ld7mLPc4/Vz1zg0IMs9ROgAtFAUkyeuGOMZ4fXjn5tLCeIeToJHdYMbPRM8aiR0S+F4ZAlbGgL
	pq/V4uvo0bIIYfposTDfCm4Kxo1mVrqWsGg8zOmpFBFXXM0+fmrV5uI+vcFAZNMk99u2kfieBX1
	ctb6rqkAWbcXZC00gZAQ+Xk0uYPmfxTLKJ0uEGeBqDy7FqSKei+6VbiGFUZoSG1TB3a8z/yvMeg
	jOZ30BInsk0tEHg0LYqI7fmlP8k0fl0ZPOyB4p8g==
X-Received: by 2002:a17:907:2687:b0:c12:7e9f:5ae3 with SMTP id a640c23a62f3a-c161e98b466mr509056566b.15.1783980574648;
        Mon, 13 Jul 2026 15:09:34 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b1a1011fsm1046734166b.58.2026.07.13.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:09:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
Date: Tue, 14 Jul 2026 00:09:31 +0200
Message-ID: <20260713220932.413004-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713220932.413004-1-amir73il@gmail.com>
References: <20260713220932.413004-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACL_DONT_CACHE state is meant to be a constant state for the inode
for filesystems that want to opt out of posix acl caching.

Commit facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
used this facility to opt out of posix acl caching for fuse inodes with
fuse server that does not negotiate FUSE_POSIX_ACL (fc->posix_acl).

The commit also takes care to gate the forget_all_cached_acls() call in
fuse_set_acl() on fc->posix_acl because there is no need for it, but
there are other placed in fuse code which call forget_all_cached_acls()
unconditional to fc->posix_acl and those cause the loss of the
ACL_DONT_CACHE state.

This is not only a functional bug. Properly timed, a get_acl() from this
fuse filesystem can return a stale cached value, as was observed in tests,
because set_acl() does not invalidate the unintentional acl cache.

We could fix this in fuse, but it actually makes no sense for the vfs
helper forget_cached_acl() to invalidate the ACL_DONT_CACHE state, so
let it not do that to fix fuse and future users of ACL_DONT_CACHE.

Fixes: facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/posix_acl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index b4bfe4ddf64ea..3dc62c1c27087 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -93,6 +93,13 @@ static void __forget_cached_acl(struct posix_acl **p)
 {
 	struct posix_acl *old;
 
+	/*
+	 * ACL_DONT_CACHE is expected to be a "const" value and xchg it with
+	 * ACL_NOT_CACHED would enable acl caching for the inode -
+	 * clearly not what the caller has intended.
+	 */
+	if (READ_ONCE(*p) == ACL_DONT_CACHE)
+		return;
 	old = xchg(p, ACL_NOT_CACHED);
 	if (!is_uncached_acl(old))
 		posix_acl_release(old);
-- 
2.54.0

