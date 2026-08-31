Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE64AE8A7
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190556; cv=pass; b=rPtDn0MbwwkKk5nJ+7Eyd81zeaAOUlc9mZfM7qsbAqAsO2KCULKnX6Yt3iPDqICpT0U2JIOMnAhjHwnEUmnnTBsiF1+sCuk0338x9rsxsYzC0SSfXwt8iy6SGdc3jPnXiXpiGZlUmmgS7cUm0+SjPyU/Eyt39jvI27fj+EqOerg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190556; c=relaxed/simple;
	bh=wfSBIfgClI5p35lI+ic9e/u/Lz9C9GDWQ9TG04DDxx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvLWcay7XRTEovSQw83YBKVH5jOAi5qst/6tBw2neTjy9DQd8ANTU40AFZRsvlmdMx1uNBiJpXyFu6wxqzGhHyNQOI/Lz80E10e87NS0h3Zh6wuEvk3iV6f7SY3pBrYGV1OaiJi6eY7ZmZQj37BBR1VuPWAv9H0dy5FV3dxE+6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWg3BTkQ; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWg3BTkQ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8664769db58so10952007b3.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788190552; cv=none;
        d=google.com; s=arc-20260327;
        b=qtU70wOxjaYhSuKC4yNFKGjS3M/FuaLCn8ieNfXO+5H9xjBHAmdYxetREt8RxIIGj7
         r+/0I17B4XQIPuP/CciL+/zdv5DGdM2mEecPWbqKh814sVmcNdHQzuPrPsykzMmGjvkM
         34bFfuag0/jB/9jUlDpMGRk7RMSJ06u/ft16IhAjypkUFjo0qG2+41nDZPDJyS/MPDiB
         jtGSFctHIkLFcDGbyQyqs9uDHmXzw2j9WNwJcqzhsoAPvlw6Z/cmlx8XaV5MOE3+LLzA
         tLmyqGpW0jwO5O96HLD4eNHVLOyE9XflObVsKlpUUfB4RlNdNgmpuj/8ZOeKHe6y/78N
         d1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RT//O5/BgV+BOkB+AeUow8G1x/wRGUP+UkvNfFgVkQ=;
        fh=ZCJ9wnbw+WiTmMGVElhQpx3n9y0bz38yEL8cvc1hCtY=;
        b=WM/89l9uY+vtazohaav+BXs0Abosw6aOIhHGNGseWAyyoHzaC71RqLt/GSA7PruRxo
         Op3xONlYujFqDn5xaqb4za/0pxjBr2ws5CAEcdBd8W7o/BTo4JwALhLx35flR5LURQ2u
         wWCWIZTSmTu/4/zCJBPTJfPEpM+2RJD7QmaU4ofTcVplnyhZEEc/KH/R6FQFEXq7Gp20
         r1jxxcs7g7hphrTRMW8e7fx+xwktPJE7jg5NrgRPxW9D0GqcIy19tr4+X9KZ46Emlibe
         HLjRbYkA765Mrm/6N3XruhDUjTaVbfVBmM/6jo8TyIIOFPwj1npOwvEW23ZLcBH/udqE
         akqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788190552; x=1788795352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RT//O5/BgV+BOkB+AeUow8G1x/wRGUP+UkvNfFgVkQ=;
        b=LWg3BTkQozu1ZEqOsPwzJ2Jxcp5xdpAsnuzdHR8N0ve8FbsRCibUgdCQciEnPege1E
         Tv5lIB5pv8P+JLXTKk7OLcL3alrsZ/wP3adiAM6YIVceuoxbB5WKBld+Rv9C/BplXz3E
         GbHQmSm6Y9R0iaZ7XN+zIkWeB1URy5LnkpCIwHVCjZNNIGJi1705u3OTeUtmMBmtyAaO
         LQX5/brB3cYz0lRRZ8r8gLswl/S9aBDhDrOnO8vVlfyllrz40T9nR56fYC4FHpaBCe/C
         NpoUbddA/d+pOCPI9uuTSx2k1V0+iksorXSvAtvMmV4LvzmsHVLzDnqbGgqCHuuMwDMY
         C4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788190552; x=1788795352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RT//O5/BgV+BOkB+AeUow8G1x/wRGUP+UkvNfFgVkQ=;
        b=Di+TEp8vXI39H12uXrrM6bHY5LHC6UJDlc8pU26RtOzOUWpyRlAjHvrsEcPAcD2/et
         DvWkZa+i0nWZJGFOeNFsyzduYwHxToJAqhLD/bFl/A8Hbo6W0AT1wFYtGlgjw7fSGCe6
         6o2QuHwtb0ChiYCARIpej1limVh5NaFTMjLbYZcuJjY4lZtJuWUeFyEcjM9i6vJkR2+T
         728nL6p3MU1dOdw1Dq6eoC23AZNNucQvYuCX0ooEIScMnTY4RdfQTIxTz25kfcZdvfCN
         fEfIXd6i2uKWanlvDK5usJAM2CoRYwzFBYdRUvJSSrKABbTlYtnUcNm5gTRQV8LOrDxq
         ViWg==
