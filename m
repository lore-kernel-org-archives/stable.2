Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596637;
	b=oCXYD9miYV3j9Xqe85lpY+/XBb8ulJ+rgNZlWIOiL7F41DI1/m2dfLNYQXbfcv0rY6Om
	 DVVLxyq3vO/XtIfbEVHAE1vZgQg5iZRmpB319Xdo1SKmTNhXmCi4kRQUb5y4+9zeIhy3l
	 7g/GMDI3Jczu9RV5WvQt7LHOtxoTy++ceOimQi0J2KPp2PaXzVpxN4G2clj4hyLoCKZRV
	 odJQ8r3FKWRqKkSJJqW+0AMpFkvLzbd85q2vXELjIMWvMfogD/+cfGFiQ1xiKzfoHdiwl
	 i1iPirtfySS5ocouuKF1V5QYbmkiaCYqYd7mylxSVtcdrVM1E7qpt8DH0H6bGHCcW8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5AyZlgGYEhR53fEZ7gd0rwv1EEGS5Euv5akgPii770k=;
	b=0slJfxIAtSu1pImIPMUDee4Aqir66z62iiu6oblqHhmqQ0xgHymZcBv1SGfKvZmG3QDx
	 mB0wANlxXBu5zxAO3552gkbv3TLq9MzXntiahSnFVQ5YLkQkr7UGYHSjX38mClMGFn3qq
	 Jv9P7RsirQ8ZgyHXXc06VEZsXx7o6t/1AzVZWbMUyChDx944TRwsmcfcMM1HsIrPIDH51
	 9+WQxu17k+ZXdZR9uaZ8y9HFDEc5kxPBJ1b+SrlUf0vdPAmSPHgb75/2yNYcH5mBc+ymJ
	 Hdt8NfR6hCQwYBJKFURG6F0iyH5kuoj8+J6R2zEBRg6vppSfjPDi9cGdAm94TaxYrYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci9AV3F5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23B606A325
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci9AV3F5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7A21F000C6;
	Wed, 21 Oct 2026 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596636;
	bh=5AyZlgGYEhR53fEZ7gd0rwv1EEGS5Euv5akgPii770k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ci9AV3F5gKsAuyt4hQiZh1rNIdF5Y68Nrsfg2UoKJLsG+ye0KOOdOxFk5SaH6Bvv6
	 WBUV3sKwnmdmvpvTbcz9PXQdzmSHBCatQEBm/Lc9m5dkBnPYhkLO+iyy4AQ+SaIyya
	 ySesUIsJ8HBNanQUF2fngw2jpOlDo9DFrnLM8DzaJEfDatnx3rtOI4FXUbmipffqJq
	 MP3v7s28EXdq/pY0S3pzgeZi1ELgu7G7IDjGvKidLAza0iwrkD264WTs/apmrnWs9w
	 8la05PScPj98rf13+05k3JPglZ5ArzlhNpHtilQU6H/C1R/DAA/MeBWT2cY+Bo2HWM
	 Mp3DQ612PPHLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YangWen <anmuxixixi@gmail.com>,
	syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private
Date: Wed, 21 Oct 2026 11:30:31 -0400
Message-ID: <20261021152930.293677-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021152930.293677-1-sashal@kernel.org>
References: <2026102157-deuce-giblet-3fc8@gregkh>
 <20261021152930.293677-1-sashal@kernel.org>
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

From: YangWen <anmuxixixi@gmail.com>

[ Upstream commit aee4d5a521e94f658e46c904e08a473daa9c8fc0 ]

commit 02f312754c87 ("ntfs3: fix use-after-free of sbi->options in cmp_fnames") introduced a use-after-free bug
due to improper handling of sbi->options in error paths. This resulted in crashes when superblock cleanup
is performed in ntfs_put_super.

This patch ensures that the options structure and its subfields are properly freed, preventing the memory
corruption and use-after-free errors.

Fixes: 02f312754c87 ("ntfs3: fix use-after-free of sbi->options in cmp_fnames")
Reported-by: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cc433e4cd6d54736bf80
Signed-off-by: YangWen <anmuxixixi@gmail.com>
[almaz.alexandrovich@paragon-software.com: added fixes and closes tags]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: c01b091b0641 ("ntfs3: free the sbi after a grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ec4bdaae14114..791d3cc489a42 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -706,7 +706,7 @@ static void ntfs_put_super(struct super_block *sb)
 
 	if (sbi->options) {
 		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls);
+		kfree(sbi->options->nls_name);
 		kfree(sbi->options);
 		sbi->options = NULL;
 	}
@@ -1264,6 +1264,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 	sbi->options = options;
+	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
@@ -1694,7 +1695,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 out:
 	if (sbi && sbi->options) {
 		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls);
+		kfree(sbi->options->nls_name);
 		kfree(sbi->options);
 		sbi->options = NULL;
 	}
-- 
2.53.0

