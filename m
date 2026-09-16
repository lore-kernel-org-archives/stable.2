Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BD5A984C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576186; cv=none; b=Hdd9pp7FjoLP+eUJTlcdvda8XmDUAH2o1k/3QOUS0BOIQ4gscsPJYQPYOoRTF2NewKcI1YydzLTpjYKgRSBQBuHmYziCXPl14h50YdZUVP0hNtp0RQG51rpvs60vyiq6mIYynzfDvspaq/OW2CsV+XrzPWz+esNCKN+80jIkZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576186; c=relaxed/simple;
	bh=rfCTD+62jY9yHO2p4lEH9EoauwzrB7tZLsKcVUlpPbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HN2KMBpKWfBHxz3CtQKQVUbK6eIPtG/PbrHX7lzqkTCrmiuj5I/D/jqg+Er9Y+Hmu+xB7Gg+RGbSaI4WLt28wwyd7iLT5RjcMDUF1rCCfHVzclWEv+Z9cSLbd+SUpNLPd6s1R1OTYwqz3hPRVqMiogDNeFicwLrJcS4X7MoCUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c4Ikx4j0; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4Ikx4j0"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so184549966b.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789576179; x=1790180979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGsaKaCm6H9DIjQx0NqyVJZZj6VZWtfqDIqvxsFeHmU=;
        b=c4Ikx4j08+Z/Ya7L5ry0mZfAqsOfx8AVPzHc5Qk0EuYiBRwHk846n2UUW7QlxFljWb
         V1Lvx+eGtHhRryl7uufAdfrzRz3tTrddkVq7yU0S5Z2QkLLkeiYw0ifs9oOYvhfJFpUm
         fnm2eW9gK/CYX4pf0FrGa2RnoV2JSnK+yN9S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576179; x=1790180979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGsaKaCm6H9DIjQx0NqyVJZZj6VZWtfqDIqvxsFeHmU=;
        b=S2GyUgmeE4up0kelqo4iKToHbJV56gV1SyEk0ei0NYGHwouryY6nyrw6FufR90nPE2
         +3LmWbA0sxtKRwxytP1LL3WgOHMpW7lWooz4aryuPrZLnNRr+I7yRyGJtrpBIYFSASj6
         VO5iBRAFFV/uRwGHBoDUIitfjAzJJcnq/UuxIChFFyjwC4ZKI4czDSVWwdURB4yr4cNy
         iqeELnprkOpFrt51wqwIOuQtTbH62ao/8Q9FhthqOl4bAt0FW/2Rcdvfxv+2Xje/Kdvi
         bJm5tV9OA/kv6elBvc34fycVFpy1TpXD/Dm8EQLbc4n8cd8FUW+UbsHxKGYXRVZiiCld
         Y3sA==
X-Forwarded-Encrypted: i=1; AKwUvByGBBxOr+PmV6T+1kDMad7Iqj8OFvtvbTWI6lzzDXFShl93gx+B1A3jrg+2o81eIhp97Y+CP/E=@vger.kernel.org
X-Gm-Message-State: AFuF++kUrdsF7hRdNUqJCz7ctW9bJzlGnU5A0TTsxe2IAgP+q3Urj9CW
	SdjoUUJS+vbAd5SFup48XCJP9nPYPhBIA0hdWuV5/ELMbbSW99/v3Db9k9r1T1eyxfx5uFtsu9R
	3wHw=
X-Gm-Gg: AYBFou3Pzu1jHQ1D92CtBVrtDn/WTk3DRaOtfcyCTqUZq3C2LVp118zSn945UHmU8Nq
	3lQYqlyTc0t8/zHNliobYzYSPb1muDo+YxrYYWrKWDXwURP3nj1bKAr6h2hUQA1uiZm6KgPKUIy
	Q74lIlv6soKRnkBUB8trN6i43sAXSpl8PZPT/NbZpUz/QbWbHshIj5D+Q+HE/iuvNOelGCX9myg
	5M7tQOXc1FlV7jCWJ6dP2FwgdNntpg4D66PBrOsleBCUtzdq4WFz+35vVz+W2cgXGaHkDSeLM8j
	kVntIsMQM3LASqA3qmjsbrhqdGLPcEIWO9tIajsQcEyer31x8OBWxncAgLcRTDySOga3LzIJLjp
	MgAWjcMBEqWnOkck3On2SzcuT4zZRxffQ6B3wmXjrWM3ww+W4q3ljRkeyjMHKVkjLy12A2Dv0qg
	3XYjLYVBwDk9VEOa6YZ1Xfv0ekwugdu+7jx4ZM/6tKCavAQlLT8I94Cdo++/ekUYz+GglZw8twJ
	AqtVMUrYSNhdtTzmiO4sHZeZmGZNQzVBP/WKf8=
