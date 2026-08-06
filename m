Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE742CB08
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054595; cv=pass; b=UFQojmKdCsDaenT08d3PhvlIXiHWLwh4Qk86KYJUBGb92ZbOfgNgzUN40d7jfatGhRLS6uteqj490l2Ov6q3q2KHakSZGNneP2EMCfX6ZkFrpS77RYIU+jz7WWHQnMnUPPzjS2hq9bmyb+sIehLZ9tsDG0oBXW+Iilet0HY0OTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054595; c=relaxed/simple;
	bh=weYH6v0xVOJALq1QvcZ20AX7YymFl1h0XJLHWt/8Y88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI5+c/ROpIdkMD4n2OTTPb6WtA4e/U0i01Kw/OvyVN9DlYt7Tr+tlqB3kot/x3ZoBg67yS2ITYp96PyYDAqUNe+kkRzZxGskoGCpeSjweaxOL0YbZ22dSHAm2u71Hg2GmzT6110yA+9eiW9eieAbkkMtQ+Q7y2MTW2v5Q0j8WDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRdimAB7; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRdimAB7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso23399581fa.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 15:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786054588; cv=none;
        d=google.com; s=arc-20260327;
        b=XJ4NfxKrJWbPd8W/8yNnvzEzsdgNa62d4ImtVy2ixMl92d1w+YfRZ6aI1fhDeJB0Ms
         OimLKwvIDomji0Eoex2C7DZA1uqTn05SH2vKlPu+4SNvvvJ0Ee0HZf6HEJlXmkW8QWCy
         XoTmlovQkLQ9/nl/wbOVJqAl4AlCC0EmhahvWcsEWR+uASf5tUapLnT83PZjW9wRI0DR
         OTJAQN1ewX/VWxUKVXtCx40tnoMua3skw3JWH6ga+rQRlmrPd7gOFC1AMuWaP6LJuuSI
         rf1EYuKmbol8JASXo8pHK3VGpB1dfxwces5np3HxqzfXn4qRYhOnsUsW2OqgE8g0j7y/
         rW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dik8lXj7bGmvDMfqCjvRXp95BtHdEKAxWp1zyPZ20es=;
        fh=aZGG6nuSA0WPY/Lb5SFi99GL78OKFQj5PJMgIYurXOU=;
        b=ssuWbICPGVpYkHWJAzy9BF4+v8ByerEtC/k+TAD2TH5Zq15cPVmeGiqE9unSJsRXjz
         nZhb6UiuPGPNxXOuV409ua6NfMphUW6bDIQqQBCsVFr58jfnogoWq5mn0pyM/QpjDnIl
         g6TZN+cqYxgqebiMiEn6LFRRat9W6nAb3yjglugU7I17RQI+prr+R8hW04FN0f1o4hXv
         H6w8Qb63zhX/dhj9SjxoKEHeGIOlmQnhzhNYrG89EEgXcYfssCuBjar6KMXLm5cBGSna
         TICz3in+7aZLNxZSqXKKX6q1n6NSPvmUstH7nj7mupSRoZaaJUwWh6tz0cZe3IU+nHiA
         ucgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054588; x=1786659388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dik8lXj7bGmvDMfqCjvRXp95BtHdEKAxWp1zyPZ20es=;
        b=sRdimAB7UmjyFDvgwNzkEiVGQCwKXcDyt4cyrlruF9G8cCTbmXphqD2YzLtaRnHO8b
         ITekhNQp6ZVQ6AvskcsHDjNyO5TP7VQ01vhJT4+huhv8OUkGaC6SQma75trTQhUso7tN
         K0AdnDzEAj/MsdNdYbhax5Y86Y/3OcVr8jlEwRez6ozIHZjr79RGc+MqILviEbp6h71f
         FhrXU1JOFAaH2ksh0YU9scg4BbUOWcZESJ5u6OKhUpwyK9jlRFkXGbuXwYLEiseHSBh0
         ECHMj3GPqKruv7P/2CKwAACvidUZnS8vmrGaaKYcMa6jjFcRrdj7kNuz5buWhg3BuH5k
         OVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054588; x=1786659388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dik8lXj7bGmvDMfqCjvRXp95BtHdEKAxWp1zyPZ20es=;
        b=q+bERNQoJ+QgUDWyKIhJudHM8IJEESbT6YBZFfOIp7vvmX/JgPLWFVsapL+dxE6mFO
         eM4ZzH9ryXoOaNuv0KNjklCLcH+8hIhUVJ5yv7efLY0kxKCEUF3ORRS5qNn+scw0HBxS
         uNsfqMS1dYOIBFk3qb/nqaBM2vJOzxAxLtf5MJI/hlgCF1e8NiSw49JR81k86UBAdkvA
         TjoNEz3iik6w7FY0BFa5g7x9Br1wVlxowh6vikkRHwAQUkIyIoc53lzc4g9YxZgtXch0
         XOuD9OLOawJI2HU/fZDClxRmJ6lh9HyFMzm4TxfjHhjask6qXXTe6bAGDxBSirKP4RXf
         Op6A==
X-Gm-Message-State: AOJu0Ywnd7TcEh+N8aLSqJSV/ksX4NN7ZuaZAc2pHHWNPKNuF6w5N/X0
	PmZYEB9+LlPooIEPPJVTUNKuBZs3Rc+6gw0IkLYCubfBhjAX7vbb3zRyr9GkDPQJ3d2z9xB8QOs
	7ceLHVjbBreyHYBT50DZE+7HJBajcXKkvFgIh2W01IjvEfu42mkUaA2kE
