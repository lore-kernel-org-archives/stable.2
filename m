Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1A3F8ECC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671355; cv=pass; b=CizloIGmW1WUDLsxkQpiKRTzBy/Hku6sY5pHuX8Vc2GTJlskiKDI7/9cwhs0vxs/1t3qxbzvHe9usOjMUAmAWF4zR5oGBG08RWCQMWxjfX+U81FpfxH7K81O0JrVd/RhtEF5rbnY6atQkIayLhi2bNMn21j5U/3/e5fH1L0jsnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671355; c=relaxed/simple;
	bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmbnRzpBQMtC73YFl+2aRq/XD7rH/MrtCzV34O8hCEE7CFd32dG89mXxG+nxF1NgHIxjnEYaSjaqH39YleLBioA5bo+0dpvpL3gAUln7RUWWqaZnM+yxaN4ELjocESlV+l9PHaT5ikq5bjG+cuBGQ/zlQdBUWp7i7brSnwZtzhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eEMrJF6e; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eEMrJF6e"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso2323523a12.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790671351; cv=none;
        d=google.com; s=arc-20260327;
        b=TFfeADwfBCCTiGF1E0f6Fa/6VVqLrLrBO2Mxz87Bx00teRXi2ZeLdtUwPahmPvQ7O4
         Pn5V4K3QymDilQavQDc6aL4B7XJN0bM+L2Kleq+dXbTCLcew0AMaUKoYDRrMfHTAVXeW
         7pgYL8Pqp6yNDa/PQj/+JSuNx/DVjwU9wueA/ckzcYYky21EGIP3qZ2gbre/vgSaF1Pw
         N19NBAaA1CEpmF2kSdbRxl7H779usLi/h2/98jriMieAU4cmbTPrgn9tuoBAi9L0tVdQ
         b0YS+BOg8/yodkG0J7ByMfFmnXKShZ9DhV8al8gxO51GdbHgS1cqBKkyQm/qJYAxiQun
         NEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        fh=dIYw5TPw78+w1JH1mrvgbUXN8UF45IjwHPGsWHJfh0E=;
        b=PE/rP1FJ/oKjfGRYLmxWDS+6YYPhPGGShBkaqblwz4b1naAdGYEK5li9vtbUJG7tTA
         GvXFFDfhie1IKeuqNysx8T6JKZNGj2S5TW8+sP6viNlwIV1FqISxYVz97HgHmf5JjeUj
         DK4e0R+sC23B1XI9pfftGg3E2gquzxjF1O9qhPP1NI/3oI5IdxxbxCvbOBPvAnFLu6St
         wNaCw+pPC1SEax6G7s7Fuym+ysHlUZvXCAxVbGNZ6nb6iN//Vj9x4K8tCmf30l093ism
         AmlGHrgnDrZCxU/ukik77xI+Iundra6tpTszmQtGW5S2665P+NYzJSimWB6PoetymJxn
         w2mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790671351; x=1791276151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        b=eEMrJF6eBn3mLB0JLeJrZJGysrjBDHsAXVJp2n9NxYOSwRyreWRQErMoFjrRngE8la
         LgUxmZKKxDPpZeEj14if1Z08DTwVKvIjoo+IjE751eUyjSDHoCBUcz28T+1klfd6P+iM
         9Q6ebo3HtK4YfzmyedUpVUe1BwXzO8CT/IMfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671351; x=1791276151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq7rlocm9HRXN1IEydAK9bOdaq/peVOU2getKJLN7Kw=;
        b=2oB8IotEPsQv/Lf/Y/Bx+8hW+1OskGZdcptFjzhTutHjCqq/m6AjE1gq9HnG7nBlUU
         rTFJX6KCHUCjNGUwRQ+2SAO2pGhsdNZpJFP6XNRZ9ydrEgCRc+WQA7kTNuk/IeRsdmbZ
         HBCScWLBjbgGsrAaxcDlRrmOzSnssktKm/OjALyaprBj7TLmfkOW+LB4gBl8ye6SA2ge
         FgvJxhiP1bAcnysLr4H56uOeSUy4/1M/nAuGG247dwwK+ymrUFTVI7e0D2lqCPSDA+Dr
         2TnCPi8n1aig6U8+ztFd81vzP7hdYK1YXNOJ7RM70rsfVj8EC5GHOxeiuFBxF28kZLdY
         G7tw==
