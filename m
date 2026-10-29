Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306130;
	b=3FvMOWs1lRFzHIE7OfIutG8R7kvpVw/thX4CLcOmWFjaoEz+07Nps0zMOhiNW+xVBt79
	 p0vVx3ZzUjyMsbQOd0KNZXrBYk2FmKgb2+v57P0MNKfEmGzIIDrwqGvxMz8K+JXi6oOpx
	 mNYUzvS3oUpQ5g4LcH3nLNGKLgg2pKf4HpgALW7QQg4TgSPkKrqDKQXEf5Xbz9eQ5xhFP
	 tOFe42QKSd1AQ+Y8WV7LLe6F6zmOuJveyIknaXSp7F1tqX1NnJk4ppSxIOvnX3QmsNg1U
	 HwFxd7bPdFLS+fMahn3GmcBtQXJWwcKdLNUGL61Z8+K5yFq79bDzvqAqIfzjlBrSYYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
	b=IB/R6vBxJWW2BDpSGizPGeeXrML+2Ck60d2zONve0+9mwSKN2GOCLJ24311qHGTNslo5
	 +WCLKgET2aUNQI1QZsUDtt0kXFnO9DP06jsJKfX38ruNAabAK6lJohgPqSMFZF4O5hXDt
	 eEGCg4i66Izg7UOwxOEFvCtxhICLsXLtnNfN4lX9KykJFNZ/mvSMqFG6wPQt5pinridaO
	 GXEpSg1OoIxEgkpc/p4VKBzpjcygXXLNGVQuWsvY4RmcWk7MhuUy/j7fIPmqQkRy8FOJl
	 rNeRZjhEAVvmQ7MamadH95ncciKr+z20sp9k76/ZKLHl0KYoklP9adLEz+dD0hY2oxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfElnprs;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44960A2617
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB44960A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfElnprs
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so37015eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793306129; x=1793910929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
        b=zfElnprs3bd8FJhhaiq9y++DLA1RQ7UXviuuuoo6gneNaTe5X1ECba6IhjI91/y9fr
         SI5F/bLYM6xs/u+ranyBHtEL/Y02GuyqZ1NDX5DnozaJmIKv8u0OBMtjIKq4sRLkfYqf
         12iei9PUsCF9KpCjXoM1ATY94bdG5xBns6Zi4673UvqnJBCPZQUnkKRbQaVcecqQSPM3
         WkDN3m8FI2Wn8+LwOdMhpeUup8rnMzTMBAe0+27yRNKgQV13RS0bSmPW1MZCFKmbSz3f
         nNNHBiy9eus2WfiQrWNdeyu9Vy6IyRrhr79ZAGLxtD/3MtAdd5oI+YQCkPajibZNocIz
         EwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306129; x=1793910929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
        b=DSqhBYOrLyN+YaEy7Dp0x7ANBLMFZ03RInADrqaZ3+MEyx0NSjz7H+2t+yMFjnb/Cp
         R/cRIvAg+oNgS/TW2vMEFuOwjDOLgeIwydU+Pqd4xPLjJhAbrt0+cUrAV+g4D4jcPNma
         WWA7ROvKa6fybWT0CJvi4gpEjniME6dIpruV0w+jP8NpFNjwUpoKQT+MPCq/pEqNUvQz
         LLPlgh5ceQXc7dfrAmBpKpIOkpVOBAF7SftSnkEZ4IyRah2lWUA6wrnqBsJGUQaXgr4U
         v2DSL/fHDGFj+Q3pnKG4TyRhHMAde8ntqGVEzzLQv5/6kXzTT6xgVtizXAVvLz0AB3XP
         kzrA==
X-Forwarded-Encrypted: i=1; AKwUvBytkzAQnyIMYaqlTeMWPe/0PWD9fMXUm4eabkVoYCFaaIFUistCsnrHi5f8N5UMMxgJaR1bvRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIllrSal2QigihW+RX4/nw1RvMXRUpNWb1UFGUSlaYzYq61vwmN
	Bg6MRAGRQ0xAzMdK2+hKJcU96yntaGgd37V8LqE3K84/QJH92itUSrld
X-Gm-Gg: AYBFou2R4lEo6T0bHVyApNsSM0CWE6jbHJ6gHjq5es37+U4mJvD73b9lJ+Lcy98DArE
	sSb0tY4+V26jk2Ayntemd80AcrqkvzNjdffjeZUPJuojyimul4dr8wbiKsUc1rfsJnZdwR25Uga
	uxyUNHOBLBzevS9UNGgD1geXxgzuLDEtTnIPLuCvXSmruIFiYCFNvPnXH1vYBFiqDnHDpuOfpxu
	KLi53YrPmVkSBqsYUoPS+AJmeIv+ZJG8dNH93wu1Bfmx2WQIL/th9rjAVGl3um6ezJMH0eByyzH
	rMJoolk2jlMHtN4GV0x2hYhf2edexzGd/5HZAm/Xgp1m3r+s9lh5NFqezl3vgJUd8parZ/xchBu
	9iDQJrsTFAsmxSw6YIDaPB/rhOhcmfwPEnx/3hpbYuLuoQ0WauimGUNnspqP5AvpDV4PvGtaDX0
	7Z2POh2XXnEPJRsN02d5Rgjc89rb0HWNcZdsT3MMGosYKflyad1LUNR9PaTLXJl2LoPSX9hEYDF
	38hGlC0X+FXPDWPtp7MxQQM12GelPXdzjQCE/2hKp3+/hyiUB6tZ2uDrue9mIsRgHk+IkoR0u+2
	1upwA6zOApgWFyd2EcFjBR1MZlht8xrSBds53q+CWZxFpyXyqSo4JUat7ZgHCkijlOk3qsjMM6d
	DRA==
