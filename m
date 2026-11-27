Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798953;
	b=T9MM5bNCX9LTUc/4xauAjYoK0EgohmH+rH2ifuJ5OESzd/xOQqkvzOmiEZVAPGH8iqNz
	 5G36v790Q1/hTH2yc9hhCmcIk7LJMhu2qpKKveYGA0App4bukE/8ui5RrqyAn2CO/v0Q8
	 HSHoXwXt84bw4CECBvZys5eoM6h7l5Sam5+/7rXCxhcr5ljo2/RrU1tmNNJ6BYooqN4Xx
	 0jX6sAP+4HticYRYMjuif2dNxYns1XCmPOBLK5TNhrQwNV9T9BTJ06ABFKz20/usEKJ7q
	 tNBu52VVX6ZNO20rhavqQI2Mkv6wAAOHpj7VhhWVrrpfsY9JG3kjUkH0p95Pvx3EwBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbZ7nuhz+8LuV+BglDOHHp/e/0zfCfr5SGcNiwr9ZP0=;
	b=0nxHMqCpMZz3tzjqUSnVQwtgwokONKwEDLwZ5FmDsoUiqRlI/3atxHYUTCPyEI5dOfQs
	 YkejoNxYrmbEvaLIF9exX7DbiNrE+nNJJprSG/dKzDfJZo7LQaa7PLy+ihRa3mH85E7Ll
	 ACwVzNrjNmuBx78+1m2T4E/QWLifwGg+7zSSUC6WkiVMI5wJCQEofsczAF7oIsAuLhASc
	 4bLr+kCdPYY+o8/1Q4cz8HrtpOJWkDY+V8G2xkmNhqRkt5aBzBMUlYzPw/yLHTnQ4G7c6
	 XKmfzZXjMQktREwMZiw7x2yGdFvzIt/Pt5Pm6uLxL3tDzfjSYvIJ3pdhba4CMb0OrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAeKVWUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64215606A689
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAeKVWUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B0F1F00925;
	Fri, 27 Nov 2026 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798952;
	bh=WbZ7nuhz+8LuV+BglDOHHp/e/0zfCfr5SGcNiwr9ZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAeKVWUFRYN4lJNQ4ZHHdc3g4ZI9kXIB0JqikTh+MpcnLdn0waIXSgyPJGGvLwfVl
	 NJbTZwQyXYzT8oisSHWYGZl+iyeVzgeR1cx04vieOHmOqIoR20XtGEzSXLzVdDOs3Y
	 XYCiGSSXpVONyKrTY0KomhPVOuMe5+ejY7XsVfYi7NK2stqKz6ZxuRX4Sz+Sr8YXm0
	 HxbQOBRV1NWQ8wM1hOia0ND+ZNEZItvJOajvmrWzKgIhcExj0cDHTem2XQn4aH/t+j
	 nFurJnLAOwHG+EsOpGvwy2QjlLd/LXlwaHvzzHP2qYSww30AQVNAEabU1tsoSNvqpz
	 xDzECnQzsVzEw==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: Backport commit c3ca8a0aac83 ("serial: sh-sci: Check that the DMA cookie is valid")
Date: Fri, 27 Nov 2026 12:01:22 -0500
Message-ID: <2026-11-26-1-daily-reply-0034@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aab6f82a-2dcb-448b-bebd-ce5376280de7@tuxon.dev>
References: <aab6f82a-2dcb-448b-bebd-ce5376280de7@tuxon.dev>
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

> Please backport commit c3ca8a0aac83 ("serial: sh-sci: Check that the DMA
> cookie is valid") to the 5.10, 5.15, 6.1 and 6.6 stable trees.

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
