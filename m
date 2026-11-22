Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370157;
	b=LZqbTQfBa/GzZEG/oFy94arMCvk5zvuQvFY/3ubRoSL2IlSNuWBS8KoiQ4LyO6szLv7y
	 ACJVXcnJNVc6SoYMqaovMZ21R/e0+Ig/IDreDtTp/YXDbyc9BgGI+p/MhFptJX13mxaMy
	 LhwOou8j4GI9kkR7dhL2kXdldrsnMgk6TSPXQLXWrHADDEMpMG2+TJoLEGY4S4KFBHC8n
	 7bLbJ4Zj2CkUvT3cc92rUFQGPzX8KPVKXdJiC4EybTt2X76jpxWwPykKBw1La3ZVfAZYg
	 R6YYDWPr/0XPGYuavvmbWnvythWoqbxhKEK/ueBotBsGj7L1lwJ3C1f3LYdxekWmzNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370157;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YJuynXecCuAMRPu1fuAj/g8WUJ63sUPX3+ZQ3T0k/jQ=;
	b=YHYHBm88grMQqrM0Tbcd1zyaXAyshXzBz587ElJ8np1SxP95nHroj4XNTrXRg2Z94J5G
	 Vni5r4SbUbkrHuJq4fXfvxw1MCj/B5jTMr4do7VOI/nijuSjPYG7k2baK8k0OpusDiZpC
	 /oOUAyrMoGGJNIeReThCx0TFToSYnROyyku2gMq+dJNHDPs6uIpaMfONSPJ+hC4dsfPPd
	 tGDEk7pMTT5Ayu4OIQmzzjMFpRdqE7AP1R3xVCKMi0oZU1UQ9Jbb9zNq2PE6dsaaIh0CR
	 w0ggc8KfSikyWMSIEDRl6CVRHogZbDGO5uwFa0eYML+xA6ys70ezJnG5Ds0jDkekfuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPMPBSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F214606A32A;
	Sun, 22 Nov 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPMPBSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873161F000C0;
	Sun, 22 Nov 2026 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370157;
	bh=YJuynXecCuAMRPu1fuAj/g8WUJ63sUPX3+ZQ3T0k/jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZlPMPBSqzDmHZOGkU4054fbMNFlF1IGQXsCUJvAri5JYusQq6Fld+r5likMn8ztyc
	 7Mu9eLJLytazLi5qvR4SRWz2zDpkE7rhOdNUxABvNd9cXZh3w9NVbFT/1fK3G2mQjm
	 T/G50bkDLqZAhz5fG4Qa2/PAI4f5SbSBnyUGRdECOvoORfmjY7nKMarfffarIrcue0
	 4p/dISPdQ38AEu/2E5zXoiDU+qVjyi+aRyDPyIeuectPnv6lWYxDSXN57PcX4bQnT8
	 6paLk+KUayEaB0GxbLKlmu55IsoNjLstoFUqG/1K2dQan7NU+By0RS4eluYAbhRKR8
	 sNWFJkwwLQ9lA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:20 +0100
Subject: [PATCH v2 3/4] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-access_shite-v2-3-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=david@kernel.org;
 h=from:subject:message-id; bh=f8MyOmAIcEjLMC9uMSbKvRisK/L7ggF5sRJ95bTUbag=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTpFH06P76o89+bMQV6RhB1rfNnzZyntmJ6i9n3Zg
 XtzTZ5GdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARtlCGv4LXtR5FTwyfuPvV
 mktGH1783zK3bR53UvaTOT9EhOMXVL9g+F9ToTll5fSfRpcOb85ieqIRcuLBUudv8zlK2kTnubP
 HfGAAAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

spufs_mem_mmap_access() calculates the local store offset relative to the
start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
writes access the wrong part of the local store. Mappings created with a
nonzero file offset have the same problem.

Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
already does.

Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 98c47bafaf678..0a46d6f7178ab 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
 				void *buf, int len, int write)
 {
 	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long offset = address - vma->vm_start;
+	unsigned long offset = address - vma->vm_start +
+			       (vma->vm_pgoff << PAGE_SHIFT);
 	char *local_store;
 
 	if (write && !(vma->vm_flags & VM_WRITE))

-- 
2.56.1

