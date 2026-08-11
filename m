Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA4353A8E;
	Tue, 11 Aug 2026 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474297; cv=none; b=m2Oc6BSwWNb23d+/0iyOEc42E+3eD34zdlTzNXkyFoFVF1V6UeYH/bxF/ZY/Cm8a9A3ZutV8M2AhQf6rpZXzMgCtRyVJR3pUYiJuRTihofKp0zm/YcVZaftC5ObBfW+nTY3/DbzcUrUL2o/OxdRttKuRX67aHtKbnQbFYZC1zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474297; c=relaxed/simple;
	bh=9RVGymyr63M+CuIUGj+cqQdmJUybT4RexizDE3U83ns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gWBgWfXx8Yp9/MP+jfbUszSpbD3bHG7G9nbFuyOUsrZzj6tfEZAhPzFMJeQuFCJLLcen/i1SSzgnBeVc22cv7hv/vwLo2UVwNQHi2j+5wB30ww9qLhPWV70arClPNOPr9SC3fE2RoV3DaLcg+JjclOmKRpGNDpyYqbI4k57ZqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPJYYvfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPJYYvfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9794A1F00A3A;
	Tue, 11 Aug 2026 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474295;
	bh=78jkVzzHUSr8oR3vzkTgpDE+8qGTzuuPqvrfa8j7gEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IPJYYvfbWgWUHpLf32oI6yw9nfrp9qHC/z1S01FH6YPvTpik3iXjCRhlg/kJ3VlTR
	 IMFtK+II2vWxawUWjtdjEJnAfZyFf/uc7xyPgHWhofsKw03CjLbMmdVsYkhKPkGNtU
	 ZdwE0O8REintcvzJekrVVq4fLCTnzTYJTarg8p5Eg4RVp1tISZyvDdxuX4EqdVhdgJ
	 B9/EA/AiLSDgpWkiBQRQB8gVEjaHdv2LjB7Nhod2XvlwStAsOG6uC8DS+kioe1PUup
	 Yn7zPcmLCItJjISOAForAhCuJ2SoE0i+TDy/hTqxmK/i+CB0i3B4bV6SFQ19eGlttz
	 KQbWBxjQCONWA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260718130024.341243-1-martin@kaiser.cx>
References: <20260718130024.341243-1-martin@kaiser.cx>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: tracing: no ptr dereference
 during log output
Message-Id: <178647429224.1113716.1062810521058645946.b4-ty@kernel.org>
Date: Wed, 12 Aug 2026 00:21:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 18 Jul 2026 14:58:48 +0200, Martin Kaiser wrote:
> The fsl edma events store a pointer to a struct fsl_edma_engine in the
> ringbuffer and dereference it when a log entry is printed. At this time,
> the pointer may no longer be valid.
> 
> Event injection can be used to trigger a crash:
> 
> $ cd /sys/kernel/tracing
> $ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
> $ cat trace
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: tracing: no ptr dereference during log output
      commit: 2ea04dca8e627f722caa7a2037cfbae0257f3501

Best regards,
-- 
~Vinod


