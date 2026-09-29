Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47943DCD96
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670220; cv=pass; b=r8lR9yxBox3pX+by7uPnpUqovxiH3C0q5/96xhuD18i+XWT+wO6Z6m0PDuYlKfPA26Dn2udpRPWBOQxOTY45C5Q5DX7S5fDwz7luEJ+1uF4OFvSXSL78FNAn+uCkceKhe7eMcUM91HgFt5C6XqHbxJl6n3LImHsdIpRhtXO1Dbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670220; c=relaxed/simple;
	bh=Bk+aDP7Fo6BLFnfF0mkl/u5hMpwIT56K5DBxKBjeA+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaNmd5XKKhRrTcdgUqmS4i2jCQC4Qf/p8nDyc3b+TiJjrlPeyTIMsOs0wEWfL5gRv4bNXkUXX4fDBAyevnIgKzcFDbdrV1A0q0IKXWTf0oL09Xt1RYn81S4uL0jFheYlMv6qF1EhaQn1EMoj8hkx+nGi7Per/86nsxoNndVfGLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptOOUjPl; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptOOUjPl"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso6833083a12.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790670217; cv=none;
        d=google.com; s=arc-20260327;
        b=O86s9n+hxN33gazeWGrGO4GO1P9GpK/CmaW07QJgNlTAf5MMVTmnm+Ov1DlvtjV6lt
         A4JzTuJoblIb+i8kQjnLlvKEPuk5xg6HR8fexGMMkLrKTdrb+3j8210wN0V9VCenV5r/
         8FD0LzxSUoyPMxa0PUHvnr2fiXUrHIsfS44qHduuqYtCibPsHTTF4TD1CT0KjFEQLS1l
         VuKGjIuV8FA79vkmxqLiVAZKxBh/e1TuUUQwu8pMLoinLW8kYuivjEkXtR0Bv82k5Oz5
         4q89n+elEcvUeEmMXJbW6oJbctp76oEoec/nmEXT54C75aPyChLoPL8RNL+CD1kh785R
         bFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        fh=VQ+i8MdFEiq6JktPGyBmRkd1OcysIJkR0cY77vVQDU8=;
        b=LY2i83mfEUtrrozANHfGyVvUoYvtu3Wr0xlNB+vOV0XDgw4mafvkpqkBxD/A5p4JcI
         MEMKaib3HOD+ay1kQM1UdOj38IlEPiwfspXpuTdxtTYFo7S5H1S8tGjZOLBwO4SL73Ts
         H4PO8Go7ra8PoiNrfkCTfGSxR1BtkCkh+8fSElRGNOPhinICuJjluwad2hDIjnXgRWc9
         e6JBcJe2y7cCwDm12KxU1aF/PRlFviNhQem1ytcLsGiZbZ2AWp2lrhR69h9sVEo6waoh
         SX5U5W+r4+vsb23/w3VC8f50yMp1zxEqBKen6FaUjYKJBnWGwLiYf6VXiifrdKREl+oc
         qMuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790670217; x=1791275017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        b=ptOOUjPlL+RS3tKUM7QTODf5FGFIgxXCO/zzgYXcYjaiMVz8J1A3zIWXUK23O//ZoU
         EW61h7LlY1kqHxJ3EJYC3AVOTr/+v73lNMKYE+qxowVN0ynN/4LlDT25XzZwCThYabXF
         kqR/EK5GE1s3DIOETLl7nKKfiWsK3VKLB29dHMs5ZJRplBrAXr1u1SaXRVBoKNWUhLDe
         MPu+LL/K8OU/VFMwBqG6u1253AnOIO4OOZ9B9jTEYvZuJmX8QHZyVm4gs9Dd80R+HbxH
         Mj8gOx99P78vj3T+ffndKbGnqJWFTmQL9PzZ66sgEkSQWWNzl2lNDH0J2xCXIuYizwwa
         UGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670217; x=1791275017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        b=LwhW6rjAWh0cZedGLuOr+OeeD9O5rfpDN9AN9hoWCGQAbKLZ1RIzTq23+PVgW4Z50/
         NO6fixThmyH0To1MCl5v/WGRPItiLSnRdvtYBCuHmS7u3Yf4PKTihmb3SHVjMLboEXkU
         jIp6p9Ro/QwZw1bhKpQgASV6JXon7Q9EtM06gjDWunSsUoRuu0IsN4+jwGRousVz7SMu
         rbTjCNwCGnvLWPTNu8CHcLbLScKp0wHjWlxBNqN/mxn4aDjbg7Hz3Rha8DLCXf1MY38H
         mXB8ufWdPTVlIjRz+Jr4D5Jp2ozSzKqUsFbO0IKatUPs4kDbH5ikEeBVPAawMhX7jFO4
         AGSA==
