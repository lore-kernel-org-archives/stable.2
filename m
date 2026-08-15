Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5C41A938;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805801; cv=none; b=pAVzD4MC649JRk2JQnlY5hmwHLaa0UAqtN46P09Uv0t+boRB6a0RbfJ5tI4CUhuOklWL01mPaRapJSUlSfme0jTGP5RkVR4Ch2Ar3KDtQc+QP433s5t4aZ9D+61JZ87V2xyfXcEQME1yUJ/ySx/DllT/KdFbrEX4ZNGqDfw1GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805801; c=relaxed/simple;
	bh=A/OHJ9zYmscv3Q/pEhjmGIVnvixUXEumJLOP0slecFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YSSd1qKU/BQyqY798jCyaAMwJD1So8/eWbCgOjZggSv9gki4LAvJ71PxZMixEla+p4Wjwkak7wFh5i71wTMOz5n4L+L50UNxYRgd4e097wOMlr6wlQPpth9YcPWeXj6bCRQIYdjvyxFRfB8WEOxByxlyaZEcKOu4CSftL227t2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jc4vSXwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc4vSXwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B80E3C19425;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786805800;
	bh=A/OHJ9zYmscv3Q/pEhjmGIVnvixUXEumJLOP0slecFA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Jc4vSXwQNQVIoWyX0w4OqeEpjMX6wtbDe7cedGOmIcsJlCokDW7qIXjvBuYYTLVO4
	 jzYKKnSnecCr+8qA5gAPhDVmpNElt4722N2SOYNKvnllRq7YDdLDqhbOP5VIbMI0z/
	 6bMw0gun+5naN4gSdSp3jQH2yl/D+D6b6+Gj0o05JSiTfUWND7knzB/OZi7l+JfRgc
	 0sIwHdhwkPgh+YlYEkGMY7ZtX9cqP/k+PTloANBv2yeydfEMxUl+aVf1paHTPOaN5T
	 FDRJkFBK7Zuxb2K0xc6C6WH4dBZFj+9O/5/FJZPU6SrL//P9/UA16s5D6EQ9lryh7r
	 9eOWdDj0txs3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93618C5CFDB;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/4] media: fix four memory-safety bugs in vicodec and
 v4l2-mem2mem
Date: Sat, 15 Aug 2026 22:56:34 +0800
Message-Id: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ+gGoC/x3LQQqAIBBA0avErBMcTYmuEi1Ep5qNhoIE4t2Tl
 o/Pb1AoMxXYpgaZKhdOcQDnCfzt4kWCwzAoqaxc0YjKPgXy4uSXirBSOkSjtV4QxvNk+sNY9qP
 3D+WX4RZfAAAA
X-Change-ID: 20260815-vicodec-fixes-600a11533341
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Dafna Hirschfeld <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=A/OHJ9zYmscv3Q/pEhjmGIVnvixUXEumJLOP0slecFA=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrIY61XThyTOXaLilxwZN+i+14OYJ/obLm/SWJFz7Y
 XeZ7YC+yPaOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmMjVp4wMS0MUZ2qe3j35
 WNjs8wqCnYF+ZaoyP7y0hZt4/dZbR9nzMPzTftZaUn2yInOXkOuC8v7K1ssp5xqnLbzgzmD32aB
 R8AMTAPGcSDg=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Four independent fixes found while auditing the vicodec codec paths.
Each is reachable from unprivileged userspace and was reproduced under
KASAN in QEMU.

  1  v4l2-mem2mem: VIDIOC_REMOVE_BUFS is not serialized against job
     execution and can free a buffer an in-flight decode is still
     reading -- use-after-free of a stateless decoder's reference frame.

  2  vicodec: vic_round_dim() rounds only the chroma plane, so a
     dimension one past a multiple of 16 yields a coded size one 8x8
     block short of what the codec walks.

  3  vicodec: S_FMT never clamps the visible dimensions, so shrinking the
     CAPTURE format leaves visible > coded and the decoder runs off the
     end of the capture buffer.

  4  vicodec: the encoder's CAPTURE width and height are settable
     independently of the OUTPUT format, letting the encoder write into a
     buffer far too small for the frame it produces.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (4):
      media: v4l2-mem2mem: serialize REMOVE_BUFS with job execution
      media: vicodec: fix out-of-bounds write on under-rounded coded dimensions
      media: vicodec: clamp visible dimensions on S_FMT to coded bounds
      media: vicodec: make encoder CAPTURE dimensions read-only

 drivers/media/test-drivers/vicodec/codec-fwht.h   |  2 +-
 drivers/media/test-drivers/vicodec/vicodec-core.c | 15 ++++++
 drivers/media/v4l2-core/v4l2-mem2mem.c            | 60 +++++++++++++++++++++--
 3 files changed, 72 insertions(+), 5 deletions(-)
---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260815-vicodec-fixes-600a11533341

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


