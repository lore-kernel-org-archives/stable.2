Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708073;
	b=YdHuKunhhQf5Fxnot2FfHimSnuiYZeiZ41Sql5dq2wsN7rXSOu2vL4Yxm18yMWNbpTV2
	 hln8ti2EeclnUXooRIzcrxFUbk1Ti1ZzYdqU+lA4KSpC9lpSeChpPIuGZWvEfhKvXczvZ
	 ScGJXZtBYbB9tztjJHC9IXEhcSc2wSFwTMnrjGEJXA1vOK+0vlLh5q59n3GSXn89rsIyd
	 y0SDqqxoozdVWtZeUH3beTAgtXNtoYJ/jFlHhJPGTGurhxYVZb4yNte9KLFSf02RIwtNH
	 drF9VWocc78DBcsIq+rJ+Gq/jfqvP6iX+yZIrnb18w6vuYeICNa0gbWcjHqmMtEtxpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708073;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0+Ld7/Zk4WiQZ4amubX4SBRwNoPdKGg6LiHRcby0zgc=;
	b=zlBAFH6PiLDDos3x1Q7WS51dyhe0yyslaVsUuLVZGLtaviUcmROccUG6u+a+tROFzwA6
	 ++yS4IrRqoLP75KCeiN7+A3HVu7T8b9BJxtli+/gI3+Z3jMyKcmkDO6JuVeYVnbDugd8J
	 7fOI7d590NE5sT4ibaGKmYGE4a7bZ8kzNqedJCALf2eeVDHd/MbNKEZKAET8d9y9oBlH4
	 MyGT803k4FaDU1YZAPL0Iq0FjovL6/cwEIDlMzLx2eUO6GN4WulO9suPfB4KEri6UKmja
	 Z0IBMHnhSlhsbVZ3tCJ2+i88XftPpxQtMmY90gCqAn2ca5bybNFSbS0x/Bh4D7k4Rgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QopKRgXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F3606A329;
	Sun, 15 Nov 2026 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QopKRgXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91E51F000C4;
	Sun, 15 Nov 2026 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708073;
	bh=0+Ld7/Zk4WiQZ4amubX4SBRwNoPdKGg6LiHRcby0zgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QopKRgXq/b0ogJZ4Ce9OJK+sphWd5vDDn8R3wfzQ2YNg9eR845JciRUT0cXA2j4Kq
	 18PtXjIE1jhWPC8IflsmN3rHN0O0OSR+V3PqVPrEd4Zqon/1kskvbrdwowbcZn3FT1
	 u3ym2FvlvcwhoXNcXB7uMmA4mXKSY8KBQbFYt4sh5tYev4refnIxt0MPCohSIxRERs
	 +3AyQVTv+g8UsnMsBqHNcYUYUM/St4JvqGvoS5aHyHlODlL4bTGWf/s4ouRTFrmxqy
	 gUKz/YexeAWHpFVQrFH+xG1tL2Z6DuAMVG08PZT8ZDa0wkswp7swr6wNqdn2NQ9sGU
	 GEmnF52Cdqo/g==
Message-ID: <40839783-b23d-41df-8c71-19fdcca00323@kernel.org>
Date: Sun, 15 Nov 2026 11:01:10 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] ata: libata-scsi: reject reserved bits in 32-byte
 passthru
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261114014801031Y999WJfhmUrM7FRlZ-2Qf@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261114014801031Y999WJfhmUrM7FRlZ-2Qf@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 02:48, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
> including vendor-specific bits 7:6, but libata interprets bits 7:5 as
> MULTIPLE_COUNT. This rejects non-multiple commands with those bits set
> and can print spurious count mismatch warnings for multiple commands.
> The reserved bits 7:5 of byte 10 are not checked.
> 
> Reject nonzero reserved bits in byte 10 with field pointer 10. Skip
> the MULTIPLE_COUNT checks for the 32-byte form while retaining the
> device multiple-mode check for READ/WRITE MULTIPLE commands. Also point
> to byte 10 for invalid PROTOCOL. Keep the 12- and 16-byte count checks
> unchanged.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Damien Le Moal <dlemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research
