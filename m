Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578B562603;
	Wed, 14 Oct 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992903; cv=none; b=b/H+Sb25z3p21FcX2LY4yZTrwlT961kLLvpnuCUBlwciRf3PuAV25iJBuHJmYo6OYBHNASGgQxLYbxY8RhSpzM6ZWV2bXaSZmDmr9dr6LJFKpTAGqO5k6pPGDqczlanj9snlqHnr/M0xtdqnfh5NZGINGgTx58bYHoUo6uIEh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992903; c=relaxed/simple;
	bh=g090fhFNviLDeGHovXWZ43fAVImrsninC8gPvKmCmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRukCrRw2GeNa8T7seBIXwD+z3Xb1eKilo/79r3A6pQVSJyDPSqz3rzqYMW2FS33uIAfTFh1faP5xnRiDt/g1tRojUkFvnlPK/9WBEduAHN/qyZGfwCPGeE+V+H1HW5AA1VxKatF3PG+QlHAhfVJVyRA0QfOEJO5+5HUBs/sELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGNROjsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGNROjsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3971F000C4;
	Wed, 14 Oct 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791992896;
	bh=rvCn0Jy5JPk92lbxMFMPQnmkaKsTTGgMrym6uQCnrBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGNROjsWMPa878f5faYxkglJCvBR/VdU51Uk8eb1VRHR6m9M8fYCsbthlETEkmQIe
	 bn3N+cA3yuRCCZ9DCH8EYPfCvTeBt/OQ2iFjNKA2i0hIANRP8ebgKIt4C6jaGl+0CP
	 8IF/lRQjm4JpPgeUYgNP0dQwK3+LFLNLg20PX2ypKGTT6LEEWku6UxHOkbRNncRSvJ
	 hkF75pfvMKFX05OyVYDNeucom0hF8KdAHBO/alarcHJ23dPdN1E0eKlI5gLbgChZ3Q
	 3JGlC6Ruz328RiaZZT94stKv31Zyxo/DM3yfRiem6aPiGKP73p4OBRnmxBPAXORSjH
	 echT8emnji0UQ==
Date: Wed, 14 Oct 2026 16:48:10 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
	Marco Mattiolo <marco.mattiolo@hotmail.it>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-ID: <20261014154810.GB1182143@google.com>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <179198100282.808561.2750105116872314866.b4-ty@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179198100282.808561.2750105116872314866.b4-ty@b4>

On Wed, 14 Oct 2026, Lee Jones wrote:

> On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> > The qcom-wled OVP interrupt is enabled at probe whenever the module is
> > already on, but the driver still believes the backlight is off, so the
> > first brightness update re-enables the interrupt and trips "Unbalanced
> > enable for IRQ". sdm845-mainline has carried a workaround for years and
> > Joel posted a flag-based version last October [1], which Konrad and
> > Daniel asked to be replaced by something that does not track the IRQ
> > state by hand.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
>       commit: 186fc521f211a207c323b753659f28d3dda7bc45
> [2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
>       commit: e60dc9c05e0f415ef8bc63b3179abdd49830a619
> [3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
>       commit: b32a8c32fea3855e707717155f198f03fdbf6f1e
> [4/4] backlight: qcom-wled: Read back the programmed brightness at probe
>       commit: 2ffcac916578f4a57347e717786d1e07e85cbf2b

No idea what this is.  The other one is the correct one.

-- 
Lee Jones
