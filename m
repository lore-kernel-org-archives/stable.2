Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793976056;
	b=B9HjhGymwBaHlt+R0GhZcMaqazW70t60xupu1FsDW1FbOR7v2ncjCn4Z453LZs6wEXmX
	 InubYD9inEsfa2oMS+AIPvh6J00NF4vJh4zAGiYy/TU9V9vWNBkY5kvMiz+YYbaEsbhG8
	 DEQv4hXBZknv8h0Mqs3e1zY0T3D7sLpSCkp9Wbn2Si8W8K8CdRjsZSG8BIfB7HfELKw/B
	 CH3lwwf/NfAXQzzy1YKzYtpen8U/6lLd8LnYQsF7vvI5nEgKmk8v44LJNBltKVmj/iV+Z
	 oSNj57UiBbcH7+MHrGDCepoMlt9RhZ8XQB916JWqckJ0mcOA+8YQHBGTcKBoQAO5Y2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TZiy03HEnuE1C3/pur5HMVOzRnpakc/+/DX1upYZ9to=;
	b=WBj9mcUNERbBzb3Pf9lYYYbfJzsNw48MJ5QAzgrDW98QkquQZwzDC1OsjlHPmtlA8S0t
	 Ouuvf/K2VWEwWijAPbnegxQp+an6pzoC2vbY0EGDotBaeyx1kC/A+tgh8rDuCwpyArsI4
	 RSBxnWHIZQ2pS995PEt4cXY7+Fm7W5NRIeu6M9mgdJhmDw8uYNOwusp/I3FKcNlDWiu/Q
	 VoQn1VC/E9o/fbzKiYbmqaXtO9W7vimmGi2N8yV3Sh3Zd7PB1UgmO5bGxsyrtkXoje1bJ
	 v6yaEzsCfmgBOBMDj8x02/9T6vUjxnjrcnK5bYX3qcH0JHW0KI4lFVlaau4kzYuboKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuEISspL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C08606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C08606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuEISspL
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bb5afa736so114621eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976055; cv=none;
        d=google.com; s=arc-20260327;
        b=KDrVkvHryjz8YG9FiBCoXhXqOXuQgLRc44dksZR1u+7TaAAyXlmhYLz3zCsj28AvAX
         JNWmX5cfhFcd/5rIDiGZQzabsOB54aHiqh7dCOgyxuJ5XvZU1Vsibol8V9svkpfrYr49
         A50jPS9Bao0l3csah/mu7CIe5TPGFe+Rby3Qc4oupflKMtP5Os6rLze+qzN0HWLsSw/9
         PyFugTOxeOlyDN1S0jMc3a1irX0+gU00f7Dfvlo1xvh8JkCakohGxWxWnw4+gBxKnf0x
         Hy0X18sDB+J2TSmtwEUOO1dknEMsFrveb8qh0m1HLySzWa/UpLa5821wLy1MPWjWliS7
         ySsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TZiy03HEnuE1C3/pur5HMVOzRnpakc/+/DX1upYZ9to=;
        fh=f8URWBPNfV3LVXA4YTvMsebsYAOS0IIU7aS7orvnbTg=;
        b=AzQYRRZoOU//xxa245eBbTdkUED4jii+wFjyT0EifXJN/Edu+pFK26lTJXoVrXLegL
         lF9MNL8/C2Rm5gZ7V7fz096nQERt3X5WmnX/UrYfhu2xtriRw/hvKNHqshxcnQ4Uvku7
         QojAFNqCBIbUkUCb+A15xGJKuQ/4bHAkLJ+2QGS3WV0DGAcoxhm8T+orwjr8oioei8DV
         X1P5dRUYa6xQ7x1IsjZEjJM1EWUn+dkxlX6Ut6MC+WbjScEOrm6N0ShLf6oVWJjtWVu+
         RT7oBD/7JTnaw+R+gspY8imhlBnTroPJ/99y4hedTT584tq4SX5ptU2r6M1LNbpP8OfU
         DmiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976055; x=1794580855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TZiy03HEnuE1C3/pur5HMVOzRnpakc/+/DX1upYZ9to=;
        b=kuEISspL/4Sh0IlEStaI4LWceGQz07faYdkRWb5Paa9aiKoNqNDzLn2czTnL/P3+Fp
         kwWTSXYVfV9KOEO/o2NXXbtfUIGc0SZYaYPttguQj247ZNZ1CeGmbQwA2lYiSPuTHhmx
         i33QL7yifmrTf8YDuMelT2ll6wdl3tHHUaiw+JbRENmkX8q8PkGG/j2JtaZBkGdB3XiP
         6le404NEXAspfwXYaxBYvaXZX8v3y5JQQL68wRjSjMlxS5kIu7GCnMcq+lx1tqmZXTAl
         3ZVqDAgDJtI4PBsdH0GpYaCHlnN+zw9bICLVGjIRqGb8V7Os+Q2lCGupGsfa9c7Q2bR+
         egZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976055; x=1794580855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZiy03HEnuE1C3/pur5HMVOzRnpakc/+/DX1upYZ9to=;
        b=PUjJRwSK1XmYyinEuMu9x/P1WTuR6Pbf70Q5kHm1IAOi6+Rw4jZ19xAQdz9xmcoqfM
         y3dUElYYV6fs/jH29Lye1g+Q6Wp1UX/ktvIFHW8RUIEjSBt2VRRXT0DDtYfzHz68lArt
         8c0XOQQUQLlTect561fzcsrzBioSkljnImI1rW0KqQte2L3xurapwIVaypcxpi1FsCWc
         BlPA2zf3I40XUx9almoPpGysA/lmBINR20wiNtdQCQ0kiClsmNlWPDC2LY+L3mBYuquy
         CfUuMaIZI1tsCUd0rETr8OAfULv46Ap5HIe6ooTF2D3ApHtMdyPYpRVdO9E66XBdyOIL
         JPYA==