X-Received: by 2002:a05:693c:41c9:20b0:36a:15ee:c20e with SMTP id 5a478bee46e88-36a42430362mr654438eec.33.1793306128640;
        Thu, 29 Oct 2026 13:35:28 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm982137eec.18.2026.10.29.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:35:28 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: preserve colons in symlink targets
Date: Thu, 29 Oct 2026 20:34:57 +0000
Message-ID: <20261029203457.59990-1-dennylin0707@gmail.com>
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

ntfs_nls_to_utf16() parses colon-delimited ADS names when the ads mount
option is enabled. ntfs_create_reparse_buffer() also uses it to convert
the complete symlink target, so "ln -s foo:bar link" succeeds but stores
"foo" as the target. Following a link to a named data stream can then
access the unnamed stream instead.

Add a parse_ads argument and disable parsing when converting symlink
targets. Keep parsing enabled for the other callers to preserve their
existing behavior.

Fixes: be310476e886 ("fs/ntfs3: Add basic support for alternative data streams")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ntfs3/dir.c     |  5 +++--
 fs/ntfs3/fsntfs.c  |  2 +-
 fs/ntfs3/inode.c   |  2 +-
 fs/ntfs3/namei.c   | 10 +++++-----
 fs/ntfs3/ntfs_fs.h |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 14ca54e54578..be3c6a7fc57a 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -173,6 +173,7 @@ static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
  * @uni:	Destination memory.
  * @max_ulen:	Destination memory.
  * @endian:	Endian of target UTF-16 string.
+ * @parse_ads:	Whether to parse an ADS delimiter.
  *
  * This function is called:
  * - to create NTFS name
@@ -182,7 +183,7 @@ static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
  */
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
-		      enum utf16_endian endian)
+		      enum utf16_endian endian, bool parse_ads)
 {
 	int ret, slen, i;
 	const u8 *end;
@@ -239,7 +240,7 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 
 	uni->len = ret;
 	uni->ads_len = 0;
-	if (ret > 0 && ads) {
+	if (ret > 0 && ads && parse_ads) {
 		uname = uni->name;
 		/* Find delimiter in range [1 : ret-2). */
 		for (i = 1; i + 1 < ret; i++) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 97c04ab2763a..b06de8566a72 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2668,7 +2668,7 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 		return -ENOMEM;
 
 	err = ntfs_nls_to_utf16(sbi, label, len, uni, (PATH_MAX - 2) / 2,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, true);
 	if (err < 0)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5a8d362155ac..d883c4b47e83 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1315,7 +1315,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	/* Convert link name to UTF-16. */
 	err = ntfs_nls_to_utf16(sbi, symname, size,
 				(struct cpu_str *)(rp_name - 1), 2 * size,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, false);
 	if (err < 0)
 		goto out;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ae88cb66fb7e..ab9da0faa104 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -45,7 +45,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 		/* Convert input string to unicode. */
 		err = ntfs_nls_to_utf16(sbi, name->name, name->len,
 					(struct cpu_str *)&fname->name_len,
-					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN);
+					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN, true);
 		if (err < 0)
 			return err;
 	}
@@ -82,7 +82,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
 				dentry->d_name.len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 
 	if (err < 0) {
 		kfree(uni);
@@ -437,7 +437,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	sbi = dentry->d_sb->s_fs_info;
 
 	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 	if (err < 0)
 		goto out;
 
@@ -496,7 +496,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 		return -ENOMEM;
 
 	ret = ntfs_nls_to_utf16(sbi, str, len1, uni1, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 	if (ret < 0)
 		goto out;
 
@@ -509,7 +509,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 
 	ret = ntfs_nls_to_utf16(sbi, name->name, name->len,
 				(struct cpu_str *)uni2, NTFS_NAME_LEN,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, true);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 689151fcf993..5475eaeb49fe 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -540,7 +540,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
 		      u8 *buf, int buf_len);
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
-		      enum utf16_endian endian);
+		      enum utf16_endian endian, bool parse_ads);
 struct inode *dir_search_flags(struct inode *dir, const struct cpu_str *uni,
 			       struct ntfs_fnd *fnd, u32 flags);
 static inline struct inode *dir_search(struct inode *dir,
-- 
2.43.0

