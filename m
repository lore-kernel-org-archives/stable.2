Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522938;
	b=dyRgXalI4AJ4HuVH7xHKL72gKoKoZ9mCHkQoyU/0CjYkcc6lXzd1Bey5Bj8Lrvkxir6V
	 YWapO7Tzusgopt1cupq//lrxxsOc+mpIQQEhskr1ib+0IQp0EQi2bsd5TaEf+Sa/nWggN
	 wY49OX4Rys17pEcfRusU2IGGE+NrdlYRRxDYsZYdMOZ1qAFfpPG9q8FwaxH6Ai9XnyXJG
	 UAl/u4feOe8PJ8TC+NgAXVl7YlxiBjdr7EWc3V2X01lp0nQ0S34EYp22nvsiIxHV6vScM
	 FPmq5QbZxYfvc8aznA28YnqhaQ37YjxmeLX5f0sLEWSDgCvaJhnr4oYR4hGoYg+gZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522938;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=MAC3MjW2HkLElUNXBYu/aiadpeQcZyC0ydUhewAODQ4=;
	b=3mpvaDiuEUjzWUa559jlIZnKNqLfSKJgCVOS9LwEbk+aJE7v47cvKGBFknJfCGBXMkDI
	 NfdIZYJAx/4KTt9IdtqnklgZVaJBBIzTcHI9BwFUivkCLxkltjfGqhEvjezMRLDCBHliC
	 ae1bZQf8fq4vxDBCbNXCRRYeAClqt6JbRmnkMcuyJaqm7fPJJKXjfh0gk+inqN9yPTXCW
	 0lAki9gRMqTHatFmBPMpBTqEUdZ89P/49RAEBxKT3hYCcbgrOmNBkUvqPfkwX/O/iXmf3
	 nuXaXETy68/2NyqAe/a8kMvAQNPGAeZWPbnA5eFDEVShPnAKx7JsbJIFC8NKZtUJo8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=MEFygLbn;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0281606A31A;
	Tue, 20 Oct 2026 19:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0281606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=MEFygLbn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MAC3MjW2HkLElUNXBYu/aiadpeQcZyC0ydUhewAODQ4=; b=MEFygLbncK7KUHhg9Ph+6mYGfv
	IvvgUJIhgp9tzDFUKBF7Kk4tlldUpoUttMNiLlU3z/bTD7cSrFdbUVUlCrrZljVT6b+uhDmlGA5hM
	wOunZ3Qm9W0tPhbZtW8QRylBxWf0NQZ884lF4KCgMjAR05Do1lwKLiAjQfGNqL5VABE021z9v3VJs
	ygPbU/7Hegx1SLijNRezOxvvc2yVxlo4JTepf5k8OniTzAVtcPr10gB9N/TbcLXpKfzE6z1P3u7mP
	Y+Hvd3lN/lIeu5mZmlJSB7FjJIf1FYHKtA9ki+IJJQVQ3AYhcN9IV9bWt8e3gW7eJm/+lPp/IQ9AD
	HJO51oNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJF6A-0000000HHqw-2FEs;
	Tue, 20 Oct 2026 19:02:10 +0000
Date: Tue, 20 Oct 2026 20:02:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <matt@bobrowski.net>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <20261020190210.GM989762@ZenIV>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:

> And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> that current->fs == NULL in do_exit() breaks d_path() called from ext4
> open.
> 
> can we fix it in d_path() instead ?

Once more, with feeling: if you want a pathname relative to your chroot,
use d_path(); otherwise, use d_absolute_path().  If you don't know what
the difference is, just use "I don't give a fuck" and save the cycles
(and avoid potential infoleaks, while we are at it).

Folks, it's _not_ just about an oops - specific callers need to decide
which string do they want.
