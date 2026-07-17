Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2B37AA98
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267239; cv=pass; b=LKq5d5fl0esX5xdLca4KbME0TVVO+qp3yKL2xsE/JzUtvbJlkdIe3j/4FOh2EZfq/K6BstdS1Gb4pgXjXzyfDb/c7/G5nX0xqlfslcM6XsGehsKeF1E+chgKGkNGKGb1YrewRcoTfqwDIQc/4uRMruaD9E5PmaWKVW3Ab6Vyzj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267239; c=relaxed/simple;
	bh=/0yEoNbcL6E1NCkGiJMMHleLznfqzreX/5EMsmJztsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q18Z0oVqTCGnjuysDtEn47DtZkoVxAuHTOBZP9/on3erC2RLbsar1EP6iKY4nX7WoTMRD82e/btsmOyqPoMQpXRBJ1gEohJMcHoY34w+UQNYxMYaPA6F9G/MUo0mqmjhRt//2TUnaGKEIa5nbRJkt+OVaXyFYb8X9p8Drii4nGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=i9cIuHd8; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="i9cIuHd8"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cd3fd760so848436066b.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 22:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784267236; cv=none;
        d=google.com; s=arc-20260327;
        b=pgzRr9Q28NerEGxd7bFXSZqVRAcPjah8J7vsj6MIe+Bd+4QFpOcRTf6nMC6z6TVlYM
         /ZYibYIP/Hw5vorwDwVKCdbO683JCSj3DN6hF6AMwaZWRbtyid++nKd8Mqg+71z5cs8I
         xmCqUxqLAR5qpx5FdCVPr9eOinjHLoUfdXC0sGxZC0E4XgeBbAfhX+GFxVS3+uN5XxsD
         +m86Iqp1+J5ANBYCeZxw+IL2A0F7cYF+oFZyndopDx7aXVr0PrZ1OcY06bpLygGGPSY5
         S32mKkXsr3Zuv28bjX8XkM4E3B2Kx5xfWhw3fGWonIVdyZCnx3+VHjihdqJPbR4EkJWg
         Fe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0yEoNbcL6E1NCkGiJMMHleLznfqzreX/5EMsmJztsM=;
        fh=GdWk/4DA9Tr8bTgEJ++5A1Iq2TawTLzBILSh2TOtzms=;
        b=q5BooXqVfK7nzQyB1sTJcAAyTHUex++pt+neJSoD9cR6v/1lXIS787Qe7m0TwfMIqg
         7pnie33TUcx7oksP/bpZlQwvz9Zt03hYPj4RABHaX3XWkvyjhWBZ+jNvgciNULp4fyN3
         KaJgVk59app5fQMA6MELM/bo2G9EmrCei0NQnI+GW5C5E1cHhmTSnpYGmn6evmMc/1Bq
         rt/VC8san4AfzGlYoBTwUJ/qdmNxCAxQhwzDnW84iyvZexnGnOmNe6rF2+ORfI2oHBkn
         UZSQ4/IW2yHgsISuLoIflrYUaTsssn5Gu3TBI07kjpFpe0e7zRr1Ji0W1+T6MYytGSBO
         5Gtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1784267236; x=1784872036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0yEoNbcL6E1NCkGiJMMHleLznfqzreX/5EMsmJztsM=;
        b=i9cIuHd8rT5CGX6LXYIGbYELkHx9OCsFt4e8pMnETK6TapwQKkWBbYrDttIE2zHlyQ
         z7xA/rHd5B2vXnNXJjO3vCWUSw2O9Rbv2NAAX9q/hspH0hPA/TWtA7IAWW2IobubZNbz
         HHIrXAlhSa63ZMHUqyi5NVN5jWbnUl1+rAbMQcMir1hUS3r2L+2cFmpV7oAvQYwyCGDS
         04h+ng4G6yDxtm15xPptfIl+hhn3yn8AwDbXdlHONSY4BwSzoj7bbpfKAdWdcUAuFhGX
         /gn9N8fZ8bGlyf/9EjjwkSBrS1c4qWegpSJzKiz7aczE4gZn0GXzgaESyyP4W5QI3cgD
         2HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784267236; x=1784872036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0yEoNbcL6E1NCkGiJMMHleLznfqzreX/5EMsmJztsM=;
        b=DGfUr2cg6aPNtz3J24WUUEpcy2iIPvNj/3hF1s+1EVk80bLFtGK60sCoKUKxrYBGpg
         3xf4m/I6/GuBW4I9LZWIogsSjv4oAmtKhZ8iCpemvDpsaPlEFpjg1OASWAZbqrNlEouH
         yu/8BYYsXVgvaDD2HRJOR2mjw+zTlbXhmzww3v+Y5teJV+/Vhkc2yqeAJkrF+iu5qrhU
         NaYs8766vCUB0vo9Lw6waOxcF67sMDjCHe09o/mGgP/JIHU1EF1K/zJArc80UwIJfL1C
         vxOmO62fU6EbcieWT+iEa6gdL/7eafTk8xRw1dbX7KSNY7cbZe1oR+7srln5IGSKjVeG
         hWIA==
