Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7C39794B
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021764; cv=pass; b=KjWLVO7cWhRnFpSViziDFbPweAcTKwMeA1LeLZk/HOhgvZmv+/81G93QIp8pldKLdQoW9NB5j7lycFiWkEcAr30mJ6eD53hxhIkJqF4NYAvXu/yiP6KO514ekmGsOcHPGy0UIVbGWvTqx7nNbOyx9JTQH/KG4fg0zrpnMxKQFjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021764; c=relaxed/simple;
	bh=gVZFIq7E6DUEA7UcHTTV0g77Ncrm6ajPHymyOnK3Cyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u94WwTtvb+o3n8NpNyan1yiJUyIlOuYsHLbVSkvrQqy+KUr7pjuf88X816iu6hiASdFA41NZ4ZDQjtlH052deLjJZ2qDg/qWODDhqpYrnrBIZBDwproCby9i1Aw2QHmqiwdgR9nxS88YYga9aJ8Od6UdDg04NbyjSWmZZIH3cKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTetC3FY; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTetC3FY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c52d920b8so247143066b.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788021761; cv=none;
        d=google.com; s=arc-20260327;
        b=G+aC/xy+YDCPHhTJ5EpgE3Cff1sxWPQ1r1fhPpWFaDmUs83Ji7UR5PMacR17hfewSH
         aEVkCOTR+CQahN+QjIUfWCeWTIMi7kUrYvPyJgXe2ISggRR3aF3nePDdjkI7O+xFEQMd
         ChwB/7Zl+Gp/9pGxIE9mJNCWiQQcuifxGpVw8jshodWHNKZh5ognVjmf4lucqleNQcJt
         zvf62mDNl84zqChlHZHjGMxLMaWMaAUV/5KW7ikMXp3Q4r5B55wzKARyazN/71uYQVYo
         lFy/yw8qbazM2v0I/XhYO3Mt04FiyKIT6zuZrxMIHflK1wNBKq4tygVuB7s/Yhp1ZbD/
         kS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        fh=7P205/wIE6AuJ95I4G7UgtXfL8wqMR7JhT/AV4V6cMs=;
        b=U5RTAA+CmAzzQayUBopULZ5CbNEsqWDyjp588Tqq0aGPawy8kBl6mBEgKYzYOZFK4i
         QzcqQVR1z4Wg4Nac32kQBXc4WyKgOzgpVf6meZmBl08lObgt23tu2gLHwmJpH/C0TPU4
         oyzrPCYyioXnHxnCQWBO62/QpQ8/aNsRLRI+nnEvJR0+n5dute9gOrO7OUkVc9h8n4fb
         H5GYY6GZpCzXELSJVBYwBu69KAH2Dx+7RD7e3u2lOOY4LMig6yxIMA2lDeUoFo1cZzZv
         CMk1cEomDttJB36TzSLgwUjoVSPd4ajJ6yQnqnRmIfbl5DaX0sAIBmRwAf4n7iRTy1vi
         uY7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021761; x=1788626561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=OTetC3FY9YR2dT91pmq0tWTCBVQw98A+ro76zO0jrdRuA8IZtsnSh7UkqJxyoJsput
         QYkwqUcp//atCTeq9nNabFfVtR3cltA4BnJlSN/uar5m/kgT+3MEs42eO0e02wospduc
         rd7a0zJaN5uoUP6GJRavB4PZ8F3hyZZHH4PEbtX9YmOgSbCfGFN/PElptV+PHQz0J9vf
         Bkx0xSdvVwNswH+ipIw1CNfsIk4PAx0dQAqh41NWWhrjuJmVCLhS+IToYESJMrG28Xbz
         dtUzdafCWjb87kTs+7MK86BNNaSyY3rkhvgNFqCPfd9b+Pbk5DgfsG4pW4torbn/l2sa
         A84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021761; x=1788626561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=iawQDKcGuhDMSE4y2/RP1lZQW6BDKw2Nm++z2mLGXSzIjDlhMtvhm8SF24uE4naknk
         cRR1F3DqVJ6FQYIssARzFTGWBuDvgo6QBAIqYpDpPkcOk3TZqNnFZqpHxhOI9+T9jDhn
         aFdPsO9a6Gd2BNZnaRn8f8Ykd+J6xAOlxX4LbaG8HPVMaq8nxPuXIg5inVU1l2iD/NRD
         QNTYosdRsVvF6v1CDGXdCiVzSg3uwsPLHJ4+h0f1R0J12hXDU9Ez0kg/y8/566JZF81F
         p7esZX4C1d95xf5pU4ue+Dg8uyAy4DhUokimoBnDGvYPA7eVwt/igct15JrCK2Tt2QGD
         G15A==
