Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486318;
	b=0PPO2ooQd2PFbaRHxya6GvtKWTSrGOAojO+rBZ67FszAj9yEEAyK6F/1R0LvsBMelb18
	 zuJz4QrYShjzRUkBOwTLV7oxg5AIbxN04b489L7abZzUMZpmFrIMVzeo6/Lggrt4kL/Bd
	 YJJyJkTLod1WiXmGfxIwRNhCLKzBkEEbjFox3L65E9mzMy5cVZLBYfA38TFA31lLN2PhN
	 B4vuD/bXom8BG8DUmNC0pwSAzrwqA/oQLWLKTmHhwkPjxfdXPm/20q381sMG4e1pacofQ
	 8JiJRR3dCV68KwYtD4F+L0cJ48ddETepmOxs+mZfLZL0EpajdSJSLcPvQ/5L6PEHXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cWdLX60IifZyu31DTGoe2jXMYapJ73Gd4ive+HkR5Ps=;
	b=uVmS03CN7ZZiaWUZtg/Nc1DoQJOhL2/AfCSrWEoGpOTDAhhAX95D8DrnCe/ITSEHlAXI
	 6A4W/Rhu7imQqaYN1pNkxdFcvPA0b8tJTpblY45KG8XoCi/4v2sqlzDHf+OUkiTYiC3G4
	 Rz9OzOOYDTJzCX2AGnUouE/H9Lg/HfTiqJwJZk5g7Lc1X4cV9uBxBQHFR8R9vlXw+zkVh
	 +sh460l/ULqCq1ley5ArgnM9DukdZpsICgRjKR5nujxmETg2YgdJ3+hsQVMTEoM3lJRHP
	 mHcPL5b5vaZEXCz5+B5K3tiRMZrogNdCHQEkk/vonkFWe2oP6Dfr1h6A/LXMNlbvLag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gtEMj/sn";
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69527606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69527606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gtEMj/sn
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b1a38a5088so97170a91.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486318; x=1795091118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cWdLX60IifZyu31DTGoe2jXMYapJ73Gd4ive+HkR5Ps=;
        b=gtEMj/snNUiwfVvBcfd8uy1izMUswBRFrjZ6O0YiRzcLyKlwx/h+55VEXDR7VSKYWI
         u/kezgl2dk6sJchQm3OY4gho385UHYtN5nmYx0x/SM2nAIHQupODJRAfYgNO70A/wgkX
         DP5T+EAHrhTHshdtCIQspeYL7ZrkJqVklKbkdWVp7NjAEf77FgDybLdLrUJPo2Sh6QxS
         lS7QglYF28SevUvjNhTn5VtuwJNmMJHO3okjfAYG9UOsnUv1Si8LxurzAmsMG+z6FZbi
         ZF2CWdA8qGtqm8u09to6fz838TNlJYCZs8kxBwuIhCWb+JefQwcSvUAd40z4Q1QKooCI
         mqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486318; x=1795091118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cWdLX60IifZyu31DTGoe2jXMYapJ73Gd4ive+HkR5Ps=;
        b=ZFIgZaKcgQb1HBlAK9unbTNFHaQpQ3OzBRrlTMeow5lEqcWcLsfH8htOUn/M3nySIG
         8jB9GYyRT/Y/5EmIRjsuwMnv8eLwp5OXXfxu0Vb71s44vh+Vkg7H7WiVa2qQ8hpQ6dFf
         5Bd44/vQMxFr8VH4P66nJSEYyrBzb+0KXPgYRauD5DwKjPuTEUTVJ6etNv5S3Pjnzp/5
         yfJ2vNdDSzKuWE6iUqdRD1qViVD6hMm17h9OT81RlCGPaIVIAMFN4p+rTwhxJmAdds11
         yawQFwr83fWJQ3mhS0eyZ35IeGdBtpcnhQRGuqSvCxJKJkRESjjBmDHcRtyw1CclrGZs
         5OCQ==
X-Gm-Message-State: APuU4Z8KZeznUOVVTCsZyJhdgW587uP0LsKFJQbTTpFhVyeHgElKyXET
	aVQJCl3I+4+MvP92snxZQO0Y2CyxxUXHVlXXggmHBnUoeMuxGMHafBfSy4ftUOJ422lStQ==
