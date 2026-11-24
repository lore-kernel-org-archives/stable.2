Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563534;
	b=ITUW/sszzOULA0Rg/rhZxpF9PZ9xTwSC1siii1RYXO+63ZQSGkcsEj1k0xval7lJHEIC
	 GDT3JdeJGvFlb4nwiFPLzwVDLkbZFzMfmdTWhr7sHge1lPVmyJDfgvvCzvRyBGpZlhtEY
	 XzJQp5F9TlNDW8xN8TUBXuZhrlF92GQEcITvfI29736cJ/xrFLPBCwABkowUBQez/fkez
	 GMBtTovcP3+TjNaqsLAhJp8ygO/gl/45gnDICPtjgNv8dVdEB6u635eeAgrY9i6oH+t4w
	 FI84g1HoGMPHz8KxYRSibMjDH6Zmk4672TzjuMPbetw9U3HkJ77GPgcTWdIiVUMJY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=DSz47Xb2Yu074okaoRlTthS67fhUdvqRS66Ctj90ArA=;
	b=Mp+EmWBpbjXNYukNXo41D9GPNzIKsIMw1zuZ/u6qIE6kiYWpFcp+fT/sLayRHp3Ib6pD
	 /EqVWFuijCqIcZRalQ/2eldkOMDUFMHrM3Iijil+TMIXKIsp5lqnySSSv3bPJsoEFMyHu
	 Z2NQxv7mh6DNLRkAtoqXYu1+HrfIOoHHv7/nnZD3/MBWgBEPd4qPyiWw43b1XQ9EHNHcE
	 rrkqb1KOyDTJJfomBiwV4kfGrn1NmKMOJQ/jOuOj8PpVceBKrK88WwnetZRO4PK+zh2ES
	 7qw2KLnUZg/0u6hF3hrYgBy5IPpwIcEFkMHuLUoq0nRfEtizzkL7TLgvqPDMgX+aRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c49RfFi;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1B606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E1B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c49RfFi
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so2560560a91.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795563533; x=1796168333; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DSz47Xb2Yu074okaoRlTthS67fhUdvqRS66Ctj90ArA=;
        b=0c49RfFiXg7MMM+V5ReJSq/A1x19TeDfE7VYQIbwrsJHOILZPw9H9slMQiUCntCkDX
         s+LI3kIDp/a474MULNg8So/YKq/2DINHMrgVIYAp7bLi/EQW/f0Y6ZdEk3zRry9f7Vp+
         kKRtvl7Wd4Lq1/n8PEe6IWOW77BVNhNvIGyB3N0iczBvsTDj8sXjPbRBExDxqoFEo7i0
         5dLUofgD1b5zJpTz4rwli/uicHWWc6d4ms1meAjyrxz+uLBsRbHeHMip8+5lv+1qV9St
         qZONviLSW4iNSkTyG/NHgB/AJ1McJkBtc1zN1X2oGI3WXsaCpKAb5y0AEzTxWO0apGM7
         XBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563533; x=1796168333;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSz47Xb2Yu074okaoRlTthS67fhUdvqRS66Ctj90ArA=;
        b=NiGpbpkeA+r3GBZVePRNjxj7dHJZuEnpEAJKuCVEQhAa0/tXtFxWcmvTpCe2M5cpKz
         Z369iEePXq3tFgFDN3SLRrOEtXF4glAvi8+/+6VzTdu0ZSjUOTZXENWU5VixuD3ITZGQ
         0A4maJHRtvssUfTD/NOnc+wZYi9hWcGbqz0kj3+1Bk2L7bXr7jvZprmWBujZbaql7MBi
         /UyUaEn+PU5AvaYPvfQVzJa0qzoskB7ZLj5WzFtCla3OBd5XNFK6qDFYrbeHjtIw8u9o
         8iG34vIDVEyHjcJchNGD/vqBHeVpf9sGGQ3F/rhHJq/p3L4YONYhpjcZ3E8dqqmSSzQt
         RUtg==
X-Forwarded-Encrypted: i=1; AL+hErEVpMysDYOt9jBnwxw+EvlEk52vJjpW2ImatxSvWEtC3saouGiWxYSa2ltFPTEzkX94Ro+fm2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BV0euIuvdPyZiKeFBYWIcppPgymoO40SVV1/F/ihXxcYWCoVU
	4ucrfHtq22KvLVs5eglxM2hj5jCPBuRUGIbFN9OIH9Fbl4gTl5ra4GwD
