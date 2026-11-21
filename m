Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275009;
	b=5dZeiuV35ohsZfzGy+MXFgX/O00drGoecrR1t7Pfp5urHUC92JaWgrkKQ/fBQCAhttp5
	 B0ezcDZkkwXD4CqX6ZrxUEjiHbPKA8R9QEH1iXT8QRtmDoPbmtlu6fyIA4zKyG2Fsd8gq
	 lt70oj1Lfl4mFOyo52z8T5+5CW1AbjE3KlaltTLNIR38hi7O1Pm11YVWY/fpevmdb4C/a
	 tO5qdpS2iapijLezNaGoY3ETMHphSczoHfYSkrAbqGw9SxmRGELXIgznNpdXHhRhW4vVs
	 1NTtjkOugv8Od/zU5Jp7rZqwwSOc2nJKhZnV3004LlkVce7gp/U0s34P0eCWLpFZKSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U8Q3AHE2krE4WjwTcA1MAoOcsg1cPYEXK33XekqHDG0=;
	b=BlW16ltrkjkSlBZpgEysb+hzci8kJLCvfo2egBsHwLXmrxQQPQPIAZ4kS2xQVkYY+P7f
	 dW0vW/Ya7orzjf7EClkcqAAG3klKgfD7QO0jbnRbzvuLcLQlYBsJUk9/oM21Uha5TyGaQ
	 dMKrnsbukVDNFNGxOQSnLngiDvVEvPP56oqSrqgK1XkBT4kdvQ1HW5tFhOj5A7Of7/QYn
	 Pp9E0fZ81LHLF0f+iaX/+AskoUnFrHGysX3kB7VbPOQwmHR+BJYnzu5CCMbvIYewkDlrE
	 M6WaHXAXUWlvSFIZ7sP83P7oZqySBTMv1Zmskj1QI6I2fA+WRuz4NBSLl5lKwZwQQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChAgozdk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D9606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5D9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChAgozdk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so22614915e9.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795275007; x=1795879807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8Q3AHE2krE4WjwTcA1MAoOcsg1cPYEXK33XekqHDG0=;
        b=ChAgozdkUP7cXMhO0ipL9UB0ajIAvHMPZH8Hzj74ECxrgVHwUrKzCpuTfFy0kAb+Sv
         W7/Y5HMP47LIxhEE3iBcn91DEt9KoaH19Zn+INhZxVZ2V+dHP7QNPzAkKq0XzTfzaOeE
         drcs/XzTRcSUvJyLbUQEzH8LheweLbkWTTFGe4Wc6PLLMNoLHaoanGia0RqTK7uGNOxq
         2bcY34N31bMRKwppKuOxPqw/VzemJ/hxt4MJncPiLQQxlR/zEgUI3nBBO7D0oSIe0K0X
         ba1efB2PmMIAiDIZXXl4KhzRMDfIIsK+qXiCewvbql6QPlMZ5FFn5ftK/TJ9uewGSqG0
         BbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795275007; x=1795879807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8Q3AHE2krE4WjwTcA1MAoOcsg1cPYEXK33XekqHDG0=;
        b=Min0O2gCItJYs8wcxnWap+gRdyWGIsNXn598uE176M9ydM2CAe4cpzoXMEnvM9FZEp
         LutY1n5lCUfJanC1pqKJN8l4U5qSc4M064jGVoErDGCVmWoWxYaZKD4HCYm89vhqd9/X
         itR/JcuZrTWXcROUBK1+fpHs/FGiXtmEYq7v87qtddFWia5RP4Dz8azBNf7dDQpbOAMQ
         W0tbXrkfqk6Xedcf7yalEncbqhKWMC5fotQDKb5ovIPZVnuAZ6ySuK/I/uMunm3YHpXN
         lLMDAiAkyDdPOtI1+NoueB78Fhb2fyBAl1/eW2hPKR1ibi04cgek23Q+6qeNS2pvxH38
         s53Q==
X-Forwarded-Encrypted: i=1; AL+hErEaieQTMNxhmwgkauGaIYvXojltwE9xL7olk8MrHmSBQhNUD7BHLSE0/8B826iAx3F2XOgA3TI=@vger.kernel.org
X-Gm-Message-State: APuU4Z//lpi1FXBe6zKgVt964CdyJ2UDKFs4OgR1DdBzKww1LWhuAbyR
	KNPka3rsKaz3qroeTNjd8wiUIH/2PshOnti4tNwgCDgLLtquodCP/ZM/WEP0UALB2sY=
