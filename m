Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447859D610;
	Tue,  8 Sep 2026 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891637; cv=none; b=OVTLIZVY5GzK4Ejncimv6Sr0hJiNI3htRd6+amkEju2/mQaQdeH/dXdLhKXWxRXja3wp0/p1P5TOAY3HcbZRWOR1BxjgOIVbRAzq+yCrdyK6+sfpvmY2GB+ATDgBm8WsE2eKZcCtv43HBPK3YfxcQEr0oisGWnaNrGDhN6IHutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891637; c=relaxed/simple;
	bh=iF1T2G54AB61FFX+H2X6INkXOrjW3hIt8QYNA5KfVTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPCIS2BtDnZZbqh29pmlvcQfTmXl/l3bxOVFz0gUdtKRnaRRc1EKkkt4uODG9pMiTsJKvC0ZWafMUilx2Asv8nhVvuQHmZpTzr0l/VlqFXrSG7Sg6sZy4u6RiIDy/qTUTSOfCqNNOyurwZHoYrxZ9qhBRzv3pHvJAnlP3pVEuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkjkTa04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkjkTa04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBF1F00A3D;
	Tue,  8 Sep 2026 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891636;
	bh=ccXOdVFzH972jdgocJFa+E44+QQhkG58eRxMxfs9WlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkjkTa04ZPZEb5beLHdp/cJO/j/Gp8g1XFRdKygFna5WTunLf+r8AJ+WRXgQ0wVf1
	 xnEldfNR/arHNmpMNuS7WfdDvlx6nXGCmo7rRblmzNnqDWMN1SukiyCZUIomuHCXGn
	 xFYnEJK1j0AgS6jIDltyiXJOXB+DSpi2cRyTXAobmXF5mfVguV/7w7Sk+QIX7IgwoS
	 MUIDpboS8kRfhsaDEIxZTp3rhqpmR+Uw5JBi4dK1e/MqpVcDanL/UKUwUPs3NtsZ5w
	 gII4H9oioLPHv9uU2CDYf3L5P1N5atkLlJCNPSkygE1h1dUqt11qSpJrGdYVjbc5st
	 S5+8c2Xqz3BtA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] cache: sifive_ccache: Remove redundant dev_err_probe()
Date: Tue,  8 Sep 2026 19:20:28 +0100
Message-ID: <178889161921.3146991.13668063347588456069.b4-ty@microchip.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713112946.468067-1-panchuang@vivo.com>
References: <20260713112946.468067-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=466; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=vcZWekDFgRHjqKZw/CO3x6YyAvbCmqMsDCJ5P79VCoI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFkLAl9LztBwe2yjuO7Smqjkmd6z5MNmvnkvfcYsI93D8 fPLbQ9tOkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAnCT2xn+mZ29dHbHts1xyW90 c2fUet1b8uUVp+6TrM47Op+XbrzD+JeRYf3CzG7B+oCtvx22dfjzzVEQmB9nuzLT1s2vNeVPsOp kbgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 13 Jul 2026 19:29:46 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err_probe() calls.

Applied to cache-for-next, thanks!

[1/1] cache: sifive_ccache: Remove redundant dev_err_probe()
      https://git.kernel.org/conor/c/75effa447550

Thanks,
Conor.
