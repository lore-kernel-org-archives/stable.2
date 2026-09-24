Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA990357D0C
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270015; cv=none; b=utdjdfccKXCWmcc788rW4g2gngU33pOjJ6SuTw/Ai6sm6d3Z+yyAYQyThytXB7qIrZmTgNI21+U8BHTV693px3zTEBrnN5ir7TzJmAki7YSv7AfEuxwLpyIT/FFf6e9Y6XtXU6qlzJgvsW0kChVg6YEw4PzYXj1qvI5yEURFJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270015; c=relaxed/simple;
	bh=HuBq1dgoqjt6qemoZulCxbv8xiDtMjOnT6LEr3oBzyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMn/+fp1LWMf7rC/OWBoEcA9ms1CumaexIa0DaB0Et00FlhV3kVthjC4dvEV6Jp2i9oGQrOHcdw6v9er3DXpqEIAsmBgHEibStElgkKC5p4XuGlDhePzPyFcekcKv0RglDqpzp126k/if0SjL54+jJHd71+188eJWjs2qAHscu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkw8QSU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkw8QSU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061D81F000FF;
	Thu, 24 Sep 2026 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270014;
	bh=KVynk1J9ZIK4NwAOt2xgFc/0dJmWVgfWI4Vto+E1s90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xkw8QSU1DY28gW4aTKgq8Pup73EjI4O7BSOXGjhDPEgAPnPPEsRBp5iQmpvThMv1V
	 ATK/P3jPW9Guz9FUWdPM4IjfGc0CVyYFCRPUPXCH8gYjRtcpNhygJ284BUKcnV0JDj
	 8stpYgR4uUH/Ev2aJldIKvTobxf9kQG1jiAuC8LR8jR7995st6DWQVej3D6d5ujjU5
	 /Sax2mW6uVzLxG+jzqtxxDJdIG58XWY1IJmk/AInYGd59Xn+dBXld2IpTFdS3OanhS
	 nUjT8SWCAtAtwPIS06kRVAX46BPDm/J+IlNg0mK/o/RSwWHelir/bSVoIWDRSREQvc
	 seiU7Ut/houZg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com,
	guochunhai@vivo.com,
	yinxin.x@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: Re: [PATCH stable] erofs: fix large folio race in erofs_fscache_req_complete
Date: Thu, 24 Sep 2026 13:13:20 -0400
Message-ID: <2026-09-24-daily-reply-0001-re-erofs-fscache-large-folio-race@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923084823.496741-1-hwenwur@gmail.com>
References: <20260923084823.496741-1-hwenwur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> For stable branches: 5.19.y, 6.0.y–6.19.y, and 7.0.y.

Queued for 6.18, 6.12 and 6.6, thanks. 6.1 doesn't need it, since erofs
doesn't enable large folios there.

-- 
Thanks,
Sasha
