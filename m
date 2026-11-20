Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795213579;
	b=YvquXASea6IgooJuw4K/m0c6185Fs8NUhVRHebFM8Qe3qAglSNLdh+5jwMPosjxdCcsy
	 6D5vvqz6C3bQVBKFq1BGsxa0SJZ1eomlRljlZGn4jq9VjMGU/wqk9VuTIbteKOSngn5fX
	 fYJ6ZBlepEAK/1pBxnF9BjHs8I+OpGPg6Yoy4nyr/2tWsFFbh6kuW4LxQBhKCTz+imlGb
	 rQuajwUUO8wVzT68z5ML0D+2POTXugZLz7KUqgA58B9qKSWNhL3qHa+Gtvohq5RCyZ5Gz
	 MaEXI+1FGQVpOanw8bjDLHCtB5gg6WHwTKR/AcAopmV9jeD5OiIH/91ZLFd+lZZlPbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Tye7LrQ4gNYOB2WmBMU3D2E2j9Fo/YYB1XWy/GBCLfI=;
	b=RsqL8TmtFSuCdao4v1mLkQ2jAWZZHQ1w91S6B+sMCjL+TNCZFu66+Ilp9LOAgOglQxpz
	 DAqDAOBZMFoDRdWCOT7ABhsr9cYJeH9U4HTIpBb5uzQDxi0MoH/RMS67YoGXWwS3VdS/c
	 JgjrppmkW5Ve74fstox6HdB6+Jw3j2NqF/Ne6FpxOv+7ZnlJf9unMwwJmeKrMOCPUpxza
	 jsK9Yun2oOgUyqrIN3ll+8L7dFZLQIGATvkkDTE7PyFQ152+wd0WyuEtX8VzxjbN8C7i2
	 1h5h9hRRfsZYAcFsnB4+IQUe7L8W/89xFW/9gvCj1HpRp23BtCajF9aMOB/iag6BemQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j3mZjb1k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202B606A68C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5202B606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j3mZjb1k
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-86156cf8a7eso1915416a34.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:26:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213574; cv=none;
        d=google.com; s=arc-20260327;
        b=PgopSqqPW5ipqGgsMon5xo+3tjtCYEz04Nep8+VYT5sel5r7gM1YoLNfguu7YOgdzi
         fqcqlw2IHVe2UPFIKGjdx3ozb6CN0O6TkUdnAbsjhkUe+Ci/eoOiJGcCHJcPXT2Ab61i
         7KF7Qq58k7slKL9jztl1hF9CJT4JbilwDrDPSeuoZmMJH8z+k7YprHsOz1kkyEze2j3E
         zyzGMw3AlqLwkG3CxGHr6iae3GO/mH/3E76XQV1ylV2UAjgMHZqORJ8Pa1uqiafJOU+W
         LWfYAA52HTyu2aDDf4gQvH4n2JKnn9Gqqpn/PKA/xdVG1C3q33q1rrmrj47sqVlZxqZS
         JKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tye7LrQ4gNYOB2WmBMU3D2E2j9Fo/YYB1XWy/GBCLfI=;
        fh=52YcX+qVKQwCU055rT4md/Ug0ei8QXkxTYUHbRoZA6A=;
        b=K/Fg/5NiQFR6rN6AtU1iWT3Zp8PGL8QNVlrq4LpamjqYl8hhKVZrauW3AyAL60xDT3
         GrXzbMJsJVwBDHMGw9Czyzlz8SDZgSV7M24FJupi2cBTA/VxWZ9gkpYNnrW8p+lRomkS
         fckAWoFJeXEpos+et2iuqk8O3wfvrnFEv+EYVnWsKVyml8ddiSNCdmK7EB3GfBXXv+NI
         rwOYfMpNRZQN/Wsf+68Fns+YF3YER34Bq73JFQKywIFhpyAMyeYvzpyogfhB3/XhaiLL
         VDMbvNK0jTMa1ZOeTuXGQ7vs2s3sSHRlsczLX/V3BSjPK4DbcnFgw3ruhLBC+wOcfFh8
         x6qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213574; x=1795818374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tye7LrQ4gNYOB2WmBMU3D2E2j9Fo/YYB1XWy/GBCLfI=;
        b=j3mZjb1kO6H0mL3bzn6Xjf/ysp/IjwU1PXPYeNPXZBqIe1cpRmCZTskCW83KGieb4b
         ximN4i7a0auok0eVqJPGV126AXIpMRJanH0TQYao24LNm2p3nTFxc+ZfsXzDELM9AiBL
         DuqKRczUDUDulGpnU5hmqYyL4lQrBvgUJbI8aQMm+veQrTheZBXexfeD6U7h1dM2+LGD
         0KCr+SrlW19veEXwLgA2PFf+hrVqJCLTMsnsirtpPIqYA+40Wn0lcV6X8f3KMu7rzKa8
         E3rMwsbrBOKLJf6tB1VA0qKeKnzSyAygF1xHBuA/qL/8bxQmIpCSi6aRHQTAJ8PuagNJ
         0RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213574; x=1795818374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tye7LrQ4gNYOB2WmBMU3D2E2j9Fo/YYB1XWy/GBCLfI=;
        b=DKFy6iXO7SkLrsAyDVPjP4pVR1wwbaMVf32RPYriajNwj3l4FrzkIDs5JJ4OAkuOf7
         2dUKVd51q+/qrnmBvQbACJXQLrgx9S3IAZBcMgOYrdpIwO4h3Y8BTACptbuyDa6Xjpm3
         NCmtwbScvRqYX0lT+tsb9BugmTxvz1j7Whs9Fn7bKJfiuzmYmBRvsuA9JmKBmAw7nEqr
         FyowhS/40zUEMSmgmeQgwn0/RszF+dG9FAwOtQrkpqAkNQ0vpGuud+lPhh7Jq2CrQiKB
         lBHudzVJlmONtruPdEoQEsQmlaiy+p/MT0+woI8QN6Wq4TBePqTXoXH0gtiG9bhc4x9u
         ANfw==
