Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8F2D0605
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815314; cv=pass; b=kLsXeBW4uBNK8Rou2y/pEzTyF9aVPVTfG6RrzPiY4KtcgHcYk2r8Of7F3PK9K85dZQtb88Xtj0JBkMS/rnLD5jRRTirO0wyqAiZPGceW8+cii5G8XVNRFIehpPKZtfNIHIhglunU42VrdI0s6YD8gqRYsU1CF91w5zOfxhesfLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815314; c=relaxed/simple;
	bh=oy7K0n0jFWqeWX4aHH29R1d5bUVx8XK5bTOk3DVMP8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpqXtrGskOy+BFfjOXhts//vjd2jPB/NP3nH6uIrZa+zU6hMhvx9aLik8NhrlyroOF2g1Dhca9uTPUmH25d463yP6rW/go6Jo5dtjLxQU4RzXe7LTG0XEgpr0or5XdAUeh4dlh98dDGbLKQhzrY3W24JDrmVQ6PjxxurJwQ+au8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=UdFDmLE8; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=TZuXKPsc; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="UdFDmLE8";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="TZuXKPsc"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiSPK3008093
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=cs7RGxrnXS+Vrnax0XTysU0w8PM1gCqppDj7/q0PDDY=; b=UdFD
	mLE8A3Ej4JB39Hd6v7UCe3Ps+P4PJNK9Wndq+5VUCopzQHKAEpm1xY4Nt5gBS4de
	ZMGZdG/adbbWEAEFgYo0S5C+TPqFQR3DZW1mxb3Bpc3aqcqqixwRfEBnuKsg8QFY
	hR2xLcFCp+pfq1RuyP6gC9Afx6NqyEiNxp4pSK0qO0Zd+iEWcTeDoxEaO8dfj6fh
	MEmatxvpmKZlX2qTX3BXQuo+rKfWvxuEpWE+GK7darHVUzDF3JSFdb2eyjAzNsIs
	qJs0AYGDlKbqaxQb//YntP/csoTDHasC1BV88jgWrnSPa/ky7pKzknSS3dajZe0x
	JrRPBpLccexZz3s/BA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3k8866-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:41:51 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7e9dbc4039bso26255517b3.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781815311; cv=none;
        d=google.com; s=arc-20240605;
        b=NrR5HzeFSYWgydvElF8kExFRnzaHDv+rC815neJDLwVG4dYWgwb/0tX6SUmNTQo2aW
         vIOQH1rBSo6+fzkQaBsUg1qkZb8mK4iwK+ytNql6Eg9uG0qmXqKBeWrfOW+RVRkf9EXU
         1KR0sxY9xBfS9i1Sk4bKvdTJNi2d6k3GvEPTw3wDB87mVqXlUJ2HxMMAOgkmwQP3wo1t
         hRJUNsufrCjL2mhDLK+F/ZvbwFz5pHrBMza0eZPW8hGhQZVHabdr8iPpegB+U1bGDndW
         8TScY1ClZq5UEbb1vuOofN6MYchquxB1g+jHbjmfbPpGWV35M+/YOJO9bUxaYwul1PNA
         Wlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cs7RGxrnXS+Vrnax0XTysU0w8PM1gCqppDj7/q0PDDY=;
        fh=8Eo9Y+Ic7jCVAmjnYYwTPelh0bw6QnAseCGPVdA1zD0=;
        b=Fq/NlZke5JUVQBDwsISPznHZdheHM1IheG7l8qfwcNvU3EncI6Ld+prlc/HoGQxtg1
         vzChEuZ7Kp52WRwQ4VY1EyVLwMXYJ/4Kbv37BAKpq1eqmtBZpt8NZy3Du0UlEYXZSwC8
         kRdvuczX9rn507XM79HKSuzKqIMOAzEId8jWiLxh5IsquDgS1DzN8khyP+7Iq8bUiWUJ
         yVhrAvAHpc7LVPpAJDZwbcLEk1vSM9+PRKi+urvOJM+9uM4V99taOJkHv5cJB5oJ5m2p
         k3xqA0ON/3LEMJkt9dlrdLZd5g6RlMm99nijeP3Hq9Ht9wfeY7Mp+mPep2LdgOesOEUr
         hxCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1781815311; x=1782420111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs7RGxrnXS+Vrnax0XTysU0w8PM1gCqppDj7/q0PDDY=;
        b=TZuXKPsc6/iWmgMcDHJL6K5lIMrKRr2xIJuI2fy3v7vgLsfofeFSmHmoN0g0onkbdo
         UfnhzcH4AbJi/sGNNNsKw+jN0aG1AF+K3sg5+PushDDMWUJdX0DgIZOUbyWW6ajeSlkQ
         iCYhvE9WLbg4prwzOD6cdp6YuoocuDDejLVyMwYwF6h6oHnRObd0DHkU5D56RrHhUVSc
         RBTfEnnkkvHoLLAEi4wQPSXm2cENRVMLondrE65TO2NxDSfYH6GtKE7aXYVIOWcKbeNl
         iy0Gp7mjbuuh1EEKa2dhpYlrXPdkDmvFdx7WohJdUUMi+pu9N5068lYXA7GnUNvyZT1G
         4JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815311; x=1782420111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cs7RGxrnXS+Vrnax0XTysU0w8PM1gCqppDj7/q0PDDY=;
        b=eyMbGdxKvm4+6zQEPyE6i+t4n0TAGIlMq25kUhAoUo8nv10QxkSRbhBKXkFURCiR+3
         4uFX7XFDbSY/j0KV/0HrUWjxR53xSQOAKPlq48S5SWhSMvJeFh3mBE2mLSbY8Fi75v1/
         1w4+t05o5xbQwuJG7+4H/QcIYk2lcmeP1GbGLNEZarKJGKpv/oxKqInLVMcv/mSw+uoP
         k+uo1DqRHG2g/nrBIMwHSw3LX9eHG/M49ChjXAWhIt5SuuIwA60yeP5ajt+COKdzzQFH
         TNPR1XPXY8c7znLdDaJDjUo0rweH+nnmhC0HMAZM6zdCnGmhJqEH9f243YJ09/M9C7Uw
         A4pA==
