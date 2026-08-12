Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80338372B2B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500738; cv=none; b=hPlvJp4q8JagXZ+dRwYQJAzA1VXsO7g7Nlj+9IpqBb+i5o+YBE5A/MObHzgM0XHK5RvIK6RPq4slChltfOBcPZioEdDBmam10OFJJqtlJWeciZHXsT0SOnQ82hK0w6cuwL7evRLenpZjBDmofffUqaAgidTNl5drF1jGERr0XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500738; c=relaxed/simple;
	bh=RjnVpJtgm1aWzrGK2uQx+y0xAN0zBrOwrN1HOdP5iD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK0JZia4Tmx8fHQ6oIr9UmBfw6nM5oxo6kt65nbAj90nuO5T67eG00LND9C5U2QXoxCLm5cCdF+O1Cy8L0yhUOa5dy1SyprBsBDXcnp6Kuw5yodKooeDw2kI3NHX7W98dsfJrXgthj6rGe2DTpe8WxdMpsJOe4Nj4OCltKDIUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso5114241fa.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786500735; x=1787105535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJWCy+AORJn19NlWTvsJ78hQZZp4qoOR63zPXJw1xNI=;
        b=Wqh4kvsDLb/OCYRbrOYf3PuI3Nc5QbU9MvQ0f2gZF5ZiBUc2Pj/rtPkcSCUpDSfuEX
         S3bkalfMVJgB8CYSc31H7gYAS9YXUe0QaCBxK9zbMXgcWDbSdTYrY01hUAHcQBasop0H
         1vg50neY7WomlfXU9PQndoHx5WmgW6RNQzksBpWG/npz5HtghMe+NebODuuycJQSi1eG
         VePPrYH/hCOpRZthr7NOo9Y5S0LTVaNzQf9/1EpMp/yE0Rw7rqENJUsz9+eHoN85apNH
         V6ePVq498rsPNtPLVKdLqff3YqKpEjsp1/XbzilgV20s4y3T3KGvOuKF8q9awz/fv8Cm
         X5oQ==
X-Forwarded-Encrypted: i=1; AHgh+RrM4a7MKxqK41XVzFKCaSObU+EJa3Cy2E4+1q0F+bG3Er3aRQ7EJ+p7J0hvLcKtbM9cCuQSkTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcFuhITWpfc41LAIeCkjze80dXIcBhabvo+g+SqXwSgd/KFgo
	cSkEG+wzE+cxfp5wIbGR7t9zGUHfNMjkq5BrN/U9VVpbrX9KB3KfN5n1S2kt+ByN/l4=
X-Gm-Gg: AR+sD11cnxblAGdkj8QT+jlZHwyUlhmwE4/dcsUb8XnbYB6gcjfUmcnoFU7YrxniWfO
	mDrDRjRPrejOZ6Zfk60RQv+SBw3EtEC/QeEVaVrSIlBQrKViFTqcBI2rOXAYSBsnM0kg1DVlUcW
	ESJkc/NF6t6k3fGlT2uSOIyFY+QaSpW9uYxrAy7MbxrRPDChhIiesmn/vNy7r1dwWlxQcHllIcG
	tO5gSYAt9fFx82pwfYEiiJpHWLfwa3L8SG6XglmhLHuxvScUiXpyEZfGtP3bxEmYFgETnslsakv
	6zQDWnAr+NFKa1ykUZS8YWaL2eaeeBIY8/NAvC8osiGnxpl52G5sAzIplQfC3NpdPBbgw6oY1my
	To8Fiq0RRvF1Sn+8kMkCwjpYsIElegeqf5xmdTzMnCVDwQPAZ8EirgIk9M3brTU2maHwUzi0pLs
	soFgZy1L0P3BuQb1DX5M5ic57/KLHY4vqTmSyRpveBnlPPlufz3RX9xdaLcjHlhBtA0ljcu3kxu
	lwKHOrbFpQrW5cUIHQmbj3/RcWcLaK4hZhKZVELp6rTOBREMSya
