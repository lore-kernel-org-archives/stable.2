Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAA2F60CC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261343; cv=pass; b=bSHrkEPsytAuRw4cr1+xk8XEZePh1OukoZ52QBtKbL2TGidA3Yztt8hoWr+8gMmRVXzphhrbXWQTOfgr47fH5TB3ZObUUi14Kp2pQpspKLVYUFT0BN5oM4YOQLVNXrumyWE8pEsOkZTtTXIIJzjmimCg9pDYYKYnxQcyttOWDbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261343; c=relaxed/simple;
	bh=kLdS7ke0LWQgn6aP2nxVSl2qoV2tenQHCE5j3MIUnw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uyg/EbPHGl1cOtkP2BVH1/kP6cYpArrJ5MQkXLOZVAgBdAuY2r5sC5Scjfjo3xoi4hpA1qzZRt3P0geMfgML7941hUgvLLMlQfxkqxMlXXjdW9m9VIfPi2EzeCbvcUft5OfDWgbevDz5Owt/f/o2DnYahG6cKOHMIBj4/AaOw9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn26SciM; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn26SciM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c8bdac50so48769947b3.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 04:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788261340; cv=none;
        d=google.com; s=arc-20260327;
        b=gYU2qDNsSXBAQMjsubue0bBrzSKPPgM5IHdBETIYoPA5uyQ4iM1ebc15LRCXClvLew
         92E3XytvYX2HSsmmD0SY0wukous4w9936tfYt/ejlAD6n8bNgivzRxRqNld/zLa9HsRg
         UfT6y4GrsjtXCWWjaGo75EWbSLjamGdOy67tQCtc6OAf7QVB417Z5VpwZgztjurvf4lL
         wemQEXH1wLNMZV3jqPt9ZEmZ6zpkoOctUQs+fQmOXe+F3rbcmduAArFRKtgml47ldtz+
         xsQCV+0TIjaOWsKk2WbYxyHRthshxDYt8tAFbvFA3qA4k3VQst9XVl82gpqeSE8zuvxu
         dYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FumveZjSTeO26BGifT8VYdiVW23oY5i8VJp+9cHujdw=;
        fh=0UoUaVyX+py8WD+CaWaCW5dCduaGqL3USyuOQlEIpro=;
        b=EXN+5u/CdHO6Xp/YBvZe2eJ7W8ZVO/kEP/rhnLHlCpNmJd9K1TjaGEwWsgbR8M7wL2
         3Kt/ES7px2DTfPCaQMnN3xjO9nJRtiHeOShg3wnDJd7E/BbyZeHT+cSwYrDKhCkyhq9w
         4f6rE5VRldoNIVl8Bp3WISp4DxfBfBAZXuJHV++upiHspfKNrsdrCj6x0NIRTITvSvMn
         02u4AQVqxsnp1AxlvN4ZY/UtEdpXNrTT2QyVlLg+KXUHZqjLiU24uMCyvRWXNqM94aJH
         y2p2Y6bTsscX+gLybF6zJTqW9xUmd9EmdzIso9f16yNVcYHE+2FT2UZSAhpgHR/Qnbcu
         M/sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788261340; x=1788866140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FumveZjSTeO26BGifT8VYdiVW23oY5i8VJp+9cHujdw=;
        b=Kn26SciMt9Dh5wTm4bHh42PjfbpQl65J85xQr3b+no+Xit0ncEqgUOLmoF79VnEe6M
         IVZe0w4uj7DYeKQmNO4ruomgVw8L/nml5X+IY/7hJA/txQQBQkDrmEZtYlaTO4BXQat0
         r8WQl1if4vBZj90XMKhA2IXo/axOTirjOsBMVLoWR0ZL7CCJPR4QFZHJxL8Jo7YbD9LE
         NKubNtFVcPkQCiVtpSoIAywfSqjRMrJSNgWBuU3Wawbl1W4y4AUnHxoA1998gIrWXrrG
         rTXWkfkV/siWcrnV0iLEr0Ery5doldV3CziIw+MmfD6LT+MA1UzbCE8fWUsd9ArA2NIs
         G2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788261340; x=1788866140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FumveZjSTeO26BGifT8VYdiVW23oY5i8VJp+9cHujdw=;
        b=ZOgg3EsD9fuAtI4xJrwb3ufp7L7k4KuadumcudRapDr8S2ysfSwx/hDu9GsGjO8xg0
         huA38hWA8HXC20R6hAbLg+pNp5a2z20usZ4v+n99M6RrHwYRk/pr6Jq3/mXHwLXVjFUm
         hP1qMvQLJhKJ1A7MPaKupfETd3WwCWKykTd2qA7GfVeFrKuFu8c9BD26wEOcQb3pVEWY
         s/86U8+4OMzNWPkkra7H6P3ERyjpqxkMb4V+5MrboGdNMoQToCMIznViC0ZcnfGtrjNi
         g6xRWbXURadO/ZRFnZEX5ZlaLrFZz1q+czbqoss2thxzkEplVCHvMS5sz9fLM3jZEJQ5
         Hc2w==
X-Forwarded-Encrypted: i=1; AKwUvBxGYfa/Ml/zhQpdcBaFWDAAAp+oEowBNj9BpN3Zg73jEhFDytKfGO7Ph6Hqg92ACbKi/hHTbbc=@vger.kernel.org
X-Gm-Message-State: AFuF++lejjLKfEs+7dZQLQ503+YyOqa2yJv9gGR5XSW7Ciy3T/EhGsRZ
	ZURkuBi2wjk3hIysKY+MJEMteGlN5NWnm3xOruE/aDSdls/ciszCo9xb/DRnQ3AHQUNhBnATzy8
	QZRccuuHUBQLPcu4yFoKFMV62FRuUKwY=
