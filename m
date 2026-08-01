Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7850237713
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565738; cv=none; b=Bv/xrqazX4AtMcrYctDf+OdTcFAIpRMGOipwy5tNTUjfH93YTVH3exStj/gVjHdx43d8NwEgjjYnqNbFrNXl7anQ7A8+iAPjtUkX+pbDsfJOQiprkfYfc62oApCz3Saqzb15ZlWXw3d7n0QKErLBlvGVW8gI1p2H2pkupSCVpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565738; c=relaxed/simple;
	bh=COvKaGnF6LpDq29zlvmPP4pHInzce7eb7TOvIa0Cn1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZcwWrZ+SlvSPBiMvnmNOzALjKGJ4PYg5Yt/YWJOeHB2pEHYcrRYRB1jJkAkMmQWnk+kcYZFMmJ+KBh558jDgJr0et+aKqz0cWWdbf2HLworkvPxm1RaBbgo5TTHYXO2QbILcdOxbq3aQNtKgYT00H6Xfnku+rqsw3awXldbilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2154266e87.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785565735; x=1786170535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16SUzRhWVW6EVWBmL0y+JvMFJQWcBIjhRCitx1SlS08=;
        b=iP/S1c2Jb7tQ2LrFKhvzk6PxBaBQm9oWIhYvStetzyM/IASW7HA6qg3sdzUX8KFy+C
         TtTYziYEO5tiF1v7XxcUYcb/XT1wFW6u4/y9vFfcEDaoo4QPiAPAypnrZG4zd2jRTR1S
         tur5Iuon0XKG2Z2CSg0xBR64OStcBzUsygwA7hJwApDV8Ji57PuqAWy+ndUTSyUfHcgA
         iEEAHjv15B/cBVkIiJmwO7UVEC6/DStIYbgJSYIudy4j/lpkLBixLbuo7kbpvx05rlJD
         8pm9a1DxChdX79jSFMm6hzStiXt1ITGNwAmkBv1g3+INZJjkwDhOJ82ubPkxbD8hY0+5
         UUMw==
X-Forwarded-Encrypted: i=1; AHgh+RolHkYsCDQi3gl795BxjzHkFGT2KVRliaSl18wDgpvXYqmsIlw1Tj37xF6BJisNhES8KOtPw3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukYjf5wWMg0Vhyi/5tyT00uXa/sUUwXYjwuYG6vg25g6u5uWA
	GxhVNZI/bEnM2SqLpyh8V/Q/lZQK2PYaixki8VDVBuUSLtS9r80kX9cxjyG9V+zB53k=
X-Gm-Gg: AR+sD12iqDfuPAy9ktUKpACLQnuBFnsX/cONfr34H8kiBXGNbEdHgYoNCRKNs4L4KhJ
	X8+Ccq2kxLAAiiEMUL82xA3KFn5cSorOsLYOSgBfAi5trJSSBf4SZ4aJtq9uBtG6hP7LqE9Q4QK
	RQLuoExpLk+kQohkoxUQ7p3PpRp/4Jx7+YO2jgbTVm+NzDp4T0PIp6GoL1xPldh5C2JHcKGal3g
	KqHf4UbjL1R7czkTFlKznBS/Ts43y0eQwPonpeRAcPQ5KM9ieUp1/WXiI3mIbQgeQ2SkHB9ggZN
	JSZwu1SlWNdBl2BNssdGCcxI3sWXm5JisNJbTAR+ZWxuJZn0LLuLKxtzBGIPO7GmK5UDP4L2BE2
	nXwFZflwrnLKkOa6S0wG7u2JA6av/9NfVd2ZNn/04LEZfQkZ8BzdaNKyDrI6pUa755epU7WUK18
	j3D4cEBJuqe2OkwgrzvitwQxpP+6GJlbgo0YGqo/yu3UKU6NeUlGiL0irrXdOHiKA+/o4UdJI93
	j7HUa/5hAiao9toCrMKm/fgDa5OtBzBZt8ftt0RLqLWyVnHhxOB
X-Received: by 2002:ac2:5f1d:0:b0:5ae:b6b4:f20f with SMTP id 2adb3069b0e04-5b2e4f903dcmr324870e87.53.1785565734794;
        Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23cbee2sm729096e87.29.2026.07.31.23.28.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2154258e87.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp3dLqQQ/K+ze6RMJlXVGWS1r0MIHI69STNNVIFJgilNnzfLgpzUA+NvO2iBksWA+vzaE1M+ys=@vger.kernel.org
X-Received: by 2002:a05:6512:1455:20b0:5b2:b7f2:f7af with SMTP id
 2adb3069b0e04-5b2e4f1b820mr311654e87.2.1785565734267; Fri, 31 Jul 2026
 23:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
In-Reply-To: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
From: Chen Linxuan <me@black-desk.cn>
Date: Sat, 1 Aug 2026 14:28:42 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNd3KTpFJduy2YopaxH2WYFZm9BTcjcx-oaT+nsMkXd0g@mail.gmail.com>
X-Gm-Features: AUfX_myNdjD-tDqaRQGIo5jviX-U1IrbV_ZULMEOokd7ywszYjRDxh--xiEA8tM
Message-ID: <CAC1kPDNd3KTpFJduy2YopaxH2WYFZm9BTcjcx-oaT+nsMkXd0g@mail.gmail.com>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
To: me@black-desk.cn, Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:50=E2=80=AFPM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
>
> From: Chen Linxuan <me@black-desk.cn>
>
> The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
> credentials ptrace access check before handing out a namespace file
> descriptor.  The accompanying comment states that the code "mirrors nsfs
> behavior", but, unlike the corresponding procfs paths, it does so without
> holding the target task's exec_update_lock.

After sending v1 I realised that the exec_update_lock in the procfs namespa=
ce
paths was just added by commit 6650527444da to fix CVE-2026-64371.
So the pidfd PIDFD_GET_*_NAMESPACE ioctls, which mirror those procfs
paths, should be fixed the same way.

CC Jann.