X-Forwarded-Encrypted: i=1; AKwUvBzCW6CyY//bidxCRKZvWXhlA6ckQOuI65lysr0IdP4yPSUc+DouC2rdJheCZQSUgqO+E1DTh9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nl+pUXfKWHDUNDyIQBoQkjJUvKG8JXaLItq4Z8xM0vU6znIjfz
	YMeZB9tZX2l2OVD3ha2hEEH3UZTTzr/h0+o/Fu9Su3nxEDQxBCIkCDsVQX3G9PV0lb6slSXWzor
	7NuTswhWUvEEoWV41CBoK7XCPtzL5177K6lL5o/j9
X-Gm-Gg: AYBFou0ri9FeNzWSnd9VqdOhgxQ+xRx/sSyIKhhDYkgnthGitHY1VpJVwpCrQdisC7M
	+U7Eu7WPY9AaE6gG3TgF/FLinE+AEzDFD1FSuE7rG+2cVUnqj0r0VT5N2fHfa7AB/QVafjzeWa2
	DYAbd1YkNbOz5/LdYMxHEXE0tY+K43DlrylR2Vv4gp+q4iGhf7rP6GrXJLHKuB6MgYmTNplvPmG
	+g1TOIPqh1GMcjBfAWOOk1UrhVTP9lrrO6rv7qlbPiaSiPDB+4MTF3ezPiFqWrmX/tDtCYrJN4O
	7zqttY9sSG9mqJS3kUklhohK+CQR5h/2gCCTdt06C2uA9FG82ya+/NnITCdd9/JGcRpw+lGzd3p
	LpJCuJVjswUotch75BIYVsOHI9hkJD8cB2A==
X-Received: by 2002:a05:6a21:e44b:b0:3de:48ca:c565 with SMTP id
 adf61e73a8af0-3de48cacb7dmr5733871637.35.1790671351647; Tue, 29 Sep 2026
 01:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com> <20260925171834.73b5b367@kernel.org>
 <CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com> <20260928174738.139f1365@kernel.org>
In-Reply-To: <20260928174738.139f1365@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 29 Sep 2026 04:42:19 -0400
X-Gm-Features: AclHuK9fNJKv-Iie2v3MeKnPc47Kd4hGdm_wSNDWT2mtNgLBv9kBpPijpby1J_Y
Message-ID: <CAM0EoMnqa-K+jR9S7Y7o6PpEnQubOPWqqkxB9qVsTBhHPb5qAg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 26 Sep 2026 05:49:57 -0400 Jamal Hadi Salim wrote:
> > On Fri, Sep 25, 2026 at 8:18=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yiel=
ding
> > Back-end Review & Insight System <hybris@mojatatu.com> wrote:
> > >
> > > On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote:
> > > > Tested-by: hybris <hybris@mojatatu.ai>
> > >
> > > Please stop adding these tags, they tell us absolutely nothing.
> >
> > This says that our _automated_ bot tested and it adds the tag before
> > we send the patch.
> > It does more than tdc for a specific patch set (e.g., PoCs for code
> > paths not reachable via tdc) and it does find issues sometimes before
> > we send out.
>
> My main point is what I said - it tells us nothing upstream.
> It's like a gerrit change-id tag, internal to mojatatu.
>

Fair enough. The idea was to provide confidence that what we post is
going through some serious testing.
A couple of times in this flood something slipped through that missed
a subtle test (which resulted in a Vx) which this bot doesnt miss.
So implicitly i suppose it means if we dont say "tested-by" it means
we hae tested it?

> > If a human had done the same, wouldn't the protocol be for us to add th=
is tag?
>
> LLM !=3D human.

Well.. this specific bot is mostly muscle (scripts) than brain. But
let's see how long that " LLM !=3D human" inequality lasts ;->

cheers,
jamal
