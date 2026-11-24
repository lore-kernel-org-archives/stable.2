Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480478;
	b=nG/X+zQAiVQN3cWIS90tmjDsb2OHnW+dpOsUni/hs2yx3SdfHRKQ0qTuiQidWRp/MtEs
	 aaf7kGSZPkk1cFgTmg8PL/635W5O+hOCaUFDuqAod0e5pzZDzRkSpwQ53pkJqhFPmMpYA
	 5dkXJlI1GHAOw9aFkiiDzygEXXiWY8+/45fOq1LvbEXdgaR78s9P74tlTqELy5pWhBJ0M
	 5ACs3PB/nWCKOBUfSLi5RyVo+4+aamXQhYmvCL6o7C5uSBDqe9TNmQCNdkyYaBrIIdwN3
	 k/y7EP/zSY74BdvBrhlAJH4JZCeu3QJq+b4NNiEj1tfBucKP2A5GwGhjrtUNG10a9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=l7RsmPiXmsKn+Pr+oiok7oJbW9rtNR1UkxIP+KjD2WM=;
	b=XokG5MCiW6XvyuNWY3Hv2T5cfIvDsSQUmIJ4Lq9oPekTPjmOHtmtwzdC0z3+wfX7+AtP
	 BScp/v06I/YQ66jI+SCEqfZT7+rBQEawIwWfEfri/KnSn6wFbUwzVn/fkNAhhhsX1zu17
	 0g1Z5O8iVHXfnkN4EWS5PoN9bgZB1yBeSXwqr58/Z7H3xdDTSdZLnags46vdwZx6YUXUB
	 MYFzLDULp9HIBYRY9qNlR8ftDY+LHNW8Flrv3H+E3p6ac1+dy79nx/6fEsdgupMbwWmsG
	 aXS/F2jasAKC84enFZXbQ32/cfj5fmLavEVyBHcaacTggvlmz1lYXK35Ye8HAM0RTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=morsemicro.com;
	spf=pass smtp.mailfrom=morsemicro.com;
	dkim=pass header.d=morsemicro-com.20260707.gappssmtp.com header.i=@morsemicro-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Fl95uPc2;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCD606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DCD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20260707.gappssmtp.com header.i=@morsemicro-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Fl95uPc2
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1691681a91.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20260707.gappssmtp.com; s=20260707; t=1795480477; x=1796085277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7RsmPiXmsKn+Pr+oiok7oJbW9rtNR1UkxIP+KjD2WM=;
        b=Fl95uPc2lWIRLyNUr23VSjU/b4abaP1c5nkdSmtoCKLrh85iqjzNtkD9lEH0v9g+5D
         fhSoOyjdI426VOA181RhnHHat6RimdbYi3kT0Kt/aVO/K8CwlSw8wFY5V4vxRaoJLP2F
         1TVJHq3XMkLsfB7buzrGpDxAbck2qM/2Km/Qrr8J+hehuWDi0t7s4Eusl3hd7NjhVmO5
         5E0Z3RGf04wVwv7Wxt7S/ne+0xb1RSadAB7djYE7OuqIisEqWIvY7vKqMBG0FgEkn6qh
         L4qyAMxwiZNvZkk3q99S0TMP+F1irub7VBBJY2isyF59cFxAyusXqIORZKzoBwucaQF1
         QBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795480477; x=1796085277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7RsmPiXmsKn+Pr+oiok7oJbW9rtNR1UkxIP+KjD2WM=;
        b=DSyUpDFG7EDX9Ike/fBEjKEKsRDK+mCelsi9QOj/J9/D0cWYdSeV544TKXUu+PGHia
         WmMIw1PnOrs6jX6o7ycbXqSbFON8Ydtsz3TpIkJuksGd7S9742KyX5pvyWtHzB96gJ0y
         jMx5ygtxEob8FL17QZeCYmXuv/UuK5gZs6m6tPNRFFptkWxu1QrFM/oBl/TdTo5fdBjU
         Ap2ao4suWl2HTiwZPCifMRImlaigIeIhY9YCCHfs7jyNlC63+LiuXgk3+7xjzaYhkX5+
         O4wZe+PD78NpUBk/M/klySBkzdlSV4P0EDoUx/p9cuxO6OfQk3KaKSXUHULCgJ8bvDB+
         rj+A==
