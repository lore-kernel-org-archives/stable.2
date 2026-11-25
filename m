Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643174;
	b=gJmhVvZ40IIgG59S4RIO/kAoD+/juibLUqvcl6Dnrbdh1B/cJEvSvn8JoLoMMgokJGFV
	 f3L789+SdlUB8lx0vCOb3E9foTjLw8n5e9GyuX8eRKCf4xIj2Qu6c/QSM0VQk38AOkXAz
	 /nqMouv+y83JLFJ+64+JzOI9FxN+FD3xMqFXbQLcAWCEUtNbS69Hc3dhr8flFSGiaPuxH
	 F60CwgxKPPYwTE6Iig+TuqxsUJQse4SN1SBeNNG1LIsN5/X7HuEJyrC2JGEMVIRI2beVW
	 qTgCK3lfRRbjNCVE+xlEHZSq81XfbKhZV/Whj9FtYtsfNueYaNJS16L/p4ERJIvtvIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643174;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
	b=jn+OB94PFCaMhi89usfZfB5MoZMgeTfRfSUoLWbA8ygH8juLGP3gnaW+zDAtNTHqvI86
	 3imtpOp2lF3h6ClsU2tFtM37Mli20k7yYGr7Yf3cOzcOsA5wDrEwj7ikCVPWty3SNCUBQ
	 DEBYQ5k5BIdIOOVQ7PVoCutdmHqM1sqMJvS4q9iqwozrG3oFnN/3MhJm+DjGVdPY8krck
	 xof2AKD7+JngFaEItBRP3GZnEgOWEK6CKTydGTlmQgFg/5kvkadvHtCsV03+3qWyEXB9Q
	 wCl25NeDoVUQHMxs1zqdp/ADNMqhc6M/lbC41Dx+C8gpRyBDrafrR9wfMSRu9P5TKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDx5zmQE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AkkPJYKD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F8606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B12F8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDx5zmQE;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AkkPJYKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795643172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
	b=NDx5zmQEWSndb22Ah9+ElfnoPYteBlKza1Vtx9PRcIOtHQNlNHnh96FSLgt+YHDryJ3xIG
	V0YH1NmbI2y4K1Lil+3bOAsQA6BQWxTuF2t3AX4YpiPfhTqWmzOuTEdz+3yQz3MvwjWPhQ
	+kYTaZwC1hTmeCikEXIHFHxgcgSLsyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-lk28WS_gOiCtb3as5Lbl0w-1; Wed, 25 Nov 2026 21:46:08 +0000
X-MC-Unique: lk28WS_gOiCtb3as5Lbl0w-1
X-Mimecast-MFC-AGG-ID: lk28WS_gOiCtb3as5Lbl0w_1795643167
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso30059415e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795643167; x=1796247967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
        b=AkkPJYKDIXBVrVw2QNrytGIe1fLO+fFEnatpFNjpK+MFFD0PzOyztg3dFKSuBJphAZ
         rUGNfarsUuMP1DvvQe432mVWldoZLMpMRmsd2zHfbisipNWsJjFsdACoscR+lmAfl6o5
         xiRypMxkiSfOvk/18zg2fCkBXZFE0K1iBZkWGxaZSjsfVwC05GCFOBHg/R0ET+NLUjUg
         ctGAtp6YKkHM9mgKPg82orvPOGZ4vMFXSOmzz0IqgtvG8FIycUmQ+8rXWAz3Y3o2afip
         4ydLEGBJ8Ra3mV4AH6vlnAsuDAEAqIfpTMzqmnRGG81U3IR1wTk5F+/TlbvgoSlxrg01
         G1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643167; x=1796247967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
        b=lI3592bytlrCyPM/4MyGrRC6KBfyUjBGNJ9u6uXiY2fpsFiEkH5tzm6He0ugl+Q8kp
         XNrHNbZB92AUxPbk5+maY19kZ6AwaQ2agUqNC4UK/N9glJYxjn2ZC68Jb5R1Ell8dqiU
         Liq9CN9uCbHORf7ku7GqDi5dEgg7X2I9whTCWcnmjRr7nyZ9mZ09c7/LICsNQiH7po5g
         iRHU2LchXXKfQBQXC/hzog9QkmHJdhwl0efURdUsjtnASYwmv812/ROvwuo+/gu3iJqb
         QR7bYvSf7iIfVcTKquhgNQdyhV4hEeNWp5YyqEt3PL/w4gOzdsWH1vb5ld2D2rqU2ZVH
         jbRw==
