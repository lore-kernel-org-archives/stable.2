Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329153D0D8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000339; cv=pass; b=m6TsZe6Jjc9x9JJzWaSabvb7VCvJysiuJ4WOY3JYC3+UGeIwLa8OyzlgpkJ81sxH6v/EujBU6x+dRWTOF92sBbozrOWBVGSRYBQgVP1eJkBPy8M24vxQhsCVnh9mTM3svgQWO4SmsmceJUoAPtrlYoGlebjjoXheb89oeGpKPmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000339; c=relaxed/simple;
	bh=hbHSPhq87+/pwYwNvx5gX2zfxPRsJyJzwGcwpxxTEbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJWYcTRhQhOaRJhxQ2CQiht3P+QGyxBt3d9Z0P1N7IADU8PJNpc43xPSI+nscGZkh99J3eBJZuvyejKNPs/VarhxIqnCRdTchFj69TR6wt+zezHn3JaV3SHZwKiPY3+bzN6N+A3sasSlJxbmKXmF4BwlZAxr3nMB3oCPBGBAfIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Qu1L4A; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Qu1L4A"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6acbe0e4090so758729a12.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792000336; cv=none;
        d=google.com; s=arc-20260327;
        b=EtF/3CyLIAx8OfFUpBhoOEbuMH4evtH2PVqqYpl0b5bhhsrCd22j0mTJ68uaj2Zu1a
         XzG4H3q8m5Yu+iHYUmXIOMgpI7OUv8kv4bn4Nf1yzc4xJ58Shp7VDvrUqBCNhtQWOe28
         ByB6Fm3EaVbN8QFXL0tnHymk9+GXulUEDhpq7fSQy+oEfEET7E6VYlYegNSKvjH4aVe7
         LWBtUXwnFZiGAGqEFU9pAc3JT0bWE6D3rBSIHspy3NOaeFfe7rygyDFGX8BKAZJ1lqlw
         zARLkzhozimURTRxBD7xa1TA3BVi9B/e9KML1hZVWCDK1rrcmlxG7rlOZH6SX4sy6Rs2
         hA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        fh=szhwl9Bag7PPXWgCs9dVfqeBbjKFL30aHSGtq9UaOO8=;
        b=Y+BMujTfKgk4oTrsbloW2foFb1/inFI5bBINGIGOiTXGlL0IoI5fYWZ7ICahlrIrNS
         hyykuOySMlZf/PSA6sF7hC8ej832yn8LEdqJ7bv+xY+ZIq36O+3enQjJkGwu1VR1Oomz
         XSRUu0X7bRfmdFNnCouEz5Cr0nbosC7LTZE207o3aHQ5d3jANRSpzE9Gjahth8mOcxXY
         s1ElZbEPiaDZTndj71u/cJZ4x5eauf599aXZ9wpL1hzJ2kPfK1g228LPRSOJcMKvlO4j
         hNXNcRGjbTk1rK/cM4VJOeBra3pSTqdlPXCF14+6E1Ys5HdMquo8TjcHtatlJ2pcJqGM
         ddvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000336; x=1792605136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=R6Qu1L4AHJBuDACn4coyHjQUcnDafj/0vdancQ/EnPgGCGymLwW5yN7BGIb8tu4op9
         GM6DhSbKUn1RKLznNwv8otDYFe/HrSkHBsxMnC0dx3xlyM6pemKy5Lvyzn/Siy1OZn7Y
         9NlHfkHnFWqAW9bSdePJC56aeKpMsIe5LZJZQAjENpYq1V8KepoSzZcpUoUYwoeZOSwy
         JMSs4/jvpiIne23lCw6AkLphAae6zCfINStfEv3WeubyjoFELyK2UM7/c7BJz2eohVUh
         vDzturfzThHADm8teuq4PkDxmWb/sBVfHK5Z/ABbT5Tzi6qo5JSiAr7aujYldY4/6Mx4
         SHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000336; x=1792605136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=qHLoMmREwV+KZmoisH8na//UAxv9Mil1V1vKg9eAQvGqUGhcKQJ8aP66mCL22koDiO
         62WdgR8jVERsfDBewgq7pSPEf78ICBDEBEBxZ2Pj+RuHGMMJlimSnik9WgucqFFnuoGD
         evIYn6uEppKw+mvWFizeO76b5HwYpvppotB0EInWrVMvtr9gwN/P3AmlG0NtLhC/fJr4
         b1mx0/Iitl8VikgpfpupNgRklgVdTrP72lx7iHQqhWOefVdj+UmRhyNKLUj16WUu5GB3
         xdAOQ3I2UMEeYfuOBXdMsEiGnXoTSqL+L7ucPfj2pJdmOB/H/safY9DbvxKa9Mt6tueq
         9NCg==
