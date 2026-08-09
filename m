Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C884199E89
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300357; cv=pass; b=HAKFuuaGtYUHAqIyy1yUFdixGLS9VyiIsw1DdnBtpU0XpYYw6NenecNNDbj7jdNIyzEl67MPb140gOM1MfSYkhpxd08/Qwi12qQFAdovB/YKmtKTH4vK/JulsaHmF9swLnpiB3ks4+3srPKn+QdeSvPof2EpyX37txOJC44ryj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300357; c=relaxed/simple;
	bh=ZRvxCPN/Pn6xKN4kzylsdN8URZcXpD40RKKAE4yvtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEPd83kJeMsTXSB81dyiUDJ8J9tntcr/Li7q6LE0mFBQ2lGGZtZiYFTtFAJVlAwlqKY6MAMvrq6UB2q81eCWNIohkeeqmDUeKyZg3NMHIwTHBcSH5A9reob4ivwdmlNCHCz+obwXGfnyh2Z9/J4m4t/mTBvZkeeYcuLbx7TAwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FfTink7w; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gFUI2ecx; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FfTink7w";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gFUI2ecx"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679FmJIR623515
	for <stable@vger.kernel.org>; Sun, 9 Aug 2026 18:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=; b=FfTi
	nk7wAnz35vkjyqgaz5kxh8xN/mxzF5PiLfKFsxowFPJ9BLT4e4XeNrIcqhwaVXWE
	dGBuWprH5ZuhY0JxYqZkg7ERi1/Uw3uQDeZL5p+GAl04552mj2ToUocoVEuEfxa0
	jGf+GkVtd58SX5y0mu7mJ/JIAFmr21JTqSg6ish8OBzj6wGxO2Br5377wCjldAXd
	aKt69xzBWYA6ZnkoPLT9g4ZrFweGpVG8siwTezwba1nMzPleA5qh9ilPbtL81hok
	WQcJMzGLPZuXrL9ha2pTuEPlC1AHsbYrCXXU+1HjKsbLzd6VCqKhKFOUC5N4Oo8d
	LUMWSqijyLQ2I86EAg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fxf8xhb0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 09 Aug 2026 18:32:29 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-82112a1fe2fso41054977b3.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 11:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786300349; cv=none;
        d=google.com; s=arc-20260327;
        b=GHf0Urb0oQqXblWbo9FZSJSc4yMfe9IrGSyYaazLVfP9DYBZNsSXMy/JQXFvPfPdLV
         l9KBddMhihOeE9bG0oao5nT7O46/eRvI85MXbAeh6z+k3wDDsN9MrG/BCB3IGW5/OGVm
         RzF8EBSsPBrUG1WFE7NeYyI39l1jcLDejqE+2gNliWG566LJyhBpnPP7ml5043cgAQMt
         Zr+yu3UHVo98C6F3VLsNxEOklpQbBV7Izv30e8VUm/jsT2HKFNA8PpTZo3x9L5r//ceS
         /Cw3xPtiNksRzH+41yTg9qAoyjPzmRymfYtIuEJUu+C3ICaQBP7CWRFhCojFsWQ4XK1p
         IdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        fh=DcINTArWVGn4vAAXL68EB5Fl8CM7m1NoPuDPEwH4PtE=;
        b=q6cEQzM+ugQh81HPp+6uiKtzF3nq0X4fQGIgqCIuzs+K5Hstubss1is7kk1ZvH+35S
         Hl2klYJUl/EmNUe6KJzbXmpyk/qi15VAWoNwMmRcIJD95voDLzVOFNaRChUPoedA90ef
         PNMjG2ZOjljgmhxCHmUzLYK/90LwtlE3r5L8Qa6B8fPaVEO/priN9YsSalyNahK4H+cX
         dMz5uXJ/+Z97+KmWEkf4/hx/xleGZhUiZ4gjWi2TXzdPoYMT5mNBGiEH4JawPnMzYmSM
         iGtUPobHTJormPHtdqPpRr7vhcAKFfQ5Ye37yDcpqhamKfH54jx5ecnf2kErI6RWepyg
         olQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786300349; x=1786905149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=gFUI2ecxASqj86RV116VD5mzrU5KAA/rbb1xhqriAdMmI9cPJveswvJ71H3YGcfjok
         kJFDFvQBuproli1/q6go3sHtL3OGBP6WxYsJgMpeb2mfmRDZDlZBWKV0qLNYH01FomLa
         SzsO909KdkM7dwdTgO0szrEiZtKk7TSLADHNYkcybF/SG6S+sMQ5b4tp3z1JVb4Qlrmb
         OPlknHMUlotlus548ElwNxz4ZiwUN4ds1ZiTBJv7TcCb4p24FfzKM8ObatNScjjmaia3
         bayhQrZ/dA25V0vzx9R+tj2mTmHKtpri7FPpaBPnzX9BlnwpOMmcj1/dSxUfKKlUCQxi
         jMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786300349; x=1786905149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=NkEu0+fOuqDlhdZ1eZRT06fktZYyOwcpJwq/40oC/JrN+rW9PwqWEpQ4Q7/FJEXCQc
         wkb+aMeALE5WvL/ABCZiIPLSvhGcXNhnMa+CAPOxCkY9YUUwe3iw8HminzZPavCJcfzg
         hN1L7UFGmbDZfk0zn8jh62W2ncFJvmLEV4l0HvDXpabxeHtvO6pu8lFzHFx2ztYkyNHi
         Xx/ZHYn2ApABSi2bAE/Vpj64/tNcG7T8oKJ8QVdnS1Hr47s2VedJ7s3czHf23pkr1zGx
         TuJRKH95XUnWg+L4RKtzPq+wz+ZSn8ospOiRTv5tBUhAbrvCANcsS9i4KI0KDNVaUF4u
         JlYA==