X-Forwarded-Encrypted: i=1; AKwUvBxxTHl/YblwMY+Rd5Gv/Wn8JW7tOfCZW2UV9Wk5XV63TOtHWAcRTcV8uTs/Xo+nRGBb+y7ofTg=@vger.kernel.org
X-Gm-Message-State: AFuF++lR/paOHf0xFtUuLhNClSVwkgG14D7hn52gIqV2xEA+kKNgLxP4
	S/R0IaRepVxzMkJmibBAlH4+VmG8nLcS4JKQcC2Sqlo0m90baANT3EdONQzb+Vkh8Pfg5hc9anO
	366ph+YrgqFtAlTDz8GSautxWWj3JG0A=
X-Gm-Gg: AYBFou2L8yrtL1vBWvzvL8XHsqtOdQ/W4ypc9RFNqeYxrwIB/IA2CIlQGGD8NGD60M8
	u2FHyyhmHjH4vt9zbR7UCgPnKQQ9Hk4AyNqax+me9ihfBlTWsOVABBXMYiJdXj9kPjhXNi43kVo
	2X+T6YJvuFeWgaaaQt0F5rCCYkSfrnPc46Nz8Ll1j4Z+AQz5J8q/R0ylHNIeCK5zZhmruJcnsTB
	AUseBOjAoKS0jsTvtqA+QDyCj1OUrx9iIgMN/L3QESTDGkcxRSa4J0eL0lRCAZ40eVegyWcvHTf
	tAaJm2Rs2lZiThT2/EZPG33sKSLit/n5LdgV+BiU8nzssmu3Vmiueb9QCX/TSSB7hee6KoWP09o
	uavmbqwU6C49EzI0HaJJtZPq87mtY
X-Received: by 2002:a05:690c:4d0a:b0:858:d554:79e4 with SMTP id
 00721157ae682-85d6b275e9fmr97350387b3.20.1788190551542; Mon, 31 Aug 2026
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828022549.1721170-1-hnkz.64@gmail.com>
In-Reply-To: <20260828022549.1721170-1-hnkz.64@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 11:35:37 -0400
X-Gm-Features: AcwNN1XQx-SG7fqoeaFuKhHkroYfTeaIUDlBopevEMRN67cE1xUlnBG_ZZBBCtQ
Message-ID: <CABBYNZ+aHsY0Z5jpUmKNW=fS6Jubq5wx8S_jDUwNizRORBm=Kg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Fix IRK lookup lifetime races
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kazuki,

On Thu, Aug 27, 2026 at 10:27=E2=80=AFPM Kazuki Hanai <hnkz.64@gmail.com> w=
rote:
>
> The IRK lookup helpers traverse the identity resolving key list under
> RCU, but return a raw pointer after leaving the read-side critical
> section. A concurrent management unpair or key reload can unlink and
> free that entry while SMP key distribution still updates its value and
> RPA through hci_add_irk().
>
> RCU also does not serialize list mutations. SMP cleanup and key
> distribution can update the IRK list without the hdev mutex while
> management paths update it with that mutex held, allowing concurrent
> list_add_rcu() and list_del_rcu() operations on the same list.

So rather than using the hdev lock, is it better to introduce a lock
specific to the IRK, why?

> Give each IRK a list-owned reference and return caller-owned references
> from lookup and add helpers. Keep the SMP context reference until pairing
> teardown, and drop the list reference only once when an entry is
> unlinked. Add a dedicated spinlock for IRK list and payload updates, and
> copy payload snapshots under that lock so readers do not race updates.

I understand why we could need a reference, but the locking here just
seems excessive, especially since many other lists are doing:

list_del_rcu(&k->list);
kfree_rcu(k, rcu);

Which I thought would garantee there is not code attempting to access
the entry under rcu_read_lock but perhaps we need to force it with
synchronize_rcu before its freed.

> Initialize new entries completely before publishing them. Unlink an IRK
> added during unpair before dropping the SMP context reference.

Sounds like a different issue.

> An exact KASAN interleaving that removes and drains the RCU entry after
> lookup but before hci_add_irk() resumes now completes without a
> use-after-free. A forced late-add/unpair interleaving leaves no linked IR=
K
> behind. A KASAN and lockdep enabled VHCI pairing/unpair test also
> completes successfully.

What test are you referring to? Was this a test generated by the AI to
validate the change?

