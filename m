Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793763337;
	b=z+syjadLoDCZMTVJyQK5od5xY1kzTuOByb4IYP4M+sGuyvd3vjSCt/NPv2eGzk+7keyB
	 tIVKafyBx2NNwS6rZB984nNtEJVd9LiLNgCDFIMLq1A3VZKJBsrL5LRlHMIKjUueCSKDH
	 WtBjdEdjEfqWlls/B0opgYhy2Rld81oZLCdOx9TZNnEeBPwlKSnS0owxGkk+EMaTCxUn7
	 svFQ45E5nF+71k9Wjs2SZcL6LkMc3lOpwauDO2uIKO/ZLW/Ij61pMqr1hpzPy7JdjnmZE
	 ZqoRksexOrsxs2rnk8heeKyV6KbkTCE9sZORShNgkAMx4zuGrQCkCsGTP9qh5y5RJLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
	b=5CSDhsq/y0gkahsjBVU7T4rfg5V/7hw/1a+2N/nQCONIpxgrbDarh+LZOyej6RVPwLN7
	 0YbClAj5Un1v5b2iOk4C2/hxp/SuziDTSIkIyg6uDmp8yVze+VfXCHGkNH3sIQb4Y/u0O
	 j43RKnTjF97O+KY38trEigbLXHltuE0wV97Yf+CTDhZLG0Nw6XLkrBIVMjmVNsOpOX6L8
	 cVxsaf40B8gQPV53UklXQkrTiphKgSPhpe6od9XlYOI2kQb9Hm2ilGzdRnHFPg+yoLWL8
	 Vs9sBzSXgfPd8uv7riMYFQ2QnQ8Jpjfx/XGBiDw+leofkV3alBVPe67TKbDCBbcKGgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZM+Bo/NL";
	arc=fail smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F7606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZM+Bo/NL
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so212948a12.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793763335; cv=none;
        d=google.com; s=arc-20260327;
        b=VIa15zx0FGTDWW0JOoO4cElP0el0CadJM83D/1rkpqmsfNFw3colMCaO+ENAvVvMMj
         Pmhkzlr5REdBzK7Jw5HP95BsCVFOheWuoY7Q1LAAwpZ9DM/THX0wTu5X2X+2zx7MtnXk
         E5/9RMN8J4Hf9eoS+SI5lJwnz0cICXcjWt59B5ixWyWjOvL0PmMAHQ4nPviTBgEXqmZ3
         U7NiPx8wIcZ6FwVPAMRbi1zHRzlnCUwXRK3Yq3FzgVCiA9X8H1AypwTuWhwLbiJ0o+1F
         FsG9aRLT2UbATsWPrAtR/IVxlrZvqSJ/K4j4knGC9EIngga6od96j09td/+Dcm9TVOJ4
         iCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        fh=HMo5LlUEu2epieyJUxZ5RmecUdrErMg+1EKhMHGdK8Y=;
        b=qQ6zElQBOy6ZT5sLP+ZcuHsfp0c6hWsszLuuzaUF4i729MjjMe76M1yNCWgEMRZ0YN
         kbwPZu+D8DR3uoFdB2KvYC2NMXb0cVqYOJ7u29vJ1utf/0OjoErVKnPsVNKFqlKv3bXr
         Xt4zcGF5Oxg4P+NO36zIfSfCxM9o47eqRgmWrRa8ySKifEDYEdzyxPz77Td0m4cgLLf6
         x2Fi77GwnIuluhgJj95b2B+0JghhSIUMsDuW4OmrVDaEs13L46x+PSZxZx5o99wgRct6
         rNNu1w08OX1g5BdOW+ZX7RMp3j7hA/3tWM4oEhRyummAHLGOZejOJGe70B4SoCtIrZvv
         a89g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763335; x=1794368135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        b=ZM+Bo/NLHVAIGud/SRt1S82BHSV4Dy3O/1v/XhWAygF4W6LC8LJ4zz5tAHv0DKZISK
         y99m2Vzu9GwsILtdlsp1jaTwouR/2MYaZmRoQEYGjyc1l9qj+unLS29lF5agI8+M5HLG
         0zc9jcPKe0IbDIAMcl9xB1IndX3PyX1CtpGmg1HJxmIsKGflGof4vnHMxAw55W1f/Wcy
         TbkSyTfpug2hmzKDyMDSQkiLuVmmUM8//uoc5GY4fuYPaFwMt86KGBfg6K5Vec6Rgfxj
         N6E6our0/WG7Rd0Xd5gyJ6hair+/K9LSmfSxXKasKFEs4nwWUykQmzxp5ANZSCoa5RCb
         IoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763335; x=1794368135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        b=oFKQjJd8bksBzRqCMpI7zfglePT4Lf6lcP6E7uKor93uYWMOdQ2d6gERuMmi2Z9tqr
         ijNZT3IywL444zsuhtPMn0+CodaUEhcdQSj9kWMEQa8elqlcKvvfBFl+uPwVauAUEPPl
         J6qMuz0O6PBGIP5uER+PbARzndjfEUO+mmJeo16vb2+EmldcTiPa7FJApB/vZAdn7sEd
         I80X3iu4rCWYyahEcZQzbMsy6OYseX1t/3zZulMr7fD8jKZ9yvIbDzUGh4qvQXJovKnT
         iZAu4IbVCwKwUs2JLJovviTiXEKSLf7ra7Mn9kpsOWrTChY+KMTbKjA8D8L9h1Cfez+A
         QJhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxl/zqs0tFA1gD9mjIuOSK0uKayVGLSMs7rthC+x/8QIAxjVG6ewgZXMTikCUog38H7lDH9ss=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v3cTAE/5Weo9LMX8HGge+kbfOIHRtbfFXN99y5JPK8pVXxoJb
	7GjMBN1zNGsPyYpUrdW16OXHtyfZuhBuGPnL1iuAK3KcXgVWPNgGYPaH5dOP62UH8Ccn2soOv8Z
	UySkX2PXYdYvI4F0DoYrWAZ42RPUfKDc=