X-Gm-Gg: AZFdTZf08Mx4cL9gRFt/ZwdAer1dcchpZdw62/F+JUBekiFojsltJJsYbBDVyHHMmCq
	os7Zg+59gAQy3ufNy+bbI3w8kb2CCwSBcXdZkQafHT0YPhVrxWvw39BL+s0bQawKpdBfL6Dnkp7
	Vjr4U8VqAQetPlqUBY+b+B7Rp9gEdeOhj4Cn6M6PfmU4ufwpq3hONdEtbzMKvYprwwb98pWtwdu
	YfARi4iMRZml5jbEhFTXsSNFOmdAV+PzpUf5AZ3frl+5WZPQHLQ0kl2dXDO/yFAlrjfzqxeANLY
	RTJRobLxD/Nm1Vo5sY13sXFr7ojY5hgIQEw1MF5I+8i75wKoUyjDkgOHRsz1rh0luVTeQMnJxpN
	tk+B2NJt/4XDMaOd1pv9qs35Uu6P1UbpaL+/iqBdhT+aU9jejEMytHAYH/dXzgfMqNkXSVKz213
	E/kMlsO68yzO6bgXN1uqXeGBHky8J386+UatHfizavuQolL1L9ZXbBamwT2QDyzcwyCyGUAW0ku
	eTIuRj7UsolhDyOhR1Bns8Mf7g3xMHc+9Q5Vs0iQbEVboHHBqqet89ox/En9FYPr6xENljSumo+
	ItuMGeat3nRkrvcCsawVpozBeaDkc9WXuoCU7y83kqLoViqdtH8TXt6wbuOdTN1H/z0SOu6gpJj
	d4nAoANOPtVt7BT8NQVgPAk+FXR8F2LWAB4Z74CU+/yvq4CEV3YHAJF9k9EkKZBTKpEpJ/hVEsw
	i0cx0j22Ut6chqoZMIHFzfJ/+CU6g+2eW6FwfvdTdrb8+l8TxbNuA8atdZNAk=
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb88805902mr139219285e9.7.1795275006740;
        Sat, 21 Nov 2026 07:30:06 -0800 (PST)
Received: from localhost.localdomain (static.253.42.225.46.clients.your-server.de. [46.225.42.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm268540285e9.11.2026.11.21.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:30:06 -0800 (PST)
From: Vinny Horgan <vinnyhorgan@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org,
	upstream+x86@sigma-star.at,
	rppt@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: enable ROX also when STRICT_KERNEL_RWX is present
Date: Sat, 21 Nov 2026 16:30:03 +0100
Message-ID: <20261121153003.2499592-1-vinnyhorgan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625090627.1501095-1-richard@nod.at>
References: <20260625090627.1501095-1-richard@nod.at>
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

On Thu, Jun 25, 2026 at 11:06:27AM +0200, Richard Weinberger wrote:
> Running a kernel with CONFIG_MODULES=n causes the W+X page dectection
> to trigger:
> x86/mm: Found insecure W+X mapping at address 0xffffffffc033a000

Same here, on a ThinkPad T490 (i5-8365U; "Spectre V2 : Mitigation:
Enhanced / Automatic IBRS", "ITS: Mitigation: Aligned branch/return
thunks") with a CONFIG_MODULES=n kernel based on 7.3.4:

  x86/mm: Found insecure W+X mapping at address 0xffffffffc03f3000

With this patch on top of 7.3.5, the same machine and config boot with
"x86/mm: Checked W+X mappings: passed, no W+X pages found."

Tested-by: Vinny Horgan <vinnyhorgan@gmail.com>

It doesn't seem to have been applied yet: arch/x86/Kconfig in v7.4-rc3,
tip/master and next-20261120 still has the old condition.

QEMU without KVM could not reproduce it: TCG offers no IBRS, so
spectre_v2 falls back to retpolines and no ITS thunk pages are
allocated, with or without indirect_target_selection=force.

I found this, and wrote this reply, with the help of an AI assistant
(Claude) while building a custom kernel for the T490; the results above
are from that machine.
