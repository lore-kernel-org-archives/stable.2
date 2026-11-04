Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795969;
	b=RTEbiXC5pGE3SHVxIpSX/qFUyuT9dPxTNHf1dyrX9LyJFT9g46e4+WRm7mkwmk4mT07M
	 dZt1rTxNPfe4WQQfUQp6WQF0ogWu/y3wE9xLsX/ASEl7cToiaD3rpj4wwTVPE7BHt0myM
	 Z6zPqnwVg+ZiMQfDvUj4mS6vdt9S5CmEn3GHc+MiIBvY/1w+oRBs3tzIWsK2IGsSs1pgL
	 +eyrd/+eQajY+IofLjus8ohgHKf39dqXBzRz71gX7LLSnUynKla8Ev/goym0IXH5qe8fk
	 6cEBwEmczDEwPgc1ZGBrYpOIcdL0uq04gOSuMSzLLYKDxLqRTj6TeLLf1wAEWBo6X+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795969;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3pAHxwg5eB4oMCrESxKjvbe89M28ObnZwTdmRi7rnnY=;
	b=vLqzjK+bvOyaA7HrYOrWTU9CHMQV/WArTrd+PknFLcrfpVlML6z8kvm20s8ZUIGNQ1pw
	 i2g9cDMLizm8SRDYfAszipYkqb7pH14GgE5vX+VMhLwGYdb3HchBPDkI6jh+s2nqAcVC+
	 i/Z7PZYoxoRQ1iOHL+K1R2Z6rkNch9ggnmMnhGsxD7vldlbluKM5zkKynSYMVrG1SRCRr
	 v8fYVQA4CuNvH7Ecvqerhcd8+6/rAoq/fyBSKNq9yBWrwJFjwk6VPlGgdnsDKTsNVaWBy
	 5OhkTLt/57BPrDf6jZiaCXFLDy0oGEK+qr92ZNqFG+bP6HGZvoC+LzkU3gNkGVN8d+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JhR9ZsV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C955606A31B;
	Wed,  4 Nov 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhR9ZsV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063ED1F00919;
	Wed,  4 Nov 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795969;
	bh=3pAHxwg5eB4oMCrESxKjvbe89M28ObnZwTdmRi7rnnY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JhR9ZsV/khszUI5P7fdzbOC0cHXgq0ZJg82FJw37WJqvcGTb04++rUafDGD4kgMtV
	 rN/u8086IjRTI4AtqTUYfV2ELVM+uZ1yQfRpvccyTqrSxT29BbRIgi9y0EnG62bqkQ
	 RKvde8VTvYIJiPVQBfhraJttOFqzJfbAoNCTSmeBC0a48+iphffxdICzrFJrXYbnTx
	 6av21LAhgGqiE/rlqgp5gSEHfi8qDO4jLF02t0DXCPtw6Jb6hw7mFx8LDFhoDXl3vB
	 lYeoTux4ApZi3YrpDk7m6zEkbQ6tpkR7ZkHrRgwSj+XoN7pSF6oTTbWx31wdDZ67zF
	 HbQCW/2cgW/8g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 4448425F4300;
	Wed, 04 Nov 2026 12:39:27 +0000 (GMT)
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
Subject: Re: [PATCH] regulator: cancel disable_work synchronously in
 regulator_unregister()
From: Mark Brown <broonie@kernel.org>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261103174911.1600930-1-lui2012qwq@gmail.com>
References: <20261103174911.1600930-1-lui2012qwq@gmail.com>
Date: Wed, 04 Nov 2026 12:39:26 +0000
Message-Id: <179379596607.2456854.2339185330606278000.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=251; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mHnd+pylxKnwPG35sJ2/zsEaKSEHCX0b2yhbKnhSBrg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeq9enuIquvlZtWJbTujaNY5qy6Mm9befnxKy5dFE1c
 6OZuWNZRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACaS/pyR4dsTTp0Fj0R93E/I
 m1bme9t++bnp5NyQVpM+29tL97VPsGD4H/5PdYvTv7RVjivvbZq7csf7s5pW55N/NXD9Ob3hUnz
 GPWYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Use cancel_delayed_work_sync(), which also dequeues a timer-pending
> instance, waits for a running callback and blocks re-arming.

I think you want disable_delayed_work_sync() here for the rearming part.

-- 
Mark Brown <broonie@kernel.org>
