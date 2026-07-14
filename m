Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B0480DDA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059333; cv=none; b=lRJwpVifv3clxw6E5bgPs46fnpAQAOwzRFL/0/NoisBZabIsA1pPiofCv0s9wb/iGlseuPIeYw/jpw03CORsLj7W+mKIcBCYXvs0lSzC3T0obnMKofir6FwoPsVyw82vp/be3yIus6OFNGHK4JT2lNMYMEZhMikAzRjargIopAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059333; c=relaxed/simple;
	bh=88aPM4Pbib41XFlWrYsWNgJgp/ToutOkAsr6bDRzeeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B07gkjEEcoq2QdO2TgvFkmVIE6ZXWq0PtAR+IdxkErXyVNOOTtcJwWTlDGKURKqjgOq4ATGvi7IMiwvegUyNhSBZQ2fu2xdbP1yuUFVszoG0pLkv1bn0ywrs72rzj4h7YFFuBs9G00cz2CNkOzDmaZKZt2qj29RuIAI5xXgI/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+bXE4Ex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+bXE4Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FA1F00ACA;
	Tue, 14 Jul 2026 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059325;
	bh=28HFm/hpzryVOFUp/cTJEspKP3/SSgVB01WdTPTIHTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+bXE4ExdyDKHSk1lDutOW69DKqgjmoehXYgWhlblB83kIx+CePJC+g5iFNdzrYAj
	 x+xv/UDPxcAGn8U62MSFefQJJaEbfZmJkV0zyo9V3iy5kQ7VvKw6tBvSTGAvOvUhUQ
	 gL9mbWY9xBKRp2/XeRbvZUeTqDfsUWDZUGssHC2Xz6koNht/MRJZsD1Lf23GpogAqg
	 sTWKZ4F5ZP6lL8oMxJyuoePxQtXY/GPAjk1sVGHLkNnV9V2EL4+KK4Cvs0QGwDQgsL
	 0/A91wt3o0yPy6ZU+6IpROtbDNAh3T5Wx6pqd8Wq0ar93vaKUjKPoIG6PpSqEuhsjj
	 jCgcYHHlfP4eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/6] staging: media: atomisp: reduce load_primary_binaries() stack usage
Date: Tue, 14 Jul 2026 16:01:58 -0400
Message-ID: <20260714200158.3152137-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200158.3152137-1-sashal@kernel.org>
References: <2026071304-opulently-outburst-4960@gregkh>
 <20260714200158.3152137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit f4d51e55dd47ef467fbe37d8575e20eee41b092d ]

The load_primary_binaries() function is overly complex and has som large
variables on the stack, which can cause warnings depending on CONFIG_FRAME_WARN
setting:

drivers/staging/media/atomisp/pci/sh_css.c: In function 'load_primary_binaries':
drivers/staging/media/atomisp/pci/sh_css.c:5260:1: error: the frame size of 1560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Half of the stack usage is for the prim_descr[] array, but only one
member of the array is used at any given time.

Reduce the stack usage by turning the array into a single structure.

Fixes: a49d25364dfb ("staging/atomisp: Add support for the Intel IPU v2")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index d57ab3fe39ae42..d7c3d1d98bdbac 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5870,7 +5870,6 @@ static int load_primary_binaries(
 	struct ia_css_capture_settings *mycs;
 	unsigned int i;
 	bool need_extra_yuv_scaler = false;
-	struct ia_css_binary_descr prim_descr[MAX_NUM_PRIMARY_STAGES];
 
 	IA_CSS_ENTER_PRIVATE("");
 	assert(pipe);
@@ -6058,15 +6057,16 @@ static int load_primary_binaries(
 
 	/* Primary */
 	for (i = 0; i < mycs->num_primary_stage; i++) {
+		struct ia_css_binary_descr prim_descr;
 		struct ia_css_frame_info *local_vf_info = NULL;
 
 		if (pipe->enable_viewfinder[IA_CSS_PIPE_OUTPUT_STAGE_0] &&
 		    (i == mycs->num_primary_stage - 1))
 			local_vf_info = &vf_info;
-		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr[i],
+		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr,
 						   &prim_in_info, &prim_out_info,
 						   local_vf_info, i);
-		err = ia_css_binary_find(&prim_descr[i], &mycs->primary_binary[i]);
+		err = ia_css_binary_find(&prim_descr, &mycs->primary_binary[i]);
 		if (err) {
 			IA_CSS_LEAVE_ERR_PRIVATE(err);
 			return err;
-- 
2.53.0

