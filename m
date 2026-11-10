Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273988;
	b=ua1bPdZ4rXjec2/8FE908B7ttXuKkzkVkzOH0+cbMmZo1Ao2Z2n0Go+SBCwLVlkJTUzj
	 d7S+IDnei2N3AH7HiB68VtFfk1Ar/h0u/Y+qdBRFGRHG6mK/ybHu75ar5CG4JnDdDSSJY
	 CjCWb1q6u7826OBB9YEhtXZ20VrHN69qLWAYcBPNFJh31rqlTW9t+P1LQCjRgkFBwpE/9
	 7O71EbhMDyfdGQM9dWUyHvHSW54z/aEiataQIKz7QmZ5Kgz0hishzPWioQf8YpqYMHFvp
	 G2F/jiQ4ELqTADKAMcaA2nfHV9Cw9CySnpwxhxrwOUTn4haKlQWp0MPb8Lpqmumvj8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7KRZ0pO2OqYpvQIDR6mFHwASavs1bzhMcYp40X6SYlc=;
	b=MvLIYiEwGKd0p0fNv7S4acS09V/94E0fixCCynb0KUjO4bXxE0WNSlACpj3aUvJsTHY2
	 UQig3auAhbYWO6on0CDp/ctXu4gDaaHexjTk/X3P/WYyopzno8i3Sg75lnaKRemsP3+Av
	 e6r6GFArH6mtQCxPIUUT8hwbPk/zPNiApL5nldVoQRpl3QDKka+Qkgtf1dv3ybvEDFpBl
	 ZKkOozjX0CGUDGSQ7LdGLENsnUtFlEEuLs64JNLQYIAOscseOaff+lDvE9xnXrn2p3vcg
	 tjgnkJLilm4OQrdceqz1518SJdY3kmfzI1u5hJ58ueudRLqgC786H2t+xypqVrnPCGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAcVps7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BA606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAcVps7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534271F0089F;
	Tue, 10 Nov 2026 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273987;
	bh=7KRZ0pO2OqYpvQIDR6mFHwASavs1bzhMcYp40X6SYlc=;
	h=From:To:Cc:Subject:Date;
	b=jAcVps7Fdv5J81hnP5zm6BJW//703ALvFWyojT596ryLfC56BWsMUOT6r/MVlUUph
	 eCSAE3aA8zJ7qhABkB8gkHdVmKeISCRREQDxRdkXvS7AfmAlSlxeBqdj7zaxsgcnxQ
	 qMTJhcDgThQcuMKpP3BN50DkVrW2bpYvEsq62fvXjRQw42LnBdmIYTXdCSArocBxXm
	 FTEXcr3E04AIfqILixdklcG1/auuwlMLotOuSKdTBriBM5wml02SzM2FLPzaToGwez
	 RGEZOrdv9HjockJ7T3VsNtJu1nts4uEwXBMSXvj4Qc9U04IrSDhGlFZCMgPXur+Y+v
	 UczNZg09tCcHA==
From: Sasha Levin <sashal@kernel.org>
To: tz2294@columbia.edu,
	linfeng.sun.dev@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:26 -0500
Message-ID: <20261109202626-failed-5.10-fd1462c96baf@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fd1462c96bafe2cb14e88c837b270f8990b717b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202626-failed-5.10-fd1462c96baf@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fd1462c96bafe2cb14e88c837b270f8990b717b5 Mon Sep 17 00:00:00 2001
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:34 -0400
Subject: [PATCH] vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error
 path

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Reported-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ad3a157b40502..46169c8eb0220 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1170,7 +1170,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -1206,7 +1206,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -1221,7 +1220,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -1252,7 +1250,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -1267,7 +1264,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm, NULL);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -1279,7 +1276,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}
-- 
2.53.0




