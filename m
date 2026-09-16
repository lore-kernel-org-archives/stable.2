Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B4514766
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575358; cv=none; b=Z4yM8bWD9rJ4TcLlNseKkoTM5CiEChvJR2bfKbXanjEvjBa3q2UF5SfAXL4Cg1pzcB4jjk0j0zc6b3ZZsdqfrrkQZEwo8lnEaMb5C/XLYQ6gGDUY+IyTGv1SIONQsHKK6Qzi5Qew9UTSqSYhbcta45ihO6knNblHVkGBqJR8+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575358; c=relaxed/simple;
	bh=2b2EqVDlW+oYzYz7c2LcuNFACAORO2g1/e2NLw79m7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DajqdN7nzHAnkldgLSNUODVGfu0v2W3Qw4RSQe2wB8WJLtQ1EO/6we06w9FfDttQecN+4kHINe89JojCM8uI+srp6mFDcgaQLVX2AB0XCZxKEWtk0BogqcS+qTKEuJm5ApyXBa/JEk8SGSFtxzHEuj/Zlq80GPkghVRkG/ApKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VFf2Yytc; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VFf2Yytc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so245679866b.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789575354; x=1790180154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2vlAcSoWpickl85/r3RIRzpAoJvNR2Bq+srSMRA/Noo=;
        b=VFf2YytcDOi/cGw/tgjdPkyF6sLOTB4c+BRsX1bnTOpu/qZKjXCOesyIWo6NRuT88V
         3nVHAaCt5KsYiKr6IyKa9tSOsRg4F7zQ18ac5N7LmBuOQrDEmYTZLXVMoj3+rKLx4WMy
         beVGyCq/QJnhP+yLu9PzYD3wxc+SE0nufqj1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575354; x=1790180154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vlAcSoWpickl85/r3RIRzpAoJvNR2Bq+srSMRA/Noo=;
        b=oxp0/6rI3YY7bNX9vdb8csvlFpjdTK7d7Q0teF6OkG9a0r8PDnNCRY+Y7N3AJaieoV
         XAV0+eKEu+qxI4QHRahmm39AqfCCeQ12/YD8jnoMX4VeG86SF6aD7Pf8OFGjoR+hftwe
         rA27mVqXYpcUJJDiSflUT2DBkMEoDxWQ+/L4yhrhwNLv9kKlvPIsDnpvN9F/vwrhtwdk
         lQ19gcn2YosPnu58ZKWxOu6AFUVgCesXo3WPs+3Y2ZIdUuhO4zwwIRHIzlG8mB+WYx6l
         fnkFzq2n8AZMOUVIwVd7RlpAfpKyo0W1tud6p7lVT7IVyGzDuiFTdXVpAA42ZQVkHpUM
         67nA==
X-Forwarded-Encrypted: i=1; AKwUvBzmDZPqQYze0Fnem6Gaez1TDwe6Vnpik6y6pJVZigHzLFqv2X2xfUHD8c9oHIU1LgCLSZZGze8=@vger.kernel.org
X-Gm-Message-State: AFuF++lzdMaT2HVP88h5WKc6d2VTs6fykLPgTYtbkV+CDHqCtZcm3cKK
	jYi35yxiz/Gd+dvY3HSGUXEloaJaoncPHoPO9WC0j+2avg51pTdFsogKH/fXGu1Odcx7moGVS/K
	dt78=
