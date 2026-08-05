Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80447044E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942664; cv=pass; b=oGldsVf4wA2G0Ii8q+ePzMTTvbn5vsci27JE41sHaA4WS8hZOxlRe4ZTJqZmekkdbhHpcDh8dM6nEDk8PQjttNBkmQHsSY4KE/uLyU17jtq0t0OHAy9ysZVhbCosQbqaooCrDT2NZQmq5w7nfkHGwYstqT/hvlBKlH8j5HV4l0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942664; c=relaxed/simple;
	bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSuzwxH0nqGZGlmTt2SKFlb1K0jeKiaxSAFnwKTPfqI95z8q5FZf2vOprgnYqwZ7GQz4lWIm8UaU5eN80P7fZCp44AJDUv/IOIhOO+CB6UiNZw3OKRtgU+463XYm5b2JbJp/v4oKs1tOMiq+k0WsfI3Fg4DBPne0OJHs+6+7GzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EktfBeF+; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EktfBeF+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso144855ad.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 08:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785942662; cv=none;
        d=google.com; s=arc-20260327;
        b=DJKo4njgiZfrXi54qHcV5r3+Afc//sECmOH24sflp1jvDdSHzycqIsuSJLDwnOS27/
         8Y+dvrnEcDPoGMEk+j6usTmad4+PFEb0Fg0Kd88yUdkP0n7L0G5yUc1Ibfh1fBCIcHzE
         Y7hV2PECnvPO8DbDOdVDs+qaDPI3RP4bLrZPw3UnjyiQcMU9ornwG0F/6DoEJ3KJaYZh
         6wKc24jtMm7BuRNIodWUMO0BTaq79W7nefXGAQETNfS+1WjbTX6PLzQ4IOfI9uqeEv9s
         Igdn9Vxm+8RGNnXn8gB4Zy2GNY7QiyWNI7sbLlsLajQ8JLwTp6KCIm0VsItl16Z4eUpB
         Tv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        fh=lcDrGSH5UYOjeFliJD8izhz6ufk5h9vQ0w3CvmVwrVs=;
        b=LhokgKCWYLG8ZW1TWrpsI/QBDoe9Ztz2mF7fLi4RqYY3mU5S9NeIgpFguW8wilTnIQ
         yuvw97W16zItp2yWwU0+uyhHhSdT8B3vb9sqmVHMyRGFKbhLGvZu0h25mMJod0K61ysG
         nBCSWYZnLhLy4rC4+zYJhSvSbBW15xx2LGzZoQjtnbTzc+wSKrXDeFhrbJ9cuWnZINj+
         qL7oTQnxeR9GTcpMLOvYNtJY9UKGJdHJBb671rIrQJDWCQntsi3fRbIaTquZX+l9nG4f
         iL9UgYEv3NqZjjhA+cZBH0d/TzVbbE6jKhshJ2HviG3O22UjvbHFepP9Xlj40qdvf8q9
         qKFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785942662; x=1786547462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        b=EktfBeF+Eli/hjyQAyfsOwBYrqV/5BYcCuBgoTnnKs+g0hgiQ/fqEAhXkDeJdmcEfo
         wUCzHe3fxTVa3FZbgkN1S56iRDhOf/7FPxNzzlSVs20aMnPI3PrBR7P2MJFwn7t8zUNB
         tM/78rNvoViiNeJ03UtQACOPmT4zzY/2ZLEnyPigasKU2TRdAP9TeoYokiZAcxtC14NT
         MvynT2b5v418NTqvtDZcx5sXLSt6Ud1yvb2w0jttlIWxtjS1w6GN/F5dc5XD1dQKRW6z
         Y15ok+xnjJyxyYciaTrC1Z2UEoOsjkhWD4CV83uKeaKTbNudQn+unTDtlInBlPflw7pY
         fKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942662; x=1786547462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        b=RleVeM8QmZDUPYSOcJpAqKAZTbG9Mj63ADoRpVx8D2YgxAyDq2MKQx1Pcu7cF17Xml
         EgRQ3RqfyUOdTcpWDw0Ere3TcMOz4Y/ILp9P0tCSf0M0UTggFJ4VhLM3LY9/jt0THU7d
         qjsum+QvlcMIbq8EaDLZ6KHUF9CbLxU2NFaDkp4cU3ldenf9D40ReRvfP4OEJ4fLmBP3
         kj2Phmw2AWz+S7bhDHh/8di07Hka/1amC4ybLquRe/o0N9rIT/qKOei6eFB5mtHjbdXh
         jgKM5vth/s/X8OAIUs0NXisXZbZYN4YqlIllAX1jKZMy69Noi2kAL67MHru+h/OxYYoB
         OVOA==
X-Forwarded-Encrypted: i=1; AHgh+Rqu9zvx1lFRp1Ha7fvRXlXGgbrkCvZJGnCxHmQ3OH6KTlesDsgGaUw1Zs2L/F1f/H/HOYh+w7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKW3ut5wBPCTL8RU4dDYRSyDWYfEwKDONE4I0ddJPWRWtpFbx4
	1dwbZ9u3cF8FpVFD1WgjJADv5kn3MnZt9p7fbUIHra0Cp2igvISx1jQ+CiYo3eSNAVNRxOlaiqX
	b6+f/bLH5rchNCI0g2BvdidCAumTKRG/Npp1vov5i
X-Gm-Gg: AR+sD103RUdkSO0gwkOsaYhtP+iCJRf4PmCxnXV/G+Kn5Di7EP449wNVQHbylD2eVp1
	z69mPWDEI5cKXXkfNz+dPmuOPvLG/Q0jUh+8LKYXHUZDh7AntuKta2YQlrvqrkjIlb4SvFbNZR8
	VuwFmFlsbFjXwxEDM63mv2fyK1IoUxJs61LQYwKFv4r0w8GXjlYALjnlhKU3ymXnQQIA4gCZ3p3
	wg7TTcUVgIXpT2hG/FnwNlWnSESqppA6ldJiN8HEi+DsUW3C2rU1lHLa3MW8vBDKB5miX/jquoE
	PqkIKtYX5te+IjJMkHaN6DAetoFAEDMy1j3fmF9z3Lf9ROJu+JHjVnj0Bh7hoOliWxGGux0Mml8
	KW+PNiVxeJ+FhNuxWjuLiJ4uhIZI6smE=
X-Received: by 2002:a17:902:da89:b0:2ca:6bf:5bac with SMTP id
 d9443c01a7336-2d0cae8f44amr11533235ad.8.1785942661451; Wed, 05 Aug 2026
 08:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
In-Reply-To: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 5 Aug 2026 17:10:24 +0200
X-Gm-Features: AUfX_myTcsrk-R7oyPxABub-MizWAf2aGlhLPWIrIHNJM514VudAdz5cv_qhGcA
Message-ID: <CAG48ez31uJ1utneG2VepgkpYp-zpmypoBJ5TTXOxiPLrZsXTrQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>, John Johansen <john@apparmor.net>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 5:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> AppArmor's begin_current_label_crit_section() is a scary function called
> from lots of LSM hooks (in particular VFS/socket-related ones) that check=
s
> if the label referenced by the current creds is marked FLAG_STALE, and if
> so, attempts to use aa_replace_current_label() to replace the creds with =
an
> updated version that uses a new label.

ping, I've seen no activity on this fix since posting it