> Fixes: a7ec73386ce2 ("Bluetooth: Fix removing any IRKs when unpairing dev=
ices")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |  19 ++-
>  net/bluetooth/hci_conn.c         |  34 ++++--
>  net/bluetooth/hci_core.c         | 202 +++++++++++++++++++++++++------
>  net/bluetooth/hci_debugfs.c      |   6 +-
>  net/bluetooth/hci_event.c        |  16 ++-
>  net/bluetooth/hci_sync.c         |  16 ++-
>  net/bluetooth/iso.c              |  18 ++-
>  net/bluetooth/mgmt.c             |  12 +-
>  net/bluetooth/smp.c              |  20 ++-
>  9 files changed, 274 insertions(+), 69 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 4105c446ca98..75f3f26d9e31 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -24,6 +24,7 @@
>  #define __HCI_CORE_H
>
>  #include <linux/idr.h>
> +#include <linux/kref.h>
>  #include <linux/leds.h>
>  #include <linux/rculist.h>
>  #include <linux/spinlock.h>
> @@ -211,6 +212,15 @@ struct smp_ltk {
>  struct smp_irk {
>         struct list_head list;
>         struct rcu_head rcu;
> +       struct kref ref;
> +       unsigned long flags;
> +       bdaddr_t rpa;
> +       bdaddr_t bdaddr;
> +       u8 addr_type;
> +       u8 val[16];
> +};
> +
> +struct smp_irk_data {
>         bdaddr_t rpa;
>         bdaddr_t bdaddr;
>         u8 addr_type;
> @@ -561,6 +571,7 @@ struct hci_dev {
>         struct list_head        uuids;
>         struct list_head        link_keys;
>         struct list_head        long_term_keys;
> +       spinlock_t              irk_lock; /* protects IRK list and data *=
/
>         struct list_head        identity_resolving_keys;
>         struct list_head        remote_oob_data;
>         struct list_head        le_accept_list;
> @@ -1885,11 +1896,16 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t=
 *bdaddr, u8 bdaddr_type);
>  void hci_smp_ltks_clear(struct hci_dev *hdev);
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>
> +/* Returned IRKs hold a reference that must be released with hci_irk_put=
(). */
>  struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)=
;
>  struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bda=
ddr,
>                                      u8 addr_type);
>  struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                             u8 addr_type, u8 val[16], bdaddr_t *rpa);
> +void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
> +                 struct smp_irk_data *data);
> +void hci_irk_put(struct smp_irk *irk);
> +void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk);
>  void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type=
);
>  bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
>  void hci_blocked_keys_clear(struct hci_dev *hdev);
> @@ -2505,7 +2521,8 @@ void mgmt_resuming(struct hci_dev *hdev, u8 reason,=
 bdaddr_t *bdaddr,
>                    u8 addr_type);
>  bool mgmt_powering_down(struct hci_dev *hdev);
>  void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persis=
tent);
> -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent);
> +void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *irk,
> +                 bool persistent);
>  void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
>                    bool persistent);
>  void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 8de98af2fb58..5e19fc6ef930 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -70,6 +70,8 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn,=
 u8 status)
