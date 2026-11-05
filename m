Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897103;
	b=mkvYXMY+C0jMl1q/FAV4/KkDqGyvSlh0fNIVmLmpPha1/gobQhNNYlggiYKwt0Etu/7o
	 lzi/9KCb2zIJUB71HkRbRWgTw4XT3OgJskScqjoghRdwZ9nc3RZu6GmHoeJ5yzzXKviur
	 8cB9RoJ+RJZAHtM7KsFsmeROLgLYNfjIFmTy9xS1hzlk/YISCD3ZFPSahSf895CQLcl63
	 IR4d/AmgsLj5YR5sWWjA8Tt/ZRGD2Eruub/+BfijaZd0pNbQFShCDUaV++91ofTdKHc1C
	 UHvyJIcr4LjTIE5zKl9j+pnOtFxWgMxfi+5b385cKr7UwihHt3rUehnHb2TL1pFqOsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
	b=imV4BzLr5nDJhNQti4YpDFPOUTpyPcmKxo+Wcz9dz315GdcALyEp2LmPoyHR+Y/GwUBa
	 WJsiOWcyp4kpWS9bAfzTCCO7hpV8KKI8yL3yXqXa762yL6mvyj/NgGm1bo1hGGiLixWSN
	 K+uEoK8rK/6F372l3sXxMUo9j5pJONangQ9RaAsKNrU2ZoTQARQkg2rrxvFeMVRs1/KBv
	 X+fOnoYjLr9pVoaj5xJGEkoI5sk4KzflkVeEJoZdFY8OjWgOQVMvHV2iC3TnAgXR0r3XI
	 qsGAb0sJ/K2PjI4DYd28O3hXNcyWG8lJ21TJcVl539xwM2upY4rgwyFkYBds9NpqeBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeWQn8+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31738606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31738606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeWQn8+z
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed3f563739so9825ad.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:45:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897101; cv=none;
        d=google.com; s=arc-20260327;
        b=oyIyKcza4c443QyxeePqxgawZCN1gn3H5NE72njWPbk+BTzy1OXDxU0PW4HURqqYQe
         BqK81YK7izymvKe7UZjujP2dz6gj7+qvT2e0/iJ9kjMWmlIuJ9fZI0P7D6HWifMO79IJ
         /SMapXAtPoU4bbAC+yRk2Yu/eerBCS0lKdUpPdmCiDi+3azuzSTk/aqplboFZRGdeuiq
         xxciFb4PEaCUXrsUfmpM475Jp7INTpbkRi4Hl9aYIJyQ2kP6xykUoO9J+L9qNvgHOZFG
         l4Dr/87pPp1ZnTGoJ0F31cV1T7O/C3WT4wVdlxSI8JBPp/IeTBIUkHqBKpHYu0g3GAKg
         pxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        fh=+ZsDOs7dGQre9lX9Zz38wEB3XSx+b7mxln2Wtc/yVXE=;
        b=buxHSFb2cK+Z2boMGRY2akIRoVK6W/NZmKlxYSsGjWHsLTxZzqsNtFC1k54mScBoPj
         u41dgjmMhKI5mQfQcrRlOoAy082sJsy7fmbBkCIxvDHNX44JugUf1xjrTs4ZC8seSZKL
         0MxiE2Qc1rGJf8hiY/yqPf+XlJ4WZXHNEQ/fqQMM1AZbPRfKZhZValcTyY7aoUSKLCkO
         Z4nH7PpOIbN3MjQRJysqrwr7UuNKZec0JJ+XoGPescusZiqX6cbbWm3lcTV3SAS6YcgG
         61F/nRmDa8EYJ86ZissyJS3F0miBt96lvZze0XJR+zE78YuKU70iPsQp7xENvZpdiuw0
         ZcHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793897101; x=1794501901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        b=GeWQn8+zTCHvUtarI8ppl7DxE2DxVhnh3Q3uJMcuo811/kyKqNIvbJWgM44d/Z1jcF
         uxmZ4HtlFK3aSnR0TpKMlENeCTJ66Vj86SOJ0/Fdfh8t1Cj7stI7bnd17Zvp3zgU+34M
         bzAZN7oAmeii/J8KUcDC/yM25/Sbdl7PX+ToYXi5fBWmc3IFwetmuW3nrnkHhPSIrke7
         JMadU+uRc/vwrPc410zSBHmfVbJPQ8+Y7/0vOIJcm6g+X7vLsHIE7B3bIW/RS538Hi3A
         MbXbLOH0GrIrlZHra2msMNU/Bx1iAwPKcy2ZsFUi7kZl5+78lIcdmYBOerALR38eOCI8
         4SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897101; x=1794501901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        b=HfYozB0KE6dp9SWRGErncSZDbxjcLMC1KwTdSXEnXUGVWEr7Bf4klEcS+l45XDb/uh
         SiUGyU+4c59iiVGXamJi4o5M7yzWwWIwkE5WlO9AzbfTuNHg05Svr3jTxRGWSBKW1IEz
         vxTdr2ymJhJ/o3cu77FKQZ+RvcPfqBnBXSj+FMoX0iVCgOBp4MwVyZhfbfXQy0YNdAUM
         iU8Fmb8PYxjUDJz9es5Bfojx+GXXrS+UPNjVCXepNls+IUPjt+fhwjRd65/64lcpNJEf
         /Zch2vdvlaj66Q11NGieJ6SPAdGmbA6tqvRH01Ld6NZPaCHcTTY3RZ0MfvjWf5tNB3ik
         kPcw==
