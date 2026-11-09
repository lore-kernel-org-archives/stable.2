Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254989;
	b=yFWmfSqou5wSp6YRRS1gcam0VYIycPkGpbGE+i7HB6pO+cW6/J+uMLKNLtOyLj107FB8
	 jVw4ZLl29xJ/0DihYX3UKxhSic5CU4VFTAfimMwd6EqjLiDeKjvcF+n6qvCqaCdqWQslI
	 m9ZJUXf7lWM9ewnJxwrZ6/ItJy5B9xfVVZqksgumJBaiHlJ3DtyoZun5H5nWopbVcXLp8
	 U2iEYTh8mzxi0kS5PdAMuUfkV5pIMwl7fRx+9l+lkbiYKGS34caBK+674aWZY+G5/YvpX
	 eBTQQES9TAhGkpHxVIgluC6rB0XGnTLJcWDXV+uAUujLAK/Gho8PZJRALzUKUIrgw2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254989;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=e3wMJncUkyPyeD4oOnz3hi60hN37Fzq4tkhkf48zJPw=;
	b=VQ47n8EVulr7uSs6ydSWDbRNAD4c1r3FCWqyGyYXiZDm9gXGG+ODJ6bvN7bJL8KnV6gK
	 b/rOzn6XlnWAR+hWfFlzCYYNh3YZmvE7+x+IwAjkqJwm95hc6HxFDdouiKZ1ilTKx3vNj
	 ik7pWrI6CtDSa/eamMQlgVA8JuQazw9yLsVfsbkv0pr6Ag1WlXmJyVaGyKlqCrG8q5Pei
	 QqpQNxOZ8Fr0LF7wh96/e1IUt6NZWZDyOoCERz/LznZ2ilJqMSRxrQN3ZZMsn28OHmakr
	 laCDTenuCpJEILcjvufAmbX12SBQYlLM+J6ioLGLWjl88/Fj+Uh3QfYs8AJTfnEnZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF06NAFj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80701606A321;
	Mon,  9 Nov 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF06NAFj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D011F0089F;
	Mon,  9 Nov 2026 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254989;
	bh=e3wMJncUkyPyeD4oOnz3hi60hN37Fzq4tkhkf48zJPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MF06NAFj5ShZv/3ktaOwD1BMjVdV5Gal7JNzIeUeKWWT+hI3+n18YED0l/SW1G6PX
	 TkExxIcWCaGgqhzIxfJdddlr19Vo6vv+1WwqPhaok5WKF92uPKuUuZo2W/9I6jXgUN
	 xx68tZ0n9q6YGyNNdxexDg5sB3VTkD/hRB3DbqMotNBo1VRFgXm8cSwoX0tC7Dyi4O
	 uNaDYiUMlIN7V/LPp2ubVwhiXNh0tbcPWILfsLO2Lx/bdHsOWllr8fnV0RE7MOxAvC
	 UcW0Yu66JO3yAuFc6LnK7Z/BlBESQGXVt0H5eSp5CwFrMYjqCbqs2vnQPen3sqwq51
	 nOD2pgQla0ZkQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261104221249196PEndOlhSBLk0FozQ1xnab@zte.com.cn>
References: <20261104221249196PEndOlhSBLk0FozQ1xnab@zte.com.cn>
Subject: Re: [PATCH] ata: libata-acpi: check the _GTM return object before
 using it
Message-Id: <179425498783.1564905.7100810041309461151.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 21:09:47 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 04 Nov 2026 22:12:49 +0800, shao.mingyin@zte.com.cn wrote:
> ata_acpi_gtm() evaluates _GTM with acpi_evaluate_object() and, after
> checking the status, dereferences output.pointer without checking it.
> 
> acpi_evaluate_object() can return AE_OK with a zero-length result and a
> NULL output.pointer.  A _GTM method returning a reference to a method
> local does exactly that: ACPICA clears the reference when the method
> terminates, so the caller ends up with no object.  ata_acpi_gtm() then
> dereferences the NULL pointer while probing the ATA port.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libata-acpi: check the _GTM return object before using it
      https://git.kernel.org/libata/linux/c/f710be6e

Kind regards,
Niklas