X-Forwarded-Encrypted: i=1; AKwUvByagSTj1x/Wvn65+gjtNVcvXkaFqzrP4b7YHwA++Qf7hCvQvKviZ6Fz6VVWFGJCZeUZ3F2ctPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8ww9Rtuli8WY5Gst5Gd9fPWx1zAPRaf2EXv83JDcHpRdvz5BG
	JnqOzqd14oygmM7UCXQHb2u7MvcQz9TayFKAZ1JviZE5ocaaR8EWjxXXccOxiXvpRIWqwoBQWx6
	1ZpsvigS2SaewSqNtpt1i/y1Ht4u73Io=
X-Gm-Gg: AYBFou0rfBt3tfvckSlNyU3uVkT19AvRPkb5sb1tVN9sIynuUfcaGv2nGKjsvsk05qb
	l3fXKr2AIQgLbo+8VYMeS6KmigIMXp5WFHsRQ/0vLDmUa7DoSt6lJ6jKoI6yW1iw7TITal4ducS
	S8Rb35daBlWguI+Feclg+F2Re/ZNI4QhPcCXuP32yeoJg8PovLlBPu4Adz+y2gybubDW0s0p2gU
	/rRWeY7P4kYIK7sQSWu9vju+BmHnHXs3+4QOAIFCZM/SLx/cqjZxJ/20V/WUAfbuuU7uzfJNr55
	uOmih3sCJ34XrHZPKtjFNM+5liMr7whcZNFG93Vl2DQsr6LYBCBVcToIX8ySzcZJCXjxSsz3QY6
	jJHpcAED+
X-Received: by 2002:aa7:d496:0:b0:6b1:a51d:2091 with SMTP id
 4fb4d7f45d1cf-6b1a51d2173mr7110113a12.3.1792000335396; Wed, 14 Oct 2026
 10:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com> <as9otxVeOLbhkIMy@kernel.org>
In-Reply-To: <as9otxVeOLbhkIMy@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 01:52:04 +0800
X-Gm-Features: AclHuK-mF7f2-ToQFw5yb6eWZea95LJSk6oMoOQo82NHSzDQBf9ruJ97DzyUm-E
Message-ID: <CAAo+4rXGputXtxgkLLAtFSS=utgr=S=ajbqDFZV=jySZ1yz+sw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace filters
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jarkko,

On Wed, Oct 14, 2026 at 7:34=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, Oct 13, 2026 at 05:03:57PM +0800, Chengfeng Ye wrote:
> > keyctl_chown_key() replaces key->user under key->sem and drops the
> > reference to the previous owner after releasing the semaphore. Readers
> > which do not hold that semaphore can still be using the previous owner
> > when key_user_put() frees it.
> >
> > For example, namespace filtering in /proc/keys can race with chown:
> >
> >   /proc/keys reader                 keyctl_chown_key()
> >   user =3D key->user
> >                                     key->user =3D newowner
> >                                     key_user_put(old)
> >                                       kfree(old)
> >   read user->uid
> >
> > An earlier instrumented run reported:
> >
> >   BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
> >   Read of size 4 at addr ffff8881128abbc0 by task poc/88
> >   Call Trace:
> >    proc_keys_start+0x353/0x440
> >    seq_read_iter+0x25d/0x1190
> >    proc_reg_read_iter+0x19e/0x260
> >   Allocated by task 86:
> >    key_user_lookup+0x1b4/0x540
> >    keyctl_chown_key+0x3cc/0xbf0
> >   Freed by task 87:
> >    kfree+0x149/0x330
> >    keyctl_chown_key+0x7b0/0xbf0
>
> Last night I missed the text below.
>
> It is somewhat messy to the point that frankly I could not read it, or
> at least I did not understand it. Have you read it yourself?
>
> There is a whole eassay and I can only see that key->user can change
> unless key_user_lock is taken, and READ_ONCE() is required to pair with
> the writers.

That READ_ONCE() should be unnecessary, since key_user_lock now
serializes both readers and writers. I will double-check whether to
drop it.

> I don't understand what is going on down there, and what's your goal
> with it?

Yes, the messy commit message should be cleaned up before sending...
Sorry for that. Basically, it describes why the three `key->user` use
sites should be protected by the lock (because there's no
synchronization) and why the remaining access at other sites doesn't
need it (because other caller sites are synchronized). I will rephrase
the commit message to make it human-readable.


