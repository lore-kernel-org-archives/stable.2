Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCB40D588;
	Thu, 24 Sep 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262671; cv=none; b=ijiiAWCTfNSFdm/7PHh0EKoGmSnsW63E3wutDkKxTtoGIH+woakSMhu0cb2mnhC2eCYT45Nn9EzXXfmlC3GxTSSoT9dU0RDCLGfQ77nzN7I2Dtx2LbVhifAx8c/d+VE/TGpQT2znYcJoKLsF00B7vQ2VSCp/RtOwwpLDqUNLO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262671; c=relaxed/simple;
	bh=8MpcjzaEyy9j8v5FlGt1mRpAbMw5RvBGvj/TMpdlgPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpSfWvwEh1g+o80kiQ8YhnW7vnd9l3cs9Ugma947E/XneFGhNwyq4EFlR0uYNsBYcfrzPuDgJ1yJriD3+YHcUOsiKuDVlqy6FBlHh3GKyVoCDsfloLqVHB1LxqRbH4vFzXCLnUtukA3M3zeZrQx8GtPT8BMjETdy4itmunsLVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CDSjt09j; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CDSjt09j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790262661; x=1790521861;
	bh=8MpcjzaEyy9j8v5FlGt1mRpAbMw5RvBGvj/TMpdlgPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CDSjt09jaY8v77TlFohUictosvRX6Nu804caliPPZvxK2Xw8zr5I/vf9UPEhm8Ud8
	 SmWObVFvzHNy2waEOPpCw5qoJFLwYqUTPA15krrO23KULSAAcAdIVsUswhANEpEYku
	 1wUclRkXLIFaB+duqT291KSn3mHuQzJA2g5tZDR9YuphqA53u9jm3GRg6fbBiid4j4
	 wMxgT/9a7hqTFZ0sGKU9d9FtB9QgDSHRbNA+/SI+1HXxDQpFsnTtP5py6gjoeEnxmZ
	 gWUkeENpetdSlJD13a45+SLAx/8D3PbgMBmyTk3RtsOLm/EXCdKTtEiLGv8PHPUnYw
	 vtxhZfwX3tWjA==
Date: Thu, 24 Sep 2026 15:10:57 +0000
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Renjiang Han <renjiang.han@oss.qualcomm.com>
Subject: Re: [PATCH] media: iris: reset AHB bridge before enabling HW mode
Message-ID: <179026265520.10624.7225501417802995951@pm.me>
In-Reply-To: <20260924-vpu_hwmode_fix-v1-1-531498f3499a@oss.qualcomm.com>
References: <20260924-vpu_hwmode_fix-v1-1-531498f3499a@oss.qualcomm.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 952b3f0fc5e2f6b2720f5b37eec8a3f91a353eb3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This fixes the SID override assertion I reported on the Lenovo Yoga
Slim 7x. The test details are in my reply on the Link: thread.

Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x

