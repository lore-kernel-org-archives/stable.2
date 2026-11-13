Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598003;
	b=OZsLuxOj/KA3GDLbDnzQy5zXoFA+iDIPHCh18jFV3DhvCoYqGt/ZlZfb6Fd4vfB4bKYR
	 kvJLqmHb+h/svV7KV7I7MdEGcsJ0NhppvfmDsRQ7p5ChEnDda7jFsHHM2RigwxsTRTyyy
	 xAEIvFnwbGwXP61iFZx6Q6ggAhPAjcKxA30UvBcQqi1l/GvuHggBaR0rkWdd8nEr36XHp
	 SonQ1PvA4abO1EZ4OYFXiFaSZZROrpXLWkEXgYapUqaE2FHqS64lHoyPsziiIdWhWbE5u
	 PLyqL8Bhi2hrgSmiHozqmXCW9dJ1/BfetZuSyHuJPWxc+V/PYvSwYHUHe4aVkY0SUQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
	b=uBoRZd/2hPC8U+/Tu8fHgxR/Vz60fxr0BTB/MHvHA56JI98ZstYshhlPxsiXCkj+/FqX
	 p7IGNQW/g7ANdHJtTZKF9tmpIN20dlImLdaR0NmQhuk2I0etwo7R7jsd2dqCdTM6afVYt
	 q8Wa18rr2522PqSs9QTSsWEEbXxY89SULAN1AjUJXmrLP7/zHQTubB/SHU2m2tFREjjhu
	 rYv8bZ7phJQ62eVdMSde12a3AodSPzGlIVfHjtKDYMBSlkrj06DjBsvOf6KTih0rc/DMw
	 pNX0hlarwzT2ygZUrKnb+JuAQYN8epkbp/2oW3p3JkcKD17HMCI0FZXOooJkA/0n1Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cYoot7un;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA36606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA36606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cYoot7un
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so19879775ad.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:26:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598002; cv=none;
        d=google.com; s=arc-20260327;
        b=HTBHKdi5UpxA0QqKy4unO3trS6prz8Vc8Vf3KrWsF/wKRzLXGfjrYPK9FTtbA0n1aI
         sPPfOU0sVZCR9i8QZ2tVkN9QhyoBook+by0NOhgk+/KRnpHHLtqgd+YHJsppKHnMypVG
         29SFESXyQpI1/c/Ni3C+nP6CXwkw2RlcgSTV4wjEX94N5Q69+bQ9YQ7Nflh2XFHhCA11
         9r2lQo2MpTVlO616r45tqX/0qz1tGpD0D3i2JpFR3tiOAtvtWt9HnpCMKhGP+1U0Un1L
         aASyRkLDF8o/Ul3EZoMKAaCol5hpoRKGrcNqaX6KmW7VjREez3GpI+JyoJjxh6pdxtMo
         mgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        fh=4FopZCnx+luCBs990zZ1bYIci8baFI7Jm6bdPW2d6Vw=;
        b=H86x5ER6TW/XIP0SqD0b9Bzc3zdxtPImw6kuDxHDOfziExlF14m/0/7OnpjPJGof15
         MYvLjcdnNclnk57a36asNoRWZEvZIjWLDqv87udccKX0YjHn11QralmulRIxJbC9rf9y
         nQJCh60MElXW6xGCEzBp24Ede6GA86YtIzscYYTGC48vpPHIjCKJtVNJqiUxjfhwHuhA
         mee9b3MEmgmfO2S6f+tTxnpZ2aTiKMc1hPGsXVkyVSsJamw6sKLNGTypEdk2/TsnJ/gZ
         38VqKVr+nakn1Gd0528B37Iz/9lkBPWbwVwR1dBBxc8s18Ma2WQhocrF3ZwCyMmYm2PB
         pZlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794598002; x=1795202802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=cYoot7unQPS/3GmA5SC0wFl6UOpV/+X6gCQJp4wBxSFo7t2KxJa2fZxp5V/cjZhU8H
         slv9FbVon/Sv65B6pgIsLRT7xer6EhVRTchVk2j0FwTg/ZfPdCLxuy3ivzehlC7Ly+c1
         O/MRP0xaSILFZNeFpSGbvp17p9I3PnfASo9NsG7qF7v/TmIgigiF5PEmzhCdvt6pDtVg
         0gNogHERceNCbPI6Nj5kOMrza+2ofQdvg2z+jsUWoyKcWjho6jjJeDMso5hWtHjx1Rwf
         mVDE2H9V5hW20AAM1g26zZPvxNVNeEguHXmLWgTkLjcUNK6AH8Jyb36IPwnnjRvJE8h/
         R9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598002; x=1795202802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=CANQIBKyyyBIr3nwKeErdt9xy63xHcIeCMYMZEoNlSqmXjhFROejVKNRQQbH8pPb+L
         6uw1f6k6IbdELaybIf3TaBxX1QfckrvKScYQ+YE+cgOLnBrJRHueBK7Me+pXNz/qcqog
         0zlMyHUaywXfYdP2EG3tvoVG2PGosjkfUrVcPbB7cTeQUW2Wp83VS+AJC1+Y5v9XcgCh
         c/kVxWkzwoTlUYnibptswgQ1FzkxThn7xBChj4+mqo42sGZ/351Y+I30TGM8Sc2YGfmc
         QORsogls8SGSWrH/nLdl5ztADjd1+/PcSleGfzHbHOOOVyp3jTCBL4jgfblDLeceobjj
         KOeg==
