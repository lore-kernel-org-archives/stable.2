Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E02248A0
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601608; cv=fail; b=SfoauxCz3JlTVQoXFeb6yRl9H5FrZnTy36ZiX3KqW55tVHMp8icQ/QnYODVehA8e5av414DFXZU0kfUySZBjUep97afct4DiDfQs5SifBRpJMDM6+kaET59ItrvIrvrmUFlyFTSjDFXz4GhmAS/RJJeTOdgbtJocWH3FQatZ080=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601608; c=relaxed/simple;
	bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+prpsowyax5qcrWAZqQqgMLvhHAenWw1Edow3qrFaGII2al+j2MREbfqBpk/kwDEQRTeCpvF71Rc9HM7olq/iMLGMJ2e3VKpE7MYRDvzsO5xfSHLj36ftqdc0PeNornLaoeES//XVGOAZj4TAe5Kq3djC1/1AoJM+liI3oxwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=kyCh0JXP; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=L8B4qYgx; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="kyCh0JXP";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="L8B4qYgx"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1whoFp-0000000BVfx-2GcA
 	for stable@vger.kernel.org;
 	Thu, 09 Jul 2026 08:53:26 -0400
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b015ed1b78so442990e87.3
         for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783601605; cv=none;
         d=google.com; s=arc-20260327;
         b=jTofCkkB0XhC3n/SyM+D7JNI3ozuOPRFqjSLk75Z7djpDXGKetnS3iUMyc4rZqaQvI
          bY1uEfEh1CW3tzbrDcPiYPVh0sdTgWm8SkgH1bktuMCVFU/tte6LuZtPcTsJ3D1VKAti
          c4GK/mPxZ1/IYKU50ET5I5i1lsseHtfFOM/1EKPzIPS2UdgoM6X5Pk3EtZGlHLDVE5NT
          Qj1MOxytS8jBs+f+9a4Y++AKzbWDz1Ib1DvWMF5ZPQ8kiUXlkDIJyZxCm9hUlpiQfFB+
          rOsVXKE7zr4OuYlk5pFW5OAWTudmDZaDde0teZIp6VNqKSof7Ppe5Pf2TaO/tr3NjPGo
          cWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         fh=BeSPVBQTQBOrRNXvVn4ihR37apMnd11Ns++hyZbaFkk=;
         b=noc58yATbWSIpWsu5loJuafYQQPSJyT3on+RSjTrl5mF1Xo2ky2y3ntNgK+3UYl+6L
          L32U0RVu7L7NpTFBasNYlVVi+re1QfucyjyQnrsoAiy15UgskDCBYbKkBos+q0YMV6fn
          UUEtxZS7r0OmLdmaIZc5tuk1awBCwAikhO/yX8+vNMKsB9qrSohED+QGrpgUHYNkcX/J
          0zFRTno9AW1Zjf9YAsNv/OVQ6I6Yu8Di7wwowAHXasolvjC4ZYllpFJKd0SeSWyfJOnz
          j7P6jlQFo3yaDEKqMxSeElzHSxuxxcRff+zMy7GUv/Rmtxnsd/oTBXGK0En6rlBKqGiA
          Lndw==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1783601605; x=1784206405; darn=vger.kernel.org;
         h=content-transfer-encoding:content-type:cc:to:subject:message-id
          :date:from:in-reply-to:references:mime-version:from:to:cc:subject
          :date:message-id:reply-to:content-type;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         b=kyCh0JXPnAHGu/jzJbtCSxwBz7DTlc45gQiBL49XjCVFn2rlrR1lQd5FzoP0b4BMeB
          SXyeQNW91DvTi9b+IHvf1a/SPJ7n4X0m+k2IC/tx1GlLXtg9WO2Si1sSpwVM0pBEc1IW
          q/DbGxZHIWXWkHAHcmJucuKdSBEUVEfCLQVI4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783601606;
  bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=L8B4qYgx/650Ad0m94x+Rcj2z/H2Kfyj6P2kl+b6SzjNWCtK2t+pDTKCgWwChdb/H
  RV4QL3tWySnXSUzw/Ehox9UQ0jbf4zHzCtPz+KP4zJpqSA2ecPTJBqzE17/mrwGK7v
  VHfHpIBGSmEX8DNOVAQMzVX0aQmqlwLw+ONA6TcQUK9M06tOq4I7Iq6WUMLRjgXJxF
  TjZboAl0DlkQxSVjH169u3unDoqYycPFzW7CPrSLKdvZ7wTLZAxJWyjEHo4ZF4XIgc
  OCueJ2rMrvDdEArS+rzbLeGR62n7vE+9bpdYMV9A970qq8kF6Q6XPaBTunxjvYuQWw
  fqKcG9JEIFDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1783601605; x=1784206405;
         h=content-transfer-encoding:content-type:cc:to:subject:message-id
          :date:from:in-reply-to:references:mime-version:x-gm-gg
          :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
          :content-type;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         b=qEVb3Wdola/XPgfl9ri7kjCizUArvGASaKduEXQ9OMedUgBKHVwmH759eVHgZPsK+X
          T4KYF249DonPAThUYFBPe6VxbDvna5J2tHN07MI+3ilomQWBbSiUBifvPWrsKSjpDaDD
          70lBGCCRfooFiWt6Uensjru48xETFL/8jFsU1ys08qshFdpK+2ZUoz/dvjVeGf0udqn2
          fnH7Wg8e4pqUGLdFhWZDzrZ2T5brRCyu10o6xSp7LeUsNFO6j0RVsE2qNfJI08x9/fZ8
          fStJ+832ljK3HGUV3Q1anx28AcQOnY5yJv+n5gzzhlKPoZORLdYGo8jk2gK1L3/szZHu
          V8xQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri/kHA4x0Fv0rUNNjHZMgFe+tVApjWVjp2EBXNN8QJC9IM1vrk2YGwPHk8BU6HMRwMAlp2LGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPovajQASlgL0pHLx+BulK0Ffu05GyMKtXamTxg1fr+CbZLAF
 	XJeiDuwBpKJMs9q2dMiEKn30TO95uN464uMGCqfM2NaN9jESaevEaBJWqgjG5dnn438CUYQ8bYr
 	uoDdDEdDfG242LOwjO1WsZiA7MT2dcuyubwMShzua2Pk7EWhe2rcsdmv+S5XeyZskjTBgFaVF6j
 	8uZINSBt/RuMMfTYszsA1R4/S2XV0j8ag=
