Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C81D95A3
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298630; cv=none; b=nZmzWoY/UrhNbfMArqotIzL9YOkTOS4CfmmLwTnVyFs3AeZrO2X9Q4ItwHALdHu9sbs2JhAtF/WTZlOZsY2UucDRCXCK614aJNdWlHsXIo1jIpUrKkdZT/OC02PsoWmpBFKzTXG78cV+GSQDfkxShE2bmm5w+VsI13NPDxjm290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298630; c=relaxed/simple;
	bh=+f93yqpB0vWTCoxVOTnikZ42TYA/9hQHZf7/f9OTlIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQRF7NFd9fKimNjZhD5T6ri4RYcmzRNsoe9OCxiAqpB9TqCYbbr1KHZJw/ePHqW5Ffu29EpE7pph5721YZdKtPIJAdnDGKVfYbvSAv1kxdLZmjpdh7W1ehgYn9oCO19lQP6oHo1zh2TbDItUGJwieQpCjZaHXniIK/U8A/rkVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHmN7dIu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHmN7dIu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso269459a12.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298628; x=1785903428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
        b=CHmN7dIuuj2RMBWlN5fJVKLsAU+WCRSyPb2BPtKwo3Z4W3hbypnRGMa3vw+0BmQu4e
         L4HyTt3RPKqHVioyJ803CW4pIWLusrfUCDhBBc6zjndNrPNiMJy+LeUrEVhJraJk8nBV
         qFCxam0irIJ1h2S8AFf20uMuFd0XvtanKoxK+ztMZsmRIk5PAqGjJ7vX9dlXvnh0EJgd
         EFB1/THElzwd461P2wCg62Ny83P7EPcIwLqBJrRIKT1M5/nxYBDRqLM8RA4VfUtzZhgC
         Hb3RS0jbWk1FpfT0sAdqJAR2hEvlOn/W8WiZAiiTVa9vpnHL3nP7GiJCHMh/rtU6pthe
         5aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298628; x=1785903428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
        b=MnZVL4Q+ZACYdVcfY/RcZCqfVX20vKdXlhGYclU7wd6CuOTnbPWbkYqM4O6P/29WBc
         zx/jfloKyvQoSbcZ6P29os1QJTbodjwwz/KxvdvekMBVXwS3Gm3o9Q7x36Tu70pg9QBY
         3Sg4HbI/AvLG//zRvPvff2bjX8vF25O+6SO1GuMbE7vdSne4O+ML5u6CJeXNk3ocQ2Qh
         7LM7wDC8RKh3SZziXnzW44djlWET6SEcp+GSgROOf3blMPAsKLpl94GON632NMxOyOeG
         dkppbZlT47fQV83TnI+3MOykSYPDeRgqr798KAjkgLHaN+zaS2PdgfudJ7AshKTAC8RP
         81wg==
X-Forwarded-Encrypted: i=1; AHgh+RrXdrHrFU+ZxwiqQCFdiGzxNRbnhrU+m6YWL6UjbcrLb820Uml1iOZhGdHN0/OVZs8zOkUnZpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Yz8RMWs0vwknqlDFhUpww9mQr3BbOOvF4fEt1kTJIvKAdaKS
	drcV29WIgPGLbiYMEmcHCX+NNqf+RgydE9dy2alFM89ENuI8EsPeo5M=
X-Gm-Gg: AR+sD12+bGBdCFZSBb7fagovr1fN9hXm7/wI/7HLJGFAN0LVmT/lDSYPOW5Vv9ZOEwX
	6HupKkBMBzGl/UyXAdqVZ6mJhJfG9iwUfGiPtD8tpkdm9EBX6ubFiWUjmP6YTfLpDHVKNz1xC9S
	7M5H2xQRS0QUISp90a/FCQt4+w8b/GjsTnRr+uZB1RfzsUCYCh5kDwk+57X/0DDkCd8ElaAaSqC
	cHlrivjlVhzOyQO8sH8sAb+L5vydodsqwkq85r+ec8P52R1TBW/9g9hvpitO139rrh0eVVLRnto
	gGLGl4q9DsDYizMHHpXLCPUIHNEM/Lf92Il5ANlgwKhceeDA3JvP3kLTibV78xPpkkIsic++eYG
	oYdxr8zp612dQ/Xev3NLd1H8dHXJmg2ox2kPQDF7ul+rG+Uvk6FPT+09GUEllIHgPNqQXTjwrAS
	Dtbr5TzkoGeAJ7UZibW5kcxUSFMXRNK33gPCrt91bNJEk4peMzKayte/V1Kwx0vHbVC6R4RMSHG
	JvASxJlm3VWMncLfQHamTixp2/zFpXyF7wDn5My
X-Received: by 2002:a05:6a21:2d43:b0:39f:59c8:f302 with SMTP id adf61e73a8af0-3c8ba5d0a12mr6192619637.37.1785298627978;
        Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:88b0:bed0:1488:2a4e:85f:d739])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b6d14bsm4507589eec.10.2026.07.28.21.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>
Subject: [PATCH] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
Date: Tue, 28 Jul 2026 21:16:56 -0700
Message-ID: <20260729041656.51967-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_xattr_advise_set() calls inode_owner_or_capable() with
&nop_mnt_idmap before allowing the advise xattr to be set, instead of
the idmap that was passed into the handler.

Since f2fs supports idmapped mounts, this compares the caller's fsuid
against the unmapped on-disk owner rather than the mapped owner; resulting
in the actual owner to be wrongly denied with -EPERM. Use the idmap
argument that was already passed to the xattr handler instead.

Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 610d5810074d..281e2fd6c778 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -118,7 +118,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
-- 
2.45.2

