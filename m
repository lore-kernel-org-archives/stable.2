Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896041;
	b=M6WJOARlZ4opKRyD7QKG/zZHwrkguku5feOxD8sT9egjaOUBuhKkCYeLZkAv5v5nQLjm
	 PgfqYXUKXmnQou5p9FIqx/QAhoK+0H429DAf5+BBBuL7bzMJDh77wmrubNQCCXWo5pZSF
	 rpw4IZCbHeZGLpD0qFAzHWON3MexFGSubpMVrHebgZPIxdEDuHoCQIoVN6EJ1iQEWMo42
	 adR0VWKMgt1xuZ6eEQ5ASdl62BgByFSUU5609sYukBnc+lnfly+1mXcl4rtJ/d0cLQ5ou
	 WON7qt0zMOLF08ynE27zOTasdxAug2dQwQzYV/ZzpVARPb3LQyGVEv4dyxASSPtPB8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
	b=hP4vbh7XpKmEQh7IDCMPXGXei8pcLv6iVdlOxw98zDINT/oJCTRPqdvVGEANXsBtgsjo
	 p05v9RsKf1qi0af6s5Rnb2WQZ9ibVBoYggSu2HNdCNUvJXQaLzmn1FTfNYO4t4p3MRKbw
	 g5awk5esTAPA5Es27mX1iRKKtOnLygSNYUwGQqBfm9xsrQR0tUyNHtYPKTBbMxjJPm1gf
	 xFiNy3xALlmaFi8qsChRjuZ65ON/S+ZApRfgpOCBwhR2bR8MX58gc1ugUlBOQxudegZ2F
	 pmC+zi2zVtUFBDt6ftEfibAjMgMLJyNxGPgvlJmtJvLawc4GcVMiNt8xtoCXyDu8ZnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAdWmD8J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB2606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52CB2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAdWmD8J
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9f6a16afcso68515ad.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793896041; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3wdMINJenlVivZwe8iy99isUusLm9KPGw6IF9kIjF23XGtp/rsL6v7HUdyvPMKEOx
         5b/FA3pvqy5mUZZeMO2fwkFhXTjPqgunm2mtFeIVnOOQh1bDiHF3v8n+YP0V+8c5EsKh
         HEmF6cSnMhEi+iw9yWKoVusN2EfI4AGfpMLh+dlprP7Uw11ngsSwLfwogDg3sO5OxQs5
         pZq7Uw+sHu8awEeZKM6cO/UVuW6NdXsHZjpwQEABFIWU9zwUiP63fBn8b4EQ1WmAN62q
         IIp04YW59ZnvFqp1MPXkOhAFoIoxMUvAK+qf5kX+D2tM9phFDAelOvESYhdmuwnx6GFy
         ANqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        fh=G0cMEWjCNOJnU4LzR6wYlO/05bxtDqRpm6mHJNeDaro=;
        b=R+0oiHEJE4xjQ9rpop9sfxf/uXVDCJHH+Kc+kOZ0zQJHn7J5GvlIF8QJCf/Ld/tb5C
         WZoydGER2C/k45HpB2fVMQl9cSuJqxw8EfT1djPSC61K5EzBmq9OgF/i9wkFV4WhzPGs
         BEEjKH6eZFI4ACXYrgCfsFI4GkfywIdEHtMSCDJtwzCbD6vZm1ZzyFF0s9K5FE0ea9ou
         g22DTLU4RLjNXTaNkDuTFjwL0muK8/5eC1ULeYiKWEgXjClq0GrjxAXOmZywg8Jl1bIz
         xlp9d8yBQKu1X03iaHsxoixj+s2ju1ed6Elp6XKU4hkR/SikLRJ3o//mRouD8ScfbFiq
         VI2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793896041; x=1794500841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        b=IAdWmD8JNPkb8+BPDqxGVrDthrcfZlPbVpLTWVrjVrtFSpMlJnimBTQk4/nuq9rXDp
         ppHgIt4hqBFXBeHjd867j/CAsSVgjXkfq6GXp16mkT5K/sYhCf74FuAWiOgi51Xl23YP
         p/7zABbNgjIH5SYUiZdfmFPGbIW4FfN3p+2pIa6VhaHQDutr8itsY0X2nagXClXkWHMm
         FhEWL0xZD3vJItk2osFuhRXByiPR+eFiUTfqLZPdBdt1KrA68k2W2Gzf67boy/FaF5IP
         8Q3yBF7aWMnb64lG4ghdiuQNiOK05BhTUgghwfBU4bgLRDPisn0zlxqVkKmr32WkWXNs
         aokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896041; x=1794500841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjSVeGEEd0+bGdWRP6KVoFnNf90ZO756HfHoWrPkLN8=;
        b=FIiA29olZTtyMFwv8yDqSU/xnHcPzuPgkKFWoc5IlvuQV1owf1mlpLyQrF6XOe6gYw
         nd649lUxLWd3kcGi6yIolO91ziVEghIGi8d1V3r8cpxw4Zf66dHPd2Z4vGXyRbldon30
         /kqMpV0yS//3LI1nbWzm2T8YMoQYPKjtAnM8/guCQtb6dXP97umWy8LKGEEs+vygF+oe
         p1w36GJunEbvDWT+HMqn3zPvy4h1uqJwzaNRZIBzNBVTl2DauMABwW07M2DPwKksZcl5
         KhR2rLFAkn9QUQ3q/9k1ezUKrzrCJ9JMx2uxaaMobauhN+R6L3ZJrwOEfVJ3PHfX8scc
         +ciA==
