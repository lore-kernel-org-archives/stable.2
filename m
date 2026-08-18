Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01C23D295
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095713; cv=none; b=DykxUu1Mt6v/w9Qnz3NL8/ZgZiaUPyGHuduI4sktoX6f0EeAvWGVa4Mb+RkSHvAAY/wYxjP+gLORORA7FeKUzO8RSuaW9LS70pLA7ZB8os6hBv/mQTrdG2eSGFTcXV7b4/2klV5qHx0ILYgQUimm17JoPYJGn6SWeOH6pofgxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095713; c=relaxed/simple;
	bh=5DJnELyziAg9tyUWTJoEmrJn3/9U/hbPAyh2tw/x0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOoUUBieOen3tOLfqgfV3baoTSK2RwkZ7+6mGtf9TJq2c52Lvp/JX7F4lhm7yn0wmQur3EHB7pl4g3/j0dwehn0s/psJzqsEoDA0o1FFsGcKQTZJiPBhbxc/bmPuA3ZZeLv/xonVa62eseh2wILYTCaPGkpvBYif+cHOsfKdrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt2OV5uC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt2OV5uC"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7c1176317so258889a12.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787095711; x=1787700511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=59jYALgU9vbLaOXzJvnS/IhFQh4MMfIkFpvRCWZoJu0=;
        b=Bt2OV5uCV29BmPD4AQdgriIIoxvWBGr0ZBzQGdPkUa1571vBmw1Mfi5EYB+q0rhJ/l
         PdwSD2oATSHP2KETudkP5bv0fWur/v9pE3UissftXUqbWTIkEflIt0VXqyoLmoAqCq5M
         4eViNbjt0LF/qWuKVP546YHGkW6ob2IJcn/c6S+Q2emHexrJoy/IleOeyc+f1mpaCWus
         qJGZcMuRMHdO6OghA2dLYR4tObyFcJkfjKUcM7a+CHYvo1T9ErrpJ/XMrdWP3yuQV3/Q
         OJkluFf6QIRTBUwP/RL5taM/SMwIJRmDLDOZvoWpWiaoIIHzh3B9yJgHsh2p/aZfUTih
         Qo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095711; x=1787700511;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59jYALgU9vbLaOXzJvnS/IhFQh4MMfIkFpvRCWZoJu0=;
        b=e0DhrAmcsApGUiUkwIB0ykh2YQ0sHvUbAZB4EDgwT8ef2drYGkVcWRveG2qlX3iHZ6
         ibCEzx0YioRbdBH2vxQsO/STQ6M1NljVfwfnvAcuwL0StRVbjgXTLmEqTHh1xtzrNLHp
         QtGFBIEuWZrVurl+HuNdB/I1olTrttWwxS2z32rqkYdjzowxWFZIl8/Cs/YTqFvhHkfy
         i4eTcEE49LzGgicPIa/MwL0odvEpE46BGrf4S/ELbtn7/PrXUkHYIrhEXHbwQUhj5ELq
         V3rl6IPlGBJc+dWENObjRIJLq/BGT++8cxax+ZnU4QSYeWFYhMHvmnK7/Z6PgvvsmVsu
         jBOw==
X-Forwarded-Encrypted: i=1; AHgh+RrQolGSeAcvA5fBQ+2wgU67GPdCknKEeJjE2zNEFHZWhyBPZh6RNkP1IsHRlOpdjwGotKkFGT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjl+SUlE4IlA07D6txZZ5a4nhiGhSFMqnTbHr4uY2+NSLawnf
	hBXIY0US6uxG5UFU+gwY4/2F4VVZVTLwToN89Fw9e2kVIvcRcVL0IHJC
X-Gm-Gg: AR+sD12uMKHSS5hwyqA56aq/oNGMiVH6KPJkVBmBw4susQh4U/b+KIe2zCPGTmBpIzX
	QF/bs5iGaKu72fvreyaOFJ9Bd7MLp9W6bqfrq6+GaCgDi/Kq78kwCGsqN70Xf2HjOdB9DzoUYjN
	83OuBMZz0IXXj0Wis4piYU/7vZku35C8scNFLX21zG+LtEUz3mbgxQ3USkTK45RFgHsycQmV7CY
	fiv6YtomOQmNazfgxrJvi8tBG6kTn+G0fibcVsLNWdUZncQIcRf47i8DSUwE6ISbj0hPMd8U7lC
	ew7DBwGuDouqzGZeZmUJlxxhKiqAb60tZiM7QDRUdRLb/prrIp2/7ibMFzxttjXzdIxumH9TJOL
	DYPQ7tgPHkk0POzFMI4u9KXDembIWb24Nhc2nsFmZZvTXAAat0UK7hAttJrCxW/jQKpnqDo8RLB
	7+GOJhBI8YEz0DN4MO+C15ApBzxBLv3F/g+bEfwpiWWWL9wRXRnL0enlwBHIHg7xngJpO/hSL2C
	9v01EhwKMBwDhweLMo=
