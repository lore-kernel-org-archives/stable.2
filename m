Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362592;
	b=uKLA9PjTfKNPnUvGtjCCIVS9XFNsYKKSTH+buPQ7dkXrTkRlZXRgXDvXC5TazlEsaPYT
	 Q7Zse9mlXac92RPqywBfBWkH4Fp3dsAkWOjxaEB5AwwTqpNFx8DiWsOmp3+aFac8VAHho
	 d47LK83ILcG8HL9fcOub2wggbiEtDI+C2nG6yQIp0duBvevHNrWtHCNCI5DGLSL5g9li7
	 9SyjipXqEs1iXf/2J9Uz91NQlARZQ/UcUm626Z0X0YOPXF3uQxPLVq997qmbnRQe2MYFa
	 x+7I0JiYTGBT10Ha3gYa14FEQhBMkmjYh+/ofB/PJ9CGIxBpP+1+aTdg5SVnq4LPbWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
	b=ioSKh1DUJIiChLp1Plv1fYQIMdohXRW5T6pE5znGP2g4DV/G9pH4NyR6feBS2PPySga6
	 fgJsWrSwtHSWfzrHi3dWtcwYte6REZoAgrQ17UZqxlxgcXz7vO9BndY/6Cnp7BJG1dntt
	 lMzsrIwV2W+3xQjScfW93n+RwFte8c4XI1shyVd6DTQC+zL2hv4indMBL77sg3tzKYOFC
	 Ym5WtN67XNNpRSuVbNBFnqKMSu/7ZvE3HhOL+cVxlHyu0U6JA1NBtdeXF7LsXCf6hIc3w
	 fNlgU2HhDBOAdqQ/iShtByYba2wUDE1Cx1VGNaOHXKotSjop3esJrx26SzYzIiCD/2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc2mvNEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE9606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEE9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc2mvNEV
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so2312955eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362591; cv=none;
        d=google.com; s=arc-20260327;
        b=hmN0545puO6RFrLRVWuVhVPKHzGKELo2zObKDUiWVZ/wIuhFuaJhZtLu8uXQNOB9gE
         imtXup0UDurPJu7+6Zhx2/yLo98yyQmO3VW2fWR6GPmSP713vnPRgSx0xBwD1tVQIpXN
         qVmPobnLS9okuU3OSrU9BmT5E8HxlZLQ36PMLfLGYEU0dr8Vulm5w9qxFbfqz6nrQXIa
         vkyK8yg1WJ2mpeq5PTYjmHXd7tbEw4xlLnYyGF7CRjH9IJKl+XukzGJnzMV3rtDTbj2Q
         XSAzSuzy6zgOLbDqPUXjp24o2huyT/eInQ1DKJF0/dN8torrnyt9Qm0fZLzf5VGzmeOI
         Oabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        fh=41ETIgyq9nNSBMl1QsoanDdPC/D4FvpkROfbJi+fGII=;
        b=j0i6YkvQlNbt4Brw5fqGG7iPVgDMw82BQUskaUAygAeei00DC4180Z6auNZgJKKBAT
         jM5vogC03q8AXUxrFUuPe7r1vjvuPqulo+DpHF8nvni0xQSAqmH9ita3k5QiJPyft96B
         KcnfcZk1t6ihHrpAygVyJtiUEL+baHQJpjKZbIDefPOptEsBQ8yuoTMZ1I6mQygdeY+R
         IZw1Y4AGDargX1LR3THqQmBgNZY+qn22lVjpzXS6aiOecDBi4h9F76KnkkBvaccmr8Nz
         +OAn7+oWNy8UH/ccNbU3Rvp3oS84/mo/omR3z4I+ZgLAubBeXu8q1xQN3emvTARH7WBy
         YtRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362591; x=1794967391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        b=tc2mvNEVIdm8B2xyfNM9PSN/LYEqHpd+CNNM5+GFrAjNJAEVehCOmZfouiWm6H033P
         Hv2o/4hJq854Uf3xuG809NW5W5Szou42PXkOPvSdJSA/g1ZA4ZvDpu84vKZA+EEp3I85
         2wnCUDAz6A9gdQ5KOyu9GEnlWDpj7eoednBRT62k6BWDuisKRR0EyAkd3HO9+61lpKMs
         1FEJlUZu1M63H2XTMlBtjVu/g8o3bsx/bOjWUHDf8hM9W3KUgYEbWZA8gWcGn2ldO6AQ
         xn3bexjLcOGgmwgeFiW3Fo0aYcsvuJwu9Ts/JCL1WSO/k6Pt/SL9RWzwZtVOpDkDOx06
         J3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362591; x=1794967391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        b=I50z+KYELPLIAbqQu5+3yOjl52CT4Hi38/LRL9ESJ/YqAOgcR73D6ufL/D+rXjAg6y
         pr61+MZ8bEIeNZzZq+nseonEMJtXdk0OqPYo/EcLw2f+WJV3SU08cwujKklpqu23h12K
         LXVBGM/ucq8A1oiCH7/o1BPM5z5SVUD60mzW22gWNYege5MEdI1STAEeViyQg9Y3vNTX
         OFJ3FuJ8NljPaE7YEyKoZPnJNF9qpf/KTXdK5OFcl6xnjQAHweIggCR0utQyrppBqE2f
         G9RpiFDWRFo8aCyZwhrbFotMKWvK6S88PMedlx2YeC2u1aKVUvx9f8o/o9tk/9zIwKhM
         u2pQ==