X-Gm-Gg: AYBFou3+nRZuHnwCYNBvF5CcK5d2GiKWQjQC97/G0+qqh/EBztRrrnKgcj1Loe9zaDJ
	dFiS2nrWSAZ4yp8Hi/Dc4ylpcwPtUGU/15iyhE+9kN/Y7jNi38LAmhPItapsDrTgkd/K7y2RJku
	fJkPcbUiajb5MXcaiD5OlV1lzmEYTkaBxZtbcw3M3ZIEdIzrhRy7XO3duRYR7i0Mfon3QXEcXKc
	ETNYiyCGvoF20yh1m3MOdhK1CxNoWdi78dYOIlZPEJAeRkIySKHcV49gaEapVJcUUIOGmkF4O1L
	a4upJTYs/YqS/WX6wu2tCTlx9QhCTLIzWqPnT3xiDdZ49sjI/O7sqqj0qtcBLQriqqIFtSEMysy
	qVV4zbjMnasTkwC7wxx8g/cpTY01mgedz+VWXkA/X7hbwSR5CHZHrF5Km+1wUwVQNvajRQd/zD6
	M=
X-Received: by 2002:a17:907:a890:b0:c46:9ca9:f522 with SMTP id
 a640c23a62f3a-c4ca7a69782mr1214812566b.26.1793763334986; Tue, 03 Nov 2026
 19:35:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179374297269.488856.7749172366095110113@kernel.org> <20261103225321.19288-1-federico@rimpianto.com>
In-Reply-To: <20261103225321.19288-1-federico@rimpianto.com>
From: Chris Snook <chris.snook@gmail.com>
Date: Tue, 3 Nov 2026 22:35:40 -0500
X-Gm-Features: AclHuK8pgXDdUe8VVPBSwoSm2Xv7dqRRsi3A56cCZ8EmMNgChDd3Wu0uj8DEEoU
Message-ID: <CAMXMK6uS4-4aq4A3pUMghkt5v3U+NekcCfDa7ytbjLD5ZwG+8g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor
 reports an error
To: Federico Musto <federico@rimpianto.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:53=E2=80=AFPM Federico Musto <federico@rimpianto.c=
om> wrote:
>
> Thank you for the detailed review. The findings on endian decoding,
> multi-RFD error handling, stale RRDs after reset and missing error-path
> work accounting were valid and have been addressed in v3.
>
> The v3 now:
> - decodes rrs->word0 once in CPU byte order and passes the decoded RFD
>   index to both the unmap and cleanup paths;
> - unmaps, frees and recycles every RFD of an errored multi-RFD frame,
>   with ring wrap;
> - counts errored descriptors as work so the RX refill runs;
> - clears the RRD ring on reset, preventing stale error descriptors from
>   freeing newly reposted buffers.
>
> The memory-ordering and link-reset/NAPI issues are pre-existing and are
> left to separate patches rather than expanding this fix.
>
> Validation on netdev/net:
> - scripts/checkpatch.pl: 0 errors, 0 warnings, 0 checks;
> - baseline and patched W=3D1 + Sparse builds both succeeded;
> - no new warnings; three endian-related Sparse warnings removed;
> - git apply --check and git diff --check passed.
>
> The issues were found by code inspection; no hardware test has been
> performed.
>
> pw-bot: cr

I no longer have working test hardware for atl1c, so I'm unable to
test this on real hardware. The same is also true of atl1e. There have
been patches somewhat recently for atl1e that suggested some people
are still doing work on real hardware for that one, but as far as I
can tell no one has made new hardware for atl1, atl2, or atl1c in over
a decade. If anyone is willing to help test patches on this hardware,
please let me know.

- Chris
