Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734094;
	b=ru0r3NCcHSQ6nMm4HniNG4SejoCfUTPkHOgxdPped8S7vB00N9ssfO+6EtFktH37t6WJ
	 m9mKWraIlWDd1UacJMcRiAO+LRhFfVfeWJ4Pg4OCZ+jYsVEv0lnK5yRey4dJQocO/sI81
	 TPOtWEYEBVELY0h5Oe+yD1VUsVcckkDlkEzpQrghu1/VZDz2VdjQOVSh8eOlEIruFd2KJ
	 dlCzAowhs7wA2TraB04/Zw7DTtOZEunFgedj6WE3CrCVanq5qvBIxsuN9Bi6Nw8mxEllG
	 ondRzCFtfpFnqRmjcRqQgbd/nBH/IwUN9j26iIGcH5g5tGhFHbD9C35H/A2Br8fQHKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734094;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zuEYFaLmVg/iLLrHIfXW07NtXiDvrmAt5+qGwHGIFjg=;
	b=uOPcJySPyEXWbx4I+AjbC3cqiV4tLNqbSkpmlYueDODZN+16v/HUYIlVOHfNe06Q4t9f
	 aCaYhaa821vTC2upIbPRjupf3EG12kCyfV0S8ynglwqIO3U4s4myvrWk5jjdGS3YJXgbc
	 1LECV91Xf6VJZUd0wpO26SarsCyUxzp8VmOjAFVEbU/JeuCnuWcXRAbvHdgY2dDhDeR60
	 KUiw38qXiUCC+Y5gqEp5z2e1VFF1xE1MFcJDsAdm+KOAP4WNQjZXg72M2qN/+a/Xwnt8A
	 anJANk2f2Ubzai5vsVPpCj33IFC5hCryJJU0rsyS7jt757HrghLOxVbSz71p8GHIsNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wo41QOxd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC9606A328;
	Tue,  3 Nov 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wo41QOxd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793734094;
	b=s37wJa9wG6OrxU+wBgaXf1Gzhum0+lRqHgxnKl6bDmSIRyImtOWZFX4huxpgyaoWEOGk
	 D/Tlj5LIN+b4r0CYISQ/oZcuGnBR3WPW9jWShSQNBvs2BUF6HyxM4b8e++S+Ipa+yLru3
	 xPs8GAMUJaHwET1A85dqNRKX6wE5nBfg1I7hl90vGexvXwJy+IbG/LNp1D7kO21bUaooa
	 vR2tC1JJk4l2Z53rgT+PRRhIt4TJ6PXjIZluYIeEcF4VRKtmgb9M1mbGW67LCiaRj0nuX
	 AP37Au8TMdX3qRPaJaDffG0Hpa6elsl6rUgbFP2MhoAmCgDf7WNpwJlY9S9xrOgDUzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793734094;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zuEYFaLmVg/iLLrHIfXW07NtXiDvrmAt5+qGwHGIFjg=;
	b=rgHCy1kTaBIt7i4IbQZbqiSVlERciky/wXR5uafixBwTYRTAd4vSiT/0hlR6v5KBiJvd
	 seXH3eD+5MtGWpEP0sjaeCPLc4AdYnsnjbrl9CLwcD9AkmWHoDIP8vvdHejrcKMiGuNZc
	 AzjpO4lS1NxruLOeyfhsxN8VA9vmQcSvBbVmLWd3QJRci8n/nWkDGiWLhlRBcTtYs3mlP
	 5YCVlVnhymqKEUAu8brLLY8pPQapoElQF5bqWf+xKLdZ50yT8xFReUk/FmR9hz0EYCnTb
	 j2nd4WyLzl5S/fKCsLcl7aR+hAFn8j+N9Xafn3IrMDxsTA5V+HZUl8hTq1SMo767a9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 650501F0093A;
	Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734094;
	bh=zuEYFaLmVg/iLLrHIfXW07NtXiDvrmAt5+qGwHGIFjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wo41QOxdi+Rx0EvCtXi4Xw52XSVPn24QYzz6gsylsm2M2rDeytrR1NG3IkPKmAtb2
	 WL7fB/E2mZrTbREqym+kUtCopGoKYqav1np4jE2NUyJu1Ca2/xNwJW4+W52Pi7hlRQ
	 484uCrS+/AbwkMolrZIxiYvQu/Iag6/DbsBzl1YSH1bEJ89XmvgxMPssExYFjd4cFR
	 fRLqZPyBLmGwccCHm5j9WPJZN42e1Rc49pYTzjgtnxTf61ZBa/fkaGxg3OulbO99HC
	 78divx2sfqf37ZZpiRjHVcfPB1Mnb5PgGVMUz5YnmZAOVFV83od4sYHBfKLcKQ/72Z
	 kb4o7xpyAd9Mw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E274C46AC7;
	Tue,  3 Nov 2026 19:28:12 +0000 (UTC)