X-Gm-Gg: AfdE7ckzOFewghbzMmd0QaoQi25A7K8l8E8j2Ovhb6d8QnM0LfB5yq3GYWiDo4IGpbI
 	nzB+alvp1RwfpiCIGmS32smG8jywHATMrEwUFVjAp9t7kOpmZJmkPc4JUtNzPPSOkKMKU1ASJ6M
 	Y37MyNokmyg9NyqK13r1vOPVY7QQkCLAFjt+RIQQeSPekLnmR8istNLe2iRL+iJoSW9kY=
X-Received: by 2002:a05:6512:4384:b0:5b0:14a5:372e with SMTP id 2adb3069b0e04-5b014a53b08mr833268e87.27.1783601604993;
         Thu, 09 Jul 2026 05:53:24 -0700 (PDT)
X-Received: by 2002:a05:6512:4384:b0:5b0:14a5:372e with SMTP id
  2adb3069b0e04-5b014a53b08mr833263e87.27.1783601604634; Thu, 09 Jul 2026
  05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702165409.164568-1-pfalcato@suse.de> <akhYu66GmjyM8l6a@casper.infradead.org>
  <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com> <ak5g9h3FuVn3bZ1G@pedro-suse>
In-Reply-To: <ak5g9h3FuVn3bZ1G@pedro-suse>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Thu, 9 Jul 2026 08:52:47 -0400
X-Gm-Features: AUfX_myfsaz2CNj6SYVdToPKTm3sV3q-2qQKmWB5EgGOqp9HxGlKza-X6yxVsEA
Message-ID: <CAFN_u7ExSnVo=QQBuZvRJkLR3rHo8qN96rDKYu+KNiSjk0FCHQ@mail.gmail.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
 	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
 	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
 	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack thanks for the update and all of your help with this!
Obrigado pra vc (Meu esposa e Brasileira e achei que vc estava
Portugues da sua nome/sobrenome)!

On Wed, Jul 8, 2026 at 10:40=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Wed, Jul 08, 2026 at 10:05:43AM -0400, Gregg Leventhal wrote:
> > Hi there, just checking on the next steps here.
> >
> > @Pedro Falcato Are you currently working on this patch (mentioned
> > above, re: holding invalidate lock), or are we perhaps stalled on
> > something?
>
> I was waiting for some actual tags from people, but given the comments an=
d
> no tags, I'll respin a v2 before sending to Greg KH.
>
> --
> Pedro