X-Gm-Gg: AYBFou2K9WwdefKfgtb5Zriz2dgcQ9Y9UQSQtiOOIA23I2+f1n4cTw26l8/KqsBx3pj
	dmt16gdN0fKfzzcraJPMSZK81k1jxLzzIICG3+6EdKYDoOrDHj7A0Q9BpaUleoY0pTZ4yjMr93Q
	dWYYZbS7gPo0kvoRa4J0qR3W/gv3VzqMjRQ4pEXWhejsp4I3QAIifrfTqa4NsSGA9o0dqSgTDMu
	STStELTiVJP+WE+wr+Mc+iRdtGw7ZFA+/PC9V8IcvrkKIupZFfio1XvGVMXGZJKhZYoc5yku9KX
	HcXm3opWjO4EdrJMle8vEj6er1A4fqVr5Tsy72Ui6pkQhDecMR8G+8s1EbsphnqKI5G+6vJT3gC
	R3duVkLRSGTZZTc1I7+rZEzKT34iQtAKsHOuJTfcuLLaPPXKsm2ZmDlAkIJEI8COeedE8NZ00g+
	7oLDmrFlhOrnRalwMnrTH02ZdwtD5zcTgP5knXPxuN64wq7u/+upf1VX3oCBnmzYeBREL6kqe9w
	ZUUDCpcLApopFhuJkMAcAN+rfLa04UxPVBqSn20HjI7C3nMhQ==