>         struct hci_conn_params *params;
>         struct hci_dev *hdev =3D conn->hdev;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
> +       bdaddr_t identity_addr;
>         bdaddr_t *bdaddr;
>         u8 bdaddr_type;
>
> @@ -79,8 +81,11 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn=
, u8 status)
>         /* Check if we need to convert to identity address */
>         irk =3D hci_get_irk(hdev, bdaddr, bdaddr_type);
>         if (irk) {
> -               bdaddr =3D &irk->bdaddr;
> -               bdaddr_type =3D irk->addr_type;
> +               hci_irk_read(hdev, irk, &irk_data);
> +               bacpy(&identity_addr, &irk_data.bdaddr);
> +               bdaddr_type =3D irk_data.addr_type;
> +               hci_irk_put(irk);
> +               bdaddr =3D &identity_addr;
>         }
>
>         params =3D hci_pend_le_action_lookup(&hdev->pend_le_conns, bdaddr=
,
> @@ -1004,6 +1009,7 @@ static struct hci_conn *__hci_conn_add(struct hci_d=
ev *hdev, int type,
>  {
>         struct hci_conn *conn;
>         struct smp_irk *irk =3D NULL;
> +       struct smp_irk_data irk_data;
>
>         switch (type) {
>         case ACL_LINK:
> @@ -1037,16 +1043,21 @@ static struct hci_conn *__hci_conn_add(struct hci=
_dev *hdev, int type,
>         bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
>
>         conn =3D kzalloc_obj(*conn);
> -       if (!conn)
> +       if (!conn) {
> +               if (irk)
> +                       hci_irk_put(irk);
>                 return ERR_PTR(-ENOMEM);
> +       }
>
>         /* If and IRK exists use its identity address */
>         if (!irk) {
>                 bacpy(&conn->dst, dst);
>                 conn->dst_type =3D dst_type;
>         } else {
> -               bacpy(&conn->dst, &irk->bdaddr);
> -               conn->dst_type =3D irk->addr_type;
> +               hci_irk_read(hdev, irk, &irk_data);
> +               bacpy(&conn->dst, &irk_data.bdaddr);
> +               conn->dst_type =3D irk_data.addr_type;
> +               hci_irk_put(irk);
>         }
>
>         bacpy(&conn->src, &hdev->bdaddr);
> @@ -1458,6 +1469,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
>  {
>         struct hci_conn *conn;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
> +       bdaddr_t rpa;
>         int err;
>
>         /* Let's make sure that le is enabled.*/
> @@ -1498,9 +1511,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hd=
ev, bdaddr_t *dst,
>                  * from the connect request.
>                  */
>                 irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> -               if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> -                       dst =3D &irk->rpa;
> -                       dst_type =3D ADDR_LE_DEV_RANDOM;
> +               if (irk) {
> +                       hci_irk_read(hdev, irk, &irk_data);
> +                       if (bacmp(&irk_data.rpa, BDADDR_ANY)) {
> +                               bacpy(&rpa, &irk_data.rpa);
> +                               dst =3D &rpa;
> +                               dst_type =3D ADDR_LE_DEV_RANDOM;
> +                       }
> +                       hci_irk_put(irk);
>                 }
>         }
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 35a1be57e386..4503e2afbb77 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1031,13 +1031,36 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
>         }
>  }
>
> +enum {
> +       SMP_IRK_LINKED,
> +};
> +
> +static bool __hci_irk_unlink(struct smp_irk *irk)
> +{
> +       if (!test_and_clear_bit(SMP_IRK_LINKED, &irk->flags))
> +               return false;
> +
> +       list_del_rcu(&irk->list);
> +       return true;
> +}
> +
>  void hci_smp_irks_clear(struct hci_dev *hdev)
>  {
> -       struct smp_irk *k, *tmp;
> +       struct smp_irk *k;
>
> -       list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, =
list) {
> -               list_del_rcu(&k->list);
> -               kfree_rcu(k, rcu);
> +       for (;;) {
> +               spin_lock_bh(&hdev->irk_lock);
> +               if (list_empty(&hdev->identity_resolving_keys)) {
> +                       spin_unlock_bh(&hdev->irk_lock);
> +                       break;
> +               }
> +
> +               k =3D list_first_entry(&hdev->identity_resolving_keys,
> +                                    struct smp_irk, list);
> +               __hci_irk_unlink(k);
> +               spin_unlock_bh(&hdev->irk_lock);
> +
> +               hci_irk_put(k);
>         }
>  }
>
> @@ -1171,37 +1194,73 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev=
, bdaddr_t *bdaddr,
>         return NULL;
>  }
>
> +void hci_irk_read(struct hci_dev *hdev, struct smp_irk *irk,
> +                 struct smp_irk_data *data)
> +{
> +       spin_lock_bh(&hdev->irk_lock);
> +       bacpy(&data->rpa, &irk->rpa);
> +       bacpy(&data->bdaddr, &irk->bdaddr);
> +       data->addr_type =3D irk->addr_type;
> +       memcpy(data->val, irk->val, sizeof(data->val));
> +       spin_unlock_bh(&hdev->irk_lock);
> +}
> +
> +static bool hci_irk_get(struct smp_irk *irk)
> +{
> +       if (!test_bit(SMP_IRK_LINKED, &irk->flags))
> +               return false;
> +
> +       if (!kref_get_unless_zero(&irk->ref))
> +               return false;
> +
> +       if (test_bit(SMP_IRK_LINKED, &irk->flags))
> +               return true;
> +
> +       hci_irk_put(irk);
> +       return false;
> +}
> +
>  struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
>  {
>         struct smp_irk *irk_to_return =3D NULL;
> +       struct smp_irk_data data;
>         struct smp_irk *irk;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> -               if (!bacmp(&irk->rpa, rpa)) {
> +               hci_irk_read(hdev, irk, &data);
> +               if (!bacmp(&data.rpa, rpa) && hci_irk_get(irk)) {
>                         irk_to_return =3D irk;
>                         goto done;
>                 }
>         }
>
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> -               if (smp_irk_matches(hdev, irk->val, rpa)) {
> -                       bacpy(&irk->rpa, rpa);
> +               hci_irk_read(hdev, irk, &data);
> +               if (smp_irk_matches(hdev, data.val, rpa) && hci_irk_get(i=
rk)) {
> +                       spin_lock_bh(&hdev->irk_lock);
> +                       if (test_bit(SMP_IRK_LINKED, &irk->flags))
> +                               bacpy(&irk->rpa, rpa);
> +                       spin_unlock_bh(&hdev->irk_lock);
>                         irk_to_return =3D irk;
>                         goto done;
>                 }
>         }
>
>  done:
> +       rcu_read_unlock();
> +
> +       if (irk_to_return)
> +               hci_irk_read(hdev, irk_to_return, &data);
> +
>         if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYP=
E_IRK,
> -                                               irk_to_return->val)) {
> +                                               data.val)) {
>                 bt_dev_warn_ratelimited(hdev, "Identity key blocked for %=
pMR",
> -                                       &irk_to_return->bdaddr);
> +                                       &data.bdaddr);
> +               hci_irk_put(irk_to_return);
>                 irk_to_return =3D NULL;
>         }
>
> -       rcu_read_unlock();
> -
>         return irk_to_return;
>  }
>
> @@ -1209,6 +1268,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev=
 *hdev, bdaddr_t *bdaddr,
