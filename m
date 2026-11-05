Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886312;
	b=PKTP+dzErWdbVPpZoyJEme5kMsHTLf/2bLyvqc9p6UNqLHWnZcdomlaTOR5vAKddbxjS
	 RwwXGlsiCcirRsOe77JNpWwGkPb94CIk0Tgd2gud7pBRS76NdPUmHV5HK3UgXk9wSdZ7y
	 FaYNuNZsgY+6LWjH7z66MF5uys7l13OZqy7acpUmo+dZaVvBsaK/gVnsK3G2DyYPhFllD
	 Ngjp/3/n/TNKI7N1SommCATeQ7RyXCGZgTmoM9RHtXTKk3zH06nlNnSKxpk2AoYgSGeaa
	 +GIhwSzvzOU2vVivHzbPN+VRUldkDOyI6Mia3YNv0+3weU0ooqxY2utOEF/htwKVRiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dO256H+LIxFTdd6t2oXCNmhsicWnJ5fiOZUhfsKu4Ac=;
	b=s26TJk5ijPb1W6MZ3O6+v7g2c64CxNbihe0bxQULYIC307bSxaD60dd0SKN+s18cPivx
	 yPGvGugasaPWjyzMXo74wQyy658VaKpC5olxT0MLZAkmXLQiyBXLVoBbWAR5ICzv9eYMU
	 wVcn6xj8cbP0cX6IgFfGWld3abVFfbcXFxrJXeVbd2/ekkyy2ROBvVqf/G44/BN+pLp9B
	 g03VtvlcSls+ZcLtWfx+bAKtBYv6gPXLhURJg0ziOhu76Qpzj2+1seVy7dkoXwxNaQpVi
	 vu2PfTHd+9Tuc5dGw1Z4l1nfLK1rOoFIsh4n+OatAZr1uggHr9onEoT1FBKdyVI2/lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzFKTmYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8EB606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzFKTmYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6351F00919;
	Thu,  5 Nov 2026 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886312;
	bh=dO256H+LIxFTdd6t2oXCNmhsicWnJ5fiOZUhfsKu4Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzFKTmYXm2jbtAovKwqD6o0Qrj6cyjkcPvj+30X1C7M/xgjcMYUW59v3EhM/4X52+
	 DbEil8MW46zJ4LyULRer+zF7hOH6R0fWtJjErjsBOblWT/QmbkBCPKj51I+BqS3TZ1
	 FmEE6uF7CpoXNDsljs4PicOPRIgYOL/k0Oti46BTrxQx1BpxdtM8e0yE8Jx8ziL8As
	 Aozr30qQDQM34yJvyL4zjfgDihZ3edkGB5ZSW5dgoZtUGhneStwZRAYA0TAfotUNci
	 KkVR3lOoH137ImjYb9AHEtnh+N541I2n80RJRNR+bfM4K1cemNR664haKzU+eOcLbS
	 f4z+UlIuz+s3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: do not copy up a dentry that was removed
Date: Thu,  5 Nov 2026 08:45:10 -0500
Message-ID: <20261105134351.1612295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-mummified-purposely-6cef@gregkh>
References: <2026110408-mummified-purposely-6cef@gregkh>
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
[ sashal: replaced LOOKUP_EXCL in start_renaming_dentry() with a d_is_positive() check before ovl_do_rename() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4c7ef60dbaac0..92b33a4fcdaa9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -703,7 +703,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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

