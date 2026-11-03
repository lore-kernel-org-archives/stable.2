Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695308;
	b=QKgim3Wk8uIJ5oZX8/gvU+3kJXm+nwT6brrumDaqzBUpoqgWKkwO1+PZGwJk8ZGfzawv
	 I5L3FjsTBag1IGemFLXstZEYFhrh5xRu1EAxU8x4MJ3IzcafWGwtMqMXXpMFpKELdhZbr
	 IvnS1BQRzPAm69cr3YYhEI0i+wvbyU4ovAs7lkN+KnqV2JgA/SeDzCeWPXPpVgHS4FL9+
	 H6N4RbjhS0zqu7oF+PNz+66MvUbB/IdzmBBE9SNMcDW+6pu4H25H34D09zX3ZEy+ZvZeY
	 puo/93gZ4mBZEiE1HDZH/VJGwbfAJ3/cPMg2GiMSswopZ1iTQc+XUNBHo52+RrZNVaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695308;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XjrwwACPOWikmoSkaur5bgUuCzi6GVUqjuufwN1HYUQ=;
	b=jtA7PIW2cvMwCqn001X+4boXvGKjQ3y4lvLri1/2vYUMaGorzJLZqzgQNZj4/uiMp7e2
	 v4UxtEqOpzvDfNOcHXCN4fhELKDlSCbSmxS4sojAH0U2L4jav63TyZcuqjBpT4EYkXU5w
	 NJ84tVTgCqaqLWLQidzXXPTA3lNPokQeuWktoFF0+8ZG5AFh4FUE/LMx83j04vEvthrwf
	 Qx0Bd71qelMBer8DzliqoRzDOGeCCkEIG2EeYSSmVlGR06hqHpq5bdJDA4pwm7IOobQmf
	 13Q1MNF3CfMPGZeHY5khWLU2QgfAlb2MCLXiWRrXZ/zcqORucH2pTgao7Qdo7vfAtKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=T3nyVCSy;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68669606A940;
	Tue,  3 Nov 2026 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68669606A940
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=T3nyVCSy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695296; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XjrwwACPOWikmoSkaur5bgUuCzi6GVUqjuufwN1HYUQ=;
	b=T3nyVCSyhFIm7LeqXFxOCFY8llBJLwZF6lvshxtLAUgl9KjInRR8QKkqEiteyUfg1BZSa0i3HM6dXzwzInmIJytNd3fif2AVRL09cAUcZT2M4CSX5XvU+07Hmunne6uwnrZiPuD0crjSGPl9j6mqkdzg591Bc2KHloZHi/wOalg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1329135|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00421968-0.000429425-0.995351;FP=7885207108989459540|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9Ci_1793695295;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9Ci_1793695295 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:36 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: joydev - avoid signed overflow in the broken-axis correction
Date: Tue,  3 Nov 2026 16:41:29 +0800
Message-ID: <20261103084135.426629-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The JS_CORR_BROKEN correction multiplies two user-controlled 32-bit
values before shifting and clamping the result:

	value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
			((corr->coef[2] * (value - corr->coef[0])) >> 14);

The coefficients come from JSIOCSCORR without any range check, so
the product can overflow the type, which is undefined behavior: the
compiler is allowed to assume it does not happen and optimize
accordingly.

Do the multiplication in 64 bits, which is bit-identical for every
in-range product.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/joydev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd8a7c1..947d7671a59f 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -74,8 +74,8 @@ static int joydev_correct(int value, struct js_corr *corr)
 
 	case JS_CORR_BROKEN:
 		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
-			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
-			((corr->coef[2] * (value - corr->coef[0])) >> 14);
+			(((s64)corr->coef[3] * (value - corr->coef[1])) >> 14)) :
+			(((s64)corr->coef[2] * (value - corr->coef[0])) >> 14);
 		break;
 
 	default:
-- 
2.50.1

