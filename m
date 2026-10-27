Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793087068;
	b=IkTtmvPjrrZ5gyVkF3nCw9UXOAglEPIXMYVJEAqlvYaBxbM0/LRzESm4MvhkuI+Hi3Lt
	 QxrVdYJVf9KeoQoy9sEFgLpQ0lZHIi4KbWBXhkLV4YvI3ooFlz+t263T22nqBWOvVPcO2
	 YaBF5EuiWN/JZkglncBSI4NSWXgOGiQhbjQqYYak8et8THxXFJsdTQZgDPOfvVOfSeAbC
	 Rx20vQvsuY/cSg+0RX1peXFN11op5uZ1Ydmrt1IJWA2F5tQipRZFqVvoLv+TMqgBEgwiS
	 Ohn6XaxR7I4TyruvTSzX3qD5B5Wa2Ee8T88uJotO0kjrCvMQytEKVMwZBOQfcaCbtGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
	b=QmSosXYdGHjDvsH0eeX4SllvSros8Hw5Z1YbaAT69r2bypnS8Vy8a7HG0guS3QIkhsRF
	 ZL4LQEeG0a5QWm9y9AvJS3Hgi45BnFuCaMPuvFhWGMth07LdLvOUYxfjLZCWk3ZPQUmWc
	 3KUNmJ4XLHuZuqEIjlWvg7gEsZSOXYDAKH7LVTAlaKnX2GKf7s25j6DYzu5rN+tlx5+sN
	 t2mEgouUyqCuEjP3dgOCDZwENvoh5mSjdN3wajCUyMQncDz0/R4hgUXRflZu2bArVMN+b
	 bQkj8KvJY/hMEu5nriB6ew9PHD1/uzuoStkbUWOWnyc4pgWUqObzZoZn5oBlC5WhFrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qJtaDY7u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D63606A32E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D63606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qJtaDY7u
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso1219518b3a.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793087067; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnSVEpB9e6IhS2grxuAsQD4Gpqx97usJ76TkSUAX1ujcZCMdN8TbGygFiNDROKZ9tt
         r3afwz6jfBs8N79W+FACRa8ajv35JhhOEA/KD2tlng6quY66RpgoolvDipO0WiXd/f7A
         SoJ1fsmv3difGOArxmCqh4M/Rne+c+GnjvmVOUSS223d3ZP07UuaBXpjb7Sdu99XG6j5
         O3McJEXTI1dXLUKsy5OG293vjEmcXI1yuh6mz08KjkfbQI5J2jAzOvNHYbL53m4y4wMZ
         OfjKLzF1VJDJuEcRZEFcP6tmHjPB35gGZEiQb9/hPV4rHaX3IdmAaJ9Q5dQ2vHEoCKol
         2eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        fh=EBME3DIJZYv98phBZqN+uwcClr5oezOfWrvymm+44CA=;
        b=j5GO6Z1U3r7tPHSu22nCu9AsNA4YxA/RM/PUueHvLJv3k6upZFBx5qqT8tyQR79VFF
         GSkZuJVFLmPpqnL2KMARUcPytmrDOMbUy/FPgVhT0hpoiR0ufnEIwDCP5J1bD7ZlZA7x
         Dh5Ibi84EsFJ6m4vsTEc4YwFfyY8PCKLlTJ9xbiBf1kECVDx7Z9TAwzvjDWfWdTZDjYs
         hiIUugpkDq8v46VBfwEcXo6fN8D3SNie455TwxG50MJw4gVu0hH+2UgxFbJTpoiMiHbo
         hD0JH2Ao4SNAGRlTV2gZlGZfGYdlBz8aTjNA5SjsWguUe8HoUY8Od4fjNBhYzVATIX+G
         xPNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087067; x=1793691867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        b=qJtaDY7uRC/Jp57961vqxucRI+RXzzW+zMjJumh4cdp7WfZ9iE+VyK9NW7VuxMGQSd
         61TLVdOaXpjCHo68NPRakgDUnx/tmIq4fAOItrVGC7kmj3loIie79w/o+vzW9cL06oJb
         h7W8hhdk/dd76WvA0ku8XY7QfLjH3XSpvrndw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087067; x=1793691867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8/PxpfNSZztMrpDfo2mhB/IeCh9GOPkH14avjuDCYE=;
        b=OLMCRNH/5Hp+/4N5ssezx5CFyr467Lh7HmfIPF5/nDFCK0L3x0rj028K1B65LWF1Sw
         7L7G3P3Exp2qM6X1o0vs5eClHKLuDnAFkHzkcVAjy0XVdN/mNgl9QMwn26c0ovYeI+68
         XQdgcyDv9eNE87RCJUAc+CHMB68zT3Cfitjnt08IZbXFylgMcogZwC9m2BU1a7tKepJD
         W1QAYHPVjSA3R9eAnE99nNeTn6tzWqkiipPSOekkyPk2UX7DTx97EW4If+PVsDTNIIgA
         1wkaW/X/qZMPMmj9pQhGKbxQ8mfkNTbuHMqPUQaJJSwe0LK1LELp4yzw0cFhH1a7wSPe
         z5ig==
