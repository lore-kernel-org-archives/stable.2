Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794912171;
	b=f6by65hzEwirj79GkC7yngsy0jfYme3PDcV12fqy8UlgOZ2wsBVRtFShiNrxZBPgljR6
	 jAMmaJjcFA5kvq0M//jsS9MebkprihZlrmaFP1cnQ4K8RIpopGINwGQOvkyuJ9FlKC0FP
	 WWfqhHW2zJfotVEtliR0+U0YFWHLXMWO5bCLqW0NeWjWleUdVsj5SVKVP7tzY1mRoZnLF
	 5g0YVqyRMI9LVi3utQEQ3EZiV2lCG5rS+91XJWmRiyfY3aXRVoUSrcNTPg+NxvPYiJRlD
	 dMcILkhIrh4LeiKZQqIjCtyaBe82g02550TNGAOp/Uj+T4AspTrIE8v1X/cxsXvYXZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2K4xTG4xWSYcGUU6Ck/HjLgjeLHgRelJwDhlANxGeH0=;
	b=uRIAAMdsk10g+xi1iicTuoM/TyEOJSD0opa10vF9pMV+teIs79ClL8aWvvZLQr4o2BMk
	 j8HDyz7N2uZ6l/AGq5Pj2XU2uYkjw2ssquwPWeMyj2sfaPa5O55/UW0OWbHoRQpeI1mE0
	 imNmClhvOgvWS25Q5AZwGVn3ft5loC9uo3avkQjKrFSaeApQKnqVxBNhIYwE76UDWYxRX
	 jwJMMzspJSYS02DzcR99KnBxRdHtTuelNKiUCCzUbjp6po2+zRj/gbYLzmJkWO9XCOBe6
	 k+L32V6oX0p7UBMohsyvenEeH/VmdgX5cp8R5CpH+lhmcXuSZE3LAjPy4ziMPJ3PhNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9XX7sbB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D115606A338
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D115606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9XX7sbB
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2790242eec.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794912171; cv=none;
        d=google.com; s=arc-20260327;
        b=q2mm8cILlsX644E9QkimlJN0zVg9fj7MwKIJBl7qsTCcotr4D44OZ89B8dFtaHbuQD
         vqCulgKlUeCvuyf3m1avPV/Dk7xxlR18fjF5MRlLjRQ3W3H2XiK4LijX1YFZJUFtaG3e
         iOrQH8Bz4AGJM77RFB5m1Y2CUAZeJAvkp7krThMasNiOQ9Hd9ducnBUYuABXhtyNt7Uh
         wQIkaE24s5iJtnJhNzhi1bn0JzDoomHb3TxqfcfPjmvmGHRpGBUK81nPYzyD/RK1fh3p
         H02XlLswo6er3mPkaymmbJzSzUuLwHtW+3Sc4TvVK9z4IVHtbKwpAcexDyS2YCgPS5sk
         XfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2K4xTG4xWSYcGUU6Ck/HjLgjeLHgRelJwDhlANxGeH0=;
        fh=YcIG8Jm1YvxE69Qc62/Z7vcZ1AbKactNnzLfErRqKbE=;
        b=ENubrvGTr3KDk87kuXDyNyUAzNA7F/ZqVy49ei6lBQIwpmJ/WsuvbJbwPmhGA/DIfj
         cps0VOWRUKJZT0wQ4356M/MPRkPM+kTeBrvl0ENzQJvyXvFi9m2IZDPbIGsPl+mes9Mp
         sH/fyk+QKSXM6aRwRjYQBujLZuJmMBnIHXMXj3+yhLt6Dz+a3JVdAx/nyhhPCdoRcGbC
         MFVcciUXRgGcBUZe4ariCmZaOx5TlfTWViG3c5m6E+hrWv9p0UArLJK1yTcU1ZCxC3ja
         Qd5mMFEd5UeVQ2Y1JXC3PR9FtKYzFQ1gA7XyYRXm/Xh41wuGBb5Pw3iMEKjnpe/8LYdz
         JKvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912170; x=1795516970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2K4xTG4xWSYcGUU6Ck/HjLgjeLHgRelJwDhlANxGeH0=;
        b=F9XX7sbBGR7GouHuWGezLAmbKtVKQHZ8Oeu2iL4zpWJKnROQcZ2s5Cspj+RKbTEvrC
         XQNC2UKsm9V05bFoE1pMpCMiflQ79UjbYv8sA0F3fkR3DQ/GFnWfZi9Necslubvm0Fmd
         WVycYxZk+x+5t3XLyRLFsHdGWIrnC2gMZ9EL03M1K9MFSo9s+tX/kFdBHa8yZLrl+bnR
         KajXAYQY/D68O9Dmj6nGEG7Af61W4spiH2GRp2EQIkQ8QJP924vRlZr+p2HiwQKzqICh
         0solGFlFeLuwRC1mnOv5IECODksGUc2ywzVDucETnhuJuAxM1y7KSRt0D5NBYT9jRN1y
         +s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912171; x=1795516971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2K4xTG4xWSYcGUU6Ck/HjLgjeLHgRelJwDhlANxGeH0=;
        b=VadM0zjUhQlVyItvOt17bA8o2ZvXA+n/2hj/GIpMu/xwR9tU3YYCNxXAg7YXMM69id
         jeUPlX6M6O+1O0lQ+fhB6A2gJpMCWsPet8vzJKZI8umk9UqXJv8hFtyJdxJ+BY5K8z6L
         KxttdqRGzIRFcB+KoIaW4GxBsM2TebeJsd0i+ztiJDBURubjQtzSBIgKWSBHEigzzzLl
         B1nprjgeQpWvvzEjrSGBAg+HA2gsNlh+fJLPz4cc5u29M0pVLwssii8IwfWqqHmxSWZp
         e2LadBE6NVWXMJDNzVceSeGxvtqnk8xy/hcxPzeFmw9OmA/lsddH5ziKcnTIgRBRS/z0
         ZICw==
