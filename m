Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE11370ADC;
	Thu, 23 Jul 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807504; cv=none; b=Dvn544LOjXVsrCYHXOxjBnQDNqFc0Wk1SQzOaGjUVpQFFG5wpOfNhOjzcnUYbhFPDltL0VN+rKbx4yWz0o1E+dGdWbu14R44aosyh4frk5FKofFU8zuW+NysmeJk2jAMLPwp9lDGZt6pFU0MRb2zj1X85NykBrJyhHrdcQoePKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807504; c=relaxed/simple;
	bh=Z3nb6HVG1GTUdoXT7hOsIu8xTLWpsZZuFYESu05qzlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=so9o54Km0l/DjcUxK/h7mn1kMBa8RxzlxPf7Mf0A2zQUT1lyAAOuoG5xBduXQMgfpv6ezXGBR9M+qBe+F2onvSjwhWYVhepnSTJw7mbs5iYH8yHVY+hFDrWylWbcIjOC2s6kTrHKV0v8DwGV14WuVyTsQkpwe/EmzTBNJw+ky8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGt85kU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGt85kU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E79B1F00A3A;
	Thu, 23 Jul 2026 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807493;
	bh=dKFI4P9SHqECxGCF0p5S46UhsYNl4tqIC3o9YbTl8nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KGt85kU555tXyZxukvUGi9xRw/I+dC+VNoe7i/XuB0ATlzPdQOWAJPlDANWjRG6zZ
	 VdsblW0zV01pWHKQwN9DZgyQrgMdyShJLP7m4BnxiXau7edcXmwYXvb+KQ4IBti7WL
	 Xx+Vreoq6l+YlEYwftqw6b7vpZy2YMAiMEVhPW9T+9DEUTajXgeG6QYibVrMZtrAw7
	 FaO85V+hhuxmcCIZyBXzedWLlj62yQ0gfUXnq/jcOJepo+cw6gxO3rGwl9tVYmybho
	 JJmfJfSYkHNLCAl+zSu4f5IhZbf6Dp9PbWVGF0Ge/+eicTFFzuw1WYavi//Fjt8MI/
	 k32Gh+oECihcw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thomas Richard <thomas.richard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a@bootlin.com>
References: <20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a@bootlin.com>
Subject: Re: (subset) [PATCH] mfd: cgbc: Fix teardown ordering in
 cgbc_remove()
Message-Id: <178480749205.3382441.5364233727433592490.b4-ty@b4>
Date: Thu, 23 Jul 2026 12:51:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 13 Jul 2026 16:43:43 +0200, Thomas Richard wrote:
> Release Board Controller session once children are removed by the core.

Applied, thanks!

[1/1] mfd: cgbc: Fix teardown ordering in cgbc_remove()
      commit: adfe19688536f8f6d2bfd84c33b5af8f26e1e4f8

--
Lee Jones [李琼斯]

