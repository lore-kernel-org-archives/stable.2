Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C483093DD
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695059; cv=pass; b=MZEHiVKPQYcg5TNokZ2eg2AL+L4MRpASeggHIBDsVmfCngExG38RUO9dCkCqQc+Jv8otDM5U0TD+ud1jiUbSioEI3JDPJArF+81tUJ7v5lJIndLycifasr6JzmcehD403pIdg2jqAwu7+CjjUSiwmN8L+Y8QYVY1eW6Mv9eyguk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695059; c=relaxed/simple;
	bh=4r4q3g5VqzfhWh8kEQRXnv5b90zr1rjNtxEoRsVqBNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY+df0j3+8LuF/0reKpTwDcEAbkt8pElUN1R74olib6GTBxVzdPozCqzy6e+kS5NeTSQbzghQ207WOkHBTq33jE1uJ7eNGFTScAp2sUs4bQ0kbZOdXEhcwf/pb2vEq7zFoBI99w5STFhWJYmXJ9dg0WSlcb9t5DdiGoc4KtiS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayn6Ysc4; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayn6Ysc4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930f618435cso142310185a.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 11:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785695056; cv=none;
        d=google.com; s=arc-20260327;
        b=evCx9K1vc8vplIyvVZRlkTXnVBTOln1SG5kiiLx0/pKXbJwTYtp0syj3pvLTnyCyVQ
         pYL1tjbomHBQ7l3qHeU/XklVMIQQqx58ZllXm12IjQ48eUX0XolOmSvSUM080VfzR/Tf
         88oZjEVM7qSBrjBlLcmEPjS6nbTVPOi+sDyAosIhRhxviylms9AtDMaL5bZ/Dr578zk5
         jDt5tGju3l5v6eouuX4iqqd109AVPynVBv78oKfskicPph8R/+M9O+P4RuzEDmTcmdAn
         Y8AF+GBfWK/xmr2JGNVxSk40V9O8oHkMxY3YnV3jmK4yaactyAdK/v4zDhAz2ViHRBSi
         nKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WP3qLqUIjgO7jrMLKGvU8i1TpA1teHZXvnJrB83KgPY=;
        fh=AM/Pw1A46gXJzwD2jwMeES98nFSiPvWU3fNIdpKmpGw=;
        b=C/t971PBAfwy2QguHG6Glc5FbSNwmGL/JdWhJxueCfqTO8i0ZJjUAiXBAl4atAZUvB
         cYLGmoSxhl7FMt1VV8wDokhowXCfuHDNQzo/8ujHovIKETiStEdvzINeVxLJqOUTxalR
         +83GlPrkWF7EKgpS3xFqJK58vhE43JbV7TSLmKrB8B33dXYcSZ9JAyuUmIOOn9nOrt5k
         ThZjAhfkMIGnpcjQlIY5FyQZVOw+CMw1XIZCNBXTCxSZm1aR4dI+qZKEsrnb3bT7bSgu
         PZd59AMN0qrQpqVnrTQs+VcCTChDmq1ixeI0DSw2JCFru5CFqCi8hZUso34fgrDbC+12
         lf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785695056; x=1786299856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WP3qLqUIjgO7jrMLKGvU8i1TpA1teHZXvnJrB83KgPY=;
        b=ayn6Ysc4pHH5ptRzn01JqD10Skg1Ir26FcvPjvS2VTJFbc4dZOePw7mOn9qrNgX+pr
         AcT4oWI6LJOOy0OveQpDJQaGODhX+ljxAX2FxVXF24uAcW1Eu2njMx+9hv3QGYv9vhPF
         bCDNBcCHrX/Hengq9XG0pKgAKuMCB0PK/0N/Uc9+DJLK7w932P9juD0nBuD4pg2Hmua3
         K18jzZeG0TUlhb0I4W6LWZMn42HWygt2PMw8U0pFtklvzK3OAOsU994AaBOSsHmzXX5i
         suXsuSZ3ynMJBoTeZGg7pgTu+vugtzMyMSfb0fwgsgMZcEG4r0fv1oTxgWv6HdoEANIi
         ubZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785695056; x=1786299856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WP3qLqUIjgO7jrMLKGvU8i1TpA1teHZXvnJrB83KgPY=;
        b=Rf97CCa54Zqq3rFSfx8ouVS9Dh5o9YJTPeUNqHXGgVbhmiTZuofx9ocOWEum3rgAdL
         9zlcOahLOhq8cYrhbeN4h42RBWhsDKlxVbgnkW2OIMWMTBtm77YYitcAc/GQ1ENLmo9p
         BiN1pEcxRttG0T+ISXROYgc6Tz7p03j7jMA1EYdCzURu6reICPajq7VlDxv4aeAGyBmY
         0c+Om3Piw57QYGeQs8yZveY749830oRIdQUIvV0DQ2/GQ4iwjhtDeBHplM/jHuNuprPv
         glUsuRbMjQu7rm+uvWJD26c9lu2dNEU7KA2RbwyAi0LKWb5bz8DozeTPK1qnL0mZX4W8
         hxJw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7dCozfo6x/3v3jzFJIWgtJFHZQMpxl3ux9a5DQ06SIoW9qWjnGL1UNorYqPCC/HWIkWtR8aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRbA3sFaB9EA5tCPROi163qDj/EBO2QMpOZ0fTaT+cqIBhDIL
	7EpQUOoMm8dX8js/AmVREo7yQ5bBEKpVQBaSNxkLWF81HQyHNWb8m0Uq9V48BMoEeciEc6Zy/1T
	uqq1z8hT7btZFZ2Nw9KlPEaklIJxiVCw=
