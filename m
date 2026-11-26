Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693179;
	b=3JFSKJVlt6Jz2HhfCXQkzZD1RXEO0SGJr6yBfTUd69HPhflkn/OCNWO/sKYltI6mfOs4
	 Q3vxV5W/r5sdzmiHWaSY2uUK0x+48YAI+8k1FGxLpwz+YrCerkIyy1JaOtzk3R+I8L4We
	 dgUb3in+c5n9fpjweMGpsh3gZglfdUeV2Po6WZkLBKVJEFDlSKdNxFajXNnhu80SrqWkp
	 ot1z7pC1kFQ5fl6eFZE7InxFwaHks52H/sXLj07K2yxyux0//VZIn6ksLG8lID6x8rkLD
	 ELf+E6iVRUVQkNgSPmGQs4pJ5Mx5d8L7eHxyCG6WcmhFLrjS1c1n0tDexwqWq08JqNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693179;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=6zfoUu9yqYjFhPgxu/RMw2ffkjjrJIsOkSg5c99hBC0=;
	b=WE8N3IzVf8pc28jbyJM/nqo3BPn/TUqaP+ubgqBrLcZxVU2t2sZ1YQCfbdjH7Q1Mi7V8
	 tEDyCk/vIOSO3n97tIK6XL5VCoTctgHNCgyvyWZ7lH+uK9mfJLsLV9gKci8FFOV7tXqMr
	 /P7ZVwan90VnUboOfet+XYiN/rMqFhUbo6aMZirKPJQmBFqIiaGZ+MJg2U6QueLtCNpSC
	 k5FlKzN6naG+1f8Zon39tyx8P5iT6GMqk96NTN29tzAzR/cqQAd5C4qTEOfe3/tfPHi3N
	 PUWQdVN4O5wdjJ1agRrfqh2s9GSsosQ8m3cM1Huwsak3LycyD7etGvsprpJUQd8gRoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXql2dpI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F76606A31E;
	Thu, 26 Nov 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXql2dpI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30341F000C4;
	Thu, 26 Nov 2026 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693178;
	bh=6zfoUu9yqYjFhPgxu/RMw2ffkjjrJIsOkSg5c99hBC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TXql2dpIehycOPGyf4I7QV487bi7LbgeNFV77PQaMtYv3+SRyUTSy/kCXoMnhGEEG
	 bL2F1IImA76/IsSpj/vyj7j9GuOdRqO2Qwmh0YSUYBwkn3k4frjgeCNNP6LIVvkYAW
	 u50/L/QhbfX8ByXHgu1TYQxGAMtSg5Uqd1UjLFVFLRJf9ZhhgGOH2u4WqDS5ZiNT0U
	 XGUWroEfWncESPen/5PeKDqttf3Ga6Hu43ls1oNEDTW9pMQbZv7DbjajhhZ86JDQr+
	 xKIDVoSVIJyOMpQqjsO0LT9Of2PuBIGTPcwQ7UO2GnbNWmXod7I4wDYQCtCQbMFYjc
	 12eYhDplelnTw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Ziheng Wei <zihengw03@163.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261115080213.910112-1-zihengw03@163.com>
References: <20261115080213.910112-1-zihengw03@163.com>
Subject: Re: (subset) [PATCH] leds: lm3642: Fix container_of() member
 confusion in pin attributes
Message-Id: <179569317743.56981.748708182941145109.b4-ty@b4>
Date: Thu, 26 Nov 2026 11:39:37 +0000
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

On Sun, 15 Nov 2026 16:02:13 +0800, Ziheng Wei wrote:
> The strobe_pin and torch_pin sysfs attributes are registered on the
> flash and torch LED class devices respectively, but their store
> callbacks recover the chip data by container_of() on cdev_indicator.
> 
> dev_get_drvdata() in the attribute callbacks returns the led_classdev
> that owns the attribute group:
> 
> [...]

Applied, thanks!

[1/1] leds: lm3642: Fix container_of() member confusion in pin attributes
      commit: c8fda3f82a9b9a29bae152571bd66c1ff36646e3

--
Lee Jones [李琼斯]

