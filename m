Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734095;
	b=DpE8BcqZzL6ZkYJu1fsAg9FB60vuF2HrGSeu133o9cHEAs9CDTOzfKOtTsdnUVbufv7D
	 5IDG8HFItvil9rQFP91XQxweabLvydblIZBvWueMW/KRn8+8IG8/voDkgrCpMgzF4ndR3
	 OSJFMODeWPHDZUJxVrSWzMSq4iGEWJ8N5Dq2WEjXlqzv/wn0HeGmlkW+j6Kg4dR631MMX
	 PgYUH00cEU/Ji4L0LpsIreKn3UZfruDK3yxsZEQEONi2AxOIKecGNbgXrAE5SnJVAz9LE
	 VYQQS20z/9szzrwFnRK6a8HQY/APE0Fq3OwhpsE+xoAK65BXAEpZY8vOe69IQHrvrRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734095;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BKFWknLXoJXJ+ACd5yc6fHV6PM/d25/HPAmyVhKtJBM=;
	b=HYBTvPPrNRq972ndvx602dL+bQ6njHNugUlb/yHJ6nyhvPGRCgrrGxLeAvUtaiXDKVcL
	 MhGATcQFJxbnN0gTysms46FOJvJCkuufTAPvgzN+T9emD5rJi1ZL6YenLWxNwHyeLalX1
	 QuFlqQjTKGVC9g5KmzlNF6BhRKLdki3gz98mDxyYpJnYTbzuycRtNK8EVHqGfugxZiN+a
	 exxfO0Bq9Tvl/RA7SyCSttBlLz6sk5KIF0THuWoaGZc5o2OnPjtCX/qpwYUnfikwUVVpz
	 b68cHc86/udnNdUvZUJGgYWbNj7DREeEQfWwE5vbX1CMr8SM4gP5PhQZd4iExUdYcEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nw7Hr28Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562D606A32D;
	Tue,  3 Nov 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nw7Hr28Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793734094;
	b=rX2K1n64CxLrBjnNprLKpYo73nnJUyF25reiJWWh7ifob7O69RaO2T0tFoayfHRDOjlb
	 r3InCi80gAoRRqXrVlpBz9hTZubu/C1sNR69A54ITgLCEn/qpEmIHJEKMHm0uqXwo3gfX
	 EVuMAciYbifOKCdUStkLdhw4bfeirXfFyJMgTlbJJA6tC/XFnS9+AiDxtm3WfZBnCC4yx
	 zx+nFZrqys6bx6tR6QH32fZUDDS7BOHVwGv+hiuC1yOlwnuRzJum1KTSrZrSgWhdZULsy
	 ov5FLw4kv8i8zPaOOOPa20o3klNlCvGjBYPOgrHlwQWq4trjgHujUcCkDxbRUq32xOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793734094;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BKFWknLXoJXJ+ACd5yc6fHV6PM/d25/HPAmyVhKtJBM=;
	b=kqKn6McNHNs9oLGrhYLe4ABumeHvJEYkf96F3nTgm9sN8++HN7Tdf+pUj7LsqK6nwHBp
	 CVV8Zuf+ZeylTr+0OXelM8WkPuR5OHaaRtz9vFQ62bMRHbFzaPloT6kumAX6pERzvVdWU
	 XACkT4tQ+p+kjzYxbL80+mzsaE917nW5cuH/d/at1Rdg9KpBPnOVxiwU607pB0CCLCRoq
	 VMtHojw6fGwFKGxD1RTIPvNZIrCQtRMOSh8srfCy5jU0lHkciQ38ZfgIzN6hop665VUM2
	 ZESeUYSbp3ifRFfvX45bCPtcXdQBjfrE2GrCgJ05Mg1S/a/l7CQ7ZCo0RZGl9kydNqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 712A71F00A02;
	Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734094;
	bh=BKFWknLXoJXJ+ACd5yc6fHV6PM/d25/HPAmyVhKtJBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nw7Hr28YZTYiJEJu9Ej1+EhwU8AxhOKoaXsaXfNkLBB7Y8Xe/t+MkI6e9viIl4Tpn
	 cqKGxAtvaASyA/AmpYuuDU5uIYLMRlB1YbR62GAGzw/5xo7UmCw7dG5GEIEk2nprzl
	 RatvzZFLfe2kl+cZveVPHpeBtMK9YE8SsmWcR+ry49QKH8JLT/nus4b13UkohUSGii
	 uwS3tq1OoYJxvVrR2VuAYKiX4q5UspY5HN6ekLjqLxuExRZl7NePbb7pkb/GkC+0K4
	 ej0FV7pft37Ipfi/KJlm0NNCPWwfW2eRl7bX1o1y4BhJLERd/Y+87rRdYGdDhRvqb7
	 83TZkXHU0+3XA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EED0446ACB;
	Tue,  3 Nov 2026 19:28:12 +0000 (UTC)
From: "David R. Hedges via B4 Relay" <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 13:28:03 -0600
Subject: [PATCH 3/5] drm/nouveau/gsp: don't dereference a failed DP_CTRL
 reply
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
Message-Id: <20261103-nouveau-dp-fixes-v1-3-892f4bd357cd@thelittleman.net>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 "David R. Hedges" <linuxdev844@thelittleman.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793734092; l=2139;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=Em2OoM13M26pHcKpGhv1LYrtl6SYDlTdhnsjJdx/IvI=;
 b=SbNR04R3SMfP+QN1UMFdmAjrsP/bJpahSlrmBPEiholWFF0MG14BK5ZjKZRTnQSMaOK9sjjOC
 2YG7CX4kHn6BN5hvVQCke4v4O6nJOyumj6eFFm+r36izrVnQkjlVZp/
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Reply-To: linuxdev844@thelittleman.net
Content-Transfer-Encoding: 7bit

From: "David R. Hedges" <linuxdev844@thelittleman.net>

Commit eb284f4b3781 ("drm/nouveau/dp: Honor GSP link training retry
timeouts") put the NV0073_CTRL_CMD_DP_CTRL call in
r535_dp_train_target() in a retry loop and dropped the check for the
call failing.  The reply's err field is now read whatever
nvkm_gsp_rm_ctrl_push() returned, but when the GSP RPC itself fails,
a timeout for instance, the reply is NULL.

On a GA102 with GSP-RM 570.144 this turned a display hang into an
oops.  A modeset hit "core notifier timeout", and releasing the output
afterwards timed out waiting for GSP:

  WARNING: nvkm/subdev/gsp/rm/r535/rpc.c:164 at r535_gsp_msgq_wait+0xb1/0xc0 [nouveau]
  ...
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:r535_dp_train_target+0x1db/0x220 [nouveau]
  Call Trace:
   r535_dp_release+0x73/0xe0 [nouveau]
   nvkm_uoutp_mthd+0xaf0/0xc70 [nouveau]
   ...
   nvif_outp_release+0x1b/0xb0 [nouveau]
   nv50_disp_atomic_commit_core+0x5ba/0x6b0 [nouveau]

0x10 is the offset of err in NV0073_CTRL_DP_CTRL_PARAMS.  Only look at
err if the control call succeeded.

Fixes: eb284f4b3781 ("drm/nouveau/dp: Honor GSP link training retry timeouts")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 953392504413..028f342e020b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1006,7 +1006,7 @@ r535_dp_train_target(struct nvkm_outp *outp, u8 target, bool mst, u8 link_nr, u8
 			nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 		} else {
 			/* GSP didn't say to retry, or we were successful */
-			if (ctrl->err)
+			if (ret == 0 && ctrl->err)
 				ret = -EIO;
 			nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 			break;

-- 
2.55.0


