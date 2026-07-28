Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08003BB139
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281956; cv=none; b=NGmzBU7eB/ntBfdiMddnB1GLcHVx0naCSUIVHrTbptSfn854UaT6MOkREGiKhF+gBdsxTP65PfhvkRTdC5bY6y6OsK4AJTQyFIEtB18BAtgCvDkcbRbl3O+Mj8PsY4ajJh8KbKfbB973xzM6GaWV7oc7t5HAe5UV2qt7PCmvOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281956; c=relaxed/simple;
	bh=XRMpXRtKkfalPxhM0CiA4AYDEJlnQMcfsUXjBD6mybI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGU3y0XItDtJPyv/tQWsxlu30Mj0WH6Bh/IZb2iQVdiCU2WGX+w4rQPuf14hTjEGgpIiR104AHSWp0EucFF4M7XvQDNirCy/rSejLuzRubHqEfKNzZyKM6S18sf6oh0eaw3xryUo/dUuvP76IyTexcUvr7r5bZv/rXYuRV+sXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY8TxJmB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY8TxJmB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453427d3f4so368830b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281952; x=1785886752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oA2Ply5Hwex1+JOwakFGMwJlbHNQEJQT8Ns3mOL3v74=;
        b=AY8TxJmBSzB6C/nhjTDXoH7MU6fSTu8R4fjb8Pht84He2z0ch/jjazXR2jcE2amUz9
         LveYMOwKU07BDCOoCmjVvGSE0AYaX2aI2Vn76tDccmlkGgYE9CtYwrB3k/+GEIfIL6Pv
         ux1WdeYpQwUatskuOMmUO9OD8fvrKXkmgR2nnbwq3A7uokHYh0tZ7o2Gu0x2hAwZrBE4
         4VSrQbi47jFAQE07wL4iOc3HiriFCGm1nqnycQcnGLcK9H254LwhF7L8jCh78c2MZqA3
         ApWTFVu/GJ7mEXcvmX8cOOCnv1fzlKrKS7rew/9zNZK03oPQPqtF1QYqjMB5P/bYVW/O
         I03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281952; x=1785886752;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oA2Ply5Hwex1+JOwakFGMwJlbHNQEJQT8Ns3mOL3v74=;
        b=CWsa2CLHBH8mM6TUZOgkjcJnO+apzyv0lwgVmVCuoYsnHrcuP3Qg7lnexsrhvaM0qR
         r4RUCNSUsp5FvauXPSpOcLOXa429vmj5iDvGAcuG/8E/xfTdz04DaQwlgXFFxbjGKauo
         dc2Wk06+z4otdAise0nrvfclVDZh223aXOAwMPcs7pXInAGODsQ4iJ83X5C/8KuC6fPY
         4YtPMFO1A+MQd/jWq+SYzEIp5vDGCUK8kByT2ZZlyhpIf2Gt/PsDHA/ekebq48LsjHUv
         PTm54v2WMeMw30OR/Ybx/pvwZa/A4hSmU81ZpdIUWjvNAilsYQeOVqGlTWCPOWbry5R6
         PBOA==
X-Forwarded-Encrypted: i=1; AHgh+RqQXu8S5m8angAC/00G1BxoNJDURm7VBp5jTo6dgxTA0Ws56ewcKstF1FFhJ8R8oV3vI9bzUlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigCOPWFNHsyXb0bo76ijyw86Bt0Dg5mjlsE1nZxQ1NxmziYoe
	zIQHb7Ftqb40JGc6hbJzIUydIhwaT3/vyWQDPG9vyv6g0rxjN3cT6R+X
