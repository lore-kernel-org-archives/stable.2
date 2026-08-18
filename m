Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D080411F8B
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046338; cv=none; b=PbUNJ9+DHRvzmztj2Z3nOSXhWH62gvALJqCJPeoGE9Q4M37AL9CP13xATWzSzGPixE2Af4+/hWfEg3Fbj6n0fV7nCrvRfVgkqUEprYNOISg3PuFHUzTSXlIui4MGXZPn2IYwd0bkaTchmoBpexgeYdImBTRVEBHd4UrD89E0qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046338; c=relaxed/simple;
	bh=4SkzOidhvnxWCRowJi5VGUs1BjdwjDVLRVBmyyUgQ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B13BMAJvWznUBbC8TZhyAbFZ7kjMULlOQD3O9r1wq+stjQR28K6DK5dV5AtyYOlDlVQPAIwiQKToqLhm7keoOnC1nZX6699YncQz2NBWRqtgFvzt5qTQ8nwLflHr0NTWo67CQVTUZ1m4GrH4uzsTJmzYhfCjFpwHrLln56S5u/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJF6zsk8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJF6zsk8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4474298a91.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046335; x=1787651135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmO09z6pBU4zBJCgyFsTIyoPSkYviKeQVFdIYHsjxTQ=;
        b=aJF6zsk8HbqBUEF5yLUrEBXHBCq2SEMbIqbGYPApyy5T+XTOQFyjfVq05ZNF0t/kLA
         uiHFgQAuo7Jux7RaoHZgUKFA6qoQ0OmFXLx6vjb7yOKxqwbKKU2y8qpqhSsrNL8KvLKR
         pc/NtsD5bolcA2Loha0dh2PuNiXsPtPkPYbMQYoh8WqQj6AvNYK3KMrFBZYZfE/4wPro
         Ia2muMzNUBrv1a6AY7CZgFilZR2wNBwu1RMMpquYMAKaNJVnoioWphl6ShzP5SLLUFkS
         j21vTQvuN8Cnq02/6tm4brjrxauGcmN+uh+k7kpl+cshbFQFkThY/7wmvv6FsTu6Dnu9
         O81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046335; x=1787651135;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hmO09z6pBU4zBJCgyFsTIyoPSkYviKeQVFdIYHsjxTQ=;
        b=jvely/uNbsTFGCLW7dZrrNiIm8nTjBeNiP+fjCimJJ1DfMtgWjeGHuKyyXxu3pGfB6
         FMegkViiu1j8Q9jLjVmyvxjXsUY3MCjaqsLVZx4Mo2pyZDWvmgTJtbqCjFhKf0Wpzbgb
         gO22ZbvFwv3wyuQ+WVMBFcPiUM+gFd5Dm/VrC8VAi2t39aWaVi2QYR/T8nlAezFpQqE5
         MWKZboj0UDQoVDcY593Kwb6afpToNA6P3hnOjRQjWLzRmFc4RbyVhsa52IBBPid4Uv6w
         Q8IlgZHPuwQun/YyyAzWSw3DaoH+v/3RS9qb3tiaofaOwErR+dPabXeu/OsLWzqjHXVx
         psOA==
X-Forwarded-Encrypted: i=1; AHgh+RrrkcM0Sj6F06Jmn+SyhA1SogZpQKROWRSuUN9G4VFqLXzhbRhLAXA1ybpdSs9zg58WsAF0qtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygXhOMUMH7Fn7Kl2sdwLZ3zKGGD4EMLGMuSpoyx7h+s40yTVO
	l7oqrErgac8d3e/Jjw+RQYb1824WWXjuaMyttCJ/i3GAI5M665QJZEiN
X-Gm-Gg: AR+sD12BVGGpMRfRo09vd+tX/kR9bB8eVUuVZQLXXt+gbInX7e/eZpVJW4KkU9WJxvM
	x0JiwPltuWAa4R9wqz1a/Kfq249n2gL82krtgUz0j3kWLy7264CVwcHBH1W8/VBYUhXoi3VvfxA
	A3MBt7C1ewoOiXgQjuSJlZvezeNkJisAKxFRgH2zo4H5rH4kHXMsqDoQLoRiPDaRXIZuB/R+OJM
	tMKzikimoQeQiD23wvMq6GBr/hxnYAlMsVv5C/LNzRMYig4q5v6VuaKzq+ohBIEy+47D0Cv8w//
	zhUJ0sA1tcUN53Fmrc3XCA4Dd+v7U2CkDnBgOJntS+7m80dsbDuo+5fwryJIQ2fSHI/SF5mAids
	9XEjDDBVMyipVtowZsfNLEQYY3mo4OvTaS+T/q5NvALlyQRKSDeogvlQpZwUTe9gpQ0GQ3ZSTrR
	kxdECx6Kr+NaO2m/D2Lu6ygLOQlQzQdDyLwWvwbLz15A+xEMmWs86D6djtRdOQ4ar077498bGjO
	jWXOg==
