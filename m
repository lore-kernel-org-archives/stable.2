Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAB476CE5
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394367; cv=none; b=JNdHXAahbRKp95kGM/YjhUUkglrgDLE7inNFcuqchsSXuWEAS9PW82d1mBaUfYMNTzvlciTAx8zCZ28iEvorPYv9n4rQ0PyCfNf3duNAK6gl4NPE+XdujFyFJOMDWrwdj3PYChvHkRf15oOXJtAWUwG7nSMW/wWHlPtYHJ2TUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394367; c=relaxed/simple;
	bh=THdLJ9ee9FRcCUXZZ3lWD/A7Un1UUekTw0Kak9WvlPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVqW27VxbC+La+6tncGcX6jRu+n1jhJKsleXN+6QPTFIfBiZqkMHQvsHPSQ1MJoGdI2dYbAahFozzJWYElJcPrTbrvppGM1CJODLerhNoU9PyqinEtM0JeUs3r+8oFXH8Pck9bNhAhFvYo6VqVNPP4l3NLZ/eXtKJfefmBrENOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWvJiVN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWvJiVN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBD1F0089A
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394365;
	bh=BF/upnNJRBN8CDJv+gcD8akq1YraOZ5jyJeHkMFP4/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MWvJiVN+osSHVWtYNMYOYFaKvPqgvwr3/Y0MY1Q8Txs0bMNulOhDJE4n4VnAOjPpj
	 KRwotvcgQWTGEbpIJ8umjX7ZsdnJSl/zmCLQro88oEK9r+IXlOuFuUAPSbzQnynC1U
	 RUitHmZK6arTdXnknohIFhCwMCnOFs6NVHG1xu/BwdJTAU7JKkdwWbxpbQVCazU5mK
	 fMtwwztWwGEp729/uuUAzO8MizIKCpT0BGbBwWqxtMOnkYKcDGLC8w2/p52sRaXNaK
	 AVRCZoi5G7g9JXKmMEUPiLSL7p7vfuDyHa2hHVz1Sb+yb0d04qr+sjf1hfoBsM6U/N
	 QzoHJWvqRTWVg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a9cb66f7b4so3177128a12.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:59:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy8WyFZjJ/GqSkXPIDKM5RI+GujeYERCBeHUbcn4/KTbeE2dZom/mUdAo6QbWOmOTRPzHGjcRI=@vger.kernel.org
X-Gm-Message-State: AFuF++kUr1nJZFQhw+k59ZQCKVbNK1dArKlH+Uc3AoH6orRc0JeUxYnS
	vz1Ns9Dv5y+zQixyt9traYPqIEam+2R60KXzXxSCIryOjTuQcr5A0iZzp7VXbUXbHm4hk1hJNsD
	VHWhAGKKyIDta56HcLO0ZZG76sKCsrlk=
X-Received: by 2002:a05:6402:3202:b0:6a7:ee54:f8a6 with SMTP id
 4fb4d7f45d1cf-6a9f63e997dmr1637389a12.42.1789394364134; Mon, 14 Sep 2026
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914034202.52011-1-zenghongling@kylinos.cn>
In-Reply-To: <20260914034202.52011-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 14 Sep 2026 22:59:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9EFNkofkj1tEg1vs5+1ohs1exYx6mys78X8852x8w6Yg@mail.gmail.com>
X-Gm-Features: AcwNN1XAR5bzxHAGZCl1dFczn-ZlFu0sSpynXI-wMbWjCynZLoDvrdWw3YNYZII
Message-ID: <CAKYAXd9EFNkofkj1tEg1vs5+1ohs1exYx6mys78X8852x8w6Yg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: mount hibernated volumes read-only regardless of errors=
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:42=E2=80=AFPM Hongling Zeng <zenghongling@kylino=
s.cn> wrote:
>
> The hibernation check in load_system_files() only converts the
> superblock to read-only under errors=3Dremount-ro.  With the default
> errors=3Dcontinue (and with errors=3Dpanic), a hibernated volume is
> mounted read-write and the mount-time $LogFile emptying writes to it,
> although a hibernated volume must not be written to at all.
>
> Drop the on_errors term so that a hibernated volume, or a volume whose
> hibernation state cannot be determined, always mounts read-only.
> NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
> remounts to read-write, and the $LogFile emptying is skipped by its
> !sb_rdonly() check.
check_windows_hibernation_status() calls ntfs_error() before SB_RDONLY
is set. With errors=3Dpanic, this panics before reaching the new
read-only fallback...
