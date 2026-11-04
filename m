Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804613;
	b=aY5AfOqaTsftxSxhXu2fcKdbLp1qFQSG3nwLmbMRwGuI10/b3cE85N8f9hwAiP6MhW8Q
	 L07TQcrhdANQKoVBnf5zpkp0FkLh7MhE2GLDkBNimoXZJNyA4n7sxzJWP/clUcJCMbxR3
	 yOhlahI/SlCacIj4b5+X3lt2S+tq3yQjrHui0PKsI+Ifmoa0i/Ca9zYBuT3fQur6MDqwb
	 By2nBCJoYFYYEN7niR1Uwv+EeELvRJv3fJdRiiC9kOYnv5AnwrOa5bgS09LmMFSQICPZx
	 nFeoa3bEfxqW3nAIrZ6ShDeYIYAv/xoefZ5qui4ccwxgjS5qZxNa6oJ0dItS9CeYfPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zQQ1Vc06LqUongm1/zFlceNM7/HAgOD/NIGM2scTpfs=;
	b=h5XX8uceuNGSK232nLQkSk8Yfn5JXFB69+6ChvD4fpgNidHOPqfD2o1f2GSLZyJWOESo
	 dCtBFTiYkjN2SCA5ghZclD7EKxzK+3FeLIaJ4DlrZAsGzmEKxL2B0rmkD/iTqHepFwnH4
	 t9bKYj0ozNVF77AWisF7y32Qz0ZCwVPETXi18V6iuYtWp75gFCx6Iz2f7zHsgbk/UxZ5/
	 cGcExzI7fPK+jhgSIHknKv70zaJBmYENWPCTljh50sWY7JpvjVDP348VhzEPj4+bY37Vo
	 T1F+0mm0b4BSlmBbnHzAm32J6T9zV70orjTQx5L0wen8bQOZ6eKjEXfZ4oDEFFzRvMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmZgKazM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE23606A32C;
	Wed,  4 Nov 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmZgKazM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481AE1F00A02;
	Wed,  4 Nov 2026 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804613;
	bh=zQQ1Vc06LqUongm1/zFlceNM7/HAgOD/NIGM2scTpfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DmZgKazMQ4hvjav9DVy3LjZ+gfRayHBSgYW6SCZvIIg5jatZ8wFVYUbyQj/qKyRxx
	 ZcV9/8x0O7iYqYJEGJe6hB0MhbstCxIS6cD+R7rFVyz20JTD9VQrTV1OrDf/+OMVnp
	 74gsuYzbx0JJl9oKY+BInF+pit6xH2LnW1qq9Ge5BVVAAMprp/32v8dLMdcQ38AVM0
	 XEPTe3DqKULFClLoIc+lL5UbBxt+4Llt6LYHT+BCjCKdK3utD2XsSzqesoPTC9gh4/
	 nvCFuJ8E/CgPjxeqOb2XLOosW4LJZpk43KE4qPzbQjQecNY2GKgYOXpRKpZyzatEaf
	 cV9r6McySGdVg==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"eadavis@qq.com" <eadavis@qq.com>,
	"tiwai@suse.de" <tiwai@suse.de>,
	The Darkbird <thedarkbird@protonmail.com>
Subject: Re: [REGRESSION 6.12.y] Please backport 70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")
Date: Wed,  4 Nov 2026 10:03:14 -0500
Message-ID: <2026-11-04-1-daily-reply-0005-re-usb-audio-oob-612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <shfaXkZCI7FtyNr5tS4kCC_d5E4uQFhc0MtwJa2CQFXpNMfSw7Ub6urwWpGrcoRnHuoneJEi9mLwtnvVImMhz1Hb25iwNJxx8GZZsDCV_HE=@protonmail.com>
References: <shfaXkZCI7FtyNr5tS4kCC_d5E4uQFhc0MtwJa2CQFXpNMfSw7Ub6urwWpGrcoRnHuoneJEi9mLwtnvVImMhz1Hb25iwNJxx8GZZsDCV_HE=@protonmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-03, The Darkbird <thedarkbird@protonmail.com> wrote:
> Please backport the following upstream commit to 6.12.y:
>
>   70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
