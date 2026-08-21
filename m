Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E12ECEB9
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324687; cv=pass; b=KZtE4+cKp1NiQtf1C1h80N4N6x/5p0Q7AIoOUMZziWrjr9+IoERds8hqjnfZ7VtWaCLIG0uZN99tCtHNt0EJv+ovJD4lxNiznXSV6LnS1UCWI/usgSaJIP1Sqd3/h/QiV+X2BlbxgtAyrmcfILqkbASxKCA+aVWAELK3vqV7MPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324687; c=relaxed/simple;
	bh=xI3FZAQOo1BYZ+T9qj0wmxsBx01GV1sbYW4CCZJN3HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMa+eEQUcxtexhrEBDmgejPD7hDuGLxW/gUbzldeGdovnjRsJsgk0JXzGjL2bTWhIrD1dJM5d5QgEwK6AzZhXWF2a/yZfQ33I/nN+PhRmo6MYGeaT5WrjBa6rKh6IfRTYLhmw2uTk0AH16MZiM2on9rcXhEePd3/DTQ5DWV2I5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ou4vV8Qv; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KEjay6D/; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ou4vV8Qv";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KEjay6D/"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCnTQu2413324
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=RHpIr9KJkjJgmpVSToOMN4yt9MnRJr1pzWju271n980=; b=ou4v
	V8QvsbioRRq+gZuKUiKADBYGiV9T8WrwNxDPMIyfmcasRBhmKctjHJQpGWRO8yEL
	um1I6xGT+v2/BaSkIiIAeqoibkFmnvf2R70JRwtnXhAnWOjPZpq2rxOXiI5wtAs3
	aOxgizcxjYq5GXNcaJZPtltpsawKahNuFELPK58PJi7BwyERttwRFNokhmc/RRAI
	GcfmVrbTXXmNwML/+8nEaeBg0SSq8p4ayuWzUBnOH0SRjcWlRDh2kapUCk7zQ2U/
	cTa9akRQ4HzokT6ZlUMPxn0s7XVRTtE72TZfxgPZJGAORtjeHKvbWUcXz2onWJyA
	sDDMS4CLs0ZtNP249Q==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4g6a55trrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:04:39 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7f5b54da461so18065997b3.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787324678; cv=none;
        d=google.com; s=arc-20260327;
        b=GZPfdsqszDB2ebOLeWMvcQ8s8cdM2xF/abTxef/U3mgo+2SQ0fRa0asWwfKt7lqI7N
         xk5xbO8UhGwkPwfkAzc0zTDhhRaLSe75jliGMhT7GLwKtyVBDl2PswwJ2OxRv27OjUSa
         yH2xZ1oYcQVg5luztgcVaIPJXTEg/Bx84rAsmQTEaKgYvtzw1+EHkcUBmYJoNoHkEQcK
         5cYrbppiXG0/A8XZSE1O82/Y+oHZyi29hgA9qT3zgXgqRGmzoGmMMBLiY96b4y4Q4GZb
         07oL6qhUgYntCFuksGameqrWpvfbIgu0hfkZqL3E9NrefNrPTfJZleYuhezII2wKAN/n
         1Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHpIr9KJkjJgmpVSToOMN4yt9MnRJr1pzWju271n980=;
        fh=j4pyd5kJ41tO/P9CjboVhr9bqIHwjRV2kXkKzuUuF+A=;
        b=cfof1FblTVjQtqRD+Ga2QuE7dri0g7SNPRSyrcmuHl9XFvR/y5HYlKCTPOY1Fc80CS
         /8kGzpa3yfgXdQejARYzBfSuXGZgc11Y2k/2SDEnL7MN5SBcVim0K0gT362T3BQh0wso
         22TUyfVc1yQ+KuGvxElmBZl7bR+WsxZ2PakCnKzNMRwU1sbW2TtGRM/wLp5mFJtKNqEl
         SAHZhNNPW80aYl6dCvaWq3+saFPfCXW6KoOM7cQappefHb5IwYg9tKNNpxh6JWhMfrkI
         3k8r8duyMN0YvP/SV8MU5zbzLc4WakHb/JZPBjFhVE6lg95QoKV0oEST6Ak4mpgpEV7R
         orPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787324678; x=1787929478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHpIr9KJkjJgmpVSToOMN4yt9MnRJr1pzWju271n980=;
        b=KEjay6D/VeesGbMmIMMaCYujGoiOzTu3w6H8vDglYPUTpOFUCK1/c2ybzNq3spZQlD
         q5wPWkJ0NN+CbDYyulk2U4wbBSW4slMB/Dvs1ymIBszRnIvZUXxfzZ8UCoVG2ozXiBnr
         X86n6c4J7pgGqyx6mzv25koWAXbo5qWoZGJKWGRUDKs2lUa5QPAycjoUJIJIcDlxwldz
         FWbmkcfvRnC+mzqJxzMPO2E4PSwzelDuT/AJxiumQS4HtPhpFALJUrEImzaknwVOpxPi
         gdcbfstQ7vD96hwhdON9UjbisaVle2FoIpkh0FKf1DOFaYR+/Mlbii0nhmULoqo/BJ+O
         HM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324678; x=1787929478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHpIr9KJkjJgmpVSToOMN4yt9MnRJr1pzWju271n980=;
        b=UhDkxQ04ltVYZLitV0r1pzGgt73oJo3snuR6q7qznuT2MV/YqhnreshHuU/ABiWd79
         oYXianebp1FaKpKAZh0XM0y2mh1XutWjF881rVyBkM3QleirRYk/kMIcPPbcHuNs0OI4
         yYzCLunoWbMQUjXtaJfZx4XtWr1/9X7Zi5NghNnRwTe4uEs4yTJpAgDlQMgoDuGYZRXr
         5Ajlr9hZYmsIpRqRjgGonz+4H1Fyx5Wt8GW1SPOaw/HbM5j9of+eowkW/sLyiWnkE0sa
         IfSXUnh4g/oxHSSGmJK8BdVRgvc5K3RBoeVGYVlxwLfdr8M4Q6njUhRB458ngnidsB9m
         S0xA==
