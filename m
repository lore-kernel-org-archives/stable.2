Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49264457DF;
	Mon, 17 Aug 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980290; cv=none; b=O9TIaCYCQ44qK3jatpWGqAmPA1r/key4cSpd0w2xvOTfwsgr9ei0pzFenDT84peY6TiRJFhNOUzphd3+l11HjhBXydkVd5uUeKMl3bY5bUPZWUsdM24xEL1ElwbHRr5HneAA0qehEnEr5a4XRU+l+Y8jQ3kVOYmWuAyeLcH5ULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980290; c=relaxed/simple;
	bh=0c3q6d2zWk63PBLtKZF8gEN4gUfghbPU/Zan4SOPAbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO2gRMPBlfyL3ZBeMg38thhuBRKKFyFxvpfSmvYsWYqkNRTIDX3Sj8Hh9N2QfihDUOOOdiyOgKCM1zkHC1N57L7w9dLlgIZJK7Bng9XTtPIknrlLB0dMeEyKAaJf95SqYk8sY6rDNj2goRcdefCmGYJ9JiT0Qoz5zzFEKvmbxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSDjjHqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSDjjHqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D281F00A3D;
	Mon, 17 Aug 2026 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980289;
	bh=EK7cUu3dbm4rFg2BVK151Vb9UHwILqRX2WqYb8MnLbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSDjjHqPmsKVphhCi4Kv8ll5B8iOl5P8FTaw4MbacOtNWo4F+BnCl8XhjFvR4PmUz
	 FF81Tey9aliUljD3zePBGjlwYFg+9fpvPYBuKu2rvROiaJSLAUF6JFZktnyfFIwel6
	 i5ao6fD7X+gM6/MK/+M6F/4VMSpPdE3ufawHmxDFPiOZxIUDru8mOlsUbVrunkeZIy
	 PwmwRt2kI8jcYrb/UNHOu4Huky2TRLNArFWDdrONUO9PPsZixQUvfvJfQYVCWAfhBK
	 8PT+CG+nBlgTy8D+U5MXlAffnu44ePmxLQMR+Hkxe8FKPhJ0xVIiiF2GUZ8jzjgcCg
	 17Z57vFX/jW8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrey Troshin <drtrosh@yandex-team.ru>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] media: mtk-vcodec: potential null pointer deference in SCP
Date: Mon, 17 Aug 2026 11:24:41 -0400
Message-ID: <20260817150000.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817055803.1946-1-drtrosh@yandex-team.ru>
References: <20260817055803.1946-1-drtrosh@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return ERR_PTR(-ENOMEM);

The backport itself is faithful, but the error path it adds returns
without dropping the scp reference taken just above it. That leak is
fixed upstream by 4936cd5817af ("media: mediatek: vcodec: Fix a resource
leak related to the scp device in FW initialization") (Fixes:
53dbe0850444, Cc: stable), and every tree carrying 53dbe0850444 already
carries the follow-up as well - taking this one alone would leave 5.10 as
the only stable tree in the leaky state.

Could you resend it as a 2-patch series covering both commits, targeting
5.15 as well as 5.10? 5.15 is missing both and holds the file at the same
path with an identical blob, so the same two patches apply there
unchanged.

-- 
Thanks,
Sasha
