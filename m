Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B774A92E0;
	Wed,  2 Sep 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363113; cv=none; b=ISI0SzG1RSDR8dRHfLEotLuK2m5XKsT0yAyAhCkL19DKXFl9jK3LmOLJFZWZUNXLhVjSTKJFsyU02weE+nDhCBERsteCPW+tvCrjeEgoD6Z7CvDU6IrisphhOOOieQvezj5FI/1pGkLlTt1lezg2HEPS6nhjpDvaQjMK3PCprIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363113; c=relaxed/simple;
	bh=F8/2e4coUXQd1OEy1MIBLrc2n0JoU2v7FX9aLwh/pHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vu+NSDd8s83ZAWbIHd81sbSeO66BPLT/EEzh5uVAC+q+Jq7I3k0bgp6I+GxIyVi0IxJsVDyVl77HYl5DwL+Z2cg4HgfhQc8c/o3H71m+CqHOVV1D8bhB/YoWMCE0IJDHnXu1OD2a6NF0kSfRuF3TvocAAOsor5MuwvYVoQ9SGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AycOmSUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AycOmSUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4971F000E9;
	Wed,  2 Sep 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363111;
	bh=i6uzuZvKCw0azG4q0pqw0jBpOqzGi2PjCgyH0kixHC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AycOmSUXIjOcllCh0E8Y1oRuzMPYyoA/UXQD1D5OzH1IdwZL0G2ZXxeKQT3xm3t8F
	 LJfhKmffSdyee7Oxvb8EGbHifKdp9cY1XPOnxPlUJUIozbt24k6tRNfkLtTqjnQXmo
	 ERpJ2YzI20dgnYzqBuPXSmJWL8zm1D/OVtxIOQgGa6BE/NaycSo8+dXZu/bx55X6fm
	 toOkq7K6eoFdk39mE2MBzKjE2PGl/d1NU59Ahy7JSrIIZD2DOfP957mZ0c6CpPujd7
	 36TI5eiU0Jab7keOCDP4zLuR3RifnrhaAtp1vqMc4i6hvYHmVT4nHcoICztvU977md
	 ffi31LWGLl+iQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Hongyan Xu <getshell@seu.edu.cn>
Cc: Support Opensource <support.opensource@diasemi.com>, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 jianhao.xu@seu.edu.cn
In-Reply-To: <20260814153019.1114-1-getshell@seu.edu.cn>
References: <20260814153019.1114-1-getshell@seu.edu.cn>
Subject: Re: (subset) [PATCH v3] mfd: da903x: cancel IRQ work during
 teardown
Message-Id: <178836311024.2127451.12083678367837110310.b4-ty@b4>
Date: Wed, 02 Sep 2026 16:31:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 14 Aug 2026 23:30:19 +0800, Hongyan Xu wrote:
> The IRQ handler disables the IRQ and schedules irq_work. Releasing the
> IRQ does not drain that work, which can continue to use the devm-allocated
> chip and notifier state.
> 
> Manage both IRQ-work cancellation and subdevice removal with devres.
> Register the subdevice-removal action before requesting the IRQ, then add
> the IRQ-work action after the request. This avoids leaving a live IRQ
> without work cancellation if action registration fails. Devres cleanup
> then disables the IRQ and drains the work before releasing the IRQ and
> removing child devices. Register both actions before creating the children
> so partial probe failures use the same ordering.
> 
> [...]

Applied, thanks!

[1/1] mfd: da903x: cancel IRQ work during teardown
      commit: df41eb0718d7ec4609c98844aca3ea381bb569ef

--
Lee Jones [李琼斯]

