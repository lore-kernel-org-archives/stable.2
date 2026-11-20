Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194337;
	b=IyeNeyE8W83/UbUEbQFR5ylLaypB0//Erm8bBZ9RPYyqVzhxmpM1gK/r2pyy+4IUQ/XB
	 m3MElN/Z7HCpJ3yyvJ8uyeN0nSSAOE72JhCVaPcfdWRdroVYuW3uESXYGPHRbiASR0Tcd
	 9dPAsNFquZcdelJIXzfD/+G/p7iUqoBT0ySmw5ch47qK/uiqs9UngWBW6CXz+aiqBXf6o
	 fQXFqxvL9/p40h2j1KERvCR5b09uCLZE0B/Tc0q5q83mmkEda7Y6c66ANeZopX6nb5L8H
	 dBPCtnF2CaGGMjL9A7lqqjqMNRxaxbNDOmKPiUagI0mM/D8udRRq3Ixoac+9/Yq7ItA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194337;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sLHagpSzuZUnxVW+XAVPh7Bz8a2nvrteEUglC6ttg5s=;
	b=x6+G8tUhPkFUmgx6pQFZc38JRJb0EVrwqKG67cJCgKQEBmIUdTvL+c6CTCTZDAd7MqYY
	 ah83fOeh3GelkQrGcj98bwaCI4jt/vxy3c1wN5piHQd+ruxwwGHABqH5zKHZWuTLkIapG
	 xfHME8ixr9zQzBOhlJ+3YHxn8lgda1i1skd6NNlMro2lCtViHE3z3HQeqOfX3Hj7brkCi
	 IN93/ykUCkLTHEQtYjI1XeuO8hXibac/cHWSnl09YMz6Ap20y0ePf9DBNyEhyVyJ2cmmK
	 XWqYR3B0g3l3JhMxcGlExbdiLpQA0jCAXk7PMbfLY9WJKoM6/9hRzLChIYczpSFhhoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPZVmBFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A982606A331;
	Fri, 20 Nov 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPZVmBFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112B51F000C0;
	Fri, 20 Nov 2026 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194336;
	bh=sLHagpSzuZUnxVW+XAVPh7Bz8a2nvrteEUglC6ttg5s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JPZVmBFbSLH4qRfurSTkU7D4cMHVJB63sygNn48qanW/x9gaSE6q6rrgnsXVpJiLp
	 j9YaYyHMR9f4//GWZGNt6jVuShlrO4WWCmpMZIyqtdj/xXiQQ7UhsPFJX/S3ezvXAE
	 7BIa1Uij5IrWcMxTXQPdNIVdOG/ugfTwgXT7DmDwZ2Asw/C8hk/Sntc4mjeb6NNwiU
	 q4DXTxmLsxXMtRWy2TC+dHtuO5gZMRm+VR6+kE1A8IAEDsHPUMArxxrw/LEO7BUypQ
	 NPhzSUa5t2L2wf6XR8ZTSrgrXDTo5CXp7v4XLvdAIlxTNgrPtHIbpZMOUX6A8nKyD7
	 JsXKdCCU9S5NQ==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "media: iris: reject open() when the session
 limit is reached"
From: bod@kernel.org
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261031-fix_v4l2_compliance_unlimited_opens-v1-1-f20cc9231ee3@oss.qualcomm.com>
References: <20261031-fix_v4l2_compliance_unlimited_opens-v1-1-f20cc9231ee3@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 17:05:31 +0000
Message-Id: <179519433176.2846709.3130559519650730589.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=bod@kernel.org;
 h=from:subject:message-id; bh=jJZdAILGiedxKQiKHyuiMhryleJ97+ZPJW5mi9NYkEU=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBrAH3bzQr6m9+W+unouQnESrUqV1JC24VyNoMeE
 iLvfOo7Yy+JAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCawB92wAKCRAicTuzoY3I
 OspqD/9Z68k4P6DV0O8Sz+UvpEaMN8+DcerFwXIUgqS7UzSuStoVIvKjw0RTfmoVlYE4hIjLwZS
 aUdmJeisIPlTtDMAI5nfFJywZ8H/7I667K51gmYIUKkxp2ymVTSd46U+k0669LhzMAfwtxXb6Er
 V3oDgobXYCL9OPq0FVva1U7MULh6+OVv/hp987+8CabKFCYOPxnOhkY41UoES35bNvu3BoNPdR0
 TuSeQUFv+nqgaBxoAKafpOqxOsJ6Wcs/cw/Gbzhn0d8GJgXydumgH5fIUxGxjesnItZqoNAROoU
 WkpwVYanRxzXDdL3m9Y18WQ5FI+TwnfxhO0B1be9xkvLg8gSNbukxR3hGbqFyVYLFqQ370VtkFD
 HSwKXthdmoqOambSgoc+V0yb2XcPw87UxR6IlgNbqPO7gZs94WwzzUAKsLm+7LjAnDc3ROL09PX
 eElNYy3/sNGAHCZ5PD0h613XPkZSMskZDG893kxcToiQA632AidNJ6yEFr4bvWc9/sPzoJc2sgg
 1qyT+pxlnVRZ7E2bLmC3JhJ6iUtzDKoja7+/QpKF6gVzfMScZtduN47mswyqp2y0mQlE+fl6J9q
 QPxXchoix2lpNdJMPQ1kdm/gJq4++D9oNCSa56TjsHJiIaeDJJx8O/UM1mkB1DJ2VfDsp9p38CU
 VuJubh/T1Arg9Xw==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-31 01:45 +0530, Vishnu Reddy wrote:
> This reverts commit 397ebadcbc21 ("media: iris: reject open() when the
> session limit is reached").
> 
> V4L2 does not allow drivers to impose artificial limits on open().
> Resource limits must be enforced where the resource is actually
> consumed. v4l2-compliance verifies this through testUnlimitedOpens()
> and now fails with:
> 
>   fail: v4l2-compliance.cpp(773): !ok
>         test for unlimited opens: FAIL
> 
> Link: https://github.com/gjasny/v4l-utils/blob/master/utils/v4l2-compliance/v4l2-compliance.cpp#L747
> 
> The session limit is already enforced at the right place. An instance
> that did not fit within max_session_count is not added to
> core->instances, and iris_check_session_supported() rejects it with an
> error from iris_vb2_queue_setup() and from iris_vb2_start_streaming(),
> which is when a firmware session is really needed. Failing open() adds
> nothing over that and breaks the compliance requirement.
> 
> Fixes: 397ebadcbc21 ("media: iris: reject open() when the session limit is reached")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

