Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818382;
	b=1KsqNT4sYmHpl+b8as5o4/l4TTgtuecayXS9H/e2Fxu++egf/bnd1Q/XSf0PsUi1dW5Q
	 0nExkmFTPRpM9QrumwCpDoEMmLZoRtusmE/vSpJM9Ne9rQXTMOAqJbejB8XfZe2XfFyji
	 4ZYTu/qcgMRMOW4R3GqkGWHhjjJ8QrC3qrbrPH6TSueYXkLDR4OaiyjZvdD5M5yTotHPi
	 iaIGu+7+0Ji+poBgzVoU3c59E4VAyYbjThK+a7qdQ4bmgrCc9ZppSXaddxeJ3J8W+qAOY
	 NggOpug2wKXbzI51mgbk8hebB+31zPzwpEzBd2NeiQah/cQgbrP93Burk66VonMUq4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OmaFlDn2sHp0SZU86PB8+jcQio5Xj+DXOedzLAfLnHo=;
	b=zmTsuKvIsXndg/pUl9zkTPwXfUtQwY7x1y5xmUmWapgh/Q/Y1bf8msqg/Xe3ck9VrRlo
	 aK7K9m8FFqNuTfrAaxBB1Stw9sLZj7aP8EhdRLf67FzoTp/kO6zWISrke9NUdlnbV98CD
	 224Aw5QS/VmLtKngZ7sWxKw/q2iE+VKAlviD0I8RzPQbxuFHjGFDEl9Cx8JhLHDca/QLU
	 Cp7Is6fTy0ZWFVSMuvcXTIvxuORKeFTBSeuG/KNiR2vvgFI9L+3nYirGHMdAR/vF4SWQp
	 AcldvC+SOmeKrpvG34Aj9XfGDUeu63JuJVQKBQWBtaDdfv3oeXgZxYtQ8TwHqY8df4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjax4tUm;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2F6082BC7
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D2F6082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjax4tUm
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df54150dfso732637f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818380; x=1794423180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OmaFlDn2sHp0SZU86PB8+jcQio5Xj+DXOedzLAfLnHo=;
        b=Sjax4tUmoiCFgJwc4obaEFuvYCQEL15OoDjnDXA3D3ky9A2oreEGuvZ3H6TiqDnvZ6
         vn/m5INuhxVps+VpiJzK8oxQNHYH7A99lKYssfVXkojlUqocFQDK8XdQUMYFNUKHWlhg
         oC8F354EODiJyBv4jMPmAmitBHznyZnDD712gnW6ssWh7noDOy8KQcghRhOUCsknsyp2
         8fvOu2rPxbGICMjUhOwVnk+OY90jMwVuyCM28Dr632a3tPJd3hgnrKBUTMa5venkM1Ie
         vCsrYIc5ck7VBW7nezM7moOZSgFug/SGK5K5IhdKoRVMBSrzmrpBqjiOwEAStszxRBK4
         y5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818380; x=1794423180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmaFlDn2sHp0SZU86PB8+jcQio5Xj+DXOedzLAfLnHo=;
        b=kRRuYLythYXFuDCBLqkhiK9cb21vl0aehcTxkQgTVPTvX9Xs+9rZA0hos4hcyiU7Qc
         stVQhJu7326LanvK5WWFH4LImbyxNd5vcZbCbdNofuVk40y0dkttZ6CUR8v2CaTSuYzv
         BT3FQh31Bu5lEr44tGAQk1QuupuW4VLl8rm85ObOEjo01m1yI+DJfZze2oakkZM7u/tD
         kPpV0TugX2+iomUob59pTF4mgSfr5vNJOOUHuo5E8lWqiFwAMkClPs39maHzyHChoEV6
         JwKCZYR4QHl9Yaj3Pi0iqE0KhImDdFIvfl8xLuyZJH2wtTEN0BBKSpDV/K2NeTuK9hf2
         MEZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbsjq/DcaLb96Sn1kkgOvwrJLa2qrNmfJOlHDPBbnvAAdvq+Y1drMo9eCZfIXCORXPHaR5blU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MfGytDXRHPCSIa1j0fj8ihWCIaPmjOZ0XMZNlORP8OSnad34Z
	CSzaIDcCHplA4mRl+e67Olta8Dw35eASr8HjkUxugh7cIX8aUWBWU9b1
