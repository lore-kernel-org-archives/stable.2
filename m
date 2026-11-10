Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345145;
	b=FYGRKugCzkb3NSXXM0e0ngs2l2yAlJfL831KaCF/4GEYtLVXDGFoyIY7fNl81YB7Q5nj
	 /5z/qjkUdtg0kJ3QoFoKjY91uCUhbN7EUk/pY7n62suSu1cyeUd1xGwHHOFQHdEQnzTGc
	 D4wVLi8lNLu5ourIG2Z/g7FNur1zeEYJ4HKKlOfusYv+g9iNwollgTgcdz1B+jWEU7FvG
	 9eBD1H3AFhweEos3r/2G9/SJe2r5Avl4pbBzq7e/4yTQMMAv0Sv+U4j6U7NYtNAKeCcq7
	 SF9gjJ78/TopDPmzDvFLAf9MzUcttHIVmAJ3+ySiozj85mSRImUlHES5ZnIusbt/wwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kpMQjwToUtQMejhV8vNvA9vJE+DssTQ+ExQPhOzvSeY=;
	b=0KlJivD6Ypienw/PIu2dFInmtgPKzXf2q4y4gumhkCcWyI0MHzTzcONErjYlhjz2MoY+
	 bs4loN85s2IEUVq/rOsFEzidgx/IAnsd2Eo/i6rmpyprBlseTn7cVGXpgCYVBX2vKjYqo
	 SJaXDNZnUSnBdCnvMlkEpDV/PmHhUe5GQJcgZaJxMdZhOGkhcV1P7zZfIJEHJGuNuEzfj
	 /Fykv5TLB/1W1YGsx2vFqqteQ7YkFgfB08CMJIyw3ddlHjnuwl2TD7zTmAmL9FiTu26Uj
	 pFAjybA1lNNfMxjRVwU1W3mUy3qLkpnvL8e2S5gxT5v6u8IsvJXXhr4q1b62h6sQKsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNknGzNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F7606A31C;
	Tue, 10 Nov 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNknGzNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F61F0089F;
	Tue, 10 Nov 2026 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345144;
	bh=kpMQjwToUtQMejhV8vNvA9vJE+DssTQ+ExQPhOzvSeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oNknGzNTaCB6b8xU+djU2aY+3o/AwDqMYCenobrc56U84Tan4nhEITPKTOnFUzWZM
	 FMVIi7DYTtybcsKNLqZv321uHnIfLJkHRRvLZayGZdX4bZOMUWePllWxdeIJcGXlRZ
	 dmK3LpNw0aRbreZbr+u21xCtGZhy3qEhxf5/IxMsjhzWscIX6SsIMfQs1sIv+Cp9pj
	 O86QXxeDpJdUudiw3O1qDMvYtnwRfeeo7GEyKSTtDlwhB8rGBK7hJerpZuxS+q0LBG
	 hnaVVjMhoynsCUT47uPbJhoRN49FNjyPhbMdYR1TLxpmuXm4x9CuafH5ownNxqUyuK
	 F0IZIVCr5oj4g==
Date: Tue, 10 Nov 2026 13:12:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jiayuan Chen
 <jiayuan.chen@linux.dev>, syzbot@syzkaller.appspotmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg
 <sagi@grimberg.me>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6] kcm: reject attaching sockets with a ULP, and
 TLS on KCM sockets
Message-ID: <20261110131222.7e228d44@kernel.org>
In-Reply-To: <20261104183442.617519-1-rjethwani@purestorage.com>
References: <20261104183442.617519-1-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 11:34:42 -0700 Rishikesh Jethwani wrote:
> Holding a ULP also has visible side effects: getsockopt(TCP_ULP)

This part does not feel right to me. It's not a real ULP yet we will
start announcing it via all the ULP uAPI.

If you repost please try to trim the commit message and the
documentation slop.
-- 
pw-bot: cr