X-Gm-Message-State: AOJu0YwNmwijvm7uu9j0JfLdXjL0VW2IavtViKiLrFyjvdlukAIlTVRQ
	qAXt1cOB4JMgzW/JEpysppOAisgpKK3n4godjjsWQ1bD/GpPo56WJ2Gg1Cxniy4XwuZs9hWWEyZ
	7FsExPtjJ0Hr291xVIfc0lTjYx/nz07UeFSEl560AmnxZ3pxMSNv7/KJAcIPeW3Tuu1NKZCfDz5
	oC24WvDnOTerSG+3r8ClJl8UI2jTixyieS
X-Gm-Gg: AfdE7cnT5DK7rFSl1Mo4y509hFHOPigXaTEli6Vv+GhhdgEobB8Nn46918g+Jc2nno6
	yVf249h+AdNj51ANddF5uaGxywc7UvvU+LHHl5kws2CFnsMEfV6CELy0yMrVxA9R+p/EyRWcohU
	8aXtYkZIJJJhMp/KV5XxxDd76IOdISBCaZvETFzqTUgD/p4aG1JUeib7c+hr3SyjzPFQ==
X-Received: by 2002:a05:690c:6989:b0:7c0:56f:5b6f with SMTP id 00721157ae682-80122eb6b6cmr6121357b3.19.1781815310519;
        Thu, 18 Jun 2026 13:41:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6989:b0:7c0:56f:5b6f with SMTP id
 00721157ae682-80122eb6b6cmr6120997b3.19.1781815309792; Thu, 18 Jun 2026
 13:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com>
 <2026061837-enroll-fracture-d6f9@gregkh>
In-Reply-To: <2026061837-enroll-fracture-d6f9@gregkh>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 18 Jun 2026 16:41:36 -0400
X-Gm-Features: AVVi8CeoXPD-KXyWz_sAdNZW0u3n-M6-XlTFlQtVORk1WGOYU3a6bXr2YpvVXxE
Message-ID: <CAOu3gNgnkcPTW9wusNtjmdWy+pbEXrEa2tFhSv6pRALkH8=u6A@mail.gmail.com>
Subject: Re: [stable request ] backpot Fix ftrace symbol table corruption on
 kernels with CONFIG_X86_KERNEL_IBT=y to 6.6.y and 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, vmalik@redhat.com,
        jmarchan@redhat.com, Martin Kelly <martin.kelly@crowdstrike.com>,
        Justin Deschamp <justin.deschamp@crowdstrike.com>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pE-alqSVOHVfPLD4wsTxocWxPWtymmEQ
