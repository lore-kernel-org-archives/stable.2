Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB5B67E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821960; cv=none; b=o8QVHiLhhReHB3qM692MFrr5h8ZJOucues5ay8RQLMMn2bCF73Nhf3QFMhmFkYod7nYO7znipv2LYr3DQj4q7KhDpR+zlcgrEcNvDnBrYdLQsN7BRFn78wHxotBXAr2roFWbeaEI1nOk4D8+pghtF17zvkipLzmBmkNrDPmXa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821960; c=relaxed/simple;
	bh=jhTJZh52VU6dl91aENQnXvvK5y2NS81BpgBdoua2yu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4HceHUE7+zzruSb8n+p/If2+gzqSG2o0M8wOC9mJiDYtUYswqJoyNtsm8320VH991Q0QapSCuE5Y6wL75MfCJu2t/tNn/Mlps8B3/1J1gLhX7YOZXrUG7psKR2Clr+u4treM6us1SzH46p+VLX1383CUeJtsx3k1B/Ivf1ifQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+RuYZna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+RuYZna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFCD1F00ACA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821959;
	bh=MXrpqVudxti8QfHk2Ftrseh3QMUAAkfECm6BjJoPTsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E+RuYZna2c+AOcCMfSTICTk1UZvWYWqjE9hUqIMOtO3GAsDFId+i3Z0DiXpVqlbLN
	 6h+B6wG6DY/L0LQMaKdCb53/7rvU9EtrGHy2e88fkeM0CHWATYTqCgwA26Co0NIW82
	 zYA3Xj+QykDUo+xfYQv17jS5c1gpPdbuoW4e3+OI9GQTEXij+NdvrW/wM80hdwDVDM
	 l02nRLMYN6nEst26FU9ZeLCLUfupGiFwtnLNT3KaLAa9vSXs936hv4UKs/R4/bXZS0
	 m2G37/EAuE6SjFzMkdXxFLEjKO4ON1O9KMvQVukA1Ct1YH/9k5lyfCzL7gz/ljlplO
	 llQxolZFQOz+g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2544ff970dso547723966b.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 15:59:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4bCfJMhV8zdsk93x83tMz8YORYHA8X73oLn9CkxuTFC8ZtOwHV7Knyq2GFPHPDGDU/E3NrBM=@vger.kernel.org
X-Gm-Message-State: AFuF++mjDMFw9jknrju8X56fuAGMJnkZsJuoF7Rv6ReudoSTnXTnoSo7
	ws+6lvtsy0WV7dTkTuQ0+PJR632Ng2s3vXUPP1rJFFFEjXGR6slaqM0zXRvVrgXBv6/6HS4PesO
	sKPOW6NM35EiKV5uP7g5sQRcLxUsKRNY=
X-Received: by 2002:a17:907:9485:b0:c25:541:fd3a with SMTP id
 a640c23a62f3a-c260c7b5cfemr948661666b.7.1788821958297; Mon, 07 Sep 2026
 15:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906200517.725015-1-pc@manguebit.org> <20260906200517.725015-2-pc@manguebit.org>
In-Reply-To: <20260906200517.725015-2-pc@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 07:59:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_8-mbsd5qrEOem-skGJvsxGfF83PU9+uacKxAJ3LDvTQ@mail.gmail.com>
X-Gm-Features: AcwNN1UYbYcQA4uSssV7T09aaW2hgqnQYcvwBC2lcbJ3D_uxcWFCp0culhNqHus
Message-ID: <CAKYAXd_8-mbsd5qrEOem-skGJvsxGfF83PU9+uacKxAJ3LDvTQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] smb: client: honor forceuid/forcegid when mapping
 SIDs to uid/gid
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 5:05=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> When the administrator mounts with forceuid or forcegid (uid=3D/gid=3D
> mount options), they expect all files to appear owned by the specified
> user/group.  However, several code paths unconditionally called
> sid_to_id() to overwrite cf_uid/cf_gid with server-provided values,
> ignoring the administrator's explicit override:
>
>   - smb311_posix_info_to_fattr() (stat via POSIX extensions)
>   - cifs_posix_to_fattr() (readdir via POSIX extensions)
>   - parse_sec_desc() (CIFS ACL ownership mapping)
>
> This allowed an untrusted server to dictate local file ownership even
> when the mount was configured to force specific uid/gid values.
>
> Fix all three call sites to check CIFS_MOUNT_OVERR_UID and
> CIFS_MOUNT_OVERR_GID before calling sid_to_id(), following the
> same pattern already used by cifs_unix_basic_to_fattr() for unix
> extensions.
>
> Closes: https://sashiko.dev/#/patchset/20260906155816.603278-1-pc%40mangu=
ebit.org
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
