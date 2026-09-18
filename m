Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116C30C619
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690745; cv=none; b=WgSnj5OVIHhcEi2gQE86vrMgpY8EpEGsDVGYFZNmj94yguxF/1Aav8/RGI341VzU0NyXSJq6GWqjRHXDNJPVRz+Q/PRPJ7aZx0CEJDQWVjGVwh3PEoSZOzeX1w7Vjp2O/64OfGS8zO0PGGAROvtCktTpMKOeVPpoxxJMwcDwgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690745; c=relaxed/simple;
	bh=EJrrArdFExXLBT8+oFTwhGLYUlQwTK9HPYXyg36A5W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1QP2fT3yyefFooHozeu1dr6+gbNfLovgABgc4QmFvNhjDFQosSJz4vivG4pk1qRVzlvqmVKs5IA5WYO+K4E9KS6iGyM1x5NCSuKMSQiz+tqtVaziUWbuFag18I+V5mCexUWzpEKZwyKp1E/ZSPuF4+xCyFBLh0Q3UyjObBY/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwxGhjUL; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwxGhjUL"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso79459a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789690743; x=1790295543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2kWwQAwLBzsFj5hWGDDv4FZQROuRodSEcqUKRJ0GFE=;
        b=WwxGhjULq5VC+W80oVRdkrUjJzHbZku4od16HfY8KfVjsB3+YJvSI2BhEsykcd+mKh
         0ANMcGS9Fl8SsOIITKINzbToRz0bQwZpAmmXHvxEIAfrvPJs7+zLi3LhMV1C8qiOoPdL
         mEddYObKVVKn6fuS+4m9WYwqnzytmgbF87AQHut5BKhlDAGhWUI9MVze7RYAv+0wYvVk
         mZGYi5fcjeLcY9HggcbdTbMpilgPLaU4j7Wospr1/xEvT3cuaHOFD6g1PYtmIGuTK+kc
         TGFxbrWdRN/bDPOX7Fnzb4rwOM5nFTtdzC6ajUEGbXaTdRKp5Jpcx4Mnm7elfKlOdE1f
         ggCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690743; x=1790295543;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2kWwQAwLBzsFj5hWGDDv4FZQROuRodSEcqUKRJ0GFE=;
        b=2mjAP8O8IoZH5X03bGEi80gj4tczAFSSMaoXjofVcnWNgIe4dUDGzv7aiw/CcFarT+
         j+XPABdMuC65fqqIq2ndnVpQIMShvxzr+rRh/r5umTA4SbAxe0bF1jXsb8tEZTftAbkh
         kxyFCsBXtFB7zJBLActZtCn12R1XVwu7Gmy0VKpr/dkQWYU0c8w/dgGW2WlGuldQXaFy
         BggacINBtHyRay9CeYlNHLQf7QakIW/7lYNZdhbrsvzQ7Q2SLexXIzKiBvtaSR380Vif
         mrZe5o+8OaTe1RFfBsSkSaHu1eIBuNY0E1iZkv0D+rFhBR6IrncEACAnGSzgufydbbe7
         42XA==
X-Forwarded-Encrypted: i=1; AKwUvByjnUCvVhIj4rQPiy7PUmZHZfbAxSyp1mB2qtzOithpw3o+nAiVzH6vHn3eLgKQ3BcSOY0vA/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mWvVlZRPjmCxBH1bKyPfoKQxekmga5xZK1b0LJCAsz4FgsaRmA
	ZHE37nHDbSPJ3zYJhSzO272lUe6zRevHc8dx1OOa0cHvx8ibdBh5718b
