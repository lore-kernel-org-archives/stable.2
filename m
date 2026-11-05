Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854523;
	b=iR6peoTU+YUk8gjEMaeGaXeHhzxyx7oHpjmAAKcRKjeVLObF0dK2Wpan3HBsXcf94iYa
	 UMyorjQoa97/NZU8QyXbHOL+XoXDyV4oojDbgoksRO6vaj8uZXQ33EoC3cucbg42wIGYY
	 8R83pbMCrgY1uMJy2LUqA2imk9uL1bwjUrBCfGqvmYve3FsVjxWsY3ZQA0MvTzgNZ7xgt
	 yowMe2VfzQRF3W0EBXkCs0L/5Aa5zHvbPoOiYsiz2mjsRD9xtpWaTGY/BjLsF3vZyo3O3
	 Gy2pPhei7xxcSzifjZOFONyI6RBrqMbOCwq6sUOUOoAL5EgJPui69CGR2MJpam0MLbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
	b=ZMHhkVtQfHk3P9s4b8qqqnmdT8VtU/Ba2IYvAdbFQsFSBSpNO5uRMEANHBL9I2ibPfdI
	 cwExqY2t6MQu7+FwDd/dyH1mEvphixe1y0oBgBtFEsc+I5ToQwVvJ6Gi/hCjVnnZzqRC4
	 BTY07O3iC3zLvPIh/NYM3UzVsttx+vgNbW0DkFJvMjQbnblcSFgfV11qP1eeFoeZXIFcV
	 mv9lxtodnuB910VeDSrsDB58aCV6IkpiaL8eBJ+MF41i4bG3qohfm1oqXmGu60Jcrh6Pp
	 uxB4aJql7IBKYrgDGmBQJ3+8rQJ+uqW0GEMHJCRfXpAZ86J/Ime/bZjdFrrf+9FO4FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTKYyYeV;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973AC606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973AC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTKYyYeV
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b8b5d28cso47766a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854522; x=1794459322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
        b=mTKYyYeVr7uxttrPBh/zbgdicB4GtUsAEPY7xWdW42ONQLpFWniKAVmHzgolRVnz1R
         7cGjdcpTCPUuQy/A64lwRFiyY3CHLGj3nlqbK6AEQwT2zG7biKPOWYGbyqYZoXfGRvF9
         VMNjEFP/372eFVw5FbTuSsi8X8vRwpvlmPjZMD5VyyudE8jzRBB7z6J5DpdMGoY7Hq5p
         KRhkUg8+WaJVVEcdue/XWCVzhYJgAPz+7SROTuyUkDUJZGvY0euOB/3t+nKtd4g2liXU
         30ygp2YrQxS3ncCjh2vsNdYieq6M3aMH+1rBdw0W/ieO4AuFjVJakOI9Kr5nAz8+hS5n
         ycYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854522; x=1794459322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
        b=p+vlzVlt61FQhWALG8rB6l3/AL88Bj8YMQZeDu6Q6mfFxGclZxlaGNoPipiwnwCJV7
         ZaaQ9QDAiu/Rc/fAUDiDWp23vqYLZzZJEhdtU9y7anj8Z1L+4NNZDYuuXtG7dzn5W38y
         O7RzOUsCpShlDDjipYrcnI8zepin5923IQqV+XBpWT7s7QdbS5CfbjrfSdyh3K8i3Mmm
         c91RKEAmiS1/eluv+j2opD9dKer3xRozkKXU7c9Bo76WGSn5d8I5LVDthRxgYQQgDnp2
         KGyjkAX4Ob0ARSULXuklToBmiiyR0sqGvuNTFjGctMgCDhpE4NhucLj37tpKHF0ckr5b
         2nKg==
X-Forwarded-Encrypted: i=1; AKwUvBxK4vWcYwQ+EMAXtPL3w7iNZ/HZhXJX1WiA95svFe+9sv0QlElcgI2qUfbL7zkVeTlcZsxz1Go=@vger.kernel.org
X-Gm-Message-State: APuU4Z97Z0egazWKq21X2cmlQXSKiXbxvz6X8/+yGdEY7idOm7X9HnuC
	N0cMWjj4fXpP2fpb1NywBpNUzeavrMhdG2C1ZEULNANzVG8u5JZBsDkA
