Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EA4D4871;
	Wed, 14 Oct 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981007; cv=none; b=rcCcxT1jSR4dBMWLYcR8DFzwtz/VR6k2xQlS0CqiutKmoq9MAEd9QauiSZqfytW25UJ+VyNV8rVqTvf0EzhaG5dzPgCT951iVT69VPqlaFx5dkVaPm/Q0h6QbNlkllY5UivUeyZMAJINuFRwsLI7UabijuEbdRhNIC/FTjDhdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981007; c=relaxed/simple;
	bh=bCFxC+G5LkvNJl1avUiZgUBgnk+2WI1hyc8TP8Xm1uU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hLib0f1UDuF4Tr+onoM6sCHYXkV2PFnl27ItmNZkBueJRVdrNLaQa5goTglF11muQZnK+r9f5mBD2gXUHLtnRLppjk5RZ/MQDqscz8JQHvB1E3Lc/F1EqkJl0a+BSHdTepKHLZnejKt07ueYIqU/oqKAcXLXkGOMgTeDKTNBcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljil3pb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljil3pb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A231F000FF;
	Wed, 14 Oct 2026 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981006;
	bh=vEb5Gx0LrtGn+0frlTWsSNwPuSCsK7a2RD1SMA1DXnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ljil3pb0zmj/wIQfZB/cQuB9DS2AhIvaEixXz+DRu0ctwfV+uIB5+aTb+AKr4fGtv
	 pda6bfzDOZgAGvX9cTgJh/VbcqoQmK1GKRVXUvFSQr2721LDY1hZ3oyzu1IDfyAmsF
	 RE5XPBwu5tH+L1Oc7nUddPsAR7vVPUxNYWiT7YUraox48N3v0514slWNq+e49lNfoR
	 kTxHBW256PTScguOamk6dTxfUP6llVcZS63QHzv5pudOpYNtwUmiHJQpV2BDHx1Ul+
	 wHFDM381bh0i4wyCgeT4b1xXOJiWVs+7eKoNvOKyqss19TjaEhItjTA5x2wTseNagL
	 awPFYwfKeAzgA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-Id: <179198100282.808561.2750105116872314866.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:30:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> The qcom-wled OVP interrupt is enabled at probe whenever the module is
> already on, but the driver still believes the backlight is off, so the
> first brightness update re-enables the interrupt and trips "Unbalanced
> enable for IRQ". sdm845-mainline has carried a workaround for years and
> Joel posted a flag-based version last October [1], which Konrad and
> Daniel asked to be replaced by something that does not track the IRQ
> state by hand.
> 
> [...]

Applied, thanks!

[1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      commit: 186fc521f211a207c323b753659f28d3dda7bc45
[2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
      commit: e60dc9c05e0f415ef8bc63b3179abdd49830a619
[3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      commit: b32a8c32fea3855e707717155f198f03fdbf6f1e
[4/4] backlight: qcom-wled: Read back the programmed brightness at probe
      commit: 2ffcac916578f4a57347e717786d1e07e85cbf2b

--
Lee Jones [李琼斯]

