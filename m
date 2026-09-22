Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176D4F7CC2;
	Tue, 22 Sep 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074862; cv=none; b=mxZFvYphiP3bZLVKJS2aENXHQFfxOA06JY+xcGNms7WEhmoifJgW6kJSxLR2WbO4P7CRe795MaLx/uFVf7MQnM+Tpc3wdUg50CWHTDHBj8jTdnaOULv46cBk6bV8SJtrVYT64tQjU7thXmJH1kfyKF45W0kUwBP2MnpRTjUI3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074862; c=relaxed/simple;
	bh=wjNU9I/Az/NKGeCqubCpD0V5tWNSRzrAf9QGIhV+xMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VMjJZLECrBV9ZflBTlYtAZNYn1t0uOGy4FKcDNdrIv9A8EHe26FJw+rlPD5TO45/WHA4EoOPPyErX4L99Wc0vEJV3KHSjLnN623I/6s5DUqKioq6qEcEcdz0tKx8KJgH/xJSoDffZPf+DmrGjzLOW4k1J3fRAeIA4stqi98GIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT25D4Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT25D4Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F861F000FF;
	Tue, 22 Sep 2026 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074861;
	bh=+16wq41KVxbnmCP3te3elTSkwT3Xi9ULqmUVUXOWlwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AT25D4WzZ8uKpspTEZSOQv3KY4W6TQbnILr3SK+doVf/7MCYd070Uq+ZHUWhs9dbi
	 P6TaR+GCFAoDmOyFkvo8g3ROn0zjYpDDi+oCxwwbuFjwr3ruXz04Xf9+dbHt7DlKSN
	 yHxxikgcUnGJTK4dRULpTU3RZ2xEI5AmMSH3IfgofFGtq0uLBqYTSW36qy3R1ITJ9/
	 3zlByPvXWDP4yTeoxgWcC/DEqEmzoRuJgSsL1JLTKla6fzM6JKdyFA2QKvW71DQhXr
	 u4qLuwF1LT2c5PooVy66NYcakOGJ31wsex6x5pgGEPkoXmnAJlpWrVJ38wP256c8p5
	 efM0zMWE9gWvA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, pavel@kernel.org, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260910194525.99654-1-mhun512@gmail.com>
References: <20260910194525.99654-1-mhun512@gmail.com>
Subject: Re: (subset) [PATCH] leds: ktd2692: Pass context to regulator
 cleanup
Message-Id: <179007485955.3295011.7984610080294031068.b4-ty@b4>
Date: Tue, 22 Sep 2026 12:00:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 10 Sep 2026 15:45:25 -0400, Myeonghun Pak wrote:
> regulator_disable_action() retrieves the driver context from device
> driver data.  However, ktd2692_parse_dt() registers the action before
> ktd2692_probe() stores the context with platform_set_drvdata().
> 
> If devm_add_action_or_reset() cannot allocate the action, it invokes the
> callback immediately.  A later probe failure also invokes it during
> managed-resource unwinding.  Both paths dereference a NULL context.
> 
> [...]

Applied, thanks!

[1/1] leds: ktd2692: Pass context to regulator cleanup
      commit: c73e9f04445f361d5f19ca2edfde742ce18348ef

--
Lee Jones [李琼斯]