From: "David R. Hedges via B4 Relay" <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 13:28:02 -0600
Subject: [PATCH 2/5] drm/nouveau/gsp: don't report failed DP AUX transfers
 as completed
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
Message-Id: <20261103-nouveau-dp-fixes-v1-2-892f4bd357cd@thelittleman.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793734092; l=2363;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=VnhFFCJgwU5i55xG5SnKSfbRyrndYBR8/9ZzNzwvcvc=;
 b=FvGKLCExeTq/wzKIWyYwo1rYcl1ZNPwjfmlGJ9iRJBjjjUCu0eUeEa1Bfv5QXetBKXpDgnJXF
 yayxYdUuTsrDUdBzi3pocWEpW6KG++byU15FYqnfgrHstlChLrGGO5h
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Reply-To: linuxdev844@thelittleman.net
Content-Transfer-Encoding: 7bit

From: "David R. Hedges" <linuxdev844@thelittleman.net>

Commit 9776c0a75a1a ("nouveau/dp: handle retries for AUX CH transfers
with GSP.") put the NV0073_CTRL_CMD_DP_AUXCH_CTRL call in a retry loop
and dropped the check for the call failing.  When RM fails it with
anything other than a retry request, r535_dp_aux_xfer() ignores the
error and returns the reply fields as if a transaction had completed:
replyType becomes the AUX reply, and size and data are copied out.
NVIDIA's own DisplayPort library (EvoAuxBus::transaction() in
open-gpu-kernel-modules) treats a failed AUXCH_CTRL call as a NACK and
ignores the reply.

RM does fail these calls.  On a GA102 with GSP-RM 570.144, replugging
a DP monitor that hasn't come back from DPMS off produces bursts of

  gsp: cli:0xc1d00001 obj:0x00730000 ctrl cmd:0x00731341 failed: 0x0000ffff

(NV_ERR_GENERIC, occasionally NV_ERR_INVALID_DATA), one per AUX
transaction, and the DPCD and EDID reads made during a burst are
judged on whatever the reply fields happen to contain.

Return the error from the control call again, as r535_dp_aux_xfer()
did before the retry loop was added.

Fixes: 9776c0a75a1a ("nouveau/dp: handle retries for AUX CH transfers with GSP.")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173fc2c..953392504413 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1101,9 +1101,12 @@ r535_dp_aux_xfer(struct nvkm_outp *outp, u8 type, u32 addr, u8 *data, u8 *psize)
 			msleep(ctrl->retryTimeMs);
 			nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 		} else {
-			memcpy(data, ctrl->data, size);
-			*psize = ctrl->size;
-			ret = ctrl->replyType;
+			/* The reply only describes a transaction if RM completed one. */
+			if (ret == 0) {
+				memcpy(data, ctrl->data, size);
+				*psize = ctrl->size;
+				ret = ctrl->replyType;
+			}
 			nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 			break;
 		}

-- 
2.55.0


