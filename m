Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971004;
	b=nUs+KLGZs849edwfz589O+Ms8KylRiBrOhJkL6oGngWZqB9pqsYQvnqQ+6vOakITzml1
	 Ca8YGdmkdmRpFBCfxI+tKKEcofVyQI/fV6b0fKncgCv6vZrAfG8905OIwlIGlS8BRs5br
	 E682/eSuZhHgYMUoOLhRu/mO5rDpwTRJhRXHEwhtDvoqSEjNzQvifGC18L4W47PNI9Acd
	 Jp4r3kyL8P5Ff4ta6GuJQubYzbmTFMZR1rCcwmMNh7FF2yTs6gRz4QoU6AoRuVp8Z694d
	 yHGsdHyOzxVyDEl/M+rfuv02YVv/uN9PQNjRAHd77h1v4bpP6jsneaB3kq9MaqASMLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E5YQoaj5YHm1eYEazSEM5pfLF2ybdrxOAMvKmHrv13U=;
	b=Gr4hXM5Bjt+Qt8OK/iIpTo0mliWIrnPsNUxw7FyZgOwVJQiU+BRYML8kADNEImdSZr2x
	 ZadKwLq8VOOGZocNrG5tk/9IY9Z2wezTqvvM6Rkacih5Q+JhWEtNdZTQzsqD5jPF9qWJp
	 SsdxlHlGDW9RHmg9uqIHorzPiZk74sNWYWT1KT4N8dnk9gSIXgb4mNmF1jwOw84G/m9Y5
	 PmaV0nQD/z4SctCjfDB6poginfd9DfciMs3W0TIq9oEG8ioN7GJPuWgUOKWX88HVuVxZy
	 dTpYVseb8DDTdZJKF/26IXWBp9sKCuUNvqB9Lo+UWm81Fu40r8NIzQ1EQ1jD1akrFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiZQD0dO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E6606A327;
	Sun, 25 Oct 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiZQD0dO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA8A1F031E2;
	Sun, 25 Oct 2026 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971004;
	bh=E5YQoaj5YHm1eYEazSEM5pfLF2ybdrxOAMvKmHrv13U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aiZQD0dOYn048Dt5kIdHgZN4+KsVtKW3DNbW92Gy7LWFVxoweBBae7ZkSuxKWZLnl
	 Vy8ht/HWaJjrCzfwImn8XGM3G1XXSCaI6jdMcbfPeyyMFDRx2bHebW5SKNEhKhTaW+
	 m0C4+V0/hk7EBqHBt+vdcaOIisX1YZk2iPgvu8dA3Ijw1vTP1z4t2heheQA9rVAD2n
	 E0FBpPiLvxkIthsFu2baIad4uhsKq8xxvk6zc0AlnTK+VHufrQI/BQwwNm9o3IpDY9
	 rjXU1MJk2GsvstBb9Xy/ELdH6t1Uva+7d+cbEZzCEkDtCykmuqVE8baPGqzr4TVe3m
	 9v0/vuqnhfN3w==
From: Sasha Levin <sashal@kernel.org>
To: Christoph Zwerschke <cito@online.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	1149377@bugs.debian.org
Cc: Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
Date: Sun, 25 Oct 2026 19:29:50 -0400
Message-ID: <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
References: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
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

> > If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
> > (on top of bluetooth.git master, with Cc: stable). Alternatively,
> > btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
> > is missing.
> I didn't see any regression reports for 7.x releases about those
> changes, [...] So I'm still inclined to say: leave everything as it is
> in mainline to avoid any risk and revert only the backports of those
> two in 6.18.y and 6.12.y.

Yup, that would be appreciated.

-- 
Thanks,
Sasha