X-Forwarded-Encrypted: i=1; AL+hErE6WdDB7302pk++QGSVkZIj8fTgd6LJ9cXBamMul09Ulab0EsNTd+Dx2GXkgI6VOEsuvpVMqss=@vger.kernel.org
X-Gm-Message-State: APuU4Z81W8A+jIz1m1LC7rpecJNavcHaAHU9SFQrKoBikEv+nt3hz6sk
	ocexX26U7bc47lgz20bzXGNJGEOT436T+sjZzT8258ZK34Y/gvTmly8PFqLKGk2ZpcatINXJHbt
	35utr5dZCKqY0s2jMZGMiKEbQ6NQzufM=
X-Gm-Gg: AYBFou0mo7MwxzRa/7RenEh3z+UxmqRucnDfOa2QW2J40HoZippjDTQ3ejtMq3gKEtm
	PjKotCqTmgvjwss4iyJfs9bgdjrsSWdRksG+1Mi1oLos67FtL1/rlkfovooWvmCEUlH2dnw8jy6
	C8PApy83SpgMbQebNX0kCRgWJdAcDOOzEUo8Bt6vjKL+nsZDdtveqk8LYWK28gMW6KXhZR9lCb6
	C7T3zEUcQy22kF1oXur307De1KhYG2V8Tey9VuinYDPgu+wyrYzCi3sa7/0dybzQerVgEDS35EY
	Dzb0lcqIGhVt3X5jSTJsH8pOr0vqlM8ANKOTFuBDYiGX2YZNHvPWf/L8XZYlMD4OTzsHfTUAEUt
	/Nm4dg77w1WLodmShEmxSpR62fSabslw/jvLPLPoWVdadEksuwFRicnqJaWnxVsKPrF0j/d+HfK
	Lml4IZvGnp37NNBJDro1fJF5t3ReeAYc2ezjLFYJgBv9VnXZGeQgk0UWHCpZdKjeYeF8et6kfbD
	rb5oeN6+ml5W/53wneO4iZB4plvQ5PTbITp
X-Received: by 2002:a05:693c:3f02:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36f7700accamr5071193eec.2.1793976054792; Fri, 06 Nov 2026
 06:40:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110412-blemish-tinsel-f7cf@gregkh>
In-Reply-To: <2026110412-blemish-tinsel-f7cf@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 15:40:41 +0100
X-Gm-Features: AclHuK_6OBxWKZIDFePe-LST-Waze5HBFDebi83ilhT7ldAc7DtXp-8_wuidHOo
Message-ID: <CANiq72=ANbEDovJPNGj5UbVtbonfZWOD5_4Rcg6n_UWJ7KDBvQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: dma: declare cfi_encoding for
 dma_data_direction" failed to apply to 7.3-stable tree
To: gregkh@linuxfoundation.org
Cc: samitolvanen@google.com, aliceryhl@google.com, dakr@kernel.org, 
	gary@garyguo.net, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:14=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 7.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This is at (as a series):

  https://lore.kernel.org/stable/20261106143802.27907-2-ojeda@kernel.org/

Cheers,
Miguel
