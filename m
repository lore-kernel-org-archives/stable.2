Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E533F5BC
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786794889; cv=pass; b=Vcxug0MBzfRbqR3/lDV4kYYa8KWEWB5nSDQISG8Z3clsaZL3huYO+OXwj4+YrWKwTSF+/sXEcSp4RWqtKgqfJT/sIPB5f1sRO8+cMceZiyu68tLnIIUbh70F/+a79iZ5cljSKwBlgW0raMdL/I40w6KJdfqb7x7XuWaUSLDWYOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786794889; c=relaxed/simple;
	bh=DwDn4FlgRXsSKB1MiSURzLVBVpvmD0h7YLZFcLJup34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSo7fjNeZJucsfJi/ogWUTSpPgFVSVYxcvu44lSmHdAUxCtAJDS3kBO8KK8QkvLGMaSvU0hiZzrFHKrlScYuC/+9zpQS4IZ5isece5S1L31/3dNxXPWDcEnvwKh3xLRmmcnUH8v3iSdnVRL/lY1eP8wNndwUIqfUU/xq8oceAQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBSEBdIG; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBSEBdIG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdce28edeso3236215ad.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 04:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786794888; cv=none;
        d=google.com; s=arc-20260327;
        b=jwbV/sRj9kQc9FvD67DUt/+4hhmkeRkFWbVuZzdk/lIttEb/a+HSMNVlAdxTOPm0de
         I2pySif4OOMZpU7n7kqGMXhdnemAA/3iJ0IkfcuL6YGAmdIKVwBhsD7qteh7umZcOyWz
         Avqjzvh/fExHogcBVG3wUDK9ZqQZd6nJEZJXwQO7zPM+cmSLcqfGOv+T17olMbQc/wta
         B7Z91TTElVkDtolw2ZKTTEMwADQywOh3dv9LrJPEMDt6BG+Ho4EQWSxkb5nDw46UoueT
         b+51lkTVKJnDknnATnIrfjiJp4jVS8KWweLtU0Jp+Gi3c5Hq8LR249eQv5VOLk/aYJGX
         1qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DwDn4FlgRXsSKB1MiSURzLVBVpvmD0h7YLZFcLJup34=;
        fh=CLyoIA37UYRn0uoMGeT7we+ZMfCGGcuuPtwK1UL3mFI=;
        b=bF6mrLJ9uHjgtkzS9vr0N3SR1sXR6OVe0Js5JdRwvG7HcjJiEphVAmdMLt2odt7gkf
         SyT8kZUz99rUFUkxEr+13BZLpwsOln08F5+d1D6N7WCkbalpldn7R+51UrxJhh2HRt7y
         NAW+g/axzvr66tpX+Ga1vW0vZFJ4AsSQg6uox/D8MPVHe05klZNQbT/B2GcRRQ8x8/Y7
         b9ZinuTebfPa90yIpswlVqgsm9FX4RX6DENvZxYyxCMCjamtqxJZq+kGn7p7jQMhRYTV
         utiHZnJWQ0A7YdCioOhte/u+eXVpooT0l2huvb6blRDVETc/NUW5hUO8eKC/B1VHOduo
         msow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786794888; x=1787399688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwDn4FlgRXsSKB1MiSURzLVBVpvmD0h7YLZFcLJup34=;
        b=aBSEBdIGKVosPSdXjM2qQvYQY7nUx77PxeOSRv9W50bBZ0V9/GpBrGrE+TfMdCkgOx
         JK0Fl04ZSiGhzfKMLZxz48I1LBNhhwvBty5eiTOJ9hLVxh+2dyv3DJDwcE3K0Zl03J97
         vKmW8y5KI1pC3xmN+gva34uzxfVxvU2feBHOqL5H0NQC4UKDAiWcxVU6PcgLRWD5ZRtJ
         vWOvmZS78NVrgVqA6AAUMDr1HlsplkGd0QxP385ZxSGTUMYFgUpUhvLk8WJWR8vg6AZt
         PMDPl2VzKOb4vY0kNl9RlS5P0tHeu/yQBDtfqEJpLG+uPaoDapvI/w0g3AT1fvOqRDpb
         hdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786794888; x=1787399688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwDn4FlgRXsSKB1MiSURzLVBVpvmD0h7YLZFcLJup34=;
        b=jOG/Yqh6CggzqE7pJSofK/bICI40ksU+juCvIfAByeMElNEPOYXdyMCET/RsuWG5Qe
         Xnn2j9QZBIQ5eYKdwUHWmrgeFmqZNsmJalsapM7TyDSpUmeFAmjsQFhU8jT/STAz8Fo2
         u0awNkquPskCi53GEg1L40IIdZCyuZJrxU9fceW4bV03n+pLUs6Rl+rY5WkkexDsFTtE
         fk1FGCUODyFcfrnHDzIsnLlly+w1pZz80enR6nW3lccTlG3HFr5KnXS0BADwI5AiJIC9
         vRrbx9EJmBsQYmiEpIvyXPynY3MLoeDqQ4u7KDCpL27Rt6P4uYIY9mIwuUBlDnBae7Q4
         F6zw==
