Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E0491589
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791637779; cv=none; b=RityqwpqVL6iWhbPVU127aVq3JQ8zJAER/97JMP8P+7JRuwPkEnaYJvc/UuR2iHAGCJrchr/FucxrtJf8D6J/pik7rmO7NmpfVTr9Xqgsaqs7uULRK5tg1aYUb1bqpjy2pMQZIX+ZcRYhB/eUFtTWKEkCmv8tQAh5VuUhz3KfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791637779; c=relaxed/simple;
	bh=LsK6fZ0SfROYf4etiSROXi+yEPcumM8U1TqvGAnBhk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+IHlWqKT9abfYRaKCnh5sp4/QG24mtGr/uB7v0CgTsFU6K8JanetVGJ0Un+PSEylw69H6iXO6V27BbNfXjD21RvVIeCsQSY2njZ36b+zNvSqvVk/Fws73Z3IfW29509rgCLxsG2zKXHxlPgaIe+W30MaOB2JnQeBXB+szzXNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMRk9Ns9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMRk9Ns9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACD91F0089D
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791637778;
	bh=az0lTeXZV5T09G7IFnvnoEANNK1G4YVdPM1Se95rG/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fMRk9Ns9JicVxY3EOz7ROCFQGwTbSn59PTYJfLm78aYfCIsGVfDMAeoi3V2Klbz4e
	 VjOrYRzHrJ2lu1a/eNIW+4+lxwneCaTuaD2hnaYmubA61FqnLFaNUVQkcUDg/ImDx5
	 l2449RbUFG8IJfmCVEal5XWoqKWikZ3ymzJoDUozLyeegFXj/NSdXtVkdV/u3iEFgR
	 voLTbZDESt4hzafrzB7Eh7AVAfN2i4FyKD5iZDaH83bYAui9DTP+sgHGVSNr0hEA1R
	 UjjH32c40O2yeoKgDW9RWb0zTpLeiMgmox4yKBW3DLog+RWlb5aPFjXdc3IEh1ZSAM
	 kMCowg5r7zqTw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b16824c0fcso685390a12.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzqYSSc+NE2Wv5T2RzY0XNl3i1U6QP7Wdb/hhuBrAj3DMDhKPKsU6vbE5hwKgZNFqB0ssBx3Og=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1T/0kq6HXU6akAc+6p8l7Y7STZbvuv6hY9CqGg3Q31yPmU3Gg
	hYvosnehuzwvX8T68IVziRfcEH/5lOO2+Qf8nt488iaC/wOSV6v7IJOh8QH24CBq97AZWjodmWa
	cWds+MmBUEnO7DzeUDOROdn6/MTDgPHs=
X-Received: by 2002:a17:906:f58f:b0:c29:f5d5:5a97 with SMTP id
 a640c23a62f3a-c31aa04b413mr539680266b.33.1791637776558; Sat, 10 Oct 2026
 06:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8MyiCVhdN_PaQ=aSEO3yYYQ-Qb-2TnC68o0_pbchM0mw@mail.gmail.com>
 <20261010032856.1880706-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261010032856.1880706-1-bsdhenrymartin@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 10 Oct 2026 22:09:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-GfJxLk6tUdy5tiqz-w-zjLzqUzh5kZDuoJBLLXcLUtg@mail.gmail.com>
X-Gm-Features: AclHuK-MmhmTOSXadXJ8KeSGNp1qxkmHPXULH0ZOyu2ydC4gtXzj6eFxbqq9qVg
Message-ID: <CAKYAXd-GfJxLk6tUdy5tiqz-w-zjLzqUzh5kZDuoJBLLXcLUtg@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: fix use-after-free of server info on
 cifs_ses_add_channel error
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Steve French <stfrench@microsoft.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 12:29=E2=80=AFPM Henry Martin <bsdhenrymartin@gmail=
.com> wrote:
>
> The error path of cifs_ses_add_channel() calls cifs_put_tcp_session()
> before cifs_chan_clear_need_reconnect().  The latter reaches
> cifs_ses_get_chan_index(), which dereferences server->terminate; if
> the put was the final reference, TCP_Server_Info is already freed and
> this is a use-after-free.  Same put-then-use pattern as the recently
> fixed sibling in commit 717e0a25036b ("cifs: Fix server use-after-free
> in cifs_chan_skip_or_disable()").
>
> Move the put last, but do not read chan->server after dropping
> chan_lock: chan points into ses->chans[], and once chan_count is
> decremented a concurrent add_channel can reuse the slot and overwrite
> the pointer, so the put would act on the new channel's server.  Cache
> the pointer under chan_lock, clear the reconnect bit and decrement
> chan_count while still holding the reference, and release it after
> the unlock.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: ee1d21794e55a ("cifs: handle when server stops supporting multicha=
nnel")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
