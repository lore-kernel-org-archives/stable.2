Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299425;
	b=DQX/kY/Eq5SoYCQlrjM8RtTldodt2qoETIhGFmsZtJ3hHUkpCDDOr6IZxG7qAkpQVQC1
	 lNDaxpzlAixFwF1yfC9X0PgolALGlmK7c5zubp4tSmvRdNs7hJqwaIZo7qx4oUXkKAtto
	 W4fph3tlYJOQ3hXGhrIl21J8aB9lA+3yDb8+p6Zvy7ViIwRn9piWqcSMKzkf8fq3jCCJd
	 lsI2CAQfBs1eSoyA6UoEEY57I7j+T+jljmTR5b/K9tGMpJYCB0FNkMjWOMARclIzihDuA
	 YvpI9RbQ5weq0sbq84/RkCLTDQ/xDITBAGIR9dn02K4xuJUH9sgbYEOC0RAED8ontKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V4te2wEsSq2MQOwnRIlvq8DZ4r9P/00oEbFjRyb1KN0=;
	b=JILMj6KogbwEUN1SOiQLpAi4P6GyzSmn+VkornjGVwj7/dVeR7ImgJPkgoS1uAh+NjRu
	 AJ380o9JgXUPqHZdu8v+t76fi28AQrKe+9YuuyZxQcggrVKJ1VHBhL7yi1Y8DNjCwG5N9
	 iyeghOIHnMc4yFfQeQGiVfcJ7hUYmoDxqD7WlE9NVEqRQmLck1/ncaB/Labo2QuvkLRZn
	 gRKoYAyPtZnGjdf71pr97pxZHiGz/a3y85D7Vt/NBxOi85rH3I3VaaeQ68reWHf+4Nw48
	 VEHOFZjURWZChg8+zu3YgoBVncw/sbYWL5hFIJe6Fqs7ZaamuK7EJS1edPxybhw723Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohn5vNZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99E606A327;
	Thu, 29 Oct 2026 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohn5vNZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25901F031E5;
	Thu, 29 Oct 2026 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299424;
	bh=V4te2wEsSq2MQOwnRIlvq8DZ4r9P/00oEbFjRyb1KN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ohn5vNZY2b4T/TlFp23gCzsTferm0LKWKVY597MzxzbnsCOWZOgO1IV6zRxnrwpKN
	 5yPz8Ac63Eujw+6C0Xuvzp3JZ+4JcGe21kqZtEQ2PCZWgcGj+jajlGPyg3SvoakrLE
	 Z5ztQyx+8vhPNpu8e3a5fWkMBnwFBgroHqEwAVUz+ZV3Ro8L7zu9L35Lo2GRhEZCX9
	 dHD/E4+7pN7mV6n+EFC9Y5tngwaV1SuPwm5F3hDJ7eAdAXqLnr8s5LRQTrcxdQ1UaO
	 8YYVCDVFKvuU9pfnbny4cFj+OLnWmNz+214y15NqgmfB/j9LVl4HHomd8Toky8yOh8
	 DpSJNUKGJw9jg==
From: Sasha Levin <sashal@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Carlos Llamas <cmllamas@google.com>,
	stable@vger.kernel.org,
	"open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: fix null-ptr-deref in ntfs_lock_new_page()
Date: Thu, 29 Oct 2026 14:43:17 -0400
Message-ID: <2026-10-29-1-daily-reply-0010-ntfs3-lock-new-page-6-1-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029031815.2783998-1-cmllamas@google.com>
References: <20261029031815.2783998-1-cmllamas@google.com>
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

> Commit 95b917a14b15 ("ntfs: Do not overwrite uptodate pages") added an
> IS_ERR() check on the folio returned by __filemap_get_folio(). However,
> __filemap_get_folio() only started returning ERR_PTR() in v6.4 with
> commit 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio").
> In 6.1.y, it returns NULL when the folio cannot be allocated.

Thanks Carlos. There is no upstream commit for this, so I'd like an ack or
review from the ntfs3 maintainer before I queue it for 6.1.

Konstantin, could you take a look?

-- 
Thanks,
Sasha
