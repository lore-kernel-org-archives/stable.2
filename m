Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF764908C4;
	Wed, 16 Sep 2026 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552248; cv=none; b=idOM3uiGSnO4bPgwQFBLmMnROYPoe0i6DcShzKmGYlqx8HCu+rvQatSxnhT8UFsUoDGh955aUGkh0sATCA5ZRGpwIprh4r/+jrm15z15Gcq7PqOHrx5rBSjNQNgbguwMkHFYDGcJttAWqcRItKKxTk7chSJjvx4Iq1J//7Yo+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552248; c=relaxed/simple;
	bh=u+xXkx+ozWpK6LR0MYCaUkHv35Z96MYakuUypumAtTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtOzDrPwhmf0DirEbb0+NfjGdbf58rOQ9FBwyMWpLAtQdh4qAzhXyXmt7BDCe1mDInWexQ9I0iy4fseSRcmTycgdDh+zgcB8a9KWTw8W74ezCmN3DIVZewWQilsJj7JLBBh97BnWcl78UvA2TaqLkNR4YFdOV39Ug2CJ2Yb2fEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkBgZqpqWKrgBw--.1636S2;
	Wed, 16 Sep 2026 17:50:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Bhawanpreet.Lakha@amd.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	linux-kernel@vger.kernel.org,
	nicholas.kazlauskas@amd.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
Date: Wed, 16 Sep 2026 09:49:56 +0000
Message-Id: <20260916094956.2008436-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wkBgZqpqWKrgBw--.1636S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW3trW3ury5Cw1UKF43GFg_yoW8Aw1xpr
	s5Gw1Fvr9rAF1xta47J3WF9Fy0kw4fJFySkr4UCw1Sva45Jr1rJF1rXr4vgrZrCFZ3ZayY
	qa98J3y7X3ZF93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqQJWZugAAs2

In dm_update_crtc_state(), when a modeset is required the newly created
stream is stored in dm_new_crtc_state->stream and an extra reference is
taken with dc_stream_retain().  The reference returned by
create_validate_stream_for_sink() is released as an extra reference at
the skip_modeset label, leaving the stream owned by the new CRTC state.

If amdgpu_dm_check_crtc_color_mgmt() fails afterwards, the code jumps
to the fail label which releases new_stream again.  Since the extra
reference was already released at skip_modeset, this drops the
reference owned by dm_new_crtc_state->stream and the stream is
released while the atomic state still points to it, leading to a
premature free of the dc stream.

Set new_stream to NULL after releasing the extra reference at the
skip_modeset label so that a later goto fail cannot release the
reference owned by the new CRTC state.

Fixes: 7cd4b70091a5 ("drm/amd/display: Rework CRTC color management")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..28300a3e757a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11706,8 +11706,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 skip_modeset:
 	/* Release extra reference */
-	if (new_stream)
+	if (new_stream) {
 		dc_stream_release(new_stream);
+		new_stream = NULL;
+	}
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.34.1

