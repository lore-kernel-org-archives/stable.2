Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657326;
	b=LrAtTWrf/qQrECKk9XsS+BepMIngY2Vyk2AdWQouM4pxxjoIh1YsHnRiVrp0q8qTXoDs
	 SZLTxZ79Xdeh2XprauMj7sokUSfDjawGGTG/2TJ399pcazPzc7jM2/HI7SRtIdW9IFojd
	 6AhQA2udzZ2WVYNl04yr+7msG1nThcpBFikWDYzyDMcF3u8Cs0MnMz6GcM5jc+P1eVwC7
	 3HxwG969DVjw75i8WUIr2/h+UlMzBZMAAWLG8FjUgv5iVC0wIvymNJSDTE6UEpgIpr6sJ
	 rVxvneovIzmFvnxWnPYNyCL7FfKkhvlgNrugrZpMn8UP9qM3gkvRQ+WLIy4W3UQK77A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
	b=CPabzQTYSQi6dg9kCyjtidoJZd1uz6UMoOWj+9MiKncIbol94gdAlXeaY+oKGgBaDF1p
	 ILi1UO/u9cDSMqkMQpzIonOazOAnYc4/nEna00xXwTdz9tn8QVmNvGjrxlQW3o4q8urBQ
	 peXocGR1O7XUL6lSTVa7zV5QPQ3q7qQ+6McFsYADnOEK5E6RO87pIsFCdfsK5lhAWynK7
	 fNQhNhehboEgFGKAAl/o2N9ivRt3b1P/Bq0J69GEKxoEidQ/CneQyhs2iNJKGKuKvSmgz
	 wCO+mSy6rRjioNTiViIOz+lRnBrtu4K51WJEOrEaVIZFsjtrm75XRtAzQPq4rF6Y3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vlmPd/Rk";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEDB606A330
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEDB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vlmPd/Rk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso21641515ad.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657325; x=1794262125; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
        b=vlmPd/RkycBiY4ukdmMVnlWoeM0oSXArS/RRregiuEzgOAjEethQMPZeA9tAt5elt6
         /cYb/duStX70uSKpDQNglifYisToIuqcdEZnufgRMvKelbPRxsr0rDDCHzaUFaIMMVkA
         BNoJCA/7W90F9+JS0Uh6sO4ORN0MHR0rzJ+2JqdG1g9Y+1fPvXozv1q0M95WGpn9MCNv
         Nq33XGZ9DS0EKoJoJy7goD2zonm5MUFekMx6YAI8VzC7Rn8YO0GHbczvJMkiNKINlpP5
         VW0KAT1pib8wscZnyOcJMlVpAb53CVzazt+nY2aBgLv90hEMgYCZfmfu4CEqfcGJZbRc
         4swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657325; x=1794262125;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
        b=UHjckBLDbmTI9mCaxxSqgCKKUnA/uENQYSA26UBP09qY/hkKAC9wS3XHHN3kY3bbqQ
         PlLaEFyxiWEexolC7crUMzU0MhoFomJnbw+w5I6jZ1olV5cs2aRSn7QyYzbEN8sEL/dt
         /QYBg6Cj/TWkKnvD3EKKqYfe4Waxg/6yO6xj8j8VuTe+A5EEN8jWkCxLiMcn17IM6uZo
         Iu6QqQSQ2QEq5lCot2H4qY8sx9gAV0BT3DGAUqiCd63/j5XOJcHTw0GbVTz2Byf3H8z5
         RkpAAV/eioA17tOavEry6VLidh7KyCdCd0uCPM6sc+QDbNg/Rjtc/PicJ2S28fkMUiAn
         1KqA==
X-Forwarded-Encrypted: i=1; AKwUvBw1UmQ2CciAZI+CbyJ/0G7OcUM533nLqiekwV9f5sdspst+760GkkLIhL+Tv98AGKmRCKQP67A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+utJ6OPmvINH8j0xHwZDbxj6mzJ0S16wfKWI/atZ1y42YGbGzO
	h3VwHWymeV+TsJk08JDGxk6zUmvrahHSHejN86lT/b5/USXaY8AM6uTwl+zBIw==
X-Gm-Gg: AYBFou2t6PtHn2prxB6N7ehzc6F+atV7dKLSO+HzHu3d101H7PtD2P+8B3Bq7+bJT/q
	Z2ogF3+P55rTrVdj5wuzaatzVHYO+1wcCpfbFR6QpVjLvetxU2zWqUDrred6A6rA+XfYrQIleBf
	jJ2zYv4RXTuVhdZvpGOQ9Vpbm8JuqPgBgxvmNJeC8NhwbL6VKzzoIUIgEA/mkcaZXqMYoGpr19R
	R6TFdkkVN+lQnAeIaRtS4s7oDxTonqK7amG+8Te7GdKnDF15/eqbwY4hVz9fTTvMZMUO/yHCHMP
	q/M9OJPqzO+UlUC1741EVckdGgW3zfinJq1qUTX9xVKqHhOHptW4/NYAJZ6svSE39mK7PgtKt2B
	ALL+A6t1+GMYJManrhuNrtpUSTnKrhDSBs8X19gphSEO7C8NBBnAhDLBYltJ/KFlTc2ip+wF/ZV
	s6xdb/+5m1unJXN4wM+G0DrUdxwe7gy8jpvrSQ+pW179CujVcALzdjiYKxAInTMxPzViENvqCfD
	dNxG6FySSDjbrzcjg7gSI7XmmMaSDbmcGmvAQP2W/I0deZOy307NTvi9qIHqnTsb79de5ZM5i08
	ChQwPEyZApuhRDrFWGMpijLdWonsoXwlmB8smTcMn+qSOpLBdYfxWrKnjpcASuEf7cqvRvbk7yZ
	HSomA3KeKcfx2zzbIW15ZRiXDJRyxCdpQTg==
X-Received: by 2002:a17:90b:1d47:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3ae896f87c2mr10000259a91.17.1793657325415;
        Mon, 02 Nov 2026 14:08:45 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm986281a91.11.2026.11.02.14.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:08:45 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:08:44 +0000
Message-Id: <DML2GFI6LWXU.3ODKDXNQDBYYA@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf: netns: require CAP_NET_ADMIN for link targets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?J=C3=A9r=C3=A9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

On Mon, Nov 02, 2026 at 12:29 PM Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> BPF tokens allow a process to load BPF programs using CAP_NET_ADMIN in
> a userns, however, netns_bpf_link_create() does not check for
> CAP_NET_ADMIN in the target netns. Consequently, a token can be used
> to attach a BPF program to a netns it does not control.

That's not a gap. The prog FD and the netns FD are the permission.

pw-bot: cr
