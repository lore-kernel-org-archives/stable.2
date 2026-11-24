Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522772;
	b=1+FtezDSIT1eLyfarBHjotS8iPuc8cfymJklKJRB7qii+hNWW7wg/ZBpc4+6mFP/GWya
	 vMdchuOiopm+PXrfC2VrwJH34aCAUqHA8ByLP1MirUxtDmC/FXfn9p4hH1U3nimOT2p8i
	 LPerSjDCfJQPUgJ8zJHLV6w8PZXanHOzPeq1GXPP+Ek1ZkW300UCpuQI412QrC2hy+QkL
	 GmLPVNmKrkwfIC+ZpXShIeoz49guS86l5oF42ysiKp4j49AWAY4HDAKx4V/Bf9yE6KobN
	 JnPunN3GCtc/PHEuZuQ1BT6Rk16/iwp9AdgOsMD7PDSCFeQcHatRaWF0aqHIlcopICQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V8j/7x8rOY24muk9yPjpnNTz4+yzbaLuw/EWCrjOA/0=;
	b=UsClVePPYCkrlxNv4jYZPTXFKL3j1scGJ2IYqTndDBATsN4TuJc9XMXwfAIKO59X325F
	 ykziVSh65ezT9sIlQOv0VUOxj5rkHqECK90J74PC57bYufVEUzzaIdiHlkxdzNlYbrutg
	 wpCaLXkL+B1KXQ3DBNyU+j0Nctb5/Mwf0cffn2UZIN4JRj3VNHpVOguFWgaZeYWjCv+z3
	 cOHBVWCeIIMY8qUHlQNkRcrfBaRaq/8nImCmVYws8FX4d1Rqb58l+fGpi5Gx/x/a8ePUN
	 4N+yfa5rciAHZhsA/qNVHr0v0F6pw2duU93d3kUhkedSubyCW9nfgc+z1eVizfK/Tmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSXIIhvf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B391606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B391606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSXIIhvf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so11687659eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795522772; x=1796127572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8j/7x8rOY24muk9yPjpnNTz4+yzbaLuw/EWCrjOA/0=;
        b=LSXIIhvfDUn6KxtqknDVWtbk4AT5uBrpHhNoS11CBzz7o0ujd7HkanuJZDBhs2Mzwd
         5Niv5ww8jtPhybLx9GO3l8F12HU+Hu7DJuthhPwg58Wzvi3cN1i5PG+VFpL21RzXTGAQ
         B+39aBLj1i9uZRrnQ8VzOUP5dytUKRohe1vCUs8AIwvTOQc1CrInIIGcQfd5KPLpVJxO
         ZL5yP90qCMzc+beCP9zDj+Dx9dC9mQMx3KzBPyJdQdk40xO0N1XNikFY2BmPKw4H24J0
         qCufH5NIMwYxh6HpQuvS4xY+Z7VZc+uEjpHRDgTztJqwKaKg4GptrFNqB7W49bgUUig1
         g07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522772; x=1796127572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8j/7x8rOY24muk9yPjpnNTz4+yzbaLuw/EWCrjOA/0=;
        b=GJ/4oMQrw1dwk39jCDNNSlJL2XDwT3Zs9KF2FelOXiOkGuRHVKMDlbpQFe6jchc5dN
         UgRy0Ls/4ibSrvktmkAku/yAxd8ACFtQ/18lE+k9ZuLUefpi5V6Ko4oAcyGDU6j5B/Eo
         A5MsRMS0cz1LnOeqdGk7NyfvcX/HEmBL+aGoVi644IyIt24ltlPrQO7inYSONwLs/mGc
         Q701j+2IKCFXTZok9/JqVikkT86dPSQdnEuYMlwjeu8ZJwC7Gpo3dlCc1k7kyHR8ChrD
         OEcum6y5QJDvHjbOEIZ7rcx7kv++watvdR3m2lCMKYWccAqd9cIGWMu59ekUM62/vu7H
         fmoQ==
X-Forwarded-Encrypted: i=1; AL+hErFYFvpE3YMj1C+h/MA9Zy1p330w8bSXtyM6EMZwKHRFzcHzbtUJt4kyNwplR32eUB/sORSjdXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LoL/ZIirTQQBkMK57vCmQH/cZPLmajifqfKCjS6oTvAJRI9gj
	bbaEEignA5ONPFpbrnB1UgFwZhsu6iVdEwy+5uSzi2Fs0WfWjXPe6woc