X-Forwarded-Encrypted: i=1; AL+hErE0MDVuPW3bPLl4f8o/he1noYGqZaSLWb1d9f6JkM6jbazi+g69DWTVQsYvm30K42a74nLZxyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cWW/uRKCZa5FOeW/MC05oH69o5H/kgKMIJkdbsD8fdluSgIv0
	m+VVG80KQEizVqYCSSB5scZgHFRoXefS0Le4fTd+D9tG7ALvbV3TAPO/uBtRF9HHOK497kEdViA
	kcvukIKk9ffsAZJA4JWaeaxVi80UjVXqJwPtLPFNyP8y3eCHXKwIVKmcb0w==
X-Gm-Gg: AZFdTZcARjKcQa2w4AJz5YRox1Y/S1FTACbTuOLJhmHFB7Tb0V8GvTuHil3BgPCTzhT
	L6ulP+CfQVILPBrZBtINs59khTlNlo/nff53XbDQNFq+1nKJeIL5Qso9hxm/foiDeBXH8YTHiwl
	44m3Hb+r4Xbv5UtVjS9pGx9JIRR7J/MTvJhlPOyNcTTG/D0POuKzTuvA0oNu934Jazmn+x2L+nW
	GGeuiu/7yS4xJG/KQ3kTsE1r+b8wSXCKofe5s+yC8zzrR3iIbYw/sEwEj67RZ/Xr4rCH6CApdOa
	m4BHaWxZTzz+225EhoEB9vQLSK2UEoBtix2BBEY+bGJ2zw5AXo2zZ17vG6P5c1WjcC3PkWFei+K
	lKzJYXM/qJ2p6odkcfcZerqLiO0NnovWpHgpZOensCek=
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr398711405e9.10.1795643166763;
        Wed, 25 Nov 2026 13:46:06 -0800 (PST)
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr398710875e9.10.1795643166098;
        Wed, 25 Nov 2026 13:46:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm38309168f8f.29.2026.11.25.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:46:04 -0800 (PST)
Date: Wed, 25 Nov 2026 16:46:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paul Moses <p@1g4.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"chenglong.ma" <longpareto@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org,
	co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com,
	fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com, lirongqing@baidu.com,
	oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com,
	sergiiushakov@google.com, shubham@octane.security,
	stable@vger.kernel.org, stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu,
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com,
	zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <20261125162710-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
 <awWOpS3HR_2FTN3I@gremlin>
 <20261125060533.1296-1-longpareto@gmail.com>
 <awbTgufgR4Uge1kJ@gremlin>
 <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>

First, thanks for your quality bug reports. I saw a fair share of these!
To answer your questions:

On Wed, Nov 25, 2026 at 09:21:01PM +0000, Paul Moses wrote:
> There appears to be a recurring problem with how previously reported 
> vulnerabilities are being handled in this subsystem.
> 
> Yu Zhang publicly reported the VDUSE VA/PA confusion on August 7, 
> including runtime evidence and a proposed fix:
> 
> https://lore.kernel.org/r/20260807022657.11318-1-yuz08559@gmail.com
> 
> Nearly three months later, bb2e6f166547 was merged with attribution to 
> Claude Code, but without any acknowledgment of Yu's earlier report.

Mostly what happened is that Jason left RH, and at the same time a wave
of vuln reports hit, and this one got some "critical" sashiko reviews.
Which I didn't look closely at, but at the same time, the reporter
really could have responded to, but instead ignored. The patch was not
Cc stable, even. I could have looked at the patch more closely and
noticed there's a reported security problem and tracked it.

> As 
> Lorenzo has now pointed out, the accepted patch also breaks the driver's 
> mmap path.

yea, not good.

> This is particularly concerning given my own experience with the vDPA 
> netlink double-free.
> 
> I reported the issue in March, submitted a patch at your request, provided 
> runtime evidence, and received repeated assurances that my patch would be 
> applied. Nearly eight months later, a different Claude-assisted implementation 
> was merged instead after I reported it to security list a second time.
> 
> I acknowledge that I eventually received a Reported-by tag. That does not explain 
> why a known and acknowledged memory-safety defect remained unfixed for nearly eight 
> months.

I don't at this time remember why it took a lot of time or why I chose that patch at
this point, sorry.

> I have no objection to the use of AI-assisted development. I do object to a process 
> in which previously submitted security fixes remain unresolved for months, only to 
> be replaced by AI-assisted implementations, particularly when those implementations 
> introduce regressions that basic functional testing would have caught.
> 
> Why was Yu Zhang's earlier report not acknowledged?

Because the reporter didn't follow the process.

> And what is being done to ensure that previously reported vulnerabilities are not left 
> unresolved until they are rediscovered?
> 
> Thanks,
> Paul

Following the process helps. You did good by pinging repeatedly and the
problem was fixed as opposed to rediscovered. Thanks a lot for that.


I'm not as quick as I'd like to be. Make mistakes, too (
If more people can pitch in and help review patches, that will help a lot!

-- 
MST