X-Forwarded-Encrypted: i=1; AL+hErG9E647cB7wvJq1rw9OdNvbXmLuVfDbUv2MIou7tV8BNgrTZca83NMO4gSOVh/dACezNWSi6fU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PreLtfkephbu83klho24W+VOtoCVmoa0Yh8qDC9URGblYHiOB
	gVA1dyZZ2OFFY9CpwIN1ihNrauFPxiOtNyrDTEnv1jG0sepnxYhuwcP8w5+xnxJ5RLbl0HJRH8d
	EnkhuqMyLRME2VeyWIKf6h6zeY46lozVULp/cs9LpVU9QzbKSedTKdiMm
X-Gm-Gg: AYBFou06dYDkTV/qvBJh11oqdslJiWf6s849MklOCzabMgA/2SjjzBuKs9fIe1y2WhS
	cGTy8SOuhy1xv+kreg6V32a5znSbpxx0IXJiqvGZfj/K4vsFlo3cRqS5FCIg2Wr4XwNQO/yCD2m
	6K7Tsw34YG77hb8MmHHzGZaNBBg4bzsP6A0sbDKvCZW6Ufhni+GTlO9rLEMHYU1Sga0i+sxCM1Y
	98hzKqY2t4m/NWuE+4tCJ07FFEdZthaScMXHyf0lUm9K9t6VBbFlfFSv/H2APsGAIcwrf/pMRNl
	fKkn08JDQTonZoqv6Oy5rWG5hgsD4v4ZpQE+4IaWtvcSzrQcqe+CIw1YGuvSD5dI8Kud04n1tla
	iiTbPVNkLfwkcGIqnB8z4uuRkrPtCrD8pcHM3TiDy5TE4Xk1KUsNP77dw5XOHmuueoho5zg==
X-Received: by 2002:a05:6808:c1d3:b0:53c:4502:971d with SMTP id
 5614622812f47-5797d6af383mr5058486b6e.36.1795213573342; Fri, 20 Nov 2026
 14:26:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net> <20261118-tcpm-soft-reset-sop-v2-1-b6decdc95e66@flipper.net>
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-1-b6decdc95e66@flipper.net>
From: RD Babiera <rdbabiera@google.com>
Date: Fri, 20 Nov 2026 14:26:02 -0800
X-Gm-Features: Aa3M54oI-5EGpqjWcL7_ouoCleZ14wJ8wiVioJZkDAZdFUGMZJh-W31xizK4Ug4
Message-ID: <CALzBnUHZXuV68o=Y6aDAbG2b=u98aNJXvsP0fi8ARArpUPupBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: tcpm: Keep the Soft_Reset target apart
 from the VDM one
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

Thanks for submitting fixes here. I'll have time to review over the next
two weeks.

On Tue, Nov 17, 2026 at 11:27=E2=80=AFPM Alexey Charkov <alchark@flipper.ne=
t> wrote:
>
> tx_sop_type holds the SOP* of the VDM being sent, for its retries, and
> SOFT_RESET_SEND also reads it to tell a Soft_Reset for the cable plug,
> after a VCONN Swap, from one for the port partner. Nothing sets it back
> after a VDM, so once a VDM has gone to the cable plug, such as Discover
> Identity on SOP' before the first contract, every Soft_Reset meant for
> the port partner goes to the cable plug instead. The cable plug accepts
> it and the port goes back to its ready state, but the port partner never
> sees the Soft_Reset: a source whose Source_Capabilities got Not_Supported
> is then left without a contract. The VCONN Swap, in turn, overwrites the
> SOP* of a VDM that may still be pending. This left a FUSB302B-based
> source without a contract until it was unplugged, after its partner
> missed a message following Discover Identity to an e-marked cable.
>
> Keep one target per context: vdm_sop_type for the VDM and its retries,
> and soft_reset_sop_type for the next Soft_Reset. Point the latter at the
> cable plug only for the VCONN Swap, only once, and back at SOP whenever
> the protocol layer starts over or a Soft_Reset of the port partner
> starts, along with the SOP' MessageID counters.
>
> Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to so=
p'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: RD Babiera <rdbabiera@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>

Best,
RD