>                                      u8 addr_type)
>  {
>         struct smp_irk *irk_to_return =3D NULL;
> +       struct smp_irk_data data;
>         struct smp_irk *irk;
>
>         /* Identity Address must be public or static random */
> @@ -1217,25 +1277,53 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_d=
ev *hdev, bdaddr_t *bdaddr,
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> -               if (addr_type =3D=3D irk->addr_type &&
> -                   bacmp(bdaddr, &irk->bdaddr) =3D=3D 0) {
> +               hci_irk_read(hdev, irk, &data);
> +               if (addr_type =3D=3D data.addr_type &&
> +                   bacmp(bdaddr, &data.bdaddr) =3D=3D 0 && hci_irk_get(i=
rk)) {
>                         irk_to_return =3D irk;
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
> +
> +       if (irk_to_return)
> +               hci_irk_read(hdev, irk_to_return, &data);
>
>         if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYP=
E_IRK,
> -                                               irk_to_return->val)) {
> +                                               data.val)) {
>                 bt_dev_warn_ratelimited(hdev, "Identity key blocked for %=
pMR",
> -                                       &irk_to_return->bdaddr);
> +                                       &data.bdaddr);
> +               hci_irk_put(irk_to_return);
>                 irk_to_return =3D NULL;
>         }
>
> -       rcu_read_unlock();
> -
>         return irk_to_return;
>  }
>
> +static void hci_irk_release(struct kref *ref)
> +{
> +       struct smp_irk *irk =3D container_of(ref, struct smp_irk, ref);
> +
> +       kfree_rcu(irk, rcu);
> +}
> +
> +void hci_irk_put(struct smp_irk *irk)
> +{
> +       kref_put(&irk->ref, hci_irk_release);
> +}
> +
> +void hci_irk_unlink(struct hci_dev *hdev, struct smp_irk *irk)
> +{
> +       bool unlinked;
> +
> +       spin_lock_bh(&hdev->irk_lock);
> +       unlinked =3D __hci_irk_unlink(irk);
> +       spin_unlock_bh(&hdev->irk_lock);
> +
> +       if (unlinked)
> +               hci_irk_put(irk);
> +}
> +
>  struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn =
*conn,
>                                   bdaddr_t *bdaddr, u8 *val, u8 type,
>                                   u8 pin_len, bool *persistent)
> @@ -1315,24 +1403,47 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev,=
 bdaddr_t *bdaddr,
>  struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                             u8 addr_type, u8 val[16], bdaddr_t *rpa)
>  {
> -       struct smp_irk *irk;
> +       struct smp_irk *irk, *new_irk;
>
>         irk =3D hci_find_irk_by_addr(hdev, bdaddr, addr_type);
> -       if (!irk) {
> -               irk =3D kzalloc_obj(*irk);
> -               if (!irk)
> -                       return NULL;
> +       if (irk) {
> +               spin_lock_bh(&hdev->irk_lock);
> +               memcpy(irk->val, val, sizeof(irk->val));
> +               bacpy(&irk->rpa, rpa);
> +               spin_unlock_bh(&hdev->irk_lock);
> +               return irk;
> +       }
> +
> +       new_irk =3D kzalloc_obj(*new_irk);
> +       if (!new_irk)
> +               return NULL;
>
> -               bacpy(&irk->bdaddr, bdaddr);
> -               irk->addr_type =3D addr_type;
> +       bacpy(&new_irk->bdaddr, bdaddr);
> +       new_irk->addr_type =3D addr_type;
> +       memcpy(new_irk->val, val, sizeof(new_irk->val));
> +       bacpy(&new_irk->rpa, rpa);
>
> -               list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
> +       spin_lock_bh(&hdev->irk_lock);
> +       list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
> +               if (addr_type !=3D irk->addr_type ||
> +                   bacmp(bdaddr, &irk->bdaddr))
> +                       continue;
> +
> +               kref_get(&irk->ref);
> +               memcpy(irk->val, val, sizeof(irk->val));
> +               bacpy(&irk->rpa, rpa);
> +               spin_unlock_bh(&hdev->irk_lock);
> +               kfree(new_irk);
> +               return irk;
>         }
>
> -       memcpy(irk->val, val, 16);
> -       bacpy(&irk->rpa, rpa);
> +       kref_init(&new_irk->ref);
> +       kref_get(&new_irk->ref);
> +       set_bit(SMP_IRK_LINKED, &new_irk->flags);
> +       list_add_rcu(&new_irk->list, &hdev->identity_resolving_keys);
> +       spin_unlock_bh(&hdev->irk_lock);
>
> -       return irk;
> +       return new_irk;
>  }
>
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> @@ -1372,16 +1483,27 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t=
 *bdaddr, u8 bdaddr_type)
