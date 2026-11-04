Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760723;
	b=3LldwSpXnc6p5cSYRWlQC2AP9odbnyiCDzuzptGD2qAUsw4xWieYlnbKXUxeO2RqDB8w
	 n7tV2M5tyYIZJ3qImw2TiBFHCqGyfr/dXVAJrKnYyjsk2ZXTT5LXV8/FPfh5qmt7umWT+
	 UOlWeCtp5/XId8K6jCu+cCpl7AKjn+G0TzMnuGmgNO+qkBW+vi5+KYRyMaTxva9eYMSZ5
	 dRdoFx+4V4mz9+av6GnRnfDvzUXRBvk7gT+XujSnBXA3cRv2yXf7mnPRlG0Cg42oBU3/c
	 lVMPtUyZgqNGtXp0rMM0N/tS68IRHyOT+edQWy4/oD3ufw4eTa+9rj8Pgz4j9OdpEow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760723;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lAXkSs68EqPkMWGoE3m+CfzLQOhhK01OM2CR7g9/IfI=;
	b=rZELyM6dtaYYY7LlY1G4Z0K1wawqDrRcoTmfE6BPv6GLiy0YN8yLUL/SHOdK3eG49W8j
	 t1T4jXxIs6Bd0EvQMK20rZ8LQfQfaahpJ3qyLvz5gNZ2COVa5UPNvbh9VoOdS+AT2BQQd
	 MRbE7ZBpyVfqPtqDVTrtZcOUAGYDJaB4zkfDQEyldzOKg6DrCqOtCUmr8ka//PHEf93L0
	 5pYXTElEvisj+fqkspO3OBUxiaolusn8QFTBxPbUVbSS9df4xCOC0fXA1Ajngoqtxg2Dl
	 c4Xd2dBVIg1huTHEtWBHU2ksbtIt7kN4gNPGYXjkZ0uNU8cZNEhpbe80Z13hVAQL/EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=IWf156x5;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=fZlWShPL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABD606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 02:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8ABD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=IWf156x5;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=fZlWShPL
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LDuOL191586
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 02:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=lAXkSs68EqPkMWGoE3m+CfzLQOhhK01OM2CR7g9/IfI=; b=IWf1
	56x5+qG7A3AQNpZx2CGF1BJ+3T3X85CNn28Mkd+EWaFAX/G0ejE2v/Jut9T0zqqY
	NmJlgwJGA9eZASRIObxEdZhZ+mGhfJlenp5dP1dNgcnEuJtuDQSDCNJgNleaPGgs
	VpKDxnOd7IbS8lvHRpeS3n/ArNLGJYWVHDvi5B4BiKe9IpXXVJ4XluDJRHVQzuYK
	Z5RHcYDwqwqyhmhjdhgLN6ypNmOdbotzHC+FjDjebQyKHZ5YG6XA/qneS26Y0cfp
	mNAdWfzt4K4yO+C64rq44UiOfRmYZy/DH9OxaFvlygXH38f3MiCgYQgjhALybw1J
	of35AfqAZvN79RK0uA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hqqbk8wn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 02:51:55 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67682d4d684so536703d50.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 18:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793760715; cv=none;
        d=google.com; s=arc-20260327;
        b=QuC9fub/z0npMvO2TQFFnZwK/q1F/5cLNXjx7LssQBPLgDg/2Q3FpHvelEjIUFtcoC
         1pqYKipjKhbE2Ue4E42F9erTjob1UWmMrl/kin2EbqMeCL/O0QlF4xEuu7Ir44wgxhXl
         qnb9TmsvVeW96zb/REXRu4j1AG3M16ofxie9ANizS9jWB7isSb2WAkFPTLxzPrv36qMa
         RQmIpe68rJu+gDJAEqqgGnVigluGGC6hwhP8+08RLG8X3EIbOoXZSlOTBZb7I+1xze/G
         9g3xIQiAmZBbRu18bMLhF7eZT9AJkhFWvAWcN+o24aVpkTT/t7YDTqZodpOS0WpTEGr7
         dT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAXkSs68EqPkMWGoE3m+CfzLQOhhK01OM2CR7g9/IfI=;
        fh=j4pyd5kJ41tO/P9CjboVhr9bqIHwjRV2kXkKzuUuF+A=;
        b=sn52N7wsORMi9Pb3sxwtXYqeAcG7LCeHXA5zA+QwVuPVaOolzrzUyGMKsl+KAwRDUl
         2cPRuA65656BR102crMh25KN3P8a8/UZ0q9G5AwFFMN6Z8+WjVqR4dE6JYOpv5ksTD1h
         +wlsUUn7ZXHrfVueyBu/FQc9+FfZqXiDb+Lk1bb1ASJjOQQgl8zqjCeKNRPa6qIlq2+3
         ro6qDvgeEZ5jxXZMbqwtu6BHBwTYA3lfiEUv6hddPUCeLFS3GPiVIH0W6Bel9NJGQ4zf
         2X/zM8bXUlDKeZ9IVIhA7VFxLs8o1rns0GTxNKd8Jk1nfW7QeJxyyHa0X/GN7rFcTYXo
         sLzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793760715; x=1794365515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lAXkSs68EqPkMWGoE3m+CfzLQOhhK01OM2CR7g9/IfI=;
        b=fZlWShPLpSeOi4izx8yuxtp1u1XCZeta4anl1OgTlAd7/BeWHTYoiOS6xfKyyCJm2Z
         z1rIJggCff5xusnb9M9Q8Y0FS4ibm8AjiB+DbN4DuV4YacNRRTH2OxHRB1iHS9AKCKaR
         OjqYT0t6ToeplNCL5Wqp4dzSMAC2q9fNihUpy5vKnsGspi6bfjMaHeWOCCyOZslw4k90
         hrYm5UjKrLPVmEbpLXKmZKnTQGvpn4LaKas76vcRoN4zg1MZCSeBX1t2d35Y4ciP9mGA
         Ad5LLWzpbRGFVIpmMQBzI4kMGCs68/5AZXvHH3RuF5p9hgYcnCj99in8/c5nkAvK2Eau
         /83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760715; x=1794365515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAXkSs68EqPkMWGoE3m+CfzLQOhhK01OM2CR7g9/IfI=;
        b=Pz403AqABwoJkw7DZWAgU+yi/Avk6sUjt+2uI8J1Xih2vBRVBNk9e0huuCA/6cDwBN
         jbQElpC5btSA0uR55EfycPrfoq4L59InQNlFUcnZLT5amuQIg6P9xAZV5S7KLoadZ0Va
         CUw1ZvDrQTJLJlwUVXm92MZIkut0Z8G7H1DumUg2LLFsYBnWQ+adR3Kl7g1uxB/G1Oav
         kBIetmDdaiGwYcp1DRtbgWC6wpZogA8xbr3LlCI0OOkiPhZYBJCdJ9Fd60k280Rwhq4V
         YS+CJxXcJJ3w33UG//yIqew2myB21+uJxh97OMAyK06Dk9BC8xQamLT0MsrPIlx1cjSb
         7sgQ==
