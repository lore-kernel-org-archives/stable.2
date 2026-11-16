Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807879;
	b=sUKkupDgk3UHRPF+Yvei6qI7Af0n/u0jyzRa3bawSFMFNOTv2dqMaSALG60rypHXLVKb
	 Jn9e82DZE+oaEMbKQUml4Gi0s58H9SFy/8llOnlSm2+D7NWe8dG2Xj0l6/j/vRcKpJc3/
	 pG+cngC4DaT/sPzP9mlAIc2ZyADeLbjjOmuTLLYvnupt3R8GVKAfTRFDWMRxyHezzX7S0
	 vJn+vltoBvnsUGmgQS76DXiFwqXA86+hbJkS2uWvSAivJKtF8pDMmmyx2DRmwwdgdgIPM
	 YYv6PAgD35eMy/ZzgbTXAHbmum9G5uw+W8R8zdsT0pIoOI/BFCVrjPa9Nn22m8c04qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6juYiLwJPfjMMa1PV9mnBM+MXTPlKv5dj+C2Lcf3/rs=;
	b=pODJSd6Nj0n88CUNpEI20FMAn0acqFF7r4ARXXBnl+e0BMv0vrwjGzNpno49ghgpVSFR
	 n9pZ0ApOaQtZzvzvIZPShKsVEqBqebj5XAcRkQOh0SMBRwxy5d75wLw3IWJHb9w69g395
	 49CyfUCyaKnVa+sZ/XKk5gH65PB7JfVhrkjeoOvz7cLbOqRXFrZXq0Sc6QBCWgwJcI6yU
	 YM06z3lkm+XC666JuMUJ83ZxLjGScBnA9dT/yLyrsPMTKbWamaYCHKyCFfKEI1xc665ie
	 zve+XP96hWjiw1ggzwdyollw78ESKxvYwGbl2NA12jwDkv+AcCsdvDh3D0Dyb0XC2dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbcyvYrO;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E6606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D65E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbcyvYrO
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1127659b3a.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807878; x=1795412678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6juYiLwJPfjMMa1PV9mnBM+MXTPlKv5dj+C2Lcf3/rs=;
        b=KbcyvYrOCF+jA/uX8xFI7qHAQ8AL6G1YvRWtN85kZR2PmGYHc7TC+9VQ3cPwdGWmqG
         H5j7xrNlK1JTWUj0vR7kLwPYPKw9X81xik+JOqeQ8WUFGlSTOQIRIpsQON7TTO3FdJ8G
         R8QsafxUs7UHjig0wcEilZjBOPXx9tl7royOiKw7YIV/cWdmmkNjgZ8yTcTGEFcj04qW
         m916fnhskK0NTAL0aAtfkttXYrnGzGg78TjjXXoBlGvsK6oGuFMbQErcPc+h0ui/vw0Z
         LsrJ1bwLNgL0RMknkL+OAfflZQH9zBLrmfKz8z34OTZqjW8yWVcyNcxgtgrBrRp2K8P+
         6blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807878; x=1795412678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6juYiLwJPfjMMa1PV9mnBM+MXTPlKv5dj+C2Lcf3/rs=;
        b=H8cc/O738BxkHmSXddK5vF9XDFDaP5YNjH2Y5ZQyAX609S7AyiaxxSEe/2KvEGnmux
         5NuEZqDbTSMI5y38XUxHP7eHgYHd3hmJIfTWVZKVRTCWCAdlzYOy6lZCVJrge07mWhVy
         6fj2hWEx35iNfipez7UOJeZ+YdgDOmiCjOo28axaRA39B7bC/FFsqdhjmth212fUF1F4
         OFHWUPilsEL1olGoNM5mnx+mMPGg8swq87orUSPggWmp35Kl8eisTYfDqJJJz3WiHIM3
         3caT96k/wc9skMJYDLSD43RNUuIWthZWronhhWVk7eyMuuHSvBTQr7HFcHw0sw9NbHGd
         TMLA==
X-Forwarded-Encrypted: i=1; AL+hErGPSpiJoGpqKguSsMPP/NDHMZ3CTfdGnvFFtTegIogWeXMwzeYO+5ja5ANmdRCd6IH40g3iPTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZNA+4BNMlTaQKNyFgflAftzv2owozuaytud0PdXz1ym7oG8fS
	CFCDcgwmtk95N4AWLFFUKpronR1oENrRTRhMbRyh/rvA/RnkDLSn+QwQ