X-Forwarded-Encrypted: i=1; AHgh+RqYaFP2n+MtEACxgWUU/C3VmDc7rLbJ9pWnZ/fXlhyPfihLed8V2Z8I1s1cLc9IY75rSXfBt4w=@vger.kernel.org
X-Gm-Message-State: AFuF++mubojIUE5O2YIMmkA7Ld31ok6zB5C8c+1w/K/1msu+XCIyvC78
	kYIDP1ynYHeh1WRZ7A179JPQne9Anp2EK5sK4ZcYj9QwgY818Jafcso8xW8XTEBoLsf/aW3FySV
	UAtSeIPvHCTdoHUMVBF/85EycsnQxtSU=
X-Gm-Gg: AR+sD13WROpd9/e7/uaZ/V8fsmUjPsPzXKmLEWlPg4f9Umltr4IanuzoFTw/e6nzLsf
	ahhreC1leYX9C9W0wo1dn2vNI/4TXpoXXyFzzZ+8FcocPdE1OZ0JBeXxKY7sqNGyiugbvaEW+pm
	Uitd0O5s9cxFaHpoCvuu1CLcXpIX/iC3sfGDyqaNRSmcHNVPoCxYbXKlvY8LlFlmKu4H10G4939
	rL5SdL2bVsiUFl5C6TeJfN9b1LMFUoH4G9dVVReOLXvDuZrX+ViYQZsQ81pdgBHWT8HCWQKZ40+
	JqZtIMtx/nXwiMW3bcg9i35GX6L4l/FZBA1bKPspeU9usA==
X-Received: by 2002:a17:907:3ccc:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c255741f461mr1048868466b.24.1788021760941; Sat, 29 Aug 2026
 09:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
 <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com> <CAOQ4uxjn3sWjkrV8KbA-V+eno3E4OskTnCznNBex6FOstEbJ-A@mail.gmail.com>
 <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Aug 2026 18:42:28 +0200
X-Gm-Features: AcwNN1VZx95EdI2tjlNCAWiVqqkY5zejH9GYUNhl8FvdsMNeGPTwmtuy5Ph3m7k
Message-ID: <CAOQ4uxioiwVPntt1=QeXXftehoPPb5LFZHuctfJzkNJzrNq9Ng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Paul Moore <paul@paul-moore.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 12:05=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Aug 28, 2026 at 5:05=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > On Thu, Aug 27, 2026 at 9:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> ...
>
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 1ead2eee1944..171b90412ff1 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(stru=
ct file *file)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static inline u32 selinux_file_user_sid(const struct file *file)
> > > > +{
> > > > +     if (unlikely(file->f_mode & FMODE_BACKING))
> > > > +             return selinux_backing_file(file)->uf_sid;
> > > > +     return selinux_file(file)->sid;
> > > > +}
> > >
> > > I'm a little concerned that this only works for one additional level =
of
> > > filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
> > > FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
> > > unreasonable concern that at some point in the future that number wil=
l
> > > increase without proper notification or testing and we will once agai=
n
> > > have a problem.
> > >
> > > At the absolute minimum we should have a BUILD_BUG_ON() for the stack=
ing
> > > depth.  It would be good if we could watch both the overlayfs and vfs
> > > constants, but the overlayfs constant isn't available outside
> > > fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit=
).
> > >
> > >   BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);
> > >
> > > Ideally, the code would be written to keep diving down the stack unti=
l
> > > it hit the true backing file.  No one likes to see recursion, but at =
the
> > > point where this function is called there should already be a reasona=
ble
> > > bound on the stacking depth and the work involved.
> >
> > Unless I am missing something, stack depth should not matter.
> > file_user_path() should hold the user visible path, for all the backing=
 files
> > in all the depths of the backing files stack.
> >
> > This is the issue that was fixed with commit
> > f2381b546e7e6 fs: fix user path of nested backing files
> >
> > This patch makes uf_sid behave the same way and also documents this:
> >
> > struct backing_file_security_struct {
> > -       u32 uf_sid; /* associated user file fsec->sid */
> > +       u32 uf_sid; /* top-level user file fsec->sid */
> >  };
>
> Perhaps I'm not understanding your comment correctly (it's the end of
> a long week), but selinux_backing_file_alloc() and the newly created
> selinux_file_user_sid() functions don't operate on the
> file_user_path() path struct.  In fact the path which is resolved in
> backing_file_open() isn't even passed into the
> security_backing_file_alloc() LSM hook.

Right.
But the file that is passed into the hook has the top-level uf_sid
in selinux_file_user_sid().

>
> Are you trying to explain that the way the backing files are allocated
> in a stacked filesystem, regardless of the number of layers, is that
> they will be allocated from the top down in such a way that the uf_sid
> will trickle down to the bottommost backing file?

Yes, both selinux_file_user_sid() and file_user_path() should follow
the same pattern independently - they always stash the top-most user visibl=
e
path/creds.

Thanks,
Amir.
