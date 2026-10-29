Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311355;
	b=iaC4B4oktgZCj14xT0isHYA4BCLD95OEL9HodIbzvcVJL/KKR26wfr29bsL8tyTCE4Ef
	 inXOB8oW7IvWmWCrL2D5tDdHk4CYVWK+Cw/s1nSDbt4RsTUBlzyd6Ou0yHwAbGVFbxpKw
	 2+TyxJvj5ss8ZcnmOEhCIKb/bPby/tPUw+vl3jx6f8TrZUHiXMwMcA/iREB5ImypyRQ4i
	 OyAmQqzeiCMHMeoUGzwyaOjpVdBhBdMTi1RI+nmTSH911T4NLr21usytbuWriMuUhnJ+N
	 DKGJ/rmWOgLUVKq1tW6sJqX86Y0mdxA5gNJdOoXDhRcWDaUjWb803LnkCPiXoorYY4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
	b=jqZnTUZv24VEQEYqRjovB11tiqde8rFQ5llA3ZlGsx5EavAfxq4fsn73/KUVe7R3Sqab
	 0smFK3hcbs3dqemrsgDTTUtTPQhok2v//B4NvF80BLC9nALQtut5QiPOzrRLkYVW00w0Y
	 KSzNNRqaVegOhm2GfsTEBDVBDt91nMrqzSulK1inzaAzL6G6S4oxoI0Xhh/btXiLcRpPE
	 iqjH486DmQfWp8+g3Zu35KGKnYibmrc/FztY4eu1kR5UdF4nwsqeYTdgk03/2gBYZD1Cm
	 VVR3RI+XC3a55JXgIcZ9FM5+3+Xt4cwZ3pGbVfSDPblAnNApYgd2qEgaa/z77eHREMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZAcwi7c;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF8606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFF8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZAcwi7c
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so9879c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311354; x=1793916154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
        b=EZAcwi7cNjE8Z3elHqVYyVHf5F58mrbaRpdJuodzcKIs2zIDyzeNU7YF3fJi+rKU11
         ZFYQ7deGZRP3GtgLfcUnCE1CozHJud+8cYl5XZJbOTrvDbBTqaeRPT9CIr0DuNKCx3zg
         /fs75bFXju9fm5gr1oxoKpUWPXU5Y1wlETogtVrKhpEPT0Q3UWo71bmzoqdk50zxUZIn
         vI7xgGXQXCjvU7fbasOg6X0JyzcXXaNkvlS3H75K6dApI3GpGDFUzK9V44C/omMh4NzH
         wulFqIBY9jJ+0xb4Guooql37u+WPUsBrLZ1c/6G2ARHXZk8BWFQZ/Zrq8V6zhaAyTx0T
         nepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311354; x=1793916154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
        b=EcL5gJ3H/YeTVtVosijljPO5eJQmSPtDI9NQOC44+fgHhyGzpDQ2FNhY+ALjhulVUU
         OuTPtYbvgU7RN3LV7t+UsLSi9mMIs6LE2PgmsJEMTcB1wZG0CjgyOA3xiFVWfnZnnvyH
         GCU6LipUfYvKhDQeU85DDa8i/Y71aLsv7CQ/uCloHhY/hPNAuVzj5hU9IQnU9i1kWolS
         /7yJgzhmNqxCnKruWm5R1UvIzyggLsckFcczk/6414EWJcsiOxzAB5b3kZ6+IS2N4rQH
         xN3Xh3j2YS5vtWOgXduiIzNF1gXUbObXzpgr45q6UCV2X6qGRyxvxjCeBBIlsy+D4O9/
         EaOw==
X-Forwarded-Encrypted: i=1; AKwUvBxRSH0T92VGbf7XWU5MdDz8Y7PCe8K0tnMZDDqUeJZ8HT+9cFaxoNOOf0hI3F8OkcSrUR04i0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRaE5XDS9dsXkf0lMUcrCuGnHOKtbUAscDnU3XqYblWSkxl3BR
	+YKA13DUzCrprJhn5YB8gB0Twk7hfsrDDiL5OuBsKDRNzKU1GmAUBC4y0Y4c4Qusp+o=
X-Gm-Gg: AYBFou1qL/Gq4rkqOVhng1+8Gex7V/VPVdm8lwwbTUiW93RgL7j5KIF0Er3oK6FKN2q
	JPjwOPUEw72kywtmfirG+cobqeU5JICaP8YjC2lbMKIC/d8y5ZNYrRxxvcJyzXdU+topY7FlDJY
	mdkd76cLP0X45EZ+FfnSs8GHXNTcTTSW2XK8t+zVhqGnNJppQI5SL5gMPdqVGbVTs7eWVt5uNYX
	FHa8H3Jcji6N8+4QcuBMQoHB+iHRnwKaz9ozHkNBjUHO6xwvW+g3OgyoIVvwOIl6w8h/kVgZLqK
	dqSU6Q3E8sxVO3kVpa4+HlWdTLAXH0Rk4paFMyh9DPPQgQAThWxAnvjAGMzukcTyQljM8e3cWPt
	+9u2uDKFlKjmkTmHW+0MVK2xL4tShJQteO30TOMNYtzEjAeHIR49OtVPvR+3I/+awY0wxlc/PlU
	Oif0FMbxV3CY472q3+26+rmFx/cBGDx6IHlR4vMjKa4/p5Hr3pMEl0gH7oVUdypit0xfms77nTv
	4rMWJpaCCfgKiKowJE7mfyq5FBkB9HjwAKNLCQwW63AwXsomG9wQ1dW0/G1Lnp5wKoF1AtEetLP
	xqCspD7z7Kq8WFpZy38LT1/zclEkmAtf7LQ4WjX7ueLDOe4s+G7Dc/kb
X-Received: by 2002:a05:701b:4354:b0:1a2:6b9f:f7e1 with SMTP id a92af1059eb24-1ac5cb1a31bmr472033c88.14.1793311353726;
        Thu, 29 Oct 2026 15:02:33 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm1316007c88.20.2026.10.29.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:02:32 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: accept unchanged read-only fileattr flags
Date: Thu, 29 Oct 2026 22:02:03 +0000
Message-ID: <20261029220203.80532-1-dennylin0707@gmail.com>
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

ntfs_fileattr_get() reports casefold, compression and encryption flags,
while ntfs_fileattr_set() only accepts immutable, append and nodump.
chattr preserves the reported flags when adding or removing nodump, so
chattr +d and -d fail with EOPNOTSUPP on nocase mounts and compressed
files even though neither command requests a change to those properties.

Read the current attributes and allow reported flags to be passed back.
Continue rejecting unsupported bits that are not already present, and
keep applying only the existing mutable flags. Requests that omit
read-only flags, such as chattr =d, retain their existing behavior.

Fixes: 33f29fc7c67e ("fs/ntfs3: add fileattr support")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ntfs3/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 52e1cd969e06..af6fb438eaa8 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -134,17 +134,21 @@ int ntfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
+	struct file_kattr old_fa = {};
 	u32 flags = fa->flags;
 	unsigned int new_fl = 0;
+	int err;
 
-	/* Avoid any operation if inode is bad. */
-	if (unlikely(is_bad_ni(ni)))
-		return -EINVAL;
+	err = ntfs_fileattr_get(dentry, &old_fa);
+	if (err)
+		return err;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL))
+	/* Accept unchanged read-only flags. */
+	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL |
+		      old_fa.flags))
 		return -EOPNOTSUPP;
 
 	if (flags & FS_IMMUTABLE_FL)