X-Gm-Gg: AYBFou084/OLasTs8oEddiRd0WckOTunSzu9R3pRjgYtiKiSMWh8yEAtdCi+mkcFLbI
	VDGkC4p13ibu3UDOE3Yhkzd+L2IgKrkPytT8CZQlDccgwug7V4ziBMIniU/4kU1JlYbKF+3sPib
	t6O9zXDp1e0t9d6Oowe0QK/MKxV9/hRKHUZY1IydHuOdVUfJlpdAzYilamtEQOIfxVIbwe5IF/o
	bOpxMxruH1JtnfNqRB9NdINoVFq1sJSVZmItAnkogRLAbuPDt+3HkROnE32bQzYRqmTZPxIZd73
	Mjt5dikAqrOWgmhA2q1uF9hwvy5KXsX0oUTeXStTXT2tZnzZHUchnicKO2dFYkTJsSr9kvyYpfF
	F7XIaBlrEXz3niujh6kBkot5X3ctEYnRgpGnM4VFEz0rlnT5oWatZMt/A4Q9rnUJfplTFjx+3Kk
	fv0fukVsYzJAFCBWsBRzaaDFU+SSlRTE8A1zPA+mxs+zBsjzbw9x/sGClpYxx/xt09QvTTPPGN7
	Q1s4EjUo3Q7OntL8p7X6QMayiAqZq9OKo6gQdqr/KOjpWw+GkjjGBwzswVuRwezC65wEmrDofQR
	0b99CiE5n0QX9qLCVB5Xw/Djf/hYuiRcRxc2jf3Z4NUoAp6hGbLb
X-Received: by 2002:a05:6a21:3d86:b0:3e2:26fc:2e06 with SMTP id adf61e73a8af0-3f7a77c053fmr6978259637.26.1794807878106;
        Sun, 15 Nov 2026 21:44:38 -0800 (PST)
Received: from localhost.localdomain ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c7575sm3680304a12.27.2026.11.15.21.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:44:37 -0800 (PST)
From: Qing Zhang <diasyzhangqing@gmail.com>
X-Google-Original-From: Qing Zhang <diasyzhang@tencent.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	kartikey406@gmail.com,
	yi.zhang@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Zhang <diasyzhang@tencent.com>,
	Ahmed Khan <ahmadpsn95@gmail.com>,
	syzbot+9c29b92a3b6500bb347d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ext4: attach jinode before inline data conversion in setattr
Date: Mon, 16 Nov 2026 13:44:23 +0800
Message-ID: <20261116054424.62067-1-diasyzhang@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <6afa2521.84fe3b82.798c4.0005.GAE@google.com>
References: <6afa2521.84fe3b82.798c4.0005.GAE@google.com>
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

Commit ed9356a30e59 ("ext4: convert inline data to extents when
truncate exceeds inline size") added inline data conversion to
ext4_setattr(). Pathname-based truncate bypasses ext4_file_open(),
so the inode may lack a jinode. In ordered mode, the conversion
can pass this NULL jinode to jbd2_journal_file_inode(), causing a
NULL pointer dereference.

Attach the jinode before ext4_convert_inline_data() and propagate
attachment errors. The attachment in ext4_truncate_up() occurs
after the conversion and is too late.

Fixes: ed9356a30e59 ("ext4: convert inline data to extents when truncate exceeds inline size")
Reported-by: Ahmed Khan <ahmadpsn95@gmail.com>
Link: https://lore.kernel.org/r/CAOaS1==g3mdoqmS2AjOC0_-woXJbA_X0LJQt7+M7d1=+gfyQqw@mail.gmail.com
Reported-by: syzbot+9c29b92a3b6500bb347d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c29b92a3b6500bb347d
Cc: stable@vger.kernel.org
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10cd85d4c721..1e31933ae98c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -7127,6 +7127,9 @@ int ext4_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 		 */
 		if (ext4_has_inline_data(inode) &&
 		    attr->ia_size > EXT4_I(inode)->i_inline_size) {
+			error = ext4_inode_attach_jinode(inode);
+			if (error)
+				goto err_out;
 			error = ext4_convert_inline_data(inode);
 			if (error)
 				goto err_out;
-- 
2.43.7