X-Gm-Gg: AR+sD12o2lBLo3eb1itlvIB5Yv9lXY3G/nN4EWa9adqhSEwuYINuaV5DFUQRWvrwecw
	5Q1vcPMRe0L4kQWc9WzHx/k9tSj1rk+v+MI48fCeY6Md9t9cZ18YTto/ecUdxjT/CtC7n2fFWFZ
	lS5sYwMoVhY2cSkQRdrBZtrQ8Q2ZZgX+nmYguh6A04Knpt1JE2vVuD3WJmcyYeoAJm2RXHiKxw8
	jR0DqWF72SHI3hr5lIUzYk/GJpDOy2kXfjxZ6cn2x68v+RRbnw50+IWlLokCmW79D/esahidl6q
	JNDc2PvzA65oetXhcV2ikNI6x+R/mltMZMqrNnkrBxMzXUMjtuOlsoGAYWeoeHeUe7Pde0pBNAy
	xISSRp7IkS1gVXiH7UjsJ91AsuDhd3X92WwNSkKGcYQ2qqbn7lHYNhZ0f3MgaVYKRFktZNiTmoB
	YAii7e3l6TnEKIyjBT8C1ohCcLtVjKlSoCSrY2lK2qBcKC9deOjbtOOK53YX8=
X-Received: by 2002:a05:622a:908:b0:51c:857f:9c12 with SMTP id
 d75a77b69052e-52b5669de9cmr149737711cf.4.1785695055997; Sun, 02 Aug 2026
 11:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802004809.1301715-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260802004809.1301715-1-shuangpeng.kernel@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sun, 2 Aug 2026 13:24:03 -0500
X-Gm-Features: AUfX_mz_5HOFDX4YQh7cjlt1h9LRNSHnEfYzC6TnVn8q_yfn1u7JQu3SFcr4XUA
Message-ID: <CAH2r5muLehYvO1FxJb9WjOwrK62bSOh8Ke2EzxRA3b=WS5gH4A@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Fix use-after-free in cifs_try_adding_channels()
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Sat, Aug 1, 2026 at 7:48=E2=80=AFPM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> cifs_try_adding_channels() takes a temporary reference to an interface
> before dropping iface_lock. If cifs_ses_add_channel() fails, it drops
> that reference and then increments iface->weight_fulfilled.
>
> A concurrent interface list refresh can remove the list reference while
> channel creation is in progress. In that case, the failure-path
> kref_put() releases the last reference and frees iface. Updating
> weight_fulfilled afterward then accesses freed memory.
>
> Increment weight_fulfilled before dropping the temporary reference,
> keeping iface alive for the final access.
>
> Fixes: 6aac002bcfd5 ("cifs: failure to add channel on iface should bump u=
p weight")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  fs/smb/client/sess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> index de2012cc9cf3..7cf7dd104f7c 100644
> --- a/fs/smb/client/sess.c
> +++ b/fs/smb/client/sess.c
> @@ -233,9 +233,9 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
>                                 cifs_dbg(VFS, "failed to open extra chann=
el on iface:%pIS rc=3D%d\n",
>                                          &iface->sockaddr,
>                                          rc);
> -                               kref_put(&iface->refcount, release_iface)=
;
>                                 /* failure to add chan should increase we=
ight */
>                                 iface->weight_fulfilled++;
> +                               kref_put(&iface->refcount, release_iface)=
;
>                                 continue;
>                         }
>
> --
> 2.43.0
>
>


--=20
Thanks,

Steve
