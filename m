Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FD412C08
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764701; cv=pass; b=MmSZB95o/KXG4JcjjK8g69kDOLt8huUeRrew5Dm7vLT3zWbf8bMCXCtOVcu7j85QcYw676mbUMTT9Vd8F2OGRcDopPjGOpLgcvWsirPFz/DFw265A7g5oyk3WJfgkJEcMC/4AzqdWVWVvJBA4ZqJqM0eH9KbuTDs2Iv2U+oVYxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764701; c=relaxed/simple;
	bh=/hpeuRssaa6XcAvdK1eK6+2E+wNiDC4goF4wBMKm+6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxPKV/3UliuK9QnvTU/P5xkr1imfFVjyhk+G1SwD2/lEsAFzocTL9gzuYfON5T/YrQ0qf1ZlM60AYHecT+yYmFXU5bF+z4kUpKJNN6/jQLwy8Z8aGdZAFfD00nYzWy6AVHZsMhVSGJiVEpzChCpFpJhmMYxTdSDfQoQ59i6HJ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTUg4rKl; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTUg4rKl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cede6375caso133545ad.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764699; cv=none;
        d=google.com; s=arc-20260327;
        b=Dl7sVNYRSexbvvXl6r2mQ1rHzbZLNBrRY5ABbKIVdhmVtnQON5BJhuSYwYSPZEA9hO
         EdOblao6yZpX6WTf5ftqZV1pJFgfKCyJIlgScjkbtW11rrvrZSe9uBWuwIsovxbooUNA
         e3+r/IQlqd+djn2saoHkc4HKeXHeyGSNH6KOISmpEFyIH6AZCjCJuzQ9NuLPEzZYXM5o
         NrbLPeP7RjI+u7ews+eK/syMpRk15JUuSkYk/dXciWrA2RcCmDxFwFUPqn8dVdGgPD/E
         fanL4Ts98vFu6uIVnw5Yo0UjY1KMxwiOdJouTupAxBUu2wWfDhO0J18a2eC9dEDUehLg
         eg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        fh=quaEuGDPE3+tyI0jJmTdItYU2T+hpWFu33QjYlrUs00=;
        b=gH/IZs28zY6ZnbOZ767iE7Ka7dJhPqIIAAz5TMhfuN1pmB9isSB2vrcomX2m6xF0tS
         jQ1qnoZ21R8DVTg8BG9Tl3z33SGiumleLJ56CfMbpqN2AnCwNFSxUtsaaw44X7HdeO+E
         3GdypwnBMq69Kq/iJjkjwCm+3dnMDKSVQvFwmuXKY0o9WXA8L34jvHtoRQ5mHSIPf3j8
         oXay7aRyefrmKSE4tNY9Dm6GvvVQmpt49fiT2VvflWJeyj7XIkQFlOZIiQS4fGQweMeU
         QVRMqK2ESrwqmKv4qCQz3cNa6wM7vzhZ5HeIu26g45obzyS1fl6tK30kkthQZE8kYw8D
         j9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785764699; x=1786369499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        b=MTUg4rKlUUL8Nu7o+/d0PeSTI1dnlJUcV3Byah4LTBrTotyXmQweamfNFl+3SIfDCr
         ng01Np5Mq0xloHVmINFBFGdquGx1OE1ovhKZHLmVoi+zg8x1fxrzYeoZH8M7yGI8E0L0
         ZuO5mC7WcaPb03GMQ1r+iPwCb/2/vkh/QIyYlQA1F22wiIppKv6Uc0l++a6wfd8n1G17
         Csl/X4H06JruwFzE9LpjIG1eYOx7Ge2I3GsFY3mh2JsMAqlQsWBjUANNNUgBNG8ys752
         QF4Y8PhVFgDQ1v6Wcyjm0VwCuV5Eey004tFKFZlLsUFXeTonmuIcIxKwGFdjO94JqfM4
         YmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764699; x=1786369499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=og0yvuLtJG8uMDCPPvFKEGgNRUhvDLT0Vv/6jZ7ygcA=;
        b=PJqQ5F+yVO10TjOJSqvJRK8CFQ7zNfUfyGmi9JftepZNKf274QAZXjLqVRHBgaj0m6
         R3U1TviByIGX4g43+5jCgbkBo4X7x04hKMk/tSgID59XXdX3EvYfEmg5/gCNJ8NoXNIR
         1kqj0G3+qpNQnCAw7J/VF9NGrg3rF0c7lrZDfWg0eegQGPMMSREgzQn8Ew3Z+eN86b5O
         NizLHFu/iHflKfO3+yOI/89REVdERL/G0w3hBFhCsjU51ou6FH6lBpWpupxNQEc9F+yi
         K0mi4L4NvwAVnCE8mh4ma+v4aN9jSx092zeyZIQGyzMuCYngXTXeQ5KHaKvQfcE2uXVh
         Gwjw==
