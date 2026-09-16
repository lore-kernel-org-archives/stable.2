Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDE3FBB4D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542664; cv=none; b=nFZI1nT0G92VE+DhVamecVNbbJJZwOyn9MMVYwqMcWaT8TfbpYjLCbjruVt0CVykA65AzhscCSGmv0HMt7JiQvSTVvdNsUr7hIAc4p5N1T8NM+hgpQZymYDcDonz2MY6ScJXMPfPTOQoNZZNiaN2BufKIUqg3W/j64JKPtVcwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542664; c=relaxed/simple;
	bh=BOyNczjwY1481415FU16xdMtsys9Keob7mvrHoY57e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KH93kicYSRG+9d1xc6eLVct2jV+n7rUNw7ICN42Zx8nbfF8Brg2doRS57d2TJ6S70IwclM3bmkbUgQtmkaNULoRQ9xENmv+WxFsYww+hmPHSgq40jvdumW13DleND83JYBnY1LgD2QMs+Mh6R+zrNnLhyfXypTi71l/yIU2mtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Hc+yMS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Hc+yMS"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so554946a91.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789542650; x=1790147450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ErVH+2TuW07Le+Zr6PYdSFXTlmKMoWUBH05vRHa71x8=;
        b=Y6Hc+yMSfe+hsnXaEZtX4jiXUKsKTY3yCGwkyAkcnzA53slD8ry0eA0CHq5UE9u7x/
         nWuFT3UlMLJMsb6wILYQ3phuf0Fd8RIBkVojEN35xnTxQZDohlZnfMYkQ06Mr3AZYV6Y
         e7iQpmTtEsr00QGf0lTJ7TH6PgWM8qo4602UB/By9zNCvgKd6TEhXXfPcZ+TvucZa4k4
         knXWyROeb3YRoHH8T1TeFUgz2lPQfFz6/8gia35EPprpEcY9/6QIxBFVHW5C4AobRDm+
         v1qprVXmmsTqPoYRLtz6J3cGiQHqtFGZy4Qn6W2q38WQQ/53+WYIP6PmoYKxNEwD1Cb2
         dfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789542650; x=1790147450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ErVH+2TuW07Le+Zr6PYdSFXTlmKMoWUBH05vRHa71x8=;
        b=Qbaq+ny3DfbnWUn8ti7Zlza1JXaWGW7hwCrgyu1noTUlHygMJ9Bk4depeGJwi1GwOY
         mfigf9kPQhvmM0wqyFWvlHSfEkqFoHdmRTAod/IGjNZ2PIFZiUoNXg40Ylu5TQp1/VAm
         WGi6f3Ymvs4xlmrjrk3A7C6Smo8bADgiOBLUJOBZCgsY/7q0NJGverYubajbBrF4f/Za
         7ybss4cMZ1Aq0ZIykA4IVf457+vxOVntSGBZ2OuncpmaV6dUxyt/9nD3gL83ZAs1LO3C
         eJXgBWCGfEZRugZr0N1oK510ZwVZSvY6tsinZAWHzBd8gOtsPSRBnGxo/7XRNgQ53dF7
         DS7A==
X-Forwarded-Encrypted: i=1; AKwUvBzn/6+PcFwrnJEELxzrtGFpTrngHmmaEWiRdcbQS2iq21/1Ycc0Z5z+rjh0W/FT2nA3UJkRpd4=@vger.kernel.org
X-Gm-Message-State: AFuF++mO6tOswoHBT0wFeyda0ekm8l94xP09Vv2IQ5YVxmA4CYXETBnI
	+GGGaVCFCU+crfuOK/6abCG3hLAnVw8EtJ0bEuz92d7+zhInDPV9E/Ad
X-Gm-Gg: AYBFou0RafEB/hSFN66jRumaWTx6+56OxAYb5Y9gL22b9prsD1GjhbNb7z9AjB0U3Yv
	MRIUweSWZ6iSJW6kaNj25SIP1IJ7fsu+CwTXuPVDmo5DcuU18svraujQGQXSgUoR90yeBI2/S/e
	sxmaUEau6le5+SdpLVWw4O0UNQHYrb5GYdeKMrVajPNsiEHx3SkIX6Rs5+Ik0X8hjeQKRfs96Sc
	pvbqgA1jTKQN/zGc6TnKANH+aysvtx9MWebQ6IZqmnY+OFoid/4lbZBX3gRTegwQJYwGjCWY6PS
	yWJu/KovJZ4cfZOTgY+62orZOe7gisUR2Bx6HL3T4S+HMoNqgviJ2ndREU+l8RFROZFtso6XHnX
	2YzOO+XIwHAowiXhwz13lZS5yv7/SZDH5LRL+k3HnswrWqvEgraAGJejx5YP1GEi6VDNw07MSKs
	Wf3l0LPKOS0Gne8MH8oW57z+JV0L0Mrqpt0u7Plhpvf5MkQDgQu4hXE+p3RzJYeyo0YJuqfdRJp
	99dtll7dfwZQt0YQRLFHB+IYSu0d6UZKHU882j2LnFMgE6xPaSgdO1sASwm9VE22OxEDaOKM1Ha
	3NQ64Uyeh7rmPbjGBJNEB0RWsOV/H5hPNp2Wdh3IBFObOZroXOxQI+CdeKmM3rSbzNtLDlfvIA=
	=
