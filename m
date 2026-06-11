Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3341C302;
	Thu, 11 Jun 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191598; cv=none; b=fQQGaiet62j/MOeNXgZnXl9o31KOZMYLZvSuRDaV2m1N78I6bjuqdfvAj2vwnw5w8aEFV6u0mu9cOEnMa/K5Y0vSqEEOmC8wGcdHg0S6iDq0imeDl7TTeXDJb6WUJ5ODCUnxv8+fAaLvEhtiykGyCa1Mn7I4/ra3mCn7REafvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191598; c=relaxed/simple;
	bh=DBqicv98CNBfeibSXsJa778cvJt3FtvD4CmXE/vj5ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOEFXRsuPaP3MGSRBPsjbC+zfuc/aBuij2BZtN8WLwIBTrD7H+/J5Y8dPvCz14EMadjxSzPzC/RxclSB+RbmT42b3X9uWQmjWhf8tnSm6DBxW1nvCkvCB0d54os083FXh4ZZQqAeciFD3J0xSLtOE3VHLC7f+unMp2b9K2TgWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2IAczJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2IAczJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6561F0089A;
	Thu, 11 Jun 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191596;
	bh=DBqicv98CNBfeibSXsJa778cvJt3FtvD4CmXE/vj5ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2IAczJHXaOhDUioPEcN2QaawM0NOCZXvaU1aIYetgS5fjVWWIqAWOjbrZAsr3rKE
	 jPd/i2ZwvdlvJh/zo0EL4NA8he+zSYOcbF2Ry3mvItgl4SM7yIdWSJdmRl8VVL8npl
	 TiDh87bTK5nN/O5mbn5koGg3CGcuDeA8lCSSpADbqs+d5A80RZSAQpES8D59+O90By
	 d3CIoFqaQ6f0xz8Xfmc69fgpZDoeZscXI54uEVP9UsubdcoFIkGHszjhWmK+WWczSh
	 pvbCGd48BX4iJwg+5CkjdbLuGispmUIneoPcMcYIfs0moESl3XKxfOD8F4+XGIBOTZ
	 KLF8QcqX7az7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH 5.10] io_uring: prevent opcode speculation
Date: Thu, 11 Jun 2026 11:26:24 -0400
Message-ID: <20260611-stable-reply-0106@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610172203.27999-1-apanov@astralinux.ru>
References: <20260610172203.27999-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 10, 2026 at 08:22:03PM +0300, Alexey Panov wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> commit 1e988c3fe1264708f4f92109203ac5b1d65de50b upstream.
>
> sqe->opcode is used for different tables, make sure we santitise it
> against speculations.

The 5.10 backport itself looks fine, but I can't take it on its own:
1e988c3fe126 is still missing from 6.6.y and 6.12.y (it's present in
7.0, 6.18, 6.1 and 5.15), and we don't add a fix to an older tree while
a newer one is missing it. Once 6.6.y and 6.12.y carry it, I'll queue
the 5.10 backport.

--
Thanks,
Sasha
