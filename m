Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFC40EB90
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765002; cv=pass; b=QjQ/J/KyMhX5ppzjeKfQUbi8L+SaSkf/MmZbtlClaz7GHP1BE5uE/mmffnb64a9bW88UmXYG4tYy5VPsszCdBnm1FT4DaZ3ZclSxY9/R/FNg0VknJ8hNoO/+qmE5b4StlVnJAsWiK8/PNRhtlvShWIK9BW37qgsLeuFE4HphHAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765002; c=relaxed/simple;
	bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMqKUSE7iysHwtELSqpsgeBRBIRlFoCjr3X+YwjdR7nluVvrZucU9zgGatkHW76mjN8W1hCd/Ad7hOeWWv+GwuJ5doZg3cZq6HtcamzM43GJWNrgU8l/hjEslhUxL1VW1Sx2bFjUu3E2eZ3iGRdEgng9DJ2nSHjz3ILZxBGTqtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNDwjwAb; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNDwjwAb"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5218927884fso49454731cf.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765000; cv=none;
        d=google.com; s=arc-20260327;
        b=nPvlBVaemJlb3jMwkN7WVEFa+u7GSoq+3QT7/bVIn8VBN8gllekio4AyPu0zzKx6vq
         ieFtLQfGUClO03Zy3BFHuVnTQIWDAP5sYCyVZ3KgtDxAL6lOpNIDStNGe+RSTUXetJ3C
         Zo1wlKxpPvkvoFzKngbb16JP1pXsdc1fQ1vc0sfIPAk+m6XIHdG2+BFuzFz0WF2dSi8A
         1mNx3+kXMndNRTYq17zOtpc601iooRKMwUTn9A6i8Uw4R4icZAZIdg3ZrWTabNyeaxCv
         F8gsg2Mce8PoqcVxvbdL1LU8ChxnOXYGjM/MOX6JCO+VCfdcctwpHFWWthaqBqSNb6d1
         287g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        fh=zHZjHV4yrraBv4/Qz6RfcEygbHPOpAWO6aHCgEDz7ro=;
        b=gyu1JQaRmEGOq/TQjjk2JlKbaMpjVoPukAVkvbKqDANqB0/f5scVuyLWM8QH7OQlNo
         UYyO0KuCPiKw7FLYFtG0cD0lpnmRL/mhuzsaqAE3ID7vEp30EyftRKomShh2p30S+V/j
         Vrobs1AWPFkWhqtXQo3H7C5vP2anRnJ8RY5tfYyltA8G3OFaL7ymSfYmmHv0/G7XX2Ya
         sP9wnKQ5D7RwjlOvpmswMhVF81jH2BQ0B/Y7fLaoFM8hCTxIV5YkwE9eKe+m0FKsD6L3
         tsS8FprV3mKVRiIugrqVqV8De5Tq1RgimC2QKYkDMUeBVbmf2T0vh27kV0aPaKOmYK6R
         R/GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788765000; x=1789369800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=DNDwjwAbwLxb/vjqZoJ6266SI9OFz+CRF20kRsRaVJQF1iCzpn8hwIZOEdh5VxTZFm
         ue2qn5tjAgvNzIU5F2Tl+JsqdGB56h/wwC536s3/ZAf8++l17XanvmPxS5xttFqpnAYL
         FXScekSslo0iG7S03As+qjFZgLjY5YNAgYRQsiKi1ATQuka7TktN/3BcmwsKodS3fnMx
         DqeiaIIGei+5KOcvV7E7SEPPFPcsTchO7kXhI7DeOJmWO3tNqIv9IHa6UhXF9UeerPC3
         nHkXebvBvxJl+4sN5kw60OfI02aCZvsHc4eXW7Vi04ALTrk6PsVOKCF7C+s7pQ7D0xZ4
         kinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765000; x=1789369800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=dE39ohWUCnPN0AUBqiaHF6BnhPvoDzdsLQ0tDskbt4fkt+e15eGVriSaPz2ji4Pee5
         NiGh6ryWvgSY1zG1Bh4LNc8C1U4nIEl/Hnen8z1jW5aACE1CvAr9qwRwYrWUQt4AdWTz
         LGXlHNM5V7Wbuo7RC0m1qzbUx7a3Sz/qSy5pRFdO/KL5Td9LePe5izPtfX5hu2vRUXDD
         u5XoNmfbvR3j+5t2B6n0pfU4gEZ9V7lVgV6A3/l+DRXhYy68ILL5HJNSh2JQ9eCV2y0O
         TskNXLXD14GYy9VMnD2oMTyWVXiy9Vm8S0Dr+vpetEYrxA+qIBWSMUZaWR+Xq92NJL8W
         K/Zw==
