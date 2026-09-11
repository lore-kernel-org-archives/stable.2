Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CE4A99B6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148397; cv=pass; b=CqVkKDtsHtDiKscCSfh8/l6dh9pjbu5TviYRehE6dKT2VNxEAj7LdUQnZ6gjs3/AOajYEhqvA+YPyzk+hN8imEuHkYDameFvn3BtLHe400MwceYPIWP5g5mEEtfg2XrC1PeLMkBNCxNsxaa1Cylt/edYlNMP+bCtOhUwZGBUW/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148397; c=relaxed/simple;
	bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc18VUPlhNG62iadfJAtz+MGg3QEs9whhFvfOG7IFcU9f2kJc7UAhFU5yDGWCJjpph2vMzqpFrAvmznhD027EzUI2et6qsGRHS8xmzZGTNpKOapYGRqdTVLVDWIfjEUiUB1YUnxYMgHSC2Kg3Y0qtBe1mCKaActT0TIp94Tjdgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+wzf5gD; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+wzf5gD"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so2648a12.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148391; cv=none;
        d=google.com; s=arc-20260327;
        b=pnNa4hv1kKpk7WkE8xerhjRFrsZjpo4IZogvjpNqXbnS9ZBNZmQy8KfimMCb6laE6a
         dgP5CjWdLS8uqHskyJeLZc+aeXFQOve/S0OOL3YI0hw9Mc+OMv4JGYHsPq7R9KD/FzoO
         C7yo9W/RqkM2d+hUGeOaCG04qUGbusVz0CGX9zpoqykBfcjJfrnLuRPvgG6nyTgxaLzr
         czG5w0C6Qx3v6So2m8YaIm/HrfbTnaG0+a/jWbzjVWIKb/5WPxMEpgvfg5z8xN4ngtnY
         vXnf/u8BMF1UZqwNULp/63naUHnY8KNV+TEGodJxFmt7Hqq01vYPsuUy03CLDKU3Bph9
         NfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        fh=zjgdJHHNUlsc4bixb96NlOct7kraU/uQ1fl9p535/bg=;
        b=Tt83i0wDOBNUiowCBBYkWESp5trxm32rorZx88q3wVnhOTuC8McGUo0yZnaaDycL7N
         QZ5fqEAV+oBH6Sl7Y4225KIw9bCphRUPOZ/YseXVvFyC+euAqX6n9xCNVEHhoWPW5iq9
         HjTMZ7r0vh0+elVbKiAdYVfBO38MlKOXn8T3qYzQN1Qc5q9r6SJ5IwLB15jXbx7Y98IX
         hVuJP6i2VrKA0iSykSRLCtmU4HZ400SSZB3aK+n5Xaoc4oPKtXknWmC+ok4xAgRoCjG+
         F+llfmHbgsadF0fpMWangmdoUYZAOmvjGRbWMnSxF5jzyuxUz9SlAjIL2Vvwq9Fngl4R
         nl7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789148391; x=1789753191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        b=Y+wzf5gDdAjJvN31ndTPQatU9eRlMBR3mwyJqDCJmTCgl5odbeO8CWb+eKRNmsh4wN
         K5eVgyPeed1zyxXTwlQvLMtI2GO+dwLZuFVXyXQocn1vqPKqzHNxn9kyGcsTBsLYptvB
         RloRmmWevN1Q2Y+4KX1C4y/YnHOl84yIpT4HGZUDODwczDM93uFBWqP+UhGbfOyoMV9q
         XQPDNeclUAJt0H1nm22CiPr2G3g0r619shI2eKIx0pEulNQeb4XYiv+xzSZnyrIFs/vy
         zPLf5zUOj+gSI9uG1AsdLDe/wrUcPXvc50geX83Bj5f6Cqv7vxaeTiau4iZ6CwNWElTd
         Icpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148391; x=1789753191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        b=eKynd4VsFu4l5ndFN0c0W8bGo3wdK/OaIHvchxDi0vdiCzeMwmjyI3JTjX5Ztgj5To
         7g1lzdERadcC50N+4lGHpPneWmoh1Yno1rv4aF7Ra86PvTpqIYXcj9zNrLkiPG+usXt6
         Eebx1cy9yhD3UPZmKTtseZ6+FAjpYSWogCdl02eSrYjYpJdaPQ8RI7lMXPPM6BB/WUZL
         wT7hZu1QIwx96ZImkvxcQ2sjL4HTsM7pCHlhZczIeGIWIHL2OKgwRHOIpCVo32THLvtL
         +i+LjHcfZfyH3T7vBNkyqxVOgZWxKS+ZeT2g9Xz5UW56A/KVgMEywWPBMmaxN3wYjinC
         1d5w==
X-Forwarded-Encrypted: i=1; AKwUvBx0spqQSkHhxjWnbXGqei8FXtrY9hMF1QuLpPWNVKjZQtf25gzYp79zf45fJjCOfaspVAkY2Dc=@vger.kernel.org
X-Gm-Message-State: AFuF++mUMy6znHv3uRSfh7abazcMqqM1BaVN2m3gtHdH8X0Fnb+7wPxE
	gHalaFwIu0ILpxX8IjSAOcjHGfyzpR7/BvZ2Dt4zcW3N3vIr9rLRv3wk208yhxVXGEHxfkYkxHJ
	Cv3JIYSPUOR/DuOD+Y1SCqjJo44yEazmlbvETGw9M
X-Gm-Gg: AYBFou3hYTB/oM1iWjQfW8JU/rIa6F+6o4r9Vy9avYEZs7n/ssdHsqCrqoHnO+uvNSt
	BZicDHG9Aih8zwXTw7lpUZNTL8TBZWBgeKJ//J8EQGq3TxEGQNCRYh49gtiVfJvGYgrTLu5fxoX
	OlrmfzJJP+NBjz+9W6ZdhP02g7/kud2ve4mK3JiK6Kyewds9osAhDEGpDSHtQad8pvhbkV3tw1q
	O6GfVp413FanhAfLOw0uNxYohF2CpZ0nju2R1PJmFcgrCB4ksWspm+SdVMTTtIUZqLRm1LnWFg8
	lPD+Eq8uswme0ccYnpmhkEa/Xyxkll3FRerbg5Ox3yw9bQXxb9A4hYo=
X-Received: by 2002:a05:6402:3987:b0:6a6:967c:3186 with SMTP id
 4fb4d7f45d1cf-6a9cab59a3dmr2722a12.2.1789148391126; Fri, 11 Sep 2026 10:39:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com> <aqGsukcRG6khmxpt@google.com>
In-Reply-To: <aqGsukcRG6khmxpt@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 11 Sep 2026 10:39:39 -0700
X-Gm-Features: AcwNN1X2A_hxZ5GZwsDJmDi2mwtjAoPaaSIS9kKhx7UswvNj-QNrz6kZOK723cw
Message-ID: <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> So, as an immediate set of changes, what if we do this over ~5 patches, w=
ith patches
> 1 and 2 tagged for stable@?

By "we" here, you do mean the Royal "we," right?

I just want to confirm that you aren't expecting anything from me. :)
