Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314762;
	b=gCScleaf1/wrlh3VdHM/zwdbk5tIxRTUjU3a8acMQC5DUZKwwegVoS7/QFCueAKNowts
	 Wm21S8NnkIx0RoYGjv1sC4BlAUxf8oaQkZjNqEp1hg1hbCqXWE94A1r7lq+2EysaMP9TO
	 8UAS8KtX3M4b51RW8lCvuhCytjIW/08T/vH/ndbSQfBtOyIaSranNN4iURBdmCaVupHhD
	 cUM28ue/xBrrlv/6M0BKhu+HCqpkOuzN6pZV4xsYnNDT0qHb5az/fe97KsR+Qj0uCZXVD
	 5eL9UFJecGG3AThIKb7a2gRT4fb2G9yRPRA5zSMNCj2sCdmTd0XvMlkRZ6wBhHe7wUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
	b=EPCvrncQmRtRPWiidCE7F9beXIHiMhS6vrwT/GHQ9l9CZ+hXdcVjYJDPU4/pxCXz1j7h
	 7H/O4Y67PV7SBXfpbaObUc5FG1DglCF4pcLbd3zezGTXwrCRhxVqqIf5OL6SfyEDR3PvL
	 dynyAkfTzoRejTUrGQClC2cMn3dfGOtR5xuyt+OtdG8IGPJRoUVj2300wS9rbAEVRWcOT
	 HpUOtYcltt9v3lbLr7jZHawLa+3+mXh+BtWSwt7bPbQWvjG8z1tdc+kEKL3sNyLCYeiwM
	 juZQR6+ZyFqykYTdy860/QdxFSMxKMpt/cCUrMpESUzWn1nYEjT/5VJGz86HyeaF32Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7NsA0p5;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D511606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D511606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7NsA0p5
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-368c26de2e0so34170eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793314760; x=1793919560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
        b=G7NsA0p5fd/KLkSMaNXs1QyoEcDtA7SSuLtzJRGLXleyUbtLCL0K8yUcVeAlGuTf+X
         6zc9IQMYX5xptgxuLEDlmexa8j4dwiS9UfUsVJYn+Ql0WSpFr9f5zfPE2HGhMC9vcAIw
         znsrhkQ81XEzh1Fa1VKJEJSH6pfraJ8zeSz1g3O4M4Yogk6ytIIbOqqUIHNpFDJvA6+N
         xejnIxBz8NgbRRLhV9ZJmadxoCa1o7v+ktEIgOfg+HQdgPEvlNt1Lk0a6Lqaz0Krjq4Q
         cs8H2bXMD/N+PTImO+AzRLW4/9lxa85vHoL6o8lvJUcvwbwEHX7ggbdaxOdMt2lan3xo
         z+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314760; x=1793919560;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoIbjYHReLG6WDNOTPVhVG9Y8H5GzjW3qhBS6aSgkkg=;
        b=WmoLBX/kcEONpFwdNAXkoa8WKBhjZt40+pB6DNkhOw1olUGQtxyvl6r3Qn4nFRT/dA
         tpiyDqbwev7Ro0TjCVxJbIAw1dnDU+euUOVf31x5e8r0TfG6UzQVeufJ7hzTHX7HCdSe
         Fu2ndzh22D5D+tUBwEI04ifCKL66yWcPgc2EhIdpsozfZIBGJwKtdk2Ni8VixwQanVyz
         xM7jICVBzc4YyLcQW/XHwRnWQTBNfpyhzBWHALLYtfUA6LMGjv1R0wYbf+1hMssQjtwf
         MuOCmAQ4gzryYPz7xGs7l2wcLpxFbh0SwwYXLgV16IC+I2SGKHa+9O2TwN952VYFpxgC
         KRlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJZjUbzw6WyfiLDt0JaVJXFuV1G5L+HiGHPF+OLsaXAwehfKI5dOjVaCf4lnH3sRVhTL2hu9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqMl7GxPa7AbYiPnQePS9deCw57MZiiGU2kczM6qC+WwTQvLv8
	L+yi5KjOOf+eATZB2CYfKKApAMe2dYQFM74X1v3qOk/XqFDYe3PPcbFi