X-Forwarded-Encrypted: i=1; AHgh+Rrakq7eL2vr+xA8EMGriR/1qGFeKsPefpmwAxzDCHWLI/G9mGhzvCuyDbRTHkbAem/CuLV+bmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ck8IXRXBiEsDvmAPwqF6Uvjj2mDQuPgNwTNIFrnVypezeSuO
	hyXVKf6o+YJCIjCE5IMf5HoBj6OHyYlvWBpue48pTKaSYHvIstxgMKxfv211WmS1+CY6NUv65tW
	Cl8TTSumxm/GS7qj+EHcmyUmKl6vrC2IB5H8Awzvv
X-Gm-Gg: AR+sD12UVOGs6bLb6rl+7EqVzwj5zmgA2tXkLPDLRMqLO1MteH44H1yDUXlGK3uFqM3
	uIB/4GYLf9Q2eGL2WOQbjpOixkcm+wFGAEfhKyGJ95Tcb9T3N41WUMdqn+GIOYc8nnN2sGy13O/
	m8LOAiz0dlVGKJfjQ0YoN6lUCTgHf07AYnMRayHx9f0JHFrdShwH2tcxWBYQKFyH1qc9OC5Z5NO
	Ei55dm4WUp4tOC4BldaWgFleCA/Cte1SqTyB5zeXCMSJDYYqmZEiTe6UIliUdgGJ/T4oz1fgkkj
	nqjg7TWQt7djDdqRzRQRneAKXtvUCCpEbcCFAfH4XDcoHCXOuNcdOl6EAEYj+koIMxuJDAhf+pk
	tbbFDn8aD1tbXX6s8EsSFBcocVtT+FMblcMOHLrpEVNU=
X-Received: by 2002:a17:903:3c63:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2d0547fc556mr15355195ad.12.1785764698053; Mon, 03 Aug 2026
 06:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
In-Reply-To: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
From: Jann Horn <jannh@google.com>
Date: Mon, 3 Aug 2026 15:44:21 +0200
X-Gm-Features: AUfX_mzMs8LPMGeaw0QXamLvi3sESQh9nHboIA3NCYUg_jtF9QZJiqeYlNr2lt0
Message-ID: <CAG48ez2YssN-F9DHHskmiWORTnaBPUUyixqufD-L5VkW96Uv4Q@mail.gmail.com>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
To: me@black-desk.cn, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:50=E2=80=AFPM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
> The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
> credentials ptrace access check before handing out a namespace file
> descriptor.  The accompanying comment states that the code "mirrors nsfs
> behavior", but, unlike the corresponding procfs paths, it does so without
> holding the target task's exec_update_lock.
>
> proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock for
> reading around the ptrace check and the namespace lookup, so that the
> credentials used for the access decision match those of the task when its
> namespace is read.  Without it, a caller can pass the check against the
> target's old credentials and then read the namespace after the target has
> execve()'d a setuid binary and committed new credentials -- accessing
> namespace information it should have been denied.
>
> Hold exec_update_lock for reading around the ptrace check and the
> namespace lookup so that pidfd truly mirrors nsfs behavior, as the commen=
t
> already claims.  open_namespace() itself runs outside the lock: once a
> namespace reference is obtained it carries its own refcount and is opened
> with the caller's own credentials, so a concurrent execve() on the target
> can no longer affect the outcome.

I think this makes sense.

Given that the rest of this function is written with scope-based
cleanup (https://docs.kernel.org/core-api/cleanup.html), I wonder if
this patch would look cleaner if it also used scope-based cleanup...
that documentation also says:

"Lastly, given that the benefit of cleanup helpers is removal of
=E2=80=9Cgoto=E2=80=9D, and that the =E2=80=9Cgoto=E2=80=9D statement can j=
ump between scopes, the
expectation is that usage of =E2=80=9Cgoto=E2=80=9D and cleanup helpers is =
never mixed
in the same function."

But we probably shouldn't be holding the exec_update_lock across the
open_namespace() call... so I guess this will require either
refactoring this function into two, or indenting most of the function
body, or some explicit "drop this guard" operation.

@Christian, do you have an opinion on this?
