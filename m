Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817828;
	b=ZlHQnq7wfYmL0wW5RgTa3UT/9dbCPV3srkIXGd6m/dSGAauESKH0JstLZOtXUL0HC7sm
	 iRss2pceDlFzGIMtVqOTcDbjO1cJttp4AcIVFTs2OQAfObJM3WFF6k6/lC7gJjhGomz2l
	 kWAYRyPA44a/UxVeKpqOY9zoiAo5QkTHyIqgazznOzobZ/ERG4GJlsEpd3XH1fX33RazL
	 SK8a3ophyC14ZE6jMHvjbQMUmzitB81vio2CWyi0zAfwEL1CowXRqq3AgEOtO1LmJ00Qi
	 yZ6COwAQlERMX0Lf5yAJfMeBhWtLdMW0IZQBQG6JPpwTCUD3NQzV9CK602QtrlR6E3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
	b=RWCbQ/uqh9Sw3UJw1K0qrGVBjlCfix7HgQA99VFg6q2XaSCC9yyFQ7q0n8JgPHor/Uer
	 jhnwiY3usU7CxbxkmDv9sLkw7Jds3klH9NN4kv0DoSD7KSIt3egZJEv6UvPlR7QQDk7Qt
	 HCtnpC4rrWljRpoOeJreb9fpgmBGKJobF/vldEhIYq3jQpX4KJMvJnzhjHLH1e5rmRp3E
	 F8lNDhGjArh9AZvCM9P957kI9iJIj9rHoOJCHfV0MvURpLVwSpbPNZDaKwkMuknvIDz8L
	 451LTd1HnvhzTAVEr8kZXF4km1P1ZsojJzcA3SBKIKJIFV3XUpPYjkleW+c/FmFBlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k30JlQ6o;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6067606D80C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6067606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k30JlQ6o
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so11238805e9.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817826; x=1794422626; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
        b=k30JlQ6o7repyugxA9okX1WWvW6FN3Y4mpdmzV+MGsTzBfy1md0wkJiqBfaFhJQURl
         FPHzitUXV8s8533Fr9N0pYiIPkywsqJKruic30k7FjbCgSU//FVm/XcJ1jGjZ+NH4Ne+
         SAYUaE6aeRgyWb2OpIhhH5493oL2UgWIgEpT34XZNaZ2+CuxKMN0zB8j/nXrzuH3/kGB
         6xWN8+ZyL6SySKGXH5J+vL4ImsKy+7SUK2I4orbXlmYwjw+9veZiHToJQDfvIChz10oQ
         BD9Ly6JywQbVg5LoekOehym4uYx3pFxXWW14Ka/xum7980kpSXVffYlyoiaBRmEYyJmX
         Bu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817826; x=1794422626;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
        b=wgWnp/MgLvpXHUR3Jweh6qZEGHKq1CV0aICl+uPof0RaQT6fNKMzSOa7etr/G0K8Qv
         HLj+1JQvgbRA9a91ZlOwK19AHFK0fmYBQ/AZNLm77GAwwapnVj62EKv9DnhEDJwboaKA
         7hZZ1b+Q4wkMUTUXEExLlzTN9jj4acGFEPvuGv5/gkeN0r/EpOSJ4dE4aNEvqXE7a+zt
         PBMnsb6tTB4P+bXlnVhal3qTS/5/R+x7+5px6Mk/wVhIHEP0i2aO505XYr1MnMwD7g0J
         3kqbhwNFiNPM4EOcDkBg5T0Bs5gNxj5ejWRl/joOqmCiutU+vG+A2ZJX48C/bNUAWTrn
         T/3g==
X-Forwarded-Encrypted: i=1; AKwUvByO3fSbWa5G/jxeRJsu0gM1QMu9BAR8JtnrAxsVdRBmPkXNAt+35fXCf1MSx2u/Zx229RCwsqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z91tsD0ofuPZMFJUugWYNRSlpKYyVsoIHNqRyRhZWKnbMRI6+9E
	TKSZ5cSNTuMA0YFBeckCe/enFSIksc8zQR7ettnqsdMSjj/9UoX7IZA=
X-Gm-Gg: AYBFou0dVjza+JWf+8pclm9gNiNdSraswE8Wsc0FaOXA58rT62oK3Xo7GiquiNggC51
	1AHCwZRvqki/y5WlPySztUfIU6kPtGDsrlfDn2T+g1NcYD1kdU6D3lwqctCra+x8F7tKOXpuKLm
	wqrsAv9Zw1yXVyICWgMCiMsaShBdklIsyodZ7Ztc/uB+tsQE/yTMeZnkLC/2SFlt64j4PfcOxjL
	oOkKWwZAa+hWDwpXQuCQCFk6hA0vY98h6ioCOLssspSgsZ3/fX8LD0ofDKJUZgydMbfpEJbupkW
	nLMAKzHsLNCMJMewF4mBopOPBEeHqLD4qTXmhYCJrL9IdlIffu1L8ZEFD3iycy5yP855IFtIV4b
	rq+rtwgk1U5IsD5ZL/3i3jVqSg5ZxctndRjAgCxj3PBPH58QlGu4F96LT5DqztePpmIyULaAQ72
	Ejcc4MKJscSVtvIjiuIEyh5Kql92Suh/eqRTCGjxAz5u/TeRg1jj8EV2oz/ve8jGL69e911iM7I
	7fiPETS/M8IxbOvtEgNEfu03ivxZX2Inym+rd+gqfNsOWQclHwX8p46HvUh3limVJZdbcPJ88LQ
	UcAu+ULQP53gukM=
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr379507765e9.34.1793817826186;
        Wed, 04 Nov 2026 10:43:46 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm5320098f8f.41.2026.11.04.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:45 -0800 (PST)
Date: Wed, 4 Nov 2026 21:43:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Mason <mason@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH RFC 18/38] proc: don't WARN about a name that is already
 registered
Message-ID: <9cb48eaf-72f2-4e9f-b979-1ead58deb22f@p183>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -401,9 +401,10 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  	write_lock(&proc_subdir_lock);
>  	dp->parent = dir;
>  	if (pde_subdir_insert(dir, dp) == false) {
> -		WARN(1, "proc_dir_entry '%s/%s' already registered\n",
> -		     dir->name, dp->name);
>  		write_unlock(&proc_subdir_lock);
> +		pr_warn("proc_dir_entry '%s/%s' already registered\n",
> +			dir->name, dp->name);
> +		dump_stack();
>  		goto out_free_inum;
>  	}
>  	write_unlock(&proc_subdir_lock);

I don't like this patch.

WARN is there to make bugs noticeable, /proc entries aren't supposed to be
created randomly unlike regular files so deleting non-existent name or
registering twice is probably a bug.

Now, some names do come from userspace but it is up to subsystems to
find duplicates and return errors (and sanitize for dots/slashes!).

In userspace mkdir;mkdir returns error second time, as well as
unlink;unlink. In kernel error is BUG/WARN (like it is now) and it is up
to subsystem to evade it.

	/proc/alexey