X-Gm-Message-State: APuU4Z+oiya9zsQJLv32Re5oHKecqTWzdLxVUwfvOjHCB5dWvmLldwgz
	EHieMELi+uET5arVLt3lHVFTuhpCU/Jjkxwe0vGKlwMZg/EmdnbEefW6QUJiJaPGXmtvFS7oC4p
	pXEYTc0PyaatM4x3yDKcY4Cakazk4cnbfVqcjF+0wmKnDmsZvNaxfiqvMao5VlrjCYrhYv9Tt7e
	4ZaIsUo1hmIEW+W9NjwmP9zTZOnmiRxHVG
X-Gm-Gg: AYBFou1SHBxaLBUVWH49jBPdaP2l0cpw4yKdYbeo/a2e36VzGT/vPvrOzQYZ6szrphH
	EwSdN4SM8itPyhxMSANk3u+d/gCWIBqW3vMfRHQvlveeBvHlnNkwaeNlgWLF1UrpPIm1bGe9TgE
	ODDkTAzK9rNBsiqN3o4GVBez0o6o6WWFjhgEYfV4tk5XEcSqWobv+haT/+
X-Received: by 2002:a05:690e:1698:b0:67b:9051:e334 with SMTP id 956f58d0204a3-67bb304d942mr6953175d50.99.1793760715016;
        Tue, 03 Nov 2026 18:51:55 -0800 (PST)
X-Received: by 2002:a05:690e:1698:b0:67b:9051:e334 with SMTP id
 956f58d0204a3-67bb304d942mr6953165d50.99.1793760714438; Tue, 03 Nov 2026
 18:51:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
 <20260820182015.4272b7a4@fedora>
In-Reply-To: <20260820182015.4272b7a4@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 3 Nov 2026 21:51:42 -0500
X-Gm-Features: AclHuK9IlTY1jg0NbCnejDWXv1EVQjqwEEUjX8rlKRSwsqn_FrN54rhZNNs5-9I
Message-ID: <CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MzMlCPt1bokt7c2ZagWK8VWpSoK3-sWH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfX8M3O0WyKCTZK
 gfYla6Ti5Vgx2uHnzycnPCbC3cqaPiNPD0PoSZE8nUceOphV6rXYA48G3fV/qF4j/lN3oQzP4TJ
 qM+kDDoHk2janBpiqRN60lBUTEbCBzDY22sK1wLIvA+GNXfvMy8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMCBTYWx0ZWRfX0tC87Q+YY+ua
 enZX/JFFmK+DvmhamScIy3kES9E7CKklsFQiI5kt9++pZZD/d89DIWp7onJLE+Uh76auDPWJZJW
 atqfSKvnad7K3EqxqZlUj9IE5xN7ooA/K4yskBofw+k3/mA+RIsbnBNRQn/ieHpwJcdr81Y2gsy
 4uY61MQv0IbNxV4JD2YbQ0fAgfNhQBjYOSkk7ciZMaOsclApVsSanVJaxPF6GUVeMsGJZbV8piA
 5tPHV2vVmXK4z40BY1CExQbuRNMOsoDQuDZwU192O5tGtuHWsctGJKAhyVnrfEnAiKb6X000uA+
 9CcMz5TO/d1GSnK9206QsKrkb4q719PFhB+ciDVCEgs0iwc9hd43YfB2SDJ3WgmOeTrANQXJmwx
 FMMSbo+obvB5ifGTGHizGK7k17qlhwKtBQPgD55OpJYnqrtmvaSqG1zSQD1gFQJFy/ll8TGE3Xo
 E2GXpGhGYe/P8NiinCg==
X-Proofpoint-ORIG-GUID: MzMlCPt1bokt7c2ZagWK8VWpSoK3-sWH
X-Authority-Analysis: v=2.4 cv=ffI4WEQF c=1 sm=1 tr=0 ts=6aea9dcb cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=e25ExAebAAAA:8 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=meVymXHHAAAA:8 a=o21ACTxphgsBks0dGJIA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22 a=Fx-rEtueDibNKiZPBj-h:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11955
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040010

