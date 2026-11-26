Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675644;
	b=2Mf238TdX9pggROBgYFVKA5GffC5k5a8BvR9LCsIfm/ZrQIzTYowG92Th7fvcl5OmnxG
	 zbVdeyplJEItkqIkuqxjB9zEJtK9cbxaq9VnlZmFJy3BrY3ypMvm3M6Y5kKiNWF6Ujh79
	 vNzxcVkIg01QZxd+oCQZ1S+tjJv7z4peMJhaOyhhVIU62qQhf2+jzfDbYaAcWEbd8FPZq
	 w5YrsnQNQ2kkPEXyRc/EB0cUru4XZpZ2UazUgLQdst5Lqb6iEy5CKODNVEckf0PhONeoK
	 gZRKS0xO2TRFJChuuojpESsLcNx9KGFo4fIl1J3r0kWiphZUQIk/TqdCBSbh9JQeSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675644;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DUqqxcGMWIG6tnXymk9Lyuyj8m3/xrj/arGN3/CmiM4=;
	b=kWpMfNJLcbwxzipNC090xmP6AvtvHjoHk5I093TsIPVIhfu3LRw5JW3Qv6p6PuXaxnug
	 rR9zPUaTNpGVbSijgQ3CvJDd9eHoMYfU0D9f1Og+0JXk9wYBtbf0kVtMVDE2eltzRjb9b
	 A+Oe3bUbsL9DkGKgHKSMgXL2fpds5RwS9DwapiNjvq+3hj8EqDTNksRKManneYicZKR0A
	 iAV4j7ldlki+v9qOqnA68ZztHyrwXWnPFLnmnGtgB1MikEhk9NobWfSH0OM6qEXUg06eR
	 neh7PA9zrpkdGYoO2sHk1ZhrcnyuFSBCGsUTrR0tEOLK0Zjz5eZgQVnd+vHWaGKgTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=BTwoOtgU;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E2606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=BTwoOtgU
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B8403FE2D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795675637;
	bh=DUqqxcGMWIG6tnXymk9Lyuyj8m3/xrj/arGN3/CmiM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=BTwoOtgUpFZJhhsb2IXCUuP3LjxZ3Sml8CK5AtqqIb0HZVBpwe2T+nZ6jw5R85lbT
	 HKrDhxs3ARkQll68P5SOMYYnX+QQOOnvCAL+11M9uO5/0r41MUGk4pkG2aE5M5IVU/
	 HZD+YcTUmIOArTF7276OxCVDADVW+vyt4IYJ6Y1Bp7LhA26GNZDGRquzQszNohb8uy
	 4ElQV3vySj4J0o0R4SPdcgiXmVJQ6m7H/4x3UrWx1JJho3dNzIiva0rfj/0FCrFeRI
	 lc+swVm6o41clTpt8U1iE5136hLLKKIPF13Qq8ITFPUS76EJlnRZSG91manWgUtXQf
	 1AToVmAtgtV2gOU/Gr5H3Gglezm313Y7mBFTBGpUc/VJTktion5JCuEcaj/JJPWROR
	 07kfKmCm6GICwqFXxAVaqqpoTx6Im58c5oKV5ZU/AeM/xRQFxLh3lC3tyY1Vyay5xA
	 eWaUL3P9GQxPznr6IvmR8bcgjfUQrpmbiV+KDf09WJ2G3ud4t4mknIbuioBcbTotfy
	 c5rVqdyZFxQRTv8++CsvI4g91FH38jk3LQu8UoJ6+oxop1iobSvHRau4Hne0MlGTfk
	 vz+Gr9mbtyYu3AJQIsDCVSU0Nr7Vpqvn/MCotptussUOU84fdLbDsAH/HD5+PXeax0
	 uJBnE3Hhkescv1kYnwHhgLRs=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b4139b7abcso5929786a91.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675636; x=1796280436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DUqqxcGMWIG6tnXymk9Lyuyj8m3/xrj/arGN3/CmiM4=;
        b=dorB3PjahdWiupqv+PIBYycR3lM3cW3hcbyGTO+KV1gLK+CR46nyOFGWlfqIb+b1sl
         5ppdo7A2uXj5BBDFOSVyQEmquTJDL7iT4PMFn9b9MJqdIk6BrjTvi5dxiz096HVcx369
         mtm1kiDijcojuC1zSJvwOEYD4Nuj1nnkRE0kY+rKz3UeJB3/eYwJlaMqqZxW4D6NXgBl
         afhKF9D90TPS94owHxRXc0I9IzeEvDk7Zi7TS7oQ7RmwAntLEVEotvYLAmPe2JgPyeK9
         flQNxTaQf+W2OvVPXBlHaNum9oeMO8eWTaBZdP6u0gurV5mlVW11IMFeyyIqO7ol5Uqb
         LW7A==
