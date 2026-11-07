Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049771;
	b=Fbxq12YypimgJTqBWLu5pSYcHXRyva1LFU85pqyJbx7Fl7zsxb3CKLyBrzb94E+RwRnD
	 ElmMqXcGLAFBbTqTVIw/N8L3YlPsFCmSAS8v4bT82aFrtgLGWUyZ6jLaReHjeebB8YbSC
	 H7omzEFU/CRTnhkH1kZ8S1gEbok+WLqEBVvXiO2cgBPUq72AFIoOCqPmB9K4xXz/CbALY
	 N/e4MqyYwLGDaIKhARq5BRrF4T5iVlXmjmWITpvlhokDIOE1X3kUDG+Y4EyqHRpfo7SkD
	 bsDuNYbhTPj+41G/iGVG+QXlL4/GDBntIblmz+SM4wGQhRTA4jQPezNCPKElF1FEyDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uRsyMcm2omMpYgiI+ey5GQgxQ6nT54ytpe7KfHUYm4Q=;
	b=OYg3AeGGeWP4VKm34OuD/ARKlNvCrdhlQ7Ej1yySVBQ7UDE6J6xwHNRHoHePLH1lUNBz
	 ZMcqoTu5Bqps1Bfr+isYplLhQzvLaAX4J8H+CcV2npDNc7S4J3N3mzhZcDjMJ+DpH7eAo
	 bjL37kh4P+TP/gnnQz7LxFGhcFbOlI0uE0IbHpUL/cGrykQuFylzZbDGbFByp9fNfGJPm
	 VqQhtFnFW7Qqx5SYQYLNquaKjCWfju1KhkFYtiIGavjuNPiv3OAYKkFqt5/32FtR6Yv0q
	 RAa3e7HW7se7aXkq10FYQ4XWm0tC8RiKYtFr1PTxe0jihtKRTEn1kFJ5+alwsmyaRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7+SixFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B793606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7+SixFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4251F008A1;
	Sat,  7 Nov 2026 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049770;
	bh=uRsyMcm2omMpYgiI+ey5GQgxQ6nT54ytpe7KfHUYm4Q=;
	h=From:To:Cc:Subject:Date;
	b=V7+SixFQ9evbYeUthWlfZIzOvmAqBt/YIyqIk/T8Gpt4V3L/OaoJlDujs94LOgFdb
	 fZnq/VUcp8jHSCJkgFkm7htPrdTwEwCaU8GOk8qujR3hzraBTMpmPm4BEyW++oSSLA
	 I1lEj1gCgwS+Ij1pWjHq/UK5CEZYhl5933M16VF73C7WE0H7GikDoJS7b+UJlD36Sq
	 u/frrTXuznKDyAG8nNXQAexWhqQ7Atonbw3piEQ+4M30QnwVURgZj/fkAi0Lukwtbu
	 LC1k/AiA6By4FF2TcsMiQLQJs60yhY8osPoT4JGC1hWYS1E3QAGVKKTYSohDHpZKa8
	 8Zv6ufJ0quYKw==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	wayne.lin@amd.com,
	ray.wu@amd.com,
	daniel.wheeler@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: don't WARN when removing an unallocated MST payload" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:09:29 -0500
Message-ID: <20261107060928-failed-5.15-b18a7c6d75bc@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b18a7c6d75bcc883b39497863cc88c9ef4c6c85f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060928-failed-5.15-b18a7c6d75bc@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b18a7c6d75bcc883b39497863cc88c9ef4c6c85f Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Sat, 26 Sep 2026 17:32:21 -0500
Subject: [PATCH] drm/amd/display: don't WARN when removing an unallocated MST
 payload

[Why]
On an MST teardown that runs through the reset path
(dcn31_reset_hw_ctx_wrap -> link_set_dpms_off -> deallocate_mst_payload),
fill_dc_mst_payload_table_from_drm() is asked to remove a payload whose
vcpi is not present in link->mst_stream_alloc_table and trips:

  WARNING: .../amdgpu_dm_helpers.c:275 fill_dc_mst_payload_table_from_drm

This is a legitimate case, not an error: deallocate_mst_payload() can be
called for a stream whose MST payload was never programmed into DC's
HW-maintained table (a new stream created for a modeset whose enable
never completed, as already documented in deallocate_mst_payload()).
There is simply nothing to remove.

[How]
Drop the ASSERT and fall through to the fill loop, which rebuilds the
allocation table from the remaining entries. The table ends up unchanged,
which is correct: the payload being removed was never in it.

Note the loop must not early-return here - the caller passes a zeroed
proposed_table, so returning early would zero the whole link's table and
drop the other MST streams sharing the link.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5875
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 88a27f624dc0ebc14a7ab274a84d977ce8513cb6)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3217aa82bea24..6febc15ebc2b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -309,7 +309,7 @@ fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 				break;
 			}
 		}
-		ASSERT(i != copy_of_link_table.stream_count);
+		/* Payload absent from HW table when never allocated: nothing to remove. */
 	}
 
 	/* Fill payload info*/
-- 
2.53.0




