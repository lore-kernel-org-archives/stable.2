Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443352;
	b=kNy8yVkJpf9MNfa0X8LPl+oupCn2+FmWTlilLRfrrBuezMYViVBXDYCsk0jyOaHC3Jlx
	 GkB1AjhudENWaBMmoiE7bmcyAFVMZiLB7AnVV7LCPAL+zMh8ufUC+9h5d35qnfyNtDrXf
	 0t7Nei5o5J8ShFJjPxIcEZS4HluINBwPKWkN5cG5O20Z7EITuMOuTczvtcsIy8dc5elRg
	 9xTx5aKlf1R8gDY8y5KzHUm7o+VYDbD0bVfAM5tJevARQLoKis/90XxTIi7wMOb+XStwl
	 ILgjg5uCLZ3SAlGoCpaz+9uhry1137Qvs93ch/e9xo4nXx13vs6EPn4oMn3Avew8ijQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sIGyzX3B4y5JmTSJFG3fHckTLqX8QVWJboA+EMd/w/U=;
	b=MktLmt1bvvJZ7FdMgafYIZoVB/jmi2pu/y+/2Yuy0o9tn+5Ky0UjlEjVBTxsznm6EQ1D
	 oOutoIaP8ki/bsH203DcRh0RhcJbjbkJbbQCdlOrTaAqRMWLCVyEFl8mtEg7z90XIHop6
	 sf3zh5Ty8JSsSu8+j1bVunUdn86qQPtQ+lrLLw5tIUK8HqftT8jG9iI08P2l5ZlfhTx9k
	 B64tBP+6l9Lm512lZbV4ERGC104727Ga71EigvYY273t2zV8uDK/4QnpZq9h+nr0j0y7U
	 0qB+tRofcrGQJ9h83CWZKpEG+KAAfNK6wag7vEqx0+UiQbOoU99DsPGO5/iGzuoj41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jr0nD/C4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A117606A31F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr0nD/C4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1FE1F000C7;
	Mon, 19 Oct 2026 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443351;
	bh=sIGyzX3B4y5JmTSJFG3fHckTLqX8QVWJboA+EMd/w/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jr0nD/C4vt36bRYbcd8Fsz+oRZZw/Zv0vfmYKNyfcYFWd1satfZ6Wd2PBRrvPjxX3
	 Dokvm+GhskSe10i7j75rn0lrOHfP9ug+IIincGl1xqmbBOHMOIcTbRB09pSQfgyP7P
	 RpXnFyzRSugWJ/WRe5t4hRauiDh/YlHAszRzDwXJ2+RoRSVCkL0LcEg8T4gtXVfTn4
	 OqphB2wfwHXmMliCV/VYmEFWeE8Aqr2osnmHs0JKQnO/qkmJKa7yXsxxzpxxpy32sb
	 EMT0HOweSdGQBzCioam6ITZZCr9ysVwSnYXl3ihooC7lL01NvasrHan2iahdf4V5M0
	 VV4YoYvBZ9hkA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Vadim Nikitushkin <bub4z0r@gmail.com>,
	stable@vger.kernel.org,
	thomas.hellstrom@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	skainsworth@gmail.com,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving their bulk_move range
Date: Mon, 19 Oct 2026 16:55:28 -0400
Message-ID: <2026-10-19-1-daily-reply-0002-ttm-bulk-move-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
References: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
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

> So can we just apply the patch in this thread to stable, the squash
> fixes the stupid in master, or apply both patches to stable and leave
> the stupid.

Queued for 6.18, thanks. I took the patch from this thread, since neither
mainline commit applies to 6.18 on its own.

-- 
Thanks,
Sasha