X-Proofpoint-GUID: pE-alqSVOHVfPLD4wsTxocWxPWtymmEQ
X-Authority-Analysis: v=2.4 cv=QrVuG1yd c=1 sm=1 tr=0 ts=6a34580f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=AtNCUuVRAAAA:8 a=ag1SF4gXAAAA:8
 a=ZdX3Yq3PCo0EtC3wvNsA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=2JgSa4NbpEOStq-L5dxp:22 a=O8dPV651JBBHpX4z-X7Z:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX940QB76H5ZRw
 9IoWoPFIoWXq6JthsV0b9xq942BobuJce/4c3fryuZgem1NZYkoQSnCClCV+Y+oDlmlbvrmj8Ga
 wm1RuaKYMxCsTMTN0udsuqy7PhXqiakXOG2S0flwNC1DRGC+QShW1zycH108oThJWoyHqCtmCwQ
 XCbaMDtwcfD/JdPFQJhncfC6dl4RIVHt50onz49VYhiCfyLBHnR8aOaR8qgm2WW6xqZSuBuOpJc
 PGdyu6L3tvGrMI8oVUeSBJVCNqcRBWcLFhqOnh4gGKQGU1QGIIoETqnPq1B+o5M5oMM4Rg8Gvak
 GqNsVFcwC6YZgUX4NfxKZFt0u83K7Mxx5aCt3EVFGcZL8/15T6UT0TyBomrLtCg3ee12oqOCOBf
 lJRHpXT/CTujONGOQX+petA0UWlnMSdSPpwBmGLKrsIFpytKbJi8AYr/vRZ1Ii0gvvXTmkDXnNG
 tJUTTCEz8MPqpbGToDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX94yWAibDjCZC
 DArVqGBCCsX9znLJkeyDsOsvSJpU4UZNPQmCHGj0VNJoXAHOqYkjukb09Pd9T5iDkKKDvnpRGdM
 vyL1VLaI5ErVQyfwuXYkKepiVPcVhhL5kw7oOeovsyJhelWI9utZ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