X-Forwarded-Encrypted: i=1; AKwUvBypRdnzZ1wmLql2MWn5uTdnwTGW8I64NGjGWNHiVGxJD3+XyXYb5O95rTRm84EgLAu2/sKyPjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+joaOELg1gFelXn44CEWcfmo6ZPdqRW4Xk1qGdUlsF/ia/Uuxz
	Fvvme6HFBIL2WRYA0rMq2S6UPIO95zRgTNoUn5tI9jgymveEMkuW7NmOB3vyOFEGSA/Q6Q7oSr/
	03oY5eyNMn97fcbxT38DXUP24NMfu29W38SbOcVOU
X-Gm-Gg: AYBFou12nK/l7ZdbYk4vCy239HwfQQS79rQkf5z9ivy5B9eD9fTn9l3JCiEkZxJoMNS
	aopXy/Tf6pJTlDmQJqsgdn5vNnMjpte60C3eURJNti5owqiYBXsBwib06JgmLWXvezMlOpKXrTS
	dnn/oKjgQ6ga3SXX+zJkaSJ2O2onBXyo4/cRY+Q8Kzgb7SiDAK8UrszOhrWJoWHOIWizJ3uilC6
	rouYjDwh3O+hcFMSg19jLBHNAH7nCN7MLKbT7kWvhdmK1C4/k01YSTteXsVrBObqw4+EtoiGh8Y
	RBiSmO9Wn22LjXbOtwX/wvBTPzAGvGCmcAGXv4QGZcTHQg29GOXdfnisfPFb1Vwon/cXdCFeeSI
	8aZNKWJbbg/xOkUyXjTjXeK37rK6Q/gjSuVnYva0IwfIj2RGIE5AmS1JRM8S4xaMaAFsrIRZ8u1
	qXiUmtQR1N1F+yst/gSj+a6rM=
X-Received: by 2002:a17:903:26c5:b0:2e6:344:7bb4 with SMTP id
 d9443c01a7336-2ed27dfcd4cmr5295155ad.11.1793897100818; Thu, 05 Nov 2026
 08:45:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-19-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-19-59422ed3e465@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 17:44:23 +0100
X-Gm-Features: AclHuK-fnefOFLp1bzMgat_Ywl30iLttA2NtTvDkjZ9zj3bJEHqA_bwaqAGV1Yw
Message-ID: <CAG48ez2XEE+U4iyhxB6b2Zm88Mj6a36iQX1=X6NyJtB4o6hJ6Q@mail.gmail.com>
Subject: Re: [PATCH RFC 19/38] proc: resume readdir after the last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:26=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_readdir_de() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is added or removed in between shifts everything
> behind it by one. Listing /proc/net/dev_snmp6 with a buffer that holds
> ".", ".." and "lo" and adding a device whose name sorts before "lo"
> makes the next call return "lo" a second time. Removing one that sorted
> before the position makes the next call skip an entry instead.
>
> Since commit 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()") an
> entry that is removed while it is being emitted also ends the listing
> right there. pde_subdir_next() finds nothing after an erased entry, so
> proc_readdir_de() reports the end of the directory and the next call
> resumes by number, skipping another entry. For /proc itself
> proc_root_readdir() takes that as the end of the static entries and
> moves on to the pids, so the rest of the static entries is missing.
> And if the position is behind the last entry when a call starts
> proc_readdir_de() returns 0, so /proc then lists no pids at all.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first entry after it, like kernfs resumes after the node
> it stopped at. An entry that was removed while it was emitted is
> continued after by its name as well. If the position was moved by a
> seek in between the listing counts from the start like before.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

> +static void proc_dir_cursor_set(struct file *file, struct proc_dir_entry=
 *de,
> +                               loff_t pos)
> +{
> +       struct proc_dir_cursor *cursor =3D file->private_data;
> +
> +       if (!cursor) {
> +               cursor =3D kmalloc(sizeof(*cursor), GFP_KERNEL);
> +               if (!cursor)
> +                       return;

(For both this and the proc_sys version, you could instead do the
cursor allocation at the start of readdir() so that you can return a
proper error if it fails, but I guess it doesn't really matter and
that would complicate the code a bit more...)


> +               file->private_data =3D cursor;
> +       }
> +       cursor->pos =3D pos;
> +       cursor->len =3D de->namelen;
> +       memcpy(cursor->name, de->name, de->namelen);
> +}
