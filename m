Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413919;
	b=41GutH5nx2swFfe4xYP2L8mUKEb2T7rck1qp7y08NZIGkDKOGuk4xu4ymVCZV19hyXnS
	 iUA6g+ViS3/xKSNWuZCMKbxJIX/dDFlczPmPLXmVMSwSuVV5m2EjxDNwqm7RKXk1Wijwp
	 36KKgGvKCOIx2/op90ehqJmaUeSajS4kRNvl1ylDf2g1ZFcWolNXBpJg6T/+IidPysLGu
	 DqN8websch8AHHkh7vBWgMPKPVg3UqmhukIV6vmdxAQ+oqQO+CHkdYMqpk+19Hx3c3sHj
	 +YtH8f0jY0U72AyzzBktGIIZKpjgGRdoiwQ+J1t1HjUhJz0sEJLlgdJrHQKfeVZZYmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1GD4Df7Fux7pFJTIJwvNlT1oVwGjVEElYOnH6LUdavM=;
	b=X9Cra+B051nbpW3R1KgLrjPelyVr9fT7fwUaw+sDYR5bU7oibIWs+BZ/lKylTxB9X92v
	 dE7uizh0sK45xCWAbzAg8g5BYkvITIhyqBFiXhMuuUgiugkM1p8wde4o4DVM2LDFNoL96
	 WD8G36lokqxZOd9evciFbioqQhciXEjKFYC0BqJ5xiXqLeWrum9Wac19iC47vmmxQYFTT
	 7BWK08OuFVVvG18iglOytKA9q6CiC/6BzGWd0CnjinweSNwSPUljgQ3lDW9GXAes7Vfae
	 +WszdaF558wAyUVO+J7in5WoaHK/Y1Q4r3L5JIiGDjqgsr8Zc7WjeKPPBqLnAJqEV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TzwoMaCz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B4606A89B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55B4606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TzwoMaCz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so35125745e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413917; x=1795018717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1GD4Df7Fux7pFJTIJwvNlT1oVwGjVEElYOnH6LUdavM=;
        b=TzwoMaCz9KlhroQfTJItRVBaooOxRed9KVWymwHFSAxMvTL3OfEZFzwDH5SFH9pu/2
         pjJ7J05cK1yCD98UZ0GpRNK7YSqSkWVm5ybdDdD+OuGN8faTepKsNYC1KJCQmfRZslEQ
         Q2q88uZN3KMiQcXYLlQ+piVHe6GE2UYMseYc3Z63fWJ2ZaRT0EnKVtH5GiucikqrwsSz
         /Oya2PJfT1S6kvAQxO4n2zF6lDy3a6i2O/C2eP+Y9xATRQ4gTATcdVvRq+mMCNmFFazS
         3EewfzxhEq6bu9QQ09jkGU2hzRoLQszfILnRTU8pPrYvyQ6sqNqNK0+CSwjWVYU1eILN
         t2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413917; x=1795018717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1GD4Df7Fux7pFJTIJwvNlT1oVwGjVEElYOnH6LUdavM=;
        b=2YwSPagftT45yJU1jsrUq4JBPrvtgPdoVRTRET7U2VplFRY3Meg1Nhs43TKSqyXMSQ
         Oa5eXkxac43AaZ2Ls0UYS842k/WGnzvffCk7AmdaxBtY31RfD3dGocp06luNEr0jFsfm
         L5Kxzz4s3nn9IPHJSHX6wPQTs4Ozx7nwn2+4syjLJEJ1uXD9Zkhsvan+cUdCACtatXol
         YDHFM7vl1F7MBkm/Aed/MqX8tJgJLe7kEak6BIFQBc7EzAYNk8GPouSxAPt7hSM/1Xmb
         PZtEeXaxsycty3uL2VJcF2Gvdhvv0GTsYu/Qe1eNe0ySI2bqLzwllplgRm1UYb6Ke7jT
         4LSw==
X-Forwarded-Encrypted: i=1; AL+hErGic992KXPgh5Qjp5Kiy58gLqu8lO08Lo2HIwRMPXnoeK/+uVHPFMZDkC6DsgW0bchRIRio0+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8upMo8YyY8qjf2PO+DB0Kl4goM1QeLx/szkXU4Si7z0zs7k/YZ
	lSuwVIUKr+cC+dUW/Itd8TxRhnTRLrVHl83NkOwoJmHojPnRENq+ZhcjOrjQpqLXink=
