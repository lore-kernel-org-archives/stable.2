Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794512845;
	b=Zq0i3Lwaltap05+VT4gVVzPRkGJh1EFcRzxOHJ/k1QzRMsFqJqiqUlFoqLpbxL/pApDB
	 eiwVlv8k8qYoP32mhdKVSVC/PRxnhCJLlFWltzW9yWGBtWzXNkDCf7SMR+JiDJd75P8aw
	 ZYtZ3EKABVdRz12LWDH7YLkUl5ZiRGTVsvAR8wcOOE98ymqSgyNADoI+DoQDcg1bm9M4x
	 H1EZBo98s5CoNdqKgjv96cP9C8i6zB0dbkqQRc8QOU21/mBRdJbNYXO2nffOqrS+X5K89
	 qwp9yClVzBuLnTe1zyFYyOd8jjeQqaTwtgHRehZ1eW5HOYFvu/z0ZS2upshvI7WtBUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512845;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=ivl2fzOJBQU4OmEbMUJ0rBy92j+Wag+ptYQzVvr86dM=;
	b=WIl3vML28p/30dvxubp7qVMlXHZDI6iAvz6nYofztNHlrxw8/I63hqyDi4rvitLIqC7V
	 x+b76fqOrlee0TTSsgo2NgfMfsyznC8hEFByIyh5n5suhY8BfKkp8nekNoyPzt7kC9htL
	 MZCL/vfYpk9cGz5IN2prilL0HeOEawZhPH+F4pvwjnA1IFwCkyjpurWEPXjLKs+8Fbcwo
	 aAMmAo5tuJGWtiMUX9fm4hXpwd6spBY+wrfvHKzWpDlkuuYsKte49s2aG+C8P9iK+9zxg
	 1tuFWr9W9bGzbkvcCALuhnA/XrvJRE0ydgZS7BOFaXLYeZlx5WBV1JLulnjyLxNyBbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=u4iLHekg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
Received: from mail-200170.simplelogin.co (mail-200170.simplelogin.co [176.119.200.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A2606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=u4iLHekg
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1794512837;
	cv=none; b=MLyWX6h41Ec0y/MPu5j4cYey2enN5wPYO9ljx3piW4zHNjnNJ2KmKY4K48d2BClOxrhQrxcRP04cFySn0whOmvzd01s1TrcZrRXg8AnGGRaZPbJBWO/KxUSJZ5tBX2iuJ4afRSe3ke6NoN7F6X/AiH3eRDYwIlsuh8cBL52jLsRpq5ZgCll/1WwApL/nbww3PLhCdSJAZBdk+NNVOa5gojY8ERD/6nFWFh7B+OOxN6ga6mBqolyzmIItzAlVvNMpEXvF+SFAitjo7AzwlqKoPzNdQz6HNYJArh8DfuMcTU4vj3fIbfa89MrpkHzdvDNJ0VPX7sIOtdUuLyjIMemtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1794512837; c=relaxed/simple;
	bh=ztgw636+7zmYYSIAXD/3iv7hAPBrWzov6S3L7gOj9Xo=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=bsv6pe3bSj6KKJKdN/wM+26csewIZoh61McZDOnoBfLluIPvu2x6QtjVQG8y0JyXOYWlusu/j0KyARyZhhJsl5MBaOsrE+0dtUtDzt/tfvc8a9NVJx2Rk+b+xvfsxdk8fH6PkndrUlLOtrdSfLqI5fJwMLZvlJixQkkZSizMaFnjfx7g9kK00I4SYQ9V8epLdYG+ofeQc3quGeDAEaRIT0E4v7aIQSuBiiTqUxYSPjhyQyN0hPYeBWVjUusKIs9BnLFcwz3XCEFWsUrLUzKu68U44Y/UB5MZqdvfZc5hrXnRZ0GvLCGJUxgG2kCn3r44iWoozvApHfwurJo5TYdy2w==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1794512837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivl2fzOJBQU4OmEbMUJ0rBy92j+Wag+ptYQzVvr86dM=;
	b=u4iLHekgFAozsBZslY5WoIUTr057H893ayj/+Iqcs57G8gj9zzgcFPIAqA42WvTx1TlAxo
	qTykDEE4eEhwHdojZ9eUKTnZX8T6qjS7P8o7IvZ9rVJzWm+wtLpiMakAyPu9OdQPpa2oBh
	h1VNjTJBdxIf3YwgroKQDcJOSHywZnc=
Date: Thu, 12 Nov 2026 19:47:11 +0000
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <avXyzxvIN3ngFepE@sgarzare-redhat>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,"David S. Miller"
 <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub Kicinski
 <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Alexei Starovoitov
 <ast@kernel.org>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179451283622.7.13355395779239029915.1767743913@eldare.de>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <avXyzxvIN3ngFepE@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1767743944
X-SimpleLogin-Want-Signing: yes

On Thu, Nov 12, 2026 at 06:23:00PM +0100, Stefano Garzarella wrote:
>On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay
>wrote:
>>The loop
>>and the zero-length check belong to the fix (without them the reader
>>returns early or spins with the lock held), so this is one patch;
>
>I don't understand why that fix can't be in a fist patch of the
>series...
>
>>+    if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>>+        return __vsock_recvmsg(sk, msg, len, flags);
>
>... I mean, why this change ^^^ can't be in patch 1/2?
>
>BTW I'm not asking to split it (at least for now).

It can: the loop is needed for the deadlock fix, since without it the
reader returns -EAGAIN early when it wakes without data, but the early
return isn't. A zero-length read with data in the psock queue already
spins with the lock held on net, and as far as I can tell from the code
the early return alone fixes that, plus the MSG_OOB and MSG_ERRQUEUE
cases. In v4 those reads were patch 2/2. They went into one patch only
because Alexei's diff replaced both, and my v5 sentence justified that
badly. You said you're not asking for a split, but since the early
return isn't needed for the deadlock, it would fit as its own patch:
should v6 have it as 1/2 and the lock change as 2/2, or stay one patch?

>I saw some comments from sashiko, can you reply to them?

I'll wait for your answer before sending v6, and I'm replying to the
Sashiko comments separately.

Thanks,
Jerome

