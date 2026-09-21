Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EA48F835
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031349; cv=pass; b=s6Cu7PKfOFPZY4stVdHZjXuiUhh0tjrTQFPF4d+434me5rZ04bxoehTVE/iXJxXtzLKdbUU++FNwTW6BJ4kVGb4Al7C+R2ruWbM9o0AiI5eTNKHNAaqx2xxhvnMvVETIDybZzjaSPNTFHLmzKhW67LS7wnaKrpJDj0gaSaH3RSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031349; c=relaxed/simple;
	bh=hyJLCVJxZDQDHfQeiCxaRFPeeiFOJ1V0CZ8eKBM6X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAX7VSjnsuwHtk40jJCSL9SVmXB3Wl9Z5mjMsT+81eKiPnG8nVyNCvF+3c5AiSLHb5SHmyFWECJ6YDyChVPELuW65YqIN8u6AlJsSGHlULQG1EpGVbS1tpupwx8c2UGtjKNd4q6xAMPUyPqXPu03n4lpbvhLKC3MoEkdDOBILtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+9x8apm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJeJkqv7; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+9x8apm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJeJkqv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790031347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
	b=M+9x8apmch+bIoBKCBbq9LPX8D/188cog2jiF1C+vuNfPPXUihph7w5w6ZlNVnKT8ykAdy
	mm8g+Yp9+DtLkS283BYNG5TE/6vksPD1yhxcb45R1lhjsRuco8xCjj9Dv7CpX1AfXv0N4m
	wjRFY1F+9W5Vc9weBUEdR1WX+qqSSNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-qLBvL2qgMXWy7AI3GjdE1A-1; Mon, 21 Sep 2026 18:55:46 -0400
X-MC-Unique: qLBvL2qgMXWy7AI3GjdE1A-1
X-Mimecast-MFC-AGG-ID: qLBvL2qgMXWy7AI3GjdE1A_1790031345
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so27078885e9.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790031345; cv=none;
        d=google.com; s=arc-20260327;
        b=c7CJkMgZtv01A2mbNnCOxpchhyRg0EL23s1MOHK6KQ+UlXMtZHqLDh+8/ItGr/ZRTQ
         eQfKkOwkPN5bVLEOiXXU6Qzp1+eDwblwM+Wpsw7doK7OLp1kNgQKN8rYbSlbI7v40IbL
         ZBl9gNcgLDJPTH788wGHFecwxhojc/RIIIfeRann34A4uNPb3Wp4lNuvnSU8g6SCXnSn
         WBQpH2k3YP0Z2HHaJEWiHXFcNinV9sOsypLoDzxVgu5MQF9rBVuVW2cqLwq5o9kry66t
         yjgg4/G6S6NWRbGgFshzoLJNTjifM+ptFcJUMu5jwnOsquyo48Jdm4p7gO4etScebMN9
         Ibbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        fh=vJMkkjv7mdU2juu0dlZ8vreYY5barBv4WtVpYPKbFL8=;
        b=dciKayDomid9jwSwQjz/gxrMbiGW+uM3z3ilMaSr9Rp/Wqkm5wo1Xi8xLOwbPaLPSU
         W5PckKSYeD0L7V3iejvpX/zAsPfjoFms7lU63Z0IRlMml65iuNE5877ajOn4t5sm8Hgz
         CwvM2yerfLBsDa0JoBbZ9rie4hh3YJIzBsUf/fKp1QRhp2L5MqKtb7hNgxuRj87j4ySH
         7GhSaRM+gQwUDmpsBhIAXXC5JYygT4bBU1MihwIsjjR+B5r393OBV3jBn6lcqKr9dwoP
         IhU3WzkEKY8sNkk7ulw4sv4YkUNLbmikLSZ2sBMcMXye90zvNZ0xyCQa7XMhE/Z43ZoQ
         o0CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790031345; x=1790636145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        b=OJeJkqv7B7axYmEXWtiECQqeta71a/hgEZL6fY3puEiCAKcTtxsjavNmK66wOl56+w
         KGc7gjDzmcT0LflvobcCPHBwhzlRUq/cgyZeCckw87lCB/1rAEG0QQEf+KdIVl/RQK4o
         Aa8rpDCkIPOyqMn8oMVXV1etciKMHi9yznzmWgy+Fx+dWnHHR/WmVFJxPNX8E3z74Vwc
         E+L+ZuY6INGSgxvaXs0QJI9mQ9WVAlqNJSrxILxG2E6gJxe2MrQjX4Lr1Z6hmjPw/HQj
         0BgriAQ6Yb4cOIJZ0b6XYrIi5Keb2+kMuEj+Sne+5kKWasllk0XZ3Q2c1c739PGiJomW
         phcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031345; x=1790636145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        b=j2UOIRsLIB1SAIlcbBNvc6OZGqlxOWo2+eK7osPjubeXFYwLVPEWQj9ZEgpR6FUmKs
         F4fMzxmc+0QHpTJooMZtX0eRrGWnMGDj04pZ+JVGXsZVeavHTUemzhtUdTvl6bkDRav0
         OqtUZcWFDqJC6eV9JOCHetvkTL9tCOPHrHEWrZf9CNkFSa6ZLVGAUPNrzWMfvxT2tyjT
         ajPDnhvmoV69vlHL+v/jZHEZRgrgtvGSVgtKYDBJ+Or5jlQ1RKSfEvDgPLTgC82hxIhN
         NPrqU4g/p9aqH62AQh7MNLRP3cg8yarRbRckhG9Q/WE/4TN4HgPHT1NEveFL7+tbPm3j
         hM3A==
