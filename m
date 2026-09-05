Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C230C637
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573165; cv=pass; b=ujQkoOz03HvR6G+CEezrUAsqzSn5mA26aZEo7VU9UlQltjMJ6s5PFqmzNMMUaYynI2TZYvZdRnbLAuSgdI/GjVmMQQHWySpTmeMe7+K0eWNRVaRyV2Y6VassLswp65TsPkSy+04l5JM8KR67ZC+h1XQ+T03Eqq0JAd+5N8gcSJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573165; c=relaxed/simple;
	bh=wubeqTfIk5VUBpRsWPXRo7LgM8grLWk4CjJuaRVPQxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWf8+Sw/qwfCYIvepbs9x2ilJ7w7seba5oc/uzDG3G/tigj50D1Sfzp2abtfMoPk80ki0Pcjex6seh4ocwVDFNcDzmoYP7igGbpICPXc1ZLjGKCeHRPXPv4cQQp9Fh7zGzK85qW7BVU6m1NaKhqeTb9GPaeLrLE+1+LAcPNNCiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=XiaUz7xn; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="XiaUz7xn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso265359266b.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 18:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573162; cv=none;
        d=google.com; s=arc-20260327;
        b=QNi2b8SW9oKxuGqEgxZnBsz7E5EXV/v3N7cpbAdh8cPi/2lv2MiUaeYGkY4lvXyArt
         SkJSY+MJWPAer3wsME4bmMVCqdt45m7HWmLvamFypUY1t2m3WkEfUAhRnplbkCnlbGzu
         6SGDXetudae60D78DEnwLe6NB5McAtm9aKDjtRuXg+0FDL2jhxW8iz3mGSbX1Woml7rl
         NsofdOWlG39ZDpp/Qj1KqWBloAl/FRDhTIjVfEGdkSfZ9ygK27ehx+kF8Hwm5/sC0p/a
         Mqtf06BrhTvxuMOb0u3qqZs8JHVEbJ33vuTrIkRnRnjl2MzfsIPMF/mf2Mb5tfl7XmDd
         qN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        fh=+9sagLXtn1H0FdFJAkhpEBeQQdmm8CNS/xbfhq2EdIs=;
        b=RN3MKxMyR0rTzP/S3FeG2IEpcyDXwwElkqngh9i9+55ihW+DGnbAKDJOsJFIhM7UKE
         5G+vhjE7DGPrrJNg8ItyFy9phPe/3Ua57ym7LSf+4Ah/8c+1bAgh3s6FBaMLeliwjtxi
         XMqkcAkVQ0EHNoOWi3FzQQO0ofnWVXg/Z92xevx/m+kYAyBu/VGjXuINwbNjkG9o0sMl
         JDne7bZlEkLYYlaN7O0Ylmsvo2Fyw94umCXL2mrcRF/0xM8tda3r4bcxsHY+JgGBi09f
         Gnl/tMSX2f9F1PRZUiyWukNyzQafMPFKreeZaflbCLBIpYRvfss7EoYSuPBE975fXdDQ
         Ia7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788573162; x=1789177962; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        b=XiaUz7xnerBLKp3FnHsA0tR4fYK6OnVBLJSL4Qm0gmYVzKVMygv2XfDVqzZMJyIAis
         TrxnEiRbo7kq1b1syqomuKcRtY1/E7XHAE6ckd8aOYzsPnf3/SGGUZq39GJsX90T8GVk
         7s6SBE83Wl4mMiOCk7VdABVVYGt3Oq1ExPWdhQTcu2V8Q7qpyIX6AxsdjCFyo+7wq5eI
         UdllKB4SeQoy8No1U4qVmWPTiS92u4CtRQgBMK6WRq7yUB7uV1qR6FXGsjRidqE6AwZ7
         z5CTeQpmATThRgVhqID8GGRm32RpPpu9+vtVI5HWJwoXfL14bdRfBM7KcRGqmhYDDapw
         /D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573162; x=1789177962;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        b=DtQl8BNp+z6E4rwiywGpdy0mxuetsibGCpMdtovd+LTKu09bL1AfXrwVWcNOUvNQnq
         cL10d9aNGdQBUJCnGVv7HAz3P39BU/3knZpeHCht4wordkEdDGMUFY8DZFHW6HKkVUs2
         qRRrtOuHdhiwwwIMjCdpj7lgZ+Lw9zyXZHfnTDTw6YrOCPi267+2ETZ9How7mRn0H2qY
         89+PsHjB8W1U2OgmZeOCGemKs0JSbXWFjdV/yZFrLCXB0EdUp3tJ/TjCRdllP66tW9+7
         MnE0PA+EiO7pOSx5v/bf0tb0MvKVfongSydy3U7Qt58duZE2BlFpq1kjOtLStaxUfha8
         74bA==
