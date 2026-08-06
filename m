Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F041B8F4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051319; cv=none; b=sBGV/xbrEtD7tDBzMKlLFiGBoJFjOkuAQxX3SHUGfzGT0lwIJ1fiTitGVJ1waRDtY8PLJCSE8MgzzR5js6GyvEuZu0fPEc1ZHXgUQrB7YuRxEINWce8LypvQSEuvyroI80uHNM74eu9KJ5byNwL5/g3PcaYvFbVUGsC1x5cL6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051319; c=relaxed/simple;
	bh=aGXLZvyQelkPQT3cxfLKxCKRSHoaeyboW4i8S8SEvIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzEf1QKpgQQUMmD8HHt5ie+aXhTuRzM6I+7QYcjoxlpkGTf8D/WktP+VkPgt/2V7F5raIZ0ygO3eyNVyMvqonYciFeThxWsSfand/y1onzjAeqgX/DQFIa0rn8shrm2fR5xI5uBeq7azSgiieChDMWqElign6J5fgxhil90ZPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m379iGcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m379iGcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E741F00ADB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051317;
	bh=I2TwJ5gWdspTnscejso/2PwdAtoi7VMpYmdyEkn6CtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m379iGcyCXIRcdKY1yEAzDFRuSv/TTX9kPUPFaX/8dTcd2FCugXDRhJsvXeueSbr5
	 NE6lIQwSzSF5IVZxBiQcBZO40zE6MbeRl9j0ZW7LLzVTApyJXq4NdodTAafUdIv7Mx
	 ClLJ9B1IM6obBZzePW7U5k65NHwQVBa4MV9kYmop7whGUsGFryNoGmGpmmNSIcfZYC
	 v9kKKkSzclYnJd9lfqTPYQfOoPqzLIPCHFHZV9oN2KDZuF824gl/eMq/dSoIrauD+K
	 5D5AnFz+4uuadosxYdB96Qv9k9ITZPQZUNQEfHv4C/Iz4ZtAmQcKMSNb20b9ShcFQi
	 mQnx0cbQEFlIw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50a650a0so149970285a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:21:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RphcrW0xB406gXtzjtZUVGLE1lVbcclvSWfN9Hvnmc6UOSwF9jtNzksp0H3VDQtO14wFL4jnGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EZ32hJ9G2CBXE4+P1zDs0Gz3MK47XQMgtGUEj1sjRbXABo3z
	KTS37MRQBhhLoN5GrBG8adA9aFTTxA9pK9+wD5VFYeq2I7INgQaxHRBjgRvcR9RwR5Gpn4u/xD8
	+lWs1mOgVGSnWD553LYEv/hFtGjLsGpI=
X-Received: by 2002:a05:620a:1b92:b0:92e:da7b:561b with SMTP id
 af79cd13be357-93649165185mr1988040185a.19.1786051316432; Thu, 06 Aug 2026
 14:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com> <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 14:21:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
X-Gm-Features: AUfX_mzFjwnQcUwC3lCRH_Ph_LR2tCAIsoyHf1ype-ho9x4_lwjyfQEXdHzODNQ
Message-ID: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz, 
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> callers rely on ftrace always being on). Refuse the write instead of
> leaving it in an inconsistent "disables some, not all" state: return
> -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> unaffected.
>
> Update the docs to note the deprecation up front.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

Sashiko's comments make sense. Other than those:

Acked-by: Song Liu <song@kernel.org>

> ---
>  Documentation/trace/ftrace.rst |  5 ++++
>  kernel/trace/ftrace.c          | 43 +++++-----------------------------
>  2 files changed, 11 insertions(+), 37 deletions(-)
>