X-Forwarded-Encrypted: i=1; AKwUvBwt4Ke9Esku9FfIx4njGBDnwHm3iyGemXlmY8hgO+2oVvg7n0wEVCEer6dBRqkMrstZagtYyNo=@vger.kernel.org
X-Gm-Message-State: AFuF++lZgBQ60FZEoWCszaxGmFPFUBldeWyEX+yD0rIB25qyvc42d4Yt
	eQfFs40a7+5V1gl/5fPnuf5HNX9WOQs7O9W7CwR5zaMgjTp1HsXepFavBVMpAxdezn7IlAKJHQQ
	RiKoZ/cLdYgnPdtmkYs6TJOXkCvJ9e+95XyBsAe7YieR9k0qUS9OGwPj9goWrSkDXMwGvfxeawE
	ygqwWIexvOXIAPA1TdgGxJU1SzdL3IVfg626V3An0bgD8=
X-Gm-Gg: AYBFou1PtdHoeQcgtQ2sr6R0+R6Ga0d5FxzauWQ73NTaZZPFZaQECQVbgiLymNzRVs/
	tW0GaY7xs4tJIKHklFTsoId8n/w7CgJNVL0Bq1hyPuqqFyquG7l/yltqiPHC6mOE09TP+pilUFO
	NxA2AgeyjVNVn8xj717zV3jmwwqaUitws6JkLczbCajx9VnPwaHRpA7C7K6tS1J4EWZAJsL6Tmj
	Nx3hibBNzuLA7DpyVjLys+dS0JoPYOUZdxV+9KZUDl9eDj77t2d8v55uY9JFQ==
X-Received: by 2002:a05:6000:4308:b0:487:c4c:b7fc with SMTP id ffacd0b85a97d-4871e211314mr20146998f8f.4.1790031344711;
        Mon, 21 Sep 2026 15:55:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4308:b0:487:c4c:b7fc with SMTP id
 ffacd0b85a97d-4871e211314mr20146980f8f.4.1790031344377; Mon, 21 Sep 2026
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
In-Reply-To: <arG1Nh2yuMQyAdhV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2026 00:55:29 +0200
X-Gm-Features: AcwNN1VWqZQpaC_UL0aFGn2RScAhYhRmCJ5aAiPwS9zJLHLF3gP_gxg2pCi6hao
Message-ID: <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:52=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 9f5adcd26cba..e3a8e8236230 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -2501,6 +2501,7 @@ static int kvm_hvcall_signal_event(struct kvm_vcp=
u *vcpu, struct kvm_hv_hcall *h
> >  {
> >       struct kvm_hv *hv =3D to_kvm_hv(vcpu->kvm);
> >       struct eventfd_ctx *eventfd;
> > +     u64 conn_id;
> >       int ret;
>
> This doesn't apply to any branch I can find, and there is some unnecessar=
y variable
> shadowing going on here as well.
>
> The actual change looks good, but the diff is wonky.

You're right, I probably generated this from the wrong branch (or
machine). The right patch is at
https://lore.kernel.org/kvm/20260918135030.171564-2-pbonzini@redhat.com/.

(BTW, I would like to talk about memory attributes and kvm-userfault
next Wednesday... and whether those are two different things at all).

Paolo


> >       ret =3D kvm_hv_hypercall_check_params(vcpu, hc);
> > @@ -2511,14 +2512,16 @@ static int kvm_hvcall_signal_event(struct kvm_v=
cpu *vcpu, struct kvm_hv_hcall *h
> >               int ret;
> >               gpa_t gpa =3D hc->ingpa;
> >
> > -             if ((gpa & (__alignof__(hc->ingpa) - 1)) ||
> > -                 offset_in_page(gpa) + sizeof(hc->ingpa) > PAGE_SIZE)
> > +             if ((gpa & (__alignof__(conn_id) - 1)) ||
> > +                 offset_in_page(gpa) + sizeof(conn_id) > PAGE_SIZE)
> >                       return HV_STATUS_INVALID_ALIGNMENT;
> >
> >               ret =3D kvm_vcpu_read_guest(vcpu, gpa,
> > -                                       &hc->ingpa, sizeof(hc->ingpa));
> > +                                       &conn_id, sizeof(conn_id));
> >               if (ret < 0)
> >                       return HV_STATUS_INVALID_ALIGNMENT;
> > +     } else {
> > +             conn_id =3D hc->ingpa;
> >       }
> >
> >       /*
> > @@ -2526,15 +2529,15 @@ static int kvm_hvcall_signal_event(struct kvm_v=
cpu *vcpu, struct kvm_hv_hcall *h
> >        * have no use for it, and in all known usecases it is zero, so j=
ust
> >        * report lookup failure if it isn't.
> >        */
> > -     if (hc->ingpa & 0xffff00000000ULL)
> > +     if (conn_id & 0xffff00000000ULL)
> >               return HV_STATUS_INVALID_PORT_ID;
> >       /* remaining bits are reserved-zero */
> > -     if (hc->ingpa & ~KVM_HYPERV_CONN_ID_MASK)
> > +     if (conn_id & ~KVM_HYPERV_CONN_ID_MASK)
> >               return HV_STATUS_INVALID_HYPERCALL_INPUT;
> >
> >       /* the eventfd is protected by vcpu->kvm->srcu, but conn_to_evt i=
sn't */
> >       rcu_read_lock();
> > -     eventfd =3D idr_find(&hv->conn_to_evt, hc->ingpa);
> > +     eventfd =3D idr_find(&hv->conn_to_evt, conn_id);
> >       rcu_read_unlock();
> >       if (!eventfd)
> >               return HV_STATUS_INVALID_PORT_ID;
> > --
> > 2.52.0
> >
>

