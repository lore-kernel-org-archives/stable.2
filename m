Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683773;
	b=sJCUb+73Vvss3JPClYD0o1XWdJmm7mAFxd0w0rg2321Y0SCs3gZwC2jTMkiLXZBaijKy
	 SEYdraOJ4KxF3XAa09wTN4C+0jV73iYS/yIjUycVMNpV2cHDrlMY98Qw3HsFotdmafQI3
	 y1Sh9coWtKcZ2euzk04AU02svMYskKpIt7GVPsPX64B6pet85Nq86RRRDqoUFI5EKmhIU
	 bMl3Xe075cTRCm2mrYdaJG3QWd4O3133Ohj+e5Q59AgE5CS6bdsUbJNZsAg6TwKhDGbqs
	 Bw+wOpXqI+9tjMFct63HboFdsL3p1OQK3+IlZ6yuPoVlc3pela8AHwp7vgQfJ8rtsYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
	b=FmGWSLcx4XthMz71ziVb9t+S6d2Mq7jiJI3JFYmSlE0ITzg31IYaVFv8Jh5fq7ZbjDXR
	 Uny6p0eq5p0rstlyC3grXrfkoFrV1lB2MLty1zW5BlqgAatbALMbvy1UdjizYkXHBwvMS
	 1tSJ80AXqOgUeJCyQLbQf4CmaJXIbYlsDjVDwxFP7vd3ubjHqnpUyMooNss3uyn9TQcDd
	 791t3xO1LxjWv1f1CtzcnWTH6ti1trzzR21SQfR/+Cu+YToDSIRONwRgWm8aA33EZZYKk
	 /6FTFt4UIKTpBQXO2XqOWlpZomEjBeGPo/HTukfGZInSc5cvDXA9zMtNe9Hji8Jkhyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IPBxSBBe;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31183606A337
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31183606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IPBxSBBe
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e60770381cso34918535ad.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 21:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683772; x=1794288572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
        b=IPBxSBBevN6si055FpDcPjREmB4umpMUr7hQsw0aEV03tx/568a5f/7TR439ZfWqqY
         iROemI7P2/QI4fSSZK+lO9qUg9iyFae6E5n63ZRCbxjuiJ06+Y6PS8s33TUR8/NTD1ld
         jHXIbomW+RWHpQf6cL4/lFe7OoCRbd9JzUEiHKFbfaRXO22PqSic12VPm3r6HlAaXvX8
         bHp7bzQLFX/gMMsBGHokuAuAP0lPu0AKc4h6H2TFSBPhP6iVBLL5T6DVED1FcnSDD4gx
         OsAKu1qEZF1UBKn18EzRQTxvn2PJUgZbLmFxCH4W3vQ3wesOxEi4f+0okvuei6psig0n
         8faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683772; x=1794288572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
        b=khkM1dEgKKPZ0XlRmbz2Bv2xRGQDoBSlH/AX1CqOSxJJgAH4lU2qcUTAZkdpuwBWIj
         U3iArANRtiO35xoMT9UNJnExP4jIRrwrdhfDyjqICgTnBa4++sn/52sZzW0nSffOKkIM
         iIov9Ma9uYdNlzZbLMWqYZtm2rSKuEntpH37c/gEMJbUhY/fNxgra1ZVSUWIV4H6CgHq
         oRsWhICqmM8wsyDXxH+OHv8QvRKPJxycD0pYwt54RFgtG04TpAMqCGsogwzt673hMifX
         Vmt3ami/LQZpGUHj2jUn9c2r/SLpKAzbTLoZwXYup/wPZPsgFIOQBZEF+16M9ob8N+H9
         fbCQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6oB1R5OFp7OWwjv0DRrgHLdf4kMrZd74ifJpEgAtZUXi944ZkVCLeEdqadnGLtmtwb/8JvUQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/m1cwFO04LjSjsxrJdANNbh9qB/SGT2VCI711jPKd4FDXd0yVh
	JT7QIGRCByirl7an63tu+LQK4NqGRZjIC5fj+esYjWwnoe44PatGaj5jMFJAiR1WhVDew89XSbY
	s/sUtqA==
X-Received: from plbbb6.prod.google.com ([2002:a17:902:bc86:b0:2e8:18c6:a093])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:2e9:5829:9b40
 with SMTP id d9443c01a7336-2eb3649be7emr111118405ad.9.1793683772335; Mon, 02
 Nov 2026 21:29:32 -0800 (PST)
Date: Tue, 3 Nov 2026 05:29:31 +0000
In-Reply-To: <20261101061331.286404-5-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-5-jiayuan.chen@linux.dev>
Message-ID: <aulxMqNrVTWFRuv3@google.com>
Subject: Re: [PATCH net v3 4/5] ipv4: restrict igmp_qrv to 255
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>, 
	Jiri Wiesner <jwiesner@suse.de>, Oleg Nesterov <oleg@redhat.com>, Gerd Rausch <gerd.rausch@oracle.com>, 
	Neal Cardwell <ncardwell@google.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:02 +0800, Jiayuan Chen wrote:
> net.ipv4.igmp_qrv only has a lower bound, but ip_mc_reset() stores it
> into the u8 in_device::mr_qrv, and the IGMPv3 retransmit counters filled
> from it (crcount, sf_crcount) are u8 as well. Anything above 255
> silently wraps. With 256, mr_qrv becomes 0, every
> "in_dev->mr_qrv ?: sysctl_igmp_qrv" falls back to 256, which truncates
> to 0 again in crcount, and igmpv3_send_cr() never puts the state change
> records for the group into a report. The older version querier present
> timeout (mr_qrv * mr_qi + mr_qri) also collapses to just mr_qri.
> 
> Make the sysctl a u8 like mr_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: a9fe8e29945d ("ipv4: implement igmp_qrv sysctl to tune igmp robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
