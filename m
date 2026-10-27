Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101140;
	b=cZGSM9CVV7jOuGAoKWUHgsJJdY3iIbDcJbZtbrd4bEl+b0P0GxcIqVjgq8b+gpjNZGyn
	 vj6IkYKKZXknnXsWZOk+mZySNCu/mlVtkCO63FOfTWRcGpAytw91nQAGXMWbYlF6NWvTt
	 APHtmdK+1HCMfZdsECtUhHEzBq4SzR0tlmzo5i+Kn+yqtztJ6+3s0LrzEATDZtNRDBVo1
	 ElBa/7PSrjH3D6LsZOX4yB3Fgp8liKqeJbFc4dD5PSRdhYzWVOsk2CID6URwIuwv5LcQq
	 1OZGFgKfWZSfLVJ+78QS0dGFUokg4xbd6FUYxsDpaFxSY1/+EQhzIRXWFKuqvbhdbtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=H+Atfl0mBNQeM06asehTHilVxLKDUF0di9X4yTUCxIk=;
	b=idQV+fXEU64wv3cASxqY8ITp0EY+YQP3T0Vu7I0J4I7Be/kgNHq/4cARNrIyuD5HYqNU
	 X68b06fgNh0q0rJAVRFRaovWvsJ13p1eBzEDuBxxdDbflXRoXjVmYSMTovGbJbgYN3Fc7
	 8i2JxlbmCcwvUSxT8rUEDenArIrqblzOwifKConR2lFBbSYhttrI+eNZGVZKuBa5RvziG
	 2rUaqmlB1UvhFIXJeNbArc2txpP9TlAMeGX+lk1bzFeE1ZtToxov8w2tcx2eNDbCqlzKe
	 QgAf8WAePr9iiUYWIQkXcWvh2fLBeVz7iNaeeluPo1yH3hDwug2WxqvyP5wW63ysNIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ldntUstH;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132A606F355
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B132A606F355
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ldntUstH
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f20b304c0so383625685a.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793101139; x=1793705939; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H+Atfl0mBNQeM06asehTHilVxLKDUF0di9X4yTUCxIk=;
        b=ldntUstHHW+UQFXixXG083YxYgNPdE838z80gKKbqaGiCE+NyhXhow2sD/12XHMCUA
         cuCho0QrwnMN/KRv1bEpyQEUDnThPURG++B2+tnkjHd5e8UaWrAPdtI7ovC+MIWDI5Tw
         vDE4REvTeOxeo6jwPMTgYGV54dnny0j/PZUajLkrA4vrLFlEENrvLKzl4fS31DQ1deYs
         7gUoAZibQp6kCErjCUxMrYyzZSugWrCl2RQVAJoNxyXo9Ctto2SahM1kUs2kq7z31HUn
         0V+K8YSUxOZQuwSKKWwPgjA/oRlidrZAOCab3hoFw43J2AEVRkQu/6azAg9UoUS2/DPV
         PEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101139; x=1793705939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+Atfl0mBNQeM06asehTHilVxLKDUF0di9X4yTUCxIk=;
        b=1EjYsUn033NN7eMw9nUlc/TljQOfKBcMKVnrDEp3dZtahMNZlJEG2QWJTAh6GB/FQJ
         2JkSr5Lq5QezyVlbNYWijDN6kmlLSGU2aj90RGBddgWI4wKbAxetuGBGxX8jgnJnq5wL
         QkwMl5w5XuJLisxM0QbCDgMxfedXLYMf+qp9lPHI3bpdGCzBWyS/9x4MXpnjPbXQDRtS
         o6i/RCVDXE4WLY6NLwggxaOe23Vr+zRJzQFDU0lCAw/0GcUqn509ZMeYWQwl2X1GgGSQ
         scUF4xx8yWGM/7dhHRfSE6JFGaSiqKiUAXDt5yMBpxGDgssFZ8d+fHle0jo5g6YnZLa9
         uHoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkBKbDhvos3mciJbLBRvEXdJAwG7SSahoNvKb6by1MS97sdD16dPWvxSSMFw1wwgdhd2HZZic=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZqbDAztp0nrL8+DG+7MB7lkWHxGRAkiQFsh2pHmgkV0QCL3QY
	gkwYhS8bjPhNZrNVFyx24ViBUNfQbtzCFAcsRjHoNRsrUJhQnyUoLXWwJ0MsD1ecLKQ=
X-Gm-Gg: AYBFou36CJEO2vVYqYTWGGXp1mOEyS7k396SvdO1rt9LyWPqXlP+vyDvV4LVHXTEp8E
	jJlHgu0/bk4HkiqJVJ+bLCVvnntSIyv/1/NrLQmPT6qPuMyYW6cv3w8ahwzIRIa9+Nv0KnjYFz3
	KxhSlF5oyWiXbQJ5RLLWKgQjaN2sD0Um3iP5OXCl4cKFXgNZFi8cSRuoJAPf8alQ4EyhST25uYx
	/+nbTb5KyTjrcysajIYj465Re2Y862Bf3nosOSbAKW1XbpRx8zF/4HMaLYZmppzRv33MkPiEEf0
	gKeLiMJzZcd3ciDCc1fFDL9qP1pVQJ2PHVoRqi2z6jz2SYe53qh6QKzTVAXVtOgUNiu41zpoEo3
	RbiYgrFyDwNvOQydav4mgRxUzsfW7EHeXXgAqdQUzh9q6T4LC7l0jn1Yh3fGpLIKE9SDyfY0Smk
	l+YjLDVTAlhoX+ys/UtL0Wp//+mA9APT93hTgm2KLCnK4asmf2ebzgUPpC16YAVRN15Gu48DbTo
	r+lmLZFEMrDk4ezf0hp4tuxoNp0IK4ShIlnLx83ZDPhsY/kaAWiMTyja92YunxaKUglgvQLcAec
	j+l7gWdHsGx4CZfG9Bo+Xg7vN9PB2u4Za3izdZAUU+1X+z7W
X-Received: by 2002:a05:620a:271d:b0:939:31b5:4e08 with SMTP id af79cd13be357-940ef6833d1mr1340746685a.0.1793101138749;
        Tue, 27 Oct 2026 04:38:58 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05b1adbsm951301585a.4.2026.10.27.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:38:58 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] mm: avoid losing atomic VMA flags
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <auBh08P6GPQEHPCh@gremlin>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <179306587687.1925990.13855179558376532702.b4-reply@b4>
 <auBh08P6GPQEHPCh@gremlin>
Date: Tue, 27 Oct 2026 07:38:57 -0400
Message-Id: <179310113752.664110.17071676524925981820.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 08:34 +0000, Lorenzo Stoakes (ARM) wrote:
> On Mon, Oct 26, 2026 at 09:51:16PM -0400, Gregory Price (Meta) wrote:
> > You too get to be the unwilling participant in my schlopptesting
> > experiment - but the good news is there's no issues and you win
> > tags and free self/unit tests.
> 
> Uh oh...
> 
> >
> > Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Thanks :)
> 
> >
> > Might be worth taking the VMA unit test below.
> > Selftests... maybe the non-race uffd one.
> 
> Lazy-lorenzo, but could you submit your test schloppen as a 2 patch series? I am
> behind on test-writing given the surge of fixes...

I'm collecting them for after the merge window, but it was worth getting
a visual browse :P

-- 
~Gregory

