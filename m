Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AA38F226
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257499; cv=pass; b=PuCBGuj56iIwEjuKuPX6vXvxifh1cQDGy5aYLBbKoAQRCUwnv0ePG0vUpNqDRpNt83iJqcjL2T+3LMMwJ26eLeRAjdFTzojEA6HxVygfebcXMZogO0hstcZ1mazASa7+duYzgMN3Unq/99sdW3p+8FYmBU3KiiT2GneZMMEljdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257499; c=relaxed/simple;
	bh=vlD0TW0KXHEjUkZjxNFErtOjxLeUd4BbAcVOw+5MSDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H50YiWeXwV4/omwQjdlKvmSEQT7k5DSh+fiz5rptopaCDyLcAh2nyezYSWILrkOsM03y8COk3nn60DlLwTBcfpWgKc6pASBwS6XnzgKBgYJTatBWaVucEpYDk+10OhME1MNFvhX48vpNMylS1dBctC9ilP4L16wiY6BWwsjmCIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tq9myjKe; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tq9myjKe"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso37788b3a.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785257497; cv=none;
        d=google.com; s=arc-20260327;
        b=QR93dmIspcQH5gnRXObBig5/IODPRdsS0bgP0+djwNUl9qAOo8jGegktmJrhvkhdsJ
         C2TxDcjKB+6rZ54rcioPXbAJtJwmRcZETuX1ZYXlIMlpnxUxGta01n2Nv167TKnZlK4N
         osXhPeFFtdBdLVJsKxWUZRaYKR24ztlyFGSQmU2hzPbbRZ4IGV0yNHqXeaTa5NwyUtrP
         FXiN86GJvLqPTyPEhduhQJZn2ZOFINBAMRbPUuETrdapmjVbQYjsLuEkzpNyOi6z+a4g
         cQxcza/wxsUn5g301xMzwYIcCpOnwh6ttwiXD/IBk2lKBNJiOQiB0XWK+7/41XDLh+qI
         Ws6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        fh=UoZ2mXmp5mvvVa3XHewtGNVMrorU4/st6Mpvo/rklfA=;
        b=sd0V1evzIUIkY0Ju7oMirb3RfWUSoEz2Mh3/514Z7sBaKoz64oTqBobKctjqMVGmQB
         6dLh+vbN8LVNrdB3X2BykI72jPvf4N0F27O3qjUuuAMdDWPS7Hq6FyYElLcmrLVYo3E9
         NPrSl6je9RbU18V9Vc6PlT00Mqp6torVgC55CrSip9bFR5bTbKH4wetjsEO9pPNfupw7
         zZHCDhr2b9Cl6W3AgRwiJRxWB8XYroEyIEz/xV6puCxc9DUHDy+wj4RQxu+lE46vINCi
         csiRB7D3TcfcuGkqVx53NldsI6xknTb4yg1tGwcwNfJ4fU6moJctB1qIUAOh7qlbV1E7
         kZvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785257497; x=1785862297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        b=tq9myjKec0FjmGjHXgEC+vXKu+KEZlzWYOdZm/ljvBInYotcov7trSwA2ceH/hqV1w
         Xi1A3iS6/NwJoXTLeeXkN5NrXApkAO6ymTLA5cxcwRB3M/bKipmCBesSkJvrPx/kvHHM
         FvMfhFyu6fcBOtYwqGVpJelC3UMuHCHqZwUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257497; x=1785862297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        b=RVzhHiXNPll64T6JvfblXCQFoEtQkX761NYOO3S7dhGJk94pwpCqvIpqE+780EZHpu
         Upm4NCIn8BdRa7LCjKJ4O2HyekKQ4ZVTIGGZlQMjQMDlfGWgYn9oyL6155T6JEvr0XNH
         MbbaorfVe6mEWN5Mo7/3OtDiWSavrS5Bv//CE5LYZlucPca46V+FeZySKUehRB9OMjuI
         IIhkNXlehYJ82LvK4JaO670zpx2+szOzis6qWIfhTT9TqnQxUuzPOyLxmPKiK3TE/oA6
         xlS6lddDgIDz8h83vEmcH5n17jPDENhaBcSR2dfyc6Jpbre6sH+4Po0cqN8D9osmn7Ir
         44FQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOr53XY2Da/rUa6M17jcCXtKbXdcyCBC7D/Rk8mrAd4KKEDgwVmYkVoMwc1eqW880BZyGk6gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBMmy/2SCR+z07QXgkAQd0/cEVwWqvDqXJ8GByew6d/WBD3kS
	seRfWVebtscey4azAS/gOtpcUwDIPMKyiNHVeKpBhuo6vONhGoUw0uNu/AXImPYmoE0YcZc9MKC
	lEEYrvOqY/ru+fM70cQaJ2qFkf3ketoJBDkENy+cP
X-Gm-Gg: AR+sD10XPtblIrqSHPcs2tMrc5Jq5ugezwlTVqv94JYUipOCuSgBejCpeRk077HqjqL
	YD7Bds5aoA3lBRmDoW61fkOrV6en83J8X0ngMiFRbilWLQXN6khc0nf4mfMPlC4IhGsVeSnUBdr
	TF5soi55LZdUamrGYrfhlxcK6rOt0b9fwMp8qFGJmYWQOWDm8Je7TZnCpPlH36aOkChWWAjker5
	PtA2XxAzVUg+Zr6S5udeU32htojtnOeGgiRr7zDds55+20l81P5PvWWsUw/Zhc=
X-Received: by 2002:a05:6a00:4fcc:b0:848:88e6:95d3 with SMTP id
 d2e1a72fcca58-84e933518f4mr3777982b3a.72.1785257497186; Tue, 28 Jul 2026
 09:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com> <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
 <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
In-Reply-To: <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Jul 2026 12:51:25 -0400
X-Gm-Features: AUfX_mx0A7dQcsiQj4fXgfq4gfSwDd_OPj-5fXEqK1RqmLfIYeYu_SXvtZ6RBvw
Message-ID: <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, victor@mojatatu.com, 
	security@kernel.org, stable@vger.kernel.org, 
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:03=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> > On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> Since there is already a
> >>>> synchronization point for both reader and write while acquiring the
> >>>> fastmap_lock, I'm wondering if something alike the following could w=
ork ?!?
> >>>> (completely untested!!!):
> >>>
> >>> Your approach has some holes, example misses the most dangerous part =
-
> >>> destroy(), etc
> >>> I will mull over it and see if it can be fixed to handle all the
> >>> issues. I think it's possible i just need to put time to
> >>> validate/test.
> >> I would appreciate that, thanks!
> >
> > See attached. Untested (compiles) -  addresses my destroy() concern
> > eaerlier _i think_ (unless something pops up in testing)
>
> FWIW, the changes LGTM, thanks!

Tests on all PoCs worked.
I will give Santosh and Victor a chance to test and will post the
patch tomorrow.

cheers,
jamal

> Paolo
>