X-Gm-Gg: AYBFou2StNLsdX82YieWPsE46P2SDoxtAFSD0TY7Ao7SsFFRWT2GPPW1Wcz9BUEvA80
	5Qah6rFa2PuQTssyx8KEmT+TO7WzToHffhBahJDbeDq8xDYOx5GZu0YJ1HN2r8zEJcyvfATm/Eh
	VvN0qI37qlHWXUcpFHn5TT/dqaEXqgQIlw3/YoZRFosUql/68I3uMaoES4ALhKdbHgaRC+sK/Od
	n85vZKa167NDh7YA84fZBPnPOmuC06cZFhAISIFxoEIWd1isXJKYoPxNRpNHoqRCNMk+nF64yFs
	IJg2V7r1c4BH0rmHfN1SwOJjC4n5JSTJsR0rpOFrDeyqtbsvvjdPP25SsaM/W0kqtz1nR2VHSKz
	1WrIAByebPaYY9/xb4VXG3sMlqEXHYhW49Newxr5b/CfMaY3MPgCadxxp0B0ivENaqZlwO6jE1b
	Vqmxo5//ltWev/ClhNy6n7wbtpmjJqIKRpUg0uAB6QhvkANPIZ+VXwDdmqIu7HlCek64d8rRsZy
	rRDxA==
X-Received: by 2002:a17:90b:314c:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39e54e78990mr1569333a91.19.1789690743163;
        Thu, 17 Sep 2026 17:19:03 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a3e3fc9sm82896a91.3.2026.09.17.17.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:19:02 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: fix incorrect VCN units for index blocks in large clusters
Date: Fri, 18 Sep 2026 09:18:53 +0900
Message-ID: <20260918-fix-c8k-index-v2-1-7c7c5d0b78ac@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5496; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=EJrrArdFExXLBT8+oFTwhGLYUlQwTK9HPYXyg36A5W0=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqrINgl2wwa4UzxKQMku92Ac0pJ87ebWS1MPcgN
 ajyPnxS5Y6JAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaqyDYAAKCRA08jD6945I
 0yMbD/44DFJaM5UVpnDxbPRCz1mhldc0s3QWb1VtnsQe9R0YZ0ByXJd5POOP134m3OseE4TMvII
 9p5NzvmdfAo2F5DFAUlaryzK0EJWa4Tqgc8xeRu5fqMA5jds/40RXuw6XCY6oMTiL67zauCVw2J
 Xa6mD3mpV4VhMl4a+M9gtJV8TGf1ki6A7zBrLFX56iUz4wN5AP97MrBFpDHG03e4LLUpimJ0f67
 CW4WDZXwbjqeRDYMHmL8I9JsCFRbBQX2Vt+MABwa0E5VeZKvWWVQTHpIh+Yyzjqo4+bBjSWHBxS
 R6qXY7H928g945IajW99GwotjQ4/qoxdaHDkqYfriGOECut7YGOAjxJoDMaBLpWrnuFY8rIapdq
 geHC4UDFWP9YX/5NkStjiCizYOFK6fn24jsI1UBxH7vaEzobhUj6YeSoBtRBb5Blnmmvu7kBcI1
 9kWfJQA9VfTQAUq4zB9AZaSfRKpsZFloyCrfyaNSN5UbRBqi+ZBd3D7C7DhxEXjWlruALczoZqE
 UYLKMqQsRYdh/vm6N2dLd5f2rowNsedye3kzGgk1mqF61I5maL8WdHtWmW8WNGiFr3KDPd0WvpR
 XwmGohBjhLwuKstdf3IZCShnkRRb18a3DqUINuETNV2zO65ovAn+itfPgT3j5BCvFf3c9ns1rOS gl3YZWVf8xS/Z7g==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

NTFS stores VCNs for index blocks smaller than their cluster in fixed
512-byte units, independent of logical sector size. Use correct block
units when initializing and traversing these indexes so directory indexes
are located correctly.

Verified on a Windows-created 4Kn/32KB-cluster NTFS volume that when the
index block is smaller than the cluster, the VCN unit is 512 bytes.

Fixes: 27d5cd2d940b ("ntfs: fix directory lookup on large-page systems")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Changes in v2:
  - Add a Fixes and Cc tags