X-Received: by 2002:a17:907:9706:b0:c25:8eb7:f388 with SMTP id a640c23a62f3a-c29e529a30bmr460642766b.17.1789576179275;
        Wed, 16 Sep 2026 09:29:39 -0700 (PDT)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com. [74.125.225.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de454d91sm167932366b.19.2026.09.16.09.29.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:29:38 -0700 (PDT)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so6492685e9.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:29:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzSYxQvgC580USZczkGaVPIiuJ0A6kPuHAtf4jHSs1cxW6LhBKRjO6wkH1xAKb+HP+3WxOOECE=@vger.kernel.org
X-Received: by 2002:a05:600c:c48e:b0:49c:ff8d:b548 with SMTP id
 5b1f17b1804b1-49eb732fc54mr76705805e9.11.1789576177013; Wed, 16 Sep 2026
 09:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916151753.6722-1-fangxy@xiaopeng.com>
In-Reply-To: <20260916151753.6722-1-fangxy@xiaopeng.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Sep 2026 09:29:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VqGXRadN8Ro2UV0hXZvNOTABDmAh+On-bUXFEGuJQOSA@mail.gmail.com>
X-Gm-Features: AcwNN1V3QXHsb6_b7XvNkZrIiXWsTtecG2wVDHU_J3bG9sbbPJ8EqsrduqMn5D4
Message-ID: <CAD=FV=VqGXRadN8Ro2UV0hXZvNOTABDmAh+On-bUXFEGuJQOSA@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix buffer overflow in the qRcmd packet handler
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 8:18=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> gdb_cmd_query() decodes the hex payload of a qRcmd packet (the GDB
> "monitor" command passthrough to kdb) into remcom_out_buffer and hands
> it to kdb_parse(). It sizes the decode with strlen() of the payload:
>
>         int len =3D strlen(remcom_in_buffer + 6);
>         ...
>         kgdb_hex2mem(remcom_in_buffer + 6,
>                      remcom_out_buffer, len);
>         len =3D len / 2;
>
> kgdb_hex2mem() takes count as the number of bytes to produce and
> decodes them in place at buf, reading and writing 2 * count bytes
> there. len here is the hex character count, twice the decoded size,
> so the decode runs over 2 * len bytes at remcom_in_buffer + 6, off
> the end of the buffer. On x86 BUFMAX is 1024, so a 256-byte monitor
> command (512 hex characters) overruns remcom_in_buffer during the
> in-place decode:
>
>   BUG: KASAN: global-out-of-bounds in kgdb_hex2mem+0x131/0x160
>   Read of size 1 at addr ffffffff8765ef05 by task sh/1
>   ...
>   kgdb_hex2mem+0x131/0x160
>   gdb_serial_stub+0x16d4/0x3170
>   kgdb_cpu_enter+0xb68/0x1520
>   ...
>   The buggy address belongs to the variable:
>    remcom_in_buffer+0x405/0x420
>
> Halve len before the call so kgdb_hex2mem() gets the decoded byte count.
> It then reads the len hex characters already in remcom_in_buffer and
> writes len / 2 bytes, all inside the buffer, and remcom_out_buffer holds
> the same command as before.
>
> Fixes: a0de055cf613 ("kgdb: gdb "monitor" -> kdb passthrough")
> Cc: stable@vger.kernel.org
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Link: https://lore.kernel.org/all/CAD=3DFV=3DV1-gNZ8yTsC+D8inePWv=3DA+9H0=
9hWJojQf5NRpcNvK+Q@mail.gmail.com/
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>
> This is the third in a family of unvalidated-length decodes in the kgdb
> gdbstub; the 'm' memread and 'M'/'X' memwrite fixes were sent separately.
> Unlike those two, there is no attacker-claimed length field here. len is
> the real hex-character count bounded by get_packet(), so the only defect
> is passing the hex length instead of half of it to kgdb_hex2mem().
> Halving it is sufficient; no separate bounds check is needed.
>
> Reproducer: attach to a kgdboc console, break in, run kdb's "kgdb"
> command to switch to gdb mode, then send a qRcmd packet with an even
> hex payload of 510 or more characters, e.g. "qRcmd," + "41"*256 on x86.
> Before the fix, KASAN reports a global-out-of-bounds read in
> kgdb_hex2mem(): the decode runs to remcom_in_buffer+0x405, past
> BUFMAX=3D0x400, and the guest dies. After the fix the decode stays
> in-bounds, the command reaches kdb_parse() and the handler answers OK.
> The patched run does print kdb_parse()'s own "command buffer overflow,
> command ignored" for a 256-byte command; that is kdb's length limit on
> the decoded string, not this bug.
>
> Tested on mainline 704340f1cd0d (git describe v7.3-rc3-9-g704340f1cd0d):
> x86_64 defconfig plus CONFIG_KGDB_KDB and CONFIG_KASAN_GENERIC, gcc
> 13.2.0, QEMU under TCG. Both kernels were built from byte-identical
> .config files and differ only by this patch.
>
>  kernel/debug/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
