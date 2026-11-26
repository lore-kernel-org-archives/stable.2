Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658637;
	b=BaAHREi3GH7JXz74mBfl5P5fjS0F8GJ5s8fNQA8i66T3wt0FRyEB+tFbkQ3GmPIAZBml
	 GSV5+AZZcvA8dMgMC2QAyX7dDnptmVFW/SZCfYj0oEkAc6liyXCRXRxHyZCXumFuWQI8N
	 8s5bExKKjr91JlHql1CMuZeKvaj0m72Ac+zbB0kANyisgQrNed/5jzbPxcKto9o1JXs81
	 mi+DLaY2GFyqh40CHhfjwKNqFh8xcgVUO2zR2cWxSB0kZ3mVWP4zil/FSNrnL19aNoUJG
	 CjtozAIrRN32GcaJy/A5aDm+pQdMNkv5VUoY42f60VhDWvGEGD0BZTJyS+3gwn+OK+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/e+jEOWJdNYwNBdYuNAC3eS2HdISXI32LlTY1dpwMCw=;
	b=BRdxWmH52KOwGPBxisDFTfGb1ldZtx4PM0UXalg2OmySPvszsBkDg1x04L29m7LWIWQs
	 K1p/YUn8sVmCUfsD8pt6P/6s3sCv6V5YvwkrmCBKuxLF5houQLWSIq9HdpN5ovE4J7amB
	 qeDJQiWFLd6PtR5hYc2bhIWQvu5vSyH2VQ3s+xZSrj87M3Jf2ACU7GP2YLISVmOskepkn
	 UmIpL+dH/FyONFwmwh+hVlk+WVwT2glV/VzBzR1Sgb3kDk828wJPjXOSzScM0It3IcRc9
	 xBCUdeb6oqOazVuDZzWMZ6pL9zqpJZnvUdvJU4y/VFdnbzyl315HsPTRqXddvyM2HBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjtDxk4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF5606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjtDxk4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE911F000C0;
	Thu, 26 Nov 2026 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658636;
	bh=/e+jEOWJdNYwNBdYuNAC3eS2HdISXI32LlTY1dpwMCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjtDxk4xRAOnfaLgZtEf/aBKtb/lDYZr4oJJA5Etq9B92uqFcREBrdQwLBxRLMRfj
	 FJV4u3WewbS9+IEWQn5t2W1EIazQSU41gGlva/PDWGvARZVK7MnKe0D5mCn/vEQHGn
	 veiF5KK8m1cVvQsvn3UdTTAWKRhTUEOpA69OIP2rVa24esQHEJ1OtfTMQGjjGbVHMQ
	 6DEfdgAz72EIMsW0jdqTv9aJW1hXsDW/tfJ5p0qQRrFQP2JlnLft58SBnUn5Htioqw
	 HlnHLH1r9mx01wgpFTUWVpKrojUnp3uGyz8p0tIOO7hDjZs/VWFwwgqox6mZqcpkHW
	 V6oRbvPgAcgZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 21:03:50 -0500
Message-ID: <20261126020308.1696715-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126020308.1696715-1-sashal@kernel.org>
References: <2026112548-vowed-carded-1ef2@gregkh>
 <20261126020308.1696715-1-sashal@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 86e2facd8630cc2fdec6ea80c53e370b26b441d9 ]

Linking a file with copy up origin into a non-merge impure dir does
not bump the dir version. readdir then reuses the impure dir cache
built before the link. It reports the upper inode number as d_ino of
the new link, not st_ino.

Pass whether the linked file has an origin to ovl_dir_modified(), as
rename and unlink do.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-98f207b6-3936-48e9-a40f-88f20be4db7b
Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 43a9866428b38..d443c3169dad5 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -355,7 +355,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -378,7 +378,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
@@ -471,7 +471,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -557,7 +557,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup_unlocked;
 	}
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
 		ovl_cleanup(ofs, upperdir, newdentry);
@@ -651,12 +651,12 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 
 static int ovl_create_handle_whiteouts(struct dentry *dentry,
 				       struct inode *inode,
-				       struct ovl_cattr *attr)
+				       struct ovl_cattr *attr, bool origin)
 {
 	if (!ovl_dentry_is_whiteout(dentry))
-		return ovl_create_upper(dentry, inode, attr);
+		return ovl_create_upper(dentry, inode, attr, origin);
 
-	return ovl_create_over_whiteout(dentry, inode, attr);
+	return ovl_create_over_whiteout(dentry, inode, attr, origin);
 }
 
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
@@ -691,12 +691,14 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 */
 
 		if (attr->hardlink)
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 
 		scoped_class(ovl_override_creator_creds, cred, dentry, inode, attr->mode) {
 			if (IS_ERR(cred))
 				return PTR_ERR(cred);
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 		}
 	}
 	return err;
-- 
2.53.0

