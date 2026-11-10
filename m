Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344383;
	b=rum6pHHYFtREpjocx6LLo6hoyTljiv510vQtRUeCWq2fYViTZnXzbC4Xvy+AV38UQZdl
	 l5IHlNZofanAzUBRl8JgfwnRsv2iNeDeB7y/y78922rdhpKqtSfxrj6TZ8yWs+XE8xg8t
	 EI5DeBV2pnr+6kKgzO7JI+x/3CBE+ZFcKfaXOp3z+yh/bnLBNwps90GBhGti28VbV0dZ2
	 pLavK/8c3R2/gyFUM5bZce4nRo6BsoVLG+71FGGKrlF/MHxMnZd22Nltn9XdrO3eanqfV
	 G/tWdtUgvOgD1EoXqhBeqwVWSxuQJH879ZP7QPUbGwbqXiICr2uCGAyOoYT7lz9QmUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SvDAtH/JwM3DeoG4H2x9y63kqFLwTXOfr8/w9opbDq4=;
	b=NFZkbF9n8r22MVm+7i9oQv6UBjib1efSElHO8W64odNUN+0+EZndCKY9BASc729dlgZa
	 MGW61wheDl8VjHVGr/unVRd8zNsEaIx7KXWMNElekKwMYN39QNx5/5Q6qbwn5p7c38x1i
	 TnKRQ4pM6S8HZgJFP947wv4/ZxR5eOXT1HQE6kM6EQcGB5VKCjirtofjqrOQ4FmaVNEai
	 MUo+7kkSoPFPjABTyOnm/5GDe436yojIdNA1Nve2z5f8TGFvTbXw3kN1reQ/ajuM5x7bF
	 PVxL/Ccvn50YreupffQ1pKXLTraXNOwDkRyn4XYBWXpuHrPFooERhGHkIXTVJYFlATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SecDpxdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SecDpxdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1481F0089F;
	Tue, 10 Nov 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344382;
	bh=SvDAtH/JwM3DeoG4H2x9y63kqFLwTXOfr8/w9opbDq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SecDpxdfGrKd1P4S8rrxkkKkOUJeS+n1jUr3POukRnrtIZdVaci3IYjVS/7GqNkWm
	 RPavbp5xKo4Sc/pYnqG3s82jL3RnDMh7Dw1LhMn+A25lMufTI3bD07iK/OMBOqDB8l
	 B/k4m+kBgYQhOA6y2LgmlVVmWuNn9QizHjkNFVm+nju0BBjYg6WIa5uxcUaUpw3eDV
	 sjZrfTwUse3BXlUfsYRhUEtZHMzr0Ldz+oOtiZh2/BC0+c0nI6GxP9KA+C3FHxWUb3
	 e85ifEIvSaByTatItprlXR3Lg+KGnuGHe36aqWHy6v4Gz0X+nXkeh11Ll9cjwYnU0q
	 uqLNqwuTf3u/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	ranxiaokai627@163.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	linux-mm@kvack.org,
	Hamid Nassiby <hamid.nassiby@nokia.com>
Subject: Re: [PATCH 6.18.y] Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"
Date: Tue, 10 Nov 2026 15:59:05 -0500
Message-ID: <2026-11-10-1-daily-reply-0009-page-owner-revert-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109141527.2880867-1-hamid.nassiby@nokia.com>
References: <20261109141527.2880867-1-hamid.nassiby@nokia.com>
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

> Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
