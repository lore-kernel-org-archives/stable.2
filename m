Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271124;
	b=V6GWKMuo1U2CgmO7UHb/qwitQ3ojXpLyB3B4rTb0DUxaLEXXoCA4yyIFWcf9Ftmr+1e6
	 4e5talTrx0ys8csPk3OY+3TjdN+FKR6zlzIr209Ntc/mr73hcrYkphJTBziYHqU04Ndem
	 zPiOEUWccB8EAVeBYpBYEVWrHTWiGUusG7qHwp3qVxtWMaKphXu/qB7tdUBp6G9qHp4FZ
	 Mf8IVh+EJCqHHswNdvNqY7uATNl6aqeD9lQlZQ0iMd35vV+7VrC3okAj2mgS93W+CL4Yp
	 086u0VnYwQ+OEFHLEUN0XcurmDkN1nCkGbMJNCY2uWx7gAuhvv2wg8PzsxkUeevvpdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
	b=F/hqZGigPq9iZHrJB7eRGy7/3eORfJs4skYP6YwabxOCvsdecWVmDIL11x/j2SDq1jc8
	 lM4Dn2Dg9n07fULcwbWT8KuSUr5Jfej3W+YBvBWonvt15pDHqzbXpYqu01P2SxxF0a6KN
	 cww7xrIt+hjCTTTcCjvPvzdVgAtHrgb7WWklFuCSVdGJA3Vhgy4om6mZmpqiSAILjUfXh
	 tK4SYZdyUQfJSIkugwh2HOKRVn14Q1w53hM6mzE5BDHriTjmHSWOoUGWXVSYb9ZwYOP0g
	 8diS3PdWXqdY3YBfxelg5qZDF/CTt7jwtcE45y5zwcrmBGTCbcR2aGM63zsP1SXbJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSZB30aS;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF098606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF098606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSZB30aS
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so2916250c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271123; x=1793875923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
        b=TSZB30aSZew/Y5iJpxyPAdCHSaUlGuRX0vGPWMGscUtyNdl4Gfru7VebT+uqAfmp6z
         QuRNmBliNwyit8/AV+JZGMrzS05uBUZyaJBYwcrM6V4CAEnFVG1H07Yh8XF6guXXqq/R
         0K6G6cvVOv6UxRt55KGii+YttWs6XbRYn3Y8tJ0JSK/FGkHwvCu2ElRB76I+w9muGUO+
         ehdbGY7CFuQhqr3Ct5KWUxe2bQqDJtvarrPkhglzBJlDKwFze5DOofXjDSx9NBRX5hSL
         ja5G7My3fhuw5URGr6Ba/QVGC9gd8w3GL/SZKX1gX5+fgnfevpEj7+FyT+7DRLu+RlLX
         hbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271123; x=1793875923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
        b=KxNzYQPBDcEcMOb+GNjO3RJuZSNmEs2Clul/HWCu5IQ8NgPnGqCUgk32ZM24GAsL5U
         poP3EimRf+P0+Hqcluar/YI5IrKWNZPzImFVbCi8keJ4/hJvpBbFeVD8nuo6801F/lG3
         uhVegTDnTwzpjnKKQDhAZHI7MbQX5vYtnuzByA336a+u1R+/soffBYCN32ALuUtv13ZP
         PmIIdc9Z7xY5ZHbSxLy/0b3XBwXaWUxtDEspzmGRSRm6vukx+NWUZ9VZQ/Manawngi0N
         XiUVJlCrk9dV2dZjtHJmGYIlzuP6pXsquZcgHQpb2LxKrToF01gF9YiOSapahtXTj+Y0
         HFlw==
X-Forwarded-Encrypted: i=1; AKwUvBzSfnhgcZZODt3BNg1rPfS1nm9Ul8RplcQSvuzvm3u1TIsHfkgizQwzsDuCmKFNIznLzXSGIus=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDSLI6aaJisHQKc+J+dTuZ9vdXq9no7+WYpThwYxNL0Wd1gjNv
	vb1GEo4/8tCGm8fH+aHTd0XZFtORZf4sbE8A6t4hO5RShj0qWhqsioF+
