Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A43655ED
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784966416; cv=none; b=S4ug8Iu7cbbVm6Yoz4S3nn9oiJMH2f7fiPT6JIAnPATcc9PK0Vc+URrWB4TCtWvnxR4KXA4QP4dYORfa5u7NdHORcJ0KivVTGMzIqsxN+yRA7FtpLdjCN9c/cd7SnZta7bSTd83WhNnjFjGaPf6UG3w0421C6Yd6N6bknU0G0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784966416; c=relaxed/simple;
	bh=x0azAcsCMMPMXxXDdBsJkovGUPenS+iAVlLZJGdkobQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VA6u8WByYzlIyXgLpQXUkoiNI97ljsvx+UwOBkO3+B1U4ie39ksm9S/VmhVj/7zi5Xm6hEGti+VkeV/3qlxV7F7D0XXa4VRVtICA0mQAVzyJVFAbTrneerFp+jcK38oVtokBVPlriuUfg56EvWl7tPopd3PxvBKREm3idw4iutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzO9y6IM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzO9y6IM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5283e3eff60so9592561cf.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784966413; x=1785571213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aN3F1x7OR5ZXu0ndJb6FFcDobq/hnEMNM/moElJMtpE=;
        b=IzO9y6IMto5SfJXpoelyqw0Erf1g+5Pb0+cqmCD2rRcQPIVTzVDbvMDo4OwjB2XFPO
         N93eHsLSFAKgKGUab/FT+H54BkPXbMx/RUScRi1YoTxj6Yrcuwe+2czW8Xv0Cr0s9McG
         tBpmDMrtl1RnQGKy1rQIdh436Lq9H/VMo81OyzA14+P9GrwVG4akFvvm40e+mILimufZ
         lEjVwBN63xnKqk+kUhu/PC0jHGkf1wLoWDy3ygSQV0mYkUufFKJt5ZfhNZwhBhZCcd/n
         QeC5RtHuHcuR9K8836570hdYFrbXqJorqns4EL6lFp0K1VPqPYwAJI2NyYyLXpCDLaDq
         1xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784966413; x=1785571213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aN3F1x7OR5ZXu0ndJb6FFcDobq/hnEMNM/moElJMtpE=;
        b=eFLpkw8qHAzcA1p4C7UbSRxvec9ISLKc7+iF3iA5fXqxz8w9Y1HmX99hGDhPV4LEm8
         tSobkL6ab0Fd9JSTfvbUK/eCpCOlQS56jsuRe+UHzg0mQz93HESLjnG/0haG5c9irauO
         agFgTOntJx33oFrkfWsL2B9sCC5dabuj+r3MaolPY5auHhFRxSPta+rA0qC/stQwSW9o
         wmxKTVMrxaKPl5jOcB7IyvAhwVKrKwG7790P/hV6ZY780LVZ8qApT2QHuQgbJOrnSmc0
         1ZY0fm4yT+m0SQ/DVq1cFjF0ayUinjCB0sf67qcJ3or76vT+kcaBEFkyZsEDCiRfvY82
         rMzw==
X-Forwarded-Encrypted: i=1; AHgh+RoFrgy1UWghFUtuAa4q7j0w6+IDIvGkDLq8jDZIbSiWYNOMm59pQ5oc66LtHKVlMh7TjT9a/gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWmso5tofxsnq3PausgjfIObbOjjPCgYnVsYX3N1K++v+4tgF
	KVzamqkRDGOHynDlWc5u1Vo5FdgHxvYev9Ba/4LTjtcdFrT3WMnMLeZY
X-Gm-Gg: AR+sD13Ioc6yGytYBftf8iRr8N7F2sxFUA6iKONHTb/TM3GtTPNvX9mJVPrQyAR4czy
	H+kJS1mY6oHZ9XMCfSGq6lQ4rR88dVyyUMZOttlp9bL8E1hkAKbR6QkvEV/ucMnxUjTb06uqP8d
	s6A+8jQP/m2oolfQVIT4gymL0CA8TDRaZrhLc3YH9UOrz8cf9AW1C7xT5NRUyerGp+2TmS9mTna
	BdFUvRmi8k5TAkzRPVmzi1otC6NF7zu2bqGkrZSCNlaHObzBQEq55SUHgJt1B38wLR83Cg2D78j
	ic5gsToD7icVAViSj8zZp0URfrNE0Frp7GOoj9QspH3YBBqDu6N3nfplwfi/jLvk0x4i/J+pYtc
	ZrRn2TEsjk6UOxdL/xRAA5w0n7xsht7qnk1ocVTiu1BLmtp+66Irl8TVderwaxRym9r+pqSXrxp
	+3CkDGjPziz0B6A1M/Xw==
X-Received: by 2002:ac8:5a47:0:b0:528:325c:2905 with SMTP id d75a77b69052e-529a8721edamr12780321cf.63.1784966412617;
        Sat, 25 Jul 2026 01:00:12 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86a1b73sm15788896d6.32.2026.07.25.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:00:11 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] fscrypt: use the mount idmap for the owner check in fscrypt_ioctl_set_policy()
Date: Sat, 25 Jul 2026 16:00:04 +0800
Message-ID: <20260725080004.929328-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

fscrypt_ioctl_set_policy() calls inode_owner_or_capable() with
&nop_mnt_idmap before allowing an encryption policy to be set, instead of
the idmap of the mount the ioctl was issued on.

fscrypt is used by filesystems that support idmapped mounts (e.g. ext4,
f2fs), so on such a mount this compares the caller's fsuid against the
unmapped on-disk owner rather than the mapped owner: the actual owner can
be wrongly denied with -EACCES and an unrelated caller wrongly allowed.
Use file_mnt_idmap(filp) instead.

Fixes: 01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/crypto/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 9915e39362db..c80b24a941ad 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -534,7 +534,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 		return -EFAULT;
 	policy.version = version;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
-- 
2.43.0

