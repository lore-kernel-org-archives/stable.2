Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403815;
	b=FSO6jD9HqL98/HtSHMIZJ2yxuwwGrnpjQHjwRBtNbYt2kHUTvzsZOpGo2+NnbuarA3XS
	 sfuL6+7pTW6MFTNtLWuYt83R3w44KNsE8GlJwcGuPjK5r/sZuV6YJZwHXWGXIRziGU79u
	 WPPr4s8lX0XQzrLd8/Xq+yHLDhE8oGcaixFMuZRU5V6dVmdgsPKMl0MICVvXsu/TxSqRU
	 t4IV2mA2SHwj9x7d/xnRZ2gDraVPNfkJGy96+R8ZqrVj7+39uLMFbI+Tc7Zg3jk0BS0l/
	 Lktck1GqgnaPgk1SM/PX2F5tJjLep6c2gwk/zcWpJKWjuOFKbVivD9rB8rj4Vv6kRyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403815;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=0RxplO1mLFzUBYXU6brprN2sPBQWvCdnZ2OutIiXlC0=;
	b=sYmiYfdEefjNkjTVeRPi1adAkALM8cYwVJnS4EurtH7bnIAIZsY2LXv9VifagoOf0f5c
	 yK62nSDFc88BUfJa/SoEVSYSx00tvT4RS0aNzKvdemjaQn09hKPFXCgUl4oqdC1zIkCBD
	 gvSXhcEwMEnBYDB/Bvou65XJrUPv5ZU80kZuRcM0mQX9+/26fjLFS9I76PrrQt3+wYMNc
	 TXP2zT/NR8aNIuOi/lz0F58mk16BXIWLEXsJ3VmSrH3i8blSFhmnvNtIU0EVocM6ISukv
	 Jc0sQMr8fHljK3Z40pio7URrFivXVypmSNrc7FrmRwFDEJ0GQjiQWUBa3mQYvPf5MsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7i2zk4Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91327606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7i2zk4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F56D1F00A06
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403815;
	bh=0RxplO1mLFzUBYXU6brprN2sPBQWvCdnZ2OutIiXlC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O7i2zk4ZrbYHmwxkjCRryhVZaWntMoZE8gCgKPyBdwcWQocwleTB2Yvsbkjsf5GvB
	 fgNjLDPILYGTLOru2D4X8Nsk3jJe18Sm15tLrqu5pSrZR9TmLMsGajpBh8OmmXZVt6
	 GUpwECkrZztup/qEn/ffwLGDFj/l+v6i5oXsuHfP/2TdhFcRImsQlrSZrsfdmoN5MO
	 Ztd9xUx+USUGcnY660sIsXwzeQF8TFCGGFGZWxLl82H27LYdL+pS+qkOjhautkDdKo
	 LrfwVg2MedOjeKwO4s99uzpRB58bfAwGYRW+xqLTCemGeoF4nSHfH5XgR9Egqj2ghp
	 QKQMcpvhjZPCA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so3659006a12.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGQGFRT6ZZYNBcWzYzFR7x+coD0Xl6DZ2jXQ7VWABatSMt16qJB6N60x5EEiL8IR1pWJsNYGi4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aJUoK1uwpzcxzk05iPQmjVojnFAZdovrVZQhif0b19he9vI5K
	mmpn0gGe98p5NMOiYRCT+Nzeq+iKIbYfv+LpXVS/1jRTQUmBfazD7+TS3bPEdr/4xJ4+4iuIkqy
	Ni7WdMhLKkJDXbmUByG1rwBQ48tNjDes=
X-Received: by 2002:a05:6402:42d0:b0:6b7:96ca:ca75 with SMTP id
 4fb4d7f45d1cf-6b796cacd4cmr129344a12.17.1794403813910; Wed, 11 Nov 2026
 05:30:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110225412.3937476-1-pc@manguebit.org>
In-Reply-To: <20261110225412.3937476-1-pc@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 11 Nov 2026 22:30:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-VC8shz7r9P=mS5XvOuGoadBhjJ6XYaaivL1z8v0UGpA@mail.gmail.com>
X-Gm-Features: AclHuK_OrYgpF5a13YXs1lYPvyoXYAk-ZAYjoaZngRG19B-eSmvBFPb8FUUjIlc
Message-ID: <CAKYAXd-VC8shz7r9P=mS5XvOuGoadBhjJ6XYaaivL1z8v0UGpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] smb: client: retry a hard link open without a lease
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Giuseppe Piscitelli <ooonea@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -214,6 +214,19 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
>                 rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data, NULL, &err_iov,
>                                &err_buftype);
>         }
> +       if (rc == -EINVAL && smb2_oplock != SMB2_OPLOCK_LEVEL_NONE &&
> +           !oparms->pending) {
> +               cifs_dbg(FYI, "%s: invalid lease key, resending request without lease\n",
> +                        __func__);
> +               free_rsp_buf(err_buftype, err_iov.iov_base);
> +               memset(&err_iov, 0, sizeof(err_iov));
> +               err_buftype = CIFS_NO_BUFFER;
> +               smb2_oplock = SMB2_OPLOCK_LEVEL_NONE;
> +               oparms->reconnect = reconnect;
> +               oparms->replay = false;
> +               rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock,
> +                              data, NULL, &err_iov, &err_buftype);
Should we retry without FILE_READ_ATTRIBUTES if this retry returns
-EACCES?  EACCES handling above only applies to the first SMB2_open()
call...

> +       }
>         if (rc && data) {
>                 struct smb2_hdr *hdr = err_iov.iov_base;
>
> --
> 2.56.0
>
