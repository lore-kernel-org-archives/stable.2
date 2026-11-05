Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850281;
	b=IoWWLJTldlLKerXgkXZKt+QMQWGc1W7oBKruHKobeznx7sShAnYrko/LVxBf5Hf9NBwz
	 3yuQuDoYNsfVmpdYXj6K0ZNqoWjVmeUhrMyBwaGXMK06WF+wb2GeI0KWvGicB9txFmg3d
	 XdTUsMglozYZKNOGQT/BvZXPj+eMyrpI7+RHX9WxBSsT0mzWDzKn0Pr8wEC8m87gNkFC2
	 fVTqtLcRlCrLH9Rnf5MWlwM3wZActrPqXHzarvXSKNdd3SetEYES76P+BgCuFTesvZAgy
	 6U5WhzR1Bf54yr77g0Kt+Pawq0AayFlqp5zpMP52nrNcav7a1Ymlrp0+9eQN6sCZjdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6Kd6oBEEGJeHX1jm+Xkx0uVlBR8vYLOVvwaFBqA1msM=;
	b=a2f87svMrJBBLvtHkSeAhX8PhFZ0BANvHwp29BGJyNR/Uqp2k48aMqakHm2ywFmjVK4r
	 Lug3zDgADPFhuA6710fILVqtz5vEzn6H/zPRzN1S7yIbtefzSswUqGffHZQTynGsutT79
	 8llsAmJ2pFzUzxMoWxyjBrMzc2NY6jg5aDhuj8SSN+1msn1kQvEIVHImjcNwCtdLMqKaw
	 RUqmy9H4Nf1a6w18mm+Zi+glC42x+jr5jHW8Nn7C2AETRN8aZmQ7jYryxxEcyylsym9pD
	 Z0yOx7/HahMRlC8Wa0hu7pvPztdWbc6irnWcR/HKhd8c94PE907UQ72IuYuxYS4NFMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsBuCSdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A977606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsBuCSdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D61F000C1;
	Thu,  5 Nov 2026 03:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850280;
	bh=6Kd6oBEEGJeHX1jm+Xkx0uVlBR8vYLOVvwaFBqA1msM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsBuCSdKdCK2nJKevujpdvQS5QRUEoEht0uR6tsJWBufsbAI0zWMFBYjyXXeK05dL
	 VuG8BJ8QfveIcw2nVd5jPyEE0yVj3XonRNj528WB0jyQpQHBiCDJi0E480hFQ9sMZs
	 PqyReQdiA13GMN9WKxPiVWYo6KojX1wSoHB8mbsOX1E9uDrBt6ANiXdGD7U+4U86Qw
	 pL/Jraf5qPHhwHuwt/67Rw7tlj26lcKhx/IjMZH5l8kp08Qvjy9Cez+EClPQxHV1Hv
	 J5cfGWfa+xBq61U6WASMxvpk4NbbgLVUny3ZopJ/Sf5KyNr78uec+Mr9NQbV+sLUoZ
	 ZSCs1JcoVlFzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: use the pinned upper dir in ovl_fix_origin()
Date: Wed,  4 Nov 2026 22:44:39 -0500
Message-ID: <20261105034400.1253169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110427-yam-conjoined-4ce6@gregkh>
References: <2026110427-yam-conjoined-4ce6@gregkh>
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

[ Upstream commit 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f ]

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: replaced ovl_set_impure_dir() with a direct ovl_set_impure(parent, ovl_dentry_upper(parent)) call to avoid adding a helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index cb8ca730c0ecf..f144fe91ccbf5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -819,8 +819,11 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		return err;
 
 	err = ovl_set_origin(ofs, lower, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure(dentry->d_parent,
+				     ovl_dentry_upper(dentry->d_parent));
+	}
 
 	ovl_drop_write(dentry);
 	return err;
-- 
2.53.0

