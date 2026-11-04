Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810937;
	b=v2kyz7Vi4xtVmeM8Mdxu6eFwelOGDmePKYOaDH/UdLhT/SGQpbCN4DvsOKduu5pjqAgl
	 ypc2cfi38DYS1+o2S45JYOjC0Lb4eL5fA1FrVGYJgpjCsOvhrPZP10/R5nGHIMZp+1wOE
	 hhjlTeCcQHj/iqp7piCPrWb5My19DNcE/dOptGeyQQufUJncx2q6XQmDebpbvNQoo1pcf
	 cjc5H5YFff3CzmcqbvKWmoJk0GIcWwTWJ492pBe2JuSsgD4VbMKdA9Dg1O71Qz50zQ0R1
	 6ASPMtAJ/FtyqVnu/uTCEscn2nS+pJWaZ+5hXpWcgDO13epS5IV9N4z/5qampdmmTyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810937;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=ZE2NzAv2taYOMojX7fb4zehQVQDj44Okng3NcbBdoFnzq/9uRB7SDYeuW+i0aMR0B9Lb
	 aGBPFuZ/B6rZBlp3FvcBf6/I1L6TfnL0talWeDZ5WIv04JP7ipC9Rt9qecps7O2yw5Lam
	 DoHVv5VeUYiiHkHREQPOH7mRuo1sf457TjzA6lni/m+ZbDh/5miT6naeWdqdwyIL6XBao
	 hOD0RUOUr6R4f+ySf7J5sEUC0pb5XDkV6+tUBHZtt3xG6gyaMsegB+fLIui3hgEEqpypX
	 DyzJVTspSAOEZt5r4K1gLkVw9F/oVmRrFfqvC0dUqUUb/5jUs1/cZxITCDr9QkFFBmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=vFIzAH37;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.161
Received: from mail-200161.simplelogin.co (mail-200161.simplelogin.co [176.119.200.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54215606D81C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54215606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=vFIzAH37
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793810930;
	cv=none; b=N0D8eoC8N93Rzw2s/p7ne8H5Qo2NehM3SEUus6xtEEucCRWTSTU4odUMAFcI5UgFsSaXgy7q8sFmjfyjhzVy/bVYpcv8KINQ1zgrEAzyJgnWJhvfoFnVcY/YkKR90hMp+cjtJZgMoQN3BP+s1/JlwGC7zMSmI1HIoeCklN15Rgruqi/MyluW/hFq/dJzp/jcAnpASpYBtVanaxzv2Yi7pNQDoM3d8jODdAvEFBMQEHnajDRVyzm2U16z/GoMlCcpzJofXjdaYu9CxLhtx8Cr09nA1Dsd+zhk6W66iN7p0QyqKL9uID9MEjkDQzL8W10gq7mYlpqy/RnxOUnluRAomg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793810930; c=relaxed/simple;
	bh=NZfHjc8GabK+5fWc9xU1eIPV8ar6IHlihuK1W6X9Wrk=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=2iqJnhFf4VrmHikqBv0PQ8K5NOhbaMGatWwyMimu1PLix+Qs5J94WbChyvcux0x3SAH+WAUU1qJ4ofY8vNqpZoR7Ov3H6ri3IPULnDIs9WCd0LeR5veg/OTMKEuuTmj5CEy0r4qr5nlZvIqv6ewEgvlUAqTd0E2EZjRJ5oDg8yrBkPm3tcbf05cNKCq789u7YsfAvW/8f/8Cape1+ghk7cbmrMHPm9Yflf4u2AWUkr7YqEXGqBtuDND7BR+ZrfS9X08NeBv9QkKVaf7IRV3fic2hXeymLXQAKaoxqYOLk1PziXzCz7cYG1wRrpGd35cQ0OpREoyyG8NEBtfrPsgsSA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793810930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=vFIzAH37Cw5VrNpmVFx3zCpuY0HMvAs8h3OdcAiJwMmK75wgnH+SUsX+0FMbLZK3Wt7ACv
	Uj6m29AHzV6CsBGkDlTCceU5UIchtfrK/FYZPU9/OH9o9Xh4JhkfGAdDtShlx4eVXFVUDG
	uVG2UKdHELMjqEsMSpM8siiqPJxdJJw=
Date: Wed, 04 Nov 2026 16:48:44 +0000
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <auSkQOU6qmj0NPEt@sgarzare-redhat>
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
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179381093020.9.4719932034061956856.1746278795@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
 <auSkQOU6qmj0NPEt@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746278795
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 03:18:10PM +0100, Stefano Garzarella wrote:
> Ditto about commit message, please put more effort on writing something
> readable by a human.

Agreed, I'll rewrite both messages myself for v4, much shorter.

> >+            if (sk->sk_err) {
> >+                    ret =3D -sk->sk_err;
>
> Why?

Same as vsock_connectible_wait_data(): an error that arrives during the
wait is returned to recv(). Without the check the loop still ends, since
every path that sets sk_err also closes the socket or sets peer_shutdown,
but recv() then returns 0 or -ENOTCONN instead of the error.

> >+            if (sk->sk_state !=3D TCP_ESTABLISHED) {
> >+                    ret =3D sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
> >+                    break;
> >+            }
>
> I'm thinking if we should split this in multiple patches.

From reading the code, it can be split without breaking bisect: first
loop on all exit conditions with the lock still held, then drop the lock
around wait_woken(). The order is fixed, since dropping the lock alone
brings back the early -EAGAIN, and the loop alone does not fix the
deadlock, so both would carry the Fixes tag. That is why I kept it as one
patch, but I'm fine either way. Split it like that for v4, with the
current 2/2 on top, or keep it as one?

> >+            if (!timeo) {
> >+                    ret =3D -EAGAIN;
> >+                    break;
> >+            }
>
> Is the move of this check changing some user visible error?
> I mean before this patch it was one of the first checks, is this okay?

Yes, for non-blocking reads, intentionally: -sk_err, 0 on peer shutdown
and the not-connected result now come before -EAGAIN, as on the native
recvmsg path. I'll say so in the commit message.

> >+            if (signal_pending(current)) {
> >+                    ret =3D sock_intr_errno(timeo);
> >+                    break;
> >+            }
>
> Why? Should be a separate patch?

No, the loop needs it: with a pending signal wait_woken() returns at
once, so without the check the loop spins until SO_RCVTIMEO expires, or
forever if none is set. I checked it by removing the check: a signalled
reader without SO_RCVTIMEO never returned and used a full CPU. The
native path does the same.

> >+            if (data < 0) {
>
> Why not data <=3D 0  and void the other if?

Right, will do in v4.

Thanks,
Jerome

