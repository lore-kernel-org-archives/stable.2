Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792841735;
	b=vV30dVcnwefDdcuX1pv3W7SjhO3Lj57x/IEpxaSWBdLGvqZthB1BTF3IbWsNgsoTKOBT
	 W2UxmY0fMDIRJV99ixk/tE9VQMrP7jBuocrKnAeUI8I63uTrJDs9xG4iUmT3ENnwlOTRG
	 ZFWAv+HN4YLyDogIiO9TMvxyGw6+I4bu746k/i2vVXL56EHkxX75flFRhojCeVGr02XHz
	 IbA3YEv3jC6Guv+p13fW1b+61upLX0r59BlitT2YmKobld6wPryjJK38T0OOCZzsrB8+c
	 Opd4UngFkGV9a4E3p1JJDqhmFHhYfkphvhLJmdjvr0+S+okLAhw43P+CqDbhBXujPLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
	b=5RtYI4Y4dSc1i8a/uOUox1tViIILnNPvS6rF1bTe55DDKOX4ThEbY2wWDb5k0rUBf5+w
	 ZkwQqPej3T7/2hI7yTZ178I8u7elLqBnNCNIkg7PLzYh09ThjtogUdwnZGLwpbR48vSdz
	 fYhhEL3Uf8SpucXV+4nP1+lbf61Pgh2VpXfyUPKAgTzgQmEDaPlgFHLFElJb2ACbVOzBK
	 MAcxhc0KqsSOIbUdeBwjW2hFQ7iZqt2GcfYQY8O9FJrR0Xow+Xlm3fYqCK51pNFHKmQVb
	 ElY/WspMXEsp/j5rf263Jz6YiRW4ZUv/APw5Zg9FJx6rQCo6YoENWlo0JJdJsc8rpew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEF606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BEF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-35af9712d88so94641eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 04:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792841734; cv=none;
        d=google.com; s=arc-20260327;
        b=ry3bhK/4uXJGIF7q+SgjSPzIWeM+8SfDr+QxygsvrsdTewIWucPwckbnZFUc6Vchf7
         RrCtNG8JNvCamw1oK/qK+yuCkskiMfvieYnScgLK3V31bK2oaeShUuuxjjQGuhARv+3B
         jqcyUGYC1KD+uV3cqsa0JxCUWpOVIfy1KytFAygBiKSF/iaPWmFde2H84ieeABIHRbPK
         3ZTpiYmCk8Je2zFw91FBz48uxJxXSoQyUtYj/8ei5neLHA9ofTiHWm5oDg2sgoaT39vs
         pSVXa9qT/ubeOlutdNTYUlsfJlv+DZqnfwwVmhHh8wiCHOY1QBSemqvwbTs/0XmUzZ2x
         o1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        fh=SEV6S7kbXKe+4P46pd2i5PlUrUng0x/zXh667fNTUS0=;
        b=gu0zWSJ0qEvSBjSv6P+0Wxfn9G20B3cxCi90pgK+Oxr38nghtzza3RDLlzKgDF2J+5
         Jre5EvgwKePrZxvLgQtCzKiMW0bNCZGh/8Iz29uU42B4PTWl3Ztbp3GqnC5Cih9lPART
         BR6vPvSeofILeUp3n/RB9rC3liqMTT4NYTs6bh6ueQzIGrcgo5AwjX0DppHKpCE8Kl60
         5X9TGX45K37+N1O+yzTvQYsf3Dtz/CKtZow6dpOltjKrXL1kAGTjKWizj8e9P6LvPxZu
         b8QofhxqobXhZavN0+LQNNMaxdPBJQlFGiriUbTyp4pM/s1WPHqm7hEHAQuAjy2rVvQw
         U8EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841734; x=1793446534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=UDpQHhjOOpLeAQ+UqfGehYdrCjlB46HMjQ/EW8qK/18tiEejR8MvCMHJZhZB+Dbz/R
         dlwWzTaBw3JbXtV9nAmMH4d5UVrTFgJjvvWCWj7LbKp1N3xectQvJaecfiHJLA21W20l
         7w/xMA/SQT8Gal2+9D+D+DseL0QDgJV7lt7CumiG/qpIqXC+iBRyhwCNtB6BUNvK1sr1
         LwwNEEA6NFQCQ3XVX3bwmopi/vLJ5SGeDu29X3N1Voy4LUcY5wdbaHfgJLuT/xnLpz5U
         ShjTjQbba90lUXadzxqleOieNVGfH3S0VWRDy20FCfKTz+Q2OA2QKNQEDOiXChyGYpRM
         uOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841734; x=1793446534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=Ld/AAVW2NUcWHFZvgImo/NQHiswqghqb7U+i2yKKltYRZCTr5Cyyv6EMuwnRFmNRJy
         bz2ToVi0l60rtfNf42wkkrEyiBmQ6s5sX6wp41kVyDWBoxyVi7iY6zJlwEn4D5ucJYoL
         M2DZJDtES87LxZdeSEWrj3wDnGND58XTpLY2dh6Q/BTj5pkm794cO44OWEA8hvEeUQ76
         XeU+Tc3cG0gJD9PudYPMIAmvbSzS1RqFlus1RphApwjfpbEZMWMmyS38Thtj05IRJFVp
         FHJKgUQjn2jF1DdkV0BcQihJBcc2yYVy3g117hBw/nj3UUH3zvgqkVD69ap4tlbYRIt8
         BgKA==
