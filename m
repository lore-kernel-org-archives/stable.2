Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395C3D6CD8
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123998; cv=none; b=PhkSJWgAO4CGFz0qRVM0hz5lg2u6coJB6jFsLz1BhRj4NeSQ88Gc4jTKm1Vw3XvEZ4htqnlBaa6y2W0pBrxsfOLcChMUiZKoiHgetAbZRRYircvGKLhlclus6x2Z8i2wz0QBUEcFxMhkCl7z+LU4a5P3FV0bNUt3Cs6zWGnlhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123998; c=relaxed/simple;
	bh=SewbY+Oo/Tw2nPKoLGNKhKQUEz+hTDmNyK4kBYHm99Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=feL9gMucVQzk4TwIaE8WTtklnhCaAewjgCSFWeSo7Te4OovGVu3KZhTvd7cQdShsl8eMqoQZD69UYUJ8L5/FxO4n1fAZCGqyVBfO/sn1pEXkaocfa9STHPzbeniHUvEhK/gADz8iganBkRkNZQn/T317UsUniwL+f7sJkwnDvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWssIy0X; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWssIy0X"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d58efc7356so7946315ad.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787123996; x=1787728796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLTbrtg2Gwo+sdFIDsdeh+A0HG/11by1TkaHcpf2lKA=;
        b=YWssIy0XH6mj9HTPovMr4Th3SrcxLt2h/feYsAZDpt27hNbRTznMs3YCIN4Gph9WE+
         SRHIGbP2cS98Kz8cbfECPrF6HuTeoVNT8nvzY2Ov7tcJM/xAHLk+NFzmUGtKwyPaSi94
         LGbtZTnIX4Sh2SM5HUZm6fcm2efSVIMvuLnTu1yFJwqgNIw4lQBEV8CYksAj++d8KqmK
         PkeCYk/zIcIOWU0zw3ZWrqdalpaUriKnaLAZDo94ph76j2mTTDLJmp6jqVrHT9pSRqKt
         Ow1pomfSdlRYgva8dJ2TxG49ue3/9bBflB+aXc65qS91OC4Scp3t+Iax+NNEmNuv8QiJ
         V87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787123996; x=1787728796;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RLTbrtg2Gwo+sdFIDsdeh+A0HG/11by1TkaHcpf2lKA=;
        b=G1+9QkoxGA2Aawpfzr9eUcP2Ll8Ca72X8k6dDNolt+NdXirSPlVtLkHctDUmfkQigK
         NqLKLEhV0Mkb1zPn3vVAYnx1I63oieUHcnvkplkOzKxg7IAj+V9FbwhVyMkpkvJI6Lhd
         SgB4lCQRF0ZTCD1d58YV9nzH+yQM/Cz9cCcAHbp/ON4DnOkl9K02R4pUgIyJ4J4Onypc
         glg8rjycmbnOZzy7GFXD6raC7t2N6vMQsQWoK20JC+Tvyn8nj7Uu0oUgj/bYq0Jc3ZYo
         FwRmALsaa2ApMofzkhZ9SViajwM7OS5L6jqZUSn1qMsB0DglHSAxILhNKNVsA8v0qAee
         eFiw==
X-Forwarded-Encrypted: i=1; AHgh+RrbyI5qZw5oKSh4zrVaUASmUZlaAXT3XPmM0XSoJkLOONwjX4mtDNtn3K0GXe/+PWEGWBokHEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNbsHS46P+GZQL7g10C+uG4YmdVb27sMZ7u85374HJRT12RmH
	yyoKvx8KcVvEomns0/QairslM47wNF8vZDKJ3B+DFcbsH0q53TxhGPUd
X-Gm-Gg: AR+sD10/a53YX3TtXA6egbeMvHt7fageI1i9Gb2PyMsSZAbEjaXeV0bWHVK5LpCOT+W
	9d89GNZou13g8Q5st+nsarzFmHWy8bxcEQ9A6/Z9eGycfi8cxvEccUZH79KriRTE6DEDC7CbUii
	lQXtbSDYfS4uTa35h/PkSlMMEc9IRC0KGSHchD7M/s8K+HgIS3wETrI1e+x/KQq3i+EY3LYKzPS
	aWccIlXsN+JXOGXA8D1hODMC6MeVWXfA/fynROU+Ei5OhpwfOMp7ACb4w1if9JJkr0jA/swptiT
	OMiLTUXbXihARoxBjlUsTcVIRRWS2+1KvmKAeGPIL3fz51cPBScyGqnTUUtGQ/Ny/Gipl6wayqG
	b3jGuTsevoth18y4YGdEXuLgr/lNPo5CPFleeCRzohvUaWTsHxHB6axEyfFzUHF/7enENnFyGcE
	/8BvkhV0alkrMexU3Lo7CqPEnq7SwN3Nbu+KqQbtzOnlHlk1vQYTIQQQofcltP7uYmHwvrZS/C0
	Jg05w==
X-Received: by 2002:a17:902:d48a:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2d5fd6fbe8bmr34571825ad.14.1787123996366;
        Wed, 19 Aug 2026 00:19:56 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ee476bsm20833395ad.75.2026.08.19.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:19:55 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	rtm@csail.mit.edu,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: reject invalid MFT LCNs from boot sector