X-Forwarded-Encrypted: i=1; AKwUvBxf47H2ZBy1X7tMZlVwKZpUHV64jorCBsujqs8G7jxSh+4kMQivCHhhC1bq3JgRzHfKfNcPpXw=@vger.kernel.org
X-Gm-Message-State: AFuF++kUshGzI1VrQnJ9SP6Rh/++K7+HNuwSVhofXn++uXaEBJEhZrPR
	aypoQofLYj4BsQyyv3IPYeSD0rbDhgBs9o41F7+ZKV+0w5wtyGdd9cXRmMa+nRmcA/2R/6f5R8L
	DiU9JT7keJA9g3i8tCdouKmb8yN7zw9rBRQ3tiRTVAQ==
X-Gm-Gg: AYBFou2pmSBkWVRyPmuHGa5Sml8CYdl+1tN5qEThHxxYHcCosIk4tCw0yvMhSAPiJtU
	CGHphSZP2sgXEZ/c1WheA9euSo3C+uHwZ3kvdbTlCF8BQu0QDdzXKp52tn6iiIONcTLgSzXrwAG
	Ulfx6HsTkBC5sZm1U0AqIxT8unkKGqpXa8iBSB/aZ53g/lCTzdV2nkVYBmHqHXmBwrHwlbKshyM
	MFXwiESZ/D3V4Po1vVdeJcHsJ1en/jPM59V/0+irZCEH4sDYk6kkAo27vTM6m388Jin11e8H4ZB
	8g6ujI8x/hEaBBasnB92TgziWpIlRjtJi+bOSr6YDnttVKo=
X-Received: by 2002:a17:907:3c8f:b0:c25:4b9c:5ed1 with SMTP id
 a640c23a62f3a-c260c9ab80emr402694966b.12.1788573162537; Fri, 04 Sep 2026
 18:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-3-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-3-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:52:31 -0700
X-Gm-Features: AcwNN1VYV_bsyw2MRCUrfeCHlF3zc7lCehIidBhtYC3IhQAcHeY7tGhIM3OccVE
Message-ID: <CAOJNxRKM-vjeg-MKrNqarpn=HQb2gw1H3-FUxPR3a9E1=Ewy5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ceph: stop checking a stale MDS map after dropping mutex
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 08:03, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> check_new_map() drops `mdsc->mutex` in several slow paths.  Another
> map handler can install a newer map and destroy the map being checked
> before the original invocation re-locks the mutex.  Continuing to
> dereference newmap after that results in a use-after-free.
>
> Use the `mdsmap->m_epoch` field to identify stale maps.
>
> Fixes: 2f2dc053404f ("ceph: MDS client")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d36a114747ae..86d592f06196 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5844,6 +5844,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                           struct ceph_mdsmap *newmap,
>                           struct ceph_mdsmap *oldmap)
>  {
> +       u32 map_epoch = newmap->m_epoch;
>         int i, j, err;
>         int oldstate, newstate;
>         struct ceph_mds_session *s;
> @@ -5887,6 +5888,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         ceph_put_mds_session(s);
>
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch)
> +                               return;
>                         kick_requests(mdsc, i);
>                         continue;
>                 }
> @@ -5898,6 +5901,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                         ceph_con_close(&s->s_con);
>                         mutex_unlock(&s->s_mutex);
>                         s->s_state = CEPH_MDS_SESSION_RESTARTING;
> @@ -5921,6 +5929,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                                "mds%d reconnect failed: %d\n",
>                                                i, rc);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                 }
>
>                 /*
> @@ -5936,6 +5948,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                         ceph_kick_flushing_caps(mdsc, s);
>                         mutex_unlock(&s->s_mutex);
>                         wake_up_session_caps(s, RECONNECT);
> @@ -5991,6 +6008,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                        i, err);
>                 ceph_put_mds_session(s);
>                 mutex_lock(&mdsc->mutex);
> +               if (mdsc->mdsmap->m_epoch != map_epoch)
> +                       return;
>         }
>
>         for (i = 0; i < newmap->possible_max_rank && i < mdsc->max_sessions; i++) {
> --
> 2.47.3
>
