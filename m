Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050813;
	b=0H4uea710RIuYv/LBWDqONUM7j1qE4EFedGkoL9n9+fCWvU19wxFJCtbY0g/37VfzvlO
	 eXSyLYGusPw5KIbaB2GdB4E2EGeArSS/yTDC+0wBzE3r45E4Z5kYOkkjolMe8o+4cmUC1
	 F8YhJzpl/qVbAowr74lJNwFXqrMKJh1ZG7m/sOtICZWC3e4npso6r1M4CerAdaHczqYOs
	 BkAgAVT0++roqAFxOViH5L6qrz9CMjp5EpVKLTHtaXU5P8PBw1tX5DURYOtXTnRZHmrXe
	 oGrRHWXr7eFgB9ZXca7Lmb8zLcts8IgnT5QkNTdn2X7Msb8xwfkUBOi66hp+JjU3b8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9r8Dd+hYOe0UP6xuHV8jq+p2cOiHYSEg8NaYmsxstcE=;
	b=HDzE1wQFFiaU5ooj6WE1gU0sfaBnVoxdrIXbTpxzsiUOZsaMMaZ28wLSJL9LrD3AuHet
	 NWURTMf+eALAeHev/rZSiVlDDQdCLz93SRwQp3fLPqFByUfuJYiIxiV0PSywGc2YmFr2G
	 cPzW/het3+14nUmkFICUcGTBYbodLExWcuZELm7TIsGcJfeVS9vkqLgo3SkJECQ9qEo6g
	 9UFS1YTnvL0Eo38Dt9bQPNgA0E1AARopBQ0HGb0thFhz1fPYK4k9LQS8zl0V47KUtorpm
	 a8w//Ec3O7wfV9FwjBTmVs7sXuvo+EOfSYSQ0NLXaAqBrWHcRG4VnAZ0okkIxAoLfcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibLfqhVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibLfqhVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AB41F0089F;
	Sat,  7 Nov 2026 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050812;
	bh=9r8Dd+hYOe0UP6xuHV8jq+p2cOiHYSEg8NaYmsxstcE=;
	h=From:To:Cc:Subject:Date;
	b=ibLfqhVJcOxJlgmQnrIdFytpC62Y7ID4lxTmOtzUUeoaTGwzVXpVrZZAyKDAu5qbd
	 TiOEz3qlZGNIXD7pWOeieB94lTy0rwFqTQ1rczK0Hl/G4PEr8T9T9nXmEWYEv21h39
	 p0HZMTaVOMu496tu+22ZtYgRh8ZihPagrSG191D2MH0pVVnNc9a+jSw3dv/8YMAIxn
	 R5WA08SNQAqFfXZFwgLmx0TtudBvLJAvPcYMJyWBtww1icTS6u8cDS8Gh93mOZIZML
	 zdN4M47ATNCAX6fNByTghH0M8N18/XS8Ml/2LyHv1+NOlZLk92FHhqZmqXujsViDvB
	 WHFBRp6mIvdnQ==
From: Sasha Levin <sashal@kernel.org>
To: kmta1236@gmail.com,
	daniel.wheeler@amd.com,
	roman.li@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix swap in median3() for DSC rate control" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:50 -0500
Message-ID: <20261107062650-failed-5.10-7b23bf82ccbd@kernel.org>
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
git cherry-pick -x 7b23bf82ccbdb4cf0752f2b8686e7319a7ce497f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062650-failed-5.10-7b23bf82ccbd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7b23bf82ccbdb4cf0752f2b8686e7319a7ce497f Mon Sep 17 00:00:00 2001
From: Keita Morisaki <kmta1236@gmail.com>
Date: Wed, 23 Sep 2026 11:24:51 +0900
Subject: [PATCH] drm/amd/display: Fix swap in median3() for DSC rate control

median3() is meant to return the median of three values, but its last
compare-and-swap step swaps b and c instead of a and b. When c is
smaller than both a and b, it returns max(a, b) instead of min(a, b).
For example, median3(2, 3, 1) returns 3 instead of 2.

_do_calc_rc_params() always passes 0 as the first argument, and the
second argument is never below 12. So whenever the third argument is
negative, first_line_bpg_offset (and second_line_bpg_offset for 4:2:0)
is set to the second argument instead of 0.

Fix this by swapping a and b in the last step, as intended.

Note that this change does not affect valid DSC configurations. The
third argument is negative only when bits per pixel exceeds the
uncompressed rate of the colour format:

 - 3 * bpc for 4:4:4, 3 * bpc + 2 for RGB

 - 2 * bpc for 4:2:2

 - 1.5 * bpc for 4:2:0

Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1ddc4bc97a62fc89d9d3681413d9f977e1fa1a83)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
index 71eedb3301e49..62673dc8b04ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -45,7 +45,7 @@ static int median3(int a, int b, int c)
 	if (b > c)
 		swap(b, c);
 	if (a > b)
-		swap(b, c);
+		swap(a, b);
 
 	return b;
 }
-- 
2.53.0




