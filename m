Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549669;
	b=b13yjbuP4+CUYz8sBjLumd3jWRAlfOHw7UnQrnTMZLsuCTzSdKNcZ0gc+vcBsmc4wKMW
	 dZ1AcccSxpODe2qhEV1jK3C+P63BY34AeKEqfu5P/4DiocFZhCBBjs8qZIQSwBG0NOjOc
	 8vy52GsHZUlKksLRatbus2Ci9ADGgwJoq+cNrCP93cgHyEmKbcthxTbJaFgjx0rkF9geD
	 PS1IpxgRQrBG0TXEsaMrIS9ZDpTInxuUanQ79jfSIeRttEk46/3tfhIB4p5yUfjL3ANLP
	 Y+e5cQ3+RjYcG+qk+m52ryP1+uZw3o95d6ysoHXqjHsHhMsVBW6Au4WoWgU6Azq/uKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
	b=D74MiJu/9Z/B+PA8Te2PdKGLQuEeeOAk2o6tuqlMnTthiA9V4HA4+6t8mmrIhlSJjyh8
	 JQkvbp2FSz1eSD1KlavE6VPYwVugAccJFXQMOZSx4pZF7uZECnNk5lF9ITPPeZ2YEnBmC
	 DLxQu6bWIWXRqxrIuZrZ4HKr3EHpFib/NKShIada8IWK1tqdTFofDNQ/ts4jocayLE3Ok
	 kBFrvAwErcDmkM7qoPidYkOtSEylIQkpOskW6GMPGh/QYxme13H78ufvGpln8b30UPttn
	 IP9oiMaIL2oDrIMxnDQH2krCdV0j2iyyzj6n+cFM8zSlVrNEeDKXoRwo2CSCA04jqRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkDQJ8SE;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86672606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86672606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkDQJ8SE
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso2427439a91.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795549669; x=1796154469; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
        b=hkDQJ8SE9T5NTx+bSFOZ+oAkTZjhjNqbr5FwlOIkYHU2pfuWXC4hay2mNhTxK23qcb
         E8pT2H1fsqK37LeIiSSxX+PRvqqMIlXOGG1K5wMto2pHYRL7DGTrjN32Kxqb5iHlE1CU
         u8mGCY7DYmYOnknCKDT8FMwDs5wZDo3rUKOjZCq5TlJv7ns4QVJIwOYleRHqUCDxLmbb
         7YnPGhg7aqE+4Hv3MnHRPSoR4oNT9YVwd86QcqSi2X5nJU1eg+L+AM7gmkVbGnnDdTIi
         khfGHwB06pBcZLt4VFZZPlFrOhNv9bh5Db3XcBIMRmkCvI+BTRNN1Py8AOJ39USrGJ+v
         4xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549669; x=1796154469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
        b=zs/cFh06io/KQPn+5218krsh/TXp/NoBCcFNrtwkvfAWf9I0tjkdOJW2wYRbhvDYME
         ZNlXrerwAFsGJyKSJe7CMPjwIqukxz45KUcZmK4gIn5M8VKd0d/tKUmhSwi6XU4evwUG
         8b0/20zmCVy5a0mrrN5E0rceTshV2uRZtjSUH8ZW8zeTO3XOxiYroIl10TVqemmTLd/u
         XgdR0/3V0ZP1j4UhXIXZtyEZzjJSqvR56lMpQbL3bA7pyJfbGR9CkxOHSLk3lEScj0xQ
         2kKUvQPpGfqgLs0Ip8FQPwzNaaaXaUNTBLGnsLVY+7z81Sre9J1gfNQXOg9IDLSDKABP
         ATFw==
X-Forwarded-Encrypted: i=1; AL+hErF+Lkmee53inWGVJVE9xNYC8h0CL002lIIrUvl4O5JR3pyb85zRYwJ19wyMJFBjdTTEwVOnkRY=@vger.kernel.org
X-Gm-Message-State: APuU4Z82q+SVBxQmJ0H2I3bTvVVibF6P69mTFXUNmj/PTRLIf/Eafle3
	Y/sAQ25ny+yKlVb2S60PKVCgoRV2ht8hL0fRyx4rNvuKpOGw+1T8BVrP3JzXr2UKYA==
