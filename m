Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826288;
	b=pUoMUhBDfvd2Ge0udavoAekRyXH7oyHLyYpJi2xC8rYX1tXK9zHi519ztnqXqf+B8Vx2
	 Co/xlYw0XKCAKiF3vCbJudoFRGQCP8i2k/Y2Ga9G/qPa2UEKmwBGOP4iPUrbVH7dzOC3S
	 7x1DBs3zABqdjlnIclFP7eTIZy9VtBagJ3EuLx6kKxCQ3t86Eszk5PV43bjkGItnTPbzN
	 1IrdPCM67wzqJyQYVoM0O77/71JOv5pOyhXOSb/N3/nR1/Eq9H9xkcF5UZOGQJEXDqt7D
	 qxFu/VLJOQUSKhBT2fiKDdt5RCqXdLI7mX7EiKeQaZww2IBADlh+fE3P7v/Gs2joBQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=YOL0rHwI3wzAxiSlMAGGk9NJU9DJm9wEtDs3FMJdkxM=;
	b=Xeh7Ofxf+X4zQQObHeCsbL/3FEi/yZJtLWMtuCtfdwjd1ePLfkaY8Cm0yxSElGxniMno
	 aeAJsmEwIHKIec8WSsXvdYbPDjQoJm/ymYkamF0HeTWIEhSEJxtYRzL/geVeHC33xcGjF
	 62UoNBKc1+SsS7HiOsV9o5DQvVtVoYIpyfsRrmfU2MuuwSlAehdX4JX4ocsJw+lmSXTHx
	 YJ7/tLUdFQUrmqC8I4IRkVuvU3z/pxAcDg9ylI9hjeye2VQm6s3HRnRQR3dFgFjwR5HZ+
	 xzT4kfSIMxIJtwQeaVMZJzQxoH52dsXe+ZfHb47pZAbDFnHu86n5gDVAzrtFK0FUB8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKquqcb5;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3F606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 00:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKquqcb5
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso7359094a91.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795826287; x=1796431087; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOL0rHwI3wzAxiSlMAGGk9NJU9DJm9wEtDs3FMJdkxM=;
        b=ZKquqcb553C1STK9QTgdXfRyAWUuYTT0NYDXAbFNELVbvDZVCnsYPo1TIdFhNon5XC
         kg+l1yQya+4Eu5DNiTvrPG7CssM5yQFpVMgmNj5wsreMe0dXvFPd3fe11juBaBgNB3BM
         dMyd2o7qTGDHVEem/5/uht7ZikH591ADQjGtfG9unKEU0KzXTHrcutyDa6X8I0oiJckz
         DlXPu/49ZuqhLHOPnUDJG0VHqml3u3ymKLeUBnSB2+YPsEVQY8usntbthQCTds7BmZAi
         b2E/Q7QRhBklENM9luDICJmLTN2PM0+S3OaVARAWjToxNsNm8tSKk/iUS8DFcqzubrby
         SRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795826287; x=1796431087;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOL0rHwI3wzAxiSlMAGGk9NJU9DJm9wEtDs3FMJdkxM=;
        b=hY4Sh/sbs+pkdfcQTnq4Xq6EtXvfkRAXgoaGeX/TO8qf8PAIinMJmIxKMVdX+d+ja2
         krxvR0kg9Wj+00zTPU1qyG3PNcpLo5Dd8P05ikVqwxQnE4mRzLC7FuEqEiolyNSDC5Bl
         a9TMINZWx/ZOWnuRKDYZdFUKciSw6okn/Z4kiVGeinEsKEhKmdCSS/emxP8qdbnSMhM6
         gHsTqLw8ZnLZxMyuLG2qiqxVQqhyD+79C+NV790r7Da0RAcLJUeCpo+zNXVwek8klhX6
         U/OVQve4wrXoTGyMVWuPelsiTm+G1N5lhazcgsx5jNzPhMBjwGusd7Cov35WahwAu0P5
         XDKw==
X-Forwarded-Encrypted: i=1; AL+hErFNGzXRnGXQXMPGZEbiNNOlZmJavVAJ8KK+2AkjfSGAxLQT2nFp//iw0WGTyWD0afGVygitI24=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ezhtKcNitsglARJE1FMyjqsNT8VPIvpU7FBy1poDdgjpQR8Qh
	W/3ptz30r/MXZ6hymhm3au9lwuRfcVjmL8ShAa6nNgAyXGBCw9c/8ZxTreQR6w==
X-Gm-Gg: AZFdTZdo6pet9SYAfeIrd80sle5RWFsOvbamrtthSG1qeq686b/zlLoyJZoKth5FyQ2
	2iHbkHgDaL2GTfq5m8/Pcm4t31pf7a9OOI3fSWsNIbqKFpDH9Zs0wxAbHUYIx8NzzpRxdf4PIS1
	kqEtuALutnJtxlvmwGmOqMdJ0paQD0XN8DPLOVd66tLhkcRSGEUED4LxqUQC9x4cWgZUiQQom2c
	MI1iidbgdolzxBBs+iBVBiGLwecua4s/74vHn/P8kUU8Nblme5jAl4hQGJW1iAYMJJwLlpcJdpZ
	r4N44cE3F8lfyPtFjwHa/mCpNYSCUnr3y4C1TiykG9O+Hq0Fzgo2pT7OJKxzHSRtOo4o6dMkcSE
	AyZaQdBY1/CMHOGymkF0PVhFvkudErFPO3AupbtS5qOccy/S3eBPx1A40Ye8TBG8xIuvdwHJreb
	HA/0Yh6GLiOwSp8966KBe9EcybrgqHncOUXgrN9Qxi40rP8vqPnj9HaRcrGEhZ26g0oxZtn6MXh
	JpfCRRBev/9+xtda8wWcKBG2dZMAJmWGOtID37vOQbkzZu7WIK+fR0Lzha1YOQ6ByQb+rjijfYy
	3UOXi5SADw85AHEJ4tm/fKyiq2f8lL+9Wag144Lgp48hWTUZlMd9J0FyCj+seT53FsFMMfvDJAG
	jBy0LCZO4xK/G+AnJTwnLgxUgzjkqzBVDmQ==
X-Received: by 2002:a17:90b:2f8c:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b41c93fac6mr17486167a91.30.1795826287365;
        Fri, 27 Nov 2026 16:38:07 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm42125157a91.3.2026.11.27.16.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:38:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 00:38:06 +0000
Message-Id: <DN6FAEWV4D25.2PLLOZNKR0L1X@gmail.com>
Cc: "Jiri Pirko" <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "Simon Horman" <horms@kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Victor
 Nogueira" <victor@mojatatu.com>, <stable@vger.kernel.org>,
 <syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com>, "shaos"
 <shawnq1@163.com>
Subject: Re: [PATCH net v5 0/2] net/sched: act_gate: bound the cycle time
 and start time arithmetic
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
In-Reply-To: <ACT-WEXM.v5.r0.20261127063407@mojatatu.com>
References: <ACT-WEXM.v5.r0.20261127063407@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 27, 2026 at 03:43 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Patch 1 bounds both attributes at KTIME_MAX and computes the next
> boundary with ktime_add_safe(), so an unrepresentable expiry saturates in
> the far future.  Patch 2 covers the accepted upper bound and both refusals
> in tc-testing.

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>