X-Forwarded-Encrypted: i=1; AHgh+RozW6tcdCyXhnE9j1unMtNYYvug0gMYro0ITKCELgSRO2VkMxwm7pdy/Le1L1RfXQ2OeL019Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7A8x942PzChB5V6hLOyGm/b6g4om+V7mgoGbAzAAFIcTtBtJQ
	x/ExBROXg8suUkFnlDLVlfxmIjFNjZAnw6QSuT9lcbYZaCEusEvRAuck/kQGXgMFhVdt0Hw1mCn
	f4sXr78QYIAbcT4pGh9wHj5KpuVe/RCJLRAd0MIkxgK5icN2uBFkpNnmP+GkntwtCY+E3hIPwuh
	X6tGFEcvldAbN1HAnOiKQWK43UzaxGeRvP
X-Gm-Gg: AR+sD116+Rm4Kow4HLqQL7ZwH9V7NH5u+uMZPPjGZrAjA1HQYR8XyS7sW88xb1Iz9qO
	3G2NSb8pS0sdPGGuHJ/ml7h/yTGOhN9kUMGuULx6cuGFcceTQXNzygGQlUCCl1l7TfJPSk935TZ
	JpKKyf3B8QLAG+bzvNrkA9W5101N9NFEXM8+Rot5dY/0CduT4IsTTMNr5r6Q==
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id 00721157ae682-8257357f604mr89550517b3.13.1786300348893;
        Sun, 09 Aug 2026 11:32:28 -0700 (PDT)
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id
 00721157ae682-8257357f604mr89550147b3.13.1786300348210; Sun, 09 Aug 2026
 11:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com> <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
In-Reply-To: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 9 Aug 2026 14:32:16 -0400
X-Gm-Features: AUfX_mxB61PImxk7Ub1YrOZ365ALM_DPyxKzut-8yKDjXWIjCGfwpeEyQKycU1U
Message-ID: <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: xyHm5-mA02HNgpYB2SYMOXEZXy8g1QuG
X-Proofpoint-GUID: xyHm5-mA02HNgpYB2SYMOXEZXy8g1QuG
X-Authority-Analysis: v=2.4 cv=VtUTxe2n c=1 sm=1 tr=0 ts=6a78c7bd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=jPl8K6pqbzkCHX85MxAA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX71l/RyHiElPk
 0UwvNocAz7vMeUjSHP3J32IhaPvzV01BxldA77pVbQ3zYcxx2hdyybyMBN9jQDvYQE0cuV/b/fv
 0ye7EIJOR8d6sa5Wj4dxAE6GQAfLjtx/Mc97aMVLuatKrerLayrt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfXwCxuBLIQm7de
 LXIP9nwE+9HbTcZKRs1WdntzAGyQsE8JXnfJvB7oAoDGKBQPBItt2jPKb+yMTRWam6M3mAD6Www
 RAhaxqqt5Cbd6u7HXrzmSRgAN+399QU5CFX0bI4H7IibWsWcjw2UmwyotEWeZLb7nIdJC0kKN6Y
 QcKNod35cC5e1hyQhIAyJLXNKRl411eZR3mzTzqVDZBNphgGlUZkqbVtHsDLb1tyXxuq6hctRrn
 jE7g2AWzPZW1f/ZDHBatzw8mDekix1kZjeh19CjRj5PrfHg9uSqm0rmqM5HdmLMYLsBVZ9xuFjg
 vGETT5hbCmn0kdNe0Y/j/aeRqNCavP2yZWA/cHye4mnxwnmD57/9f7ch8TfjedfndxeEIVhgiWb
 XmV12A4M6lfuGCxRa4SREirbc90gbN/ariOzNQr7A5ISVbWWczDQjfOCQn/4bGRAYfYBz3CSPua
 SRubTh1RSgHu5dG7o7w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090168

On Thu, Aug 6, 2026 at 5:52=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > > callers rely on ftrace always being on). Refuse the write instead of
> > > leaving it in an inconsistent "disables some, not all" state: return
> > > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > > unaffected.
> > >
> > > Update the docs to note the deprecation up front.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >
> > Sashiko's comments make sense. Other than those:
> >
>
> The bot has 2 comments.
>
> In my opinion, the test-breaking comment is wrong as he looked
> strictly at this patch w/o reviewing the follow-up live patch testing
> changes which update the tests to avoid breaks.
>
> The cleanup comment is valid but since we aren't sure if we'll need to
> revert this change later if it breaks userspace in some unseen way, I
> wonder how extensive the cleanup should be? Steven, can you advise
> please ?
>
> Andrey

Gentle ping on this question above Steven.

Andrey

>
> > Acked-by: Song Liu <song@kernel.org>
> >
> > > ---
> > >  Documentation/trace/ftrace.rst |  5 ++++
> > >  kernel/trace/ftrace.c          | 43 +++++---------------------------=
--
> > >  2 files changed, 11 insertions(+), 37 deletions(-)
> > >