>
>
> >
> > Take key_user_lock explicitly while /proc/keys and find_keyring_by_name=
()
> > copy the owner's UID. find_ge_key() is the initial/seek lookup reached
> > by the reported proc_keys_start() fault; key_serial_next() applies the
> > same UID filter to subsequent entries. find_keyring_by_name() reads the
> > same replaceable owner when looking up named keyrings.
> >
> > key_serial_lock and keyring_name_lock protect these traversals but do
> > not exclude chown. Taking key->sem would sleep under those spinlocks.
> > The embedded key->user->lock cannot protect the dereference needed to
> > acquire it.
> >
> > key_user_put() already holds key_user_lock for the final reference
> > decrement and tree removal. A reader selecting an owner before removal
> > blocks its final release until the UID copy finishes. After removal,
> > the lock and reference-count ordering make the preceding owner
> > replacement visible, including when another task drops the final
> > reference. Mark the pointer loads with READ_ONCE() and the chown store
> > with WRITE_ONCE(); the existing lifetime locking provides the protectio=
n.
> >
> > Retain the quota-owner UID rather than substituting key->uid, since the=
y
> > may differ for thread keyrings.
> >
> > Other owner accesses already have lifetime protection. key_alloc() uses
> > a referenced owner before publishing the key. Final key_put() cannot
> > overlap chown, which holds a key reference. key_gc_unused_keys() handle=
s
> > unreferenced keys: serial-tree removal excludes /proc/keys readers, and
> > keyring_destroy() removes named keyrings under keyring_name_lock before
> > the owner reference is dropped. /proc/key-users already holds
> > key_user_lock during traversal. Quota reservation and instantiation nee=
d
> > the separate accounting serialization.
> >
> > Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> > Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GPT-6-Astra
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Move the quota-reservation and instantiation scopes from v3 1/2 to
> >   the complete accounting fix in 2/2; retain the combined lock coverage=
.
> > - Isolate the namespace-reader lifetime fix and make it independent of =
the
> >   accounting patch by relying on existing lookup/final-release locking.
> > - Pair READ_ONCE() pointer snapshots with WRITE_ONCE() in chown; explai=
n
> >   lifetime ordering and preserve the quota-owner UID filtering semantic=
s.
> > - Include analysis of of the other owner access sites in the changelog
> >
> > v3: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail=
.com/
> > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail=
.com/
> >
> >  security/keys/keyctl.c  |  2 +-
> >  security/keys/keyring.c |  7 ++++++-
> >  security/keys/proc.c    | 15 +++++++++++++--
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index d14ace88e529c..c89a4d6efed40 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -1039,3 +1039,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user=
, gid_t group)
> >               zapowner =3D key->user;
> > -             key->user =3D newowner;
> > +             WRITE_ONCE(key->user, newowner);
> >               key->uid =3D uid;
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 15bf4af8f2821..4a13749bc54cd 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name=
, bool uid_keyring)
> >  {
> >       struct user_namespace *ns =3D current_user_ns();
> >       struct key *keyring;
> > +     kuid_t uid;
> >
> >       if (!name)
> >               return ERR_PTR(-EINVAL);
> > @@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *nam=
e, bool uid_keyring)
> >        * grants Search permission and that hasn't been revoked
> >        */
> >       list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> > -             if (!kuid_has_mapping(ns, keyring->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(keyring->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (!kuid_has_mapping(ns, uid))
> >                       continue;
> >
> >               if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> > diff --git a/security/keys/proc.c b/security/keys/proc.c
> > index 4f4e2c1824f18..aa42ea4becec7 100644
> > --- a/security/keys/proc.c
> > +++ b/security/keys/proc.c
> > @@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_fi=
le *p, struct rb_node *n)
> >       n =3D rb_next(n);
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > -             if (kuid_has_mapping(user_ns, key->user->uid))
> > +             kuid_t uid;
> > +
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(key->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       break;
> >               n =3D rb_next(n);
> >       }
> > @@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, ke=
y_serial_t id)
> >       struct user_namespace *user_ns =3D seq_user_ns(p);
> >       struct rb_node *n =3D key_serial_tree.rb_node;
> >       struct key *minkey =3D NULL;
> > +     kuid_t uid;
> >
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > @@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p,=
 key_serial_t id)
> >               return NULL;
> >
> >       for (;;) {
> > -             if (kuid_has_mapping(user_ns, minkey->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(minkey->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       return minkey;
> >               n =3D rb_next(&minkey->serial_node);
> >               if (!n)
> > --
> > 2.43.0
> >
>
> Br, Jarkko

Best regards,
Chengfeng