X-Gm-Gg: AYBFou1j3oxxTBXj6QlAO/JrFgD9kjNYi3BbfVsIrk1WKaoEUeMyix5CYYOiI3PtcXE
	TLG4LxrXQfgBttMuztzYGfrHK0mC6QiWkg6ve392zDzKBsmR2XHsIFY7rw78NviP+/0LNpQfPQ3
	DSUjGSa0iPT1AYASmRdeLBEZ3R1c+YyBaEmN/WJfb3FHAliKUSGHD5RylzZ4Wa9xFEUSa3koxKU
	velE0v6Dqk7ylHwwXp+9T2Z2YhgzXQ7Ns2RJt3n/wZYkP1Spv8QoUZX5u5uySy2LIrVbgH155My
	dMvv2Wx1N1VrGR0ktWYiJNTHuP99tzEEi/ftFuvuNQfq6qeTRiAJMnQAhOAlY6lGUloGxtqcSsu
	v6g==
X-Received: by 2002:a05:690e:11ce:b0:66c:e38c:599b with SMTP id
 956f58d0204a3-66f87581febmr2244793d50.27.1788261339452; Tue, 01 Sep 2026
 04:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828022549.1721170-1-hnkz.64@gmail.com> <CABBYNZ+aHsY0Z5jpUmKNW=fS6Jubq5wx8S_jDUwNizRORBm=Kg@mail.gmail.com>
 <CADNmNLFOO5OK3AT6MaJpGENt=K6V-=YRRyGoT8pjKjzNX3Bz4A@mail.gmail.com>
In-Reply-To: <CADNmNLFOO5OK3AT6MaJpGENt=K6V-=YRRyGoT8pjKjzNX3Bz4A@mail.gmail.com>
From: Kazuki Hanai <hnkz.64@gmail.com>
Date: Tue, 1 Sep 2026 20:15:27 +0900
X-Gm-Features: AcwNN1VD4YMj-Cc3dVguJkU0toRhCtBkqM6ksTgW2dWomsroevwsVGxG6fksEUY
Message-ID: <CADNmNLGn1fbTduFrst8bF6_qXRt0wxpLJmmT4Kb2Hw0G1qh4RA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Fix IRK lookup lifetime races
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending as plain text because my previous reply contained an HTML part
and was rejected by the mailing lists. Sorry for the duplicate sent to the
direct recipients.

Hi Luiz,

Thank you for the review.

I agree that the previous patch mixed the IRK lifetime bug with several
separate synchronization issues and became too broad.

I have prepared a much smaller v3 that is limited to the escaped-pointer
lifetime problem:

- remove the dedicated IRK lock and payload snapshots
- remove the late-add and initialization changes
- remove the production selftests
- retain only list-owned and caller-owned references
- acquire the reference before leaving the RCU read-side critical section
- release it after each caller finishes using the IRK

My understanding is that synchronize_rcu() alone would not protect this
case because the returned pointer is used after rcu_read_unlock(). A
caller paused after the lookup is no longer an RCU reader, so the grace
period could finish and the object could be freed before that caller
resumes.

Regarding the test: yes, I used an AI assistant to help develop
deterministic test-only kernel instrumentation. It is not included in
the production patch. On the vulnerable parent, it reproduces KASAN
use-after-free reports for the 16-byte irk->val write and the 6-byte
irk->rpa write. With the reduced v3, the same schedule completes cleanly
and the test also confirms the final release of the IRK.

The regular BlueZ tests also passed:

- mgmt-tester IRK: 6/6
- mgmt-tester Privacy: 30/30
- smp-tester: 8/8

Would it be okay for me to send this reduced v3 patch?

I am still relatively new to upstream kernel development, so if the
reference-counting approach is not appropriate, please correct me. I
would also be happy to provide only the UAF report and reproducer if you
would prefer to handle the fix differently.

Thanks,
Kazuki

On Tue, Sep 1, 2026 at 6:57=E2=80=AFPM Kazuki Hanai <hnkz.64@gmail.com> wro=
te:
>
> Hi Luiz,
>
> Thank you for the review.
>
> I agree that the previous patch mixed the IRK lifetime bug with several
> separate synchronization issues and became too broad.
>
> I have prepared a much smaller v3 that is limited to the escaped-pointer
> lifetime problem:
>
> - remove the dedicated IRK lock and payload snapshots
> - remove the late-add and initialization changes
> - remove the production selftests
> - retain only list-owned and caller-owned references
> - acquire the reference before leaving the RCU read-side critical section
> - release it after each caller finishes using the IRK
>
> My understanding is that synchronize_rcu() alone would not protect this
> case because the returned pointer is used after rcu_read_unlock(). A
> caller paused after the lookup is no longer an RCU reader, so the grace
> period could finish and the object could be freed before that caller
> resumes.
>
> Regarding the test: yes, I used an AI assistant to help develop
> deterministic test-only kernel instrumentation. It is not included in
> the production patch. On the vulnerable parent, it reproduces KASAN
> use-after-free reports for the 16-byte irk->val write and the 6-byte
> irk->rpa write. With the reduced v3, the same schedule completes cleanly
> and the test also confirms the final release of the IRK.
>
> The regular BlueZ tests also passed:
>
> - mgmt-tester IRK: 6/6
> - mgmt-tester Privacy: 30/30
> - smp-tester: 8/8
>
> Would it be okay for me to send this reduced v3 patch?
>
> I am still relatively new to upstream kernel development, so if the
> reference-counting approach is not appropriate, please correct me. I
> would also be happy to provide only the UAF report and reproducer if you
> would prefer to handle the fix differently.
>
> Thanks,
> Kazuki
>
>
> On Tue, Sep 1, 2026 at 12:35=E2=80=AFAM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
>>
>> Hi Kazuki,
>>
>> On Thu, Aug 27, 2026 at 10:27=E2=80=AFPM Kazuki Hanai <hnkz.64@gmail.com=
> wrote:
>> >
>> > The IRK lookup helpers traverse the identity resolving key list under
>> > RCU, but return a raw pointer after leaving the read-side critical
>> > section. A concurrent management unpair or key reload can unlink and
>> > free that entry while SMP key distribution still updates its value and
>> > RPA through hci_add_irk().
>> >
>> > RCU also does not serialize list mutations. SMP cleanup and key
>> > distribution can update the IRK list without the hdev mutex while
>> > management paths update it with that mutex held, allowing concurrent
>> > list_add_rcu() and list_del_rcu() operations on the same list.
>>
>> So rather than using the hdev lock, is it better to introduce a lock
>> specific to the IRK, why?
>>
>> > Give each IRK a list-owned reference and return caller-owned reference=
s
>> > from lookup and add helpers. Keep the SMP context reference until pair=
ing
>> > teardown, and drop the list reference only once when an entry is
>> > unlinked. Add a dedicated spinlock for IRK list and payload updates, a=
nd
>> > copy payload snapshots under that lock so readers do not race updates.
>>
>> I understand why we could need a reference, but the locking here just
>> seems excessive, especially since many other lists are doing:
>>
>> list_del_rcu(&k->list);
>> kfree_rcu(k, rcu);
>>
>> Which I thought would garantee there is not code attempting to access
>> the entry under rcu_read_lock but perhaps we need to force it with
>> synchronize_rcu before its freed.
>>
>> > Initialize new entries completely before publishing them. Unlink an IR=
K
>> > added during unpair before dropping the SMP context reference.
>>
>> Sounds like a different issue.
>>
>> > An exact KASAN interleaving that removes and drains the RCU entry afte=
r
>> > lookup but before hci_add_irk() resumes now completes without a
>> > use-after-free. A forced late-add/unpair interleaving leaves no linked=
 IRK