X-Forwarded-Encrypted: i=1; AKwUvByQWwrDWteyJMxmFisaCB+qEN6sOLiogFdln2F1KTWIM89DBevTPxk4hU+pFz0Sw+Y5G0z35uo=@vger.kernel.org
X-Gm-Message-State: AFuF++n2CtKtM4zXgEUHyTkzBopZgC2HNbfFRL2MG7TXQdg7rdzAo70y
	DWs+1+ctkIQujRostB9JjZkKCDEZ/Kdp0+t7OA6I/lGN/D+GQGPkMyTHhZ9T+QwSPWw0ECkQCAo
	/jpn5zWVrgnJsky2LfBAOSi2HJAy1bxtC/hm3cFey
X-Gm-Gg: AYBFou3mOaKH5w5tC2HBjUC41NYgDuiN6GdsSO6D6hEkZrax+Czv/Wg8XOrWbrvbvNH
	OrwtyIWesKveoZbDrusaEBNlU/dtbefjC3ptRigQ8I+O+WNycFzPr4c66sch+Anolf2x0rzSOVr
	yl1JalZNAoZVeYmc2nXMrkluhE9qTEfd8PVB1teIb/+zDdgPVP9xxl0xCB22crw+8KHcaG/Jpff
	GkdrgiDymE0ySfJ6304X6Fr/hOYr+hVv/c5P5wSRxMaOxs8Uu1dIUEXJKVPHx/aQKH4BH9EKwR0
	hCOuAstS2ughulQ9y76NylXP6kU4xiq2GXFLiVWdMVmEMZ7+dF9t1d7dwpq5cGfP5xk/xs1mWO6
	FMSs44QlnK93J2IW+8QhQQXQsRKogLt519U7J3mJl8jq0lAsy6pUVCnFoFbsFGvfiRGpR
X-Received: by 2002:a05:622a:1f98:b0:530:31c8:a302 with SMTP id
 d75a77b69052e-5305495da66mr256081741cf.23.1788764999462; Mon, 07 Sep 2026
 00:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788248601.git.zihanx@nebusec.ai> <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
In-Reply-To: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:09:47 +0200
X-Gm-Features: AcwNN1UdIl3PlzbDUGiFbT4WHqVNX_a67HKQKn1qGUPRwr6NlLZpE3hbS-2nlZ4
Message-ID: <CANn89iKzChGpDLsJ6iKRsMvHKdW6r_9xvkQv9g6bTy_-Pt8xOw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Guillaume Nault <gnault@redhat.com>, Florian Westphal <fw@strlen.de>, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:54=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> MPTCP listener diag dumping reuses sk_diag_dump(), which executes
> inet_diag_bc_sk() before filling the netlink reply. The listener walk in
> mptcp_diag_dump_listeners() currently performs that work while holding th=
e
> listener bucket lock.
>
> The time spent under the listener bucket lock can therefore grow with the
> number of sockets visited and with per-socket dump work. The resume state
> also requires later batches to revisit the bucket prefix.
>
> Fix this by collecting only referenced listener sockets while holding the
> bucket lock. After dropping it, re-check the listener properties, obtain
> the parent MPTCP socket reference, and call sk_diag_dump(). Keep a
> referenced cursor so later batches resume after the previous listener
> instead of rescanning the bucket head. Validate a cursor against the
> current listener bucket and TCP_LISTEN state before resuming from it.
> After dropping the lock, read icsk_ulp_data with rcu_dereference().
>
> Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

pw-bot: rejected

Please limit the complexity of filters.

Anyone needing complex filters will implement them in user space.
