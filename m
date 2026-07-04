Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F723504B
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783131990; cv=none; b=qMUvbAXo9jRwMU8CHjMS3+/wxg7vHJZ8rXXzi1Y8eWVM1u3WJBmwUkbYMJ8umBCZitoBPKne64rDZTDiw2tiqsWUI5HGVtLNnCrOd8DGwtNKzLYKFXsd3iEjwLbvW8kSbSiSADEpbjOSUehARInp8PdfhyhJHToEkVTi9jFLevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783131990; c=relaxed/simple;
	bh=K5UH7jbJ633f87UxlYmlQo32WZzzUI6x1+evumY/cP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZGaKR81YqDMSW3uNVhUEhZ5hbLUDb6Srugce/dFBW30Bnc+WM1xInG1HQM1d5XNkMRSALLcJjGB8ujAjWEIxFlUO2hWcxylHOlAuDYAoEVZ5iGd8xXr2uFzjb8Xm7xxwY0YtYTwwvEOGcrNF1kTViUcUjfW/lgcFwiU932McqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq/qzl46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq/qzl46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792FA1F00A3E
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783131989;
	bh=K5UH7jbJ633f87UxlYmlQo32WZzzUI6x1+evumY/cP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bq/qzl46mWAzRnjGbuhNxzHy12BYhSuqCIft5zwVv4CK31glb3oa55YaiR1UuWop6
	 TODWzfVIeLck9X1Y7Od83o564bwID9LDkxv1N0Uw3DGU1erbC+NWFBp81frezp9gf6
	 II+e3/sBoi9UCrNE3XKJg2m3J/8qmDjV/6LBki/GM5AOQklMUPrzFco6vL8cKWvku1
	 4HgeN55PJgXy3pVaj6OtjTyaB7Y9hWlLuev8dUv4tLPt4rWrtXPj52TqAPpWSiPKly
	 YD1LdpuSmQJJdkS346tSRVKvEVaPM3ImxZOUXYwmgdmP1FPK0jXeS8ClXi8f2+Fr2R
	 03oO4iiRcm98Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12a1a3cdb9so105968266b.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 19:26:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/8O6vdOV8r/KgVSyoWxUldID2Q0ErJM5ZsCDbRdgsqBDwBg2ZGVf2XZ1mRw9BPaPC6vDH/Kq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRgHmlFmFc3flKNq8br/nNatZ0D54Gn5pd70piBUZxC4i+lLx
	wSSIPKd658R/orlzYBo8IA3aReWcdXhE9t/5ajW+jpEVmZWiNj2EsNXzDpiIa7gBfs+6qpYWTv0
	ZwxSgH+DYUHx5tVNquQvonQyc59Sbd9A=
X-Received: by 2002:a17:907:6d18:b0:c12:6f4a:1b5d with SMTP id
 a640c23a62f3a-c12e6c34fbbmr45093966b.39.1783131988129; Fri, 03 Jul 2026
 19:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703192641.46121-1-james_montgomery@disroot.org>
In-Reply-To: <20260703192641.46121-1-james_montgomery@disroot.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 4 Jul 2026 11:26:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8U_wCr91GcKaeknkqWehhE191WGX3CUX1iFqmduPNVYA@mail.gmail.com>
X-Gm-Features: AVVi8CfO2rzm4htz4KS82u-6YZNAHnz7UxM31fStpYuVHcl6LbXEprlAmKmaVY4
Message-ID: <CAKYAXd8U_wCr91GcKaeknkqWehhE191WGX3CUX1iFqmduPNVYA@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: defer destroy_previous_session() until after
 NTLM authentication
To: James Montgomery <james_montgomery@disroot.org>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, senozhatsky@chromium.org, 
	tom@talpey.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 4:26=E2=80=AFAM James Montgomery
<james_montgomery@disroot.org> wrote:
>
> In ntlm_authenticate(), destroy_previous_session() is called using a
> user pointer resolved from the client-supplied NTLM blob username field
> before the NTLMv2 response is validated. An authenticated attacker can
> set the NTLM blob username to match a victim account and set
> PreviousSessionId to the victim's session ID; destroy_previous_session()
> destroys the victim's session while ksmbd_decode_ntlmssp_auth_blob()
> subsequently rejects the request with -EPERM.
>
> Move destroy_previous_session() and the prev_id assignment to after
> ksmbd_decode_ntlmssp_auth_blob() returns success and use sess->user
> rather than the pre-authentication lookup result. This matches the
> ordering already used by krb5_authenticate(), where
> destroy_previous_session() is called only after
> ksmbd_krb5_authenticate() returns success.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-cifs/20260702155449.3639773-1-james_m=
ontgomery@disroot.org/
> Signed-off-by: James Montgomery <james_montgomery@disroot.org>
Applied it to #ksmbd-for-next-next.
Thanks!
