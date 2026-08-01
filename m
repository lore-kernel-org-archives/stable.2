Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA90363C63;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601607; cv=none; b=hZeF3lvwv54tNmL9WxkDG+Knc0bEP0pzeVjaXHVKDcThQCDSQrEn+lsvyjG8DwVNGNcgeNJk32sm6i3P7xydcJZ780W2K0bvQp6dV7eyAwkMq+PzRVTXHmXwCKq8FVbm14L0b9qEkrE4WKX8fS03neOifZZez4u8cnn/qfZtGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601607; c=relaxed/simple;
	bh=/8tvyRdttf6eWehyBHcKnRMV2l21bkHb7/v+dtaFAGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WHHT3Ob6pfd1Yt7xfJZNvnUr+hMXYd6KMqd/UbClRSdmClSRbGnMA2KPtH+cFgg+0Z0OlsqWwdKLOwj01UsfVjaX6MPVnvz3FHDNJA79x6x3e5fmE0F4cmRT6oL256ZcJhBECyncFopA4Vs0ZSz1sqrIKNHG2Csmc876IgdbXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48201F00ACF;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2E414180507; Sat, 01 Aug 2026 18:26:44 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, andersson@kernel.org, neil.armstrong@linaro.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260801051923.354496-1-fanwu01@zju.edu.cn>
References: <20260801051923.354496-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: fix use-after-free
Message-Id: <178560160417.8893.8042896031872107443.b4-ty@b4>
Date: Sat, 01 Aug 2026 18:26:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 01 Aug 2026 05:19:23 +0000, Fan Wu wrote:
> qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
> comes up, and the worker recovers battmgr through container_of() to issue
> firmware requests. The PMIC GLINK client stays on the client list until
> its devres release action runs, so a PDR notification can keep queueing
> the work, and a pending or running worker can access battmgr after devres
> frees it.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: fix use-after-free
      commit: 4e40befedfc8ed86f44e1f81df92d13c149c9f8d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

