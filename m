Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8014A4CC
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074369; cv=none; b=trtSZtLEvdFFZrkJwhRFQPJ+zWeW2wpVvMRq65P6lMyCJPmfmDd4h50T6tDZgbdOsCZUYkOx6Ry6lai7kSpfn1nfpJzR+L9P6Y5XLqnGJCHcm01VqgMDwpCaXl/+lHTYt70dDxqZpP9XXZdlJfgYfH5Q0t2K3sD/mmCQqd2TL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074369; c=relaxed/simple;
	bh=xZAkoDpViNcMPjvHI9ufag8ldUDmYNfnibM86In6OEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk7ZxU2a+yYeMz0RjXDwDXfQvJLd8tCoHE2ijptLgFsgt7vLt688WF4J78uXFDXC5p48r9BarU981oBGfjKyEeeMbzzaaAeradwW7D4Pk3iUaJiJ1TuWZ2jhnIgaoJ2+PcKP0dG3SVD1w0m545VFEThmoOx2Ezb5p3YqUhSW/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdsdvmhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdsdvmhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFD11F00A3E;
	Wed, 15 Jul 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074368;
	bh=46hsRGXBgblkB9twTQH0MUxJhklrmtYq4tG1ajnEx+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdsdvmhMJDEHIL6amHlSKjeKB3ej6XZeRRZV5OpoKNnnwpPsj71XhJ/CJnReksfza
	 aKAbQFAzL1jJbMRKVVfsZOHDZxo1Q2dEu4+8IbKcgENtLa78JtX8zZ8U/M0cBoZg7R
	 lBrM59RAaPpNtMUl3414Rum+FzzHFUb2/4QYs9Lo/uunnfEMSlAlRB8t25k+bGJ05n
	 onLQdvP4dOFDmoKrKDN8nMiIXLa1e0o3if6f71wEx0h0opozyr29P9pbSNTvGsfUVe
	 jX//ZCuCKCh8m6av8XKb/ws0YiL1wI44/eu45KcHEx6bb7YCz77VAvacmdb25LwZZl
	 +H3mCVUy2/pUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Vladimir Zapolskiy <vz@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH 5.10.y] iio: adc: spear: Initialize completion before requesting IRQ
Date: Tue, 14 Jul 2026 20:12:32 -0400
Message-ID: <20260714200600.stable0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713165833.500024-1-m32285159@gmail.com>
References: <20260713165833.500024-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix the chance of a spurious IRQ causing an uninitialized pointer
> dereference by moving init_completion() above devm_request_irq().

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