X-Forwarded-Encrypted: i=1; AKwUvBx/oMXjttR0m95OnSnzzSmWb9VJuUzTmNSUdZ6w8S9dv3hgHA1/QCDYVR4xcCIPiAdyyI4JkGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Dv6+Jtjw8PA/zrbPcpQJ17yyAyfFWj9g6azX7OE77VOq+i2dl
	YMK+nwZnG5k8G2uXR6K3vdWJ055vjrzAlMbaBTNORKg/LcVVwNTK7xP7kdvV2i3xE5KDsZDIfef
	SOL+0wVJRAml0DYydMBqrpji1CuUgdPpXXMWFsqsk
X-Gm-Gg: AYBFou2arkXAAK2wfm+EGx8qRQYdWxfzsFnu5xaEHjXDJjnAmWOQLLpob8bU27lgGeo
	e195kG2fbEXYZI6Ann6vZsCIklHmh62ioRg75JRXX9woVGrsnzxlXkP/MAnHxVtT7+qi5L7jClF
	+VQ832T00BWEtX1iernsICnEUaiD8D+8YsM4JjFm+SeFQ/2BK81blrCXD0fM3sHC6aoUBtRnoJn
	DvmxUPr419AO6HIr8xVDbuEQgyq2i7vnSXA6hDtdUBTIyW0mdqlw8OnzJju+JP+ec5cKmcmKge4
	19Zctc1WEyJ+l/arxmZZhihPOEaISLnYBRM724vUOGE1g8JZAkjR8+VNbVUOMwz8I05s+NQ0Skp
	gwa0ngJV1R2DJFsNnfEW4a3rEysI6+qR9tM32nQIBR9fdu8vvBB2a1V950PYOlTcXNegQbxx4Z3
	h5Ig+aQoSTTVredAHbXijqootYKh6VgN4uQjA26wyBixG3
X-Received: by 2002:a17:903:f8f:b0:2e2:d665:6ad8 with SMTP id
 d9443c01a7336-2ed261403d9mr4943165ad.4.1793896040053; Thu, 05 Nov 2026
 08:27:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 17:26:43 +0100
X-Gm-Features: AclHuK_t6xWdJYQZJZWrLOUlN89qpMohpKX0x61rzlBSDTuPtx0XhCCr0dC0-vQ
Message-ID: <CAG48ez19KzsgbOQ35FfGO=cVXGvr51WTA-3g3xNWPmUv2iS+8Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the
 last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:27=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_sys_readdir() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is registered or unregistered in between shifts
> everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
> buffer that holds ".", ".." and "all" and registering a device whose
> name sorts before "all" makes the next call return "all" a second time.
> Unregistering one that sorted before the position makes it skip an
> entry instead. So a listing that takes more than one call shows a name
> twice, or not at all. Even the 64k buffer of ls needs a second call to
> find the end of the directory, so a device that comes up right then
> repeats the last entry.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first usable entry after it, like kernfs resumes after
> the node it stopped at. The entry itself can't be pinned across calls,
> unregistering waits for that. If the position was moved by a seek in
> between the listing counts from the start like before, seeking to an
> arbitrary position has never been better than that.
>
> That also takes one walk down the tree to resume instead of a walk over
> every entry in front of the position with a round trip through
> sysctl_lock for each of them.
>
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
