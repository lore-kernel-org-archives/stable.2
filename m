Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABF31F992;
	Tue,  9 Jun 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016386; cv=none; b=GkcdH3/z7o6MuF5G6Q0jF2qiCPMmzVAfcFlR0qFi8VnF4kVJiKQmjvQz+SGJztcS+dzbJk0Q6mzWsoeGbaWY3a+YqJvqPzrl+t3GA0JEN+b7DuBc2mFTPvaJIegJmMvo6KGJtsbUt0M/0qfOI1zIVlWHNK/NlwkSnhiI8PXzxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016386; c=relaxed/simple;
	bh=gyIw8qRJBT3Y+spWZo9h+r3vb6pGmevAvLL0YYRbTd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Roz8jLlkBn7tiEwebZiDjVgXWB9j7YwqvCoDaPzWgZ5WoNXDEXQDT8zHUlTt0AVd9NTTPZtgJctSB/p+t0ZzRY7oiRPM6aYx7CFetxrfgDtGxY57FpkEe3TPhPRCWsFa9ACrltxC4SaZnG4wkca1vWNJDvQiKwmzryJ42rK3SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=AQIOEq22; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="AQIOEq22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781016372; x=1781275572;
	bh=kRZYQmoUTtWL8RaAVkGdWPqztQqU9tO0ZWRSwMoD+0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AQIOEq22dWr4hrPDOiDfdVUAqQs5aUFejqZw57rryhsUV2Z/v9kvUSHgCOyNwdCBI
	 /hJkY+puO8YsrwDqmUokGawR9zhkRrDfqnk44cpVu5gc9ODih3/BZSgiCmU3BOu8/e
	 8lLbWaGHvVGSQr5hdpDHHSoCwQLcmXkSOe4XAOQr4DLRlJusW9RN7/reqz8Nt2wDbm
	 wRvQz/nndySbSTELmq8asa3E/HXTcux/0m0WyjsgDAGwYZdzqP0jxy5U8g9fCUh33V
	 YgeMV54L0tFMrPdO6XeCt9dRTVrdGHBEYxnLfJTDbQcBWYJixaMxcGkZiTcLve6DCo
	 R5SMZm+MNGRxA==
X-Pm-Submission-Id: 4gZWtp3qJ9z1DDWd
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Creation of workqueues in Rust
Date: Tue,  9 Jun 2026 17:46:03 +0300
Message-ID: <20260609144608.32100-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
References: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 09:23:01 +0000=0D
Alice Ryhl <aliceryhl@google.com> wrote:=0D
=0D
> GPU drivers often need to create their own workqueues for various=0D
> reasons. Add the ability to do so.=0D
> =0D
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>=0D
> ---=0D
> Changes in v4:=0D
> - Add link to delayed work fix.=0D
> - Redo workqueue creation to prevent invalid configurations.=0D
> - Introduce a directory as workqueue.rs was getting really large.=0D
> - Link to v3: https://lore.kernel.org/r/20260227-create-workqueue-v3-0-87=
de133f7849@google.com=0D
> =0D
> Changes in v3:=0D
> - Switch to builder pattern.=0D
> - Drop BH workqueues for now.=0D
> - Mark delayed wq change as fix.=0D
> - Link to v2: https://lore.kernel.org/r/20251113-create-workqueue-v2-0-8b=
45277119bc@google.com=0D
> =0D
> Changes in v2:=0D
> - Redo how flagging works.=0D
> - Restrict delayed work to not be usable on custom workqueues.=0D
> - Link to v1: https://lore.kernel.org/r/20250411-create-workqueue-v1-1-f7=
dbe7f1e05f@google.com=0D
> =0D
> ---=0D
> Alice Ryhl (3):=0D
>       rust: workqueue: restrict delayed work to global wqs=0D
>       rust: workqueue: create workqueue subdirectory=0D
>       rust: workqueue: add creation of workqueues=0D
> =0D
>  MAINTAINERS                                    |   1 +=0D
>  rust/helpers/workqueue.c                       |   7 +=0D
>  rust/kernel/workqueue/builder.rs               | 380 +++++++++++++++++++=
++++++=0D
>  rust/kernel/{workqueue.rs =3D> workqueue/mod.rs} |  53 +++-=0D
>  4 files changed, 437 insertions(+), 4 deletions(-)=0D
> ---=0D
> base-commit: df9c51269a5e2a6fbca2884a756a4011a5e78748=0D
> change-id: 20250411-create-workqueue-d053158c7a4b=0D
> =0D
> Best regards,=0D
> -- =0D
> Alice Ryhl <aliceryhl@google.com>=0D
> =0D
=0D
Hi Alice,=0D
=0D
What's the status of this series? Do you have plans to continue working on =
this=0D
anytime soon? I would like to take it over and continue the work otherwise.=
=0D
=0D
Thanks,=0D
Onur=0D
