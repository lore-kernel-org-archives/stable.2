Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3B411FB4
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223447; cv=pass; b=mnt20zfCtz+kKqxaWNaaEniwIbIae2oWiQ3+FjuZxGpbQwknBPjYEuK7D4qc5oXnhPUeGfVlQi4Wsk3DFfKNGWLPkx/BMsPrwEUzoXhfk1/Im6v3J2/8Hf2sLjdZUS4J/fDYjSP1nNvOooGRUcPKj/YCzvzgH+NL8Pneb9foLNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223447; c=relaxed/simple;
	bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8E5NMNjEy42///z1/zX3ZsIID7e5aov6iDU/95LYrpTtxGkRoXhoHl60+cxC9Ong7CzJbh7CpyNICHoljUwbiJtABHJWw+PFq8lcnpAhTBUg5NalEGbGHb+z1vU8BjbKql8VG6OsQU4bMvdDJ7Lj2J9vH0othqwJqBTtVL+ljs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vH+PWZ4k; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vH+PWZ4k"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-934944f2d22so141721585a.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787223444; cv=none;
        d=google.com; s=arc-20260327;
        b=SL42CkIfgEwm5OksBN718rayRSGY1O/XnNyzJvkZ+v9wmbwFTlV9LGnviy1lxKWAHr
         MNQQLEYctF2JfMio9tA5Ptdv6q3Xqxe4IGkwVrfFXN6jv7c33N55IXnvLwmeeeGqv/aH
         7yGy66lljSOwvkKBuQwo7BlkGdnmt5rj8a7zZhUrE+eU7hCXq3BzUWHOGrmwxnmvK31p
         zfTTMSMzqX3iIULHVX/25kK02woeX6Kifl6fEhrQEySClULXNHyXCvJh27pNmdtJmgpd
         XaB1SFuFocVjdchKk+hMwGhF93Qpo070ouHCwAgMvPEXax9zGMTEvZS5UaJbebRRgz1F
         F/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        fh=lWN/hmfaUG5AXrSQgevYrcFjiFhuzEM/oxvN5Tuo1yA=;
        b=FpLVVj23Cos2Z1QQHW7dWI4eEtnOKsnV553P5rQBMUXa4E7s8RzNckLZyu0S66Gj9o
         Ty2yarmdqUVv2+uo/GTeImU6mTxSxpdlnbOimdbDlSmlFd5wlQVobM/TmecH5q7IyjMy
         Mkm92lsNDHrdx69U8iuYY7AF/ROA2p8RRyti47QulhnNWOHKX7im96zADe3XAPD6CDwy
         YghftuA5vTmw6mrVSGAigtZNlP9Lw1ld3K6dxPd0zjRMQrhq+YsnnVGn69Hhl0ZsUCUp
         seyo9WIy7Ie9PHXRanUi4vhoF+devzns/aOhqWkkIpckwj01y3ZcNM4kYRR2vh7oyhXX
         59RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787223444; x=1787828244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        b=vH+PWZ4kRaCk7q+/hoUeJPvKKLzE9mCR/GBiwYww1gvDQuQNSm4o3JABuI6JK/3fOg
         e9famN5/r17Dzglyxh57XsMbPhnYJag3eY+0EmkODlC/YPs5hbRf4WU+QVV5epNu79jl
         lfdKu4p7v2OGld7/A+GszvGy/1o9rR45TTFXC8GKzFYOUhHhg2EYfqBk5cXyLR9W35S1
         pHtjqs8wOwtr7Z9lPeREIEhwR2wdgjb0fkpWRvHw0SHxkyqDbYq350LefO/tdvZFBlnY
         hHUiatk99FC2Dh3hWqI7R0zs4sxTOZ81FBHcqDzhq82VxDhQM9Mx4NkhccH//Kro6oIr
         qq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787223444; x=1787828244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        b=Q65EZTMkdHWX/Q94zdCrkdhz3zaYU4UI/hf2uQMb+nTQVFtUfirR8bLDrDruDSySNN
         J+zTEy8XYdSCioQBJmMfixEdcLK8X8EPAkNqvqYIzgmqzqzIrnHY5F9rGiyeA6sjh79+
         L80VnT6B9QG6t2gv6mYbQbB7Kl6x90KimqIsfPM6EjOZwHOCXbNPENXGMrVuPNv5sQMV
         qFtGHcQ/tfJq0jVY8ZQO/EnQWLjMZpSyCmHn0MLcZkeDXJ+T6DLWhHM+D7OtjMPP2huO
         Tvev7SS1Ldnn+XGz4s7z366hjiDV9ZyjDTq04/p4zjSXYxt0WxsaDzrjoaGuIKx64x/D
         CKRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP/wncxX8LUDm7iOTT4IjAwsFrtBWQGVYx7rrYht+ynuhR+Hta5t62oPTrbrZETJEv3+sKRHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdKjAD5Z5MGVHk4Id7xs2AhdJE/miv0lUye6pX4iimHOcTJyc
	j6pvQ7jaD/R5ow3UoV1cPmMNPL3KdRMtgWPUzTKqs94uf8qRVic5Fwgx0aSWkQkikzTVpc5C72l
	QMCgo5/Bfj9ZV5G/OQPBGBGVWmcvLlL2/aTrkpuUv
