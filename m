Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225437;
	b=tXUBOQpvk6rfr9beGsY5WYjInOq4LCNrhVmhJv49lH/ZelhEbHyPuy/HxPJ5JPdPitPv
	 va4NLhJ61gzik671NIcD/b+RQvJ/4lgfRwX1suJ/i8F87V1IA1UHOMmX/sKDZsfEP7U1B
	 yGdCKc88jd2lhrc+UZtE305brRTax19TBMMFOju73MdvxPLhut7h1PUL/kMo1KZk4pzd+
	 V3DKsIDB36QV2EKDNM1xDd4ijda91O+n0IbQ1j6aNz9KNqXF/U+wh3qgdRDzVf0jMSxIp
	 ceG05xBiICHcNoPu43ErXppovl2ZhV/xcq2x5VKLx5Og95U54oEuiW9WiVhMtKbg2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225437;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IZHBpmYgwg2uHcAp2EVwGofB3o+jQ8LHJLT3ugevwxc=;
	b=l19mwPB/yZfbLkFtG4TPmUJQKJXKWoTbcw5e6kk2wKdpir5YYf68rvy7oGdUZi9EDFWp
	 rMKGcyjbeTR4+c5pBpCiQ+8OIBmrAWMQcw+URdUHIJAL5mVhGneQ2/rIPCEfS1Uq3HQSP
	 sOgiuRxAC3BOlkuAfo4kOmikIELNXyuF7TpRG1OzqU1NJdqknQT1rW1zbaIeg/g6xDGXc
	 DY9PAM4r18fZrqiC12UqeuNMCFNhQZ6XSrqj5GT16DJwXcWkkCoQCrOPcbFctqQj8/pqk
	 FX9kNr7YgGbfBXSGYHsxgMsVhsYVqBBDscQRUIUuZaZ8xG8rus4nNFoUUBeGpVf6qSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFm9trbG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89A606A6A7
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFm9trbG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D63C1F000C4
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225436;
	bh=IZHBpmYgwg2uHcAp2EVwGofB3o+jQ8LHJLT3ugevwxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aFm9trbGR1ttSbNewz/MAIEVl2v5cjfdDYKiyeGDWaDt9zYxg1ZFQPM+BfCDY/aKl
	 yDXfd0n9dTenoorzPADsFvbz5T96kpXTvAV2KE3v8/RwcRf0bfRi8SskaR76tLMMgc
	 cNeH3TbCDM05WCXybXi9AKAVPi6qVoT9Sgk3lUfMSJbK3e95wjWTM2Zx9Z8qecu/fF
	 qaMOMbH3lhKYzxT8zfh35uojyoxtLlH9jhVS+w1phhfhF+VHHPsr2lb7H/xUfH6qJo
	 irRnFU3Sw+zeD5/eoJn6D6ox0t2Uyy4x//lC5Zv+BPnzw0TfN7GV4S3+riMIYNjjSW
	 R9rbNfqsyMHbQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so2117955a12.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHKs86ggwigI57NEAe+aGNQWEUzgrDXK3uDXuBK/2OAky2/RcGQamAm+j6ZjFp5kNc7+lRYi/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9562yLVjmENdgzYW039UgqlGrnB+slItaJwI4/Tt9QRzQUWyf2
	U0FRE3FDddU1ZSuxfMvab23gszoWXY6m6cyuZVJBGFddtXcZ5pc1rFR1wivnWZg7s+aFxiqyP48
	CvozpG2AMMtC6ZqxuKGhpEEqb+VuuglY=
X-Received: by 2002:a05:6402:1512:b0:6ba:12e2:46f2 with SMTP id
 4fb4d7f45d1cf-6ba37d18d2emr2899334a12.8.1795225434798; Fri, 20 Nov 2026
 17:43:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120155021.1618964-1-liubaolin12138@163.com>
In-Reply-To: <20261120155021.1618964-1-liubaolin12138@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 21 Nov 2026 10:43:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd97DoyU_uorCoM1viB6T=z14t3V21gXehBg9gDL_b4SRQ@mail.gmail.com>
X-Gm-Features: Aa3M54qJWxRShaBRDGyYV0K_jGwemM3TQK7CLamk1rs-YxAipl2WbAM4lXns4n4
Message-ID: <CAKYAXd97DoyU_uorCoM1viB6T=z14t3V21gXehBg9gDL_b4SRQ@mail.gmail.com>
Subject: Re: [PATCH v1] ntfs: limit MFT mirror comparisons to system records
To: Baolin Liu <liubaolin12138@163.com>
Cc: hyc.lee@gmail.com, d3nchk@outlook.com, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 12:50=E2=80=AFAM Baolin Liu <liubaolin12138@163.com=
> wrote:
>
> From: Baolin Liu <liubaolin@kylinos.cn>
>
> Windows 10 can leave $MFTMirr records from record 16 onwards stale on
> volumes with large clusters. Comparing them can falsely report
> corruption.
>
> Commit 749357bd48c1 ("ntfs: mount hibernated volumes read-only regardless
> of errors=3D") made these mismatches force a read-only mount even with
> errors=3Dcontinue.
>
> Limit the record checks and comparison to the first 16 records within
> the mirror, following ntfs-3g. Keep reading the full mirror for runlist
> mapping and location checks, and leave mirror writeback unchanged.
>
> Fixes: 2beaa98b46c4 ("ntfs: restore $MFT mirror contents check")
> Cc: stable@vger.kernel.org
> Link: https://github.com/tuxera/ntfs-3g/commit/85e208176ffd16ce9a51a9f534=
b194f0ebbde6e3
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
Applied it to #ntfs-next.
@d3nck, Let me know your test result.
Thanks!
