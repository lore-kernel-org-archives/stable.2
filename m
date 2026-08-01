Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8838AC92;
	Sat,  1 Aug 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568428; cv=pass; b=D0doZgH/8WCwPjS3hxH5BobywBcYfVgW/LANfAJ0SMd18HNyYJd6XgkobT5HyvGWlcswmA54UkSyAitdPYUxG7C4TQq01oLwzJKxiJ8HrT8dp4RA5h5l0odWUvqQHydnqQdbyUmISHPAkZacnE4kJ2C80n4jB+OEUHpdfzzrEXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568428; c=relaxed/simple;
	bh=CSq/ZfxhyX69pcg1hfW1WzDgWgKLpAz7yogVKbvQOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoJ3fxyoX5/Xhuxh1yhOOI/sJXQsmj9pzkvAV/xcOccW0/mylNOxPrQKQShrz3UeIMnzPnOSBjU48lrUbL9TwKQfLS+19UrL9GWut7syQa44mfcZNAXBNd9449yQb5fpgxGl5sjo3apaW89KRzpBywNrbkAFmmM7xR300+O0QvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Bqk9iG3d; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Bqk9iG3d"
ARC-Seal: i=1; a=rsa-sha256; t=1785568408; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Z2qM2J24xe3lQ9sI+LShw22vrACDCGdvX0Lq4bXwZ+NKbEzWToh6HHqaOv0tokURTCLiDTuzyISNhnqvFtfBpUZaQzJpp/aGmMZWDFSeO3B+lCr3qwOCIR8kamaw1sPS6Dg4WGBuBykZuaXXoIuukBuQfch1c4yu4+JBY1acq44=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785568408; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3gPiaHvRiE9a7VS3RoeEawkQAvo0NUnPaDkZy2tIKKo=; 
	b=LKu6P7rXfHkIvsiye0ciTyO19UOTk90cdLX3oC8B6RtAvFRpcO61Lu/3o1najXzbnawalW41CfXjnLX+2OJDmMnUlOxq/JuW8wRFy4dhM4BAUNFm83nD7F5Y5+DV0ZQ/sJXJGQ3OSDMJFWSe4escaw7y7siHubma02Mo437sY0Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785568408;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3gPiaHvRiE9a7VS3RoeEawkQAvo0NUnPaDkZy2tIKKo=;
	b=Bqk9iG3dpdapEQNgey6DSZWZua7GBvCwPao9G4QPLmedQGx0/E0mKOefSmJj6HmS
	a6P0HoOGm4aawZxQRl1PFN2lQy/Ce5zmYGQyk6r4tdOPuPGh6a4/DnrRMuKM7V1saQq
	OCncH3OSJ5XbELu+CeAYueHl7TfzjMfqZBG7rssU=
Received: by mx.zoho.eu with SMTPS id 178556840686779.84956335936783;
	Sat, 1 Aug 2026 09:13:26 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ufs: validate cylinder group metadata before caching it
Date: Sat,  1 Aug 2026 10:12:58 +0300
Message-ID: <20260801071306.59484-3-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801071306.59484-1-ali@iusegentoo.com>
References: <20260801071306.59484-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_read_cylinder() copies the cylinder group index and the rotor
positions straight from the on-disk group and caches them without any
check:

	ucpi->c_cgx    = fs32_to_cpu(sb, ucg->cg_cgx);
	ucpi->c_rotor  = fs32_to_cpu(sb, ucg->cg_rotor);
	ucpi->c_frotor = fs32_to_cpu(sb, ucg->cg_frotor);
	ucpi->c_irotor = fs32_to_cpu(sb, ucg->cg_irotor);

They are then used as indices during allocation and free:

  - c_cgx indexes the cylinder summary array as
    UFS_SB(sb)->fs_cs(ucpi->c_cgx), so a value past s_ncg writes a 32
    bit count outside the s_csp allocation.

  - c_frotor becomes a bitmap scan start, start = c_frotor >> 3, and
    then length = ((s_fpg + 7) >> 3) - start. A start beyond the block
    bitmap wraps the unsigned length to a huge value, so ubh_scanc()
    walks far past the cylinder group buffers. c_irotor drives the
    inode bitmap the same way.

A crafted image can set any of these freely, turning an ordinary
allocation into an out of bounds access.

Reject a cylinder group whose recorded index does not match the group
being read, or whose rotors fall outside the group, before the metadata
is cached. Valid filesystems keep cg_cgx equal to the group number and
the rotors within the group, so only malformed images are rejected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/cylinder.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index a2813270c..b930ee1cf 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -68,6 +68,16 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
+
+	/* these on-disk values become array and bitmap indices */
+	if (ucpi->c_cgx != cgno ||
+	    ucpi->c_rotor >= uspi->s_fpg ||
+	    ucpi->c_frotor >= uspi->s_fpg ||
+	    ucpi->c_irotor >= uspi->s_ipg) {
+		ufs_error(sb, __func__,
+			  "inconsistent metadata in cylinder group %u\n", cgno);
+		goto failed;
+	}
 	UFSD("EXIT\n");
 	return true;
 	
-- 
2.54.0

