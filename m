Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160009;
	b=enENqWbqGBLAyPV/tYyUPGf0NHk5juohZFmT1NpnKKjcrkfJjsGUXYmBvELI+PJsOl4G
	 G0T9/lSYZmzf21BGPImKz0fOImT7zto6fg+bSp5uhP9K68cleJV/XQkOMyd+uH+yMx9cS
	 kYpxWIdOQnOWX02I0o2Pj2wXLmwrjYgS1eGHKlTwkirf9Tlh3MGjCAFo4lR2AKXXHYo/E
	 cpaqvuzZ1Alvg7lpmvmVNcaaMk2f3IHnipL6lMmGQQC3Pd+21U1d1BZkctukVzIWRowOx
	 MWInvat0vpinWKDYSBeismKJ9kQqhd9C57HpKnG4n+59yZbWIFccYdxYaYbprnsF7UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9PnQ2xaZr3mufSI+K6dKdlREXH8U5SwjpmTIIDKwMRc=;
	b=nYFH15E3WSHOnpvYVa88CdSwVJgS8fpu49CAmU/DRGVVp9GHmVBwD5h9Nu8cYyccojqg
	 F1x4HSneoMM/IH7RAAR1KmX8a8zyqleBlbVfSKEs6NYG2Iy63+QsI6QS2iHkL2MifkMpo
	 aQevMsXva1gVhF6TbRu4UL7fzRTzoxOBn0TM+9iT+Wmp/mNLU3YlwL3/VWl9HQlTSBy2C
	 Iom15av4+SQYJnBsNcPUV/ImVftm8grd6vV1Vjb9i5ysVbL8Iya9Ird6jbRcnmhgJhjyj
	 r/zMxxFABNiXwUTy174FtAFgpcQBE1VL6gtKNmOPfuhQRX4ZwUmGSbsURX4wg8kloTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB284606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB284606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c63449320so6291756d6.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793159998; x=1793764798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PnQ2xaZr3mufSI+K6dKdlREXH8U5SwjpmTIIDKwMRc=;
        b=Rx4wB/LhE02EKCirrNsMf/bIC/Ktzo7u3dwF+S3HlsfNKW3SPrW2onMGaHbLVMuF2p
         4AH0RuZkBkR7r/pDtqMhDUw3WMcpMR3dsbSuiWFkU0TALoGcxaf3VMIToOZA+szp5Tlo
         J7UitxxoUAiQGw5jIZ1jWLRG/fNUCVXwtfQx42QZH5jpPmIV3Vd1OKa8LUp7alfhsq8M
         JK5jCeuAYLAtjaSYyPe0lPSbUj7Hl2R0PurD6aLtQX0w5cOEiVUUD9BS5RMuE92CT4cy
         xPJdYgbky6NRWJ0i4Lrl0B/7Bus4+THeU+YgMcjp3eHhVipME+Z/i6RTlxi28j9X43Vb
         X+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793159998; x=1793764798;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PnQ2xaZr3mufSI+K6dKdlREXH8U5SwjpmTIIDKwMRc=;
        b=S2y0Z80BWuizEBRrWy39q/g0ikh0IRHWn1Mx++zjyxRWItaYwvCwtTDNl47IZJFoaV
         tEqhBHO6/YribJhTlJrXdmKBHPi3EFc1ZNE/AyZtfQap6Ym8/5gc6dkd2+PTmjPQAX4l
         JRiXCzF2Rreg/P3zyCVxlmAM3LtV0eETc9d7QO50pTCV2cS/T4UAnWlGhab5+qmwT5a4
         azV7VdvqEKUzsDzdj9u9ckAutm0F7K8Ov57jqoqSnsekgOuJ0hjN9Nc1PPKrFUx141dJ
         wy4UFnTp1E1ee7sLGgxUbkAKVxI0YXaB0fnjv1Os4BLgzkL+7EC88gcHg9jQL8VTcVno
         UEmA==
X-Forwarded-Encrypted: i=1; AKwUvBzxUOh/TMGyuWRN1ofbLO7bQ9VrgitwnwmmTCbf1LG0U5HvVbY4H/QF5ryukokzUW6dpyXMeg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfb3iN9gWaiQe5KPDgXn4ezRzIxEoE9bAKy95HzB+ZrY3CJEQH
	ps85cG36W8XG/VT7RaEgky69YZCwJYnwjKz2bOqR7LOPwLe0eeLRC1Ojq0I/2s/pGQ==