X-Gm-Gg: AYBFou1O1stlFS2HOC4qC1cAiQ6v9LJGpz+wuL+yYVA4dN+SyQiD7E33b7uSqDC2cJ6
	CQsOiZPv2nfqX+cLSs+EifEU/gESNcxf3QdkS9eIKtTaqedUYFT5+FCd0Br17d3tnaDFvJW1ULa
	JqLgNwt6h34CI04sADYbr/tBZBYOOqlUy66mlpoifzqrm9y6ynnHVPCLDXRfYHyX9DhmIgMSjpK
	g/BIGfTFxOPnLW6Y6WajCWvyFfwnn2VNXq+q3Oky0xpaBj7219UgtteR1r1npFDlKetlifAsByI
	2d9OTeVw6ZQxPkUKkNUycqewKnsVLrX/cov2Lt2zz9BFJXrhjcQ6ydhOYRT5yu1y+ODhS16RLwS
	qSle604N9Nz66DMWfzmiTwEHHhFsqYRv13A8ujJtYT/ammIkiJ3Jc9VJHZGaynJRiu5qt/qXrWY
	zfQ+Jns5ng8786oEsHCRc5B1pUFtK8pEF2JERGmJrV3sk6YDlCvjy6FcTCa9P9j64adOyX2rJSY
	D/a/lSBwQhJQsklWm+T8Acp5wSSHygrIps9dV9VIKHvEzvmtM/OSSr972Kma8tmX9rxrfp9UaWx
	YFleQ70VeA3L8FhxP27+e2DVQBTkw/tf8xCqzy3ZxrkDijXoFlpf46uSV20a3UOYTuwzPhvDIXG
	8wgRxDex0y3s1w/lDOxVrdpmTZWM2uFUwsS2LtA==
X-Received: by 2002:a17:90b:5347:b0:3ac:b6eb:e0dd with SMTP id 98e67ed59e1d1-3b182f9bcdbmr5259619a91.50.1794486317597;
        Thu, 12 Nov 2026 04:25:17 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ab04d466sm49577a91.14.2026.11.12.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:25:17 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	amir73il@gmail.com,
	mason@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH 6.18.y v2] ovl: fail the mount if the casefold flag has changed
Date: Thu, 12 Nov 2026 12:25:00 +0000
Message-ID: <20261112122500.6344-1-dennylin0707@gmail.com>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit c782fc8ada811569811c0fdea5c3412511be95d0 ]

An unprivileged user in a user namespace can repeatedly trigger a kernel
warning with their own overlay mounts. They do so by changing the
casefold flag of the topmost layer's empty root, the top directory of
that layer, after the layers are set and before the mount is created.

The casefold flag of a directory makes name lookups in that directory
case-insensitive. All layers of an overlay must agree on casefolding.

ovl_mount_dir_check() reads the casefold flag of a layer root when
fsconfig() sets that layer, and saves the result in ofs->casefold. The
mount is created later, by another fsconfig() call with
FSCONFIG_CMD_CREATE.

The casefold flag of an empty directory can be changed.

The casefold flag of the overlay root must match ofs->casefold.
ovl_get_root() copies the flag from the topmost layer root, as it is
when the mount is created. On a mismatch, ovl_get_root() only does a
WARN_ON(), and the mount continues. The check is not a WARN_ON_ONCE(),
so each such mount warns again.

An unprivileged user needs CONFIG_UNICODE, and a tmpfs mounted with the
casefold option in their namespace.

Reproduced by changing the casefold flag of the empty upper directory
after the layers were set and before FSCONFIG_CMD_CREATE, with tmpfs and
ext4 layers, and as uid 1000 in a user namespace.

Fix this by replacing the WARN_ON() with a check that fails the mount
with -EINVAL.

Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be copied")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Tested-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: In 6.18, ovl_fill_super() handles credential restoration and
filesystem cleanup. Drop the unpublished root dentry and go to out_err,
skipping out_free_oe because the root inode already owns oe.]
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Restore the upstream commit message and move the 6.18 adjustment
  into a bracketed note above my sign-off, as Amir suggested.

OpenAI Codex assisted with adapting the backport and running the QEMU
checks.

 fs/overlayfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8d4ef5b..52d6f32 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1370,7 +1370,6 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */
 	dget(upperdentry);
@@ -1576,6 +1575,17 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root_dentry)
 		goto out_free_oe;
 
+	/*
+	 * The casefold flag of an empty layer root may have changed since the
+	 * mount options were parsed. The root inode owns oe by now.
+	 */
+	if (!!IS_CASEFOLDED(d_inode(root_dentry)) != ofs->casefold) {
+		pr_err("casefold flag of the root directory has changed\n");
+		dput(root_dentry);
+		err = -EINVAL;
+		goto out_err;
+	}
+
 	sb->s_root = root_dentry;
 
 	ovl_revert_creds(old_cred);
-- 
2.50.1 (Apple Git-155)

