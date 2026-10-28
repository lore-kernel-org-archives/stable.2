Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793209909;
	b=1ayMcht6bxawAIyAPaR8v566UnHevrvBd2Ogq5vOuVHxlhWWya2pxZT8UKWrql9LxSqp
	 yn+AxBc3LANZg5A1MnDfq6slJstxzLqCVMWgZh+mPfBjCThp1TX6mZ/GggGQV4mfZcg9a
	 asFdiqsFqdvjYlpvBqDcXFHrY3wZE6TfaUlRwvzqLVtJ10arooUVV0IUDrvNTpOnSudJ7
	 w763k5spW2zwL+RfAL3T1vtin5rhkAUsBlZEfCTooVSWvT6pQpvceUBGAEtWGawBqMCb9
	 WvJy73ehD2cdkHsF7xxHVXWevp38Z8dXpOGKtrKxq1lQ2v08q+ThcmmcrlyCgXFih9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209909;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=fmazTGtR1oDTSrNKrvco0aIuxQh0Wi6ZbwjgI0VjrSs=;
	b=dotPqjlKTJonFdT1wvbfYpQLlSZyvjmARkBQAhL8iuX5fF/M9Ygv40knVkErobxT72Sa
	 6h3jIUio243yjFIXhLNEZLs6mW/QSfxQ6H69q7lWgG5690XoJSFeM1MXo5iOBUTs0OpxW
	 CCUn+o7SQZ8flbY0wp9TeWxOzTiTpnk9LR73mh+au6cp/UAo2HTjYaRXoJadSXQ9XqVQ6
	 j/kdnlEAByfZ1HrIGHpmuIlW3gnQOhCthW2WOAQVfOMPfgBkqULaSnwcOJxc7v9vW2XKU
	 wydpklpicQZ3G378Z3fp5qmnn/iWbHnyG3Sm8btjJ1HrbbTG1nt23iRitEasU5fBW4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b="Z8qQZI/w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.165
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A06606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A06606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=Z8qQZI/w
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793209901;
	cv=none; b=w5kHItFYRgf0g9MvnjZe7Cgf621setVXpYeT9kQ0m0yjzjlD7z34JJHDO5E38uSIV3D9ndGMrv40YV5i1vSCwNsq0O67GBuIVFvwcarptIv/plI7591ILvQdNSiubM0gLii/SYkiq2caoQSv90/rEqweq6f9yOg2TsT9U+kV5M+dtnzbjhaWdO3Wbw+gnRbb0jSvxXWUR6JvUNew+LGM2nD9bmGv3KljuE1/JVlW7pI3P9cvRI0FjzxlSWZ2bO9PqCaGOeguwN622LSCWknVclvOyIk+y4E9WpRxRWBG9lUU1IXNo5iWP/rqaG4NPWctf6E7dEhDjKHKJXg9pya7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793209901; c=relaxed/simple;
	bh=fmazTGtR1oDTSrNKrvco0aIuxQh0Wi6ZbwjgI0VjrSs=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=aYj6zSTy1rXZDz9VTD7a+MZLGDKnSDyN2IjgCJcp2zpZHiVaxhGeJ89NRKVE3lbqzyF3vDM2TGOBMUb8PwKfC7HFVqP1Flq/bFJ2mwc44L40N/Zt5RSM7V+R4j/OmyFn31g3j6rMZJrSH6fcOwPkywvp72nYBwZ1Qh2Q6BeLtgv63P9m7OFxhVF8W5emraQD5vyr3Diu5J8J7rUycLapopnRLUupBboPOekhYE8GygAPIL6jGp+ytzlWTx1srywJKvztn6P0tAB4ENNN/ZO1Ou0MZFKlhzmV+HDV5falwHPqQ9IkJBq75TNmZACdx0Vysh8IqYik7HWW0dtLW01QGA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793209901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmazTGtR1oDTSrNKrvco0aIuxQh0Wi6ZbwjgI0VjrSs=;
	b=Z8qQZI/wnxpX/I/xd2ojXpgrNV45+/iBHyDxTV0TF1zedRb2ARjUmZv93wsUZBAjEbBxrS
	DfMbTodP+x7CsL1aGdN2L/P6blvgj1jMZsGuiXFcYltHLmscza4G2eIf0iEfAUOnIKIdxb
	0mtmCCW7kRnU+7GELRe/aw6qfo6apdw=
Date: Wed, 28 Oct 2026 17:51:33 +0000
Subject: Re: [PATCH net v2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <179123556339.434549.8635789838298158117@kernel.org>
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
To: netdev-bot+sashiko@kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,"David S. Miller"
 <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub Kicinski
 <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,"Michael S. Tsirkin"
 <mst@redhat.com>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,Michal
 Luczaj <mhal@rbox.co>,stable@vger.kernel.org,Bobby Eshleman
 <bobbyeshleman@meta.com>
Message-ID: <179320990081.11.17283545588831385663.1728119957@eldare.de>
References: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
 <179123556339.434549.8635789838298158117@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1728119964
X-SimpleLogin-Want-Signing: yes

On Mon, 05 Oct 2026 21:26:03 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Can this loop sleep forever on a connection that has already been reset?
[...]
> Should the loop also check sk->sk_state and SOCK_DONE, so that case still
> works after the error has been read?

Yes. I reproduced it by unbinding the guest's virtio-vsock device under an
established sockmap'd connection: after getsockopt(SO_ERROR), recv() waited
for the whole SO_RCVTIMEO and returned -EAGAIN, while a socket outside the
sockmap returned -ENOTCONN at once. v3 ends the wait once the socket is no
longer TCP_ESTABLISHED, with 0 if SOCK_DONE is set and -ENOTCONN otherwise,
as __vsock_connectible_recvmsg() does.

> [Severity: Low]
> Should MSG_OOB be rejected here as well, next to MSG_ERRQUEUE?
[...]
> Rejecting MSG_OOB next to the new MSG_ERRQUEUE check would fix both
> cases.

Agreed, both cases reproduce. v3 rejects MSG_OOB with -EOPNOTSUPP before
the len =3D=3D 0 check, as unix_bpf_recvmsg() does, so it neither returns 0
nor consumes ordinary bytes.

> [Severity: High]
> This isn't a bug introduced by this patch, but the patch rewrites the cod=
e
> around it. Can a blocking recv() hang here while data is waiting in
> psock->ingress_msg?
[...]
> Should this fallback also take psock->ingress_skb into account?

I agree with the analysis (from reading the code; I have not reproduced
it): vsock_has_data() counts psock->ingress_skb while
sk_psock_queue_empty() looks only at ingress_msg, so data that is still on
ingress_skb sends the reader to the native path, which never looks at the
psock queues. It predates this series. The loop adds one more way into the
same window, but the fix belongs in the fallback condition, so I'll send
it as a separate patch.

v3 also splits the change into two patches, following Michal's remark on
v2; it will go out as a new thread.

pw-bot: cr