X-Gm-Gg: AZFdTZf8CBKaQwXgOaYlUjXT7C0QbMEsh259u7GjucoXU6NdSzUGNJpR5jAP4GCNVIq
	60TQF/Yv915C054tbBtbvrWFLSi+269dfJYSm0wjExqyvzCObjjPYS0FtDJX9qdH8EPv2xsshXr
	zpW5hxzQb3Iet/skTc08hS2m0DQsY4vlFbmgj77Cr+7+/iMv/W2yE8VSzgI8vxMjWlzHpRHLRc/
	JS8PQ95Zh8aWofN0tMpvLgCZfT0tM8qOjTTTUm6OdIehFFRORmmWz0saKd3DhnQ4KEgzWUP7R0I
	PD/mUknKJWmCO8EqMeU5PQ7THfb/XqmvqyDLZShj/5ROKqYSGUNUPuXJNPtC8kqOMvZJmWdKxQd
	Fxpt8Ldo30ReFjG1rgASWMM15gzQtGqBmVzi5rpCJ30RjYPp9qfjWpLjnoQiXBF+ca6u32B3qxj
	g9KL9gNt6GzIE2xi9UgwjtRNpclpb4AvPjV5ye+H6vZYkhBEGc+pP3mDPcRe55x4WW+D7bmyJ3h
	lZ7Q0NR98gAEfK2BmejHV8rkxZZqGOCViIBdwYARimZKzbr8BsIrXlDM8mnTTryQqgdvFe78Lf8
	5canSs+zTzQ3+EMpqjjrmwFYe9ho3PD6YmfJ7ISM4X5UAFIoVY85k5ACtQM/j777
X-Received: by 2002:a17:90a:e70c:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b41c955b0emr14483470a91.51.1795549668300;
        Tue, 24 Nov 2026 11:47:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe23sm23939545a91.15.2026.11.24.11.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:47:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:47:47 -0800
Message-Id: <DN3P8HO01T16.1XHR8MD7J5JSJ@google.com>
Cc: <linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, "Rob Herring"
 <robh@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Williamson" <alex@shazbot.org>, "LKML" <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and
 resource assignment
From: "David Matlack" <dmatlack@google.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "David
 Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
 <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
 <42d7af61-bf69-b440-8685-5d9cec4863dd@linux.intel.com>
In-Reply-To: <42d7af61-bf69-b440-8685-5d9cec4863dd@linux.intel.com>

On Tue Nov 24, 2026 at 6:10 AM PST, Ilpo J=C3=A4rvinen wrote:
> I don't immediately see anything preventing from moving it into the host
> bridge struct, I'll look into this.

Thanks!

> Not sure if it really helps much currently because pci_bus_sem is also
> held but that might eventually change (there's the series which
> attempted to split that into a separate lock in each bus, I don't
> remember why that work stalled).

A lock per bus seems hard to get right, since a sizing pass or a BAR
resize can span many buses and you'd have to lock up and down the
hierarchy. Per host bridge avoids that.

> ...I already have another (unsubmitted) series that adds
> pci_rescan_remove_lock around host bridge setups because they too can rac=
e
> with a sysfs /rescan leading to adding devices more than once, etc.

That would have saved me a lot of head scratching. Please Cc me when you
post it. I'm happy to review it and test it with Live Update.

> Now I actually started to wonder why couldn't pci_rescan_remove_lock also
> be per host bridge?? (+ a separate lock to protect root buses list)

I've been thinking the same thing. Both pci_bus_sem and
pci_rescan_remove_lock could move into struct pci_host_bridge, with a
small global lock for the root buses list as you said.

A big benefit of a per-host-bridge pci_rescan_remove_lock is that it
makes it obvious which lock to take during boot-time scans: the lock of
the host bridge being set up, which nothing else can be holding yet. It
would also solve the re-entrancy problem, at least for VMD.
vmd_remove() could always take the VMD domain's own lock, which is a
different lock from the parent domain's, whether or not the caller
holds the parent's.

Eventually, the per-host-bridge pci_bus_sem and res_setup_lock could be
merged into a single rwsem, with sizing and assignment taking it for
write.

Thanks,
David