X-Gm-Message-State: AFuF++kTrFPkbzq/nVXlDOy/XxvOBwGCn7boz4vIz6fMRIrD8F2SqQH1
	7vmst1GmcRicJmFV4h1xNwp/CUiQDhfW2uUVWhdB9fQGCeBSxmLf8Zou0CpwPbXINrKbLHXGGZv
	HnItywPpyGCu3uOn50yixrRVS4zuRF1N0pP2peoc3qvtxPbtsp+x5yPs36qSZspZDLf+1MsppKC
	vasQyEShjlfVgRJQkZC9ZqSupUVoGDEKWJ
X-Gm-Gg: AR+sD12RETukApcpb3QqjUaPxP30GNcFsI3FWDPWWByIBiYZrnymLcq508qP7QSaNij
	2Iw65eKK9sVZKl+WM7y325WFsuvfqh9I6iUrBNcPTxOHzcItYxh2gWdAtCinBPD50uJJE8o5VNF
	eXkPP3gD3/UnJ6F8EzELmsxll2FX646AGP/oGsXdWZSPyEzkASu2M3Z75Eew==
X-Received: by 2002:a05:690c:c0c7:b0:812:c9fa:9910 with SMTP id 00721157ae682-849f5fe7223mr26991567b3.29.1787324678393;
        Fri, 21 Aug 2026 08:04:38 -0700 (PDT)
X-Received: by 2002:a05:690c:c0c7:b0:812:c9fa:9910 with SMTP id
 00721157ae682-849f5fe7223mr26991167b3.29.1787324677843; Fri, 21 Aug 2026
 08:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
 <20260820182015.4272b7a4@fedora>
In-Reply-To: <20260820182015.4272b7a4@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 21 Aug 2026 11:04:26 -0400
X-Gm-Features: AcwNN1WojDOLhLOZZTotIxaF2M7Kt3L6oNJI8XF3NYetDnYMIH0izBAXDao6MU8
Message-ID: <CAOu3gNhTMuRbtyEzoRyB3t11Hm+1bSFsRkrVfftmat4Q0Ji36A@mail.gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX4J5CFyeZvPF7
 9oMuOZ4qvcMBe1dPbf2s6OOd0r1RuG+gmB5bSfSe69QbuDbeVuDjeYUvFvWi+BEOuj6DG7TPqLk
 9pQo1XtJJOlPGpYUYaEDRB50K5XV1boCZRfsg/kb5i7YMmckr/M3
X-Proofpoint-ORIG-GUID: xJlFttnpT8qYniVp23GnH_ATO6MwyFdf
X-Authority-Analysis: v=2.4 cv=SI9ykuvH c=1 sm=1 tr=0 ts=6a886907 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=e25ExAebAAAA:8 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=meVymXHHAAAA:8 a=VfkgQHwZvlQE5O3WlLMA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=Fx-rEtueDibNKiZPBj-h:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: xJlFttnpT8qYniVp23GnH_ATO6MwyFdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX68p7EXRCFHMV
 smCJBGsV281ReQwjmOQkpaMJV+fVuEaEWHr3vtUDkKOkGmRWJ0jYgsyRFmrDQUccBSLz8qfKW9W
 aOYW7kuGr7tP5gUgqYbBIaSflANhSP4QZSWo2yRpT3Q6Ze4A9uktEgCVPwT2D1XlgQ0TRyiYDQK
 BllUg5Pjc0Axv+x3Gc60PuAWvwTaAmbSvSglInGcQf+YsXJJsrltL2JLLU38FS2tadqZw6LXbMG
 6sZK9wkInrCj7PXYQ9RpVMGmB1tO64mF21frieK+IX2caarUS+TFLsGjwPFSb4rN8SMGTB5V7pT
 OVSkmiu2nRSIsq4LjwZ3UW0zTaI1w3PxCkFnKhjKacYBEKyxZq0QAEa5Yxx0uvmfzBmRKrrAMff
 XJmGBryT28Ha0hbLjjr+OEq81Cmsq1ztEQiv2b6lzYzR9WeKSyWkSN3RQqfXovzft5BMkHqWe86
 2Wh1vYISwKc8b5+XmxQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11882
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210117

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

I see, ok, I will add this to my TODO list.

Thanks,
Andrey
