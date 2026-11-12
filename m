Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521359;
	b=rzLl+BvFA7f3qcsC+t9vhDc27l1AUwYUhenJDHj5+Z4SmZrg+J5n5V8/l37fvThDmaw1
	 F+QCCMthof4B8XWxgW4veaxNNrKCu+JN7yCuRqpRUvEhPmGTA2EB8bi6oh1q+MoaDL72+
	 asRq6j23aHG/xlTyFTbyU9Opt00J3D7A8uQ2SO/v/GmXZVj9PicEJxvMXztNpXxiWZAHe
	 O5OIWK0WOf9Eu6YZIHwfdjx8epu4Bq1R1EZjIhePU6CvRq0lW5CFZvowe05P1We6of7Cd
	 4kDRUBzkgSFyZ+NzWzJnMod1IlxTjoj5jSHL3KGHPWpYilyiJJS5Q2+qMic2fpIEZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521359;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mz5C+hrA4fTk82DSD6cW8Q3erNJ0g6GuLKJqSpAAgFk=;
	b=46bZdwdpUP3Ya50zFrXICIxYOhZkkSu0LN/BnrtJCFHxwQ5ZekFvr01JVPpIlNf/Smbl
	 X4zlW5fxgLLIiad2mN5+0f0sgpBXO0yAaRR/EQOkdhli/lTa1wywO/Nm6+7VwbdpvPCTw
	 KCP4vi/37G6NoGMnJED1sdgo1L6+ETtKsdJ/xf+i/xJ80LwGnPPKaT+sckcomcFJTfkZU
	 RvvnX/2QdstdwVxcio6BULKuiZc5ODaBzcxVLNLxWCBarAkkThjZyexVbEtUltSc8p0kL
	 M0GvKMOhi5snat3yYm8s9b24lsHlB+0NEq6qg89XSNEc63wLrL7IYgiOVgEesFXzwzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh8JImBl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC7606A88F;
	Thu, 12 Nov 2026 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh8JImBl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C291F000C4;
	Thu, 12 Nov 2026 22:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521359;
	bh=mz5C+hrA4fTk82DSD6cW8Q3erNJ0g6GuLKJqSpAAgFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vh8JImBlAcjOnz8y7pU8IDWYsh0VqCsMcBMwSe6HbE3/KNMIikgL9fSTP4JOHSZjr
	 71AQirUlRVwjDEcPjEKvKy9nxX5cE2CSgQsjHHZ++J82aM5osTEASy3SwFAVHIi2Al
	 yK6o/209hYacaP0a+i2FCwwTThsYUdQ/iynhfX32OjA7OCxEPQWfl93b5EpcAD7H1T
	 0zOvz0wOrpQ7IFR5/pJeNizPRh9TSkWWwGRcndpgqlf66JpmGI8bbE9R3IRWqoioJL
	 EOsibmII5FAk1frAhSF+hWqu5i5pT6ygxfDHbptiJMSPIkUBz2ZQaHcyldEHV2Njon
	 vuPSfjHEXQyyQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:57 +0100
Subject: [PATCH 1/5] mm: do not call vm_ops->access with FOLL_ANON
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
Message-Id: <20261112-access_shite-v1-1-988a5c470db2@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=david@kernel.org;
 h=from:subject:message-id; bh=Gbkm7xA4sog0FLarlHe8xi7ovZnljYEXfiAf17aaLzU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+Wfy7c+rgyoVXNq89/TK8dlY/s/mZo9w5kz1fSCm0e
 jXN1/W51lHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEtpxh+MMrP+llbnSkpuHW
 xxzz3s7a7tR48FFV/F0Ofb40GdtAoxMM/yOtmW7crbi/7Oi3Se18k46HyTZ+UGSacP7+okuzf3k
 JBrICAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Reading /proc/<pid>/cmdline or /proc/<pid>/environ can block in a device
driver, or read device memory, if the virtual addresses point at a device
mapping.

Ever since commit 7f7ccc2ccc2e ("proc: do not access cmdline nor environ
from file-backed areas") we use FOLL_ANON to only read from anonymous
memory. While GUP properly handles FOLL_ANON, __access_remote_vm()
will fall back on GUP errors to vma->vm_ops->access() without similarly
considering the flag.

Fix it by not calling vm_ops->access if FOLL_ANON was specified, to
truly limit it to anonymous memory only.

Fixes: 7f7ccc2ccc2e ("proc: do not access cmdline nor environ from file-backed areas")
Signed-off-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
[ david: simplify description; slightly rework implementation ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 1a0ec09c56fd7..d4370c1b331c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7398,6 +7398,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				continue;
 			}
 
+			if (gup_flags & FOLL_ANON)
+				break;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.

-- 
2.43.0