X-Forwarded-Encrypted: i=1; AL+hErHMmD3HWRhS7EZwHrsbOlg04GGl64OIUiMNwGO/J/5uwFBJ7AcFeVU9bpOhinHS3dCW+yC9Ios=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WbrLOC4L+P98/dZZGu4WyFUYFmZ15i3fNaPxfkcgqxZ635zii
	SNJ+svaz4RfQFu67Bs2+wCAbfkdFFwHAREt3HauF0nW7S378gMwms8816seBmEVAv/nGM7PjrpP
	G+FVd6qk=
X-Gm-Gg: AZFdTZdaYmEO1M26q1h6nkmEi3L5VuS6411uOtGNCNHsJocQML4kqviFKSPaD6Ma5Qf
	qDEmLapfasvWUquP0Wd7iSTGsGK3duEusjaK1ZaiFVX09GAg5POsmRZlfI/7Ihm6IHhn9SAzjFY
	3+qSo1UhlGlBo1hnRCfgZEtehVQ44b7KRDhjN/CubVeztEJVY0uwVIPUJVQkaux0MjnX0uoJMOu
	kGGe+0C92JopUNBMaTtec382L7MIb9ZxL9vGj0ZV9EnfME0Gn16ytv4UGoHllvYvd/+9LewztSx
	26ga4AVRX5cZwCGOUrCqW+0MXiGj1fMUzgtU74NEJ9zAASFlSi05EEeJ3+2ziyKfuhPqCWvrx1+
	5LUQwIl3OSWUDOL3N62WgIFUCjKRHbq8Vuuf6GblsU/7Sl3felF62qUxpQClOaTba68FPdJCcS6
	ostNjCsScX4TPRGtyDNhriFT58xkAVS6AzrBeL2ObMGgpboHqvTmNexZpNT6rGSJ7J9ZknWW/Si
	gZYpD3CSBt5ukkATxsZSpisX4B4XeCOwvnQ3mZCpjVzECwGSNBGnY8Z7wywYG8MFV1a1Jm3RRbM
	eP7xCPHTIYFotJ6fM2EOVbI3cXPsZ89qrPD1B26fF8FTiokSGragTyQxtdAR8JvqiOtueplvFT4
	v4mMMEoB9zKNlQQ55/Pf1rFzJ8Q==
X-Received: by 2002:a17:90b:4e83:b0:3a8:32f2:f4a5 with SMTP id 98e67ed59e1d1-3b41c956a0cmr11971327a91.53.1795480476894;
        Mon, 23 Nov 2026 16:34:36 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b704cfesm7131414a91.1.2026.11.23.16.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 16:34:36 -0800 (PST)
Date: Tue, 24 Nov 2026 11:34:33 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Arien Judge <arien.judge@morsemicro.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH 2/2] wifi: mm81x: clear a stalled bulk endpoint before
 the next transfer
Message-ID: <vshptwv5idooqjvdirp5ssf2ofiff6tjhgjnzqgptte556uzem@f7kec5a632s7>
References: <20261121164923.8862-1-25031212351@stu.xidian.edu.cn>
 <20261121164923.8862-3-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261121164923.8862-3-25031212351@stu.xidian.edu.cn>

On Sun, Nov 22, 2026 at 12:49:23AM +0800, YuanZhe Liu wrote:
> A bulk endpoint stays halted after it has answered a transfer with a
> stall, and only a CLEAR_FEATURE(ENDPOINT_HALT) request resumes it. The
> driver never sends one: the completion callbacks only record -EPIPE in
> musb->errors, so every later register or memory access on that endpoint
> stalls immediately and the device remains unusable until it is
> re-enumerated.
> 
> Clear the halt of the endpoint that reported -EPIPE before returning the
> error, so that a following restart can reach the device again. The command
> endpoint is the memory write endpoint, hence the same recovery is applied
> when the command urb itself stalls.
> 
> usb_clear_halt() sends a control request and may sleep, so it is called
> from the process-context paths that wait for the transfer and never from a
> completion callback.

I applied patch #1, but this one seems .. interesting. Have you run
into this problem? Do you have a reproducer?

lachlan