Date: Wed, 19 Aug 2026 16:19:00 +0900
Message-ID: <20260819-fix-negative-mft-lcn-v2-1-ed9e0d3ee814@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=a/O7jXZsnKbYL+CQh6l8K7m0G+bcoLnwdGb5IlUygRc=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqhVecI4OSeGQI550f3CZhUIYaHNz3olNenYUUr
 VLEGbkB8a+JAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaoVXnAAKCRA08jD6945I
 09aND/9h2U+J3fZjkkKq6O0suhCRLvf4IUnRqUMfl+CaDiSlOrqtj9YMdRZf2d3gzqhOYX3/sRM
 cnX/I9TFlaXrgYD/sM6zQjTr4c2SWRHOzfFmQ55tf3NVx1ncIsg3Py8vBYIqX2AMKtmP9/mKn/k
 SdIG4Fw7/YrFZS2PqsdIDYAmU5tYv/eHG0dYOqKR5urfwUOkcKWRTn17mYbzZh1/oh2dy8eX8Xn
 r8IWgOxYF8yXWD/z+X7lbmf3hngkZJW1Z16JoYssZkzz8qReQiJ7ES+UUKXZJ7hQh+1iCXplBV/
 S5zW8xXlDQ7LGaIymGc13aevBmlFdwBCQlm9dN+pLSVS7XH9xBmGSqHuOFgBqhDfgdwdXiHja7i
 ITg0VGzphLAU4SqNRXU7ycd7lAiEAiygg+MGQMKb/xEoRdHVjjj5hvgTnDmWgVZ7XDuKEUdgHkX
 QQyVeYcjB/mqV54dyIYlvvy/nVo8lhfANt0B1trpKbdwlTTs0m7m01NefDuVIbsZ7hQBGnbPABN
 6D3qng8gX/wyCdibJyr5r37d4CaC2volvt0X7ClQ6rKHIeDocHZTIjYSBLgkDrNCznSoYzBaNq+
 Hk5+0o5uadkpE+2wRBpcj3wJoDskIAE8FK4kk7tbS079QnXHQxT/sXiVZRNYMUHx9iRELyNNsuT
 hPs0czHiT3jCXfw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp;
 fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: quoted-printable

The NTFS boot sector stores the MFT and MFTMirr locations as unsigned=0D
64-bit LCNs, but parse_ntfs_boot_sector() decoded them into an s64.=0D
A crafted high-bit value could therefore become negative and pass=0D
the existing upper-bound check. The invalid value then propagated into=0D
the MFT zone allocator and could result in an out-of-bounds access to=0D
lcn_empty_bits_per_page.=0D
=0D
Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")=
=0D
Reported-by: Robert Morris <rtm@csail.mit.edu>=0D
Closes: https://lore.kernel.org/all/57514.1787000602@localhost=0D
Cc: stable@vger.kernel.org=0D
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>=0D
---=0D
Changes in v2:=0D
  * Change the pr_error format from "%lli" to "llu".=0D
  * Add Reported-by tag.=0D
=0D
 fs/ntfs/super.c | 12 ++++++------=0D
 1 file changed, 6 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c=0D
index 8abe7bee4c0d..cd8fa2c13370 100644=0D
--- a/fs/ntfs/super.c=0D
+++ b/fs/ntfs/super.c=0D
@@ -645,7 +645,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *=
vol,=0D
 {=0D
 	unsigned int sectors_per_cluster, sectors_per_cluster_bits, nr_hidden_sec=
ts;=0D
 	int clusters_per_mft_record, clusters_per_index_record;=0D
-	s64 ll;=0D
+	u64 ll;=0D
 =0D
 	vol->sector_size =3D le16_to_cpu(b->bpb.bytes_per_sector);=0D
 	vol->sector_size_bits =3D ffs(vol->sector_size) - 1;=0D
@@ -755,23 +755,23 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume=
 *vol,=0D
 	 * the same as it is much faster on 32-bit CPUs.=0D
 	 */=0D
 	ll =3D le64_to_cpu(b->number_of_sectors) >> sectors_per_cluster_bits;=0D
-	if ((u64)ll >=3D 1ULL << 32) {=0D
+	if (ll >=3D 1ULL << 32) {=0D
 		ntfs_error(vol->sb, "Cannot handle 64-bit clusters.");=0D
 		return false;=0D
 	}=0D
 	vol->nr_clusters =3D ll;=0D
 	ntfs_debug("vol->nr_clusters =3D 0x%llx", vol->nr_clusters);=0D
 	ll =3D le64_to_cpu(b->mft_lcn);=0D
-	if (ll >=3D vol->nr_clusters) {=0D
-		ntfs_error(vol->sb, "MFT LCN (%lli, 0x%llx) is beyond end of volume.  We=
ird.",=0D
+	if (ll >=3D (u64)vol->nr_clusters) {=0D
+		ntfs_error(vol->sb, "MFT LCN (%llu, 0x%llx) is beyond end of volume.  We=
ird.",=0D
 				ll, ll);=0D
 		return false;=0D
 	}=0D
 	vol->mft_lcn =3D ll;=0D
 	ntfs_debug("vol->mft_lcn =3D 0x%llx", vol->mft_lcn);=0D
 	ll =3D le64_to_cpu(b->mftmirr_lcn);=0D
-	if (ll >=3D vol->nr_clusters) {=0D
-		ntfs_error(vol->sb, "MFTMirr LCN (%lli, 0x%llx) is beyond end of volume.=
  Weird.",=0D
+	if (ll >=3D (u64)vol->nr_clusters) {=0D
+		ntfs_error(vol->sb, "MFTMirr LCN (%llu, 0x%llx) is beyond end of volume.=
  Weird.",=0D
 				ll, ll);=0D
 		return false;=0D
 	}=0D
=0D
---=0D
base-commit: df7dce2090342170b7643d36f694204cae7792a9=0D
change-id: 20260818-fix-negative-mft-lcn-596257dd23c8=0D
=0D
Best regards,=0D
-- =0D
Thanks,=0D
Hyunchul=0D
=0D
