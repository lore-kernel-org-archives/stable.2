Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552921;
	b=HCINVr6G1X3V4yqhMgQotQOYh4vPIyatk/dmXQ0LNoHBDI9PO/rMmo4mNVihTKq5Uwcq
	 MwfCfHxfiseXP2l6x2HXBHW/KSUSmRU4PWkw0KGWp/EZNk2yGkLWdngIH7lYXp1fmfC17
	 8ZgnnWz/vxoTDac9CqTpDeBk5tclVG6WQNkFAAIvfaD4BAm2WCNB/jZtvb5FMzmcysS7f
	 V8zaRC2ApUKC2C5AiexOoQRdVACqaTg64npzUKVrpZ8QbKuR0/zwoJbf1H/zpXI0x4QZ3
	 tRodBvjY0i5dXWoyvIlfy+uMpwchLd9OqnNe9ghGcrhTx52pVasXdbUOaXk5RX+quHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552921;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=I21QGyvLYuqiW8efrWEKXCzyX85q7lTtLZbUXjSxMZg=;
	b=AbBKLoV7YUQQF4Pr0h0isH9k0K94fRkkXaDQ8Vi8BrDRXgY+KlOsJuj0HJHtitpbxpt7
	 wd9nOj88enkNqoqmAwhM0Pb/WiQUBuBS9EcgcQXnBixUcr9e3WwnLZz61xT26WNXshKZc
	 jzpoIu4kC5L+A0CYRFm2fw03EiidMxzAsEMVm1XoUk63uevDqIrE+3U+MYi3bYXWgNMbD
	 A5kqxDIG/2LOTmMuyaMhfs/PIKN3IO81KCOoqoLAz3o2VPjtkDZQcrSKZ2bZALmAcqF8u
	 P+HkUaq+C59WJX5JoXqb4dBdVM0721LnNr7sK2rTbBzHg3m47V5Am3zIeUCI5708ZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=D0F9depx;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBD606A324;
	Sun,  1 Nov 2026 17:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDBD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=D0F9depx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793552910; bh=5+DQMvP1EuvF1C06xt4Si4q5kFFWytIZId09erO2zY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0F9depxyP1choXEsj3BLO+NFgOq27OlvisF1QlY1PNNWnc7ogRn0bEN29rJhoKGM
	 jOOl9z3hmbj8aoUJVK23QJOXi2oj19nHuluRSahgoqlbs0Y43T8lUZljgJJ6lR12JX
	 4YBJ2Fz0f9xAqDCm8LKx4b6+DwAH/IH6CXX9Pc1FCBliOau8jiH4nnkD63i9uym/zP
	 iElzlzfONWJYBHnacCC46WmsfSeffGVRifc/2gCg0YPYSTimDeh+UMCSxg3yz0nTIm
	 0p/Q6rQydT5EewIWUQZFbVIBbLoYLwbsBmjHgeM5QGWbBZK0iojXYKzdLKuf/Uir9d
	 uAPnglYflHjlw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E8010553; Sun,  1 Nov 2026 11:08:30 -0600 (CST)
Date: Sun, 1 Nov 2026 11:08:30 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] userns: keep the exec securebits
Message-ID: <audyDljs8nV8vA6h@hallyn.com>
References: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>

On Mon, Oct 26, 2026 at 09:53:28PM +0100, Christian Brauner wrote:
> The exec securebits are meant to be set and locked by a service manager
> so that nothing below it can turn them off again. But creating a user
> namespace resets all securebits, locks included. So anyone who may
> create a user namespace can shed them with a single
> unshare(CLONE_NEWUSER), and joining one with setns() does the same.
> That's pretty much everyone.
> 
> systemd gains a SecureBits= setting for the service manager itself. It
> sets and locks the exec bits for everything it starts, so interpreters
> that support AT_EXECVE_CHECK enforce the system's execution policy for
> their scripts. With the reset "unshare -U python3 /tmp/x.py" gets
> around all of that.
> 
> The other securebits are about how capabilities are computed and
> resetting them in a new user namespace is fine. The exec bits grant
> nothing. They're restrictions a task placed on itself, like
> no_new_privs, which a user namespace doesn't drop either. So keep them
> and their locks and keep resetting the rest.
> 
> I also keep the exec bits that aren't locked. fork() and execve()
> preserve them and the task can clear them itself anyway, so dropping
> them on unshare() would just be inconsistent.
> 
> The new selftests fail on mainline and pass with the fix. I think this
> wants to go to stable, otherwise the locks don't mean much on any kernel
> that has these bits.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

thanks, makes sense to me.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

for both.

> ---
> Christian Brauner (2):
>       userns: don't drop the exec securebits
>       selftests/exec: check that user namespaces keep the exec securebits
> 
>  Documentation/userspace-api/check_exec.rst |  4 ++
>  kernel/user_namespace.c                    |  5 +-
>  tools/testing/selftests/exec/check-exec.c  | 83 ++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-work-securebits-userns-6070b18a9cda
