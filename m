Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273239;
	b=ILx2g6qsEsC4MsCdrj8i/7aoO0Sly6YBa3SXbjWU2TtmSgo4VLGIbyfajIdjz3WM+pat
	 PnehHfcZT3+DmdtV/5A0p0uhK3UULooyjR2499Yo1UavAjXb/Z6p6DTyd1Of4NA7CGVo3
	 peoTx9zZwF55+DpPXTe347IcCbxTsule4kE0E4/koxUZIPgvVjKECIO8VP4rcWkadE2VS
	 ZAmDPht9JlhwldqNuXIyLRRNDhP537eok8/0MaS1M15i9ZTgMGf41Slkvd1at6bWrUQUw
	 OG199R/1Z6ZN3DBJ7Q8Ll4h85lgmyXGNEX5fmG7aiUlN6SMoqiuKW9zEAc1kSMoI1dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ib63s7B3fyIv3f0okL+XIenzf1WUzGiFJ8dFG08yPEM=;
	b=uO9LlEUozep87zhUwH5ixi9XTjt+GiuTsgvDepKqzAF7FzhzhW/OpVPPKvSNJtlpcg06
	 5XawK9xyERO95wrU6vX5PoRsL6dfikyhVQNImV5/LqGQ0j1z8gIB2Re3xLW4Iv07sVhWO
	 6qxNP5kdVmZzVPZK13Hg/3SRdrrGBbTDNfEoZKq7wjXMxw7691japGfA9pNDFBW9EU+qg
	 OE0ql6gJCuVWfx1KXQHDjLPvcNtueprQUMyKrhg+RtWRWbjcXlDAQ5xoESPQpRj2lqNI3
	 P5wxDl6zonFtoDuLnNk7GKtN//hEW1oTwG2dPWfMjJCPJkRAx0IT160LdSgvgd+XZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D73kgNja;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D73kgNja
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641551F0089F;
	Tue, 10 Nov 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273238;
	bh=ib63s7B3fyIv3f0okL+XIenzf1WUzGiFJ8dFG08yPEM=;
	h=From:To:Cc:Subject:Date;
	b=D73kgNjatuWImMnqPJOaPgZLpyslwg0WB9eYGwhwhKofbV6iOMwdAa+6bPO4lXfkB
	 i+9OOWGHTr44OfRNfwTkw5ve26j2zpK/Q0KpR1K5ICNKYzn7DZ8uStlMO6fkOJsYnT
	 yL0oP2rHfE/uWcjmLfdYl7vjDtKn68wjZzxqAwbvE902o7RqBDg+/Sz1P7JkieaSkW
	 DH1VuWkQbQ3UOQpj5t9UXVJfeMloVOnu/BAoKCG4jTaLY+F5clmFU44BUHl3H0Da3V
	 jmL+7ToySqv/nb+90oKawrhOYgaArbeiJa+UWFfx0irQsreTZuGbzj2SNF5wM7pA3L
	 4+Q0Rc97iUfyg==
From: Sasha Levin <sashal@kernel.org>
To: bas@basnieuwenhuizen.nl,
	faith.ekstrand@collabora.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Check cs flags." failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:57 -0500
Message-ID: <20261109201357-failed-6.6-f5ea64f9fcd9@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5ea64f9fcd921bc4e2307a262e19450b8a58524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201357-failed-6.6-f5ea64f9fcd9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5ea64f9fcd921bc4e2307a262e19450b8a58524 Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 22 Oct 2026 01:30:54 +0100
Subject: [PATCH] drm/amdgpu: Check cs flags.

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d01e15e76358f60ef6734462d2b6d9972b9dfbc)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d69018a14d96d..a703268ceebaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -189,6 +189,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
-- 
2.53.0




