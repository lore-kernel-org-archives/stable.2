Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718066;
	b=p+l1m1MoL4stFxZG+fTkRajlFbMxUqIetOE488svT5SlmJ+cnBGQU1uFEHKWoUpJPMWu
	 F7da181JH8bxVqNL3gfFTwLzHljaqkqgp3nGbuLlv0bFrJqQbacLgYHEHvgNq1Nach4zw
	 7toYJbPsylMAh83SzKQATW3w+M6m6v0JAIJfKcZx/Hs2+ntweesxXDmxip1vAYznNwQVu
	 n/xpnW+5VSKpW0y3JlhhL4sLq5FKY+8uDRkg3xclOMK2j2ZafLAT1zzbZ09IvKyvI3K7b
	 Cxmv7qu3fFFZJyFnARKzQKjnKn+lheG9TFunQLuM4rf262l+cy625xF19VVYJkAAIGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718066;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=fsIgPAQQdoiLECPqvwRwT3HVRoUgsXzd1UJ+VBGYznA=;
	b=1th+DhIqSJDUtBGd7BZnkh73T9Kh3mPU9GrwZRb+qxMeXTyG9lKmCxlvucWyWvMcbwzA
	 S1yTolGGIut/rL5F15NvR7wu8nkrUqREvC/fo0SBfciDhODdCqMt+dXjq/mdJRLA+DCdT
	 qIw3hrWWfHKUH/N6Rmy3ujaH5cTkc10eUYayocj429bmcHFsqhygJ/qnQ+7kBb+KnUrJD
	 wUkuna/tqFdSap+WAyU08WLn4kscHlW3y/lQ46GJVehAa3g+V1FB4HSJ/O8fhWvvH3Qk8
	 l0XOGNSbOyk8Ij9zHv29TIOsPzVQ71SBdZ1vzeTPQP5hmvT1laDhbG6QP5V0uNp9hRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo6ZqnPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC9606A31C;
	Thu, 26 Nov 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo6ZqnPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB44B1F000C0;
	Thu, 26 Nov 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718066;
	bh=fsIgPAQQdoiLECPqvwRwT3HVRoUgsXzd1UJ+VBGYznA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Jo6ZqnPHFmqviNCGtHjMYbh1feJqtEhYCPHoFTnqA2XoRhaxoWFN1uaARy6IlQmyS
	 RxRoqZagFlDu9F+YPbxmlBAf3/oK2cKsQfT5f6+iaA6svQnmC3VxZxQhE1Im51a1bZ
	 rFq2YEKiejqk1BKh4PYaQOYgcis5LOO0Et4MB76XnPshDWmm7nu7NjJYp0E/881kv1
	 8KEefXlCo8PkuF2uGNEqTzGAgu6RceRUOq6NpRpcRBhUjw+4qj4DJ4Dxhmh32ibSgX
	 w0qdmnLF+IGRLoX36yWk5EMhlxVWMyN0aHRYXdlCPX77W3jp9sy09J45xG+KwgU8OL
	 NgLQS0lgCmXSQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, raoxu <raoxu@uniontech.com>
Cc: pavel@kernel.org, griffin@kroah.com, Denis.Osterland@diehl.com, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <3EE90AC92BE07EA9+20261119023351.3933065-1-raoxu@uniontech.com>
References: <3EE90AC92BE07EA9+20261119023351.3933065-1-raoxu@uniontech.com>
Subject: Re: (subset) [PATCH v2] leds: pwm: Fix active-low brightness with
 default-state keep
Message-Id: <179571806459.14218.7457047485618205628.b4-ty@b4>
Date: Thu, 26 Nov 2026 18:34:24 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 19 Nov 2026 10:33:51 +0800, raoxu wrote:
> With default-state set to "keep", led_pwm_add() derives the initial
> brightness from the PWM duty cycle without accounting for active-low
> LEDs. However, led_pwm_set() inverts the duty cycle for these LEDs.
> 
> For an enabled active-low PWM, zero duty corresponds to maximum LED
> brightness, while full duty corresponds to off. The current calculation
> reports the opposite values. This exposes an incorrect cached brightness
> to userspace and can restore the wrong value after suspend. With an
> optional enable GPIO, the cached brightness also determines the initial
> GPIO value.
> 
> [...]

Applied, thanks!

[1/1] leds: pwm: Fix active-low brightness with default-state keep
      commit: 81cc7da655d64d452c1346f1cf33ebe78dcf3ec7

--
Lee Jones [李琼斯]

