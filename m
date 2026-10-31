Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468356;
	b=3vERtQxPs7p0mQhKci5Fg7Rrn+b34rQJUSWPxCloAxjoCFeIo0eBz4mwG0eU7fEhfaYb
	 +iaOlNZp2hNAJYWvHk79xKX5wAoi7O32o3vfLK/xY8KnkF+L0MC+gB7lR9GM0AKqDhkNO
	 3RBWsphMTYHosYuBQ7tgG5JE9LhAcBPd5nhYjKM3r1uk1bHLWbLozXLv+P1pB9suFNTn1
	 y93gF0QH/Qz5BUpzZYLQaoQoZKSNtMYW3daguthRHor+nC5hGSNhD8APQQeimqdyCYSm2
	 Bhf3qbSpQTcWGJj0+uo1x5FCC7ARr+5HHNp3Sms/6j5g/RsNmVbyMVPKUmPvAhJDd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
	b=lkVnX7qQxZOP6u18Ig0PqvY/BNGHUN2HkDinVpfmcO/ja2qXNTc7EpyY3hrivh+Y9XjO
	 QQefZgXJBEMsQ4nXKcy5CJeim4BLx8W9R0nqOq6Rca0HbRE34VqQGVrWtNdjk+Bbr+tke
	 6Pypm79yZ9ijDvpLmZVSEFfouO+lpiAuEpq1RSf7yIaULqTCpaU6JDikfX82e7DEsL0/J
	 nVvVe4Aig+SWxu60zmnb2HKHRdEtqEW36HBYDQ8lo7PdPVLqh6k3eItpuJ1lqJxTO5zct
	 ERl8PFMeZOF6mgnAKH08PFmrmw4C1e6KMMnyBJNlXJT3Zi7e7jyA46Jb5E8+7pUhuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AylsZbl8;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07253606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 17:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07253606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AylsZbl8
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-15901d262aeso17379c88.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793468355; x=1794073155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
        b=AylsZbl8rD/zrNKDrvJnSKn0FCOCurNXnYVPihbd2lSu/OdLgTm6IVDAsekTWCxioF
         EAiIMkmxAcbysGVh+GzJK5fPmJaTOlJFVfDkHn42S85LoLvm9PO1VKl21FRIl9n8pRhg
         BrusB0ZG+yGAU+AhRyzbo5FY7gX7DeCM1wZCwUKkHl0Jv3+mifOFQAfzfWd+RbmsJm/e
         Vep/I5DjYulWWM4KCntGv4D9+Wd9X5xEOknPKleKu3jE36AgAyANSbEHOShTPs2xue/5
         CTXEIBUQkP/lcJVne52Pvo4jzz4F0pIvdMK9/yyFME9eSFQ8U2gqcfFhTyPnhQBbH7Sg
         GN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468355; x=1794073155;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
        b=Y3z/F5tP68aTszxt0FDK8DxyhNeX0Q8vyEjCvAcczLmDOymSu+VF8kCP1i04AAJ1+D
         KYWObBeZtK6RK0Lo8Gb0m0f4LG/VS6FqL6RgmLmapurCWWJFj1z5JiyEGFCoPJCpjryj
         PVSwjjkfPQ7cy93oM2KvfkWuY9Fg8v6khuu1D7Gff/1iBlTnUeFumfuotY9LqubbCW/U
         cCbiIRA23fIdIEpquO0VU9vLBjX19TV1bXNDqseJumaTGBOD8azQkkUXwLevWNd2h0EB
         0YYx8zdT6nkU9Bu4UrYYtAzf2V7MWFZ4qotLZQ6M/QYixD+FA2selFmM9ZRvb0oT5fQr
         dNhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlGgHwkaoLsc1huDdU5R1g5N2Oe2NI79fqw+r9L4j1qcaXM6CYGw4DlKz1prH1ACogZSi3JEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO5k/mxUyHgc+keNGAoZfZoQBy8OZXelcclJxhOFivgUhK8ORv
	OEqgYIRv0idR/3hudXiF3wZVx5tuQB2dmf/bXXVUoASPaMOYA8Yjk5sC
X-Gm-Gg: AYBFou3sk3bt/q/sChbrwADo2pePn2expH30yF1jPPCfXDZ1HFoHJZXINaxPdbKl5Vv
	rTIqGb9fJJLxJQpwMz1o3h2r2nqe6FlaEXgQtd8Y3s490mJom0YsYryFZJeTu8n0QBDkU/yeExC
	XPfEYvlIgWCKTPQf/PSOFybIXZ4A8al/u5NBA9CxQ2Y9XhpEYF+onJjon3o54fHR4TG4ozmSebD
	LPR+DRuz0kqrY6/09J0SA3BwJw032uFh1CfxkNEwPH8inm31uu/AGzjzx5M9BTIHXEXgYmGn+Xv
	g8kEvenB+Gy/LJrLOg/ZbG4m5CMptMzdyXRQxYlcF0u2+4oCv+4KHTLLUSdDtC3vm+qhjpTl53R
	lQm+y4078yxgLIdy5Grqy2azuhc0wgfdbp01nudQYenIwxxb3uWvUgHX69QNCG2QhTBFWxa8ieV
	QW8W3Q079ED9sYCvZM4Ei+EtKlctjiY+d7B8qHr7H7zbGCY/6dRBPbZ5UMm57XXogP+h6Evs8hS
	UzeEMEcEKdaTTJih4VAgAM76qR7bsidAGewznmIxZvSeVSTD4xOZAp8ah4epANWi9P53Y/PdiGW
	qCqDV8KbpT5PMeX9mO5EjqSpwEHwZZEKFxsQeC6hhcSVUVf9bGfY1xCIDHDceNxYfez14ph1SPZ
	CTcdERlK6csD8c/TzMQ8mEjlw8V0ms3hVrg==
X-Received: by 2002:a05:7022:258f:b0:19e:78fe:9d67 with SMTP id a92af1059eb24-1ac5a680801mr9985603c88.9.1793468354679;
        Sat, 31 Oct 2026 10:39:14 -0700 (PDT)
Received: from [192.168.50.20] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac194b5437sm19811655c88.13.2026.10.31.10.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:39:14 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 03:34:41 +1100
Message-ID: <179346448183.4.15545164251841296990@gmail.com>
Subject:
 Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
In-Reply-To: <20261031153858.84302-1-sj@kernel.org>
References: <179342136087.2.16978105493403840270@gmail.com>
 <20261031153858.84302-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi SJ,

On Sat, 31 Oct 2026 08:38:58 -0700 SJ Park wrote:

> Thank you for reviewing, Aveline.

Oh, looks like I forgot that. Thanks for the reminder.

That also gives me an idea: maybe I could build a modular tool to help
write emails. Building on b4 might be a good starting point.

Tested the non-root skip path on x86-64 Linux with Bash 5.3.20:
the exit status changed from 0 to 4.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