X-Received: by 2002:a17:90b:4fce:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3955a3dd55fmr10319086a91.1.1787046335508;
        Tue, 18 Aug 2026 02:45:35 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbb41esm7978237a91.10.2026.08.18.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:45:34 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	rtm@csail.mit.edu,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: reject invalid MFT LCNs from boot sector
Date: Tue, 18 Aug 2026 18:45:20 +0900
Message-ID: <20260818-fix-negative-mft-lcn-v1-1-b7b0b206f2da@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=4SkzOidhvnxWCRowJi5VGUs1BjdwjDVLRVBmyyUgQ1c=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqhClU2oiZwfjcTMFenw8/lTVpUGIsotHAi3255
 Z6DYh/0YYuJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaoQpVAAKCRA08jD6945I
 0+SJD/4jZ2+5HVPf48AYEbSr9mfxJtEveHj+Ddz/EKgMZQjQ2xg9FrebKxzfpNBOVOhCFMI1PGC
 dJdi+0janHr/GpqOwUXEg9jIF2XyATVXwBbBxAn2RjFyk/sLHWjUz4nD7vC2WtS49F/IhvprTZ7
 HWTPboihtIDFyuKXYyby4vj5yFtmErCNNXzNRP8SubYgc9WVY98DjtOF7bPIeCXHwL69YGgQogb
 nsjAQswWiZUdpYPvJXhOdh89TCad49TFXOW10q9DeEt+1NeXZmr58Rs9OfReZhzZP7g51KslBG5
 tAVujweN7h6I8AFw++j58VIaBe8viByCOxSwgpRtSrmrRB9x+aSuT3Sl4hNNTgB82lqAtXOadp+
 UUXhWwmi1NMq6fz8mQKLcMO5XtuvODkReI9wnVd11AtbE+fMvkzaZhZl9vjUREc5+qB+ElPvirV
 qShjgsBwowsgsQg5O4PQK5/Cu/gp4qLlfpUyanAbDQhrkhEETOZKne/GpxjVmYgL7RuaMtOpr9x
 3MtzAzMs6ZHfjWfMwmFssRYdQqhUDsrfKzVOoSObbRE+vLX0kF+ajK0irbbQY2HTOdh+2ticIJv
 ABpsCGCFTNnwhdWA7+GrOn/y8yU34yPoUoYZSFA8l8gt3JC9bd10ZG7+EpgwYBZbLr1UQkrRJYs 1ExgES4vfkL+V0w==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

The NTFS boot sector stores the MFT and MFTMirr locations as unsigned
64-bit LCNs, but parse_ntfs_boot_sector() decoded them into an s64.
A crafted high-bit value could therefore become negative and pass
the existing upper-bound check. The invalid value then propagated into
the MFT zone allocator and could result in an out-of-bounds access to
lcn_empty_bits_per_page.

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Closes: https://lore.kernel.org/all/57514.1787000602@localhost
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 8abe7bee4c0d..8a712cafe954 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -645,7 +645,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
 {
 	unsigned int sectors_per_cluster, sectors_per_cluster_bits, nr_hidden_sects;
 	int clusters_per_mft_record, clusters_per_index_record;
-	s64 ll;
+	u64 ll;
 
 	vol->sector_size = le16_to_cpu(b->bpb.bytes_per_sector);
 	vol->sector_size_bits = ffs(vol->sector_size) - 1;
@@ -755,14 +755,14 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
 	 * the same as it is much faster on 32-bit CPUs.
 	 */
 	ll = le64_to_cpu(b->number_of_sectors) >> sectors_per_cluster_bits;
-	if ((u64)ll >= 1ULL << 32) {
+	if (ll >= 1ULL << 32) {
 		ntfs_error(vol->sb, "Cannot handle 64-bit clusters.");
 		return false;
 	}
 	vol->nr_clusters = ll;
 	ntfs_debug("vol->nr_clusters = 0x%llx", vol->nr_clusters);
 	ll = le64_to_cpu(b->mft_lcn);
-	if (ll >= vol->nr_clusters) {
+	if (ll >= (u64)vol->nr_clusters) {
 		ntfs_error(vol->sb, "MFT LCN (%lli, 0x%llx) is beyond end of volume.  Weird.",
 				ll, ll);
 		return false;
@@ -770,7 +770,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
 	vol->mft_lcn = ll;
 	ntfs_debug("vol->mft_lcn = 0x%llx", vol->mft_lcn);
 	ll = le64_to_cpu(b->mftmirr_lcn);
-	if (ll >= vol->nr_clusters) {
+	if (ll >= (u64)vol->nr_clusters) {
 		ntfs_error(vol->sb, "MFTMirr LCN (%lli, 0x%llx) is beyond end of volume.  Weird.",
 				ll, ll);
 		return false;

---
base-commit: df7dce2090342170b7643d36f694204cae7792a9
change-id: 20260818-fix-negative-mft-lcn-596257dd23c8

Best regards,
-- 
Thanks,
Hyunchul

