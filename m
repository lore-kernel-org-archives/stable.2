Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B651309DB1
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473491; cv=pass; b=VizFz0rNrXUUQ6/TidyIv5vVFssuYHp6bqUsxPoFsJePzIj3HBzRhGiCOPCMxjjA9dbWblhpgOdORazF0BIYR/alugR17DjyCeBHf7OqO+2Sn7cw9/9q4YafiJvJhn54erxBT+Q3N11cGDdoiI3oB8VkiQ56YRtUmdVA/G0oGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473491; c=relaxed/simple;
	bh=jfp4pi7JkIVByO98dvYjehm+TU1kIF7zgpppWrfUyxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJqH88CscbGfs0Qcw8HAtRS898zwNQXyZVF8Ks30HF9iaSIv5WupoRDZpcpOJGHc4xVX4nWLua8Y1ILs/AR6T3lcp9OPAwWbrsgSEFTJ7tYHo2KSvS3yG2va5vb6rzVC4S8kHWcMh81ZErByOJ97Iv8qF0EgGywTVHBfN/wKoeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwCBF7c0; arc=pass smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwCBF7c0"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-9159da9bba5so194986785a.1
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 14:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781473489; cv=none;
        d=google.com; s=arc-20240605;
        b=Zsu4F/xAbCPkS0ly8BRlljxLoIEB0xx7vnnzM5qz4RYmmjK23v1cvvwcihb0lA/42N
         izZyThuwQXAb2NHM3kAs3QnOpUiUqGh/wKb+Lh1CXD6I6m08U18enY8MYUH5Jg5p2TrO
         JJt2ccuMCFqzGz1VsvdTGHX/gZBEDQM+M3jRYsxZKBY4MBKjJ9Ks3iyu6CGabNbKm6vo
         ltTsUXt27BCjElzD11S1JWjv0oASsDOO9keTZi8lw4bieSdPE8vw2QpUvkUIedr5XEsc
         3VJVHEMJWW2JooBnOQ7W660x2I5uwGezPAfLI+v9E+TcLFvdoGDEFKpKIznI0kcWvj5e
         eruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfp4pi7JkIVByO98dvYjehm+TU1kIF7zgpppWrfUyxM=;
        fh=9SSuGReYqEvm8VD6jgslDbjNrluKLVR4YliuWlgrd/k=;
        b=bAl9WkVY9rghn6otEb5/3EsNL/dlG0qT8yDxwGunSVSoiTRmdYFrRWJvVOeXTlNTxF
         s6KsU+o52U8KSPIDSGjoW0HtCMFAvH5oNOveEPlFdI0GfRm0mKSyB41pJb3MrfesRIA+
         5NiKvdM/bJalwqE/W0Pt8IwWnQhNrrAS8BhjpuJdXEjRPATvH/ifHLOmlF/r2Zo7X9KC
         zxGt5+PAtNqOYX0pyIeQ53pGGIyUqJjyOIBIFdCGAR6j766QDdIptqXobyH9aplFYrf+
         iRkKyZFUYw3zC+rBL4wMMD0MLcj/kw9aT+s7uSfdv2tflvVLQU0NgMEy9gUm+M8fv+1m
         aAIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781473489; x=1782078289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfp4pi7JkIVByO98dvYjehm+TU1kIF7zgpppWrfUyxM=;
        b=BwCBF7c0/7CC8rdHTkYFVdi7PsIyGiXw/jihTrefeEl3bFWBn1rADZzRZiMj37FhMp
         p8FBMDSQS0fDA+DGyPD/t525B0yGcYtv5lCqd71ERukaAQyEKe9HZGivla9RUuynwPz5
         xllkRyv7jRTMfbEy9yqzFvahQKvTgd25ex9M4BwyX4utd2fSu/OKg8657dRC/5DTKde6
         hGGEObzdy0JArnvr3mMKMsy3uLHKIZ3/YOoe4aQfzIT0x03n99nA/fmqXC2Xv1PzRWSu
         q35qmspGvUDNp5GsDDC+KI1D8CG/FCF8PzEBNr+8X/tthpkyo+XZjv3HEacpH0piSjSB
         tt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781473489; x=1782078289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfp4pi7JkIVByO98dvYjehm+TU1kIF7zgpppWrfUyxM=;
        b=gnn4kMKTUbnvO0/1UDNzEBaSdbBaMe/E7BAhAtc/XYh8TnKA2UkAvAeEPPsfUCZ/SU
         Qbb+KfO0GGwpbfs5weUJP3KIFGEDN72udl45sXukHZGUBrGIemaarnTSiTQ1okfC72Du
         HsWjy4INDzWo2blzo7oM0IXnalmIRNIEh50MEPIQzjo1NVexEdP8vTLb9DoCmV0SoE6L
         Y0mFBwLTEZTafkG1NODWZ5zA+Zow46ZbJtqZt3583f9sJJhBHisr9V1FsrgGB4FI8rO4
         9HF/eOvNy/DMtYeqXzRvYCGB1TSAWBWMWCJfMxV+uRAqYr5lku/10tFnqrbu6zbGJvV+
         rrBw==