>> > behind. A KASAN and lockdep enabled VHCI pairing/unpair test also
>> > completes successfully.
>>
>> What test are you referring to? Was this a test generated by the AI to
>> validate the change?
>>
>> > Fixes: a7ec73386ce2 ("Bluetooth: Fix removing any IRKs when unpairing =
devices")
>> > Cc: stable@vger.kernel.org
>> > Assisted-by: LLM
>> > Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
>> > ---
>> >  include/net/bluetooth/hci_core.h |  19 ++-
>> >  net/bluetooth/hci_conn.c         |  34 ++++--
>> >  net/bluetooth/hci_core.c         | 202 +++++++++++++++++++++++++-----=
-
>> >  net/bluetooth/hci_debugfs.c      |   6 +-
>> >  net/bluetooth/hci_event.c        |  16 ++-
>> >  net/bluetooth/hci_sync.c         |  16 ++-
>> >  net/bluetooth/iso.c              |  18 ++-
>> >  net/bluetooth/mgmt.c             |  12 +-
>> >  net/bluetooth/smp.c              |  20 ++-
>> >  9 files changed, 274 insertions(+), 69 deletions(-)
>> >
>> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
>> > index 4105c446ca98..75f3f26d9e31 100644
>> > --- a/include/net/bluetooth/hci_core.h
>> > +++ b/include/net/bluetooth/hci_core.h
>> > @@ -24,6 +24,7 @@
>> >  #define __HCI_CORE_H
>> >
>> >  #include <linux/idr.h>
>> > +#include <linux/kref.h>
>> >  #include <linux/leds.h>
>> >  #include <linux/rculist.h>
>> >  #include <linux/spinlock.h>
>> > @@ -211,6 +212,15 @@ struct smp_ltk {
>> >  struct smp_irk {
>> >         struct list_head list;
>> >         struct rcu_head rcu;
>> > +       struct kref ref;
>> > +       unsigned long flags;
>> > +       bdaddr_t rpa;
>> > +       bdaddr_t bdaddr;
>> > +       u8 addr_type;
>> > +       u8 val[16];
>> > +};
>> > +
>> > +struct smp_irk_data {
>> >         bdaddr_t rpa;
>> >         bdaddr_t bdaddr;
>> >         u8 addr_type;
>> > @@ -561,6 +571,7 @@ struct hci_dev {
>> >         struct list_head        uuids;
>> >         struct list_head        link_keys;
>> >         struct list_head        long_term_keys;
>> > +       spinlock_t              irk_lock; /* protects IRK list and dat=
a */
>> >         struct list_head        identity_resolving_keys;
>> >         struct list_head        remote_oob_data;
>> >         struct list_head        le_accept_list;
>> > @@ -1885,11 +1896,16 @@ int hci_remove_ltk(struct hci_dev *hdev, bdadd=
r_t *bdaddr, u8 bdaddr_type);
>> >  void hci_smp_ltks_clear(struct hci_dev *hdev);
>> >  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>> >
>> > +/* Returned IRKs hold a reference that must be released with hci_irk_=
put(). */
>> >  struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *r=
pa);
>> >  struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *=
bdaddr,
>> >                                      u8 addr_type);
>> >  struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>> >                             u8 addr_type, u8 val[16], bdaddr_t *rpa);
>> > +void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
>> > +                 struct smp_irk_data *data);
>> > +void hci_irk_put(struct smp_irk *irk);
>> > +void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk);
>> >  void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_t=
ype);
>> >  bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
>> >  void hci_blocked_keys_clear(struct hci_dev *hdev);
>> > @@ -2505,7 +2521,8 @@ void mgmt_resuming(struct hci_dev *hdev, u8 reas=
on, bdaddr_t *bdaddr,
>> >                    u8 addr_type);
>> >  bool mgmt_powering_down(struct hci_dev *hdev);
>> >  void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool per=
sistent);
>> > -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool per=
sistent);
>> > +void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *ir=
k,
>> > +                 bool persistent);
>> >  void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
>> >                    bool persistent);
>> >  void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
>> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> > index 8de98af2fb58..5e19fc6ef930 100644
>> > --- a/net/bluetooth/hci_conn.c
>> > +++ b/net/bluetooth/hci_conn.c
>> > @@ -70,6 +70,8 @@ void hci_connect_le_scan_cleanup(struct hci_conn *co=
nn, u8 status)
>> >         struct hci_conn_params *params;
>> >         struct hci_dev *hdev =3D conn->hdev;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> > +       bdaddr_t identity_addr;
>> >         bdaddr_t *bdaddr;
>> >         u8 bdaddr_type;
>> >
>> > @@ -79,8 +81,11 @@ void hci_connect_le_scan_cleanup(struct hci_conn *c=
onn, u8 status)
>> >         /* Check if we need to convert to identity address */
>> >         irk =3D hci_get_irk(hdev, bdaddr, bdaddr_type);
>> >         if (irk) {
>> > -               bdaddr =3D &irk->bdaddr;
>> > -               bdaddr_type =3D irk->addr_type;
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> > +               bacpy(&identity_addr, &irk_data.bdaddr);
>> > +               bdaddr_type =3D irk_data.addr_type;
>> > +               hci_irk_put(irk);
>> > +               bdaddr =3D &identity_addr;
>> >         }
>> >
>> >         params =3D hci_pend_le_action_lookup(&hdev->pend_le_conns, bda=
ddr,
>> > @@ -1004,6 +1009,7 @@ static struct hci_conn *__hci_conn_add(struct hc=
i_dev *hdev, int type,
>> >  {
>> >         struct hci_conn *conn;
>> >         struct smp_irk *irk =3D NULL;
>> > +       struct smp_irk_data irk_data;
>> >
>> >         switch (type) {
>> >         case ACL_LINK:
>> > @@ -1037,16 +1043,21 @@ static struct hci_conn *__hci_conn_add(struct =
hci_dev *hdev, int type,
>> >         bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
>> >
>> >         conn =3D kzalloc_obj(*conn);
>> > -       if (!conn)
>> > +       if (!conn) {
>> > +               if (irk)
>> > +                       hci_irk_put(irk);
>> >                 return ERR_PTR(-ENOMEM);
>> > +       }
>> >
>> >         /* If and IRK exists use its identity address */
>> >         if (!irk) {
>> >                 bacpy(&conn->dst, dst);
>> >                 conn->dst_type =3D dst_type;
>> >         } else {
>> > -               bacpy(&conn->dst, &irk->bdaddr);
>> > -               conn->dst_type =3D irk->addr_type;
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> > +               bacpy(&conn->dst, &irk_data.bdaddr);
>> > +               conn->dst_type =3D irk_data.addr_type;
>> > +               hci_irk_put(irk);
>> >         }
>> >
>> >         bacpy(&conn->src, &hdev->bdaddr);
>> > @@ -1458,6 +1469,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *=
hdev, bdaddr_t *dst,
>> >  {
>> >         struct hci_conn *conn;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> > +       bdaddr_t rpa;
>> >         int err;
>> >
>> >         /* Let's make sure that le is enabled.*/
>> > @@ -1498,9 +1511,14 @@ struct hci_conn *hci_connect_le(struct hci_dev =
*hdev, bdaddr_t *dst,
>> >                  * from the connect request.
>> >                  */
>> >                 irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
>> > -               if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
>> > -                       dst =3D &irk->rpa;
>> > -                       dst_type =3D ADDR_LE_DEV_RANDOM;
>> > +               if (irk) {
>> > +                       hci_irk_read(hdev, irk, &irk_data);
>> > +                       if (bacmp(&irk_data.rpa, BDADDR_ANY)) {
>> > +                               bacpy(&rpa, &irk_data.rpa);
>> > +                               dst =3D &rpa;
>> > +                               dst_type =3D ADDR_LE_DEV_RANDOM;
>> > +                       }
>> > +                       hci_irk_put(irk);
>> >                 }
>> >         }
>> >
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 35a1be57e386..4503e2afbb77 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -1031,13 +1031,36 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
>> >         }
>> >  }
>> >
>> > +enum {
>> > +       SMP_IRK_LINKED,
>> > +};
>> > +
>> > +static bool __hci_irk_unlink(struct smp_irk *irk)
>> > +{
>> > +       if (!test_and_clear_bit(SMP_IRK_LINKED, &irk->flags))
>> > +               return false;
>> > +
>> > +       list_del_rcu(&irk->list);
>> > +       return true;
>> > +}
>> > +
>> >  void hci_smp_irks_clear(struct hci_dev *hdev)
>> >  {
>> > -       struct smp_irk *k, *tmp;
>> > +       struct smp_irk *k;
>> >
>> > -       list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_key=
s, list) {
>> > -               list_del_rcu(&k->list);
>> > -               kfree_rcu(k, rcu);
>> > +       for (;;) {
>> > +               spin_lock_bh(&hdev->irk_lock);
>> > +               if (list_empty(&hdev->identity_resolving_keys)) {
>> > +                       spin_unlock_bh(&hdev->irk_lock);
>> > +                       break;
>> > +               }
>> > +
>> > +               k =3D list_first_entry(&hdev->identity_resolving_keys,
>> > +                                    struct smp_irk, list);
>> > +               __hci_irk_unlink(k);
>> > +               spin_unlock_bh(&hdev->irk_lock);
>> > +
>> > +               hci_irk_put(k);
>> >         }
>> >  }
>> >
>> > @@ -1171,37 +1194,73 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *h=
dev, bdaddr_t *bdaddr,
>> >         return NULL;
>> >  }
>> >
>> > +void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
>> > +                 struct smp_irk_data *data)
>> > +{
>> > +       spin_lock_bh(&hdev->irk_lock);
>> > +       bacpy(&data->rpa, &irk->rpa);
>> > +       bacpy(&data->bdaddr, &irk->bdaddr);
>> > +       data->addr_type =3D irk->addr_type;
>> > +       memcpy(data->val, irk->val, sizeof(data->val));
>> > +       spin_unlock_bh(&hdev->irk_lock);
>> > +}
>> > +
>> > +static bool hci_irk_get(struct smp_irk *irk)
>> > +{
>> > +       if (!test_bit(SMP_IRK_LINKED, &irk->flags))
>> > +               return false;
>> > +
>> > +       if (!kref_get_unless_zero(&irk->ref))
>> > +               return false;
>> > +
>> > +       if (test_bit(SMP_IRK_LINKED, &irk->flags))
>> > +               return true;
>> > +
>> > +       hci_irk_put(irk);
>> > +       return false;
>> > +}
>> > +
>> >  struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *r=
pa)
>> >  {
>> >         struct smp_irk *irk_to_return =3D NULL;
>> > +       struct smp_irk_data data;
>> >         struct smp_irk *irk;
>> >
>> >         rcu_read_lock();
>> >         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, l=
ist) {
>> > -               if (!bacmp(&irk->rpa, rpa)) {
>> > +               hci_irk_read(hdev, irk, &data);
>> > +               if (!bacmp(&data.rpa, rpa) && hci_irk_get(irk)) {
>> >                         irk_to_return =3D irk;
>> >                         goto done;
>> >                 }
>> >         }
>> >
>> >         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, l=
ist) {
>> > -               if (smp_irk_matches(hdev, irk->val, rpa)) {
>> > -                       bacpy(&irk->rpa, rpa);
>> > +               hci_irk_read(hdev, irk, &data);
>> > +               if (smp_irk_matches(hdev, data.val, rpa) && hci_irk_ge=
t(irk)) {
>> > +                       spin_lock_bh(&hdev->irk_lock);
>> > +                       if (test_bit(SMP_IRK_LINKED, &irk->flags))
>> > +                               bacpy(&irk->rpa, rpa);
>> > +                       spin_unlock_bh(&hdev->irk_lock);
>> >                         irk_to_return =3D irk;
>> >                         goto done;
>> >                 }
>> >         }
>> >
>> >  done:
>> > +       rcu_read_unlock();
>> > +
>> > +       if (irk_to_return)
>> > +               hci_irk_read(hdev, irk_to_return, &data);
>> > +
>> >         if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_=
TYPE_IRK,
>> > -                                               irk_to_return->val)) {
>> > +                                               data.val)) {
>> >                 bt_dev_warn_ratelimited(hdev, "Identity key blocked fo=
r %pMR",
>> > -                                       &irk_to_return->bdaddr);
>> > +                                       &data.bdaddr);
>> > +               hci_irk_put(irk_to_return);
>> >                 irk_to_return =3D NULL;
>> >         }
>> >
>> > -       rcu_read_unlock();
>> > -
>> >         return irk_to_return;
>> >  }
>> >
>> > @@ -1209,6 +1268,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_=
dev *hdev, bdaddr_t *bdaddr,
>> >                                      u8 addr_type)
>> >  {
>> >         struct smp_irk *irk_to_return =3D NULL;
>> > +       struct smp_irk_data data;
>> >         struct smp_irk *irk;
>> >
>> >         /* Identity Address must be public or static random */
>> > @@ -1217,25 +1277,53 @@ struct smp_irk *hci_find_irk_by_addr(struct hc=
i_dev *hdev, bdaddr_t *bdaddr,
>> >
>> >         rcu_read_lock();
>> >         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, l=
ist) {
>> > -               if (addr_type =3D=3D irk->addr_type &&
>> > -                   bacmp(bdaddr, &irk->bdaddr) =3D=3D 0) {
>> > +               hci_irk_read(hdev, irk, &data);
>> > +               if (addr_type =3D=3D data.addr_type &&
>> > +                   bacmp(bdaddr, &data.bdaddr) =3D=3D 0 && hci_irk_ge=
t(irk)) {
>> >                         irk_to_return =3D irk;
>> >                         break;
>> >                 }
>> >         }
>> > +       rcu_read_unlock();
>> > +
>> > +       if (irk_to_return)
>> > +               hci_irk_read(hdev, irk_to_return, &data);
>> >
>> >         if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_=
TYPE_IRK,
>> > -                                               irk_to_return->val)) {
>> > +                                               data.val)) {
>> >                 bt_dev_warn_ratelimited(hdev, "Identity key blocked fo=
r %pMR",
>> > -                                       &irk_to_return->bdaddr);
>> > +                                       &data.bdaddr);
>> > +               hci_irk_put(irk_to_return);
>> >                 irk_to_return =3D NULL;
>> >         }
>> >
>> > -       rcu_read_unlock();
>> > -
>> >         return irk_to_return;
>> >  }
>> >
>> > +static void hci_irk_release(struct kref *ref)
>> > +{
>> > +       struct smp_irk *irk =3D container_of(ref, struct smp_irk, ref)=
;
>> > +
>> > +       kfree_rcu(irk, rcu);
>> > +}
>> > +
>> > +void hci_irk_put(struct smp_irk *irk)
>> > +{
>> > +       kref_put(&irk->ref, hci_irk_release);
>> > +}
>> > +
>> > +void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk)
>> > +{
>> > +       bool unlinked;
>> > +
>> > +       spin_lock_bh(&hdev->irk_lock);
>> > +       unlinked =3D __hci_irk_unlink(irk);
>> > +       spin_unlock_bh(&hdev->irk_lock);
>> > +
>> > +       if (unlinked)
>> > +               hci_irk_put(irk);
>> > +}
>> > +
>> >  struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_co=
nn *conn,
>> >                                   bdaddr_t *bdaddr, u8 *val, u8 type,
>> >                                   u8 pin_len, bool *persistent)
>> > @@ -1315,24 +1403,47 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hd=
ev, bdaddr_t *bdaddr,
>> >  struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>> >                             u8 addr_type, u8 val[16], bdaddr_t *rpa)
>> >  {
>> > -       struct smp_irk *irk;
>> > +       struct smp_irk *irk, *new_irk;
>> >
>> >         irk =3D hci_find_irk_by_addr(hdev, bdaddr, addr_type);
>> > -       if (!irk) {
>> > -               irk =3D kzalloc_obj(*irk);
>> > -               if (!irk)
>> > -                       return NULL;
>> > +       if (irk) {
>> > +               spin_lock_bh(&hdev->irk_lock);
>> > +               memcpy(irk->val, val, sizeof(irk->val));
>> > +               bacpy(&irk->rpa, rpa);
>> > +               spin_unlock_bh(&hdev->irk_lock);
>> > +               return irk;
>> > +       }
>> > +
>> > +       new_irk =3D kzalloc_obj(*new_irk);
>> > +       if (!new_irk)
>> > +               return NULL;
>> >
>> > -               bacpy(&irk->bdaddr, bdaddr);
>> > -               irk->addr_type =3D addr_type;
>> > +       bacpy(&new_irk->bdaddr, bdaddr);
>> > +       new_irk->addr_type =3D addr_type;
>> > +       memcpy(new_irk->val, val, sizeof(new_irk->val));
>> > +       bacpy(&new_irk->rpa, rpa);
>> >
>> > -               list_add_rcu(&irk->list, &hdev->identity_resolving_key=
s);
>> > +       spin_lock_bh(&hdev->irk_lock);
>> > +       list_for_each_entry(irk, &hdev->identity_resolving_keys, list)=
 {
>> > +               if (addr_type !=3D irk->addr_type ||
>> > +                   bacmp(bdaddr, &irk->bdaddr))
>> > +                       continue;
>> > +
>> > +               kref_get(&irk->ref);
>> > +               memcpy(irk->val, val, sizeof(irk->val));
>> > +               bacpy(&irk->rpa, rpa);
>> > +               spin_unlock_bh(&hdev->irk_lock);
>> > +               kfree(new_irk);
>> > +               return irk;
>> >         }
>> >
>> > -       memcpy(irk->val, val, 16);
>> > -       bacpy(&irk->rpa, rpa);
>> > +       kref_init(&new_irk->ref);
>> > +       kref_get(&new_irk->ref);
>> > +       set_bit(SMP_IRK_LINKED, &new_irk->flags);
>> > +       list_add_rcu(&new_irk->list, &hdev->identity_resolving_keys);
>> > +       spin_unlock_bh(&hdev->irk_lock);
>> >
>> > -       return irk;
>> > +       return new_irk;
>> >  }
>> >
>> >  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>> > @@ -1372,16 +1483,27 @@ int hci_remove_ltk(struct hci_dev *hdev, bdadd=
r_t *bdaddr, u8 bdaddr_type)
>> >
>> >  void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_t=
ype)
>> >  {
>> > -       struct smp_irk *k, *tmp;
>> > +       struct smp_irk *k, *removed;
>> >
>> > -       list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_key=
s, list) {
>> > -               if (bacmp(bdaddr, &k->bdaddr) || k->addr_type !=3D add=
r_type)
>> > -                       continue;
>> > +       for (;;) {
>> > +               removed =3D NULL;
>> > +               spin_lock_bh(&hdev->irk_lock);
>> > +               list_for_each_entry(k, &hdev->identity_resolving_keys,=
 list) {
>> > +                       if (bacmp(bdaddr, &k->bdaddr) ||
>> > +                           k->addr_type !=3D addr_type)
>> > +                               continue;
>> >
>> > -               BT_DBG("%s removing %pMR", hdev->name, bdaddr);
>> > +                       __hci_irk_unlink(k);
>> > +                       removed =3D k;
>> > +                       break;
>> > +               }
>> > +               spin_unlock_bh(&hdev->irk_lock);
>> >
>> > -               list_del_rcu(&k->list);
>> > -               kfree_rcu(k, rcu);
>> > +               if (!removed)
>> > +                       break;
>> > +
>> > +               BT_DBG("%s removing %pMR", hdev->name, bdaddr);
>> > +               hci_irk_put(removed);
>> >         }
>> >  }
>> >
>> > @@ -1389,6 +1511,8 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, =
bdaddr_t *bdaddr, u8 type)
>> >  {
>> >         struct smp_ltk *k;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> > +       bdaddr_t identity_addr;
>> >         u8 addr_type;
>> >
>> >         if (type =3D=3D BDADDR_BREDR) {
>> > @@ -1405,8 +1529,11 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev,=
 bdaddr_t *bdaddr, u8 type)
>> >
>> >         irk =3D hci_get_irk(hdev, bdaddr, addr_type);
>> >         if (irk) {
>> > -               bdaddr =3D &irk->bdaddr;
>> > -               addr_type =3D irk->addr_type;
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> > +               bacpy(&identity_addr, &irk_data.bdaddr);
>> > +               addr_type =3D irk_data.addr_type;
>> > +               hci_irk_put(irk);
>> > +               bdaddr =3D &identity_addr;
>> >         }
>> >
>> >         rcu_read_lock();
>> > @@ -2495,6 +2622,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_pr=
iv)
>> >         INIT_LIST_HEAD(&hdev->uuids);
>> >         INIT_LIST_HEAD(&hdev->link_keys);
>> >         INIT_LIST_HEAD(&hdev->long_term_keys);
>> > +       spin_lock_init(&hdev->irk_lock);
>> >         INIT_LIST_HEAD(&hdev->identity_resolving_keys);
>> >         INIT_LIST_HEAD(&hdev->remote_oob_data);
>> >         INIT_LIST_HEAD(&hdev->le_accept_list);
>> > diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
>> > index aadffaaff20e..3b3f7a481990 100644
>> > --- a/net/bluetooth/hci_debugfs.c
>> > +++ b/net/bluetooth/hci_debugfs.c
>> > @@ -817,13 +817,15 @@ DEFINE_SHOW_ATTRIBUTE(resolv_list);
>> >  static int identity_resolving_keys_show(struct seq_file *f, void *ptr=
)
>> >  {
>> >         struct hci_dev *hdev =3D f->private;
>> > +       struct smp_irk_data irk_data;
>> >         struct smp_irk *irk;
>> >
>> >         rcu_read_lock();
>> >         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, l=
ist) {
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> >                 seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
>> > -                          &irk->bdaddr, irk->addr_type,
>> > -                          16, irk->val, &irk->rpa);
>> > +                          &irk_data.bdaddr, irk_data.addr_type,
>> > +                          16, irk_data.val, &irk_data.rpa);
>> >         }
>> >         rcu_read_unlock();
>> >
>> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> > index 2f5e21ff9752..f2971319410d 100644
>> > --- a/net/bluetooth/hci_event.c
>> > +++ b/net/bluetooth/hci_event.c
>> > @@ -5757,6 +5757,7 @@ static void le_conn_complete_evt(struct hci_dev =
*hdev, u8 status,
>> >         struct hci_conn_params *params;
>> >         struct hci_conn *conn;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> >         u8 addr_type;
>> >         int err;
>> >
>> > @@ -5842,8 +5843,10 @@ static void le_conn_complete_evt(struct hci_dev=
 *hdev, u8 status,
>> >          */
>> >         irk =3D hci_get_irk(hdev, &conn->dst, conn->dst_type);
>> >         if (irk) {
>> > -               bacpy(&conn->dst, &irk->bdaddr);
>> > -               conn->dst_type =3D irk->addr_type;
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> > +               bacpy(&conn->dst, &irk_data.bdaddr);
>> > +               conn->dst_type =3D irk_data.addr_type;
>> > +               hci_irk_put(irk);
>> >         }
>> >
>> >         conn->dst_type =3D ev_bdaddr_type(hdev, conn->dst_type, NULL);
>> > @@ -6234,7 +6237,9 @@ static void process_adv_report(struct hci_dev *h=
dev, u8 type, bdaddr_t *bdaddr,
>> >  {
>> >         struct discovery_state *d =3D &hdev->discovery;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> >         struct hci_conn *conn;
>> > +       bdaddr_t identity_addr;
>> >         bool match, bdaddr_resolved;
>> >         u32 flags;
>> >         u8 *ptr;
>> > @@ -6309,8 +6314,11 @@ static void process_adv_report(struct hci_dev *=
hdev, u8 type, bdaddr_t *bdaddr,
>> >         /* Check if we need to convert to identity address */
>> >         irk =3D hci_get_irk(hdev, bdaddr, bdaddr_type);
>> >         if (irk) {
>> > -               bdaddr =3D &irk->bdaddr;
>> > -               bdaddr_type =3D irk->addr_type;
>> > +               hci_irk_read(hdev, irk, &irk_data);
>> > +               bacpy(&identity_addr, &irk_data.bdaddr);
>> > +               bdaddr_type =3D irk_data.addr_type;
>> > +               hci_irk_put(irk);
>> > +               bdaddr =3D &identity_addr;
>> >         }
>> >
>> >         bdaddr_type =3D ev_bdaddr_type(hdev, bdaddr_type, &bdaddr_reso=
lved);
>> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> > index ffd7b37e7401..fcb96c4b0793 100644
>> > --- a/net/bluetooth/hci_sync.c
>> > +++ b/net/bluetooth/hci_sync.c
>> > @@ -2469,6 +2469,7 @@ static int hci_le_add_resolve_list_sync(struct h=
ci_dev *hdev,
>> >  {
>> >         struct hci_cp_le_add_to_resolv_list cp;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> >         struct bdaddr_list_with_irk *entry;
>> >         struct hci_conn_params *p;
>> >
>> > @@ -2496,12 +2497,16 @@ static int hci_le_add_resolve_list_sync(struct=
 hci_dev *hdev,
>> >         entry =3D hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_lis=
t,
>> >                                                 &params->addr,
>> >                                                 params->addr_type);
>> > -       if (entry)
>> > +       if (entry) {
>> > +               hci_irk_put(irk);
>> >                 return 0;
>> > +       }
>> >
>> >         cp.bdaddr_type =3D params->addr_type;
>> >         bacpy(&cp.bdaddr, &params->addr);
>> > -       memcpy(cp.peer_irk, irk->val, 16);
>> > +       hci_irk_read(hdev, irk, &irk_data);
>> > +       memcpy(cp.peer_irk, irk_data.val, sizeof(cp.peer_irk));
>> > +       hci_irk_put(irk);
>> >
>> >         /* Default privacy mode is always Network */
>> >         params->privacy_mode =3D HCI_NETWORK_PRIVACY;
>> > @@ -2532,6 +2537,7 @@ static int hci_le_set_privacy_mode_sync(struct h=
ci_dev *hdev,
>> >  {
>> >         struct hci_cp_le_set_privacy_mode cp;
>> >         struct smp_irk *irk;
>> > +       struct smp_irk_data irk_data;
>> >
>> >         if (!ll_privacy_capable(hdev) ||
>> >             !(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION))
>> > @@ -2552,10 +2558,12 @@ static int hci_le_set_privacy_mode_sync(struct=
 hci_dev *hdev,
>> >         if (!irk)
>> >                 return 0;
>> >
>> > +       hci_irk_read(hdev, irk, &irk_data);
>> >         memset(&cp, 0, sizeof(cp));
>> > -       cp.bdaddr_type =3D irk->addr_type;
>> > -       bacpy(&cp.bdaddr, &irk->bdaddr);
>> > +       cp.bdaddr_type =3D irk_data.addr_type;
>> > +       bacpy(&cp.bdaddr, &irk_data.bdaddr);
>> >         cp.mode =3D HCI_DEVICE_PRIVACY;
>> > +       hci_irk_put(irk);
>> >
>> >         /* Note: params->privacy_mode is not updated since it is a cop=
y */
>> >
>> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> > index 75bfd5938b2e..928b761453d6 100644
>> > --- a/net/bluetooth/iso.c
>> > +++ b/net/bluetooth/iso.c
>> > @@ -723,22 +723,34 @@ static struct sock *iso_get_sock(struct hci_dev =
*hdev, bdaddr_t *src,
>> >                 /* Match Broadcast destination */
>> >                 if (bacmp(dst, BDADDR_ANY) && bacmp(&iso_pi(sk)->dst, =
dst)) {
>> >                         struct smp_irk *irk1, *irk2;
>> > +                       struct smp_irk_data irk_data;
>> > +                       bool resolved =3D false;
>> >
>> >                         /* Check if destination is an RPA that we can =
resolve */
>> >                         irk1 =3D hci_find_irk_by_rpa(hdev, dst);
>> >                         if (!irk1)
>> >                                 continue;
>> >
>> > +                       hci_irk_read(hdev, irk1, &irk_data);
>> > +
>> >                         /* Match with identity address */
>> > -                       if (bacmp(&iso_pi(sk)->dst, &irk1->bdaddr)) {
>> > +                       if (!bacmp(&iso_pi(sk)->dst, &irk_data.bdaddr)=
) {
>> > +                               resolved =3D true;
>> > +                       } else {
>> >                                 /* Check if socket destination address=
 is also
>> >                                  * an RPA and if the IRK matches.
>> >                                  */
>> >                                 irk2 =3D hci_find_irk_by_rpa(hdev,
>> >                                                            &iso_pi(sk)=
->dst);
>> > -                               if (!irk2 || irk1 !=3D irk2)
>> > -                                       continue;
>> > +                               if (irk2) {
>> > +                                       resolved =3D irk1 =3D=3D irk2;
>> > +                                       hci_irk_put(irk2);
>> > +                               }
>> >                         }
>> > +
>> > +                       hci_irk_put(irk1);
>> > +                       if (!resolved)
>> > +                               continue;
>> >                 }
>> >
>> >                 /* Use Match function if provided */
>> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> > index ac4864e56ec7..841702cdf14e 100644
>> > --- a/net/bluetooth/mgmt.c
>> > +++ b/net/bluetooth/mgmt.c
>> > @@ -7315,6 +7315,7 @@ static int load_irks(struct sock *sk, struct hci=
_dev *hdev, void *cp_data,
>> >
>> >         for (i =3D 0; i < irk_count; i++) {
>> >                 struct mgmt_irk_info *irk =3D &cp->irks[i];
>> > +               struct smp_irk *smp_irk;
>> >
>> >                 if (hci_is_blocked_key(hdev,
>> >                                        HCI_BLOCKED_KEY_TYPE_IRK,
>> > @@ -7324,9 +7325,11 @@ static int load_irks(struct sock *sk, struct hc=
i_dev *hdev, void *cp_data,
>> >                         continue;
>> >                 }
>> >
>> > -               hci_add_irk(hdev, &irk->addr.bdaddr,
>> > -                           le_addr_type(irk->addr.type), irk->val,
>> > -                           BDADDR_ANY);
>> > +               smp_irk =3D hci_add_irk(hdev, &irk->addr.bdaddr,
>> > +                                     le_addr_type(irk->addr.type), ir=
k->val,
>> > +                                     BDADDR_ANY);
>> > +               if (smp_irk)
>> > +                       hci_irk_put(smp_irk);
>> >         }
>> >
>> >         hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
>> > @@ -9945,7 +9948,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct s=
mp_ltk *key, bool persistent)
>> >         mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), N=
ULL);
>> >  }
>> >
>> > -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool per=
sistent)
>> > +void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *ir=
k,
>> > +                 bool persistent)
>> >  {
>> >         struct mgmt_ev_new_irk ev;
>> >
>> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> > index 6091c47cb002..37000495b987 100644
>> > --- a/net/bluetooth/smp.c
>> > +++ b/net/bluetooth/smp.c
>> > @@ -761,11 +761,13 @@ static void smp_chan_destroy(struct l2cap_conn *=
conn)
>> >                 }
>> >
>> >                 if (smp->remote_irk) {
>> > -                       list_del_rcu(&smp->remote_irk->list);
>> > -                       kfree_rcu(smp->remote_irk, rcu);
>> > +                       hci_irk_unlink(hcon->hdev, smp->remote_irk);
>> >                 }
>> >         }
>> >
>> > +       if (smp->remote_irk)
>> > +               hci_irk_put(smp->remote_irk);
>> > +
>> >         chan->data =3D NULL;
>> >         kfree_sensitive(smp);
>> >         hci_conn_drop(hcon);
>> > @@ -1017,6 +1019,7 @@ static void smp_notify_keys(struct l2cap_conn *c=
onn)
>> >         struct hci_dev *hdev =3D hcon->hdev;
>> >         struct smp_cmd_pairing *req =3D (void *) &smp->preq[1];
>> >         struct smp_cmd_pairing *rsp =3D (void *) &smp->prsp[1];
>> > +       struct smp_irk_data irk_data;
>> >         bool persistent;
>> >
>> >         if (hcon->type =3D=3D ACL_LINK) {
>> > @@ -1035,15 +1038,16 @@ static void smp_notify_keys(struct l2cap_conn =
*conn)
>> >         }
>> >
>> >         if (smp->remote_irk) {
>> > -               mgmt_new_irk(hdev, smp->remote_irk, persistent);
>> > +               hci_irk_read(hdev, smp->remote_irk, &irk_data);
>> > +               mgmt_new_irk(hdev, &irk_data, persistent);
>> >
>> >                 /* Now that user space can be considered to know the
>> >                  * identity address track the connection based on it
>> >                  * from now on (assuming this is an LE link).
>> >                  */
>> >                 if (hcon->type =3D=3D LE_LINK) {
>> > -                       bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
>> > -                       hcon->dst_type =3D smp->remote_irk->addr_type;
>> > +                       bacpy(&hcon->dst, &irk_data.bdaddr);
>> > +                       hcon->dst_type =3D irk_data.addr_type;
>> >                         /* Use a short delay to make sure the new addr=
ess is
>> >                          * propagated _before_ the channels.
>> >                          */
>> > @@ -2443,7 +2447,11 @@ int smp_cancel_and_remove_pairing(struct hci_de=
v *hdev, bdaddr_t *bdaddr,
>> >                  * remove and free already invalidated rcu list entrie=
s. */
>> >                 smp->ltk =3D NULL;
>> >                 smp->responder_ltk =3D NULL;
>> > -               smp->remote_irk =3D NULL;
>> > +               if (smp->remote_irk) {
>> > +                       hci_irk_unlink(hdev, smp->remote_irk);
>> > +                       hci_irk_put(smp->remote_irk);
>> > +                       smp->remote_irk =3D NULL;
>> > +               }
>> >
>> >                 if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
>> >                         smp_failure(conn, 0);
>> > --
>> > 2.53.0
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz
