Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795563096;
	b=ftPCh/qZaHjxlZgpUaNjFTpApFMLY3izGRkDpp5iszPhI9Mm5SimB1eYAI4qmeCDOWw0
	 n1aGbAlXSBAPgWYOPodNy1ZPzLkhzMsn/ZrOOng5HOxNTJRINKL3NVqvfBfa1qwHeKuHC
	 zXBZbRXq647EdWGYwyqAG9Eg9VHA5sXHYeDjiPkQm1yOqdXqddxuV3br3dTcqc31wejkz
	 SA2Ni29YHjj5cD7K13MOJFtNCKlP8bjMV8QYYC+8k6iuDy/JolRfSXXIwNIX9uvRDRB9M
	 +WUUaE73MRRSYitQHt5e//wsAH/zuJ2j3a2cpVO+c+70UWFYEcXZTZTKW3xMldDJc0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OKIVDoQ6IbjrbJSFAkyn2r8WUZW+fQ5wkN0UYjtVEY4=;
	b=jbQhQ3Lwj12k4OUDyIYAfiPl6oiKv2JSoVmG6dGWijzrzHFNJ2t4qTNpIOzWSKjCFYSy
	 WsBEmll7PvCZbhtijR8xECByqH9NHuXgxQNqWPFnWwZR1hG6iDHJJdk/DwG4CNJRLaUwh
	 iOOcxyLgkDhaom37HAx8RkTSFJ1LQnCcqtTWNd5TUGaIfdSJ1sVjpd9uuqfS5dvm7e7mn
	 j9g/ftWQKClAGF78au8dMT5YkV1s3yKqV1pPPNiFF0pHx0/4Gew7UNpr4sf9/iRNerYFp
	 rsZj66E2adfQx3Pn4x7MF1c+I8D6TIvSksLsU4qfFQmofyXQ+9siBPUOsWPeh2Zhpqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OWNmR4bQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CB606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OWNmR4bQ
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06e79e152so2480089b3a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795563094; cv=none;
        d=google.com; s=arc-20260327;
        b=NnRuMQqwbMdIYL0W7AF36MPGcYFmWk8csDVpOI+bhw1Nr2poZCcGhP5CCRCHcw3bXe
         tUBThRbH8SLndT6syV5/6yY87qRtOFzBPt7VNYCWjfXBF9QBSmOzdFzLdEbllqVq8Yn0
         myhQAA/Q1QJcG6OFrFiwTMA/0u6IllX7uXmwOe1KfCPEhOhUfyPUpH/pMtNtQPoXR1XO
         DSE+i4PzdOOxIydx/VMDf/Ja93iVu3gVgjosFgK3qYD7Ra4Wtm2aS9zBorHu9xuZBKtA
         0Q4bgTVtHTms7YcOvkJlikA6+QIq5v19MgARdHGd4sqzKVQLoTS8PgXc1WlgqMPXNThp
         8mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKIVDoQ6IbjrbJSFAkyn2r8WUZW+fQ5wkN0UYjtVEY4=;
        fh=KkPuvWqnARHHcY2rW/Sh0qLRc/0BhCoBmSvKRTQJ/p0=;
        b=msV6ew+OIzld1eGpNiTn+UwxH6DbfvpcXxT7D+C4EYzniBpBXuIL0gJhKoJxpyPazn
         QKUWxXoecSF1qIqRVbf32r0IifYbjlNWiY7hc7iH3e1pnT6SkrodmAxJ9AQI+RSZPWgv
         fY1YLuvE8S37feCumkmEOG/dnSQ2REyzrnd34fZlgYJXpZA6XF2u5/ZIG6sSahjCNXDf
         QuD0DFqmt5n6OyXCf6VfKgT3dHkZlIT5fmtdJgcTXaME3dHwiSakvxOj6GXdPxqMvkCN
         w7mtSo/ffQzfvRJqkXylKSP2BFJ6GwFRo31BuFkQLe5jVdRtR6Ir8j1ozOAwCAjKz/q7
         +vJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795563094; x=1796167894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKIVDoQ6IbjrbJSFAkyn2r8WUZW+fQ5wkN0UYjtVEY4=;
        b=OWNmR4bQNuAY2g8kn3mBIKMy1mDBz5BqS5/LTU5OFQyzDO4CHsNkaczpxT16SbqhOF
         aAR2c3qhiE3pTNOd7NMDyF7Zgv7mp8W9tixXX5dUCwy47PMIHFy8wfnilK7npcisz0hI
         p+aSstV/JJpBGjRY7jpdgIwyq9pAim4oZ8kFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563094; x=1796167894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKIVDoQ6IbjrbJSFAkyn2r8WUZW+fQ5wkN0UYjtVEY4=;
        b=diFddisD69CRsCjl2/Z2+u3T/2uIOia8iB8Es7tnYtH9SRRTADdTNSc63JzYTv1yGU
         1KMWf6fVKcPKYS6m281zIiHdv2rlogY3FzSuC/F9RRnYeeUKcKBYJ020qOs87WFswe1p
         VrTL7sgIX8V9odm3YTQ+90odLpNEtPmBrK9tJOtWmMW3KTkB82e7bsP8LVmuXpb1ODMZ
         GnPbIassEtPI7vbUk0DEaJGCg0zDy/UaCV+Sw/W4l/dREZbqgwHYK1orlRB1m6gZF+vS
         MooUrqMm9LSl1ZnHRCWdR3qGELoBRzE51N9/+3T/ishhRSx/XM/M3eBPsKwVkYx7Vg1X
         O7hQ==
