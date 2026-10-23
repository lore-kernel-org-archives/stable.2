Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722873;
	b=x0xR20ntojMOtJdJ0szIm/S/9/kn0VYjwVZr8aD7PhKZWkYSg8N8RLMoaulih8mO/O4x
	 kH9u5fpel2CjVMt3kF8TiIUh8rmANrveJk9QmsBn8OG3G/KuXKuEZ77YrPE0p9HuQJww0
	 5IeGNK8lvgw1UQwhPrACidLbXZtPpZMVUwDjiH3jQeU58u93+dVB5MIgkWEYPyJbmeS6B
	 PqY//8RNtXg7rDqD835kKmtpr8VP/BN2Q/mPTACRNB5UVYXRbuypZqQqmiqvA/kFqL83c
	 UoO9bTMSUdWFRgELVBNd6G+kzf1H6zCbKDbXV/U+JYpPtXQr7VyLcn+EfQmaGSORHew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K+PeZm9tsGAqhp854CH7k9KBWOkxy9cTCDo0Ktot44Y=;
	b=KfnoMWaankvg1wXNZ0/CLM3piYoWgbH64EvCefXYB59YHIU/tKxYCJLfHHXUhIxBE9CO
	 /ck+wNsdva8EeP7p2BmWzTjm9c6oo+54kXfE1ROmsIdF23yA89kcsXAt8OIMXZotJCema
	 Z0cUIVeGlaOpDdCTUoLxByVQs85s/x5YoO/QDkZh0bt9t7W/RCUNCpcejSzOZHpDMcIWG
	 b4QYw88ruPq3noMG/YYeusFClx4YJZTuP4ygFAEuv5oYlainAs3Ox2PJ5gjuokv7r2jcL
	 3Nt/boXMYAv4//JOJz3RkGwEpQ+cCmy2fWZ20TkjrXSyOnWP4Sf+Ti2HKRnr9kfrmXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODzaKoW+;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D2606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODzaKoW+
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so331936a91.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792722872; x=1793327672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+PeZm9tsGAqhp854CH7k9KBWOkxy9cTCDo0Ktot44Y=;
        b=ODzaKoW+2YuJUQ+vZ9KMdvyXuyk11NdRdz3S3VkA0otksHGLDYoyX8j7rqASnOH3sl
         88LCBxGQfyZYSLx/Rzyf/TthbjifScupo6zH6za8wq/9ZKdcWrJpAax1J/cvPFQRvb+g
         9Jv58lyF5FdUTkfA8qRsGlSmXptO/yoNKicm6HjYgH2z5OOMXEVsroCJ0sRM+5StS8op
         ookltOQGJQbv/eHlSGP6eP2aBeIfb27lEonc+ealpigPknfFnhPlS/qc9SNFnRJQHpf3
         DWRwfVs4TTJMRojk1oGqdtU0VoCr10TgIk76GPIh1XMSbwoWUOBkF5ODskhKgcdXpzdE
         uRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792722872; x=1793327672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+PeZm9tsGAqhp854CH7k9KBWOkxy9cTCDo0Ktot44Y=;
        b=yNeIErctjw9IUX52f/hl0YwdncVe9rWsM3K6zoRXjYqG59j0P1gi7H//4PedxIxmy+
         ihn6+LaX+VBLSr1xLyctvUe5RPLmtBaqbXCHL9s715tKHyIhLdUbBXdP2tKbZToXcOQ+
         KoUmcYWDG10GsGI/628uwzpIO6cfnOuKrdgOn+tqDzVnn7ODzZo6fiSuPn3houzq++Uz
         h6gXs8pd7eIZ7JUBAOHfZSYRuFXoBQHmO3tjB2r2xf7NWJsaLyntJmReng7g/K878nNP
         q+JfDrrbfcvWUe3q071+ZhFl6/J48fZ3D4gZkxno0QU9yxQHhse6q1lne3/KZSufbUYy
         gtMw==
X-Forwarded-Encrypted: i=1; AKwUvBwSEelpMgBEQInFaq2qBYXaqypWLsw5Icw4gR5sECWZGJXtH3MQQgr0DZnzI6Ih+RYdpMDFVc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRsUyHdbBAI1gUCvgrw6gcwDijYsyz9+023J81AmUI5YXEhlwG
	KjzUWWzaG2/A83VGnWPB3o7qZRXUpSjL3a1bMT0qMw0W9lRPUoi4iidKbZMNYQ==
X-Gm-Gg: AYBFou1lLtRSvOMjkJXtG8zJMMb3Bf1zeChPisOQdx8f6R8Qkbi/9/Vy/XcKEtO8TGy
	+OGrJNZ7tbBTAk93mkE2v0xS3orNz1e0oZ8437m5rvLgCWfxgyae4NXzZtlErG6ldpb57robCC9
	96k6zFJJCjnvTVX3lsEQV3pjaBGBIw7fkY4W1KLYHDK9FS7GqDO/uzf2WxAcq2BdGL0RWv3/0WC
	ZiQXDYYq3sB0+fPbwNkCeemDYVK5ZSWRgGOXbMH3w/4RxPhq3MG3mZIQPRlHIaVAbpKFCuqZO+G
	ET+9BkAf0ZZ6FZ+sXuU9YADmIB4nBzbtYHg0TpPc+39LDFtU9IIk8+wxpBeLpsIf4EVl3UIqwTx
	d9ozNdPabqdg6PR/YmiVK6mQrtPB/BtjFoKufiklmZJmsxAWLE9r6iZEWXc4YIDkxacyr/gXYc8
	Spk9ho361BvIAEMOA5Kzhy+f+rsXIHHw4OpSB7wFFGzpf49KSVl3vCWAuA2omG9tN1APFGv6s34
	1MYevRQX1QvQZ+v/i3g+/1YUV0BNM1E3yP4wzMG5XEYE8PtuLvW28ONn8XHNJati675BP+2o9Ui
	n+HE1UgCwFxS8n1feQ==
X-Received: by 2002:a17:90b:5108:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3adce0cfdc4mr660962a91.41.1792722872119;
        Thu, 22 Oct 2026 19:34:32 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490c096sm6544867a91.7.2026.10.22.19.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 19:34:31 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix cluster over-free on allocation failure
Date: Fri, 23 Oct 2026 10:34:24 +0800
Message-ID: <20261023023424.4003943-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_look_for_free_space() returns in @flen how many clusters it marked
used, which is fewer than the requested @len whenever wnd_find() falls
back to the longest free run it could find.  That run is maximal, so the
cluster just past it is in use.  The undo path after a failed
run_add_entry() frees @len, releasing clusters that are still referenced,
and a later allocation can hand them out again.

run_add_entry() fails only when its kvmalloc() does.

Commit 0e5b044cbf3a ("fs/ntfs3: Refactoring attr_set_size to restore
after errors") replaced wnd_set_free(wnd, lcn, flen) here with
mark_as_free_ex(sbi, lcn, len, false).  Use @flen again.

Fixes: 0e5b044cbf3a ("fs/ntfs3: Refactoring attr_set_size to restore after errors")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ntfs3/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index b1c315206ffa..fefd201809a5 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -199,7 +199,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
 undo_alloc:
 			/* Undo last 'ntfs_look_for_free_space' */
-			mark_as_free_ex(sbi, lcn, len, false);
+			mark_as_free_ex(sbi, lcn, flen, false);
 			err = -ENOMEM;
 			goto out;
 		}

base-commit: 3ac032ef6ca8e47bb06d1e189dfcf88fa0a09c75
-- 
2.43.0