X-Forwarded-Encrypted: i=1; AL+hErG70kaqPRSAv5M9SjYpoeFnYTeXflRAkI6hqVc7yCcClTodlnD9kIdlMWX1/aZPX+kyHZEZCNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vTxo8YOJh29lxi0R/HDngymENWGCvT/AJzWCFEVFQP0JT1o5L
	xQ7Jepox5HKqlem2p1a0LyWgjr0hlfnija3//vSWWnRVmHBEY3g27i9vPgu8wkVeZHO5/2fQSnd
	jh4dLnM4M8FxN9LChVDorYr9pI+RJ0zQ=
X-Gm-Gg: AZFdTZdR0Ah8jVHpgu+aFQSTwES1KBz2THZdDfxvBMVBzKoz+LbuKmI6eim/1GS1qU4
	TJG2qqYDBLozvSdLO0uHdas9dZabBWcm+eyNSJxnxOc1bSkKAL58ZqdgPwlyYMycQB0ax+p2Z5b
	pDluDHk9GB85xfaQ9LVwElpvyMuC3M5AjSb55NJeKibA7RuHY+zKb3Z2tfpY3pVPmQ5fOETr58u
	YMj53Kl25u08LfUUgu8yTTEg2hNkdpS8sh88Js58AtvlCoPGVeOJOPB9lxv0zVJWifbkabnEE9/
	TlaXE9M9KgCDcf//6sqCzF4EUMJwLUhlgZLgUu/0r+IuHh60/iMpd6KoJc+bfp/OTll75xT+BzP
	BGLwHlTSEfoshqro0Ovq5zDSdYwwYREcMgVmwiLpxobM8L0VHz5vyW0+/JytFkiGaJ0rj
X-Received: by 2002:a05:7301:658a:b0:381:1eb7:938e with SMTP id
 5a478bee46e88-3811eb7b15bmr3003773eec.4.1794912170526; Tue, 17 Nov 2026
 02:42:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117042341.4023597-1-hj351016@gmail.com> <CAKYAXd96-RaGbakDedW5eOgmV8JUhAF0_25qXLk2YimiT4wngw@mail.gmail.com>
In-Reply-To: <CAKYAXd96-RaGbakDedW5eOgmV8JUhAF0_25qXLk2YimiT4wngw@mail.gmail.com>
From: khj <hj351016@gmail.com>
Date: Tue, 17 Nov 2026 19:42:38 +0900
X-Gm-Features: Aa3M54qrUz1WablDAXNbu3oc9qupG3hDYlxl8MWwGpKOViJgsXLZVPrlk47_ZSc
Message-ID: <CAGr5VtNX_Fy3PqcxFBVgAxtz2aDbSD_n_HgZK2vOBpj2Bd6UJA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: reject SMB2 read on a file opened without read access
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I missed that one. Please ignore this patch.

2026=EB=85=84 11=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:35, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Nov 17, 2026 at 1:23=E2=80=AFPM Hyunjung Ko <hj351016@gmail.com> =
wrote:
> >
> > smb2_create_open_flags() maps a DesiredAccess that has FILE_EXECUTE but=
 no
> > FILE_READ_DATA (e.g. FILE_EXECUTE | FILE_WRITE_DATA) to O_WRONLY, since
> > FILE_READ_DESIRED_ACCESS_LE does not include FILE_EXECUTE_LE. The resul=
ting
> > file is opened without FMODE_READ, yet fp->daccess still carries
> > FILE_EXECUTE_LE.
> >
> > ksmbd_vfs_read() only checks fp->daccess & (FILE_READ_DATA_LE |
> > FILE_EXECUTE_LE), so such a handle passes the access check and reaches
> > kernel_read(), which hits WARN_ON_ONCE(!(file->f_mode & FMODE_READ)) in
> > __kernel_read(). A remote client can therefore trigger a kernel warning=
 (and
> > a crash under panic_on_warn) by opening a file for execute+write and is=
suing
> > a read.
> >
> > Reject the read when the underlying file was not opened for reading.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> Thanks for the patch. The same change has already been applied as
> commit 2fd145f8865b ("ksmbd: refuse to read a handle that is not open
> for reading").
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/fs/smb/server?id=3D2fd145f8865bb1a6c38a3dc68fa44290008789d8