X-Forwarded-Encrypted: i=1; AL+hErHczdZLV7tQdrQlDw8MekVBtrXcmsAzItt7LzTYWB42WLX9suhugUzw31W5YGHz+4ImQp/VSLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cn14t2uIUjcVzi4CYhYIpbxBltYJQ+jOx9Yk74Cm2nBEgwXzQ
	Im+7gua6OQkfJtZm2ccjWx/7wmL6NmkJRZ1q5tn2SYohiZhYlBgV/nKkvQmpCIvEOEw+gk1Ke+0
	qAo3uQX82DGLnPaw17+b47hQIOKcH2iM=
X-Gm-Gg: AYBFou3UP5H6sSGpficULA/8ZcCNRF6Y3wEK/1vrKy3+YvkdAbhVk48v6R99Z/VPqB4
	9D+JCDrPtKteW54H0k0p5vYQmXrHNH4PGsq8esbnALiPwTs1F7Ng4Sk0bYuD3srVNbTLKSriLOj
	HLneY/gKEAKAT5P6r9q9hvasqX9LFSVUEnYGz/MzadprgD6sEvYuRhVZ+ZSUhWAnNFfLN0AyiIz
	tTVbtZ9tbUpk7/u6flVctEnsfe4hxBRD4riKbJ9kWu+9es23JmvipYiTwz8RQcD/RrgDE/0+UiD
	Dnw/35mVdlvwBsQnHvqgv4Tk/X6+x8WvnqpXzEl3OHDGIB9OhkFeTd7wGnzJO7Sl++obYYrn2eT
	8irvngj4rcvBycRIxWG8pF0eENc73CwrQ2CDmudTPLjSgjSa5pS+5ln7JlqICJxSCXRVwsYo+Zz
	uqHgwLsElX9SS4DwWtOQbQaahuHA==
X-Received: by 2002:a05:7301:a0f:b0:36e:9773:84b9 with SMTP id
 5a478bee46e88-37685e6af02mr1672191eec.23.1794362591163; Tue, 10 Nov 2026
 18:03:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com> <265240b9-c9d9-4dcf-aea3-b31c460a0e3a@web.de>
In-Reply-To: <265240b9-c9d9-4dcf-aea3-b31c460a0e3a@web.de>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Tue, 10 Nov 2026 23:03:00 -0300
X-Gm-Features: AclHuK-wtfZcgBU4GAq4_YpIoQqfFNcIZX-I7sEBpi8z3DxPXOmg25d0xNehB-4
Message-ID: <CAOCBhwHW8=-CLB3rj=if3MQN=3En=t1eQ3eQuVJA6e9vMgLrxA@mail.gmail.com>
Subject: Re: [PATCH net] gtp: free the skb after handling an echo response
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Harald Welte <laforge@gnumonks.org>, 
	Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I suggest to reconsider the error detection a bit more.
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/net/gtp.c#L541-L57=
3
> https://cwe.mitre.org/data/definitions/252.html

Hi Markus,

thanks for looking at the patch.

Dropping the return value of genlmsg_multicast_netns() is intentional
here.  At that point the echo response has been parsed and the
notification has been handed to netlink, which owns and frees msg on
every path.  The only thing left for the handler to do is to release
the received skb, and that is the same whether the notification
reached a listener or not.

The failures that can come back are -ESRCH (nobody is subscribed to
the group) and -ENOBUFS (a listener's receive queue is full).  Neither
is a receive error for the GTP packet, and there is no recovery to
attempt.  Passing them on is what the current code does, and it is the
second problem described in the commit message: gtp_encap_recv() only
knows 1, 0 and -1, so any other negative value goes back to the UDP
stack, which treats it as a request to resubmit the packet to another
protocol.

The errors that the handler can act on, nlmsg_new() and
gtp_genl_fill_echo() failing, are still detected and now return -1 so
that the skb is dropped.

Regards,
Joas

Em ter., 10 de nov. de 2026 =C3=A0s 10:08, Markus Elfring
<Markus.Elfring@web.de> escreveu:
>
> =E2=80=A6
> > +++ b/drivers/net/gtp.c
> > @@ -561,16 +561,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *=
gtp, struct sk_buff *skb)
> =E2=80=A6
> > -     return genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev=
),
> > -                                    msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC=
);
> > +     genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
> > +                             msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
> > +     consume_skb(skb);
> > +
> > +     return 0;
> >  }
> =E2=80=A6
>
> I suggest to reconsider the error detection a bit more.
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/net/gtp.c#L541-L57=
3
> https://cwe.mitre.org/data/definitions/252.html
>
> Regards,
> Markus



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