X-Gm-Gg: AR+sD10b12ASknIxC6PPESIXpae+9v0rZBOJo8zGaXC8lgoY/LnGGUAQgno13haBmxI
	Wjx+qzsCBXsGphhUCaWDOBzRd51oep00JWvsEnQ07oXdRzdInBD6lUZYeuNmQjC81PPdKMD4AAE
	wOQ78cL/lqmY7iV7yTctjSw4FtyY/xgpZerVCXXm0uqjQ95Mllm4zZkdEPvwqy8n+B3B7NUbNuQ
	2ipaaY4e3QKp+NKs0GfyqLK2dEu9tEypsRi3W89NIiOImebX3KKmsDNSYaLkTPD7lGZ0ZBwxVsS
	KmbD6lmd2aGAtfC0mxmyR+Az1eZ3tUE2EAOZSbWs2Sl+Os7Q0iKfctmZxo7J6hY+cDH7zR6B/i+
	ht/1MEfK89kQ7gkchq0yj4SDlWHzmhdNvm5FxtJDbB7ZCu8F+5PK0sLOF5qfHtEBB1qtLyeZe
X-Received: by 2002:a05:651c:a110:10b0:39b:4371:dbd8 with SMTP id
 38308e7fff4ca-39fbb063b40mr15768361fa.4.1786054587580; Thu, 06 Aug 2026
 15:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806221044.1169839-1-tkjos@google.com>
In-Reply-To: <20260806221044.1169839-1-tkjos@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 6 Aug 2026 15:16:15 -0700
X-Gm-Features: AUfX_mwhi4xQQdQIQf9cgw0H6en9Lh7db2SZgPUJjWjfDbUxN7A8n-dGGRFuqKs
Message-ID: <CAHRSSEwFf3ei5f17W3VQA3CBhVPXNK3jB=YN4LVRxyaj-t7FSw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: fix potential UAF in create_big_sync
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Sasha Levin <sashal@kernel.org>, 
	David Carlier <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ignore this submit... I forgot to indicate which stable with [PATCH
6.1.y]. Replacement already sent. Sorry about the noise.

On Thu, Aug 6, 2026 at 3:10=E2=80=AFPM Todd Kjos <tkjos@google.com> wrote:
>
> [ Upstream commit 0beddb0c380bed5f5b8e61ddbe14635bb73d0b41 ]
>
> Add hci_conn_valid() check in create_big_sync() to detect stale
> connections before proceeding with BIG creation. Handle the
> resulting -ECANCELED in create_big_complete() and re-validate the
> connection under hci_dev_lock() before dereferencing, matching the
> pattern used by create_le_conn_complete() and create_pa_complete().
>
> Keep the hci_conn object alive across the async boundary by taking
> a reference via hci_conn_get() when queueing create_big_sync(), and
> dropping it in the completion callback. The refcount and the lock
> are complementary: the refcount keeps the object allocated, while
> hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
> hdev->conn_hash, as required by hci_conn_del().
>
> hci_conn_put() is called outside hci_dev_unlock() so the final put
> (which resolves to kfree() via bt_link_release) does not run under
> hdev->lock, though the release path would be safe either way.
>
> Without this, create_big_complete() would unconditionally
> dereference the conn pointer on error, causing a use-after-free
> via hci_connect_cfm() and hci_conn_del().
>
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connec=
tions")
> Cc: stable@vger.kernel.org
> Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [ kept stable's `qos->bcast.out.phy =3D=3D 0x02` context line instead of =
upstream's renamed `qos->bcast.out.phys =3D=3D BIT(1)` ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ Backported to 6.1.y: included inline helper hci_conn_valid() in
>   include/net/bluetooth/hci_core.h from upstream commit 881559af5f5c ]
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
>  net/bluetooth/hci_conn.c         | 19 ++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e67b1e5e0d2c8fb3c49696dd73e5fd6753412155..76764d399b23eff885e307148=
391c9cba5c6a4d0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1069,6 +1069,24 @@ static inline unsigned int hci_conn_count(struct h=
ci_dev *hdev)
>         return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_=
num;
>  }
>
> +static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn =
*conn)
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn  *c;
> +
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (c =3D=3D conn) {
> +                       rcu_read_unlock();
> +                       return true;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return false;
> +}
> +
>  static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 hand=
le)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54cfcab7636380a2ced55986a81b0240e9d48d87..aa5404412cbd34320f00954bd=
a71dce65910793c 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2088,6 +2088,9 @@ static int create_big_sync(struct hci_dev *hdev, vo=
id *data)
>         u32 flags =3D 0;
>         int err;
>
> +       if (!hci_conn_valid(hdev, conn))
> +               return -ECANCELED;
> +
>         if (qos->out.phy =3D=3D 0x02)
>                 flags |=3D MGMT_ADV_FLAG_SEC_2M;
>
> @@ -2194,11 +2197,24 @@ static void create_big_complete(struct hci_dev *h=
dev, void *data, int err)
>
>         bt_dev_dbg(hdev, "conn %p", conn);
>
> +       if (err =3D=3D -ECANCELED)
> +               goto done;
> +
> +       hci_dev_lock(hdev);
> +
> +       if (!hci_conn_valid(hdev, conn))
> +               goto unlock;
> +
>         if (err) {
>                 bt_dev_err(hdev, "Unable to create BIG: %d", err);
>                 hci_connect_cfm(conn, err);
>                 hci_conn_del(conn);
>         }
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +done:
> +       hci_conn_put(conn);
>  }
>
>  struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
> @@ -2223,10 +2239,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *=
hdev, bdaddr_t *dst,
>         }
>
>         /* Queue start periodic advertising and create BIG */
> -       err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
> +       err =3D hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(co=
nn),
>                                  create_big_complete);
>         if (err < 0) {
>                 hci_conn_drop(conn);
> +               hci_conn_put(conn);
>                 return ERR_PTR(err);
>         }
>
> --
> 2.55.0.654.g21b8a5bc05-goog
>