X-Forwarded-Encrypted: i=1; AL+hErE5TxS1qZUDV80BWXRRx2hZC/aIyoZJpjdiizUzzjBNkwN+OaWix7aGQ5TTuSUu/A+puKk2+hw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X+fUWXorCw8NXieeVPw6YYdwQF+uomMLVrP5jGPF9R8e+dqB4
	RCy+hIEzzEv96BarlSwiUPvjNjz2iLEsBWd+Y85EZB55rGat2qGxUdpUB9Ufg70CjK7E77N/sLr
	7FgWWGPfqbds9pAYuy/AN5HX941DyPumQNi4uz6Snwwr7X82t0K2iAKHPwSWbamT08krpG3NsrA
	==
X-Gm-Gg: AZFdTZcHtAqEchwyDrh6Wf/ZK8DZ+LpZttakyDC+V4ZnCkSe5o5XUg4rDnT636FcTNj
	e00DvdH6UWoKcqGxqaNloRyG9DbJ9vHJyKxQ0rW1lTaJVVzXBb8algCSE4ui3DVANdADhmnRR37
	7iBjgiT34klL4GrouDmcaYwDX21QnVY9ef2Ft3+YSNHCZf1asysUz2mPrcp3MdenU+/PHT8Diky
	YRpQsjRVyHvyzlhqTchSMK6/9Q2xUtnvzKvMOoGa6yPkFQNauyyberzardl5ba8J5dUBd07ZFzG
	5UdabJe3Iu7HhhAaZDcFuqjBINIq5ii0NLucpM56H6Ig8ZhRBNQJOHevck7MLYRZIyEF1zhVUG8
	XulBQC2qELnfKXQdRgHkQtgkOTZ6FR3yRi6/KKvdRTsFbkivonj5340W0knQH7G3WduHxocUwKE
	HFyB/KHzIR5Y3v0N+6Db4boaCbXkJehg==
X-Received: by 2002:a17:90a:e7d0:b0:3b0:aaa3:ce8c with SMTP id 98e67ed59e1d1-3b41c8debe8mr18647744a91.14.1795675635516;
        Wed, 25 Nov 2026 22:47:15 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3b0:aaa3:ce8c with SMTP id 98e67ed59e1d1-3b41c8debe8mr18647731a91.14.1795675635145;
        Wed, 25 Nov 2026 22:47:15 -0800 (PST)
Received: from resolute-linux.lxd (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm33398567a91.16.2026.11.25.22.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:47:14 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Alexey Charkov <alchark@flipper.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: udc: do not fail bind when the UDC has no pullup callback
Date: Thu, 26 Nov 2026 06:46:49 +0000
Message-ID: <20261126064649.75179-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <722603d5-ad2b-44d4-93b5-a629ceec9305@rowland.harvard.edu>
References: <722603d5-ad2b-44d4-93b5-a629ceec9305@rowland.harvard.edu>
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

On Wed, Nov 25, 2026 at 09:35:39AM -0500, Alan Stern wrote:
> Your patch may conflict with this one from Alexey Charkov:
>
> https://lore.kernel.org/linux-usb/20261117-udc-connect-v3-3-9413b491d213@flipper.net/
>
> You should look into this and see if any changes are needed.

Thanks, I had missed that series. I have added Alexey.

Yes, they conflict. Both patches change the same code in
gadget_bind_driver(). My patch 1/2 applies on top of v3. My patch 2/2
does not.

v3 3/3 also handles a UDC without a pullup callback:
usb_udc_update_connection_locked() returns 0 for it, so the bind no
longer fails for that reason.

I ran the KUnit test from my cover letter (emulated MAX3420, with KASAN
and UBSAN) on usb-linus, commit 730acad0b83d. That tree already has
v3 1/3.

  usb-linus:
    The bind fails with -EOPNOTSUPP.

  usb-linus plus v3 2/3 and 3/3:
    The bind works. 2 tests pass. The 3 tests with bad endpoint
    numbers fail, with UBSAN and KASAN reports. 1 test is skipped.

  The same plus my patch 1/2:
    5 tests pass. 1 test is skipped. No UBSAN or KASAN report.

The test that is skipped in the last two runs only runs when the bind
fails.

Alexey, I saw the bind failure that you describe in 3/3 on the emulated
MAX3420.

Two things follow from this.

1. With v3 the bind works and the test hits the out of bounds index.
   So my patch 1/2 should go in before either bind fix, or together
   with it.

2. For the bind fix I see two ways.

   a) Take my patch 2/2 now, so that stable can pick it up. It only
      changes the bind step. v3 then takes over that code. I tried
      this order. With my two patches first, v3 2/3 applies cleanly.
      A three way merge of v3 3/3 has one conflict, in
      gadget_bind_driver(). Taking the v3 side of it gives the same
      tree as in the last test above.

   b) Use v3 for the bind fix. I can resend patch 1/2 alone, so that
      it can go in before v3 3/3 or together with it. Once v3 is in
      mainline, I can propose the small bind fix as an equivalent
      backport for the affected stable trees.

I would prefer a), but I am fine with either. Which do you prefer?

I used an AI coding assistant to run these tests and to draft this
reply.

Thanks,
Aristo
