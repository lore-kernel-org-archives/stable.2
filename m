Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881189;
	b=MPc0c8twJBSNO72aqHD8Xt4v6jarlV6H62fo3Vf34nlGwY+v7xm63vGfeJZNYdq2OsnS
	 SUjEoXh05kUT7M/s7zQN0Rmxie2fvfn++u+IJ0Cwuh3M+s/mpLoq3g7Rnrb3Y2mOq+I8G
	 6KsKoxAUP44hwGIXdYxzfbc6Bm2Lj2IHggGbhKaaA5+b0olrmrzWqf4G9UJT8N6j8dAHa
	 1yHsISjgbVymTK8PrOOrwHAe8+1LcixQT3Zfnc9JsOYIVRVnsCfKuWTWbSPfqw3UZRVP6
	 nKCrw4YkqWVSSkpEUTNPoiw33o3rsGftow7MnxKFnyY3gSzWb2SH3Asmi2uFfN3yWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XhAwqwVf+/kuZf8CeuRUsDnSGCB1Edv79l0Y5NM+CjI=;
	b=gXT2YINDHPrRFCLfx9jTavoM9oIKmgBwrNFKGsjp+RYT/fGYNHPEVAf8IdL1T7vgkeJz
	 qipPaZg3wFD/Ud4Qher6crbQqDwdNHHbfqJPV3sy7LTY1BS/3gSBQfMFN6PyL3KztsaED
	 0QhL5o1EnqQU3li+UuSCPWSs6d0tyiCcxM0Tyybj2QSXXVZe9gGU0M6m4+5q50+xqV2D5
	 wWVt6z2PUoLuEy2Svzy1QyzCA4xn8g6I79kJzKX7VfRgXSX5DZuyQcUIXkqZarAUm2M1h
	 8dn/xK6MfY9aft2WXRhSru2NriwBi+XL3uSQDvlPUOVT2pVgHLyrlNV7ZoqxvQndddA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzZ0gLb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93A606A32F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzZ0gLb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74301F0093A;
	Thu,  5 Nov 2026 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881188;
	bh=XhAwqwVf+/kuZf8CeuRUsDnSGCB1Edv79l0Y5NM+CjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzZ0gLb5WEQWcSXy59yoZ35kLFEQsElnlx4q3TtkAIXEEzppj64XmCaTCvUZP8+Pu
	 uzaGOUlJ3B8oKQEVnSP5GdEl4hW9wDxXLA2ErobN1IbdsX82xLrVp7+f1G/NhR/QkE
	 9mmX3HkSehyWBPMAY0wz0WYfL+CxuORfDeop/PFdSAZy2aQ83K+p/8gZRYrRJ4n4IF
	 pQJVf3qEdhVoWBdVUFeNsXdwmER9Utz+IS8I8wlsfUYS/wt+Y7/Qp/FIPSVylOhZ6P
	 zJ5RPScAABuCAdlbaqEKi1JzS5fau+XVpiRHjMVsrPCvqplUjz0/Hnpl63WqYJRFKc
	 8/ECNGGqOwYkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: do not copy up a dentry that was removed
Date: Thu,  5 Nov 2026 07:19:46 -0500
Message-ID: <20261105121912.1275657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-elevation-shale-f903@gregkh>
References: <2026110407-elevation-shale-f903@gregkh>
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

[ Upstream commit f635192ad223d2009ee640b63adf5ce3198aa338 ]

A change to a removed file through an open descriptor replaces whatever
has its old name in the upper layer.

Copy up must only create a name in the upper directory, never replace
one. After an unlink, an rmdir or a rename over a lower dentry, a
dentry that an open file keeps alive still has its old parent and name,
but in the upper directory that name is now a whiteout or a new object.
ovl_copy_up_workdir() renames the copy over it, which brings back the
removed object and destroys whatever took its name.

An unprivileged user opened a lower FIFO and unlinked it, root created
a file at that name, and fchmod on the old descriptor replaced the file
of root with the FIFO.

Fix this by looking up the target name of the rename in
ovl_copy_up_workdir() with LOOKUP_EXCL, so that copy up fails with
-EEXIST if the name is taken, as copy up with O_TMPFILE already does
when it links the copy to the name.

Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use LOOKUP_EXCL instead of relying on d_unhashed()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Replaced start_renaming_dentry()'s LOOKUP_EXCL check with an explicit d_is_positive() check before ovl_do_rename(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index db128e1f2eb05..7ec9cb89ec063 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -831,7 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
+	/* The name may have been taken since lookup, never replace it */
+	err = -EEXIST;
+	if (!d_is_positive(upper))
+		err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
-- 
2.53.0