X-Forwarded-Encrypted: i=1; AHgh+RqaQ6B6goZPczxda8Npiw1+Ou9idVQ2D5U/5h4cDKQkviJUErHeMfhlx/GEEVhwf3hbTivcCaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cKxMifD7Gb9g6pl2OoOwWZB2kRXJ9HMcafQ+w2ihaZWQxlEE
	7Z5GUVsTjR2QJrMW2OarfBKsiHE/9p6FFiXBzBzBkBogb0XKQXnXNlI8y46uFdiFLoJ65Uso6wx
	XE9PaoQhb1JKfR1FdOc6Shl/ZYDxTIwg=
X-Gm-Gg: AR+sD10hRv+AFYrG6wkJNsZ8G9KY+aLPhr0LXD0QXu5ed1LTKweZpDT+3gOithTSusU
	kRoQDNDSQqEA6HkBFNLR+79Dw56NlT4C40JjtdQhgX0kO9/8zbF7KfX6GSYtZMHu0TSBb1fVzr6
	1XXbmS0LKR/9NsLltN1VCP0kckvVX/Ab4QIy0IFf7/rt4YlfBkTysUT4Kohew3Ws+0zc03bbEUC
	vbfXLUJ9yZ3ngoJPAV5MLATiuukVrLKRacqHUPa2w+zQHyM0QFI/JdXZmNYESWLnuTd5jPf1bjk
	sIfk8x+ASemYbQlyqajgrdBnPu4oDkWoQkM/ilZ0oTfmoNPjK/mpcnUg9aS05A129Vk/bwbpr4L
	wdghfKTPiZmpchTfZ16vL6NxomQuxw9lUaBRNRABDfldCY1XfGFR8UCGjUFXp
X-Received: by 2002:a17:90b:2d8e:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3933bd2c8bdmr9717410a91.1.1786794888152; Sat, 15 Aug 2026
 04:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815105950.1109-1-getshell@seu.edu.cn>
In-Reply-To: <20260815105950.1109-1-getshell@seu.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 15 Aug 2026 13:54:35 +0200
X-Gm-Features: AcwNN1W9c9Czz9mEsq59ulmrZzIGbv37GqPkIfv6nkihmv0oG4NHyF-3PG6mQuo
Message-ID: <CANiq72n5L-o4j0sYRKKN=uVE9xtwWkQwKQpdxjweB-Std-jpeA@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: charlcd: cancel backlight work on
 registration failure
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>, 
	Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 1:00=E2=80=AFPM Hongyan Xu <getshell@seu.edu.cn> wr=
ote:
>
> Changes in v3:
> - Add Cc: stable@vger.kernel.org (Miguel).

Thanks! (Usually it is not needed to send a new version just to add a
tag -- it can be added by maintainers on apply)

Cheers,
Miguel