X-Gm-Gg: AZFdTZeSJSSMT9LqyBmXW1nCel2czT4YQRPJ3hvGeOV6RjDNsnQKDdYuto8QGHShsvI
	ZNOMlwLC27DKFmEEGy1ps/hyE51OOfFuNWRM30DA6zN0bsQ1DgUgw7Z38GpP81e2A11OdnrIhqM
	n+jRXSQ8qNIJ/mQiAi9tAetLHlYuo4hB2YkvFKagtpTRn/xnqKK8K6+XYzC9yyvw2Hae8HtWIWh
	bKQJSuk/xaV2Phb0x5ZZqUOJRQr2hKf1meaj7vlSsO9egf7EHp64sZ6BlnmTlvKseNhG1KFMprT
	mLQkH1ARG4bMKJWNClTNIRooRv/qOIS8KV7niGQKWyGlGwLW0G0kgdZQYz3ZJMskFSFooeAADEX
	s+L9f4jqePLgDjBTw3dIolICRGlgQjiIpU2DCTYZVF2/8uZsuitSgRPSEbeqRWNV7PEamAeL31D
	o7e1kOS23I/Fsjvrwon8NsTTKcVIebOT9jYD+ChYniFmA+eCXNGGV0AHt6bsRxYwj3aKFlSTv/1
	Whm3bRcKNwkMddyChdK2LG5C7Z3v+2sRW3GDFtkAbRy7uf/Xaty256ue4LZqDLhoO6Qz98vJEkZ
	MOG3uAi5rZUdvogLFG4D79HVxtCaek64yZM949mUSOts9wlaDsW//FNhXRjPgXxfkvqW4Oe5fSQ
	Aixosn1yN4GPdBBao62HEdpishK7c/RUESg==
X-Received: by 2002:a17:90b:5346:b0:3b0:9976:c1c6 with SMTP id 98e67ed59e1d1-3b41c9bbe00mr13922397a91.66.1795563533461;
        Tue, 24 Nov 2026 15:38:53 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm24744948a91.9.2026.11.24.15.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 15:38:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 23:38:52 +0000
Message-Id: <DN3U5FE54DYN.2WDV9ZPB6NWXL@gmail.com>
Cc: <netdev@vger.kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "Simon Horman" <horms@kernel.org>, "Victor
 Nogueira" <victor@mojatatu.com>, "Po Liu" <Po.Liu@nxp.com>,
 <stable@vger.kernel.org>,
 <syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com>, "shaos"
 <shawnq1@163.com>
Subject: Re: [PATCH net v4 1/3] net/sched: act_gate: bound the cycle time
 and start time arithmetic
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
 <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
 <DN3PFJ14HKX6.1W8QEBXWGFTHH@gmail.com>
 <CAM0EoM=rNfC8O0+XVBTaCFX-NNf9TGp9scdETqju18PVaG=_dg@mail.gmail.com>
In-Reply-To: <CAM0EoM=rNfC8O0+XVBTaCFX-NNf9TGp9scdETqju18PVaG=_dg@mail.gmail.com>

On Tue Nov 24, 2026 at 11:31 PM UTC, Jamal Hadi Salim wrote:
> On Tue, Nov 24, 2026 at 2:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 06:12 AM Jamal Hadi Salim <jhs@mojatatu.com> wro=
te:
>> > Conditions to recreate the bug:
>> > CONFIG_NET_ACT_GATE=3Dy, and CAP_NET_ADMIN in the initial user namespa=
ce:
>> > tc_ctl_action() tests netlink_capable(), which checks init_user_ns, so=
 a
>> > user namespace of its own does not help.  iproute2 parses cycle-time a=
s
>>
>> Well ...
>> after "unshare -Urn" an unprivileged user can add a dummy device, clsact
>> and a matchall filter with this gate action.
>>
>> That check covers RTM_NEWACTION only.
>> RTM_NEWTFILTER creates the action too:
>
>
> True - based it on poc i could create; should have checked that code path=
.
> I hope the over-hyper bots dont complain this is "high" and have me
> resend to fix the commit log.

Oh yeah. don't bother. small mistakes in commit logs are fine imo
(at least we don't care in bpf land).
This code will be rewritten tomorrow anyway.