On Thu, Jun 18, 2026 at 12:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Jun 18, 2026 at 12:03:13PM -0400, Andrey Grodzovsky wrote:
> > Hello stable team,
> >
> > We are requesting backport of a 27-patch series that fixes a critical
> > bug where ftrace hooks silently fail on kernels with
> > CONFIG_X86_KERNEL_IBT=3Dy. While the bug is most visible with
> > fentry/trampoline-based hooks, it affects ftrace more broadly as it
> > corrupts the symbol lookup table ftrace uses to determine function
> > addresses.
> >
> > The Bug
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > On kernels with Intel IBT enabled, certain fentry hooks silently fail
> > to fire with no error. When IBT is enabled, ENDBR64 becomes the first
> > instruction of every function, pushing __fentry__ to offset +4. Weak
> > overridden functions (e.g. acct_process / paddr_vmcoreinfo_note) retain
> > entries in __mcount_loc at this offset. When the kernel binary-searches
> > the ftrace table during hook attachment, the presence of these duplicat=
e
> > weak entries causes non-deterministic results =E2=80=94 depending on wh=
ich entry
> > the search lands on, the trampoline hook either fires or silently
> > doesn't.
> >
> > This was originally reported to the BPF mailing list in October 2024:
> > https://urldefense.com/v3/__https://lore.kernel.org/bpf/7136605d24de9b1=
fc62d02a355ef11c950a94153.camel@crowdstrike.com/T/*u__;Iw!!BmdzS3_lV9HdKG8!=
xIv1YgayLfbu--18FVj-TfKphY1BTeDKw96R2VIwf_hMsCHTwvIY5tXSH0JiobtGGr612f24EfG=
3jscILAdzmr5YkXlw610SMKc$
> >
> > CONFIG_X86_KERNEL_IBT was introduced in kernel 5.18, making all kernels
> > from 5.18 through 6.14 potentially affected. This includes production
> > systems on RHEL 10 (kernel 6.12), Fedora 40+, Debian 13, and Ubuntu
> > 22.04/24.04 LTS variants. On affected kernels, trampoline hooks
> > silently don't fire, and ftrace function tracing may produce incorrect
> > results due to corrupted symbol resolution.
> >
> > The Fix
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > Steven Rostedt's patch series (v5, merged to mainline in Linux 6.15
> > via 'Merge tag trace-sorttable-v6.15'):
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20250218195918.=
255228630@goodmis.org/__;!!BmdzS3_lV9HdKG8!xIv1YgayLfbu--18FVj-TfKphY1BTeDK=
w96R2VIwf_hMsCHTwvIY5tXSH0JiobtGGr612f24EfG3jscILAdzmr5YkXlwR9cri4I$
> >
> > The fix zeroes out weak function entries in __mcount_loc at build time
> > via scripts/sorttable.c, so they are never added to the ftrace table
> > and can never corrupt binary searches.
> >
> > Prior Art - Red Hat Backport
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Red Hat has published a KB article acknowledging the issue:
> > https://urldefense.com/v3/__https://access.redhat.com/solutions/7143835=
__;!!BmdzS3_lV9HdKG8!xIv1YgayLfbu--18FVj-TfKphY1BTeDKw96R2VIwf_hMsCHTwvIY5t=
XSH0JiobtGGr612f24EfG3jscILAdzmr5YkXlwTmZKzAY$
> >
> > Red Hat independently identified and backported the fix patchset
> > plus other patches that were required for correct merge and operation
> > - details below.
> > They merged it into the RHEL 10 kernel (kernel 6.12).
> >
> > Their work is publicly available at:
> > https://urldefense.com/v3/__https://gitlab.com/redhat/centos-stream/src=
/kernel/centos-stream-10/-/merge_requests/2689__;!!BmdzS3_lV9HdKG8!xIv1Ygay=
Lfbu--18FVj-TfKphY1BTeDKw96R2VIwf_hMsCHTwvIY5tXSH0JiobtGGr612f24EfG3jscILAd=
zmr5YkXlwwWz7xxk$
> >
> > All patches are from upstream, no RHEL-specific modifications
> > were made. Viktor Malik (vmalik@redhat.com) and Jerome Marchand
> > (jmarchan@redhat.com) from Red Hat's kernel team are CC'd.
> >
> > These are the patches we are asking to backport.
> >
> > Patches Requested
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Group 1 - sorttable.c rewrite (14 patches, merged Linux 6.14):
> >
> > 28b24394c6e9 scripts/sorttable: Remove unused macro defines
> > 4f48a28b37d5 scripts/sorttable: Remove unused write functions
> > 6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
> > 66990c003306 scripts/sorttable: Have the ORC code use the _r() function=
s to read
> > 7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functio=
ns
> > 157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> > 545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> > 200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
> > 1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> > 67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> > 17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> > 1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
> > 58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttab=
le.c
> > 4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file=
 directly
> >
> > Replaces the old macro-heavy sorttable.h architecture with a clean
> > union-based design and proper ELF symbol lookup. Required prerequisite
> > for the core fix =E2=80=94 the fix patches cannot apply without it.
> >
> >
> > Group 2 - Additional prerequisite (1 patch, merged Linux 6.14):
> >
> > 1e5f6771c247 scripts/sorttable: Use a structure of function pointers
> > for elf helpers
> >
> > Groups all ELF helper function pointers into a single struct (requested
> > by Linus Torvalds after the rewrite landed). Required by the core fix.
> >
> >
> > Group 3 - The core IBT fix (6 patches, merged Linux 6.15):
> >
> > b3d09d06e052 arm64: scripts/sorttable: Implement sorting mcount_loc at
> > boot for arm64
> > a02656593225 scripts/sorttable: Have mcount rela sort use direct values
> > 5fb964f5ba53 scripts/sorttable: Always use an array for the mcount_loc =
sorting
> > ef378c3b8233 scripts/sorttable: Zero out weak functions in mcount_loc t=
able
> > 4a3efc6baff9 ftrace: Update the mcount_loc check of skipped entries
> > 264143c4e544 ftrace: Have ftrace pages output reflect freed pages
> >
> > The core fix. Zeroes out weak function entries in __mcount_loc at build
> > time; boot-time code skips zeroed/KASLR-shifted entries when building
> > the ftrace table.
> >
> >
> > Group 4 - Post-merge correctness fixes (6 patches, merged Linux 6.15):
> >
> > be55257fab18 ftrace: Do not over-allocate ftrace memory
> > 6eeca746fa5f ftrace: Test mcount_loc addr before calling ftrace_call_ad=
dr()
> > da0f622b344b ftrace: Check against is_kernel_text() instead of kaslr_of=
fset()
> > 46514b3c2c17 scripts/sorttable: Use normal sort if theres no relocs in
> > the mcount section
> > dc208c69c033 scripts/sorttable: Allow matches to functions before funct=
ion entry
> > 023f124a6417 scripts/sorttable: Fix endianness handling in build-time
> > mcount sort
> >
> > Fixes breakage found immediately after the core fix merged: arm64 crash
> > on invalid addresses, kaslr_offset() not portable across non-x86
> > architectures, arm64+clang using direct mcount_loc instead of Elf_Rela,
> > arm64 -fpatchable-function-entry offset causing valid functions to be
> > incorrectly zeroed, and cross-compile endianness double-conversion
> > zeroing all mcount entries on s390/big-endian targets. Without these
> > the fix is broken on arm64 and big-endian targets.
> >
> >
> > All 27 patches touch only scripts/sorttable.c, scripts/sorttable.h,
> > scripts/https://urldefense.com/v3/__http://link-vmlinux.sh__;!!BmdzS3_l=
V9HdKG8!xIv1YgayLfbu--18FVj-TfKphY1BTeDKw96R2VIwf_hMsCHTwvIY5tXSH0JiobtGGr6=
12f24EfG3jscILAdzmr5YkXlwvKl1eso$ , kernel/trace/ftrace.c, and
> > arch/arm64/Kconfig. They are build-time and boot-time changes only
> > with no impact on the runtime kernel ABI.
> >
> > Requested Stable Branches
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > - 6.12.y (LTS)
> > - 6.6.y (LTS)
> >
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > We built and tested the 27-patch series against both linux-6.6.y (at
> > 6.6.142) and linux-6.12.y (at 6.12.93) on an x86_64 machine with
> > CONFIG_X86_KERNEL_IBT=3Dy. Both series applied cleanly with zero
> > conflicts.
> >
> > Indirect test:
> > grep __ftrace_invalid_address___ \
> >   /sys/kernel/tracing/available_filter_functions | wc -l
> >
> > 6.6.142 unpatched: 562  patched: 0
> > 6.12.93 unpatched: 589  patched: 0
> >
> > Direct test (bpftrace kprobe vs fentry on put_task_struct_rcu_user):
> > 6.6.142 unpatched: fentry=3D0,  kprobe=3D46  (silent failure confirmed)
> > 6.6.142 patched:   fentry=3D46, kprobe=3D46  (fixed)
> >
> > 6.12.93 unpatched: Can't reproduce because of the non-deterministic
> > nature of the bug expression per a kernel build.
> >
> > ftrace kernel selftests (tools/testing/selftests/ftrace):
> >
> > Kernel                      PASS  FAIL
> > 6.6.142 unpatched   119     2
> > 6.6.142 patched       119     2
> > 6.12.93 unpatched   135     0
> > 6.12.93 patched       135     0
> >
> > The 2 pre-existing failures on 6.6 (kprobe_args_char,
> > kprobe_args_string) are present on both patched and unpatched kernels
> > and are unrelated to this series.
> >
> > We are happy to assist with testing on additional architectures or
> > stable branches.
>
> Great, can you send the full backported, and tested, series of patches
> to us with your signed-off-by so we can take them that way and we know
> that they work properly?
>
> thanks,
>
> greg k-h

Sent seperate patch-sets for 6.6.y and 6.12.y

Thanks,
Andrey
