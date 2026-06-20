Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF83921CC
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970879; cv=pass; b=WZeASF8YSRpOb4TLo7Z0+fNi1mS4hNWPglfd91sKShVMvm+j1sgPQo1zG7t+f0g7K/qg9WswqRKB3UXlqJBr62BDrK8h49OKA7g3QkFQz+kkEvpn4vkRpX/zArq1ERO/Q4P0M7bLcq4/E3qhSwE+r8Oiv1T4m47iVmIUeq0e4tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970879; c=relaxed/simple;
	bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ9+ZsssSAKw/CyBWE4bOKnAbiTle5NN7P1xKwUwZyWqUC1Qqwktz+cZdJx8EcMygYfOTgv3CpUQdOK+uNEQXq8NAQ2cQCL9AN6EY7w+BrpNIJ7+2lOzKzfXBMBSqWHpIyRbF2qbav9fvmQB4N9FzmUZhLOE28LNAxisrZITd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HDjo1vgq; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="HDjo1vgq"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662bcc30fafso3213424d50.2
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 08:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781970878; cv=none;
        d=google.com; s=arc-20240605;
        b=RRzgNuUc1scYzQuXhezlCmIsDGeloK69Lu1/+oZNKkKZyQZuNM7p1TFDDzaXVdgBhu
         87srAnazj71It/wClhDgf5hjHzMmcixgSeUSyEQNK+slGjaGKNHaxqaInv3kgyNRL3fQ
         Gz3gPFhLGGiAqy4fJ+VWcF04DaqDzOJy634G/rANUAZ9E2QSFokzEPWOQhJruteKnyc/
         sDQQRnSqtjEx2eybEOYnWCVZf3MSvZrNpai11kHuG0oJUoIAqKfrRZAkvRufP610D6ju
         w6EeADwyH5FkQ+kiS6YP9xY9OX25bSQfJ4BeIQv9q9NhIvsFj0SjmMhjDOfkH1SuoWWp
         Jrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        fh=dQSS/DWEdvLFj9Yb+pBDLgJGKlzYZVaqDNGbbayhSgI=;
        b=H6wPFICJOPR254pwu/oUqUR4Wy3WrtpaBFWpaBE0Epbgkp8E/bJlZTcQp3TWE3wcQB
         XW8ZbqHUxmzBG6m9OkJM10PCS52feEpeXStbBeUupSxZDzRMYyBkwbfpIoVFKosF9RER
         lUM1pQZ3iWQ+AyhABXZ4EqzsDkG606dez7UW6YOEm1/J+hUH4FMb+Zw0vsB7jwZ/g99q
         SpGc8mLLjsw4imb8eRRqqNC1hUZTSaMbM8lG0eO4PfItEsc+O9bkX9FNSC6EGh8QdyCg
         Jnz6pj/theB9yr27+aELPCbTs5cY4woBL/LR05cXUpQmsc5W9IQ6QK/mC/2KaQYOH6fv
         U52A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781970878; x=1782575678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        b=HDjo1vgqCyQyMY9iSSxQk9BAzcnk6t74x+hZGqpe2RZ1wS7sI7LqbzRFepmJPcGj/w
         5BsnOVO/+Kg/0IWD+7iXOaEOPrWDHK6rQJS/s6lx7lAz2/XZ0PJXZKqjForf8A66Yhsy
         CIpECxztFUM+HtYu/tDzzRMk2EWcU0vM+8tVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970878; x=1782575678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        b=R55K5w76Ul65RiSyFFB8VR4uQX+351UHOg0do0o94/lrbty+6oecpl9S8KwDViAmom
         Q7m95YpMNdM7nECVTwzaWSTTzy5swW8gYtCeQP6crR4UPHi1Z0t8zEC+LubhPNZGyMqr
         cIDippAuNYExFaIBBGC6a50rxxNagt20VC2wZHd9dss6jGOC7vuZQvylb6qG7I79HYIP
         5F7eAGC1h7jM/iXEKQqAuu3gXKkdzQXY6tTiaF37/UFPszRTB1TMhKNDQdUv71MW12Cx
         k6hH0eygT4Wtf/+2updBnCjqdPYjkhTtVg5g3yVEbeX2Owysd9zWhYviPjiU4fBtD85V
         kSfA==
X-Forwarded-Encrypted: i=1; AHgh+RrR5kj2Oil6iQ6ZK8BfMR5hSFAfnu/71WGCbiykm1ZH7xF8RC/HFPxB6wWKvHnPN2I8duOgKGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NM8KK7QOqCsor7jVeC7BvdSspVqLAJyCHKYLhiQ0T3E17n+d
	xSLK2F4TTnJsds2kn9evfqDi0nsWgDsXZIDeDPKgbv1vD2xfvG3sYxvXqRr01U1lNzPenRqX5Z2
	r9OQIAN11v3H2s3B45XBa0xsx3eIjH5xJJ5ttih/+
X-Gm-Gg: AfdE7cmpMA08I0NRDhCjOilVau7mCtyzI9nyqMYI20ErXU/lvTPltpsmN7lSRi/96Ua
	QlTvOGtQoy5u92/08tLL8huQMMS05XABx8LhGmBtdNfCxrJaF4jVHcbOJZMl9Pcj5M324El37d2
	dD4GvEDIlnlUBCzk0odph4zE8gdcuH9aq5Nii8VLgUuBX51jEX+s+FVSQm8XLbRmJiOmRwWlFnn
	FKVdoAwCX5nYKA/lSBXWjoIvTtxab9Y/Mkh9MzrfP43sN+r/hcblyTdiQoyEQtP8D2vrhbVqdEV
	q4P4MAGZABw1NsTHaVdtdQzfcN4=
X-Received: by 2002:a05:690e:120d:b0:660:5e32:b2a2 with SMTP id
 956f58d0204a3-662fff62c0cmr7294649d50.49.1781970877733; Sat, 20 Jun 2026
 08:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 20 Jun 2026 12:54:26 -0300
X-Gm-Features: AVVi8CfVQ16Dt4Z149BETVATIkTE4DSBRfU8VpglrjahZRBgNf1eldVvT-bLElE
Message-ID: <CA+NMeC8-_LzTU_e+MA0-p72-=-P0NozcuaORsYGpyjMuAj957g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:15=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
>
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
>
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
>
> Follow the same pattern used by tbf_segment() and taprio: count only
> successfully queued segments, propagate the difference between the
> original skb and those segments, and return NET_XMIT_SUCCESS whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