X-Received: by 2002:a2e:bd13:0:b0:39c:7859:a2cd with SMTP id 38308e7fff4ca-3a10d4badc1mr896871fa.13.1786500734424;
        Tue, 11 Aug 2026 19:12:14 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a107d20977sm1635101fa.15.2026.08.11.19.12.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 19:12:13 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b0148201fbso350443e87.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrzun9V9kwF6ZidMTNbp1cepX/aWgXRShFwfpxqH8nLrF5ohZD5Mg0KLuMfhh+7w33nbyN9p8w=@vger.kernel.org
X-Received: by 2002:a05:6512:145b:20b0:5b0:6aea:cd87 with SMTP id
 2adb3069b0e04-5b44e0db398mr145308e87.18.1786500733671; Tue, 11 Aug 2026
 19:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
 <CAG48ez2YssN-F9DHHskmiWORTnaBPUUyixqufD-L5VkW96Uv4Q@mail.gmail.com> <20260811-dachziegel-nordost-akkreditieren-3aecf70032da@brauner>
In-Reply-To: <20260811-dachziegel-nordost-akkreditieren-3aecf70032da@brauner>
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 12 Aug 2026 10:11:59 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMrEHQyS1Prd-mmtLDE-kOh_PSHNpfCx5y=hPEi0i5jow@mail.gmail.com>
X-Gm-Features: AUfX_mxYXQlHpiPRv6wV-NSe4YlUmh4R2wzKXwgDWmuA8eFjxA0p3_H4kUfVzgE
Message-ID: <CAC1kPDMrEHQyS1Prd-mmtLDE-kOh_PSHNpfCx5y=hPEi0i5jow@mail.gmail.com>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, me@black-desk.cn, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Aug 03, 2026 at 03:44:21PM +0200, Jann Horn wrote:
> > On Fri, Jul 31, 2026 at 4:50=E2=80=AFPM Chen Linxuan via B4 Relay
> > <devnull+me.black-desk.cn@kernel.org> wrote:
> > > The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesyste=
m
> > > credentials ptrace access check before handing out a namespace file
> > > descriptor.  The accompanying comment states that the code "mirrors n=
sfs
> > > behavior", but, unlike the corresponding procfs paths, it does so wit=
hout
> > > holding the target task's exec_update_lock.
> > >
> > > proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock =
for
> > > reading around the ptrace check and the namespace lookup, so that the
> > > credentials used for the access decision match those of the task when=
 its
> > > namespace is read.  Without it, a caller can pass the check against t=
he
> > > target's old credentials and then read the namespace after the target=
 has
> > > execve()'d a setuid binary and committed new credentials -- accessing
> > > namespace information it should have been denied.
> > >
> > > Hold exec_update_lock for reading around the ptrace check and the
> > > namespace lookup so that pidfd truly mirrors nsfs behavior, as the co=
mment
> > > already claims.  open_namespace() itself runs outside the lock: once =
a
> > > namespace reference is obtained it carries its own refcount and is op=
ened
> > > with the caller's own credentials, so a concurrent execve() on the ta=
rget
> > > can no longer affect the outcome.
> >
> > I think this makes sense.
> >
> > Given that the rest of this function is written with scope-based
> > cleanup (https://docs.kernel.org/core-api/cleanup.html), I wonder if
> > this patch would look cleaner if it also used scope-based cleanup...
> > that documentation also says:
> >
> > "Lastly, given that the benefit of cleanup helpers is removal of
> > =E2=80=9Cgoto=E2=80=9D, and that the =E2=80=9Cgoto=E2=80=9D statement c=
an jump between scopes, the
> > expectation is that usage of =E2=80=9Cgoto=E2=80=9D and cleanup helpers=
 is never mixed
> > in the same function."
> >
> > But we probably shouldn't be holding the exec_update_lock across the
> > open_namespace() call... so I guess this will require either
> > refactoring this function into two, or indenting most of the function
> > body, or some explicit "drop this guard" operation.
> >
> > @Christian, do you have an opinion on this?
>
> No strong opinion tbh. If I don't like the next version I can also just
> massage it when applying.

I did consider using scope-based cleanup, but there's a gap in the availabl=
e
guard infrastructure: rwsem read locks have conditional guard variants for
_try and _intr, but not for _kill (down_read_killable). I'd prefer to keep =
the
current manual lock/unlock + goto style for now rather than switch to
interruptible acquisition or add a new guard definition just for this.