X-Gm-Gg: AYBFou2tj1NMIL9D9dsbVjGNiFVGyszREKtJXn1Xg1ntDt30b0WP60+MfS/WEjGxvOU
	2tWNt0Pww+23xKNQkHp4QoVZmSmQywRdtpAHqqatzzfLtCqIwwrGA/w7p+iEDt3O30u8pKgBGfN
	6g6hpFkdxRkwt7YNIOflhux531Mt7aFCUbbh+qFYT61LGEUCkQ4TxSda6GReYkh4QkqFFsmQ9Px
	1diafiBsgOUAITA5RrbRJ3j9MGsPNRdUiPppG1wgn4vGDb99vwSuay7m1GV6Q2yfARo5BO5OWy0
	hlfCfTFPTUxJ21nG57xIbNYO3lrrhFr0kYUZdliY0TQH9wUFb1ZVMKF+KnQeD9/lg8Qay2ry85I
	4+NO1gbL8ZxW8tuQlFC5KeIp9qIf67bpMeJky6e2wbht8NKco2dtVdYzSY2GcedCW3y/ykdvQEo
	ggye9PQzIsmB34s0V8y1ntdDfHO9unslxgkdHhbadDXe2OeCnam2xlCKtlZE5sJ24hLyRGx2U0o
	5h5kjPq1wMCM7fTlZ+EGOXLVls65shEpPIvIIYdHAGCyuVCEWM62uC3zCogqzbx81g5x/qW8S7j
	xbf+gt6HLIwglR3J26nOZAmgrgRC/5sBrmO40Nxk2D50AN5HJSqN
X-Received: by 2002:a05:6214:3201:b0:91c:7549:f377 with SMTP id 6a1803df08f44-91c7cf9035cmr18524006d6.29.1793159997516;
        Tue, 27 Oct 2026 20:59:57 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cd9dcesm119808666d6.42.2026.10.27.20.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:59:57 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Tue, 27 Oct 2026 23:59:19 -0400
Message-ID: <20261028035919.733823-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e2ee251e8ad47c6f1e2faf9ed1be787eccf5215c.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com> <20261021153141.311425-1-hengyul@cs.unc.edu> <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com> <20261022120658.1328124-1-hengyul@cs.unc.edu> <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com> <20261023173259.3275078-1-hengyul@cs.unc.edu> <e2ee251e8ad47c6f1e2faf9ed1be787eccf5215c.camel@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Mon, 2026-10-26 at 10:20 -0700, Viacheslav Dubeyko wrote:
> I am not suggesting to change the on-disk format. All modifications
> should be in-core metadata structures only.

Sorry, I misread that.

> The algorithm only solution will be inefficient and it can hide bugs,
> anyway.

The table below is about efficiency. On bugs: in both variants below,
a lookup or walk error leaves next_id unchanged, so it can only stay
too high, never fall onto a CNID in use. Which bugs did you have in
mind?

> I am thinking about adding to the struct hfs_bnode (b-tree node) a
> special field: u32 max_cnid. [...] What do you think? Does it make
> sense for you?

Yes, it makes sense, and it works. I wrote a prototype (max_cnid
rebuilt when a node is read, raised on insert, rescanned on remove and
after a split) and compared it with the unmount walk I suggested last
time. Deleting 8000 files in KVM on v7.3 (KASAN):

                                unpatched  max_cnid  unmount walk
    newest first                14 s       7.0 s     0.4 s
    odd ones, then even ones
    newest first                4.1 s      3.0 s     0.2 s

Both are correct: no duplicate CNID in any run, including the
threadless case from my last mail.

> If you believe that this approach will not work, please, explain your
> vision of solution in details.

The unmount walk, on a delete:
(1) do nothing unless cnid == next_id - 1 (your step (1));
(2) if cnid - 1 has a thread, set next_id = cnid;
(3) otherwise keep next_id, which is still above all CNIDs in use, and
    set a flag.
At unmount, if the flag is set, hfs_mdb_close() walks the leaf nodes
once and writes max + 1 to drNxtCNID. The walk cannot run in sync_fs:
hfs_new_inode() takes a CNID before the catalog records are inserted,
so a walk there could miss that CNID and lower next_id onto it.

Your max_cnid
  Pros:
  - next_id was exact after every delete in every run, so drNxtCNID
    on disk is right even after a crash or remount ro.
  - Nothing to do at unmount.
  Cons:
  - A delete of next_id - 1 still visits every leaf node (about 3000
    here); the per-node max only saves parsing their records.
    Checking the thread of cnid - 1 first brings the first row to
    0.4 s, but not the second.
  - max_cnid must stay right on insert, remove, split and node read
    (hooks in bnode.c and brec.c). A missed update would let next_id
    fall onto a CNID in use.

Unmount walk
  Pros:
  - A delete never walks the catalog; the one walk at unmount costs
    17 ms here (cold cache).
  - Only catalog.c and mdb.c change, not the b-tree code.
  Cons:
  - next_id is not lowered during a mount: after deleting all 8000
    files oldest first, the next file gets CNID 8016, not 16.
  - After a crash or remount ro the high value stays on disk. In my
    8000-file crash test drNxtCNID stayed at 8015 on the empty volume,
    more than 4096 above the largest CNID, and fsck.hfs -fn asked for
    a minor MDB repair.

Which do you prefer? I can turn either into the next version.

Thanks,
Hengyu