X-Received: by 2002:a17:90b:5868:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395810b4213mr793333a91.9.1787095711224;
        Tue, 18 Aug 2026 16:28:31 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb4ffcasm334492a91.6.2026.08.18.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:28:30 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:28:25 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com,
	kuniyu@google.com, horms@kernel.org, willemb@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 1/3] ipv6: fix request socket use-after-free after
 IPV6_ADDRFORM
Message-ID: <aoTqmcmFcm70tJeX@v4bel>
References: <20260817090319.3897799-1-imv4bel@gmail.com>
 <20260817090319.3897799-2-imv4bel@gmail.com>
 <0e872f9e-ee7a-41db-afbf-4bae49257bc0@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e872f9e-ee7a-41db-afbf-4bae49257bc0@linux.dev>

On Mon, Aug 17, 2026 at 08:14:03PM +0800, Jiayuan Chen wrote:
> 
> On 8/17/26 5:03 PM, Hyunwoo Kim wrote:
> > IPV6_ADDRFORM turns an AF_INET6 TCP socket into an AF_INET one. It requires
> > the socket to be established, and a listener can get there with
> > connect(AF_UNSPEC) followed by connect(). Request sockets queued while it
> > was listening are still there: inet_csk_listen_stop() leaves them in the
> > ehash, and their timers only drop them while the socket is not listening,
> > so making it listen again keeps them alive.
> > 
> > A request that arrived over IPv6 was hashed with inet6_ehashfn(). Its child
> > is cloned from the converted socket and hashed with inet_ehashfn(), so it
> > belongs in a different bucket.
> > 
> > inet_ehash_insert() locks the child's bucket, warns about the mismatching
> > hashes, and replaces the request with the child in the request's own bucket
> > anyway. reqsk_queue_unlink() locks the bucket the request is really in, so
> > there is no synchronization between the two. Both can see the request still
> > hashed and both can drop the reference the ehash holds.
> > 
> > The extra put takes the request's refcount to zero too early, so it is
> > freed while it is still on the listener's accept queue. The listener is
> > then closed, and inet_csk_listen_stop() reads the freed request and
> > writes to it in reqsk_put().
> > 
> > Refuse the conversion if inet_csk_reqsk_queue_len() is not zero. Nothing
> > clears that counter when a socket stops listening or listens again, so it
> > still accounts for the requests left in the ehash. A socket that never
> > listened is not affected.
> > 
> > Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >   net/ipv6/ipv6_sockglue.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> > index b4c977434c2e0a..64fc6127e75332 100644
> > --- a/net/ipv6/ipv6_sockglue.c
> > +++ b/net/ipv6/ipv6_sockglue.c
> > @@ -572,6 +572,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
> >   					retv = -EBUSY;
> >   					break;
> >   				}
> > +				if (inet_csk_reqsk_queue_len(sk)) {
> > +					retv = -EBUSY;
> > +					break;
> > +				}
> >   			} else {
> >   				break;
> >   			}
> 
> Just thinking out loud.
> 
> Gating on inet_csk_reqsk_queue_len() reads a bit oddly, since we already
> require TCP_ESTABLISHED right above.

The TCP_ESTABLISHED check is below inet_csk_reqsk_queue_len(), not above it.

> 
> it's really just a proxy for "this socket used to listen and still has
> leftover requests.

Yes. I did it this way on purpose, to avoid touching the fast path.

> 
> The real issue is we should drain req when disconnect the listen socket, 

Doing this at disconnect does not look easy. Since 079096f103fa the requests
only live in the ehash, and there is no list of them attached to the listener.
So the only way to find them is to walk the whole ehash, like inet_twsk_purge()
does, and that walk is currently only done when a netns is destroyed.

> at least we should avoid replaces the request with the child even when
> sk->sk_hash != osk->sk_hash.
> 
> But that's the hot path, so hardening it for such a rare corner case isn't
> worth the cost.

Fixing the root cause properly would look like this:

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1756,6 +1756,11 @@ struct sock *tcp_v4_syn_recv_sock(...)
 		goto put_and_exit; /* OOM, release back memory */
 #endif

+	/* sk_ehashfn() must agree, or the replace crosses ehash buckets. */
+	if (unlikely(req_unhash &&
+		     newsk->sk_family != req_to_sk(req_unhash)->sk_family))
+		goto put_and_exit;
+
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;

That said, the review [1] on the other patch, which is the original of this
class and the more important one, said not to touch the fast path, so I went
with changing setsockopt instead. (If you have time, I would appreciate it if
you could also take a look at that other patch :))

Also, while testing various things, I found that this setsockopt patch can be
bypassed by a race, because qlen is only incremented after the request is
already in the ehash. Fixing that cleanly does not look easy. Trying to address
the root cause indirectly seems to bring in more and more things to take care of.

[1]: https://lore.kernel.org/all/CANn89iLN3DVs_SRrY1R7Eh1oZsSQqrgZdFSaaV3weCX3aFeR4g@mail.gmail.com/


Best regards,
Hyunwoo Kim
