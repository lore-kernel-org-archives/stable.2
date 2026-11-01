Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793548471;
	b=Xl4WjPHYvV48S9a3qLdzWbNrOFLs6WlxhoEEV96fBN5IlY6lS01JXajxVmNknQRb4FRq
	 9Hc48yY86kbQ8SIkMHchQCCArBPp9LflAaUh/3LwY0SQLljjjKNdConnY7sK6FtPhQnzO
	 BjtW7BE9dkw/Tk1RQnzAaV6cDIScIhALy2rOyHLsr10Ip3SS3Z9P1SRVIZEWbp4QVLVFr
	 bjEWkZ5g6kAj6NFUpC4WlZYaQJtghwW0r3n6md2gSW/8Ln/mIFhSWX3Vlk8Q8pe8Gah4W
	 S15jt+KN5u1w/eK/SC+ow5tHfK4UFotGaQLsGL9auyTaZfu5gSzrXhOB7aX89VoEtCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8Ol42oqNQB9bpHXLsAG3YClpLWwidNzN9Gqb9wYpJ9Y=;
	b=emhrGFVaHvW3/Md98xkHoeCyNohCxkr7SlCaqD9S99BXywWkDPe+tBdMPFCdnuz9lhzm
	 +ZCg1AGk9nIeViR5+BtR44T8XlJXQYEnuLm8VBzpqk7YZ9IBzAQNvFuzNFNBzscdRUVKM
	 p5iVR3kIB6QBAkYSKySnX97ahVkIgd+T5849EUxKMcUgY8EruwRyWKt+C6ZXR18C6o1gv
	 q5Rw0ml92Pwmbred/QEMXf5wNKu83D8j8xFus6CZnVWvFM5AEfF+KHPtdzgL5PTFHnRwV
	 Jk9ULaIkkhb10bkQ7ImBANfpH3wsyk9bqjgxM1ycLJOtnQTGIXZIAwIQGWAs7tZj7hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okFL4KW9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F9606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 15:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okFL4KW9
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a1947498bso1156126eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 07:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793548470; cv=none;
        d=google.com; s=arc-20260327;
        b=Cfnq2xCtrh13KmT1Rc65dH1vrciLsXi8ZmlTwTKGJwg8ceEjkI5MXaz8N0IoiDgTkw
         rRmw+nXi0U2ZyWOWa9qHNWD3QvJFL5QwI4W3G7wPndATBOv7fLN5e8G8Pf7A8swxPT0f
         T/P+AUK6+hB9eDcxxQA+2nBstWn/16HFNM6x6rYKyoqyJ98rkJx00P2Jtd9vYjwj7obK
         9M+K2M0gvc0aTWBtJqIixDQahKrv3ZwMWKqoKML51/MMIxPn17mwz8tIzzqjrEuo8t+1
         HCw4ZrhQ2p1R5GUMNduBjL8uo5dYNkVsWX9SHlxGj9L9Uc911EMZlUtj6BH+/cjqUXbz
         +qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Ol42oqNQB9bpHXLsAG3YClpLWwidNzN9Gqb9wYpJ9Y=;
        fh=1qz027Ebmo73NmXThqkgZT/ai+xfThhIhFDlqZONSuE=;
        b=hTm6BWmU9RwxutoQNMU0OZaznmtne+hKslIHc0+GkM6g1ttQNJU/4FcwEPQLC66eW8
         hEAtZkX+awl39bSfHLToDcTzawLWtdX0RteAhFFNCRWWUTNZX+amWHCRqg7+g4DASQTv
         q60reuY2ky2IB78atHmSYKUwqUii7sv1wDtYE0dL/herkb3dL6hpoYMbeW7cXTcsoK17
         HLzGfoZa/WXZcrPJTPjpa4ea7AsZveZ64TvirjJgT3M8NSdIArAOkX/E2Vn/eFz617pS
         n3ysU6lxm4au/IMGgNU9tRN7reEak83eOi0TlEzTyflzmGaMEnz5HtU329kQDElSyK1g
         LciA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793548470; x=1794153270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Ol42oqNQB9bpHXLsAG3YClpLWwidNzN9Gqb9wYpJ9Y=;
        b=okFL4KW9F/hRBawGds3EZGCybauFp9RxsAmEkkieJx+uvAqcSmWR+CdYbiNCjnIVt5
         BDFKGPdW0PAdmLUSvA30DhawcdbMwdgHoXQ1O0Ll6b4kN9lc/3VFcDJytgWrZJFODTO4
         zF7tQF5LLuvcvAeVpZm/wW1iF5MS+e2OqOvfyRofB894OhLOZ3faVwC0UesSQ9z3gdJb
         Tctw0euGgHB1Lx8vIMNnxYR/Ez32P2O2nrFzzptzoq7KgaHbvxZB8RH0bkwbDXQUk/1K
         +8TwBY0PdUe0Dp8wbGliFSjseD6IGcqObUuearPdJn3ffAkhMTB/Bn6mMiso6PD/1VOM
         6jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548470; x=1794153270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Ol42oqNQB9bpHXLsAG3YClpLWwidNzN9Gqb9wYpJ9Y=;
        b=wBrUI47eHd0c1sfk9wybQ1vhgdFZSpsYshT8zTxLZ1xsa+NJKcmQoTJCcsHaZOiaHs
         bFAWoC5COXkWkVGYXeoujSQpHujzs/oLk6vTkWmSWrDGNcoubVKdmFbrf7nmUz1bT+GB
         TTiauTzV+avSzSS/AM46AKRoFv0QqwNQVA100Qq616NQN9sMYFMMZXqMO5dxWBxJXDyp
         bFJGkiDXenm9dHkqmdxSuKYXFTAFjC0B7zuvLx3AFvgM7q9eIaQM3fD7wmioQ0199Cro
         KLBhzNbQ2dE9e4FJf7CVUEKVBdcWBsIOCsNjwMKQ1zYNN30/pH996xEKnV4B6DUTpDKH
         8IQA==
