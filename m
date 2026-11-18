Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023316;
	b=XaftXRV58odDuVqbTXbEhvEoeI2HW2bOUNiB/mdBsOXsfAd60j1mUUXTXZ42sHYRruIZ
	 LFkzyzojQRIepreKwWOXLuWjsPPYxXAor9+f6BcooEr9feB7TurzhSjfICSrIDYcU29yO
	 x7SsBU3l3K0t0Ul5HdseMZfWzRsoxTxGAms7v+uWBn4OP+kX8G4626BAiShOzLKG06YSx
	 IhFYa64UhQwifZY0juJEnyvanPA2pqfe38w0BE+A2UcVmRKohSid6XO6ajGGBD3h4n8Yj
	 i73LxNQqHyip/iBU0DB8zbOw2kfVx6B3IOOzMZy/pVB1NjleG69TPKOO0581FxDEmOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023316;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Dw7WGN/zdTbSsNnOUS/3v0iyzpJDqboEra4LQ1qe914=;
	b=vF7Ua/wEeYpYQqt8SmpqoC6I8B2I/0d4ivqa0vomGp5lWn/v0fSG74PPPFfRRe9ZgKyq
	 /tI7Im4a/pT39+QQzrRm+Hc4lJgQUZ3cbWan6u2pnhIzBI367yVGwS2P8mJX4VawIkUQx
	 ug5FES0PMlKxLKKSg+lQihHVfLL52GjmJQhyzP1Bjghlu7icTYWq7N2WwB4UsvL3ny2oH
	 uVy6op3ZQvj45Op6ExkGQuzvSNiR0oXZGYPtU9I3BQiMod+B+yRXAYa8MLRIdlokmvPen
	 0HnWrpNM4CTq3EWtq2uqZMG3Uo68bp1aLPCMCy37VoIG7UczC94XMjED15YW5ciLODw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if4rO2ed;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061B606A334;
	Wed, 18 Nov 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if4rO2ed
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4421F000C9;
	Wed, 18 Nov 2026 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795023316;
	bh=Dw7WGN/zdTbSsNnOUS/3v0iyzpJDqboEra4LQ1qe914=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=if4rO2eds0WgxoHWQpfH+kUc9iWcQNhMwnixIk/nyFVjFryEWPlrs4FHjezqisAUu
	 EivfBufsfvUlwSNodigLmo3dpwAmNM2hbfP5VDAgweWQTqHPZBmMNjCE5240bP7QCt
	 pZOJeC0sqCBl8QGj3Az+GTfnt4dqSlTaOwQxLjcQ4qmwEJ0qPlnW2jOvySl5A+19mr
	 5PQIHcGzHNTyl5E7H9tQSizG2a2XkVSrZAz199EZytDd8Qdm9U2I0vnm4XuWGw/doj
	 q1IZ5AjJjVfIVul5xsRvXktECsQGcd+pajRVudN6YtNctuCk8hmXGTjT/l1BxW1qAg
	 t3ixhGtFMjA3A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
Cc: linusw@kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, pavel@kernel.org, stable@vger.kernel.org
In-Reply-To: <20261107042737.708109-1-vulab@iscas.ac.cn>
References: <20261107042737.708109-1-vulab@iscas.ac.cn>
Subject: Re: (subset) [PATCH v2] leds: netxbig: Fix platform device
 reference leak on successful probe
Message-Id: <179502331479.59607.5067236993551976548.b4-ty@b4>
Date: Wed, 18 Nov 2026 17:35:14 +0000
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

On Sat, 07 Nov 2026 12:27:37 +0800, Wentao Liang wrote:
> of_find_device_by_node() returns the GPIO extension device with an
> elevated reference count.  The error paths release it through the
> put_device label, but the success path returns directly, so the
> reference is leaked whenever the LED driver probes successfully.
> 
> Release the reference right after its last use and remove the put_device
> label and the gotos leading to it.
> 
> [...]

Applied, thanks!

[1/1] leds: netxbig: Fix platform device reference leak on successful probe
      commit: 41ea2c75f886db9846a92e367fcb637cf45df224

--
Lee Jones [李琼斯]

