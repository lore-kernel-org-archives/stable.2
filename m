Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555252550D5
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020398; cv=none; b=b5yhHReictGKfvF8zrC75XOooaEGk3LOeJyLhAXm5+3w/hN9FzJ0zB7+KGdru4RCN1LkPChjUB7gwpATEVT5KtsUbKPCX1eIk3Meg8NHLoSzzP2g9pDcPxorAMUBfWLJRydPF8cwNwPfy8YD2sMdEiHeJhiBK7On6t34Ql9WmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020398; c=relaxed/simple;
	bh=7ALIQsBZKCu/qxCsXATooLrDVGDCPrIKlztve1YPnqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBYxE75f3yxU6BbsUAGVVUxbByEtIvQDT0mpDdKT8CrGkeDrLRxuXrzjlnbaCNk3PCizuUSwPK1eYJP/lP8/NsA9FdMQ+9h3xD6Xw5U6BB86TMGCuMuAsNvZ6zJOz+10WhrGwkZzzYGHH0y7OvZQUtXzG4xJmcCeahol1+WERw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtL3xrls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtL3xrls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7411F000E9;
	Thu,  6 Aug 2026 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020397;
	bh=goYFYVkFKzuOVuXIsgUn3P8+T5kkfwsOycz5O1BaVEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtL3xrlspreXEFN6q/TC2SMKgomsa7x3B8ulC6Zj6QSWjaICYKq7sE865wRMsRg2d
	 ZqgS3Tpc4cOoy9biM81ocL2cX3hHkEtsJcWNrNXxKjtY8RIb67af/EIfMRNav8nlTW
	 toZNc2OmsVEiz3Id0RpIpQ+o/FyxGI4up3qBLQ1a9YS83dA3+aAa1R2BURnobwuArc
	 g1cocHEOQbBR5mwHfPyqXD9xBTDc45fvbb/Y2EIIRdK4wu+NV5eYx/PsRv3PTVkJZW
	 Hu1garMa2Q6h6zN/hqUWsLI2kAuK86OadBC07T4PPP81fOPzKAqP75Qha9uRXeuDE2
	 C6hOGBDCjdkWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: uapi: rkisp: Correct name version enum
Date: Thu,  6 Aug 2026 08:46:34 -0400
Message-ID: <20260806124634.299943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072953-epiphany-darkish-a261@gregkh>
References: <2026072953-epiphany-darkish-a261@gregkh>
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
index 3b060ea6eed71..810e874639ca0 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -1583,11 +1583,11 @@ struct rkisp1_ext_params_wdr_config {
 	sizeof(struct rkisp1_ext_params_wdr_config))
 
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
 
@@ -1667,7 +1667,7 @@ enum rksip1_ext_param_buffer_version {
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