X-Gm-Gg: AR+sD111kkBc0F4zn2I/9XbC+2+gZqw/9E6yc0YvyBSZZltxlP0qr7qujA0B1ewxsha
	+q6aUFc0y3E6Eb2LErn+Crzvv4uFlbkQ53WbhYEGTlbj4Nb7GexuvRwmTP3c3TsnJrXGVjZZZrf
	buUNmuVZf8zc7OCw9RjmzhywQtu54nZVTxQiE0pAPMWcyEV/1g49PZyZ77Jhpbc6af+wG/EgXDb
	dFxwO6DFjt6eGZIRxZiwAfW08IVO6aGkmqAvt4/5jLuU+GNVNzR3DM/FLfDF6987aDx6RjaNtx2
	RPyNiD0h7sE1tHvPUYsLMmQbhkuOGXIssHEZebc+jEtQqT648DMcO0hjuGpVJLJrvWTFD/RTGkb
	/GY4XUnZWQTdHPLtlCqmuN0v0COd4qoI2MhVHOAJhlQ0GXq1j6WfRT44eCQ==
X-Received: by 2002:a05:620a:468e:b0:930:9091:f0ce with SMTP id
 af79cd13be357-9371e302067mr1049789885a.22.1787223443592; Thu, 20 Aug 2026
 03:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815070413.294559-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260815070413.294559-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 12:57:11 +0200
X-Gm-Features: AcwNN1V-lDNNVkCSZufLYHUNnmdNTo3thCvZLBu1IvrTsUJT8e265xO6leh8BHk
Message-ID: <CANn89iJ7hfewnOEjD5SSf_3n3iSQAHN8TPspBCyp_Pvy-ibbYw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: advertise TCP MSS from the configured
 MTU, not the learned PMTU
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 9:04=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The MSS a host puts in its SYN tells the peer how big a segment it may
> send us. Right now we can shrink it with a PMTU we learned on our own
> send path, which is the wrong direction entirely.
>
> On asymmetric paths this bites - think DSR load balancers, where the
> request side goes through a smaller-MTU overlay. We learn a small PMTU
> going out, then advertise a small MSS, and the peer stays capped for the
> whole connection even though its path back to us is wide. MSS only shows
> up in the SYN and never grows back.
>
> On symmetric paths we lose nothing by dropping it either: the peer runs
> its own PMTU discovery and usually already knows the real path MTU.
>
> So work out the advertised MSS from the configured route or device MTU
> and ignore the learned PMTU. Our send side is unchanged, still clamped by
> tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
> and use them from the two default_advmss() paths.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 164a5e7ad531 ("ipv4: ipv4_default_advmss() should use route mtu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