X-Gm-Message-State: AFq9FYLEDiwqCQok7UJNPQDLqOTdQVrPl8AE01H1YYdUYlB6vYo8YvVO
	K74muGCchuz+GuKgTvUfj135XaC2A9TZTDImxWSqwXmum31vjuq7l2Hxv18iMA1GY53MYJG7Ngq
	NCUxiP0gdsOXA0kYT8q1kACotk01PzA4=
X-Gm-Gg: AYBFou30KJMft8tFCIgPFwbFQIWljKFqkmmbAe/Hdmxg5pjUDoxA7B9tnT/dSP6Qpji
	Ppv4HRSCCvvfPp8C37AMkezoYTZ/K16NvpHP5kKrmoXsbueUY/P9s/LGTII198+QB65DrITsT11
	z+UP1XY5gN0+MzJAqFihcpiW8z1o8v5C045EcNJCz6fmteIFFqnyHaNss4eYTwIkdcexx8ohqo8
	20cx6ZbgqBFr7xaQXoIUJFPI63tHO7ffJ9+WeliGwi0KLGFhG/w622Rbse5ZbNHoiUjNyliPZfb
	mwxRBk49+emk/AGB/W94R3sC95Us4XGQ17i9jH6WF7HXeJ6JOXYyoGkaObf+22oWjU85DQiLuee
	soKUf7TsNy8JQjmTkXtRgaRMOHxt0TfqPqfKtmd5GHRoQEmtA/HZfSTVqqPKi5tF/XjJb11ZHWC
	AyXpjVNJ9FV7tVmn3oXS7mQxJxSA==
X-Received: by 2002:a05:693c:4151:20b0:36a:f99:ae79 with SMTP id
 5a478bee46e88-36a4232f3f8mr13332360eec.7.1793548469528; Sun, 01 Nov 2026
 07:54:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101-nfexp-pair-6-12-y-v1-1-56cef5744745@gmail.com> <2026110153-headfirst-rift-1d96@gregkh>
In-Reply-To: <2026110153-headfirst-rift-1d96@gregkh>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Sun, 1 Nov 2026 12:54:17 -0300
X-Gm-Features: AclHuK8AXD9H53KSgzNVUTodqPaN2_tNYg1yHV8DPG6o6d5skT37RG4wQLh6XnU
Message-ID: <CAOCBhwFHdydRCh87VNAnTC0Bh4_2NU_77zViQHUOF1QC_XP5pQ@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Jaeyeong Lee <iostreampy@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

6.18.y does not need it: it does not have b8b09dc2bf35 ("netfilter:
nf_conntrack_expect: use conntrack GC to reap expectations"), which
is what makes this follow-up necessary.  In v6.18.60
nf_ct_unexpect_related() still unlinks the expectation through
nf_ct_remove_expect() (net/netfilter/nf_conntrack_expect.c:292-297),
so the SIP/H.323 loops there are fine.  7.3.y has both commits.

b8b09dc2bf35 is only in 6.12.y, 6.6.y and 6.1.y (since 6.12.114,
6.6.160 and 6.1.191), and those are the trees that need this fix.

If b8b09dc2bf35 is queued for 6.18.y later, 4aa63842fc92 should go
with it; I can send both for 6.18.y if you want that.

thanks,
Joas


Em dom., 1 de nov. de 2026 =C3=A0s 12:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> escreveu:
>
> On Sun, Nov 01, 2026 at 03:27:30PM +0000, Joas Antonio dos Santos via B4 =
Relay wrote:
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> >
> > commit 4aa63842fc92de1bce59d4709a0d32e718890bb2 upstream.
>
> <snip>
>
> What about a backport for 6.18.y first?
>
> thanks,
>
> greg k-h



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
