Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971010;
	b=zXnzsauwnqg+OPui6cLQiWk5yro5ZhS82YNFkMs4hnApsDsWDG4X+svL7373wwSQz5uF
	 kQx3ZT8iGiigUDwtvsjrh3b5igLNmvK5NIi3IKATU4X+AOZLcHeNFsKN42LK7AbSBXEas
	 B+1JlpK2uDJfL6f9+iy+yqX4MkIAYWvFQ7OBMCRPBp4qKLn+CGhqyGlwKUnNuZDAj8S4p
	 I+I8+CJoegunwfHTgJShSFFPU0MUIB5sDn4LyCgF1e8kS++HPAzuy/Mqt4z15DJrL41LN
	 EYbZgDpxTHBeWQe6lczNcSMd0pmeLoo1Q+HgoDLWyE7riGZ+wu2QR02t4EqhkSkkZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xFCEI4cW9h7sIqvdTdAIE9r+Hlevz+gA+VngtwR2UyU=;
	b=Oz9Ejow9ZBZejmtBCagfrIuMwpWrMMeNZ+yZjbYzhhPf+DMMcdgSE3gK6QdMHw9F7n4m
	 InfjrnmpCbsIc/tLwAj2ibDvUfmGYZnCzVmsnnnZlKFAPUswnrLdnt4Oo8+CVjy+Jvsbn
	 I8x5dMGZWwYoWzk1i0xRdbK0uvbv6WxJwZu0XiJrdjP8ePnxz6D6s1pWZEyY1plCUx1LQ
	 2FWwDFCuHVl/huMUNeNRsFunf1SZ9yHM0KtiIWq9CcoVjQ6xXTArrzCM8WRIOecEj9Fmb
	 eyZMqYHm1ODzge1XFaBETV8jvGKfAygKt3adxKmDovkGyH/3RWA0MKctvJZqzA/7/nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWR2+G2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE3606A32D;
	Sun, 25 Oct 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWR2+G2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D29A1F031E2;
	Sun, 25 Oct 2026 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971010;
	bh=xFCEI4cW9h7sIqvdTdAIE9r+Hlevz+gA+VngtwR2UyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWR2+G2YyLYFcVfTKoj9oOiFDT5pV7A2//e0sRHGbDDDhI8iRlPR4pnjUn8zR2z9j
	 HmDTn8HMBCM+E6sAa207eQPjIwbFygHhwhmlfUdc/dBVyTuUYCRszGJm2ONGqIp2JP
	 9b4TaCxrwBIf5AHyUxDwIcNPOJMED61TB91YqPpUSyhAohl5GimCx+tnrj4bbURLFh
	 jqGndUmRM6TcOsWO5FrgLLMEsxWgF0cIZYm68xa3RIDlfeiDjATnaJ0LCYuU4S9gSW
	 KsSCTsHDHb6kSnu8NabtP9r1q/shIbYQaI/ZSsEhlmwiiNHKLs6SC867MWitNdd2qP
	 lKAVL6N3WSCHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Stanley Jhu <stanleyjhu@google.com>
Subject: Re: [PATCH 6.12.y] block: avoid potential deadlock on zone revalidation failure
Date: Sun, 25 Oct 2026 19:29:56 -0400
Message-ID: <2026-10-25-1-daily-reply-0010-block-zone-revalidate-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025060917.1652827-1-stanleyjhu@google.com>
References: <20261025060917.1652827-1-stanleyjhu@google.com>
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

> commit 3dd63dba8f9cb6990a40af7ed66ee0159f475819 upstream.
>
> If revalidating the zones of a zoned block device with
> blk_revalidate_disk_zones() fails during a SCSI disk rescan, the following
> lockdep splat is thrown:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
