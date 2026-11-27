Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798937;
	b=HxvoJS0wEcdZwxfYrdREdyuJwB65MjD5LKEM36tTeV5Ok+dGBidrPTRqL/7G+WjndIHU
	 2b+e/8U+pFMNWqZKIy3/CY/uRMcOfL5YsmPXAOkpDx6JK1T4u7fFOAE9q2f2bNvk1bvto
	 QMHi7ftpG9HzM9zdOUv6v5/px5T8SQDcFNq72p5cAOpeitBhn5+p9LkC9neMQD1/eBshi
	 XYH6+c5eamqVgukBGfo4tUpjiXLq584jHD1SQGyZC5z2xF4leoph3aoVNwTxeWnv6CDPz
	 0raNVcxZTS8pNpqj9pluq4BUV1xObExS3GrBKp+hKM/4o2UErFRz2252C0jZJLOTq4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aFRSo1rdcelrQZHsvMhQFW5w57H1OOgWj87JrK3IHxg=;
	b=kf2gxNev1eZJZIah/zjdqwNb2dy5PzjzNeAEzquW/U3HCsEQX2qelLf0nMKTh+tF3cG0
	 FiQFeu5cttaT7RdVDOLoeOcVFxYPkmsVIP5ugfBSgvzJvH3y8flWbtzWw/Zo6r88ehqtn
	 BSfwLMdGdXucpKe600GKBjPxfCEdtLXIpNnJW0mED7PVwf/oKZJcX1xfMb/MHNE1BTUuF
	 7Y2240RNJTRGJLkcx6tNU/OKxnMWjNXZ848geRfZIqWuYw1pO7iDBf/WK56U/3vp3WbED
	 ChZ22e72tu7UJiY0BWLz8RUaZqZF3bi5khGnUjrR3cH0KgTiKrcFPg+kbkV6Uqj4+6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr5iPRF5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7C606A33D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr5iPRF5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6B51F00924;
	Fri, 27 Nov 2026 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798937;
	bh=aFRSo1rdcelrQZHsvMhQFW5w57H1OOgWj87JrK3IHxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sr5iPRF5OunJfqcKWnJhMygKRSZ4NFz/YFCC4lE9TRu3olOi6OzEVqTAXyCvroBua
	 GwzZAhqrSriNiIvvJ1H10FrVRfWnRUW3YXpuV244HO8fX1ovvu7QrKyCquKNGY+G8u
	 4foS8+WU24a91okCEY7VukN/PhOS1cGpMRSaLPCOQaTi/MAU4Dw/h5KabU3OubOWC0
	 onVXwL5zBhfYSALQAZ59RlrgraOaRZT5ld5Ka4NX4iZdDj1ruvxEwolILKkVbjwE3h
	 iCt1aSwaR9LuzDfOJ62HqG/Z6ONrLQ+b4vjCX9yC1hsLiV2pkj4+3aAMf121cKkVM6
	 GMk+8XvNWNmMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH 5.15.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Fri, 27 Nov 2026 12:01:14 -0500
Message-ID: <2026-11-26-1-daily-reply-0026@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151147.341588-1-kapoorarnav43@gmail.com>
References: <20261125151147.341588-1-kapoorarnav43@gmail.com>
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

> sx9500_write_event_config() adjusts the channel and close/far user
> counts on every write, even when the event is already in the requested
> state.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
