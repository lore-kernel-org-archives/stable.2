Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186880;
	b=cFK9fVjUOnJLJ5jPgYKn5MECgv0FyFQ/GEbk5GJpY6/fQvdAai1E+xTrNpUZQaNtaP/Z
	 j82+PCMUOv/rYB0rjuPzKVO0uejhB4HzM8XlIjmYLY0aSZWMr3AVcLgQwEwO+3GLWVpx8
	 Qd6vC/msXb5XEU9VIkKK3GG0Ygiwae2NSMqLIYegXzJhl3bKCgKmC1xu982Ai3uCUf75n
	 JBIuJqFkqtOBEnKhquJMFaNgfFvz2zCru6ekRDHkeh3Dma8sir7g4iC5Zia/km19KNurH
	 2DA5gOSy/V8MDnU1ICRDK4VPbeUiyrXJbwEmtESK9uLritmBB42yK1Qu+0CvoONesSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186880;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=O/61q62gvasmCL59xNnECoaUy283F9i0rFiASLGXdtg=;
	b=3n9r/hEXgHB0cZsIXDalil69wSQ2gPTvz7cn0ipaWBh1VtQHKvZNbL/DXZ7mlXAF6bdH
	 fKIaNk/WbzrVg42a5wRaSv7o48AklElzReni8yLHYmc/Wt58JYe2bYxNLy8FhKX9D4ywQ
	 uN+2udXgr+kZMIF7xxxUErcvMBRzsX20hZp+m/ooWekduSm/WfiYSfH44mnBbldfOeFN2
	 zyrHuI9ePfj3OVjOtb2Yx9hVu55TB1S969vpLDf0nWNs8//GmN6HdK5vNlNc6USthSprP
	 /b+sQrr4GElNDCnTOR4wpdD8VS05IXmYnSneeMb3kpM0gJ4//ntm+8Jxr7dd54XN8fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cgVUIfv+;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3460A383C;
	Fri, 20 Nov 2026 15:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE3460A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cgVUIfv+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8B2C7C62220;
	Fri, 20 Nov 2026 15:01:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1A4E601B9;
	Fri, 20 Nov 2026 15:01:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D034C11BC0284;
	Fri, 20 Nov 2026 16:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795186867; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O/61q62gvasmCL59xNnECoaUy283F9i0rFiASLGXdtg=;
	b=cgVUIfv+N6JKf9LGvNH/jFTiL52g8RBI/iUIgBKnQOZgsYS93kGbCIwgi8UgyqeCjF/NmR
	Gaw5UYojk7EeSbSqNXN6ZTeSkfkC5jLjPX9K0XxMQksyhXQOeCtzltP3hi6X7F6Z2VWMyl
	Q48uhtr6f/ZFxWQmtMEHAvVQTzaWWwvdtwTY8TqtczB+p+DNC9lOxOISmmJrffh7/Q4rf0
	H+MhRqyZrGL/lHboY+hsGIYVvdl4fRekAPx+4GhbJveFWxcjSQnFpen9ftgaBDx6uqXRbi
	FnCf8mhnSBs+D+II5xXKq8iEyLNsxnOHaF+5pJbgNrVfJlQtObILSZw8DEruiA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: serialize dynamic partition registration with removal
In-Reply-To: <20261108-submit-mtd-partition-publication-v1-v1-1-cbff20b1351e@gmail.com>
	(James Hilliard's message of "Sun, 08 Nov 2026 14:13:59 -0700")
References: <20261108-submit-mtd-partition-publication-v1-v1-1-cbff20b1351e@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 16:01:05 +0100
Message-ID: <87h5hba6oe.fsf@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

On 08/11/2026 at 14:13:59 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> mtd_add_partition() drops partitions_lock after linking the new child
> but before registering its MTD device and adding the partition sysfs
> attributes. Concurrent removal can unlink that child before it has been
> registered, or release it after registration but before the attributes
> are added. It can also finish deleting partitions before a new child
> is linked, leaving a partition published after master removal.
>
> Keep partitions_lock held across allocation, publication and attribute
> creation. Record that master unregistration has started under the same
> lock and reject new dynamic partitions from that point. Check before
> allocation, which can scan the parent's bad-block markers, so it cannot
> start hardware access after removal has passed this synchronization point.
>
> Initialize the state when registering the master, allowing drivers that
> reuse their MTD object to register it again.
>
> Fixes: 5daa7b21496a ("mtd: prepare partition add and del functions for io=
ctl requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

...

> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -278,28 +278,34 @@ int mtd_add_partition(struct mtd_info *parent, cons=
t char *name,
>  	part.size =3D length;
>  	part.offset =3D offset;

Open question: would a guard(mutex) prevent most of the code churn
here?

Miqu=C3=A8l