>
>  void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type=
)
>  {
> -       struct smp_irk *k, *tmp;
> +       struct smp_irk *k, *removed;
>
> -       list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, =
list) {
> -               if (bacmp(bdaddr, &k->bdaddr) || k->addr_type !=3D addr_t=
ype)
> -                       continue;
> +       for (;;) {
> +               removed =3D NULL;
> +               spin_lock_bh(&hdev->irk_lock);
> +               list_for_each_entry(k, &hdev->identity_resolving_keys, li=
st) {
> +                       if (bacmp(bdaddr, &k->bdaddr) ||
> +                           k->addr_type !=3D addr_type)
> +                               continue;
>
> -               BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> +                       __hci_irk_unlink(k);
> +                       removed =3D k;
> +                       break;
> +               }
> +               spin_unlock_bh(&hdev->irk_lock);
>
> -               list_del_rcu(&k->list);
> -               kfree_rcu(k, rcu);
> +               if (!removed)
> +                       break;
> +
> +               BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> +               hci_irk_put(removed);
>         }
>  }
>
> @@ -1389,6 +1511,8 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bda=
ddr_t *bdaddr, u8 type)
>  {
>         struct smp_ltk *k;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
> +       bdaddr_t identity_addr;
>         u8 addr_type;
>
>         if (type =3D=3D BDADDR_BREDR) {
> @@ -1405,8 +1529,11 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bd=
addr_t *bdaddr, u8 type)
>
>         irk =3D hci_get_irk(hdev, bdaddr, addr_type);
>         if (irk) {
> -               bdaddr =3D &irk->bdaddr;
> -               addr_type =3D irk->addr_type;
> +               hci_irk_read(hdev, irk, &irk_data);
> +               bacpy(&identity_addr, &irk_data.bdaddr);
> +               addr_type =3D irk_data.addr_type;
> +               hci_irk_put(irk);
> +               bdaddr =3D &identity_addr;
>         }
>
>         rcu_read_lock();
> @@ -2495,6 +2622,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         INIT_LIST_HEAD(&hdev->uuids);
>         INIT_LIST_HEAD(&hdev->link_keys);
>         INIT_LIST_HEAD(&hdev->long_term_keys);
> +       spin_lock_init(&hdev->irk_lock);
>         INIT_LIST_HEAD(&hdev->identity_resolving_keys);
>         INIT_LIST_HEAD(&hdev->remote_oob_data);
>         INIT_LIST_HEAD(&hdev->le_accept_list);
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index aadffaaff20e..3b3f7a481990 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -817,13 +817,15 @@ DEFINE_SHOW_ATTRIBUTE(resolv_list);
>  static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
>  {
>         struct hci_dev *hdev =3D f->private;
> +       struct smp_irk_data irk_data;
>         struct smp_irk *irk;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> +               hci_irk_read(hdev, irk, &irk_data);
>                 seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
> -                          &irk->bdaddr, irk->addr_type,
> -                          16, irk->val, &irk->rpa);
> +                          &irk_data.bdaddr, irk_data.addr_type,
> +                          16, irk_data.val, &irk_data.rpa);
>         }
>         rcu_read_unlock();
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2f5e21ff9752..f2971319410d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5757,6 +5757,7 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>         struct hci_conn_params *params;
>         struct hci_conn *conn;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
>         u8 addr_type;
>         int err;
>
> @@ -5842,8 +5843,10 @@ static void le_conn_complete_evt(struct hci_dev *h=
dev, u8 status,
>          */
>         irk =3D hci_get_irk(hdev, &conn->dst, conn->dst_type);
>         if (irk) {
> -               bacpy(&conn->dst, &irk->bdaddr);
> -               conn->dst_type =3D irk->addr_type;
> +               hci_irk_read(hdev, irk, &irk_data);
> +               bacpy(&conn->dst, &irk_data.bdaddr);
> +               conn->dst_type =3D irk_data.addr_type;
> +               hci_irk_put(irk);
>         }
>
>         conn->dst_type =3D ev_bdaddr_type(hdev, conn->dst_type, NULL);
> @@ -6234,7 +6237,9 @@ static void process_adv_report(struct hci_dev *hdev=
, u8 type, bdaddr_t *bdaddr,
>  {
>         struct discovery_state *d =3D &hdev->discovery;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
>         struct hci_conn *conn;
> +       bdaddr_t identity_addr;
>         bool match, bdaddr_resolved;
>         u32 flags;
>         u8 *ptr;
> @@ -6309,8 +6314,11 @@ static void process_adv_report(struct hci_dev *hde=
v, u8 type, bdaddr_t *bdaddr,
>         /* Check if we need to convert to identity address */
>         irk =3D hci_get_irk(hdev, bdaddr, bdaddr_type);
>         if (irk) {
> -               bdaddr =3D &irk->bdaddr;
> -               bdaddr_type =3D irk->addr_type;
> +               hci_irk_read(hdev, irk, &irk_data);
> +               bacpy(&identity_addr, &irk_data.bdaddr);
> +               bdaddr_type =3D irk_data.addr_type;
> +               hci_irk_put(irk);
> +               bdaddr =3D &identity_addr;
>         }
>
>         bdaddr_type =3D ev_bdaddr_type(hdev, bdaddr_type, &bdaddr_resolve=
d);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index ffd7b37e7401..fcb96c4b0793 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2469,6 +2469,7 @@ static int hci_le_add_resolve_list_sync(struct hci_=
dev *hdev,
>  {
>         struct hci_cp_le_add_to_resolv_list cp;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
>         struct bdaddr_list_with_irk *entry;
>         struct hci_conn_params *p;
>
> @@ -2496,12 +2497,16 @@ static int hci_le_add_resolve_list_sync(struct hc=
i_dev *hdev,
>         entry =3D hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list,
>                                                 &params->addr,
>                                                 params->addr_type);
> -       if (entry)
> +       if (entry) {
> +               hci_irk_put(irk);
>                 return 0;
> +       }
>
>         cp.bdaddr_type =3D params->addr_type;
>         bacpy(&cp.bdaddr, &params->addr);
> -       memcpy(cp.peer_irk, irk->val, 16);
> +       hci_irk_read(hdev, irk, &irk_data);
> +       memcpy(cp.peer_irk, irk_data.val, sizeof(cp.peer_irk));
> +       hci_irk_put(irk);
>
>         /* Default privacy mode is always Network */
>         params->privacy_mode =3D HCI_NETWORK_PRIVACY;
> @@ -2532,6 +2537,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_=
dev *hdev,
>  {
>         struct hci_cp_le_set_privacy_mode cp;
>         struct smp_irk *irk;
> +       struct smp_irk_data irk_data;
>
>         if (!ll_privacy_capable(hdev) ||
>             !(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION))
> @@ -2552,10 +2558,12 @@ static int hci_le_set_privacy_mode_sync(struct hc=
i_dev *hdev,
>         if (!irk)
>                 return 0;
>
> +       hci_irk_read(hdev, irk, &irk_data);
>         memset(&cp, 0, sizeof(cp));
> -       cp.bdaddr_type =3D irk->addr_type;
> -       bacpy(&cp.bdaddr, &irk->bdaddr);
> +       cp.bdaddr_type =3D irk_data.addr_type;
> +       bacpy(&cp.bdaddr, &irk_data.bdaddr);
>         cp.mode =3D HCI_DEVICE_PRIVACY;
> +       hci_irk_put(irk);
>
>         /* Note: params->privacy_mode is not updated since it is a copy *=
/
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 75bfd5938b2e..928b761453d6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -723,22 +723,34 @@ static struct sock *iso_get_sock(struct hci_dev *hd=
ev, bdaddr_t *src,
>                 /* Match Broadcast destination */
>                 if (bacmp(dst, BDADDR_ANY) && bacmp(&iso_pi(sk)->dst, dst=
)) {
>                         struct smp_irk *irk1, *irk2;
> +                       struct smp_irk_data irk_data;
> +                       bool resolved =3D false;
>
>                         /* Check if destination is an RPA that we can res=
olve */
>                         irk1 =3D hci_find_irk_by_rpa(hdev, dst);
>                         if (!irk1)
>                                 continue;
>
> +                       hci_irk_read(hdev, irk1, &irk_data);
> +
>                         /* Match with identity address */
> -                       if (bacmp(&iso_pi(sk)->dst, &irk1->bdaddr)) {
> +                       if (!bacmp(&iso_pi(sk)->dst, &irk_data.bdaddr)) {
> +                               resolved =3D true;
> +                       } else {
>                                 /* Check if socket destination address is=
 also
>                                  * an RPA and if the IRK matches.
>                                  */
>                                 irk2 =3D hci_find_irk_by_rpa(hdev,
>                                                            &iso_pi(sk)->d=
st);
> -                               if (!irk2 || irk1 !=3D irk2)
> -                                       continue;
> +                               if (irk2) {
> +                                       resolved =3D irk1 =3D=3D irk2;
> +                                       hci_irk_put(irk2);
> +                               }
>                         }
> +
> +                       hci_irk_put(irk1);
> +                       if (!resolved)
> +                               continue;
>                 }
>
>                 /* Use Match function if provided */
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ac4864e56ec7..841702cdf14e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -7315,6 +7315,7 @@ static int load_irks(struct sock *sk, struct hci_de=
v *hdev, void *cp_data,
>
>         for (i =3D 0; i < irk_count; i++) {
>                 struct mgmt_irk_info *irk =3D &cp->irks[i];
> +               struct smp_irk *smp_irk;
>
>                 if (hci_is_blocked_key(hdev,
>                                        HCI_BLOCKED_KEY_TYPE_IRK,
> @@ -7324,9 +7325,11 @@ static int load_irks(struct sock *sk, struct hci_d=
ev *hdev, void *cp_data,
>                         continue;
>                 }
>
> -               hci_add_irk(hdev, &irk->addr.bdaddr,
> -                           le_addr_type(irk->addr.type), irk->val,
> -                           BDADDR_ANY);
> +               smp_irk =3D hci_add_irk(hdev, &irk->addr.bdaddr,
> +                                     le_addr_type(irk->addr.type), irk->=
val,
> +                                     BDADDR_ANY);
> +               if (smp_irk)
> +                       hci_irk_put(smp_irk);
>         }
>
>         hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
> @@ -9945,7 +9948,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_=
ltk *key, bool persistent)
>         mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL=
);
>  }
>
> -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent)
> +void mgmt_new_irk(struct hci_dev *hdev, const struct smp_irk_data *irk,
> +                 bool persistent)
>  {
>         struct mgmt_ev_new_irk ev;
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 6091c47cb002..37000495b987 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -761,11 +761,13 @@ static void smp_chan_destroy(struct l2cap_conn *con=
n)
>                 }
>
>                 if (smp->remote_irk) {
> -                       list_del_rcu(&smp->remote_irk->list);
> -                       kfree_rcu(smp->remote_irk, rcu);
> +                       hci_irk_unlink(hcon->hdev, smp->remote_irk);
>                 }
>         }
>
> +       if (smp->remote_irk)
> +               hci_irk_put(smp->remote_irk);
> +
>         chan->data =3D NULL;
>         kfree_sensitive(smp);
>         hci_conn_drop(hcon);
> @@ -1017,6 +1019,7 @@ static void smp_notify_keys(struct l2cap_conn *conn=
)
>         struct hci_dev *hdev =3D hcon->hdev;
>         struct smp_cmd_pairing *req =3D (void *) &smp->preq[1];
>         struct smp_cmd_pairing *rsp =3D (void *) &smp->prsp[1];
> +       struct smp_irk_data irk_data;
>         bool persistent;
>
>         if (hcon->type =3D=3D ACL_LINK) {
> @@ -1035,15 +1038,16 @@ static void smp_notify_keys(struct l2cap_conn *co=
nn)
>         }
>
>         if (smp->remote_irk) {
> -               mgmt_new_irk(hdev, smp->remote_irk, persistent);
> +               hci_irk_read(hdev, smp->remote_irk, &irk_data);
> +               mgmt_new_irk(hdev, &irk_data, persistent);
>
>                 /* Now that user space can be considered to know the
>                  * identity address track the connection based on it
>                  * from now on (assuming this is an LE link).
>                  */
>                 if (hcon->type =3D=3D LE_LINK) {
> -                       bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
> -                       hcon->dst_type =3D smp->remote_irk->addr_type;
> +                       bacpy(&hcon->dst, &irk_data.bdaddr);
> +                       hcon->dst_type =3D irk_data.addr_type;
>                         /* Use a short delay to make sure the new address=
 is
>                          * propagated _before_ the channels.
>                          */
> @@ -2443,7 +2447,11 @@ int smp_cancel_and_remove_pairing(struct hci_dev *=
hdev, bdaddr_t *bdaddr,
>                  * remove and free already invalidated rcu list entries. =
*/
>                 smp->ltk =3D NULL;
>                 smp->responder_ltk =3D NULL;
> -               smp->remote_irk =3D NULL;
> +               if (smp->remote_irk) {
> +                       hci_irk_unlink(hdev, smp->remote_irk);
> +                       hci_irk_put(smp->remote_irk);
> +                       smp->remote_irk =3D NULL;
> +               }
>
>                 if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
>                         smp_failure(conn, 0);
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
