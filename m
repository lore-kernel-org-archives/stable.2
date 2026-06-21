Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49F35028D;
	Sun, 21 Jun 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049677; cv=none; b=oF4AJmke4tvD7r/TwbPur2Q9leQsvWSNhda4K9nXJh9AzM1pPv9Sr3aVxnc+U11+uz6B5/m6PeNi/SFqX3A1i2jMTnFb1HU9srTxt5cAMZFMdcj+ervCn6W/cycMzb5TYclBwKNVvbPBou4gEtceVYNWJIKZi8WR0GDPHdm607E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049677; c=relaxed/simple;
	bh=rn/40Cz3ydH6DtFXROpHHGcx8CDx5Qjk9GglDltsYgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2G1tMP0NskGFCEh7n8V5kAtqHD5zBLHKfIGmd2PtdGqvLCKtgDB3B0+HFHulbm3knrvTMvFT1omDFWP2jULK+VhggcfT8hkJxFC5KT/sZa18Kpvmck3Wab2u2ups31/tuB44uHgPInCeFzuxJg6iVRh1YlKlcXHZWXPtvDZMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+hPFnIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+hPFnIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380E1F00A3A;
	Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049676;
	bh=OiF5vRmu/i6aQ6nb5HlbPva5iq5PHrNps6OyrcPIClM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+hPFnIsvxqVOn/mVmh9u+mtwgvP/eWZqaZaHr84O+Uaa1gKvrR/KJ0y4r9QBDV+Z
	 bXpYrZHY8uGMcONqevG4dNtoSawJiBqPOPbyXuXFJTxWtTlBe6may6lwuQwkF4JF0o
	 VcqrcK8PlaKY5Fo4Lhv91gWRHxqxAe+385qgPHNbZ/pGMwGJCGXMEAQI9hPyQ6H8tp
	 s0JmOEsyTf6C064c/apNR41k0SkXk+mzrxxPQuokin8lcn89JYC8mofxnp/8OMWayi
	 UGhW9UxE+liQi5QQkxYFigmmFxpQU3Z49YshEnixnqf764ORTk/qURa3GaYUK/jU8P
	 U4FjaH26eIDaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.15/6.12] iio: light: bh1780: fix PM runtime leak on error path
Date: Sun, 21 Jun 2026 09:47:42 -0400
Message-ID: <20260621133722.0004.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619143443.678491-1-etereshkina@astralinux.ru>
References: <20260619143443.678491-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit dd72e6c3cdea05cad24e99710939086f7a113fb5 upstream.
>
> Move pm_runtime_put_autosuspend() before the error check to ensure
> the PM runtime reference count is always decremented after
> pm_runtime_get_sync(), regardless of whether the read operation
> succeeds or fails.

Queued for 5.15 and 6.12, thanks.

-- 
Thanks,
Sasha
