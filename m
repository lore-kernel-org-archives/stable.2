Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E343CECD;
	Tue, 16 Jun 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604834; cv=none; b=e95vIZvJYSV4dISEAB+4W9sWusTSXHfa08C4bOYTBwf5ETK7u6J75NIKpyTxh2+VMe+uVPfLQsXPStyY/EpsJ9oRDSHRLTsOC7zbVJuGsJBpPj+tA7Fr57SCrgFMaWdPlmBDjGRnVPcYk0G1szI5k5Trn9QYgzh06xGtd3s+UKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604834; c=relaxed/simple;
	bh=h39yfY9vKWcnHsup000s5QqqY2OYLsCc/BA54RYV6Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdELQyoRNjqnN13t/3t+nqhjRGZ8D9wehBXXq3wLUh27+RBWN3qK6JzX7wNPiyww2DSAZD8594O2jCOI7l0aCGOSN+pJBwNzk+LNYx6wJq0qACJOJjruCj2XsjXjrSZRN2SOiNGIsRQdDjLTJ44PInWiFbzgof+XclPxB3WsQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KLRdeFA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkG//VcB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KLRdeFA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkG//VcB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32199140013C;
	Tue, 16 Jun 2026 06:13:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 16 Jun 2026 06:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781604832; x=1781691232; bh=yscGnKM6Pn
	1eN1WlHGZpo/1egnmUAfNS3O+ct8E0NcQ=; b=KLRdeFA2u+bknoVpi6wLPAu7Yt
	iJdd2/Ii38ypS/HihS6Z208HihWl6c/A269wVfmNZUcYPRy3GjKQGkOU6gC1HxyP
	2BUp6/woB2mslX+AU9Ho0gYMwxvcFE5p64q0CWPnBqZsatmqrd6lvrhXAclNpPka
	qebzk6gT/6/oXGsthzXU43MbVuF1ZoTNub6E/rCc+Mh/Hb3o11fRbMGKaaHDQnkW
	yZgJCWGQYI0QOG3RMmWA5ea0dX0dhcka3E1BwGV4ca1zS1Otyh772wajEB5/iW40
	Y0WY/5C2T066kl8/Cw/jLhklnwm7p9trBzdOUuIa9GmAUmOhq/1Gx0nvF+3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781604832; x=1781691232; bh=yscGnKM6Pn1eN1WlHGZpo/1egnmUAfNS3O+
	ct8E0NcQ=; b=AkG//VcBlWPkGp5+QX0CqU957h5/2UEj/XMYVfh5TkBa5JAEwFD
	GZ8so3d42RbYMkqnnoEzqiPcSJIGRn536ajBRJAI/4q/OKVIM+UpxSBtaPLzNUwV
	lJtrA0FNiuhAUbnnGbSavDm5A2neCdBdjRhYIggcHSxvHWcerXwmZX1XrSC3Pcad
	kmue6YuS+5uAhjahkx89P++vVaEXZ49ff/6J49vcIttgBpjtKp6p4Z4Y3S3jyjBo
	mCBw3GcrZRNAZAyg7ZFfkpAFrb0+gxXM4VHkLmT3YxnqfLr//pzLvX31thfL64Vi
	aEZ7t4WQHG4AgF1k9ymbDXashyytfdr6TNQ==
X-ME-Sender: <xms:3yExasOq_hfD91-KgcnzcWI-InKHHQ9H-HHRzn9NZAoVno9NOjh6jA>
    <xme:3yExauo0oR8mN_VBvyV2z1-LxDwp8eZq_lCpXCWi-YTr2iBxkchLqxEuY-6_EOc8a
    r6WETbqjxZD-JCQ-kB--2PzVfIzJwjaT4rvI4k60d1ry0KMag>
X-ME-Received: <xmr:3yExam5hIbugwhUOCO_yLy-bHdS_WgFM3aglR68GwbEZAhD7kNSGvV61>
X-ME-Proxy-Cause: dmFkZTFXmFjhiZ/J01Wd7/tv5c36hbRy67DrxzHLzGUvqVoob6gyrI5rUk2TRsZF3TxXXy
    Eqgfu+llVeu6X32bw3wTR93BrAokj6h+nD5mSFQR4EGjTjQgXkzrvdL1oZSrLLHJ5ZaEXP
    eaW04bkL9ANOpZ7eqEK9sl2/phNYVie5S4DBbmqvXJ0eCIm06lqXVM0lQBIw/hHOkFNqfb
    AydGSX9A4rVRRF1ozlS604g7aojkY6CaiA4+XH+1yJ6XUBOQRJQ5hCsI91GjHNRmhlzUQo
    PVL9+m9l+5dHMCHIJ1uQ0rbTva8xA/YVRH20faRhiH6bLyY/lpTO7/3+HUanxXwMnE9Of5
    q6wYPNxxCAigFA3VjxcRBu4F0rl7MLCy61b1Hco2V1UgkgiypxPIJIROEQcnjinGrDAz42
    6lFtYSILqUoo/GUYk91Be7xYKOFGgSI5BD3CvpndRESrU3vmNpE/RaD4bUZbmB1UUtFGMx
    ye/XEzKUNThptMfX88SZhVxjwt/wnco1txQiuCkWjjXst6uijKmWxjnYHlg47bqVb8sR3D
    AlCdyKGyB24en+/TRzzXfEdyuh/kbAwuSDoIjBF7O75Ohd+l8rkFEahWX8+yNoIixeT4Pn
    x8Z1W31Tk/QVtuv3+xtJIVxNI5hpbcDragT9TeS9YWwZL+1+N5CJgPZ13c7Q
X-ME-Proxy: <xmx:3yExak8eKc29oJxfcfyK0Od4a-87_oCLG8W7UXqv6u5hrVb5PsXG_Q>
    <xmx:3yExaicnt6lfrQcLSaZi-mmr0qYemsDudfJuWTVe2e4R7J3yeMRy-g>
    <xmx:3yExag1XSy9XrCi1pGc5bJxCCqyfXk1xkzZBnsX_ihulF2q77cYF6A>
    <xmx:3yExarpV1hTtDrxhQ9JhKiBTEVTSk53lv6J_cGdraz6-SgpZJDtotw>
    <xmx:4CExauycks29AcIPDqsus0W6Sv8WnerBEUU0rBmVMLdUsXvbFirkjbpb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 06:13:49 -0400 (EDT)
Date: Tue, 16 Jun 2026 15:42:45 +0530
From: Greg KH <greg@kroah.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]" <bpf@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.1 v2 5/5] perf build: Remove
 -Wno-unused-but-set-variable from the flex flags when building with clang <
 13.0.0
Message-ID: <2026061639-curfew-hexagon-386b@gregkh>
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
 <20260520163320.3073037-6-florian.fainelli@broadcom.com>
 <6541a5f4-a150-44b9-af27-8712cdafc1ae@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6541a5f4-a150-44b9-af27-8712cdafc1ae@broadcom.com>

On Wed, May 20, 2026 at 09:35:02AM -0700, Florian Fainelli wrote:
> On 5/20/26 09:33, Florian Fainelli wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
> > it to avoid:
> > 
> >    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
> >    make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
> >    make[4]: *** Waiting for unfinished jobs....
> > 
> > Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/ZNUSWr52jUnVaaa%2F@kernel.org/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Change-Id: I8db8a372d1e83d26fbe8beda2bcf4d1a871a2b80
> 
> Argh, sorry the Change-Id snuck in there, let me know if you need me to
> resubmit.

I got it, no worries.
