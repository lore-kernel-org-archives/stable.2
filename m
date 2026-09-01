Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3FE494801;
	Tue,  1 Sep 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285987; cv=none; b=Dp7OpwnV9qTFSVcOzbqVanw0WSC7q/ijzSYfxET8Oxv9GJZsasBiPmT6De97VryEi8XEWzj57ldQLYv7DQaRzEHF8+Y64+p7AaXlKeNUsFlnHp58Umhpu1an99wDs9u2GObPcA6SpqZDiT6UdMgbds8/OeSO3GgI1uDya+LdBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285987; c=relaxed/simple;
	bh=3W8JVYLQkvVQN7to25EbxblwpFAKAuVFh9UmW30i3N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VItTHEYCn/GLPJAAMPZOJaYwxSPIy9WdGXJxysPH9hgCETYZ1/CRytxHqZKlKM+ia5QsFv1Os40JcOn//OkgfQ0yiRHOfkNUOrnVn+hkqfHWyNsAL9QkzG6S56s0c/pb2SPWJS9xx7xZB2uev3BA6YaD2rAOa8HUqtVNbL7Mlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CL4/pghU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CL4/pghU"
Received: from localhost.localdomain (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DEB420B7166;
	Tue,  1 Sep 2026 11:05:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DEB420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788285949;
	bh=dPpGuVKFWxabCbT9X1+NC/BlECnScEpIX1GeAfUkNws=;
	h=From:To:Cc:Subject:Date:From;
	b=CL4/pghUYwiPRKjF+dxKSwmOqV2fl3bq+GtqijeIdX9alwhOipERGR60zU3z4ERTV
	 +PF9Dc5oXlQzrqMrU5XphNUnlVnJJSvtaD8JVfTN4diKNkCtz/jKl71QffuG/wpvxi
	 j+Ao1+/5ApWzvg7jTnrdaz5RjdL/KiIlbkrm8oAk=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	jkoolstra@xs4all.nl,
	neil@brown.name,
	sandeen@redhat.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Subject: [PATCH] ufs: validate cylinder group free bitmap offset
Date: Tue,  1 Sep 2026 14:06:00 -0400
Message-ID: <20260901180600.10394-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ufs_read_cylinder() copies cg_freeoff from the on-disk cylinder group
without checking that the free-fragment bitmap fits in the loaded
cylinder group buffers. A crafted image can place cg_freeoff past those
buffers so that allocation later indexes ubh->bh[] out of range.

UBSAN: array-index-out-of-bounds in fs/ufs/balloc.c:752:15
  ubh_scanc()              fs/ufs/balloc.c:752
  ufs_bitmap_search()      fs/ufs/balloc.c
  ufs_alloccg_block()      fs/ufs/balloc.c
  ufs_alloc_fragments()    fs/ufs/balloc.c
  ufs_new_fragments()      fs/ufs/balloc.c

Reject the cylinder group unless the full BITS_TO_BYTES(s_fpg)
free-fragment bitmap starting at c_freeoff fits in the bytes actually
loaded for that cylinder group.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
---
 fs/ufs/cylinder.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index a2813270c303..fec6c9dfb055 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -33,6 +33,8 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	struct ufs_sb_private_info * uspi;
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
+	u64 cg_bytes, free_bitmap_bytes;
+	const char *err;
 	unsigned i, j;
 
 	UFSD("ENTER, cgno %u, bitmap_nr %u\n", cgno, bitmap_nr);
@@ -48,8 +50,10 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	UCPI_UBH(ucpi)->bh[0] = sbi->s_ucg[cgno];
 	for (i = 1; i < UCPI_UBH(ucpi)->count; i++) {
 		UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i);
-		if (!UCPI_UBH(ucpi)->bh[i])
+		if (!UCPI_UBH(ucpi)->bh[i]) {
+			err = "can't read cylinder group block %u";
 			goto failed;
+		}
 	}
 	sbi->s_cgno[bitmap_nr] = cgno;
 			
@@ -68,6 +72,16 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
+
+	cg_bytes = UCPI_UBH(ucpi)->count * sb->s_blocksize;
+	free_bitmap_bytes = BITS_TO_BYTES((u64)uspi->s_fpg);
+	/* The full free bitmap must fit in the loaded CG buffer. */
+	if (!free_bitmap_bytes ||
+	    (u64)ucpi->c_freeoff + free_bitmap_bytes > cg_bytes) {
+		err = "cylinder group %u has invalid free bitmap";
+		goto failed;
+	}
+
 	UFSD("EXIT\n");
 	return true;
 	
@@ -75,7 +89,7 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	for (j = 1; j < i; j++)
 		brelse(UCPI_UBH(ucpi)->bh[j]);
 	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
-	ufs_error (sb, "ufs_read_cylinder", "can't read cylinder group block %u", cgno);
+	ufs_error(sb, "ufs_read_cylinder", err, cgno);
 	return false;
 }
 

base-commit: 786262be6048deab760f68c8acc2c85607165894
-- 
2.55.0

