Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045773;
	b=iaoHmVyI+NI5W51dHHdw7Lm0mCcnhxvUfx7dKf6VnzO9WHTEyGsopVmjSf5qSOIeYzsV
	 BmGvLUnmvTedBuR1pbcEiexkfnCMloGCB4Lt41pv9Y89dOM7egK0BRqoNyOhVrWtpZZNW
	 MlJ06MbdVUM2zN/PAYRoJ3Nms4ay0M2ETMvhY45BdV9u5oc4M0fVrU55dlzW/VemPcMIh
	 qaKl/ir2r/dH2gEPUIeJHTasbFgHWdbwe4SnsaRFtxgRBKyXLwJv6msbtpQVPIlH1+ng9
	 k6YdMp4shou/cvKtsevvN+Rd4S6eoxJvMeKnPAmJ3Bez7oJeesA56dig4T+GBKQcNDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4uimM/gQSj28tpHMgj/hp2HAYaniFT78VzMNtEW95Oo=;
	b=iiYcKs7OTuCAvStiXNswGxbFICsK/99wlavjPGINk5GrrgoLWUy6hZbqRjhAGonOhDr0
	 bWbbDRWA3D2Q4A7v+3W8bOnYm/6WWs9vOW8QDYPfTYAU2oPySRhJIkzK7nYsO5hkQl8Uu
	 iIfxb/HiuIFUzSjdo94MEAJPsY8L40b6ohXRTaxHn4FA5T+tersFMHZuvO5lgYtqQWFq3
	 M0qAqGEowbOMTJZB6PL/c0abnmnEUsSW9iBvZleFw77VVRKZ3K7sdNnGiVclg4x5PFrrr
	 5CF220JpxwQZzyedEG8PZKxY490uUHP4TxpRhjc422F5MuM58f5JTlTbA2vuKjwpN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJuQ2Zwt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJuQ2Zwt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE01F008A2;
	Sat,  7 Nov 2026 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045772;
	bh=4uimM/gQSj28tpHMgj/hp2HAYaniFT78VzMNtEW95Oo=;
	h=From:To:Cc:Subject:Date;
	b=lJuQ2ZwtbCQyAr26BrKTl7R2eNqzYCqh71troXZ7wC4ueqb3bS2curo+cJ86BvtIE
	 pOJCirw2vchWPgIwLJyN4AGjR398PkxO4YneXXKlt9k4d8f6vJUQ+cM8fmyb8N/+xF
	 E6lC9pkJUW//IuxzLQnNVuo3ik4f25pD20gIYuCsTQQV5mi9AgQ1vdySUdRNomgRpd
	 aaAO20EzAle+t/PZYQnddWzmp0N+XSph9cVXKQHbobXJn+ubZ/IyGFMu99v3J4r21W
	 uq57GPhFNtZJy3rVw/ndSxA5xuZYeOShlSsjZmsHg67D2SUm+u3bfGK3iLfNbVIOg9
	 xsdKd5JcStUZw==
From: Sasha Levin <sashal@kernel.org>
To: matthew.auld@intel.com,
	thomas.hellstrom@linux.intel.com,
	matthew.brost@intel.com,
	rodrigo.vivi@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/vram: report FLAT_CCS base misalignment" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:51 -0500
Message-ID: <20261107050251-failed-7.3-d00b7f4f03bb@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d00b7f4f03bbeb2efad872f1686130e18c2b4141
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050251-failed-7.3-d00b7f4f03bb@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d00b7f4f03bbeb2efad872f1686130e18c2b4141 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Wed, 2 Sep 2026 13:41:20 +0100
Subject: [PATCH] drm/xe/vram: report FLAT_CCS base misalignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

So we can easily check if a machine had the CCS bug, when looking back
over bug reports where we have the same machine with newer kernel.

Example print for a machine with the CCS bug:

  FLAT_CCS base:27bbff800, aligned:no

v2 (Matt B):
  - Unconditionally print the base + alignment

Fixes: 37173392741c ("drm/xe/vram: fix ccs offset calculation")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260902124117.918018-9-matthew.auld@intel.com
---
 drivers/gpu/drm/xe/xe_vram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 7b4478fb1697c..56cff1e44530b 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -90,6 +90,9 @@ static int get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size, u64 *poffset)
 		offset |= offset_lo << 6; /* HW view bits 31:6 */
 		offset *= num_enabled; /* convert to SW view */
 
+		drm_info(&xe->drm, "FLAT_CCS base:%llx, aligned:%s\n", offset,
+			 str_yes_no(IS_ALIGNED(offset, SZ_128K)));
+
 		/*
 		 * Everything below this offset is handed to the VRAM
 		 * allocator, so it has to be the *first* address the
-- 
2.53.0




