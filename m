Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBE3CA4A9;
	Sun, 20 Sep 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923494; cv=none; b=dKLhryvQOw7IYiyF6Kgy5eFIO18p5EOccS9VfFmgNmJpar4SjeY2gtlUPhon1t0I1BmJjpzz/TLYbmaLPK/CKgiGpys1Izg6WxVBLXCTKAAb4AsusVfXXuz+P4S5NTEPZhpe2Nv1K8hKxVWqQA5cP3sPsk6vHwODgaNeyh04HWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923494; c=relaxed/simple;
	bh=LIGe/m7Az5ezNuhMjll6aLgzBr6lJvzpMkKkb9xkC/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UG9Z4G8x3OqEgEq6ODc3VXHIF7hnlQ3YHuaSTn67/dMHYN2nie4xj+4ozKP6rE28wQDiYuUTImqw61KaUPXdW3Cw1oJFx+IKfF7ZJjB/j4KCk7/8JHKkByQUHZHDRj9E2k/bXO9XL9g8D6dA7dL4Hl3VCLQxF027hNV/RO+ccak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUO3Rctk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUO3Rctk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A691F000FF;
	Sun, 20 Sep 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789923492;
	bh=27E0vOzW1xK5tI+GEKDovtOwH7vrrrJMyJhRFmJDM5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YUO3RctklJB7DhDL1wBUapr90+QbJ/h7Z/B8RegdUETmLq6GPjohw50tGr0QPedFb
	 GGvh1e7pnOPQ1cpB5IlPgLSgawUQ6StqNs1Z3AUS5hmoq+wh+aNbQKtazgdt+/H7CB
	 vQunL+jdQ5uWLmJyPNImdXsgdBx/fJfTIo+Wg3HofCBhXEMO3sp4042XtZFxtNJJ2u
	 LdRFjwLK2fGw4OyWkAN9M3UbQppbhSv++wFjbr/ENg/JI2WM2w0+Ffoe0MJB3d5mM9
	 GIkTfQnAoHkjm8J3N1SK5ZUOtOLb/SfnMkL65hB4fVnN44yT0p0bW/TM5ANy1ZF1vD
	 7E9GVEzyXSKwg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Dmitry Baryshkov <lumag@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Janne Grunau <j@jannau.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Dmitry Sinyavin <sinyavin@gmail.com>
In-Reply-To: <20260920-nvmem-read-oob-bit-offset-v2-1-feeb7b672059@jannau.net>
References: <20260920-nvmem-read-oob-bit-offset-v2-1-feeb7b672059@jannau.net>
Subject: Re: [PATCH v2] nvmem: core: Fix OOB read for bit offsets of more
 than one byte
Message-Id: <178992349090.879561.13513828114190223028.b4-ty@kernel.org>
Date: Sun, 20 Sep 2026 17:58:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 20 Sep 2026 18:46:19 +0200, Janne Grunau wrote:
> When the bit offset is BITS_PER_BYTE or larger the read position is
> advanced by `bytes_offset`. This is not taken into account in the
> per-byte read loop which still reads `cell->bytes` resulting in an out of
> bounds read of `bytes_offset` bytes. The information read OOB does not
> leak directly as the erroneously read bits are cleared.
> 
> Detected by KASAN while looking for a use-after-free in simplefb.c.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: Fix OOB read for bit offsets of more than one byte
      commit: 841ea6e56cc88ec2c28826d62fbab88b234524c5

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