X-Gm-Gg: AYBFou31Q0EHPSOx0yJ7hp4eL3Q4EE0mFB1d3GnnsUNY461RrUVfoJjBIT4SaAjfpd5
	VMQJdlCej2uz0/+GtbUIxBP8f9sTcWIi5RbrNbuBJG0AC5E80aMjqiayC4xutm8OVyDAJI5ZC8c
	FqTav9xCFKM4eUnDOirCcGamOL5IRAf9BvYfRSAUPn+8mbZTKAFDQLTez+hN9NDWk1uxH/NmWb0
	CRg4ZwCIRbzBcjyxtD54wy7iGGhIEUmmA7yBScwO3HNF/JeOWsnXoe+Pgnu1s6HvrdrCAF3WpJO
	T3MJG9RzxHTfRsvHVbPEE5JnMMEL48kPEDN5JPAQYQ2WhnQSpsB2/UxCcDE8f9JeME23OsunsEq
	x+Mx7uhi0puNhMlYvfzCxxhXw6KTjl7DHm+MQEp5zolrC+p5hLm2SGHUHxoRZRLw/BuCfMItn73
	cDXd3dXqt7pSp3DRu/vQMpuiS7Dy0E26aJsJ9nh6kAaBW0euajT6TAQxNW8W2gspun2w8RLG/wH
	msGP1iShLPbdkYs7KLPZgmyTUBVd2Ox9g080FmFRAWVgi5S7WmFMX5JbaAHk0pBV9e47RtTkgN2
	ND4kedu9wiII3BrPnX9ADhwg8prqZrl9VyypjQyB6llGPU3Ot2/TY90xYG8PLvYACsISf6gF5qG
	1Yyv5OdhMMmI=
X-Received: by 2002:a05:6000:1887:b0:48e:d36:77 with SMTP id ffacd0b85a97d-48e6e2bc062mr43452882f8f.4.1793818380008;
        Wed, 04 Nov 2026 10:53:00 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm5366943f8f.24.2026.11.04.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:52:59 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 6.18] ovl: fix mount setup failing when override_creds drops CAP_SYS_ADMIN
Date: Wed,  4 Nov 2026 19:52:58 +0100
Message-ID: <20261104185258.3630916-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

commit 333ad304d4794d6384087ea7fc16e58ab642809b upstream.

When a process drops CAP_SYS_ADMIN and calls fsconfig(FSCONFIG_SET_FLAG,
"override_creds"), overlayfs saves those restricted credentials in
ofs->creator_cred. ovl_fill_super() then wraps the entire mount setup in
with_ovl_creds(), switching to those restricted credentials for the
duration.

Mount setup calls clone_private_mount(), which checks CAP_SYS_ADMIN
against current credentials. With restricted credentials active, this
check fails with -EPERM even though the task issuing
FSCONFIG_CMD_CREATE is fully privileged.

Use the mounter's real credentials only for cloning the private layer
mounts. Keep all other backing filesystem operations during mount setup
under the stashed credentials.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Closes: https://lore.kernel.org/linux-unionfs/20260924112858.51392-1-disgoel@linux.ibm.com
Fixes: c28f922c9dcee ("clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: 6.18 has no scoped_with_creds(), use scoped_class(override_creds)]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -498,6 +498,20 @@ static int ovl_report_in_use(struct ovl_
 	}
 }
 
+/*
+ * clone_private_mount() checks CAP_SYS_ADMIN in current->cred.
+ * ovl_fill_super() runs under the stashed creator cred, which
+ * override_creds may have dropped.
+ * The task that issued FSCONFIG_CMD_CREATE is still current->real_cred, so
+ * use that only for the clone. creator_cred stays in effect for every other
+ * backing-fs operation.
+ */
+static struct vfsmount *ovl_clone_private_mount(const struct path *path)
+{
+	scoped_class(override_creds, cred, current_real_cred())
+		return clone_private_mount(path);
+}
+
 static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 			 struct ovl_layer *upper_layer,
 			 const struct path *upperpath)
@@ -521,7 +535,7 @@ static int ovl_get_upper(struct super_bl
 	if (err)
 		goto out;
 
-	upper_mnt = clone_private_mount(upperpath);
+	upper_mnt = ovl_clone_private_mount(upperpath);
 	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
 		pr_err("failed to clone upperpath\n");
@@ -1094,7 +1108,7 @@ static int ovl_get_layers(struct super_b
 			}
 		}
 
-		mnt = clone_private_mount(&l->path);
+		mnt = ovl_clone_private_mount(&l->path);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");
-- 
backport

