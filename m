Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198549;
	b=hZPALLSl9VD0q4MLLcZGLqLRam2hFJHK++6qfcQ0P1J2U8P4TO7v8Uj/X1IA/cRBYyB5
	 T8ojBo/k+TDQRHqkOlQZwh+yzGR1md5/n6Xup7lT3QmwzamXUGFLK1TRZhWW/ifyZUJqb
	 G5lIJgF0T21Hl49yV/Jq/Pr7cR80RNNH7WE3v0sWeK+Kg24BCi4RK5YNlgyjhKJMeTL+M
	 B+rHEXMUR/mJwXSR/kSbTW02iQg+0nSEPcJRbOogu883OOZoxs+zr5DRn323o+h54VRMM
	 R4+HFJX15kOJVnzr1cpBPdic8O5ZnqsnoMAPtwJPgWyRudGkgyxmbAHR4zxDlumn3mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198549;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=TFJBnND1FRI31n2cTrtgv8IYWoLakQkBsVk708a+dhM=;
	b=gQG61tvWIfsuO9Z5VDzotSjhaH/kyfiZtn86ylXXJDRmawDdAuPTPZHv2UvqoYCIKeKd
	 227Lnm94n8oGnBFwk8JMaABHGDNugyq5wFW5AL/Te8WLaAnV7jjuonOYgXnrR09QkQWI4
	 tSzXR6DHzuVCBfr/5xAhZSVDGDFnSh+7e1XLqoK/GXH8WC+9f51rm9EubG9mGDvSETy5M
	 Lmdj6rM9tmQHslX34kB5jRGN6gc78IO1snlFYlcrvC7lOkdjjcf2BajXzw4KWnjSp7CKW
	 sBi0gfeccNsd8UilnReZQ1tPlJyuoVEV9gySu9ExFgxyYCLXRoFRqoxguWfsQL/sR/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKGUnVQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F7606A31A;
	Wed, 28 Oct 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKGUnVQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E731F01825;
	Wed, 28 Oct 2026 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198549;
	bh=TFJBnND1FRI31n2cTrtgv8IYWoLakQkBsVk708a+dhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JKGUnVQl7ZyavXtT7Kczvq0hvgEijuwKpQeX6Y3YltdL23/t7iXuxD7fyfBh7AUYV
	 Gn1+X9ULNU1J1D5QfP4X3ElvIvvBZM6yR00qKGlaZhrF5JpQQqtBNfISmpfOHKuttn
	 HwgS8wbrVxQ+vW+T5NMybHHL00/dJvJ9WnzVqZRFVt5p1xOMK4JicmwJnDtYtviKVS
	 y06NJL4w0pQ7FcfnQbXI4lqmbX4hhH8Da+bzoWJfw+jG+MoRK9RC7f0d1WdGAGCOqq
	 H8fW765Dp5jrCmB7DAXvZ6hDI9qPhxqmptHixHWCqOFDyXupTtaQELWirzvXdVggmM
	 rDVdJ5ka4rnFQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 George Neacsu <geocausa@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>
In-Reply-To: <20261018-qcom-flash-v4l2-release-v3-1-02e18d30b18a@gmail.com>
References: <20261018-qcom-flash-v4l2-release-v3-1-02e18d30b18a@gmail.com>
Subject: Re: (subset) [PATCH v3] leds: flash: leds-qcom-flash: Release all
 V4L2 flash devices
Message-Id: <179319854743.3749657.15932777477345365666.b4-ty@b4>
Date: Wed, 28 Oct 2026 14:42:27 +0000
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

On Sun, 18 Oct 2026 22:38:27 +0100, George Neacsu wrote:
> The probe error path and qcom_flash_led_remove() use leds_count as an
> array index before decrementing it. Since leds_count is the number of
> registered LEDs, that first access is one entry past the last registered
> V4L2 flash device. The loops also stop before index 0, so with a single
> LED nothing is released at all.
> 
> The V4L2 flash sub-device then stays registered after the driver is
> unbound, still pointing at the driver's freed devm memory. On a Surface
> Pro 11 (X1E80100, PM8550 flash, IR LED linked to a sensor through
> flash-leds), unloading the module and then setting a flash control on
> the sub-device triggered UBSAN shift-out-of-bounds reports and a NULL
> pointer dereference in regmap_field_update_bits_base(), called from
> update_allowed_flash_current().
> 
> [...]

Applied, thanks!

[1/1] leds: flash: leds-qcom-flash: Release all V4L2 flash devices
      commit: 4b2f49cc6998dc7fa243eed13cab8c48a4d95138

--
Lee Jones [李琼斯]