X-Received: by 2002:a17:906:c14f:b0:c26:1648:a066 with SMTP id a640c23a62f3a-c29e5308366mr231022366b.33.1789575354009;
        Wed, 16 Sep 2026 09:15:54 -0700 (PDT)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com. [74.125.225.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de6040b8sm160256966b.48.2026.09.16.09.15.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:15:52 -0700 (PDT)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so585944f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:15:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw1jWnLKotHe0YfUq9jPQtdQ2yCkTlGXGdQnCYh/haDmHPQysM1y1vJMTJt8K4WzcDSUqqMpoA=@vger.kernel.org
X-Received: by 2002:a05:6000:60e:b0:486:e901:e59 with SMTP id
 ffacd0b85a97d-4870d05a86emr4599800f8f.31.1789575351351; Wed, 16 Sep 2026
 09:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916080306.13395-1-fangxy@xiaopeng.com>
In-Reply-To: <20260916080306.13395-1-fangxy@xiaopeng.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Sep 2026 09:15:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_iMwPjdFDrk46YAe7Jkhzkn41G8B2henZJLdHeM50Dw@mail.gmail.com>
X-Gm-Features: AcwNN1U_1ru36V3m0TTMk5skmLw1I8ApJEI2Pm4DHsjAA2UfWKRe8K7kEc_F06A
Message-ID: <CAD=FV=X_iMwPjdFDrk46YAe7Jkhzkn41G8B2henZJLdHeM50Dw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 1:03=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index e271a43..a67ca1a 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -373,6 +373,12 @@ static int write_mem_msg(int binary)
>
>         if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) =3D=3D ',' &&
>             kgdb_hex2long(&ptr, &length) > 0 && *(ptr++) =3D=3D ':') {
> +               /*
> +                * The in-place decode touches 2 * length bytes at ptr,
> +                * inside remcom_in_buffer[BUFMAX].
> +                */
> +               if (length > (BUFMAX - (ptr - remcom_in_buffer)) / 2)
> +                       return -EINVAL;

FWIW, my AI wasn't terribly happy with this patch. I've skimmed the AI
response, and my AI sure looks right to me. Given that your patch was
generated with AI assistance, I won't feel too bad pasting my AI's
response here. :-P If you think my AI is wrong or you think I should
look at all this more closely, let me know. Otherwise, I'll wait until
my AI is happy (or looks like it's full of crap) before delving too
deeply myself.

AI response follows:

While this correctly identifies a real out-of-bounds access in
write_mem_msg(), the fix conflates 'M' (hex memory write) with 'X'
(binary memory write). As written, this patch introduces a regression
for valid GDB binary writes, leaves kgdb_ebin2mem() vulnerable to
out-of-bounds reads on escaped payloads, and does not check against the
actual received packet length.

1. Regression: Breaks valid GDB 'X' packets larger than ~BUFMAX / 2

The comment and commit message state that the in-place decode touches
2 * length bytes at ptr and that a write over the limit never decoded
valid data. That is only true for 'M' packets (kgdb_hex2mem):

- In 'M' packets, each byte is encoded as 2 ASCII hex characters, and
  kgdb_hex2mem() uses the upper half (ptr + length to
  ptr + 2 * length - 1) as scratch space while decoding backwards. So
  'M' genuinely requires 2 * length bytes in remcom_in_buffer[BUFMAX].

- In 'X' packets (kgdb_ebin2mem), the payload is sent as raw binary (1
  byte per byte), except for '$', '#', '}', and '*' which are escaped
  with 0x7d ('}'). kgdb_ebin2mem() decodes forward in-place into
  ptr[0 ... length - 1] and does not use ptr + length ... ptr + 2 *
  length as scratch space.

GDB enables 'X' binary downloads by default ("set remote
binary-download-packet on") specifically so it can pack nearly BUFMAX
bytes per packet instead of BUFMAX / 2. When writing a large object or
running "load", GDB routinely sends 'X' packets where length is between
BUFMAX / 2 and BUFMAX - header_len (e.g., length =3D 900 when BUFMAX =3D
1024).

With this patch, kgdb replies to those valid 'X' packets with $E22#...
(-EINVAL). GDB only falls back from 'X' to 'M' when the target returns
an empty packet (""), indicating 'X' is unsupported. An E22 reply
causes GDB to abort the memory write entirely ("Cannot access memory at
address ...").

2. Bug: kgdb_ebin2mem() can still overflow on 0x7d escape sequences

In kgdb_ebin2mem():

  while (count-- > 0) {
    c[size] =3D *buf++;
    if (c[size] =3D=3D 0x7d)
      c[size] =3D *buf++ ^ 0x20;
    size++;
  }

Here count (length) is the number of decoded output bytes, not the
number of input bytes consumed from buf. Every 0x7d byte causes a
second *buf++ read without decrementing count.

If the check in write_mem_msg() is relaxed for 'X' to allow length up
to the remaining space in remcom_in_buffer, a packet with length <=3D
avail that contains K escape bytes (0x7d) will read length + K bytes
from buf. If length + K > avail, buf runs past the end of
remcom_in_buffer[BUFMAX], triggering the same KASAN global-out-of-bounds
read in kgdb_ebin2mem().

To fix this properly, kgdb_ebin2mem() needs an explicit end pointer
(buf_end) and must check buf < buf_end before both *buf++ dereferences
in the loop.

3. Incomplete bounds check against actual received packet length

As the commit message notes, a client can claim any length regardless
of how much payload it actually sent. However, checking against BUFMAX
only checks against the static buffer capacity, not the number of bytes
actually received by get_packet().

If a client sends a short packet (e.g., claiming length =3D 256 while
only sending 4 hex chars), length <=3D (BUFMAX - header) / 2 passes.
kgdb_hex2mem() then reads hundreds of bytes past the NUL terminator
placed by get_packet() into stale data left in remcom_in_buffer from
previous packets (where non-hex chars decode to -1 / 0xff via
hex_to_bin()) and writes 256 bytes of garbage into kernel memory.

Suggested approach:

Record the received packet length in get_packet() (note that binary 'X'
packets can contain raw 0x00 bytes, so strlen() cannot be used for 'X'
packets) and pass the packet end pointer (or available received bytes)
down:

- For hex writes (!binary): check that 2 * length fits within both the
  received payload length and remcom_in_buffer[BUFMAX].
- For binary writes (binary): pass the packet end pointer into
  kgdb_ebin2mem() and check buf < buf_end before each byte read in the
  loop, returning -EINVAL if the input stream ends before count bytes
  are decoded.

(Side note: while looking at other callers of kgdb_hex2mem() in
gdbstub.c, note that qRcmd handling in gdb_cmd_query() passes len (the
hex char count from strlen()) instead of len / 2 as count to
kgdb_hex2mem(), which causes kgdb_hex2mem() to touch 2 * len bytes and
overflow remcom_in_buffer[BUFMAX] whenever len > (BUFMAX - 6) / 2.)
