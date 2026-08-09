Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76992EB5A6;
	Sun,  9 Aug 2026 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245923; cv=none; b=WhderVCdB4FVdqlrg8rN9pSNXuYEWTBSTh188wWsEmlzhe8nMg4lbOXK9UowRhEppR9bRaEXOzPSx9Bpf5+uH9rQ8Skil6VuGcQ08FfIA9WII/lA3XTTFr/788NaSo596MsXtKjyKkpDm0XIE9HgWWdvbm/SZ9J5IULpxfCvoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245923; c=relaxed/simple;
	bh=CwPpQcv+MOj0Fw1LB6TEZR5/DiH260qPgCYgmfd2X0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5Pfs/3QOrcn/01+IbBRKZ1YagiQ7mrLgnh3TyqVvZG7czlNROYSKApt3MoDyr6s3Jx7DWYNgGHDTrnJ2IPeM+SI/cZQAND3dIL56qMbIEjbLzTBEV/4db9xTLPnug7w5oM+uemf/sofAyUVWeVS7pK8MzADH4W6PmZ2w/yxEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgJ8y+0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgJ8y+0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E61F000E9;
	Sun,  9 Aug 2026 03:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786245922;
	bh=WzHWHPMCQ7vMsP50ZqL7uN4ib4ubH0eolNqnik5tgTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgJ8y+0U6ewmrWpfpq4JxumKk5piYdaezYFfEmsLfHin0s6t/rnI0syWZqZ7NlfaV
	 zyTxWgWV/nqslAI0V8nQCr9OV3RbRinOwp8cezPE7HAUi/Rj0l78RxXlXDQ9jVY8i7
	 0nLA/rdCT8+qX3dOtI4GibY8CMxb30ml4bankPaGRJZJbYFN63E/IVTICd3qimg5jg
	 y6I0z85M+TTFAvO71Ny6n1PRiPDRszg3+WrsMoWwTJO95sHZ+h1svOotGu0RWxaCId
	 johfyym7w+UsIe0RszAcDu/SKQVvq9g3wBbLjPbgHNllDj5Y1csbEbKDeAElLGzvvm
	 ldukzZa4Z9GGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH 5.10/6.1/6.12] mount: honour SB_NOUSER in the new mount API
Date: Sat,  8 Aug 2026 23:25:15 -0400
Message-ID: <20260808221923.stable-0001-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807103829.15163-1-arefev@swemel.ru>
References: <20260807103829.15163-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 01:38:27PM +0300, Denis Arefev wrote:
>From: Al Viro <viro@zeniv.linux.org.uk>
>
>commit 6dd3c6884cd9defb511284b566cef5ac8f657dbf upstream.
>
>One should *not* be allowed to mount one of those, new API or not.

Queued for 5.10, 5.15, 6.1, 6.6, 6.12 and 6.18, thanks.

-- 
Thanks,
Sasha
