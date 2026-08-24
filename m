Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BF359A99
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590037; cv=none; b=fJ9u8Iq+wi73mEMaaqvpagAOnRf0I8ITqC0vOgCdXbVqCdwAtb+MoNt1wcUq0EKltXyZA+pWQs8XE+ouVpgn8QwN3bweEyECDo9b+aaWxlcRyMzhAw7Btd3K6dQo8oF5RfDbTl3cj1lD5o3Pootw6LZhJiL7N+6y6vjYbiq5U+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590037; c=relaxed/simple;
	bh=7Eq4H0wXoehn29ByqTM1IIhuFt1x/zpEaGrgoOhjmr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9UD09eyQZvcTomL78423RgaVIvDyC07SlVCEHy5iPfwr+E+Wg+O/DXdE/t+1VQP3CdZUDYHl/qlBKwqmPXj3t8cqZuCdp4C2Cz80iW70UptRcCkjNajemxpdc2fCfQB+GiopyYDQZvazDPjAfT6PeD3MQOJp2uxEDhzsYPQArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hYW/U47M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hYW/U47M"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c16794450aeso536168066b.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787590034; x=1788194834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO5J9Tkq/BMJEuFay0EK1J+ldjBV3PGyGhM7DZqzQJk=;
        b=hYW/U47MZ2bB/sKuhjws8Yo7b8deYavWr5WZxbl5T7zBVXLJfZ3mKRLK1TL5csNgzh
         xln469FsDbJvRm9cHKtC2AYE2E/4rfn3bptbhdTtTgmetXwh2+iBgWIPusUme7KihDb6
         D+nxO5+ZYWTDft6VhbYVnvyQRrGUShjWWOQ9KwpPU46PD2o1rG09UzM7KZ3apenyE9+D
         C36TvxkrNKTFoUsbFUKuYmb/ew2x0NqWYDgPnQCuscXC4FbPqlg9Gpv3d53JU7+rZPfY
         MW6k6YAFJSQezeg+KS3obtjCeZkpuKHgvF/OW2IS4iR01nuEUQMcPpxlyMeOPPwgWqSj
         vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590034; x=1788194834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO5J9Tkq/BMJEuFay0EK1J+ldjBV3PGyGhM7DZqzQJk=;
        b=YDCPgxw9bdvhr3vMHXZd/hZsfOZUJNc14rvnuWTY3j0G5FnAa+Y4lrqvQOaFhkzPiq
         /NUXS1fonGUq3tBOwtJYy9f3B+r0xC2Duw/2YDQ+DwcoDaDyKrHxbFfd87I9yWYXLKKH
         8ybdB5gPcgsi5n4LdMcmJ1biVba9/6R99T9/OA04W6SHEwDdtKc7Y/NEh/a2iZUAefFM
         cCSomeB07jJN9U2VH4ncCoElr1kjf7KNnTNPBY0vfWPVWWVW/ziOqI+MjX6FdskNE+6o
         oLUkOfP0MQEI91lTY9n86DnXZpY8r5y6PJPBYXz4/Nn9P9zjY1wPHZU5GHYOTtAGNHrq
         IcNw==
X-Forwarded-Encrypted: i=1; AHgh+RoJXXZUxFJ8JQMFJ92i+8Wa910SxvuvIA5lYar3+HstApvaiz0zw6RzRbpe/0D3T9WXc8l4k9M=@vger.kernel.org
X-Gm-Message-State: AFuF++n/+c6EXzmF7QeagwVzNDj/qeZsbG8TUoLbU1sMV143xHl/2rTp
	2U8cz21Y+/6wPZ9fWyOSQknseIB7oPz9InB/yX6YNe2Q+/WoddqsV2GKIqsqasqHHNE=
