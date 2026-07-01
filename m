Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0048094F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906286; cv=none; b=cvlNGuQPyNefUKvuXsXmBf7SxROIPs/FoCCWLWH8N1V2nHFq0WLUkdpXnzQIG+vjw2bYRqKjWT63F4azgu/vPPDH78StURVQmdky8z5a1Fl6WlX53SHQB8nT49v2RnJh4D1emtM45kDwfmyp9rZSYnj6WmsI4d8oSpU8hBa/W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906286; c=relaxed/simple;
	bh=Bn7cpK7c9P1Ng+xQTLrX5oRSvaP7UkoJRFYhjK+iQcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GP8fUwHULmg3joGecsQmG3gsGmAwFQo7eUj0fZbkRBfWsfQRCjgcxsBDvG1RHrijnnfztDWObEtVQt87nwgHtUAql4gBEzLJqpEBTOwBbD1HXsSrYQfk/jpeDwjcCV1Z3lasEX/H9uF/eytExq205GixaEUa2WGxeI3DTGX6vHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=C0e0vY33; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="C0e0vY33"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso17144026d6.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782906282; x=1783511082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWuXB5G6o/EOutDklrz0KDK/EngRzHI91oIWGAEJRck=;
        b=C0e0vY333zeAMCS/zM/pqIYUkT/ypLoAkXN5K7p8Sd3JoEhBloB5jC3LghM1QSXQ53
         9v/SHNallheASGhxKVytCtMb5RzQxCr/z+JoeaW3Cn7xpeBBlNC5ewKyiDfA6KEXV3ng
         8QEc1DuOO0Es0pbUn4FR5DeNdATltUAdi0shnf/eeM57mwBEDjatSQaNcaVQbmWeDDHl
         JER10VKk8fQF8KFQ20MTcP9TK9v02gKqj78yRWZwXHccz6oFQ02plz5WswNqCOqP5rWP
         0LdKX9rZJONPayNPmWQuBmzK4U8ITV8FnwWf97bqDM+rEOCLj92O1wDrGESr6xf0HZwd
         9ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906282; x=1783511082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWuXB5G6o/EOutDklrz0KDK/EngRzHI91oIWGAEJRck=;
        b=CLC9PffQj+g+GdohitP4jWOupChWhPvHBIqpxiSAb6+cCad1RhCF95IAeB5+e65IM8
         eJYB+1BxD9plUKskLhjaV/9kLRgo+tUsh+KXKaGHLKJHi4NgAvRpGwdhgnnGauU8kPy0
         GkLF9ha39o4zjJxtFCW5hhFOVaBVBvMqdGDQckAdvyAeHCyi1Jcr7T0DHxyPXErphobY
         YfsfCabmNPiOpXgFmuvUOZZVO3wUYw5Uwbk6ocMrA1B4CMUoXqBiRPeVDoetXW3M4rNU
         hRcnSBxOr3QviaTPICa2stzDIPwuhcOjBhi8M4LcpjDxnM667EI72EDO5YpxQtBQpa6w
         Ucfw==
X-Forwarded-Encrypted: i=1; AHgh+RqbLCLE75VjQyNwz8Q96AMsjYBV8QOSdjbPZwDheMerC1bCYqVl0/Vq2XBWlupz6FKcgbnPAto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2VS0FiT84h6oIWmpAtd8LRcbfzwRFuFIdnrY/g7Mk7litu9L
	dtoF/vVsk//WQ+eptHwBj+YNuRv2HVjqlw7q2Bo0psrnLG8N9bl1KR319Sc67728vw4=
X-Gm-Gg: AfdE7cl/3PYYRLexBQnnZJpvVIf/vHq8qNBe+u7N/2R0VwjU0f7YzOuuz+FooQWuGeV
	XCcs3V7Yf91PBMoiKvmGKs3Fvy/BkFtR7CU2DiopUGr0lQCJNNvahUd34cSSrpU9cULKH3l4rpt
	/vwQofapl/JbWpb5/RdJZMN9lbzdfVDDeAW2bZTzrrNzo5Ob2p6w35taR0p4WzP42/SglPukIrT
	7mC3ZEFK/CJ9JzVDTmwph1PYQtWZSs8fFyKyzkxbpUmTtjNY+tsbZAqVOMRYzvp8ZO/Bg4DZ8qm
	3tWoguCTM4/qVbhJmMFBPFyPAsiNqPh5gyxJ4BunRQMQdT+dDqZx7R/qelMhv/MpO5X20E89B9Y
	rBBSmv9n9NTPM9qKiV2FBCQzK9KjuNlV/Se/+GOgTbLWqC2t7cytqak9bAt8pbdNGnA7jLVhfdr
	sTZ894EXEgQzCskeeFnw==
X-Received: by 2002:a05:6214:4e90:b0:8e5:8d7b:5188 with SMTP id 6a1803df08f44-8f2526fa04emr73202606d6.9.1782906282086;
        Wed, 01 Jul 2026 04:44:42 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8f3611dec91sm19921376d6.29.2026.07.01.04.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:44:41 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Lee <david.lee@trailofbits.com>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jann Horn <jannh@google.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fhandle: reject detached mounts in capable_wrt_mount()
Date: Wed,  1 Jul 2026 11:44:28 +0000
Message-ID: <20260701114438.24431-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent fhandle RCU fix moved the mount namespace capability check
into capable_wrt_mount(), so a non-NULL mnt_namespace survives the
ns_capable() dereference. The helper still assumes the later
READ_ONCE(mount->mnt_ns) must be non-NULL because may_decode_fh()
checked is_mounted() first.

That assumption is not stable. A detached mount from
open_tree(..., OPEN_TREE_CLONE) can be dissolved on fput while
open_by_handle_at() is between those checks, and umount_tree() can
clear mount->mnt_ns. If the helper observes NULL, it dereferences
mnt_ns->user_ns and panics.

Return false when the RCU read observes a detached mount. This keeps
the relaxed permission path conservative: a mount no longer attached
to a namespace cannot authorize open_by_handle_at() access.

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5
---
Bug found and triaged by David Lee from Trail of Bits.

Trail of Bits has a minimal PoC that triggers this crash on a custom
kernel build, which can be shared further if needed.

 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 1ca7eb3a6cb5..f8829231e3d7 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -295,7 +295,7 @@ static bool capable_wrt_mount(struct mount *mount)
 	 */
 	guard(rcu)();
 	mnt_ns = READ_ONCE(mount->mnt_ns);
-	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
+	return mnt_ns && ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
-- 
2.43.0