X-Forwarded-Encrypted: i=1; AL+hErHEw4ontUpJQ3MBCs/+pIOUe6xmHNUU5QaOSoTEiEbuSgNdhctAUDQR9diUgnWAH1S3Z4nM4Dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VelGERD6SimVYvSYgR6dOyE/NAlWlalizAoKKHkwBVbuHtxzi
	bteLrCnKrYwFL/tzX0iZJoh4x9+wzB08nASxEe/i3gyz+MwidrB5oyp/zL40F+pEae89nFy9ugA
	yBLFo95qniPBjaNersxq450mLSujPH6DCxVxsoZd6
X-Gm-Gg: AYBFou0iflV7Gh+jgygh+bODtjAhZbY6WVZdol91kykbXSXbfG2xBkV57qcUqkovzZh
	G5xLauACQvSD8k/AIx+H4mPjB8pU86UEG2ziTW++ZGatseoRBvfymZ1q2oDto4ArN3DpTfOLzzv
	W/rmibqLIwJS7/MBZbJAoXfBk+12/bNl4yXb+Dubnn6lUs7VmuVdSAQhzHA9jWaVy9u5U7AF6yO
	6bI5hE9w5/0mQk1Dc1OhYd+HuPR8Avud750Ocl8xPbqojTdez5D8gXqe6AIy3ToJlfYRX5SCjCY
	98NUPXZVEr0tG39E0FNAY0e6NDjX5eq3xmRyBLt+cBuv20DDB0XbWBXErgYufyKNkFPBIPV+Nm0
	ObJAoiWdcyN+aPUi0P3k04AiRUF2wcb9SvF6d0tsYejddvMi9Ylc+yA003nF3blSLBkN2tRiz/l
	ydfAEzNL+EDczMgw==
X-Received: by 2002:a17:903:22c1:b0:2ea:192a:13b8 with SMTP id
 d9443c01a7336-2ee0daa3657mr34970525ad.20.1794598002581; Fri, 13 Nov 2026
 11:26:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
In-Reply-To: <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Nov 2026 14:26:30 -0500
X-Gm-Features: AclHuK8_VELfOWb6QxDH9msFQuAihFI-MTzoli1CQDJEubxRePim00n173V_ijE
Message-ID: <CAHC9VhSzdLiJyRfv2+rScvX=6ObQavHvs_UbNKFDabJNzwC0Ew@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:17=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/6/2026 1:40 PM, Jann Horn wrote:
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Sorry for the delay. I have tested the Smack part, and see no issues.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

--=20
paul-moore.com