X-Received: by 2002:a17:90b:384c:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-39e1e48a02bmr3331357a91.18.1789542649681;
        Wed, 16 Sep 2026 00:10:49 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a9fd38sm5223230eec.13.2026.09.16.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:10:49 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	Matthias Goergens <matthias.goergens@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ext4: drop extra ea_inode ref in cached-block reuse path
Date: Wed, 16 Sep 2026 15:10:46 +0800
Message-ID: <20260916071046.2182813-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_xattr_block_set() takes a reference on the ea_inode via
ext4_xattr_inode_lookup_create() before it builds the new xattr block.
The new-block path drops that reference once
ext4_xattr_inode_inc_ref_all() has counted every entry in the block.
When a separately built block is discarded in favour of an identical
cached block, the cached block already counts its entries and the
lookup reference is left unbalanced.

Each affected reuse leaks one on-disk reference, and the ea_inode and
its data blocks stay allocated after the last xattr referring to them
is gone.  Setting the same xattr on two files is enough when the value
needs an EA inode and the entry does not fit in the inode body: the
second set reuses the first file's block and leaves the ea_inode at
refcount 2, and removing the xattr from both files leaves it at 1.

Drop the reference when the entry was not written into the old block in
place.  new_bh != bs->bh is not the right test: the in-place path can
reach 'inserted' and match a different cached block, and there the
reference belongs to the old block and ext4_xattr_release_block() drops
it, so dropping it here too would under-count.  Conversely, new_bh ==
bs->bh with a cloned s->base (re-setting an unchanged external value on
a shared block) leaks the reference as well, so the check follows both
branches.

If the decrement fails the filesystem is already broken: report the
error and return it without rolling back, putting and clearing ea_inode
first so that cleanup does not retry the decrement.  The reused block
keeps its incremented refcount and its block quota charge; e2fsck
corrects the refcount.

Found by the Sashiko AI review bot while reviewing commit 54b6bd40898d
("ext4: stop retrying saturated xattr cache entries"):
https://sashiko.dev/#/patchset/20260802065941.1726052-1-matthias.goergens@gmail.com?part=1

Fixes: 0a46ef234756 ("ext4: do not create EA inode under buffer lock")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v3:
- Error path per Jan: report with ext4_error_inode() and return, no
  unwinding.  Put and clear ea_inode there so cleanup does not retry the
  decrement.  After a successful decrement the branch reaches cleanup
  with error == 0, which only puts the inode, so nothing is needed there.
  The new-block path is unchanged.
- Keep the in-place condition instead of new_bh != bs->bh; reasons and
  measurements in the reply to v2.
- Changelog: the normal-path leak does not retain quota charges; state
  the preconditions of the example.
- Shorter comment, EXT4_ERROR_INODE(); rebased onto ext4 dev; Cc stable.
v2: fail the operation on a failed decrement instead of masking it.
 fs/ext4/xattr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5c310747b9650..d9e60b5952d2d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2113,6 +2113,24 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			mb_cache_entry_touch(ea_block_cache, ce);
 			mb_cache_entry_put(ea_block_cache, ce);
 			ce = NULL;
+			if (ea_inode && !(bs->bh && s->base == bs->bh->b_data)) {
+				/*
+				 * The cached block already owns its EA inode
+				 * references.  For an in-place update the lookup
+				 * reference belongs to the old block and is
+				 * dropped when that block is released.
+				 */
+				error = ext4_xattr_inode_dec_ref(handle,
+								 ea_inode);
+				if (error) {
+					EXT4_ERROR_INODE(inode,
+							 "dec ref error=%d",
+							 error);
+					ext4_put_ea_inode(ea_inode);
+					ea_inode = NULL;
+					goto cleanup;
+				}
+			}
 		} else if (bs->bh && s->base == bs->bh->b_data) {
 			/* We were modifying this block in-place. */
 			ea_bdebug(bs->bh, "keeping this block");
-- 
2.55.0

