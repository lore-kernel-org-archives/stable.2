Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524412;
	b=w9zMc7rW1exMcyVr9o1UCeN8LBS73BKAU6yyOl+bm9xZn0Rm7Wn4EracmhBWcowJcSQK
	 v54QoIoa8QynsUteJr3kZMWEktZJpZ8KRsUhuIqM5tcksL7pszZ2XdCB+oLgyoLJA3iIV
	 uE/XAAM6l8URhddHITFkVSMuhQT8fK4i4kk0YMXRSaoKLi1TthVTqySlErA+hUbWNcxax
	 waakwmuTyME6tLjDP8CmLWhPOOs7qVkg/jpYyW+NQmCRtxcLdhERCXYhtNPBirIGc3TyD
	 wpUU3M7jrHXHvGsQ6IgdmUvSxxRVxOE8udQ0/+yx+YaK/L7pLj8mDOvNyBHRSLUrX+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524412;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oiNSXAcoGi/JldYohLXptsVAIK3X+9WLuWCmpuBMd8c=;
	b=MrPLLjuamMKW7erDNunzXasftmMs5Sat6oIQ6lF2KoK1GknY9Bu6Dvp8olu62S2gFz96
	 R/qEpQaYrKN4QOuH5Lp/1p8aDukxyfagYXqT1wFXDKz21uPj0hBvIgpwT+h6rb0AHSI+/
	 nc0M8NFsjJoDuAztsVmQxxvJwJpzdcb99R4ZOTsdbL2o01sNnAFvWkAr6dBwZz93EpJah
	 ezk9cMPzB9zr9+pw+puazkLpbcKq1krAcItfbHwAyW4lbFHJVdFSL8bnuOm8mzK48E46h
	 bu8osNF8ecvefqF3TgsiEkiKEgENe7uYP7OK7COyE3ShgE+rxZQ4/uobze4NXJU/Azg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaAe42Xx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297E606A336
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaAe42Xx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458311F000C9
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524412;
	bh=oiNSXAcoGi/JldYohLXptsVAIK3X+9WLuWCmpuBMd8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IaAe42XxFR1obgLPXMc6jWkNe9VgtWl4Q1NgXDIJdNAjuGRJI6O2sKbV+CEruttpL
	 78GEf/2qOW5IrNfQ50v4yapxozHX5FcMYINPstu46HPq+kJIhYqymShQ1I/4354wva
	 Q4yx6evsxlPn9xMNdMV2pmlt/3DLO3zxI9HMW6B0SVwVw2Msy3RpkUZGTKnXcUy+Oi
	 j5oQNx4nsgyNW7ogd2fj33QCHL03htiVF6hPq4oeGU27eAjNFDXWsbWkNGoxhUc/0g
	 59Wcdm3fBrRh6Dn6J9LhpBBfPxKYs0NwnILk/arohjvuMLRO2Abdf/9IC6TFlVt11o
	 qWedH9VFEuHYA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so9708966b.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFzls03v3qjTM6VZdxvHEMsMG/LdQ14luMPZ9ptIrR46KypQ7isp35wqwFdC/s+rjuA0p5g//c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0TXkdko9SvMygvoDT/tl4LhDPz2GyTrztq+FSUfWwpsHf04NK
	ZEcskxKYz9L79j17ASRGgw7fgU6OyTuMVHl89na6ll4wK/gxXuk7EnuNP+ROJdvj3ht9BNVaWyR
	+2IsBBB6R11QdiiMyNUuvJHlFflRtD6I=
X-Received: by 2002:a17:907:8e98:b0:c48:9228:bdcb with SMTP id
 a640c23a62f3a-c509614e920mr65839766b.3.1794524410953; Thu, 12 Nov 2026
 15:00:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112111637.184045-1-koray.fra@gmail.com> <20261112111637.184045-2-koray.fra@gmail.com>
In-Reply-To: <20261112111637.184045-2-koray.fra@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Nov 2026 07:59:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8OZ1hfRfEcerPec0nZwXqRqzb=pkUW96ee8i3GQGMUEQ@mail.gmail.com>
X-Gm-Features: AclHuK8l1-UKHD65oG1w6WnmQKu1UA7Jw7DcQGP4E2lwY59C9HyzbQv_tALtD3I
Message-ID: <CAKYAXd8OZ1hfRfEcerPec0nZwXqRqzb=pkUW96ee8i3GQGMUEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: fix negative timestamps being read from smb
To: koraynilay <koray.fra@gmail.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, ChenXiaoSong <chenxiaosong@chenxiaosong.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:16=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> When reading a timestamp before epoch 0, cifs converts it from NT format
> to Unix format without normalizing it, leading to the nanoseconds field
> to be used as a negative number, which leads to a garbled stat command
> output.
>
> This bug also violates a struct timespec64 invariant, as documented in
> the set_normalized_timespec64() kernel-doc:
> [...]
>  * Note: The tv_nsec part is always in the range of 0 <=3D tv_nsec < NSEC=
_PER_SEC.
>  * For negative values only the tv_sec field is negative !
>  */
>
> Reproducer, with /tmp as the local filesystem folder exported as [test]
> in ksmbd.conf and /mnt as the smb folder mounted with mount -t cifs:
>
>   mount -t cifs //127.0.0.1/test /mnt -o username=3Duser,password=3Dpass
>   touch -d "1969-07-20 20:17:40.123456789" /tmp/test.txt
>   stat -c "Server local (/tmp):   %y" /tmp/test.txt
>   stat -c "CIFS client  (/mnt):   %y" /mnt/test.txt --cached=3Dnever
>   smbclient //127.0.0.1/test -U user%pass -c "allinfo test.txt"
>
> which prints (stat output is garbled because of negative value):
>
>   Server local (/tmp):   1969-07-20 20:17:40.123456789 +0000
>   CIFS client  (/mnt):   1969-07-20 20:17:41.()*+,--00 +0000
>   altname: TESTT~K6.TXT
>   [...]
>   access_time:    Sun Jul 20 20:17:40 1969 UTC
>   write_time:     Sun Jul 20 20:17:40 1969 UTC
>   [...]
>
> Fix this by using set_normalized_timespec64() in cifs_NTtimeToUnix().
>
> Fixes: 2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time=
 values)")
> Cc: stable@vger.kernel.org
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.3
> Signed-off-by: koraynilay <koray.fra@gmail.com>
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
