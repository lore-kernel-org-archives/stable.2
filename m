Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF4509F17;
	Wed, 16 Sep 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566818; cv=none; b=OQzOE7NV5luB+EZ2FXTsFA3JTMi37VipeKig8+z3zTkluui6hTYkjuMC1hne7Ek1VVWJzZXP7f/vCRGtoF2DpwPD5BzALntWXtLvVJqbSTaeb1puoiYHwC+eX/K+qwndNbBdiHZSYGc/bctsHo/gM1HsWb7VneUYsnECt2Vz+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566818; c=relaxed/simple;
	bh=s4CtldfZHDZiv6XKgG7znfdte/Q4hFVSKItoYW4kz/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fSuYAJg3TFrn9bJ8WOBMqAhH+eeiE2VlX52eCnt4BcbVIiOP/rLynf9lyOPJo/qkGIaG9W4dyTJAiF+JXrTU9CmcOMAxhayo+uQapXN6lnURINPVIwZyEu7norlDAc2fln7Gi+vDGxgsoshdXcwFmhOvIXhr6bqHogbOZm6QZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fklOL+pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fklOL+pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E741F00893;
	Wed, 16 Sep 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566811;
	bh=+HmCJQlvKfL0+t0+D5gxuT6S2czscuo9HqFZUXInOiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fklOL+pTLCujgZ/ZdoBgdLqb/cO/LBjNUa1ysXLXJoKP6GwjEd6j/09kcQPSBmLFx
	 538X4T1bpBUXcMeIIz44Y051F8jr2DcRQezSmXPkGVB8mlEZc0jE3TKGaVYPYsWWhG
	 9VR4mrc7Nv8HL1WDe9y21wxUF4I3AoWzmOUv3lQttUAd+Y0JNaW6Kn9IJ6n3ojTQs9
	 Lfk/1iC+dm18veS6wRKF2LmLvFmCwhiffrlLQWnEDJx7Q+twxQzsEgTWlhiZUsscwU
	 mFtXvH1lwY/ne1p2mZLJBYLqR0WyVy4n6ASfhcxm2XWyyrSZFVVk/9dIgwm39PzaNg
	 O23fz9ULIdD7g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260903-wcd-dma-v3-1-d3920c6563c4@ixit.cz>
References: <20260903-wcd-dma-v3-1-d3920c6563c4@ixit.cz>
Subject: Re: (subset) [PATCH v3 1/2] mfd: wcd934x: Fix NULL pointer
 dereference on IRQ probe deferral
Message-Id: <178956680898.1616494.3176016583638775540.b4-ty@b4>
Date: Wed, 16 Sep 2026 14:53:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 03 Sep 2026 17:21:42 +0200, David Heidelberg wrote:
> ddata->dev is only assigned at the end of wcd934x_slim_probe(), but the
> of_irq_get() error path has passed it to the error print since the
> driver was added, while it is still NULL.
> 
> This used to be harmless with dev_err(), which copes with a NULL device
> and was skipped on -EPROBE_DEFER. Since the switch to dev_err_probe(), a
> deferred IRQ reaches device_set_deferred_probe_reason() ->
> dev_driver_string(), which dereferences the NULL pointer and crashes
> during probe. Use dev, which is already valid at this point.
> 
> [...]

Applied, thanks!

[1/2] mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      commit: 1389a4a5877403e57573d6bc01c5b7790a4472ce

--
Lee Jones [李琼斯]

