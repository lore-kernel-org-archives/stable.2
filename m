Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740247;
	b=vmxA9FY8sQcm+IrHcy/DEXZ5x7rqPpmnpr6e5oB1NowxWGlulzRswZSH/l98+BlkaFYX
	 P/6SlbU0QRZUV8j45rIyVFExvh/9iHkPrOdKnFIUoe1xxGAdMTH0mHtdi4y7flkmt5Lnq
	 rsAd/THs+8QxUWtblqX0TLg7jjWQivLrXrwsl0OOvohjPsp1bCjQL+ENd6H6WIkAAHqDo
	 g2vlUrSDIKwqxpr/RVYV5gBKt1NAGP4Q57LmxpRYHZwRAZC7wL79fTxpnmQfn7eWrcAPd
	 Wxk++owYwe6LPFfJ3GkG2+kyyqU3nlABL62yZ/BbNf/7Yf7JtFXPc+nZacjHw9WmQyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740247;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=shbCkEoyCrifiYkEbQJnRfGxBCeG+XGkv8U8ujfmjio=;
	b=fXNlZfN1zBz4mhIuFs1A033ndlPSG2YF9SadFySuNyRh3/mpLzzzvA2wlod2DhCV5aCd
	 4x9coygW5E+eS6qZeLDgzr+8P/2qQLhmlpTF5f/cfmpOpzUBqXYAvU4aUIaEWs/pnuubC
	 CopLaWzIviRXiRulbiRLJxxrMYlHxvi3twYlQ28y7Bo777FxqViILQtasFEV2LSopMXsv
	 5oQH0TiGOTIXqLLqHv4rs3aSGRWrTMgSgZze0QG5vtDGPufgKhoaTbrHCcBiM8GIn0Cqn
	 KM1NTevQe4qFsLobVOzNywBFHetK49h/vpL+4pWtLejt9B8iSz4dC+LuKeQrA/sxQAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JcHbeplg;
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692A606A330;
	Tue,  3 Nov 2026 21:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4692A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JcHbeplg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793740245; x=1793999445;
	bh=shbCkEoyCrifiYkEbQJnRfGxBCeG+XGkv8U8ujfmjio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JcHbeplg7ztSDTlLNpDjXvIqhFqZDWgtpKUw0y+C1bKWqFGbZDpz7Mi9peQrvHsm6
	 lkB2L/PBWLpqebyx0gsTek0UfGjg2roVY5vrPViU+XkKQE3943Ki3MNpuyYePUqtpJ
	 lvbCSA6lEEsDP5kyaQ+HLaRkiJ2OEds3l0TXU4rl/GA7FdWK1IGoFGu9L4A6YjyI85
	 Vz7SpvisPpkUTdF7O6tMnThNYZu5c4/QB9jR7IoirDSwBCKRs9gFwKLuDdkcCpwyZs
	 6mfA/cuqZ/Pdf6mqFXFHbudCddCLv1nGgzt9SFXbmgdxczjMBEAH12ZlvTkZU7cvxc
	 wXukiB5dk4QhA==
Date: Tue, 03 Nov 2026 21:10:40 +0000
To: Sakari Ailus <sakari.ailus@linux.intel.com>
From: Valerii Sokolov <valerii.sokolov@pm.me>
Cc: Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Antti Laakso <antti.laakso@linux.intel.com>, Sarang Sapre <sarang.sapre@intel.com>, Divyamani Tripathi <divyamani.tripathi@intel.com>, Manik Bajpai <manik.bajpai@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Valerii Sokolov <valerii.sokolov@pm.me>, stable@vger.kernel.org
Subject: [PATCH v2 01/11] media: intel/ipu6: move busy check to ipu6_isys_vidioc_s_fmt_vid_cap()
Message-ID: <20261103211031.1573726-2-valerii.sokolov@pm.me>
In-Reply-To: <20261103211031.1573726-1-valerii.sokolov@pm.me>
References: <20261103211031.1573726-1-valerii.sokolov@pm.me>
Feedback-ID: 17117034:user:proton
X-Pm-Message-ID: aabe814be3164106aa1bcdc20531ac031c7b475b
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ipu6_isys_vidioc_try_fmt_vid_cap() rejected calls with -EBUSY when
buffers were allocated on the queue (vb2_is_busy()), although the V4L2
specification states that VIDIOC_TRY_FMT can be called at any time and
never returns EBUSY.

Conversely, ipu6_isys_vidioc_s_fmt_vid_cap() lacked the vb2_is_busy()
check (unlike ipu6_isys_vidioc_s_fmt_meta_cap()) and ignored the return
value of ipu6_isys_vidioc_try_fmt_vid_cap(). As a result, when a client
issued VIDIOC_S_FMT while the queue was busy, try_fmt returned -EBUSY
before clamping fields or computing bytesperline and sizeimage, and
s_fmt copied the unvalidated user format into av->pix_fmt.

Corrupting av->pix_fmt while buffers are allocated breaks subsequent
buffer preparation in ipu6_isys_buf_prepare(): if user-space left
sizeimage as 0, the size > vb2_plane_size(vb, 0) check is bypassed and a
mismatched bytesperline * height passed to vb2_set_plane_payload() can
trigger WARN_ON_ONCE(size > vb->planes[plane_no].length), or if
VIDIOC_STREAMON follows, program the firmware to DMA a larger frame into
smaller buffers.

Move the vb2_is_busy() check from ipu6_isys_vidioc_try_fmt_vid_cap() to
ipu6_isys_vidioc_s_fmt_vid_cap(), matching the meta capture callbacks.

Fixes: 3c1dfb5a69cf ("media: intel/ipu6: input system video nodes and buffe=
r queues")
Cc: stable@vger.kernel.org
Reviewed-by: Antti Laakso <antti.laakso@linux.intel.com>
Signed-off-by: Valerii Sokolov <valerii.sokolov@pm.me>
---
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media=
/pci/intel/ipu6/ipu6-isys-video.c
index 129016e574..f394e78db6 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
@@ -290,9 +290,6 @@ static int ipu6_isys_vidioc_try_fmt_vid_cap(struct file=
 *file, void *fh,
 {
 =09struct ipu6_isys_video *av =3D video_drvdata(file);
=20
-=09if (vb2_is_busy(&av->aq.vbq))
-=09=09return -EBUSY;
-
 =09__ipu6_isys_vidioc_try_fmt_vid_cap(av, f);
=20
 =09return 0;
@@ -324,6 +321,9 @@ static int ipu6_isys_vidioc_s_fmt_vid_cap(struct file *=
file, void *fh,
 {
 =09struct ipu6_isys_video *av =3D video_drvdata(file);
=20
+=09if (vb2_is_busy(&av->aq.vbq))
+=09=09return -EBUSY;
+
 =09ipu6_isys_vidioc_try_fmt_vid_cap(file, fh, f);
 =09av->pix_fmt =3D f->fmt.pix;
=20
--=20
2.56.0