On Thu, Aug 20, 2026 at 6:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 20 Aug 2026 17:30:40 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Hello stable team,
> >
> > Please consider backporting the following two commits to the stable tre=
es:
> >
> >   - b0c857049153680e1b6ccb59abf359a4ca523561 ("ftrace: deprecate
> > disabling via ftrace_enabled sysctl")
> >   - 88b3e7fedc07d940c32eb5c0733a780e944b6b47 ("selftests/livepatch:
> > update https://urldefense.com/v3/__http://test-ftrace.sh__;!!BmdzS3_lV9=
HdKG8!1ja9D51Ex2VTTMdOEl4Eb-3ORL8CXBX1biYMPMLmT1iP3r8I8tfDE41DOth6sc54E3ODL=
fRqYSaIdTR60lcLWOzKIOK6Jg$  for deprecated ftrace_enabled")
> >
> > Both commits were merged into mainline in v7.3 via the 'ftrace-v7.3' ta=
g.
> >
> > This change addresses a long-standing issue: setting
> > kernel.ftrace_enabled=3D0 silently disables BPF trampolines
> > (fentry/fexit) and ftrace-based kprobes/kretprobes. The write succeeds
> > and the hooks stop firing without error, while re-enabling silently
> > restores them. Livepatch resolved this via FTRACE_OPS_FL_PERMANENT,
> > which blocks disabling ftrace while a permanent ops is registered and
> > blocks registration while ftrace is disabled. Trampolines had this
> > same protection from 2019 to 2022 while sharing a global direct_ops
> > marked permanent, but lost it during the 2022 per-trampoline-ops
> > split. ftrace based Kprobes never had this protection.
> >
> > The breakage was introduced in commit 00963a2e75a8 ("bpf: Support
> > bpf_trampoline on functions with IPMODIFY (e.g. livepatch)").
> >
> > With these commits, writing 0 is refused with -EOPNOTSUPP and a
> > one-time warning is logged; reads and writing 1 are unaffected. Steven
> > Rostedt requested and reviewed this change on the mailing list,
> > including the follow-up selftest update.
> >
> > We would like to backport this to LTS branches starting with 6.1.y,
> > where the breaking commit already exists.
> >
> > Mailing list threads for reference:
> >
> >   - RFC v1: https://urldefense.com/v3/__https://lore.kernel.org/bpf/202=
60730163544.2042327-1-andrey.grodzovsky@crowdstrike.com/__;!!BmdzS3_lV9HdKG=
8!1ja9D51Ex2VTTMdOEl4Eb-3ORL8CXBX1biYMPMLmT1iP3r8I8tfDE41DOth6sc54E3ODLfRqY=
SaIdTR60lcLWOzV4jPY7w$
> >   - RFC v3 (final):
> > https://urldefense.com/v3/__https://lore.kernel.org/bpf/20260806153000.=
4184871-1-andrey.grodzovsky@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1ja9D51Ex2=
VTTMdOEl4Eb-3ORL8CXBX1biYMPMLmT1iP3r8I8tfDE41DOth6sc54E3ODLfRqYSaIdTR60lcLW=
OxUSL-qOg$
> >
> > I can provide rebased backports for any trees where these commits do
> > not apply cleanly.
>
> I'm really nervous about backporting patches that may be reverted
> upstream. These change user space API and if anything depends on the
> old behavior, it will be reverted. That would also mean stable would
> need to revert it too.
>
> Instead, please post the first two patches of your original series:
>
>   https://urldefense.com/v3/__https://lore.kernel.org/all/20260729005959.=
3853865-1-andrey.grodzovsky@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1ja9D51Ex2=
VTTMdOEl4Eb-3ORL8CXBX1biYMPMLmT1iP3r8I8tfDE41DOth6sc54E3ODLfRqYSaIdTR60lcLW=
Oyr231hEA$
>
> I rather push these upstream even if they are not really needed. But
> those are much safer to backport because it "fixes" the problem even if
> the main fix gets reverted.
>
> -- Steve

Hi Steve, coming back to this topic (sorry it took me a while - other
work related stuff kept me busy). Are you still willing to accept  [1]
 upstream ? If yes, can you also please clarify why only the first 2
patches and not the third, selftest patch?

Andrey

[1] - https://urldefense.com/v3/__https://lore.kernel.org/all/2026072900595=
9.3853865-1-andrey.grodzovsky@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1ja9D51E=
x2VTTMdOEl4Eb-3ORL8CXBX1biYMPMLmT1iP3r8I8tfDE41DOth6sc54E3ODLfRqYSaIdTR60lc=
LWOyr231hEA$
