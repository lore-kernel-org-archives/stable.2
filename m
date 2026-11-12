Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473037;
	b=D3ZSuQ4sIHE2zcnFxfT6xYjI/d+9Sw/d5+gzJjTGP5pAqTZKIp1hMJfkYUGcbdoRb3gA
	 taSLkIiCOX/bLa/kNNiwF1jNnVr20ljWdVs9Iv2p75xQRbKwXJ0S6SpM36xW/z7OtTMwS
	 +A8j46iHCdpQy2DjGrrT6xpNi/i2j/jY2p3MRWWIe4LDuAx5vHUdWUxDUSLcTSa57fCMr
	 ibGsrOv4oj/zyu4o6Z5pYaz/ixiu/8i62Ioj8vo1S+kYwVcG/WtIWtr83GA6moq+dPP6j
	 FUldoiDp4YsKhXeZnvZuQmQjFazjVL8TFPrnfi7jySyvgbOxlszNggt+2mGALBbQzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZG3BxFME2inkNVUmTtwMhep65XUrQaQ08x5OOJ0mIKk=;
	b=QHLMuv32C40MdeLfbozHyCm/w4P6UkG4rrt+t3rqSjaG0QE99O0Ts7yKck0l6Wy4YCVp
	 yF2SL3I6lg3AGfFaLsDLmBSYhjoyQa6k3teHzpdRGvHvyDQ1pD7J27tNTyo91TbEmZRcS
	 ZeF6OTF5EkgaQq4CPzw/HkcnNjY/Ywf8AF2g1xCDCPj6NUS0I+/Shs2H4uAceq1/XVLGV
	 7oLq3vX/NPeFZ2k6XKISnu3ll8gCygafxXXZssKEzT/8w88qu9LKShnEee+OZUflspjmL
	 Q1CLrOeoArRUYD/HV4GpPifGNgCruYbPiovE0l6MLQcxy6wCeFF6UqCZWiHPJq4aQSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfYpU3Th;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60645606A8BA
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60645606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfYpU3Th
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so3725134eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794473036; x=1795077836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZG3BxFME2inkNVUmTtwMhep65XUrQaQ08x5OOJ0mIKk=;
        b=mfYpU3ThNpZKjkuT9jqlbHG0qjszPVt/I71+anTU5MkkIsdS7HFyPHXiJut2gN/3Fw
         91FQjzZKe4KGN3zrLV/Wqv1YTWWhEs2wpCwaBmFH7h2bfWGh52EHwlojZVTvLRFEEjJz
         NC5ZV5rx1/rYDhUKmsdo/ubObuA7Nj8FeBkHwuoTlVH+/h2tJymlmeq15F+R1+bna12a
         SdAm5BrkmprYkLIKkGLYRLgiFdszH30yI5aOvph6U7fDxu71/3CvO6Xar+SU3LY9vsqR
         f/Np45cny0xb8QjOnjld2V8hL1+louvQmR/xx4F8dT52F8dwOmzBjIlPvz5ZcXM8757T
         hkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473036; x=1795077836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZG3BxFME2inkNVUmTtwMhep65XUrQaQ08x5OOJ0mIKk=;
        b=wO8ZA5dS+F8pR0/JVa1P8jq+olPxHYrUBu9J5fplnO7oJiztqHTwSr5Up7r7mseB4W
         o63N3M0g4tqSj47HIQB5bky8mCoqXJ80nYDIhH5ptFE2GWQ4povRZMVyKxh2Vaxh0IYj
         mkF5ZJ1HaKvNH4Rck1HAAeyvTccab1cK/jqyssa7Z9i2N4nA++OjXNP8PsjZnvf3WbxP
         /+5BYMvm0ozaUTjZA4fTFWzjGTHZ4AJcGnzHQby4n1Gsrl3cuFjlLl0rkjTUk7+f6KOm
         iI7tw0ue3T72SHpeX+9TYv0hKIr03zvVR5F6ozaNWacMoBvKC592xIqRSvH2TqntDASW
         dskA==
X-Gm-Message-State: APuU4Z8PUZsgPmYXie0ZaDrL6q7yMEniVKIenEO/o757AFRsVNTkeF3o
	TGXwiBW0Cchqzc3MP7HuJ0bXURfQ3wI3AZ9P6poPK5OKR4R+liRvbaUEc6/ZTqM3YqFrzg==
X-Gm-Gg: AYBFou3jdOJJN+WikR9SCHu/oO04XoMy4KWduVGceUPLFQ2IXoCes/NC8VXaPsPA4we
	rhPCbXuCAV1OLxIEFNaYkr/cUB+VBoh9eEcfqnxi5dV7owqEdQ26UUQsVnRKrD3aM9B85YhMUtM
	qx8oxKcr5S/IoHx9OCOVlimypwiI6tiDYUpGe/8JGaTmWGyqE20a6R6nkKV2P4asP0oczSACqQo
	n2yFZtr0kYO+aVRHqyVfDVmYYODKfELn6+2pxjG1cD6SF7te2y6h2JbAYs72GzPlYI89rv8cmnI
	9i3dI5i+A04Uso0FoBjpCffAy1ji3P/M5gT7cny83bbtdJGheJNmRdQm/2BgCcwpEeURdfW8oP2
	Vuvg7ARLcPc64nfMf8Brj+Z8YpveCTYfNjurGRSmTFiiMlHqbs3PXT+28n2krzQihTir6reGS66
	0DmJPEdh/+BI2j6+7vrSGhjOAPys7viiEIyP/Pn8vsf/2y+/EP9+lLZFlv1Feg2Bem75ed4Uvf2
	3rHLTKznqAz68+dfJ4eFWUv4tNtTeEZpKOk9a2laHqIKbE1EByOcPakpDbMovzqy5+P6oAeS2Zf
	MssoawUT9ZU+65HYHYHKJvL7iWpintxiZX+EP+XWbwNRnPYZ/RzyeyMaPxIussC3DTUPZ0W33GQ
	Zi24ervKEI2yNtUqOzxxVk9POIyjGhVzHjV/ZspFcF/4JmOzRDm7D8ohpHi8=
X-Received: by 2002:a05:693c:42c8:b0:374:ea35:9069 with SMTP id 5a478bee46e88-37687214143mr5164994eec.39.1794473036387;
        Thu, 12 Nov 2026 00:43:56 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe07dsm25374441eec.20.2026.11.12.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:43:56 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.18.y] ovl: fail the mount if the casefold flag has changed
Date: Thu, 12 Nov 2026 08:43:47 +0000
Message-ID: <20261112084347.6208-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109200525-failed-6.18-c782fc8ada81@kernel.org>
References: <20261109200525-failed-6.18-c782fc8ada81@kernel.org>
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

The casefold flag of the overlay root must match the flag recorded when
validating the layer roots. If these values disagree when creating the
root inode, fail the mount with -EINVAL instead of warning and allowing
the mount to continue.

In 6.18, ovl_fill_super() still owns the credentials and error cleanup.
Drop the local root dentry before publishing it and use out_err to
revert credentials and release the overlay state. The root inode
already owns the overlay entry, so bypass out_free_oe.

Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be copied")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Tested-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
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

