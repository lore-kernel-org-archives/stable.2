Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050789;
	b=LPlANzuUEjVNU8tMDhUFE9RPuSa8d+2xxDACjTPOhOznvfFOGxCNE9LwSL5+jinWK3qQ
	 yLs3Irtw2DYEz/AyauohIMyNIfovrAGxcRVWi/6zyblINc7dst9Y/DGJD767fXIoMkB0E
	 EaenEGwUefCIpVBwxVqRFOWr1RUkycBcCUsJoI0XCZVpKaZrDiLTYAf9GeEQTI7PL6FYR
	 yoL1zbTMlmbbr3q/hjyBSexCjfP8PkycHDBcjKgWEGFk2C+LfkvovpVZDUeeJNYl11vkl
	 T/g9pcSwZv84pPW0ULqFcKPda27Lyc9cO3tNh9oB2MjA6XqZYJqDx0q/bAoXvwohAdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KTxzd8PrAE7qO0l2WkK367JEezudmIRO3/tD1liGpOM=;
	b=IUFn10jCqSTgb82sFfjErunObU808s84/qwVxtbpEE4eMZwo9qRx37TBDORnL46evNVV
	 Bkw9m7e4f1lRR+EjjDBmgBo5KlMwjiDAK4ioZj3WKNnlA10KXSD7RLxX72Ii8oZYaRvJi
	 /2+XH7ZPQLRLudJ1cWyaLaXDzRDyXrSgbZmCYBppPXyliV9hk1WD4S91uxJ1lcUI1PzlR
	 DfKCyOXBqShjMTvMOj8KrtCOzI9zF8154yqM4QOUz6ruPIVAwnwf9VA34DBju+GLOfzKo
	 a2Ubc7+0xgTHB60PcferfLFGzoFJsTul7cK9sQMnNADIgnEnCUu0C+GRWtaeLLV83Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIqEFmym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIqEFmym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7821F1F0089F;
	Sat,  7 Nov 2026 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050789;
	bh=KTxzd8PrAE7qO0l2WkK367JEezudmIRO3/tD1liGpOM=;
	h=From:To:Cc:Subject:Date;
	b=iIqEFmymj2fk0t6HJYlcfEnWbNnMF3zAcPw3jrciUAHj54k/iRR/UfGpN4Lgds3Aa
	 F4lx5x6+qD6KmayZJ8XcNKUA9wcKVNSJbXVQFyoir1tkijaZVCgr+PuV+A6SA5KdQB
	 G2LkkuQAFgqXxUeyox4idjtP4nJPPjJjea5EdZuj1jvU+bOvBykDZRPwtoqWQxPEuU
	 k5Ts1DKmOxjL+bg3FW4MjRYdsVhzee62diKKH2OU7bADXkMN8ZLBKiYdnakWV6vq7j
	 faQLUeuuxjv0RL5Msg99kAg8A8TLeHKo80MN4VD7GsRTresxq0ZhEFsm5W1owyQ0Rg
	 EDduD42xtpzzg==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	wayne.lin@amd.com,
	ray.wu@amd.com,
	daniel.wheeler@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: don't WARN when removing an unallocated MST payload" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:27 -0500
Message-ID: <20261107062627-failed-5.10-b18a7c6d75bc@kernel.org>
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
git cherry-pick -x b18a7c6d75bcc883b39497863cc88c9ef4c6c85f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062627-failed-5.10-b18a7c6d75bc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




