Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771172;
	b=W7oVAIcn0t3/Rg4mi/naGad9R9DcMqtsH6qmO12EY2VWs0gBWLBoB7xksiaWLsnVcUp/
	 lcs8bgbRkqPI29Ahc4zTDs+SVvwaUwdyTKnJkvIzI1QKI6UlveR+fVoGtZTtf96ATK1Ad
	 mmL4H/H8o0aSoUVLL9R0RJ5XB4SSwcZj3hOrANfRFBZiBldGn+iImQSF3rEdpXCmRH32B
	 +RS5EScOWYJCwVbrTsb27uY3FgqDcHL6W9KrIySz8npbv8dFZDMXtUtSynWKCz7FmITm4
	 dXa+rZs0TYoZwwdY4frXCk169XXrrVBYlQIhvTNg6SLeQKrJL/616evfQtunP+678Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kSMelPUMbambLzstY6Q1ODhfgtsWJixz60QR47Gg/40=;
	b=qgpfSJK6TMqXgCPFEz61MlCEDqthr2NeYUCT63yzAzqdReXtMFbfeCDV09w6W4CWRQdN
	 PLesV3C0c32HlOOk/G5JuN8NC61Z4656M0lhw55EoZ8D1hTN4kYMW2Dlk2LY00mzF/k4T
	 bzn2hBpxudQ/r2H8TGzwep5AtTnS2PbllulC4P0xtTUBLqR3i0YB75+s/hNJ6vR8sdiPM
	 iRUveoKKfcBYztaBsvScVBDz9l/fdti4u9q3/gtVb3YiIZkzDPZ6XLea4nGKW+daGMMBr
	 lSrp+j1sWIiBDgBXkud47QnEAqxakmUFWhE0hTUl/Au5yqQgh53GpiFX0XVz4iPPg6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ckUE74cH;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51B606D813
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 05:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B51B606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ckUE74cH
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so229704e87.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 21:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793771170; x=1794375970; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSMelPUMbambLzstY6Q1ODhfgtsWJixz60QR47Gg/40=;
        b=ckUE74cHtN9SHEa9x67BM+Uaop3PrV9Y6x2SUDlsyvYcp8qipXIRSmoSVd8X1xxTGD
         cOFnHuJdcBLOFsEmkVwJwdyjggISvaeaaD47/kqbc/6B0Qx9SbQQp+1oqi3fcLV3lQH6
         oYJ8jwPh5bFpCmJ4QAzdvlshf5hSb/8T3Ms5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793771170; x=1794375970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kSMelPUMbambLzstY6Q1ODhfgtsWJixz60QR47Gg/40=;
        b=CxsGQNB+AAwPN8V1Dxq1Ll27U6Yf0iEp5CE4Ez/GQPmAtGYRSm9u7jMdklxCarDEOU
         T5Lg2aHKgAOI8BiinVewzrvvHARGwyT7kwguWqd9111JfzIh96a30OJxJ3dZle5ixGhJ
         lk5zMlKL367yZWBEfP2lLdNklrMUi9EfybGLW3/1NxhVtDi7DTDzIW48UPLwL5R546F/
         Xou1uVuAeqDgu1MYnMnPLux3Femfod7kZEtIYdCDZvhM7fN+qrm2gbC50/LqtPhzDEYZ
         eY8az7r+mKNZG1ipBWxe8Q6yGo0ZzwQj6NyndKzO1KQlHHngjN/qt135kSKhVPFbJd7c
         7Kfw==
X-Forwarded-Encrypted: i=1; AKwUvBxPXaBgg1WVf7Y4t27h/Mu4Mw37NWqInfmAk/9QCCNud1VGBTNDIO9qHS2f27xbYQG0p1PD/Kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RIVZv1I1W896XqzLSgPrMXworCHDn2Fkf6JMnlxdkxGhwez0Q
	Q0DnRTit2/U/HohvxeCgh/HoiHrRlLZAravxRq3LFTfmE2UMifOjHnJKw/CDCRG7TOsvANEyE0C
	BzXdXN6wz0A==
X-Gm-Gg: AYBFou3U0D4f2563QJ6O4tul8qLF1gBrehCXO2vXxVDBpvcB69LKF2vS+ko01ugHhRU
	ddIhCYVachJwOsEaERiPFNDW9MQ4q0bJywFib6O1uZfVP45ubdae4BKl2P1/cGMHF0zfDa3T4sa
	gqCjuceMUwOHXQPl/Lq78nt3Bwu/yBILM1BCJC9i2JAGkU05U922XrrP/KtWXNzXqzblUf66ElI
	IiXs/BM2mFRtl3uGPYgfrRehynnVFjPirQ8xjLnNW2iuB6OXKgjFSQkVav5CaQFvW0jGdlez+w6
	P089UnnFIfVWJg8fXkgMQmVP9NeV1Pvb6FklDg3vq1dlNLu3dpfutVlaL+JvXopg8DlAiWUQI1g
	ag8EIvEIokRNGSrnaqFI9aqKrT9xDryw9PLKO7Y9uiP8M2ib1FABM8qpc7xQe6lGUwDf8VNm9ch
	buamwGUlkE6e8uiBwNwWpwoOw/hykLZ460Wz9hbLmgJESbjl/g9LwCHa4D/r5AJNwez67alDzRc
	cXluUxsWEsRQm4O4Ww0SrDq2oeDZPvU2+xnfnELj4EhTSm/YGjTVIujESw8m2YG7I5KxtJim2Cy
	cmr8OQi55RbjvWGxONTPGLXd1wMIBxPjQ7sCpwb8zROxTDppQsfoSHisDj28Jm4WE/nhiuz4zzj
	73yPd7zCT6ctWFnkFUhZuruA=
X-Received: by 2002:a05:6512:3e03:b0:5be:414b:a848 with SMTP id 2adb3069b0e04-5bfd958473cmr5207572e87.65.1793771169709;
        Tue, 03 Nov 2026 21:46:09 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff6322f5bsm104926e87.47.2026.11.03.21.46.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 21:46:09 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bccecba199so230032e87.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 21:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxH6oSTdszojPK7r7WkcIgBVGR7KOzv/D5RuwDsxTP3gpy819MhfpxpQqm30JqNRRjj1ieKteE=@vger.kernel.org
X-Received: by 2002:a17:906:9c02:b0:c4d:f63:642 with SMTP id
 a640c23a62f3a-c4d0f63079amr48032066b.33.1793770759887; Tue, 03 Nov 2026
 21:39:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154218.1668182-1-liam@infradead.org> <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au> <auMbCuecFeRmBFSK@pc636>
 <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
 <urkgmijyytg3rrislm5fdzmfggqavzpiry23f6lpkqonvy2tqx@d56stj3eixfa>
 <auaFhOa5EBz4gJwK@gondor.apana.org.au> <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au> <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
In-Reply-To: <aurAxRpCwzeyXeVj@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Nov 2026 21:39:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
X-Gm-Features: AclHuK8dMub4vC2TPpv6BcEahTt6-eYYmVZ48SoCIOo5V1xGWkBIA_qqXcqQYc8
Message-ID: <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Liam R. Howlett (Google)" <liam@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Chris Mason <mason@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 21:21, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Nov 03, 2026 at 08:28:36PM -0800, Linus Torvalds wrote:
> >
> > Sadly, the commit you point to doesn't talk about *why* that
> > braindamage was done. Looking at the original thread it seems like it
> > was for kmsan.
>
> Here is the link to the whole series that was applied (v4):

None of that says why.  It only repeats what I already said: it seems
to be due to kmsan doing bad things.

              Linus