---
 fs/ntfs/index.c  | 2 +-
 fs/ntfs/index.h  | 2 +-
 fs/ntfs/inode.c  | 8 ++++----
 fs/ntfs/layout.h | 6 +++---
 fs/ntfs/namei.c  | 7 +++----
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 46a8b19c0723..3e901004bcbf 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -852,7 +852,7 @@ int ntfs_index_lookup(const void *key, const u32 key_len, struct ntfs_index_cont
 	if (ni->vol->cluster_size <= icx->block_size)
 		icx->vcn_size_bits = ni->vol->cluster_size_bits;
 	else
-		icx->vcn_size_bits = ni->vol->sector_size_bits;
+		icx->vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
 
 	icx->cr = ir->collation_rule;
 	if (!ntfs_is_collation_rule_supported(icx->cr)) {
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index 9a03f53bba47..a898e348f2c9 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -37,7 +37,7 @@
  *		(maximum is MAX_PARENT_VCN)
  * @ib_dirty:	true if the current index block (@ia/@ib) was modified
  * @block_size:	size of index blocks in bytes (from $INDEX_ROOT or $Boot)
- * @vcn_size_bits: log2(cluster size)
+ * @vcn_size_bits: log2 of the VCN unit size
  * @sync_write:	true if synchronous writeback is requested for this context
  *
  * @idx_ni is the index inode this context belongs to.
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4375ad477809..d389d89b3ff5 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1021,8 +1021,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			ni->itype.index.vcn_size = vol->cluster_size;
 			ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
 		} else {
-			ni->itype.index.vcn_size = vol->sector_size;
-			ni->itype.index.vcn_size_bits = vol->sector_size_bits;
+			ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
+			ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
 		}
 
 		/* Setup the index allocation attribute, even if not present. */
@@ -1612,8 +1612,8 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		ni->itype.index.vcn_size = vol->cluster_size;
 		ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
 	} else {
-		ni->itype.index.vcn_size = vol->sector_size;
-		ni->itype.index.vcn_size_bits = vol->sector_size_bits;
+		ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
+		ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
 	}
 
 	/* Find index allocation attribute. */
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index 9438fd9b668e..8f5792139d71 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -1880,8 +1880,8 @@ struct index_header {
  * @index_block_size:   Size of each index block in bytes
  *                      (in $INDEX_ALLOCATION).
  * @clusters_per_index_block:
- *                      Clusters per index block (or log2(bytes)
- *                      if < cluster).
+ *                      Clusters per index block, or 512-byte units when
+ *                      the index block is smaller than a cluster.
  *                      Power of 2; used for encoding block size.
  * @reserved:           3 bytes reserved/alignment (zero).
  * @index:              Index header for root entries (entries follow
@@ -1921,7 +1921,7 @@ struct index_root {
  * @lsn:                Log sequence number of last modification.
  * @index_block_vcn:    VCN of this index block.
  *                      Units: clusters if cluster_size <= index_block_size;
- *                      sectors otherwise.
+ *                      512-byte blocks otherwise.
  * @index:              Index header describing entries in this block.
  *
  * When creating the index block, we place the update sequence array at this
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 3e0adb9a0ea4..75e201096525 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -433,9 +433,8 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 			ni->itype.index.vcn_size_bits =
 				vol->cluster_size_bits;
 		} else {
-			ni->itype.index.vcn_size = vol->sector_size;
-			ni->itype.index.vcn_size_bits =
-				vol->sector_size_bits;
+			ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
+			ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
 		}
 	}
 
@@ -569,7 +568,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 				NTFS_B_TO_CLU(vol, ni->vol->index_record_size);
 		else
 			ir->clusters_per_index_block =
-				ni->vol->index_record_size >> ni->vol->sector_size_bits;
+				ni->vol->index_record_size >> NTFS_BLOCK_SIZE_BITS;
 		ir->index.entries_offset = cpu_to_le32(sizeof(struct index_header));
 		ir->index.index_length = cpu_to_le32(index_len);
 		ir->index.allocated_size = cpu_to_le32(index_len);

---
base-commit: 27d5cd2d940b53718f66fb682475587aa993d760
change-id: 20260918-fix-c8k-index-e91b078b1290

Best regards,
-- 
Thanks,
Hyunchul