X-Gm-Gg: AYBFou1+OTN3LElW6RV5Voi29KBl1SczABFr6PTC2lSGXyqqvu9X7eWrp4cMGFDVtBy
	YXQF0SrgMuwBKk+YDIJLLyg3dnoHJDA2OocTSrc6dYg/xtFOzhdZ0T1NrTOsNzBqnSEuvVLn8o1
	mAGBVzQftPSi0FxVxWb4JaCgKeGxCH+DaVHH5A5uGRbqjUsZXi7Oovr3gGl7ftD71qQOSa24aZL
	nmt9t5uO4LIR3jez8fFt7kDFNi93B+Td/o++lBHWCFdAdhw2M1HfT5XcHxU60rGqULJICR1wzdQ
	rlltvkU0Y/2l4FoKl7g0SjtjaZvpf/lAYLB8y+okrLbYGPdRUgmRY9jhoxAWiqXtnf62KCHyv5j
	hpCBtwRr3T9gwnZqlVf4KoLE2Mxa8DRwYmtZDtooAclfc5kEuHN5xB4B4PD1X1isnhH6VRankdz
	KIcJjlFb+fgXq1poAC8Pr91DJJ3Fdz1gJ7RgdaXlE+uIGtIAUtKtaYula/RQRRKk66yVdUQimFB
	JM/lPztLZZcK3GmSvQ//J7aDvO/d45+wbAulQqT7Urrg9C3IapjjfVMjtCRjnoq/gcZOkVeN3tN
	1F+M9tWt1zG6o/lwMmt8cYtm3DmcBhMdaisJcVKixWx2GtRxIFC0ZQZaehH3Lbp6OtWjEUMyNWq
	Rf+meAOzAxCw/+6LdDgmuG2DQdlB1LQ==
X-Received: by 2002:a05:600c:c167:b0:4a1:a6e0:4ce4 with SMTP id 5b1f17b1804b1-4ba093acf6dmr49528575e9.33.1794413917166;
        Wed, 11 Nov 2026 08:18:37 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/9] ceph: fix mdsmap use-after-free in __ceph_setxattr()
Date: Wed, 11 Nov 2026 17:18:24 +0100
Message-ID: <20261111161830.1336485-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

__ceph_setxattr() reads mdsc->mdsmap->m_max_xattr_size while holding
only ci->i_ceph_lock, but ceph_mdsc_handle_mdsmap() replaces the
mdsmap and frees the old one under mdsc->mutex.  A setxattr() racing
with an mdsmap update can therefore read freed memory.

mdsc->mutex cannot be taken under i_ceph_lock, so keep a copy of the
limit in struct ceph_mds_client, updated by ceph_mdsc_handle_mdsmap()
under the mutex, and read that instead.

Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c |  1 +
 fs/ceph/mds_client.h |  7 +++++++
 fs/ceph/xattr.c      | 10 ++++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 15df9d22008d..da40f2cb80f2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7247,6 +7247,7 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	} else {
 		mdsc->mdsmap = newmap;  /* first mds map */
 	}
+	WRITE_ONCE(mdsc->max_xattr_size, mdsc->mdsmap->m_max_xattr_size);
 	mdsc->fsc->max_file_size = min((loff_t)mdsc->mdsmap->m_max_file_size,
 					MAX_LFS_FILESIZE);
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ff9ba09f3b59..bd97f73ede20 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -495,6 +495,13 @@ struct ceph_mds_client {
 	struct mutex            mutex;         /* all nested structures */
 
 	struct ceph_mdsmap      *mdsmap;
+
+	/*
+	 * Copy of mdsmap->m_max_xattr_size for readers that cannot take
+	 * the mutex; updated by ceph_mdsc_handle_mdsmap().
+	 */
+	u64			max_xattr_size;
+
 	struct completion       safe_umount_waiters;
 	wait_queue_head_t       session_close_wq;
 	struct list_head        waiting_for_map;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index c6085191c29a..8f97b6448d7a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1211,6 +1211,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct ceph_buffer *old_blob = NULL;
+	u64 max_xattr_size;
 	int issued;
 	int err;
 	int dirty = 0;
@@ -1260,13 +1261,14 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 	spin_lock(&ci->i_ceph_lock);
 retry:
+	max_xattr_size = READ_ONCE(mdsc->max_xattr_size);
 	issued = __ceph_caps_issued(ci, NULL);
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
-	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
+	    (required_blob_size > max_xattr_size)) {
 		boutc(cl, "sync version: %llu size: %d max: %llu\n",
 		      ci->i_xattrs.version, required_blob_size,
-		      mdsc->mdsmap->m_max_xattr_size);
+		      max_xattr_size);
 		goto do_sync;
 	}
 
@@ -1294,9 +1296,9 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	 * prealloc_blob size check below reflects the current tree state.
 	 */
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
-	if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
+	if (required_blob_size > max_xattr_size) {
 		boutc(cl, "sync (size too large): %d > %llu\n",
-		      required_blob_size, mdsc->mdsmap->m_max_xattr_size);
+		      required_blob_size, max_xattr_size);
 		goto do_sync;
 	}
 
-- 
2.53.0

