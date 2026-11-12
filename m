Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521381;
	b=MoMuWvt6aldQKHpgqKax+rVE4jEmEexW6De16aToghx/zD2CmydzjsF/EVmsVRxetVg9
	 8FhCUjqQXqlUjlEkkxmbADCb4TFPVOeF9HX7FMB9ZSuCi4caWesI2qagxblHlBhg/cPPl
	 a15L996mPz9RUkZgAiGXLygoVX2a8DUFHC6NOdIEZMwXtYjj2f72pUa+ClQNusUcpXFYK
	 Q7BGVL2i2QofoF8jQ10tHHLG93h3U7LA8jv5HEhIqbLmWieG0glupoVMjIBs18LOIbpL7
	 /fnkmmus/g+EoJ7cJxaLWUHLZ0tZT+il1OaLSeJRRMQ4EztbRsCWp9FGGKTxo5gUwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521381;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eKtXaU18XWDmrm51FUDVoZxTbd+Jzy0nR5+iJLVT/Yk=;
	b=2+/u3pzYKI0h1rqgHF82YwqYBpl3/+AgZLioLo6pPCpA9uOteCq/C2xn6e/raByZNxPv
	 2J4B0pB+LkObmQ0gqlUc9lslbulBRBQv84SuBQezW0c9oEs1Gr5njYCt2n92EX8FswoFl
	 xWps1vxPhC2FRsg0a8DP6hfCxkc8BrTOc1ky5jCzQF+f4FWkl/1PWeyt81J2lHXH91Jds
	 kjDv5Nbr6MsPNHJbjSboJoGReUOGb7iVz9wlTKdaRm2QEdQ4N5R3iusCrVrVUBWKDPP2g
	 Cl6yZt7opnrgyh7Bhcci6YhUrLm3TF3HBHuZAQRUgU+HTQGUPuwmy3gWxruQVTwSh/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F1606A321;
	Thu, 12 Nov 2026 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891E1F000C4;
	Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521381;
	bh=eKtXaU18XWDmrm51FUDVoZxTbd+Jzy0nR5+iJLVT/Yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jkL+ZB2a4fUwx27qOVIEV+ckZQ/gSjMPP3h29FpAk4PlOjb9LirgSuhw4zlbzw+TM
	 9Ys06V8UM5KILDGz4kcDcXHt+QdS6IwpIYUNxkrZqklga3AHuZI28CAqsvB6rRKJQy
	 wQcEkO6mrSXip4E8TRbKqS4h6HYP8KFB6IJW4x5SDlh8OyCRis7XriaS13txq3yP1j
	 VjXVrSbG1x1f/e5ytJhhy+FJeef365J72+LX8ayB4cIYe5oD5G+I9hI6Sh9TFxGJH+
	 0jiRerzzmMrSsTaodVJVb8P7sjITxHF4ma/FIxHnXjPAMdZXmioymUii/zY17u1NVp
	 yh2WD0W8m2Nkg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:09:00 +0100
Subject: [PATCH 4/5] powerpc/spufs: consider vm_pgoff in
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
Message-Id: <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
In-Reply-To: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=david@kernel.org;
 h=from:subject:message-id; bh=PQPxNnQpVVFHjjbqHgG191KRAqKJhGnNL5teRs7niOM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfwvmXrNbfL1DTr7E26IRJ7XFjTl6ms4FpmrJVG/6
 pnretUTHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkURQjQ9dyu4gpkQX8Sr0C
 BvVLG3omPVjE/fyifL1Ezg6x9ZxvgxgZpgskTX6gKFW7IzR7p2TykkUhix0bJs+usdJ6c5drnc1
 CVgA=
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
2.43.0