X-Forwarded-Encrypted: i=1; AHgh+Rrwao1meMt1YLCVhyeXnN10TX0rcSSNGUQQ1+uwxo4pnV7NPjXSdVDbc5Sxf+lAJNsma+yT8tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGTqIZZQbUsCFzQKXdiS2T1lqA0Fyv1Z969wvDqCEEguFu4Lq
	PVxJECDkI2g2FVnap789EpC44/8KiO52KhSuQjLDdsovlHopMZX6wBBhTIxZjppsCrbR4xBOQOS
	lpnIRJE23kgECGLV9IbDiVW4F2AEZU/gv6unmke4jFg==
X-Gm-Gg: AfdE7cmynxnmAuX1qeSbfzua2mWq3HHatcwaxB2oamoKveiJCcspRAJbGI/xM4KJ/MA
	rU8QNLPI/DoLa6UyO7QYBXvUCO+5dxRoxyGny9boHwU4qcm2HVqlVdjLiecVfbZPdsDZb8ctBGt
	XR2IIQE3uVQNEfAQqa94Yda74NqSsnhiCHoKlK9fga7CfA7o0Acfy47sM6kxDe/TXLHoQXRva3s
	OMyMO1fAH/4O4sUlCjG6ElucMBxOUK0vLCk4IqVTxdbsIoKWxQkOnrOc0Or3lx1q5Y7kBG/WKxv
	MyDRuDSwIeLQ1hA=
X-Received: by 2002:a17:907:c20c:b0:c12:85c2:3604 with SMTP id
 a640c23a62f3a-c16b4887e58mr36632566b.63.1784267235923; Thu, 16 Jul 2026
 22:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713102229.1598812-1-max.kellermann@ionos.com>
 <20260713102229.1598812-2-max.kellermann@ionos.com> <E3B8944B-6045-49CD-A72B-0B8F6C42C713@dilger.ca>
In-Reply-To: <E3B8944B-6045-49CD-A72B-0B8F6C42C713@dilger.ca>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 17 Jul 2026 07:47:05 +0200
X-Gm-Features: AUfX_mxEf1vqViqxCK4SGqcO38mxaoDUDybvsfszFwktj7Km6V64OcOHWuqM2ZE
Message-ID: <CAKPOu+-ATGd8A_CeO1bW2A2sN3K_cbcimwHO5M-HY-AChsOmuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] jbd2: check need_resched() when skipping busy
 checkpoint buffers
To: Andreas Dilger <adilger@dilger.ca>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:04=E2=80=AFPM Andreas Dilger <adilger@dilger.ca>=
 wrote:
> One question I had about this patch is whether the list cleanup could get
> into a livelock if it becomes too large?

It was a livelock *without* this patch, because all CPUs were busy
inside this piece of shrinker code; one of them holding j_list_lock,
all others spinning on that very spinlock (all CPUs busy), and actal
I/O was stalled seemingly forever.

> If the iterator is processing
> a large number of jh that cannot be freed, then `need_resched()` is hit,
> if it restarts from the beginning of the list each time without processin=
g
> at least one jh it will not make forward progress.

If no progress is made, then this shrinker call just wasn't able to
free anything. That was the behavior before b98dba273a0e ("jbd2:
remove journal_clean_one_cp_list()") and my patch restores this
behavior. It's not a problem. It's faily normal for shrinkers to not
be able to free anything.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