X-Forwarded-Encrypted: i=1; AFNElJ9gMTDMPA7n71L7KQOZ7EzskYIG77OSy0KJNo2tVHdJk3/E290maZ4Sa7LPNeWT4vJiXWWIHo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrcmWXBa6DOSVbNX7W8kSzoOXVz7CmL8+8Bn++rawf6iRAm9Q
	ppdHDydeoUMRZUfS4FY0CZnwp3MQ6ZfYHC8wniLnbnEIarQ3LMDMvslKBt4b4NIz8C+iFxdAbT3
	muR3iJkKuTBoJiI55kcyIPVvIEVAfHDk=
X-Gm-Gg: Acq92OHA06bv0xLXz/JBHKd2GSJpp93UpcVrP03IyuFYGQhUkol6QcJ5qmjq7kl6ojZ
	op12A8RrMEqqdZKWfYvi5MOotBBVsFrKuC7z1y/cgnfYn7g779Dkz36BAW3J8fr4iJBmcdOzzgk
	ikFl+eUfRDg9eFPk9vf7M5F9NrfslboWkp4bW1ahcDCdzeShVQrhf81MVgTGRukHyXv8254aw9j
	R7X/EHpWn0c+syW7qmKM3GD3HE6B7VA5QSQu4w5P1Vh0Kq3gdN037/BTSGNlVcgUdizoQalbiz2
	AC8K7f8ppd8+xbdniAw3rW3ISuGVkeul9n8FfKqTXmSkEokHcz5l1py2ODQZdjTqI9g5
X-Received: by 2002:a05:620a:448b:b0:915:9efe:6dd5 with SMTP id
 af79cd13be357-9161bd64128mr1834791485a.39.1781473489256; Sun, 14 Jun 2026
 14:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518014920.135011-1-enelsonmoore@gmail.com> <20260614125857.398a0e13@pumpkin>
In-Reply-To: <20260614125857.398a0e13@pumpkin>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 14 Jun 2026 14:44:38 -0700
X-Gm-Features: AVVi8Cf4tnCB2NV2GOy1Plt7K6kpwZUtQU-iBzZg4G2hvwytkLh-Fi1T4bogzNA
Message-ID: <CADkSEUizT2dxUni185QDEkmVA+_r9bEQgbuEbZ8b-Sg3JZWrFA@mail.gmail.com>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Shubham Bansal <illusionist.neo@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David,

On Sun, Jun 14, 2026 at 4:58=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
> Isn't it more the case that the ldrh/strh instructions were added for arm=
v4.
> Whether the bus supports 16bit accesses is entirely different.

No, it is in fact the bus. While the Risc PC initially shipped with
ARMv3 CPUs, which the kernel no longer supports, it was later upgraded
to an ARMv4 StrongARM CPU. However, its bus was designed for ARMv3
CPUs and has no way to represent a half-word access to memory. This
means that ldrh/strh will execute (because the CPU supports them) but
do not function as intended.

Ethan