X-Forwarded-Encrypted: i=1; AKwUvByKWAyVYn+P5L1YJDbZcWgxVi9mUqFSvxpir7hmbAW3hEj1mfn2+fFNa966SjLL6RcOH1aPsrw=@vger.kernel.org
X-Gm-Message-State: AFuF++nvhrMAz8r33XaDRUXQb1tvRVqStGavaSi9Og/OHt5RSDcILnag
	gBAYHv3W0tmKVgxOnSZX+gAecyhmIo3LoZisJSX8GEX0VSiUcMUS5Obzl1eBXtyYcZ17wbEJq4Z
	lIrcRngRo0xeRSMTYh609qerMZiNXqt8=
X-Gm-Gg: AYBFou3g7/8DVz5ywETuqAdtUTw8gGKFE/d5fTxoIPKGWPm/t8b0RQ2p8BbiD4ZEIJh
	L6yj1l0PLWkLU0K7O2PUVfv5WleefJWVWmrCDq19lwTGydwKUYqg9V8MJnv4l2OpOzOT5OhL7nU
	Ib2rU1/ghUUfIbfBOgPNoEppmeHSPXgQPyQDTa24guIfOhh0XPDW+JHjQqDAmDq3qxreVqHYdHO
	yniqVUtQa/xO7UjtDgU7U6KT3/xqLe7AMuD5VXqkMm6rRE/iMlGtMxK7/kxsrzKF0iwA639CYex
	UVlivCGs/uJ5BbmB79Q3aBUqmrRrnScbd0WwVziksyeQDNbbEp5qgMUw6A==
X-Received: by 2002:a17:907:7b8c:b0:c2d:c33d:a9cd with SMTP id
 a640c23a62f3a-c2dc33dad54mr618259366b.4.1790670216558; Tue, 29 Sep 2026
 01:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790561983.git.zhoubinbin@loongson.cn> <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com> <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com> <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
 <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
In-Reply-To: <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 29 Sep 2026 16:23:24 +0800
X-Gm-Features: AclHuK88BsaqlI4K2ocbd-PK2C68a5LcpD95joZ3dWjYgjyNNn2FFfvJo1d4Dpk
Message-ID: <CAMpQs4JvLOUv3o8tktg-EOT85KCunY9gJhgxQVkZEXPH_C+4EQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

On Tue, Sep 29, 2026 at 1:46=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 9/29/26 05:06, Binbin Zhou wrote:
> > Hi Daniel:
>
> [ ... ]
>
> >>>> Please make a less cumbersome and implicit checks here. For example
> >>>> count the number of sensors and then do the check against.
> >>>
> >>> I thought about it, and you're right=E2=80=94I made the logic here to=
o complicated.
> >>> Let's use `sensor_count` as the counter. Is the following check logic=
 clearer?
> >>>
> >>>           u32 sensor_count =3D 0;
> >>>
> >>>           for (unsigned int i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_=
NUM; i++) {
> >>>                   tzd =3D devm_thermal_of_zone_register(dev, i, data,
> >>> data->chip_data->thermal_ops);
> >>>                   if (IS_ERR(tzd)) {
> >>>                           if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >>>                                   continue;
> >>>
> >>>                           return dev_err_probe(dev, PTR_ERR(tzd),
> >>>                                                "failed to register se=
nsor %d", i);
> >>>                   }
> >>>
> >>>                   sensor_count++;
> >>
> >> If I'm not mistaken in the previous version, the loop exits at the fir=
st
> >> registered sensor
> >>
> >>          if (!IS_ERR(tzd))
> >>                  break;
> >>
> >> Here all the available sensors are registered
> >
> > The name `sensor_count` might be a bit misleading, but here the loop
> > exits after the first success:
> >
> >                  sensor_count++;
> >                  break;
> >
> > Let=E2=80=99s rename it:
>
> Can you clarify why only the first sensor found stops the thermal zones
> registration ?

This section of code is based on the original version by zhuyinbo; I
noticed that you=E2=80=99ve had related discussions about it before[1][2].

I=E2=80=99ve reviewed all Loongson-2K CPUs that support thermal monitoring,
and they all have only one temperature sensor, with =E2=80=9CSEL=E2=80=9D s=
et to 0.

As I understand it, given the current situation, the loop here doesn=E2=80=
=99t
seem necessary=E2=80=94physically, there is only one temperature sensor (ev=
en
though its SEL value might theoretically be non-zero).
`LOONGSON2_MAX_SENSOR_SEL_NUM` does not accurately reflect the number
of temperature sensors; it is merely an interrupt input selection, so
using it here does not seem entirely appropriate.

Therefore, I believe treating the Loongson-2K thermal driver as a
single thermal sensor better aligns with the current hardware
behavior.

Just use:
         devm_thermal_of_zone_register(dev, 0, data, thermal_ops);

[1]: https://lore.kernel.org/all/ac5b3982-a658-e05b-1b5c-3aeeda1585ed@loong=
son.cn/
[2]: https://lore.kernel.org/all/8ca44091-35fd-cc24-9896-0317772c5620@loong=
son.cn/

--=20
Thanks.
Binbin
