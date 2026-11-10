Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284963;
	b=GpQqZZ3vV3yZWGYJPhKCKfgfxE3926burdHtpZZBmKefOgA9UbWow2nDBwq/QZ+wvPLG
	 CdK1gy4pALWBk/BdQX0Qz6imzIk9r8LKUf/Ai2JldmtqyyECJTnsTHxa+WBu2/tH2i6g1
	 Yzqhuyk9Go1VD8QxVkIL+ksB1ls523z68Xj7Bf4BfqKHA54Wp9TwXrymiDztpaPkhAw9k
	 Ppa8ubUmhq8BZYxJZ8Y8ILKuhYit8RSo3firzDDt4OdH6aogy1twd2MSg9Bi+OExV0mqL
	 0vs4s+ouV+vIgxYL0NXKMtvRex72Z79JkT5aJaPGi7UJM2bsrzq3G7XpA//Unz8BsXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FxC5kQ/SMr/KLBKiPx0PdPgsfNWcYSP2FuHJsYS9WuY=;
	b=p6jVUxrT1MNpxdyOTq8+pnbl/+45+Iz+SllqKN9oYEIzT/0uAWzo8jaMgzvJWJflgeKZ
	 jox+cw7yHGFPdLr/rDeb+CkHkSVdcj21bwSRVFC+/WJ477IZj9FtcOLF7nlOWmu385N8E
	 7xi2tcbPw1yOfgEixet6DqGhZwvAT4iW2gQtmSkOwlv6JxKbAJTzN9hdfQiWlqyP5Z3ei
	 FVVE6kp/JfcR9EuPB+wiBc9mWug+YUArbbJETJnTBuKOfLB0kTvSkRjN++f3hAXPShL9d
	 +I7wVM0xNqEkspAXpC/QbquMpakiNYJgCzuXwtPNiMfEXerNGY31T/elZo0WTajPf3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7lv4FZn;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3929606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3929606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7lv4FZn
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a214af2076so11220315e9.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284961; x=1794889761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxC5kQ/SMr/KLBKiPx0PdPgsfNWcYSP2FuHJsYS9WuY=;
        b=s7lv4FZn/1PAoZHUD7BtbstZ5547Lki5phWzqkcA39f36aMMYLkQIxf+v1szfr2npL
         NnPUmREW7dj/iyWc/mD/bM0Ohvp2qQXbQ8eYRRYLHPUWz5vJcnbbI3330ktZ9LZAZjpE
         3BJ305JWJxshhQpZmXc3Ow00phbsj9crQIRaz8ntwc7dBN65wo49ijLbS6UPgvG/JRaq
         BljsfrV5ySqeh69bqFruCAgP2u12ALlGc81V/KnuoODbV/lMMIx+Z6nn93/3+3T5LuqE
         K6B22eGGFMVjx8ZejwNEP/rm57cYtsckq8uOf2xiGHjR12WV4VPIfi0i+M0eEovBOgDo
         +JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284961; x=1794889761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxC5kQ/SMr/KLBKiPx0PdPgsfNWcYSP2FuHJsYS9WuY=;
        b=aD+G2WlOFQ+8LcITeDUcUMSHGOausEPgUUEhZczzjWqgnf5qa05ZqsWUKmd1hBygey
         jqVkDnu2yv8Tk0DV2YPpmuQ4Z6Vx0Bj8CBYY094Bx8nWluf9obD7YAm4m26Kstah3X/h
         WxdjTCddphqwNc0RBFcc11Om77qVeN8Da9DalmexINfk+DGBCswTfA3ES7qpxdsTeIqH
         +B4b0g7mfLTmuCX2+l5JgrZxolRiRsTnlAMGcTqGAr0KwxzASCVAHUEVKYCqOox+gqrL
         LKcfboY1RXWqZpd0FxtfgdE4ncPJU1L1z2/yihDFPoWiOOqUB5xdFtaVz8N8oNdqlabu
         1sYA==
X-Forwarded-Encrypted: i=1; AL+hErGITa++GfHI8CSGWpb/MM9yKPhkU/mJzYm4tE9PDvBYpFsLpKz5+4B4/p5XJnwCVNXBL9ssoB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SfsFFIuR6GqaQnTQ/11QdqId/ZJMX4ZuVXczYITnjYg5lz2gy
	0QuwU5AQfz7HfRFeCiWo8qJ3vCeOk19xwxKEfIna9aSbD+RvWAaY4a+a