X-Gm-Gg: AYBFou1t6JEHWQzYu2lW5pgtC3C0yhWkPoROlEOTggT2Gkgig6BYTq4Vr6kHWYKOHy0
	Ot0MF/juV0KEBreZhl76AZ4i19ky0yBD5e6V+DEPauNVQY7wHm2MsBHPb0MbTDw8T8dfDUa4qfd
	cPZZi9r7JtmH3mn2XYHxpRrMmKfu971aiJuhhGrcLQZ6lF7P/0XpwmfW03kLgLoXb/zxJw/TjDx
	7E70YBQmR29CI74sAmpUD1bCRQ0+nfTLNid3S62tXwJBOHp6QkqqunH8M9HLF9jHIhYFI8QuOWd
	kQg7B3fXYZ5CeQcoIBbMsSUpQUm9MrbJOzqtWadtsak72vgwnVppmmfrO5tXonN6LvKHuorgaDy
	Z0Xq5pMnwaJuX+mNB5ANwRFt9hPDmvce0J19jJ+CMhaAoclGmNKvs6VXXdqJk+KMo4vjqNnvUKM
	QKx7S/MRyWUFmQtTa6GrMyBeaCM5qxiEoYARMG4Nt18+1u9d9xvVCdlZRbFNn9sRFStt37rN+m/
	1JFBqJoNDcyVqiaj6Al1epNA7Jm+mpGTGRAr5qwEHNG9H/4gWp+b7wYIUNwCDyEHFhdFpZOBXKF
	xCiOYogAU+4JBTlEazpDISVMR27E9f6BXcVw8v552p4ehmRBXSL5DJIn
X-Received: by 2002:a05:7023:a89:b0:1a8:9857:2102 with SMTP id a92af1059eb24-1ac5f183841mr660166c88.30.1793314760261;
        Thu, 29 Oct 2026 15:59:20 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm2009723c88.10.2026.10.29.15.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:59:19 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	xfcyhuang@gmail.com,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: preserve colons in volume labels
Date: Thu, 29 Oct 2026 22:58:56 +0000
Message-ID: <20261029225856.1173-1-dennylin0707@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the ads mount option enabled, ntfs_nls_to_utf16() replaces an
interior colon with NUL. ntfs_set_label() restores the full length, but
does not restore the overwritten character before writing ATTR_LABEL.

For example, xfs_io -c 'label -s Backup:2026' succeeds on an NTFS3 mount,
but the label becomes "Backup" after unmounting and mounting it again.
The same-mount cached label still contains the original input, hiding
the on-disk corruption.

Disable ADS parsing when converting a volume label and remove the
incomplete attempt to undo the split. Volume labels are not stream
pathnames and should retain their complete contents.

Reported-by: 晓风残月 <xfcyhuang@gmail.com>
Link: https://lore.kernel.org/ntfs3/CAC_Ok8x21q=Fy4n7V5j78G3rn5ByHpLVRiM4FrYGaJnmdFiP_w@mail.gmail.com/
Fixes: be310476e886 ("fs/ntfs3: Add basic support for alternative data streams")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
This applies on top of:
  [PATCH] fs/ntfs3: preserve colons in symlink targets
  https://lore.kernel.org/ntfs3/20261029203457.59990-1-dennylin0707@gmail.com/

 fs/ntfs3/fsntfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index b06de8566a72..df939ee18904 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2668,16 +2668,10 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 		return -ENOMEM;
 
 	err = ntfs_nls_to_utf16(sbi, label, len, uni, (PATH_MAX - 2) / 2,
-				UTF16_LITTLE_ENDIAN, true);
+				UTF16_LITTLE_ENDIAN, false);
 	if (err < 0)
 		goto out;
 
-	if (uni->ads_len) {
-		/* Undo delimiter parse */
-		uni->len += uni->ads_len + 1;
-		uni->ads_len = 0;
-	}
-
 	uni_bytes = uni->len * sizeof(u16);
 	if (uni_bytes > NTFS_LABEL_MAX_LENGTH * sizeof(u16)) {
 		ntfs_warn(sbi->sb, "new label is too long");

base-commit: 4a77fa820d937fae9fe0bd6a6795c2d749fd4df7
-- 
2.43.0

