Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E32DEA74
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031757; cv=pass; b=NJCc97gQRzeEwFuIsWlbEIUw3vLXZl/Jq4pi3K+w0JeGNJV2P8XN0N8bQbr98KjcZsOFI9ZexGWnEE0svoNTFkhOTlYMCa6B5cGiv1UAFVqrskitfgehsBrqsxumu8vEDKHxVW4FYPwWn9lAtk/9Hmyqo2ryRlL+LANvrBZN7Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031757; c=relaxed/simple;
	bh=8hnO3vaj19TugZkQX8EIHSZJpsMlJhW3HowugLastxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ5GM1a7LB8p3My6rNJHHOq6apXyyozFrV4jb1MLgkzavzIIyRIn5rK5IK61Ob0/lEYFxWRCjq1nkMKgNY8gTbO0E1BFF/5MB0/2RJR+lUqWYD49PQk9aSnRqTHVtCeCFbL7CDNzTYlApBjAYWkeZBTEBRLHQGZH2pwz3PN7QLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feEm7pH7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4faWWJ+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feEm7pH7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4faWWJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790031754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
	b=feEm7pH7GpjoIBi9SvrCRR2+8LOZoT2Yf5OX8HagPAZ/sd5vvJoudxrW8eqnU+TNs3vr+P
	N8Vww18shr8YQKNPaHnB50D++Wb3ul54EJad+xw/57yghUsWNqP034HKcHk9sE72AOoqqw
	kKbQwYiSzickgjAkfQPZeYFa2c2UIJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-l9u3iAQuMRuABodJFpGjRA-1; Mon, 21 Sep 2026 19:02:33 -0400
X-MC-Unique: l9u3iAQuMRuABodJFpGjRA-1
X-Mimecast-MFC-AGG-ID: l9u3iAQuMRuABodJFpGjRA_1790031752
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so22659245e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790031751; cv=none;
        d=google.com; s=arc-20260327;
        b=NR1BPDWM8PB4SLWbB8bt8wEbZMKGtEcKrQtilsyPf8vZGKE8FZBbTcjxa5kx5zeHYd
         tdMXNPAuAVUuH5mrMqSsZPRNaNjmI0F/Eb9s6RRH3DzmQBv3Ru2x4dnJ8P2rPX38HOsa
         w73G1Gl7a19BtLS19QJtBxRR1n4Qr+Txq5O5UZ5HpeufUMuNg3txvmgM5/T+YVP9WTtp
         lgvo9OzCz/GTBh9xBGy7NRCSlRgEEn7H4aseo7mSOwZE0SBtImNrLhlw1zfiswIxrUdT
         cqUkuYBFcvvW59rzX1Aftgf8eZo6p8W4psg0EDOTL6Ek8Cl6qn05vXYoJP5GTC0vfsnL
         PrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        fh=0IGhY+LJ3oFQ+la+/O7j4a9fE5NFqQglkV1cAlTJfIo=;
        b=f54/98r0i+VXQ4C2HTEoHmmMqcICkG+dt+G0tMjYqssbil96aXdyLjyuxaSFVWxZJA
         8ILzNthwLXpKWh/fWBlVH91OI+KBfeVjD+Zwl7PPptRgv697sZ8PDXXHGKZal2k4PaXU
         GrdNScu5xcOO8ROSE1kgPlBBRM86GKNUAKnS0BvsHFahZW9a1O3vqxLNbrA/pN6k+YMZ
         1Q2s6T84d8hzoG1BOdpa1h50DLK127xBfUHlg2PZKPYTet9ZGD1Ly56jswbj8xGDC/rF
         p+IU5I86LTUZN84eDgdU2TKRvfsLXb9TlYz6S1/IXFoBWNbvgKDXfBYs34Gvx7Wjtf0H
         MEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790031751; x=1790636551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        b=d4faWWJ+IYkCUpOjZib2NVmSEeakO+ZGprnHBUVPwJQakkOnPH4W/fg7/f//b6w6l9
         SqKklAb57hNoHsFXL5PreeFxVY/AuyIq0dnQKfKy8Gh90N/gjPnZrlkw64TNkc4Va2is
         be8C7P97aGYVMxnb9aqanJ5QLWn0b4gH1QQYNkDlo8MBE+iHvJ/6KHRIyKrULmpIRMuX
         xnMNMacCT/x390gfZlsDEpLshQYM1IgTeP05tCigxGl4Mkb+Ubg5UqQTZQOz375kovUF
         PZIhikVW06BSAnYtwmojUJR69d4Q7PbUEukxNnvIoms6CZ1VtR5+CoSpqGRcEEg3OLIT
         UNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031751; x=1790636551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        b=YfTsNjjuLPvu6m7eM1bgb5s9pfXJJWHgSHUG6NyY/vcuegA3RMv7yDwRYA/zpZpdZe
         ABuEYfqSJfDKUIEGIwzsG4kKz5OLAFHTFLCUZ3RXOt+j+ZWXIaPNDw+do4t3HCRvbj2J
         Bkg6QsTSIGFtafhwJs+xLW4NPS++HR/KNsuC2AUBSphkq17nCOJt+Uxbb+HeAV0J8cEP
         w+7SumC5/bGPwGq8mIAhAaub96Jvv+Vh42ESslfvm6cwWLB9Bkr1rS1fzbouVDzUM9ic
         dHq4vxXxYFaFoP0ObIdOLutah3K/jMyS6wT/Tkg+NGFywF8VKQaQr9A3Oc0tVN5UA6cy
         t/5g==