X-Forwarded-Encrypted: i=1; AKwUvBxVhSACzRFAgyEs5EEb/vcjk+O8CqH0quKmPJFapqMP0nAfoxRQl+Y4/MQhupNBWDQUVDWaDdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIVS4btKAJquBaiq6PhwCe4ZNLpLpRcbQ2PYziQUvecU7i9wyx
	hZpilNw2YGcK06ls6ZFCz5y4XTZN52L95hrv8VnvBax/92EVoW9iADdzs6MNdzz9ym4LeSh2Kio
	80qR3jNji5oMDfZIPGAHjmNkr3wKc4GU=
X-Gm-Gg: AYBFou0GkAntiJO2cNVoRPYI99nhKw2bqgcnrsHzOKXHHEt9hrBS46hBocJ6+2TtV5+
	5wDOopzODynVKJIY/E8tz0BEG+zLN5z3ZxsJrbcy6qahQ9IDnbiPr4qcqEp6wTPg+MUq3VFIvpj
	lOto7B+PCtpQ8eluhI4eJK0M9Zk9S6yaYeyYyD7srGthbe4hap7kEv/g3eDMD/k/uBwCF16msX8
	M1huaL1SY/8HX1/Zdw009NAqMHdyMucRz/sIpGrfE6kk0cpOIBIY0cLjj3tnw9LkXsNM7fTrqWj
	QiY2DTxxi6Mm2r/k1TcLG+V3qJVgYSZn3dnVEl/Wf+Cg5wiR9NCw4WSEDrpgG5KzmwBh4/nr84z
	Sf3ZGMg7crA++eumvbDYQZiOp08K0ZQx3vKg=
X-Received: by 2002:a05:7023:906:b0:192:a481:361 with SMTP id
 a92af1059eb24-1994d8b9822mr2570217c88.7.1792841734448; Sat, 24 Oct 2026
 04:35:34 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <179283334099.3327.11706883238489839470@kernel.org>
In-Reply-To: <179283334099.3327.11706883238489839470@kernel.org>
From: =?UTF-8?B?546L6I2j5bOl?= <testwrzwrz@gmail.com>
Date: Sat, 24 Oct 2026 19:35:22 +0800
X-Gm-Features: AclHuK9pxstbMYf0EyqcMH-TBmz-g6K5xQuClbbepH1SlLVllcKyJtSHElNXP04
Message-ID: <CAKg18mkvJVPgYTr8ie2K6_q+rBAHfvCnxgbb9i+3Wh_v-cBXow@mail.gmail.com>
Subject: Re: [PATCH net] xsk: defer software checksum until the skb is complete
To: netdev-bot+sinfo@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I found this while studying the AF_XDP kernel implementation and running my
own multi-buffer TX tests. When I enabled XDP_UMEM_TX_SW_CSUM and sent a UD=
P
packet as two descriptors, the checksum on the wire did not match the
expected value; the same packet as a single descriptor was correct. I then
traced it to xsk_skb_metadata() calling skb_checksum_help() before the
remaining fragments were added.

This was not a production or syzbot report. I reproduced it with a standalo=
ne
AF_XDP TAP test and extended the kernel selftest: the unpatched kernel give=
s
actual 8817 vs expected 52507, while the patched kernel gives the same
correct checksum for both single- and multi-buffer TX.

Thanks,
Rongzheng


<netdev-bot+sinfo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
