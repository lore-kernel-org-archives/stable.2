Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F63112B2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021621; cv=none; b=lgV+oO1cvCI/OhsXhdQ0Ocy5/8CPWd7luLHXMA6w6SMr8UaEiTS6olvGaiFqgdYpSCXHtXpqHgdfMOGK4KaGtu2RwimVSOK2+/pydpDnriohlBKTlwpZLXTtaEvQtRXtV7YhnDV0yWeceTDEohy87cMPUTZ7iitg9hH0DgTvMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021621; c=relaxed/simple;
	bh=bAC0Hfs+LU9pXNUrD6rcBbnCSgCe9398FQeV/+hmUQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Lj16b7PtfIiv6HIkMxtNiv+t3A5nZKp+93puSCCF0qwCe3YlMFFt+8knlZl8Af1LBMDL/hjNgnSjDcGEQvMGWUti74WBUOPKVySVwIu2fLyUqKMGAFFEje0rC0QHGl7clYmON6Avv32Xtv5xzZuQ6nwH4K9eEKvP17FAOqbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beSlVSmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beSlVSmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885291F00A3A;
	Thu,  6 Aug 2026 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021617;
	bh=u2cb5lbDynrOhmZv8+Y/vEPVNjblxpYXCX3czSxlToI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=beSlVSmzCdiSi3kz6/QyzuNHYAF8kDkteZAGsviYJZCA9AoreEgBXqkXbWC7r1KPF
	 EcB0i+H7LRI+157TgW1XwsoI4PVf/Beh1JNlAqr4rOAy3TwDGHvbiyDPwQj+Lz/48Y
	 LnRYBqY9onm2aOdvZNGgIylvZFtAACP/m1foM6G98geAKljz6ainPEZoZTrKtRa3wD
	 DVSw3rBquK5EcrBHt0HlWfludsHcn7zV+59e92vo3Q0bQ7aaPcdhRRT9hgOlvf/KIk
	 q6h9BDLbOFCvxAarWjaLAZ7lJMqnEPeay4wxiSyu8WzecuOpFCQX6YQw8ZQk6iIRyH
	 HtVHCw298PmYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: uapi: rkisp: Correct name version enum
Date: Thu,  6 Aug 2026 09:06:55 -0400
Message-ID: <20260806130655.335225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072953-hamburger-filter-279e@gregkh>
References: <2026072953-hamburger-filter-279e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit c4c01c4fd4a3916ffdfb35ad9f511c48e289f51c ]

The name of the enum to hold the mapping of parameter buffer versions
have a typo in the name, correct it. While this is a uAPI header the
impact should be minimal as the enum is only used as a collection for
the one version number supported.

Fixes: e9d05e9d5db1 ("media: uapi: rkisp1-config: Add extensible params format")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260501190339.3449193-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ Adjusted context to keep the tree's `RKISP1_EXT_PARAM_BUFFER_V1 = 1` initializer instead of upstream's `V4L2_ISP_PARAMS_VERSION_V1`, which does not exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/rkisp1-config.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 2d995f3c1ca37..963c7a0550159 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -1487,11 +1487,11 @@ struct rkisp1_ext_params_compand_curve_config {
 	sizeof(struct rkisp1_ext_params_compand_curve_config))
 
 /**
- * enum rksip1_ext_param_buffer_version - RkISP1 extensible parameters version
+ * enum rkisp1_ext_param_buffer_version - RkISP1 extensible parameters version
  *
  * @RKISP1_EXT_PARAM_BUFFER_V1: First version of RkISP1 extensible parameters
  */
-enum rksip1_ext_param_buffer_version {
+enum rkisp1_ext_param_buffer_version {
 	RKISP1_EXT_PARAM_BUFFER_V1 = 1,
 };
 
@@ -1563,7 +1563,7 @@ enum rksip1_ext_param_buffer_version {
  *	+---------------------------------------------------------------------+
  *
  * @version: The RkISP1 extensible parameters buffer version, see
- *	     :c:type:`rksip1_ext_param_buffer_version`
+ *	     :c:type:`rkisp1_ext_param_buffer_version`
  * @data_size: The RkISP1 configuration data effective size, excluding this
  *	       header
  * @data: The RkISP1 extensible configuration data blocks
-- 
2.53.0