X-Forwarded-Encrypted: i=1; AKwUvByRDaaKfR8EFICkU9Jzc3U3ssExjZ/6iAH/+MMvhCd2K9foP+DnGs28Zpb0txYGMoiB46Y2tM0=@vger.kernel.org
X-Gm-Message-State: AFuF++nli3TldjwAGuwQksH3OR7wyxFkcpmICX45bZTy0W02VD6TdkGy
	g3TKdSC1Rek7T2kUdbbHI/6CCrh9EdQsicB1T5oqzoPeyx45aJuY+Cz4qv/EKvGsO4Mh0BlWYYZ
	sqIPJsPE3ApU8IIh1UzQ/SyKpAAcuWal+CE+UnLuUxMSdvRbzDMy8Bmtv8ohz04CQkIouVcqZmj
	3fcQ/qa1Uz3W1Cdnu1DfODh4rxaprSJ2jG
X-Gm-Gg: AYBFou0BmcVekb31QEcIsXVZfHRVBblkeC1qOczKNdH+YcZnpm31+Dz7q56Mf3dFiB2
	UZdhS7weD86X76pkuXYJB/X7VM92JS0lwzsMmI/zG2gOnrIpoCyGsXnWhod3Mn2W6zJXAhOII3T
	n/s6t18suw3DZxWUlIm6PvGWDw6syaW0/q42usU7t3XuUn2a5a1BDrlAiSYgK5IuwFaEByZfQ3Y
	xvpfdVCu7RXZ4dQ3TYZqF1YtklMTG6uZj8I78hlSxMxY91/CQR/q/P/Y8R7BQ==
X-Received: by 2002:a05:600c:34d2:b0:49e:6838:c813 with SMTP id 5b1f17b1804b1-49fc5865314mr133493385e9.33.1790031751776;
        Mon, 21 Sep 2026 16:02:31 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:49e:6838:c813 with SMTP id
 5b1f17b1804b1-49fc5865314mr133493135e9.33.1790031751438; Mon, 21 Sep 2026
 16:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
 <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com> <arG3L3TL5_xCBtc9@google.com>
In-Reply-To: <arG3L3TL5_xCBtc9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2026 01:02:16 +0200
X-Gm-Features: AcwNN1WSstdLw8s658Gdk9JRK-z4AglKofqztxWi96AE_NjSyXS6cZYk_BJ65RQ
Message-ID: <CABgObfZTbj7cSUdGEcA2xgGkSgFqZ2NnNrHJ7+uYAHP3_9idqg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:01=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +James
>
> On Tue, Sep 22, 2026, Paolo Bonzini wrote:
> > (BTW, I would like to talk about memory attributes and kvm-userfault
> > next Wednesday... and whether those are two different things at all).
>
> By "next" Wednesday, do you mean the 23rd or the 30th?  I want to make su=
re James
> is pulled into the discussion as he know a lot more than I do with respec=
t to
> Google's use cases for KVM Userfault.

Either is fine, of course 23rd is better if there are no other topics plann=
ed.

Paolo