X-Gm-Gg: AYBFou1nA96vcYzRuigDIX+TAj1E3sD3+6JgMvS9GvSUKOM1vdJohIkrXHSAH8lfY/w
	6SWUHXbQAMWE9Hcxg8YVNXlewr37jIi9c6kFeQGEk7pfpYI0bdi4jb8GaIRZagrbzMepweWoN32
	HYwoALTWtRIou5h9bxSwu6UXtzaOqR3xQxxCXWh6+FtSQwWJ6ZSJX2XYaxQZNXC4CLZv9zTvFI4
	VP80fWHWP84U9TikcniwMWAlin+PdFACfeoOAcvEKhgI82Br79hgIfNuf17yplhzTxiX4Pp/EFS
	SUEKSelZoYp8U/WJnU9C7I1Q6PVwUGPEBEWoXkSN1bzSyFgyALf3ABAoVqlnQ+nxtFC3sa6LpI9
	FQA5Vf2nkNS0zJDxPWE4bK/uRMj61rf8nH1gKKap5MNy12M2GKS3kSR8j9X+UFQhy2juzKAKMlk
	V7O3I58pxXh2f2uJU4GTfXqhdPs09u454JRF7zAY4aF8PBKbHylm/laGbT6IuWaUt/3I7KuBlat
	M8nLWBY6aFgVDiJHwYWbH6X4mJ36TrzwMD+UpSSnjKJImmwVs2ufWWuWmJKYJ9q9QDujQGPueke
	+DpWpKP5eDfogJbjIP2lE2wHoGaglqBPzJXGVSDUjvR6gSh3XpbuMYY55Ri3gyZOv4nqj4tzF7F
	XTxijeJvRExTmGq5Jr42v4BLjogb8GY14paylzBT49YfHjyEc2vQ7ftdqZjk0wK3kRaXoQ4lyKT
	QN1ACm5+Pn89Ka2ZSCXO3z5SM107wMSy0WKkajE/ykAgMB2I4cXF4FtA==
X-Received: by 2002:a05:600c:6089:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ba02349f95mr17862005e9.17.1794284961165;
        Mon, 09 Nov 2026 20:29:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-757f-6ae5-a6fe-9693.ipv6.o2.cz. [2a00:1028:8388:a84e:757f:6ae5:a6fe:9693])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204ee67sm36212185e9.13.2026.11.09.20.29.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:29:20 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ignat Korchagin <ignat@linux.win>,
	Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH] dm-crypt: defer async write submission to write thread
Date: Tue, 10 Nov 2026 05:29:18 +0100
Message-ID: <20261110042809.62987-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4093292e-1fa1-dc18-b185-18dff61a32bf@redhat.com>
References: <20261105072708.30722-1-pepe.schlehofer@gmail.com> <0197be1d-1257-4597-aea2-1a065fe0a1d5@kernel.org> <4093292e-1fa1-dc18-b185-18dff61a32bf@redhat.com>
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

On Mon, 9 Nov 2026, Mikulas Patocka wrote:
> On Mon, 9 Nov 2026, Damien Le Moal wrote:
>> Originally, this was added to avoid write reordering for zoned block devices.
>> So did you test this change with that (scsi_debug or null-blk) ? You can also
>> use an emulated NVMe ZNS device in QEMU.
>
> So, should we disable asynchronous crypto operations for zoned devices?

I tested dm-7.4 with and without the patch in QEMU, using null_blk,
scsi_debug and an emulated ZNS device. I tested both cryptd and a
synchronous cipher.

My write and read-back checks passed on both arm64 and x86_64. I also
ran fio's t/zbd suite and blktests zbd on arm64. All tests passed with
both kernels.

I also used a kprobe to check whether async=1 was ever used in
kcryptd_crypt_write_io_submit() on zoned devices. It wasn't, since
DM_CRYPT_WRITE_INLINE keeps those writes on the async=0 path.

The only exception was blktests zbd/013, which stalled during cleanup on
both kernels under heavy host load. The LUKS volume was still mapped
after luksClose, causing null_blk unloading to wait.

I couldn't find any issues with this change or with async crypto on
zoned devices, so whether to disable it is up to you and Damien.

Thanks,
Josef
