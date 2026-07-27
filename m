Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F942903B;
	Mon, 27 Jul 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185997; cv=none; b=WM756h91taUxAYpQIBO7Y3nKKYZ33FcZQRzdHxq3kAPf/rbk3/xl2tEy+uelJ5zv9kLJNLxPNmQWumqHIGnVJadEMagUVw7OSLx8qoqNJ0omi+B0ycBNZjcZMsQwnwi4KBK00lhD4Orb7JuEsTKl2ZrmfPAzL3+vFDj295WEC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185997; c=relaxed/simple;
	bh=yeTBjCtcRprg5WepPxqF5sroGINv0iSKe1nwkluM1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLq5rdI5OToIjKiAA+N5hARRnAW250Iqd7TYFi9mISdf5qsJCxRYmwGHzJUjvxtsDbNBdwXv1o9p7KmtWjArqma9t+MYLyWIY1mSdhDH6fltJ6hONuiDQQooh1YH0/JmrbkWTgmnsiI4K9kHAWGOhXFQeCeV0NcVcHm7e2YUuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYg3x19G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYg3x19G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC251F00A3E;
	Mon, 27 Jul 2026 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185996;
	bh=aaBgis3qtdrlzFxJhP9EiyfEffuF2wJyLIrF4U8tTE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYg3x19G9DTmDhuE1lTpB8VI6TlwzJZoJ2LqLBbInQYpQE9WvjnKURbktuthf5T8b
	 70CAluturJW1yu6kwHxeoCe1P4RBEFjmGlEoYYf3JuGDyBFe5OXO1yua0GHTYg+3xd
	 Sv1ncYWicPwf/E61M5tI+GeZcCDWUzWYUnVPCnakDlJWxoM8tjE14ZljI/8f5Fpm7O
	 xEwB3fY2ebPu/3aLMZIc7WVHMhdNuqY0A9Jct4ei9MpVlwSudUq5tVvQmnd8JNhEHQ
	 FiT2cBW2o/XJa+nnS8QFGHHtb+XmNzZKTWPzb1N9yKHEPc8fBQRXRFhFnDv9kLZjJ3
	 uHpC0Nz0sgy6A==
Date: Mon, 27 Jul 2026 22:59:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: jz4780: Cache host clock rate at probe to
 prevent CCF prepare_lock deadlock
Message-ID: <amfGZudmo_oNgf04@zenone.zhora.eu>
References: <2db6fd233aceb7238474e4833f4d25ca681c3ffb.1784492382.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db6fd233aceb7238474e4833f4d25ca681c3ffb.1784492382.git.hns@goldelico.com>

Hi Nikolaus,

On Sun, Jul 19, 2026 at 10:19:43PM +0200, H. Nikolaus Schaller wrote:
> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> and the I2C adapter lock, which triggers when an I2C-controlled clock
> generator client (like the Si5351) is registered or modified under the CCF.
> 
> During an i2c client clock (generator) frequency change, the CCF acquires its global
> 'prepare_lock' mutex and the driver calls i2c_transfer() to update the client's
> chip registers, stalling for the adapter's I2C bus lock.
> 
> Concurrently, an independent, parallel transfer on the same bus (e.g., a GPIO
> expander handling LEDs) can hold the I2C adapter lock. Inside this parallel
> transfer path, jz4780_i2c_set_speed() calls clk_get_rate() on the host
> controller's input clock to calculate bus timings. This call attempts to acquire
> the blocked CCF 'prepare_lock', creating a circular dependency that freezes
> the system.
> 
> The jz4780 host controller clock itself is static and never changes at runtime.
> 
> However, calling clk_get_rate() inside the active transfer path introduces
> an unnecessary dependency on the CCF internal locks.
> 
> Eliminate this synchronous clk_get_rate() call from the active transfer
> path by caching the static host peripheral clock rate once - inside the private
> jz4780_i2c structure during jz4780_i2c_probe(). Update jz4780_i2c_set_speed()
> to use this cached value, safely decoupling active I2C transactions from the
> CCF internal locks without any risk of stale timings.
> 
> Assisted-by web based Google AI (pinpointing the bug and writing the message).
> 
> Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780")
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

To be clear, I wasn't against the patch itself, I just didn't
like the commit log and I raised questions coming just from
reading the log.

In this v2 you are missing the changelog, please, don't forget
next time to add it.

I merged your patch in i2c/i2c-fixes.

Thanks,
Andi
