Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795828627;
	b=y0G+cnf1Ac9sEpT3QjZhDY3yOys7+/EW69wLbxCJhmb0gbW6+Aq7GxqLnNSw20uSCZaX
	 iAKrGjvIn+Eo9ZML1KBsocpJ0wsNOLnH2aK2TddTzvlC8iobW9bTncXiRtX6gW7drNIxi
	 rNcql8Xa5IVKxKqsDlzeRLz0ikGKvwuEyFuqvzhxf7PkTcmsHrbhhXsQeG7aZvqnHHSOp
	 TwhgHTyrr5Qyloo8w9BRBlVOaQf2tfSUWQuSNKKa8PPvmcVXhMXHRiJgsUudXmWERRbJt
	 aGyoIToqbJ+SLUFBL1Qkg1KPAKuO7H2ySUAz4KGIokVmM52X2pfxLKfT1Ue19LWkLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828627;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xToZB00hPDnFX+N6Ws3rv7y38Xp1+GHEYFSDyMJapVU=;
	b=p7xLGuGDk+y5yIymZEYgkXE72vl8ppEC5RwBL0K17igEnFXe13EYq9TDf0ZpLFwkMKVr
	 9bCCBMuUpVsa8SS5ajEYXyksCVRIMxJG1rpdC78BLo//UzVypcQZztyN0D+Hxf8wO3+mB
	 Bdo91LeKY2/UPCRhzrxT533HmoPTmZuNRsXmvYQPs0KJ1WD5EBDcwTLAkxXxrRlHhiMjk
	 6D4lhfXllUq30ys+RXAFLhROhRj4SDi15+ag88xz7cXWwDXoUkq3Kbisb9rNIhk9HVw0A
	 Pu+kO3GVXTvZiLUDdUvgUjMOv696c3rcd1S3MGf4qz55Y2w3CR4ljWc0jcQtKIj7hiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBhsJ1vG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DC606A323
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBhsJ1vG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EAF1F000C1
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795828627;
	bh=xToZB00hPDnFX+N6Ws3rv7y38Xp1+GHEYFSDyMJapVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gBhsJ1vGx5CUDFWV63vdt2oxveq1D6BKn1cQ3c7DnMCskNhYgbehSUfl1d7GC9iSy
	 Sgum1EPIlOn/ig26WwNQuW+F1UGmdZISTe49vorWeoEBP3gmpWrrXsK21cecm2MXUX
	 3dTNwCsSczBpEELWPkhdjZBFpbFsCpd0LpCTAM/mDHdylxNqgzG+xcbKgJFKkH6iND
	 ydG7s+a076mEN3olUTS6v24bpCls0qgB1ibB3ConIf3yP4RC3JsapS0b0jrEsVFKKs
	 bMH1VFPg3zLVAGd3jpxC2H1dQJpEsYsTkjq2kZK18kSsSqNA7fiTDBkLAWNPpHXHjV
	 JvQeqmu5LMEbQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c51c294cef6so241896166b.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFnw8QpoMMZeguTFIyVzNdcnieC9tx2u2kEOJ6R+zxrScwfEgF7uMvddgp203Ss9Iv1vrJF04g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/Px2a5q7Rrl/5FYnFE4nhgehrufC48FwHTxJUqdsVnRG8Zqr/
	DXRI8OeDfooTEo6A3LwL0JXYxTwTcqGuIURuHK/z7fjUCo0dI5HYOfYVRnpNvJDPW1tJX/9wRiu
	2j36C+oxTcQNqZIiriS5Iq/Hxpbt3cSk=
X-Received: by 2002:a17:907:fd15:b0:c50:f1c5:f815 with SMTP id
 a640c23a62f3a-c513ab49777mr2134433666b.31.1795828625787; Fri, 27 Nov 2026
 17:17:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261128005905.1687065-1-icb@fastmail.org>
In-Reply-To: <20261128005905.1687065-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 28 Nov 2026 10:16:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8iAUam4t7dAEThYj6Px3THraX-LzUU595OHah-YxFwCQ@mail.gmail.com>
X-Gm-Features: Aa3M54rpDriwixDmOJoBfXvL2-W_hkN6DZb2wRHlg65gC1YKfXFG1UkYIA1H4VA
Message-ID: <CAKYAXd8iAUam4t7dAEThYj6Px3THraX-LzUU595OHah-YxFwCQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fail an open whose stream cannot be created
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 9:59=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> When smb2_set_stream_name_xattr() cannot store the xattr of a new named
> stream, it logs the error and returns success. The open then succeeds
> with FILE_CREATED, although the stream does not exist. This happens,
> for example, when the caller cannot write the file. Return the error
> so that the open fails instead of reporting a stream that was never
> created.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