X-Forwarded-Encrypted: i=1; AL+hErF+cnwa2fUri60wDoWgqeNiLyKIznUGqthsSs31wbacCdtQdCQkyj1x0oo5ew1rGVQEJw16oK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rzmrh0bqknXjhHrT9ZWpabT6yKL/1+1owwZXo2TnI5kpeHOXg
	8gDji3ChjlOaHbJDXcZV7p9o0SogsVdC/86E/h9pX175R7iiWfeiJn4SlWBsOZ9ty+xZuuORQ54
	Cx3ROnJA/Uj/kftfvR5H5bHrlk5ehxkqkgLyJ76J4
X-Gm-Gg: AZFdTZeX2r6AXLf2DdN6ER0DmMlIl8wSlpNMhokutAmK9AR534/3+kgPP6Xjb/K054x
	fvGWyhFOcw7nx188bnVK0CRpFim6eFQiOCsfRBkxX8ysbYh7JNZR1g0GiMbX1kCCPp/VTDLoE0I
	2sukrEvskjUr3QEnJyhFdc7UTCACD5mex3+L/d5zUli9lq5hW0hcjst35BnqDrlq0IWvhQEbbPq
	VFGqn2vSiq7+TrDy7oQtzy0llztd5PK9pfFO9jYJQVddoI3I/60dYKWKPC4oe71ZskZ9Q2OpBlU
	k1TM9naj/8vC1ut0Z2h3yrxfsFwiqj4umcTHl/icsGTZMlCPm61uiBtvnfH6u25gQK5H4Peg53T
	3UO9As3tJW2xQjCdQM/VlipYYS8QvGbwob5OODeopPMd0ozS//Ov17iICQ5Wkn+sQiJuow6onWk
	S/fqeRthHmC4F8oHI=
X-Received: by 2002:a05:6a20:a108:b0:3fa:f23f:a1d1 with SMTP id
 adf61e73a8af0-4014df5edebmr15730791637.75.1795563094342; Tue, 24 Nov 2026
 15:31:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
 <DN3PFJ14HKX6.1W8QEBXWGFTHH@gmail.com>
In-Reply-To: <DN3PFJ14HKX6.1W8QEBXWGFTHH@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 18:31:22 -0500
X-Gm-Features: Aa3M54p0BIuXeFK1hQe6wGuidNpnYhDPisOyEEe-Ji5-LRTxpCvmnGc2U6AgJTE
Message-ID: <CAM0EoM=rNfC8O0+XVBTaCFX-NNf9TGp9scdETqju18PVaG=_dg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] net/sched: act_gate: bound the cycle time and
 start time arithmetic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, 
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, 
	shaos <shawnq1@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 06:12 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > Conditions to recreate the bug:
> > CONFIG_NET_ACT_GATE=3Dy, and CAP_NET_ADMIN in the initial user namespac=
e:
> > tc_ctl_action() tests netlink_capable(), which checks init_user_ns, so =
a
> > user namespace of its own does not help.  iproute2 parses cycle-time as
>
> Well ...
> after "unshare -Urn" an unprivileged user can add a dummy device, clsact
> and a matchall filter with this gate action.
>
> That check covers RTM_NEWACTION only.
> RTM_NEWTFILTER creates the action too:


True - based it on poc i could create; should have checked that code path.
I hope the over-hyper bots dont complain this is "high" and have me
resend to fix the commit log.

cheers,
jamal
>   rtnetlink_rcv_msg()            netlink_net_capable(CAP_NET_ADMIN)
>     tc_new_tfilter()             no check
>       mall_change()
>         tcf_exts_validate_ex()
>           tcf_action_init()
>             tcf_gate_init()
>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
