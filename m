Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798924;
	b=z8CSZdcytkhccIe7ItuvuyjR+XtjB9yolWn7k4tKo6C778NEIFzOjwyXxvbyiS8rbKTi
	 IDXoSjZ2TUx2PZt0Q857K7aZRyuCmsiz/t4sUy/Ixu6wiS+rAF1ilhkWMWIlFtdiwq6tG
	 jTADvLIvkafVM//tNc0yxtzCikTNJ4yx2H5TG+7uokQPV4RlJKJrcpcuoWvy8SGg6LSdo
	 v7ZsaFOA+CsE3rPrBCoSjGbKTsmXdeErY/s5uBN9U9KhKj9LiHbx8FIrPn0qZPl/NepDz
	 F1vZjHMASDmGy9CI6+NieO+O6Mrxt2aqS21uyfhKEzCKpGMZlSQqUaYXkjq+lafCTIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MVvyKGMvOKzE2CuBk59Lsk+xEyeLYE5n4YW+JOlSJxo=;
	b=WNnCZ4cCwtlzFcTqOo2JXdF840N85shPSVOYex6F8APKnaOzJMK/Yrs+n6UPi1w/BndM
	 1uhX0d9tfP0Ekdgl3Bd9zmuGspSW+uwA4MsyQnxXTuSj7fUC9cZ4Am+rVnGznBRT2zfYh
	 Y47fzcz9QQHd2lcI4MoUlDkmnZmvsZ0AMHEuEZxSP6swjZvihy3z5wHMompyAgiOwJDUc
	 EF3uarip/NHOk9RDiH59A+tVchuOEBrHAYOMxftL5Byo/REMiNz9A9TcTMT4Sax5F7DEt
	 K/i+iiTAgz/6cJibCbczkiR2IbXT1iOcR0P+czmisRQnvYeidTCjY+ra3WADr5m2rHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l08M6sf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67D606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l08M6sf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ED61F00897;
	Fri, 27 Nov 2026 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798923;
	bh=MVvyKGMvOKzE2CuBk59Lsk+xEyeLYE5n4YW+JOlSJxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l08M6sf1NAhnZzH2szGuFNy8TtOmlHl8K9m3GcMHBHuEbFSZijkxVPqYRW+fFIBTf
	 TZA4Rk3u+r6xHAo6d2wcgBaF1wqZMBMrAkVSYdLF1gn8Zj8jhA6ixeCrZYCUA8PqbC
	 nXWkKhwg7S+xWWJQ89/iYOzhlKH5q0WR3MtkFEzu9GnBgz2F9lqKs71poi/OhsJ6Ep
	 nYao05pbWGtNqsS3tt8Mz9+tGnmlc+VY9xRTj1X4BjexrQzkB0/dAYH3SKuK7SxBlb
	 xmLlNtFodR7u72LI7IFKkYFrl/ro2B8heJnLSl0xYoNjb4j9rVizJZtmcc7IBfBU01
	 AVJRUfHjEvO3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: Re: [PATCH 6.18.y] Bluetooth: btusb: fix use-after-free in force_poll_sync
Date: Fri, 27 Nov 2026 12:01:06 -0500
Message-ID: <2026-11-26-1-daily-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125095450.19095-1-25031212351@stu.xidian.edu.cn>
References: <20261125095450.19095-1-25031212351@stu.xidian.edu.cn>
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

> The force_poll_sync debugfs file uses the driver's struct btusb_data as
> its private data. The file is created under hdev->debugfs and is removed
> only when the HCI device is released, while btusb_disconnect() frees
> btusb_data unconditionally.

Queued for 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
