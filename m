Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273425;
	b=VOvIlL+i4vWEobzxwMeu2ux7r9muyb19hJcuj+H8gS2Q552crIMbL3z63HElSH2gAM7z
	 Q5J/2xsfsKRZ6SkpJ8+s5vXNOLP4yDvrML8dAgb5y+P0/LmZ9oonmG7Twt0ghqLCA6zYM
	 yOxIFy1HhF0UkbtCvVeQ3UCcDG0PotF9dR9S6qNfZaE0xeutPX1l3UnQyLYvUwY8eGN7u
	 m+Pr5185tSUS3YuEdk3wxMitok92LXkdoW41KO3CQCXdedht8xwzm6SwSxDdfQaRy64w4
	 uflAVndj3X6e7Cyr9W0JvQlaDxWf0yE6oKZyV+gGQ6nG05ZqmFndxSb2JUB1Wz2Zz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=99bVpuhfGi/yMrsLFKtTFi0GdPYeXIqfJAmwmTcfNZE=;
	b=p86cEn3sM1lKNUsyDU/O5iy0UNipJH26hzid4zSUdaZi3xEJ2a/A0F1YTeLYCfWRBY7k
	 rpG/T/g4lIz5W1ckAXhauzoDSuKxTiNk9HYw80ejbWmAR18a9O7Pxx3Vhii0SfxBepa8g
	 IrnetZdyhW8C1aCiu5Bi/vehDBsnPtSZDGkotmHYwR+JtF6ezw6IGH4AzGYCg3+3at1jD
	 Gz4EmJhsavDPqBhSbO1rLZgz+d2A/vGPSMv3m8J2wmHoWRmOIQaDnmqmDcGyX0uTD1u4v
	 UNXYRqcvqGdcLihrK9H2+pn0fliVbvRB0SaiNL7a/M3q+iaaJMiOMFXferpABkfujUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEM4aFuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2510606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEM4aFuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3891F0089F;
	Tue, 10 Nov 2026 01:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273424;
	bh=99bVpuhfGi/yMrsLFKtTFi0GdPYeXIqfJAmwmTcfNZE=;
	h=From:To:Cc:Subject:Date;
	b=oEM4aFuyspYrmC1QDGtz+EQxiqkpU3e/Ya2oSao6djutOhAkmJ35QA4hLYyicNN6T
	 v+zQAXhWHNdlt4Pf2ECGUIMGzhjWIksfBvL2HWeanVClKThzWb7StvtfLKNADIHDDj
	 +dVAdbFO5Oo5g/C/qwhubev91k3iIElgxkC2PKdoekDuBl3Ol/2dqvfYa/Lmu0dr6j
	 QuY3WtWP2ckeFaWfRJI6kCttrGRf+43QaLBxz5P2aWo8lsRtT4thDU8Jwv9BSHEqly
	 0UiOcVim3wvTEWP2DPVx6tgqWBMsYunlbCgn6uwS658cMRfZZzuyvT++7INKHR+kqk
	 aOA2Kb8YcaUMg==
From: Sasha Levin <sashal@kernel.org>
To: samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	david@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: keep soft-dirty when merging a page" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:02 -0500
Message-ID: <20261109201702-failed-6.1-2efc6332f18b@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2efc6332f18bfd848f74f3d5ba45b31450601faa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201702-failed-6.1-2efc6332f18b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2efc6332f18bfd848f74f3d5ba45b31450601faa Mon Sep 17 00:00:00 2001
From: Samarth Narang <samarth.colleges@gmail.com>
Date: Wed, 21 Oct 2026 11:21:57 -0700
Subject: [PATCH] mm/ksm: keep soft-dirty when merging a page

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty bit of the PTE it replaces is lost.  A page written since
"clear_refs 4" then no longer shows as soft-dirty once it is merged, and a
soft-dirty based dumper treats it as unchanged.

Copy the soft-dirty bit from the original PTE to the new PTE.

Link: https://lore.kernel.org/20261021182157.1873726-1-samarth.colleges@gmail.com
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Xu Xin <xu.xin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b1892..910a1307ac9f3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1463,6 +1463,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve soft-dirty when replacing the page. */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.53.0