X-Gm-Gg: AR+sD104ch3/ks4YJqWlTdvHumXKIAqskrSpW8JrVc9052DNwUnuEKdonV7OpzwLqan
	kruDvV4B1lFGVeGbaKMPY2+TmooIaix/EAQMvgKr8MuGWOf/vgE6oTmgpVqGxCvWiVNK1147ekB
	grUhYcrjgxXt1XExnnpTVLbJJxwX4nFOvvwddl0XxkMNTzl+gtb6lW2vcxJbICRfk9poqMw7FZb
	j6XfjgTYX2x9lGj+6A61maWfEDCwlZylNxbRQ9ns1QRCdFP5A9L0DkAuFrBrZ3EJYHHwaJ4ZbMC
	GjCdlXYF28Ba3yd6p4I1EvPBpIPf4HNcDzImYC1d6YMT9gwpIlM1xWLhfYu8PD/c9a3EQMkEEol
	+KRS6+GBMhAUIISzQpZREhzPWyfcpjPB6SkcyGdbnqF3eCuI6nOf3h5HrYbKTi31p/WwuSPuIJt
	yhRuXwUSoGSp6+YYkIkr0MTB1BWfjkWHleZGcTosE+VjWV2/QkuoGH8eCn51LP8cvgZp86WNSSp
	O9lqgJOF7RC
X-Received: by 2002:a05:6a00:2998:b0:838:127d:a167 with SMTP id d2e1a72fcca58-84e9329d68emr4322396b3a.16.1785281951869;
        Tue, 28 Jul 2026 16:39:11 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm496896b3a.35.2026.07.28.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:39:11 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock
Date: Wed, 29 Jul 2026 08:38:32 +0900
Message-ID: <20260729-topic-attr-list-lock-v6-v3-4-7f690b9b98ad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729-topic-attr-list-lock-v6-v3-0-7f690b9b98ad@gmail.com>
References: <20260729-topic-attr-list-lock-v6-v3-0-7f690b9b98ad@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281796; l=4062; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=XRMpXRtKkfalPxhM0CiA4AYDEJlnQMcfsUXjBD6mybI=; b=a6Uq7Wi7bm89XWAvdzUvgyqAhumzOnpJsQNWH/axTq3iqfCCwz0QentGIcVa9zv9o3ljWznrX m5D98vJgq29B6OO/5GuPFzqxil6QJeljySwugzMCpGe7BV4qI2Jx/kV
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
Content-Transfer-Encoding: 8bit

ntfs_attr_update_mapping_pairs() updates several ALEs while rebuilding
a fragmented attribute's mapping pairs and persists the attribute
list once after the loop.  Each ALE update is covered by
attr_list_lock, but the overall publish/persist sequence is not
serialized against concurrent ntfs_attrlist_entry_add()/rm() on the
same base inode.

Acquire attr_list_persist_lock once after resolving base_ni whenever
the call can touch the attribute list, and hold it across every ALE
update and the deferred ntfs_attrlist_update() call.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index b16c95d3ea97..e85dbe3978ca 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -3902,7 +3902,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build, attrlist_changed = false;
+	bool finished_build, attrlist_changed = false, attrlist_locked = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
@@ -3927,9 +3927,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	else
 		base_ni = ni;
 
+	if (NInoAttrList(base_ni) && ni->type != AT_ATTRIBUTE_LIST) {
+		mutex_lock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = true;
+	}
+
 	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		if (attrlist_locked)
+			mutex_unlock(&base_ni->attr_list_persist_lock);
 		return -ENOMEM;
 	}
 
@@ -4003,6 +4010,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		err = ntfs_attr_update_meta(a, ni, m, ctx);
 		if (err < 0) {
 			if (err == -EAGAIN) {
+				if (attrlist_locked) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				goto retry;
 			}
@@ -4039,6 +4050,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			 * attributes and try again.
 			 */
 			if (ni->type == AT_ATTRIBUTE_LIST) {
+				if (WARN_ON_ONCE(attrlist_locked)) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_free_space(base_ni, mp_size -
 							cur_max_mp_size)) {
@@ -4052,6 +4067,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
+				if (WARN_ON_ONCE(attrlist_locked)) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_add_attrlist(base_ni)) {
 					ntfs_error(sb, "Can not add attrlist");
@@ -4165,9 +4184,13 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
 	if (attrlist_changed) {
 		err = ntfs_attrlist_update(base_ni);
-		if (err)
-			goto put_err_out;
 	}
+	if (attrlist_locked) {
+		mutex_unlock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = false;
+	}
+	if (attrlist_changed && err)
+		goto put_err_out;
 
 	/* Deallocate not used attribute extents and return with success. */
 	if (finished_build) {
@@ -4295,6 +4318,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return 0;
 
 put_err_out:
+	if (attrlist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	return err;

-- 
2.43.0

