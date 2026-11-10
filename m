Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274011;
	b=feUFeH8Ci0VgrOQ2rvi8cNsFRB/7YF/v0Qvs9dcL5pxJl5qQ8Be8cFU6nEHYI6D6mXbq
	 f/T1C2incMOwH1Rr7T788qNLRT5N10SOP4TAjIMrNbPIlK6+NDH6YbWOOfHuS4glVg6VT
	 PlXUg9MRNYqNyMy+6n/b0h+FvD8dGZ7zwgatjE6cdZvl4EhFEXXoA+YyLqJ5mI1vAZ8hD
	 /3gr57V8CagpTX0pvRtyPot4Zxye1vVsTkcmf1246BxBif9ucIGVrCHZIaNx3x5Agx2YW
	 m8/eIv53GqpdFnLyDyw4U1q3kFNda2oNNBzafTR3zeTZW2DH+HrX4gKm/t/V80cq8HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gKAhdNasWD+QxXwxd4vVi3ZkobbAZ0nF3bF9H2DLe+w=;
	b=bmmjXyO52GR0YG/C4/51YaqofSOXo8TTWpzX38NjCEbkOv3XoJWWPwSV8jf0jdRKKofR
	 Aa+1kDasDt3oOxc8ijPIzSyqrynH1aaEMzOXyzfnEqeNUHHArlDPoa3UsNxUc/xGRCxlA
	 adSegA/xRZhLltvGKiazp4nDx/Gq2kI5VQmC4kNBhoxN5KdH7hNJ18xay0a/DDZDcvYxo
	 sr/+wg53UM1a2fq6EDYqeP3OGGBiNBHbdgWu0CIMzXgl9l36SlKDXzTNF3rIx6ZOk7ljN
	 2Pp3E3J41H5pGGWTA0MWhL5CPCFXjOlfSlOGud5YaxIiz9y5OIaUhIADU+ezEg25QKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHQdnXf2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA26071858
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHQdnXf2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A51F0089F;
	Tue, 10 Nov 2026 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274010;
	bh=gKAhdNasWD+QxXwxd4vVi3ZkobbAZ0nF3bF9H2DLe+w=;
	h=From:To:Cc:Subject:Date;
	b=ZHQdnXf2D+cMK7Dvl5fIKmCjvxRI3JbgxQS5k4lJqW1zX3/87Etg5ytOwDNDuc4Zk
	 SOZ4VHQykW7HZx1ugYeppDhh9L9jgk+eorhBsb7b8Du3glx2catQkRGmzGyl8wOqh8
	 hpsPJh4ilE3KKWEH8RbvdGXH5uhtv5lmeWdcDlfroQTo4t7WawonixoShVZFJpXTQA
	 Z+WwZn6k/iYyWjWgUYXGIIt0WHlvdcIQkr+v1DgNTlEzQLF8mGMMwLu5ctv+V/zT4X
	 sJ0NU3GfodvNZLsZjQsrlaAAnEvK6u7UGpgs3QUjpqdxG/kzaLNJoTP+UnaMAgWhvO
	 kTcU1Ttg9GD9w==
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
Subject: FAILED: patch "[PATCH] mm/ksm: keep soft-dirty when merging a page" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:48 -0500
Message-ID: <20261109202648-failed-5.10-2efc6332f18b@kernel.org>
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
git cherry-pick -x 2efc6332f18bfd848f74f3d5ba45b31450601faa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202648-failed-5.10-2efc6332f18b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