X-Gm-Gg: AYBFou0VbWPiwWlcEKq2HuCzi8gv0afK923CdxlaIPlRSgmpHNPAlU03xfG9cqLEqFB
	x5lFKoeyKJC0i/jHriR+F2o56aKZMNTwP86DhVzPu9an3KK31D8jRGzj5l4HC8QfhwB0q1NEeWA
	SHOnspMp1a3qHB5nKw9qRKCqKlBr4pFXmJyYcPCz5NKCtGRmucg4y2u2JjYsTx2m6luKa0zMpMn
	v+iq+Mg+ZKlMY/CRLw/DJy9fNs7qg/Rn9KbI/zRw4pXmHPr9rTLVuq8wXmd1JrCZIIkGzJF3GLP
	WtGSnrIUEoSa8AqyJjXt4hXBwO7MhlmqBCoKlYpNuqPeQQefXudMjOrB6OpazqiZaHXA7i89eLf
	8azzuMPe9OmStjw1dJ06dPsyKuqYo96TWYrlicVqDL+bB56FJK6m5E5PJq0z/gqGJ3N02aKFEom
	qO7IP0Vqbdf2yL5e87RKtTlktK/7W+KEehHH2h/9+EzWQbIbuLBgUbVKbRszlMl+9iB3BW4hP4O
	CcODCZimTM1eafYZ2z5PFr/kFaQfYSdxb7ITgTS2n2rjVLbN1aKwYC45ILdkyC6+32J3LijvRyt
	fYmutEFibc941IOrVK5/EZwosjskZltOtpLqxoWIj8cnjbkV0d7BkN0jh9G8
X-Received: by 2002:a17:90b:4487:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3ae89626108mr25602011a91.2.1793854521680;
        Wed, 04 Nov 2026 20:55:21 -0800 (PST)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm3726000a91.0.2026.11.04.20.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:55:20 -0800 (PST)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: fuchen.dust@gmail.com
Cc: coreteam@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	phil@nwl.cc,
	stable@vger.kernel.org
Subject: Re: [PATCH nf v3] netfilter: ipset: fix double free on kernel-side delete during resize
Date: Thu,  5 Nov 2026 12:52:10 +0800
Message-Id: <20261105045210.1179991-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026102957.5530-1-fuchen.dust@gmail.com>
References: <20261025090609.v2reply.4093.fuchen.dust@gmail.com> <20261026102957.5530-1-fuchen.dust@gmail.com>
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

Hi,

I discovered the same double-free during ipset hash resize
and confirmed its exploitability by successfully exploiting it
in my test environment.

While reviewing this fix, I noticed two remaining issues with the
deferred operations in net/netfilter/ipset/ip_set_hash_gen.h:

1. Failure-path replay can resurrect a deleted element.

In mtype_resize(), cleanup clears orig->resizing before reaching the new
drain path. Packet-path operations can then modify the original table
directly, while earlier operations are still waiting in the backlog.

For example, starting with A absent:

  - During resize, a packet-path ADD inserts A into the original table
    and also queues an ADD in orig->ad.
  - A bucket allocation in the resize copy loop fails. cleanup clears
    orig->resizing and waits for an RCU grace period.
  - Before drain replays the backlog, a later packet-path DEL removes A
    from the original table and returns success without queuing a DEL.
  - drain replays the earlier ADD, inserting A again.

The final state therefore contradicts the later successful DEL. Before
this change, the failure path discarded the queued ADD, so this sequence
left A absent.

The set->lock around list_splice_init() protects the list, but does not
serialize replay with packet-path updates under the region locks. The
RCU grace period does not prevent new updates either. Could failure-path
replay preserve ordering with those updates as well as within the backlog?

2. The new deferred-ADD branch can return success without queuing the ADD.

In mtype_add(), the new branch for an existing element sets ret = 0 and
jumps to resize. If allocation of struct mtype_resize_ad fails there,
the existing "Don't bother" path goes to out with ret still zero.

For example, starting with A present:

  - During resize, a packet-path DEL queues a deletion of A, leaving A
    in the original table.
  - A subsequent packet-path ADD of A, without IPSET_FLAG_EXIST, takes
    the new branch.
  - Backlog allocation fails, but the ADD returns success.
  - Replaying the queued DEL leaves A absent because no ADD was queued.

This branch relies entirely on the backlog to preserve the ADD after
the pending DEL. Allocation failure should at least return -ENOMEM for
this deferred-only case, consistent with the deferred-DEL path.

Validation of the two review findings above used a userspace harness
containing the extracted add/delete functions and failure-path replay
code, with lock/RCU stubs. Both sequences produced the incorrect final
state with v3; the corresponding unpatched baseline cases did not.
The baseline was mainline commit 05441d697f7f ("Merge tag 'cocci-7.4-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux"). These
are deterministic control-flow checks, not reproductions on a running
kernel.

This review and the harness were prepared with AI assistance.

Thanks.