X-Gm-Gg: AYBFou1d4/3gFSdgTnWOuatTn/L8/zYGf0xIK3Y2M1OUVHOoO1J7f9n/JTRIB5HUFSu
	Y2HekBYbuHKsTRf/rIYBKcu8QdQOTLtXr+CSN4g1OWGycFDT2TZv6gXdmgIScDHxJgSFMDis5A1
	JOxihArvOBZqTcBVZAMdyj0obS3XpQm4Il3xd+YqOAxao664Z5+Jhg8q4dVTzSgBpyqcvkZjv85
	d9TBa5v9fnSKyRNI26bXoyFLw2pA7+2pU6gAe7vzwMnULNJlCevNL1IcRFYkQvgsW5Z6rC9r2mb
	AAsJqOdXKkIQP89LaJJj05F8OgFI/cM6hwL15IXm9Q4gC4HP/vq0Zpek3CVjG/5AdOiBtSlht2x
	mDDzBqBC8yhDrMIMuM4/1ZPpaNkd4T3hculdLcQjDS7bPcTu2c5mkCrarWYYYgZ1417Rc+oHgDo
	AK2WjhVKxMwpRrBY3jFJwqOYhoDwdrFrNdCymwfUjWL3n6vvBe795Z7E0Y6CReWI3lPnvi8vgyO
	4v4T3gjIbiESuZPvGxU1Uj3QUaiw4LXGMaXOaK6wgCPIJEwfndWE95QIrGbPf0upMI1iDV0PCm4
	v4gEW5LP8QWE8nY3yAss1AI5q4UOpXvrofKmjT4pTZX2
X-Received: by 2002:a05:7023:c081:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-1a6cfb045camr6418261c88.33.1793271122885;
        Thu, 29 Oct 2026 03:52:02 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c9fd2b4sm14692245c88.6.2026.10.29.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:52:01 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	effeffe99@gmail.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Thu, 29 Oct 2026 19:51:57 +0900
Message-ID: <20261029105157.2553-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <at9mFUv1flg-6aMB@debian>
References: <20261022163116.1042-1-26rote@gmail.com> <at9mFUv1flg-6aMB@debian>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 08:11:56PM +0530, Manivannan Sadhasivam wrote:
> > +	if (cb->type == QRTR_TYPE_HELLO) {
> > +		/* Pairs with smp_load_acquire() in qrtr_hello_work() */
> > +		smp_store_release(&node->hello_rcvd, true);
>
> smp_store_{release/acquire}() accessors are only needed if there is an ordering
> requirement. But I don't see that exist with this 'hello_rcvd' bool flag.
> Wouldn't {READ/WRITE}_ONCE() suffice?

The flag is ordered against node->nid. qrtr_endpoint_post() assigns the
node id with qrtr_node_assign() before it sets hello_rcvd, and the
replay reads node->nid after it sees the flag. For an endpoint
registered with QRTR_EP_NID_AUTO, the id is only assigned when the first
packet from the remote arrives. With READ_ONCE()/WRITE_ONCE() the replay
could see the flag and still read QRTR_EP_NID_AUTO, which has the same
value as QRTR_NODE_BCAST, and the name service would then send its
announcements to every node.

The flag cannot be set under ep_lock instead, as qrtr_endpoint_post()
can be called in atomic context.

> > +		to.sq_node = READ_ONCE(node->nid);
>
> There is no READ_ONCE() in the earlier read. So please justify why you added it.

node->nid is read again here because the earlier read can come before
the remote's first packet and still be QRTR_EP_NID_AUTO. That is fine
for our HELLO, as qrtr_node_enqueue() takes the destination of a control
packet from node->nid itself, but the replay needs the assigned id.

The READ_ONCE() is there because qrtr_node_assign() writes node->nid
with WRITE_ONCE() and the other lockless readers, qrtr_node_enqueue()
and qrtr_bcast_enqueue(), use READ_ONCE(). After the acquire the id no
longer changes, so a plain read would also be correct. I kept it in v3
to match the other readers, but I can drop it if you prefer.

> > +		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_HELLO, &to, &from);
>
> What happens to the return value?

It was ignored, and a failed replay was lost for good, as the Sashiko
review of v2 also points out. In v3 the replay is retried 100 ms later
if the allocation or qrtr_local_enqueue() fails, without sending our
HELLO again, and it is queued under ep_lock only while the endpoint is
still registered:

https://lore.kernel.org/all/20261029105142.2503-1-26rote@gmail.com/

Thanks,
Joonhoe Kim