X-Gm-Gg: AR+sD12Agk4+TtfA/iWfsMW0IoEaQm2r5K4uIVzL3DHzaVk2VkIoaQCfKV+0azHWbNR
	W6VmjKZwDReuvzeLEOOx8H7FoXNoaoIhgsSDJOj4jgGsBqihf+Ytz57rqhX3qMKKQfdXXOwXJa0
	Akq4IRyN5Mj5oDf34eWWuMaSSh6jw3N6zRFfyZxQVOgN5U2PpAKiEnohVFaah2Xa46sEqjZe333
	5lxpDIFmeqorGiVqOQOt9bkEBG45zFFysfkwrR0+IrH1sTohRWCfxvKLufsoOCa3w3lSdf440bV
	6i3mGxAlbKQ150t98TqVJrB4GKjWjnDTt9r5jiZbNU/eilR0JJADBYfUMsoy1Tlpz+IN0PHNpgk
	/QVqHyjOBM1teNiIXHnMgOlTaDA/9+CU5Z/P+Um8Ls5ilsKMTlexCWsUC7HTaGUqGx9Vv5WJA8+
	c584Ka8ZafauccuB+dDEEJBcBo14vIue92+2738FM6ewLvxSh3rv1z3a9LAyTVljkLgyy+c57KO
	WtX3oD4ASOxhc0UTt+L2bJEspd/e16Adpd+ovgqGEd2bvKs6BUoAcTzgmDot+TE
X-Received: by 2002:a17:907:fd18:b0:c24:d48a:e1e0 with SMTP id a640c23a62f3a-c24d48ae5c7mr623299266b.14.1787590032837;
        Mon, 24 Aug 2026 09:47:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm9209420a12.9.2026.08.24.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:47:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: lock mutex in ceph_mds_check_access()
Date: Mon, 24 Aug 2026 18:47:07 +0200
Message-ID: <20260824164707.225547-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MDS session OPEN handling replaces mdsc->s_cap_auths under
mdsc->mutex, freeing the previous array and its strings.

ceph_mds_check_access() traverses this array without holding the
mutex.  A concurrent session reopen can therefore free the array while
it is being inspected, resulting in a use-after-free like this:

  Unable to handle kernel paging request at virtual address 003aaad64b2c8bb9
  [...]
  Internal error: Oops: 0000000096000004 [#1]  SMP
  Modules linked in:
  CPU: 56 UID: 2953037534 PID: 1253231 Comm: php-cgi8.4 Not tainted 6.18.45-i2-ampere #1146 NONE
  [..]
  pc : ceph_mds_check_access+0xd4/0x550
  lr : ceph_mds_check_access+0xc8/0x550
  [...]
  Call trace:
   ceph_mds_check_access+0xd4/0x550 (P)
   ceph_atomic_open+0x138/0xbe8
   path_openat+0xa24/0xfa8
   do_filp_open+0x94/0x158
   do_sys_openat2+0x88/0xf8

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 4 ++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c85..0348e8b848ff 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6532,11 +6532,13 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
 	      tpath, mask, caller_uid, caller_gid);
 
+	mutex_lock(&mdsc->mutex);
 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
 		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
 
 		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
+			mutex_unlock(&mdsc->mutex);
 			put_cred(cred);
 			return err;
 		} else if (err > 0) {
@@ -6558,6 +6560,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
+		mutex_unlock(&mdsc->mutex);
 		doutc(cl, "access allowed\n");
 		return 0;
 	}
@@ -6572,6 +6575,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 		      !!(mask & MAY_READ), !!(mask & MAY_WRITE));
 	}
 	doutc(cl, "access denied\n");
+	mutex_unlock(&mdsc->mutex);
 	return -EACCES;
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0ece4c9e3529..8774c7d7d18d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -603,6 +603,7 @@ struct ceph_mds_client {
 	struct rw_semaphore     pool_perm_rwsem;
 	struct rb_root		pool_perm_tree;
 
+	/* protected by mutex */
 	u32			 s_cap_auths_num;
 	struct ceph_mds_cap_auth *s_cap_auths;
 
-- 
2.47.3

