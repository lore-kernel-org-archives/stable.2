Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207206;
	b=y2vSyQ2coBN6of1FtodBTpbuB5yt/sVkyMePlfbYi1AGZV2nkex7jNG5YvW3e9jMOVsK
	 OqrgAn+U+orbSwzNup5qMlw3c//lQd6tUj6SJrVCNmXPW4Octyu567Tor2TkDLNKlJAAs
	 pnMi929oXYKCSwZVyDcPWrqmNsz/lGU4aZJSg+Uxa/U3F+G6YEAayOkqZxCP96KgzOZ0P
	 6FU0I637laqQZ9JfHSInbSDAEah7b52ViwCU2fLG/xmZFpO8gtHgkL3vxffK9oX/B0xOg
	 2ebHT5iVNz7uWD3sEyHVDDDwFCLRq/pG+gOvSJgPIhYeUOK7fBPq4F/Ets7EsGmQm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tzrsra6/jCuhZSpc15L/lZ+NnW4zrcM0lOInvoYWDbs=;
	b=5iMGJUautHo0K/m7+eDauWhfwI4V2kgQii5TE/Pd/JXHWA2pGfDuYt4egxQT9L4cZ3Jr
	 sQ3rkV6g86bJQfEagqgjnpVdAL6/UxAtVpqVAR4IfFJDi56pBhYF6CeoWcFk2q6hJhjoZ
	 6op37hAX11jo6YlHYvjegwT7AkoKHtfununu8hvDeFDZrBulv3nDYtw1wNXCerNoKlh5j
	 CLA3x0a86L2rq7Q5MTX5JiRXEpemQ6u8akD3WBHLAS93eNEHV6F+GdvM5Wu/Zz0YxHwhU
	 qquUebamr2NmjYuqYXft6hbCQX9UiVvoxBsftRzV8MaYc5izVjA/5WVzMZ0zUYY1fTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H0L7/8cZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0660A260C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0L7/8cZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101491F000C6;
	Fri, 20 Nov 2026 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207205;
	bh=Tzrsra6/jCuhZSpc15L/lZ+NnW4zrcM0lOInvoYWDbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0L7/8cZk9QS9GRQLnwlsR1cNR0OWkGPDanV6Fh2tcsyscO3edFJSNy4Y+cBh3Hju
	 gc34bM2UEyUhzwRa7Jt/L4hKqloX6SKzaGZmh+xnj1cM+QcMicDF4h3MEkLUJPA8oU
	 n6T17jYWxq+nZ9gS1KUcNAAux/VDxKw1XQZooHRK3vewokmQ6IBCITEb35j4IIhPZO
	 0rjb5v00tdCbAVQQfZIY8yJy1M9HVcP0nxO9uTbUcrrCHrdgqSC8FkTp3f4bbSs0EL
	 t65vDHCdNNWQjPK0XUlIIoqRBciikYZsA4+2yDrsFmzZU8ckKAIJh+5C6WOeMLH+De
	 sXRThC1PJlicw==
From: Sasha Levin <sashal@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	kas@kernel.org,
	david@kernel.org,
	mgorman@techsingularity.net,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jglisse@redhat.com,
	aarcange@redhat.com,
	peterx@redhat.com,
	bobbypowers@gmail.com,
	bgeffon@google.com,
	dplotnikov@virtuozzo.com,
	dgilbert@interlog.com,
	hughd@google.com,
	hannes@cmpxchg.org,
	cracauer@cons.org,
	mcfadden8@llnl.gov,
	gokhale2@llnl.gov,
	xemul@openvz.org,
	riel@surriel.com,
	shli@fb.com,
	jthoughton@google.com,
	corbet@lwn.net,
	pbonzini@redhat.com,
	seanjc@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	med08elkadiri@gmail.com
Subject: Re: [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
Date: Fri, 20 Nov 2026 15:39:14 -0500
Message-ID: <2026-11-20-1-daily-reply-0025@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120082800.23727-1-lance.yang@linux.dev>
References: <20261120082800.23727-1-lance.yang@linux.dev>
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

> Checked again. 6.18.y and 6.12.y have the soft-dirty fix now.
>
> We're just waiting on 6.6.y. Did the soft-dirty fix get missed in 6.6.y?

Not missed: 2efc6332f18b ("mm/ksm: keep soft-dirty when merging a page") is
queued for the next 6.6 release. Please send the v2 for 6.18, 6.12 and 6.6 now,
on top of the stable queue, together with the 6.1.y series.

-- 
Thanks,
Sasha