X-Gm-Gg: AZFdTZeNkzYOk49APm1InX5EQRBeXM/TGsxiQByuRtJiAcugfjMjN6b44aYMaJAKU/+
	cY8H28TxegYRJzjji3hfrGwislV9BPAWtKrqc+5CuqLBsmuAUtgUMe4p7PAB9adJ46Tgw2nuuq+
	He5q4BvyZlTyNsQa0BXLs/XNLwYmSGOi7pMMXr0uXHdurS3OcNRKIBMxlnne8KzW5yqTYZtoSie
	5w+7aLvhjNVi5zcIAxkY+VqIZVUKKnPd6vGZ0wdDgZBzK4o1USxLbGE8PKob98/a3r/sjpkeXcp
	7J/ecAjt+P6oPfhAGCP+CgRvTfCqM87qNV4O6aAKArbndsBhJtqDant/h8lgxZDdhJV6s4dkxDL
	NeoFtiIMrWY28Cm88fK5gKorLKmMCAIkE59CTZ8D+BFTZyPztfWCu3p92Fc6bFy4Ldrrvb6FIvq
	VNnvDQn4uqnGvG6FLt1ZS7R6t6RfdG2bQgnIO56Pdy7yDkeb7s5YPTz9qAJ7uvfj5hOGfDLdjCV
	1l0b1MU72uheWN7eCVy0SnfH0yKsAvAOyCnSwJwBxOzYcjlY5eg4+ZCrLFWYFLcDgu181jHna3k
	IGZfYaWafBAuDcioHhkZdnmS3nXtNZG09LYjQsLRFXIquiukQ1bYXadH96xhhnJ7DXHUX+JCY1h
	2V7jyNYYOWavZMVBH1Sl9e+g6KNXfinO7siA=
X-Received: by 2002:a05:7301:6582:b0:374:e25e:a533 with SMTP id 5a478bee46e88-38570154017mr27803686eec.35.1795522771545;
        Tue, 24 Nov 2026 04:19:31 -0800 (PST)
Received: from hyeonjun-ThinkPad-X13-Gen-1.. ([124.197.199.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm48153278eec.14.2026.11.24.04.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:31 -0800 (PST)
From: Hyeonjun Hong <hyeonjunhong330@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Hyeonjun Hong <hyeonjunhong330@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: v4l2-ctrls: set handler error if array allocation fails
Date: Tue, 24 Nov 2026 21:17:30 +0900
Message-Id: <20261124121730.1598114-1-hyeonjunhong330@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control framework lets drivers create controls without checking
every call: a function that fails stores the error in hdl->error and
returns NULL, and the driver checks hdl->error once at the end.

v4l2_ctrl_new() does not follow this when the allocation of
ctrl->p_array fails. It frees the control and returns NULL, but leaves
hdl->error untouched, so the driver sees no error and carries on with a
NULL control pointer.

vivid hits this with its pixel array control. vivid_create_controls()
returns 0, and vivid_create_instance() goes on to call
vivid_update_format_cap(), which passes dev->pixel_array to
v4l2_ctrl_modify_dimensions() and dereferences it in v4l2_ctrl_lock().

Reproduced with fault injection (failslab and fail-nth) by failing that
allocation while loading vivid:

  KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
  RIP: 0010:vivid_update_format_cap+0xc83/0x1b30 [vivid]
  vivid_probe+0x37de/0x90b0 [vivid]
  platform_probe+0x9e/0x140
  really_probe+0x1cb/0x6b0

The allocation was first added for dynamic arrays only. Commit
5f2c5c69a61d ("media: v4l2-ctrls: allocate space for arrays") then
extended it to all array controls.

Set hdl->error to -ENOMEM in this error path, like the other allocation
failures in v4l2_ctrl_new() do. The vivid probe then fails with -ENOMEM.

Fixes: fb582cba4492 ("media: v4l2-ctrls: add support for dynamically allocated arrays.")
Cc: stable@vger.kernel.org
Signed-off-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
---
Found with a fault injection sweep over the vivid module load path
(fail-nth, one failed allocation per load) on media-committers next.
An LLM assistant helped with the sweep tooling, the analysis and the
wording of this changelog.

Tested by re-running the sweep with the fix applied: failing the
p_array allocation, including the one for the pixel array control, now
makes the vivid probe fail with -ENOMEM and no longer oopses.

 drivers/media/v4l2-core/v4l2-ctrls-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 6e751a043a21..12a799824c44 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -2263,6 +2263,7 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
 		ctrl->p_array = kvzalloc(2 * elems * elem_size, GFP_KERNEL);
 		if (!ctrl->p_array) {
 			kvfree(ctrl);
+			handler_set_err(hdl, -ENOMEM);
 			return NULL;
 		}
 		data = ctrl->p_array;
-- 
2.34.1