X-Forwarded-Encrypted: i=1; AKwUvBwOeiPAc0Je/ZMYfD86U41gISbMqSeCuP2/PWoiTCIIK65/2eLMouAax9wshYVsGq7zfaEFA98=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEwt9370h/t8LCt3Vw7hv+LWSCKlirxhy715FZnkxRLzqjH0cI
	0PjjdXysxNFYTK7DOhk8KPe6EUXPzBfcoAUKB7geNifU64L7kvFiIH39VOOVFOZpcVfZsHqXRFY
	earWcoIRpU0ZkajcOaJEWkoO3NjdC/6rA783GGe+a
X-Gm-Gg: AYBFou36jDspdbrt6cZ/WGEksMzc1ZMYH1cfDrDfp9xfFsIFtO1vW8fALyOELgMdXWh
	QuCrJwi1RI3g8foohRBn0u5+it9kiPjBMgegsAiEL5bX+vMNtlTTuNrDtBNqstLh3Ypom84RVjT
	U4PPjUrc1Ji/roRul2+64t23kn18CzvJPeo5tAECZYyxJfrqI/sl0x5W4o/jwwyCXyF4CEsmgau
	g/oo3t2eNLn0m4Gc4JPfMPA6BSar9Okn2ycvarcY51YLB2ErlR+gfA8cLScOHnWisBUTdBrhjHK
	Aw/9Sk3/+06CsBfGmasOZlYikpF8wIeMuYM5nAZdofMZeoTMNz8er0Gtf5SrEIb2ZkaF40HLg6z
	TK3Us/NXq4TGtjgN2x9vXy/07KYHSD3eCU6jouHscGmnTdmCng5vPb9xEiiiK1lie9UM+LDaRnR
	sZfQrEXmexZi0M5KA=
X-Received: by 2002:a05:6a00:1c9f:b0:8a0:2344:c44b with SMTP id
 d2e1a72fcca58-8a369072aa0mr6446296b3a.40.1793087067623; Tue, 27 Oct 2026
 00:44:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
In-Reply-To: <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 03:44:16 -0400
X-Gm-Features: AclHuK-XU17g_8FeeLG5wHtsmEQGCourlsQaD87psYPdRxXdqk4bS7ynbQ1_6E0
Message-ID: <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > This is an AI-generated review of your patch. The human sending thi=
s
> > > > email says "Hi Jamal, passing this on for your consideration as it
> > > > seems to have got stuck somewhere."
> > >
> > > There was nothing wrong with the headers this time - so not sure what
> > > is going on. A bit frustrating.
> >
> > It is frustrating, you are the only one with these issues.
> > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> >
>
> Let me send a repost3 - will take the opportunity to pedantically fix
> the commit message (no code change).

BTW, checking i see the threading was:
     0/2 cover  (root)
       1/2      (reply to 0/2)
         2/2    (reply to 1/2)

I checked other postings that didnt have issues and it was fine. I
also found the approach
   0/2 cover  (root)
       1/2      (reply to 0/2)
        2/2    (reply to 0/2)

was fine. So not sure if it is the threading. Likely I have to make a
change to not confuse it. I am making a commit text change this time.
If you can please just apply that instead of waiting for sashiko, in
posting 1 it didnt have issues with 1/2 commit phrasing. In repost 2
it did. And i am sure if we wait for it to review again it will find
something about a code comment or who knows even code.
The pre-existing issues it complains about are what a parallel teql
patch resolves.

cheers,
jamal

cheers,
jamal
