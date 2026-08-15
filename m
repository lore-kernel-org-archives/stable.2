Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF53AAF69;
	Sat, 15 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805801; cv=none; b=RKemrEW4/jxV3jWkJodkZVvxki3Efn2eYipKWQ+NcXtui0d2FuWKF7sroGLTape7l+Bud2I3P5nU16CmY8HAp2+8JQtf2EneM4hxXuWv9ZK/yAHl0OnbmAJPsDiuceJaEZ+hsi+ese1h6PvwruaWluOiGcONHO4dvQBkZPSPVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805801; c=relaxed/simple;
	bh=9gbx3w5N0uBUyse1NRCNxyglDGHce1r+QyRriAJm4yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFFvIF8bAjYpibtQCEIVWqjJ4JsjkjzseAe59+VtdhEkm08QDzp5T0kl+FqvlRWBpAMMj2T6710CJPKn8Fi84ba3oeK6QtwWoCuOgu6Eh4BpOfQTF2SHUIdeuN4vOZjvqgCF7gy2E3RPCrTUjd9CK4/bORtoPu2rfmwqdbaxkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmQpcuxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmQpcuxm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1926C2BCC7;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786805800;
	bh=9gbx3w5N0uBUyse1NRCNxyglDGHce1r+QyRriAJm4yg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HmQpcuxmNZ4Ek3P5U6Y92bL6EAWd55LNTKWHu/bGdSJaJKXDNB9bpb07cdN+cZwUT
	 0utjMxrXPOmqo2noRxZd6LNW337u5kJIU1GM1Do+xW8FC72f4l+0B7PPZ8bcA9TOOv
	 az+mLgKZCeAHmVpDMC20SQRN3XkDT2Kpmdy23qxRJWLiJtXE/+izF1AileRjLpZpqx
	 fCZpfARjaQZ1F8BwhvUUV0uwKGBPh5jsCGtsspHRy/G8BKfdI2NXbsHTFyGro0sCKD
	 LizZk86Yli7pK1sohI5GP/baxOXg3Z1iHHoxPQNkgMh1rvXXgvjFj5oqX1Q1N8Z1hE
	 +PH3txb2+H4UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C6C5AD5A;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 22:56:36 +0800
Subject: [PATCH 2/4] media: vicodec: fix out-of-bounds write on
 under-rounded coded dimensions
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-vicodec-fixes-v1-2-12101572eba7@outlook.com>
References: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
In-Reply-To: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Dafna Hirschfeld <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=/Cgn2Z+/GhQ6lI+TCHOr+FQEmXhNn+WmP8yMOCGBoj0=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrIY6NbW0R/sbpLbrFcQ7OscatP0RN7MrW7yg+4fLv
 V3fe3QmG3eUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARN5LMPyV/RazkIk94+/x
 mphdDLE/rlnJCrnMOfBxg/m2m6/YVibdZ/jvfvJiVlzAVbmL+3dv6HOsUjoyc0Lnne5VZi67p83
 69/8PCwBrn05+
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

A capture format whose width or height is one more than a multiple of 16
makes the FWHT codec write one 8x8 block row, or column, past the end of
the capture plane, and read the same block out of the reference frame for
P-coded frames.

vic_round_dim() is documented to round a frame dimension up so that both
the luma and the chroma plane end up a multiple of 8, but it only rounds
the chroma plane:

	round_up((dim) / (div), 8) * (div)

For div == 2 the result is a multiple of 16 in every case but one: when
dim % 16 == 1, dim / div is already a multiple of 8 and the macro returns
dim - 1. encode_plane() and decode_plane() round the same dimension with
round_up(dim, 8), which yields dim + 7 -- one block more than the coded
dimension that sized the buffer.

On a KASAN-enabled kernel, a 641x360 YUYV P-frame triggers:

  BUG: KASAN: slab-out-of-bounds in add_deltas+0x450/0xcc0
  Read of size 1 at addr ffff888009070800 by task trigger_bin/70

  Call Trace:
   add_deltas+0x450/0xcc0
   decode_plane+0x1916/0x3390
   fwht_decode_frame+0x173/0x620
   v4l2_fwht_decode+0x751/0x1120
   device_run+0x6bb/0x1850

Round the dimension itself up to a multiple of 8 * div. The rounding
changes only for div == 2 and dim % 16 == 1, and MAX_WIDTH and MAX_HEIGHT
are both multiples of 16, so the rounded value still fits the advertised
limits.

Fixes: 3b15f68e19c2 ("media: vicodec: Add support for resolution change event.")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/test-drivers/vicodec/codec-fwht.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vicodec/codec-fwht.h b/drivers/media/test-drivers/vicodec/codec-fwht.h
index 0eab24020e9e..4b4d39031089 100644
--- a/drivers/media/test-drivers/vicodec/codec-fwht.h
+++ b/drivers/media/test-drivers/vicodec/codec-fwht.h
@@ -61,7 +61,7 @@
  * both luma and chroma components resolutions are rounded up to
  * a multiple of 8
  */
-#define vic_round_dim(dim, div) (round_up((dim) / (div), 8) * (div))
+#define vic_round_dim(dim, div) round_up(dim, 8 * (div))
 
 struct fwht_cframe_hdr {
 	u32 magic1;

-- 
2.51.2


