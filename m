Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AD3C98B5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988293; cv=none; b=LPoX5tRKlAGDw61qyi5Oryp2UEI7b/r6iIDr9MC3/xm6Ycrz3d5AJAYgvP8lXyo+vnjE+WeteDdkr7X2c68WJ4yF38yvgvVARKrUTSo186dnq8zIHVNC6XXTRhoH6yth1OW4pxcrWA4KdZujvXEhBP6zqR8kFysFLsm78BeCv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988293; c=relaxed/simple;
	bh=2JNeQ04IMcKNTxofpXfLMMlWn+o2rMxFXN3X10QNLJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6fvY76gq5FsjbOyx0VCAWNHuIpqW0EuxD8DfRxSvGg3JRrFhaiPSRsng5AeS7r7uBYABYqivgNoZqhPK5fxKhEbY17zqsYYrgGwsquriX1Eu07mdyx4K2U8UUsvnR6BhG4YoNWSHr/3tnNmiyDx38Rx0M/cFNoninofyQut2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=dHL29DPq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="dHL29DPq"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so41513601cf.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788988291; x=1789593091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NcvcU2ZyDvNJc/uxVV4o6h0SAHgq94jw2tNDLTGmzOk=;
        b=dHL29DPqONYxt2qOFJzoHcVTMk5Dy4ovl81mIpkIyvJVY5Ji/WPD5/R+Dv7/bzRMrp
         J7K314wpz7OZcLNxH8ojE1pfq5WDF5pyTi6MPYW9N4sQccUmKcYKABtyQkOX60l3+qqQ
         L7+WdFNQSvQtpkwmfrY6nDmrmBp8Rqr68kCjQkI8A3i7NXnSZL7NMUiEPXZTiiyB0kAv
         ikDAelVSxeO7MFk/koaHGrCg+wGvRdSgO+zlVDb633xbwNRnbRyDJGRP15fwivUM5Sp9
         JMBrL4R2Zl2agrj+Qz6O9BZ6M9xYRwBgaP2EtJiHtdqOvx1jMl4dbz0IRkvygopVUcCR
         /RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988291; x=1789593091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcvcU2ZyDvNJc/uxVV4o6h0SAHgq94jw2tNDLTGmzOk=;
        b=p8C9a3CX4T9JcVxieyPYliuluO1arT5MtYQ47Uao1Yg5r46Bo1+PpnF/u0T1l2916R
         ryT/tcGjd6pgn5gxVJOkLNhUHsRvtAWOSZoMfaVG1/Fm4mxBPJGxC6V6R48cAP9MHyH/
         AZLuMIWRA1+akwZw9/oUDAsIVY6Hp8DD8lUrgMHPrl0wOOKcqT+zP2xM3lO6APzHo0XW
         ZwFMhpf7kC4r+DmyAfPGUfjnfDdRMTLL5cT0EuL+CdgmAzOZz/JCcK3zI1G9kqJyBsGA
         JU6ijcVCM4dsDgGAxirtXxQ3fzHDqJDt33r4zTwwdIJQLDQztfmN75H53WAbWmapEseZ
         9HMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZIAHBzfS2FYFDw8zyim4NKpCGUp7ECJx75APJPGHYWLd0HnmrvFh9+AcacEYwoz65GxgbjxM=@vger.kernel.org
X-Gm-Message-State: AFuF++lBvowfsOS1MU1TjlG7I4u2kfdTe4ThWlSM6aTmU0xf2ret2F8A
	MFK31OIkYU3/VGUAVt5bKwQufVgoWweMQmiOjCXdib9cxb5aGc5gKHissbhaR4EC1Q==
X-Gm-Gg: AYBFou2HyQk02Jlw9ngRMp0hwSkRTPYE5IIxVKgK8eWas+Z4AIVAFPVE/YRcFxtNmCB
	3/DxdhVr47xyurv4cYCpZbK52Bld4ByV1ptXdKkOzX7W+zB5S/diCs4Nj/+bdzt7N6cmnTTq2nf
	ZfJsIM+tvY3iTmvRD6smm/VG6jWQwWfvbqKUcLAF961L/DuAEKtVhPjD/xwpOQQ3cuV9FmAWQPj
	QUCBOOqr+NGH8O/gbpB682YvDfTrzEoiMctnPP3TtbR/aQeXE1SfBQbEbUOT9Hc8aadR+4VYejN
	RqAA9WqHQh/QPtr5rHxAA54wdyQSrc8k1I79o7zKEu7gEtdtwrwFFa/o8m7rIAzoXpgSEkPOSZs
	T6Ux4IuztclX0JcZxohXvf0zwMeVLRi07DjPGr5MWcHvtannFL/LDnd/1/SEUPMNXw0z8gkfrV9
	cDB9tF+VljL6c7807TzRhFJj2y1BFAJd9l4GJIJH/i9JFnZ+U6z9LnLAbQ2y23lzOrBSwMmiam
X-Received: by 2002:a05:622a:1dcb:b0:530:aa4a:993a with SMTP id d75a77b69052e-530aa4a9cc4mr64563791cf.41.1788988290773;
        Wed, 09 Sep 2026 14:11:30 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054116466sm150525631cf.6.2026.09.09.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:11:30 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:11:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, boqun@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
References: <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkymywth.ffs@fw13>

On Wed, Sep 09, 2026 at 10:49:30PM +0200, Thomas Gleixner wrote:
> On Wed, Sep 09 2026 at 15:28, Alan Stern wrote:
> > On Wed, Sep 09, 2026 at 04:45:15PM +0200, Frederic Weisbecker wrote:
> > I can't tell what you're trying to do here.  The UNLOCK-LOCK ordering 
> > in P0 means that P1 sees A=1 before it sees B=1.  But nothing in this 
> > litmus test forces P1 to execute READ_ONCE(*b) before READ_ONCE(*A).  If 
> > the reads are executed in the opposite order, you can see how P1 might 
> > get r0=1 and r1=0.
> 
> The problem we are debating is:
> 
>     C = VAL1
> 
>     CPU0                    CPU1		CPU2
>     
>     STORE(A0, 0)
>     STORE(A1, 0)
> 
>     LOCK(TLOCK)
>     STORE(B, 1) // 0 -> 1
>     UNLOCK(TLOCK)
> 
>                            LOCK(TLOCK)
>                            b = LOAD(B)
>                            if (b)
>                               STORE(C, VAL0)
> 
>                                                 c = LOAD(C)
>                                                 LOCK(c->lock)
>                                                   a0 = LOAD(A0)
>                                                   if (!a0)
>                                                      STORE(A0, X1)
>                                                      STORE(A1, X2)
> 
> The question is whether CPU2 can observe C == VAL0 and A0 == NULL before
> A1 has completed.
> 
> My and Peter's argument is that the sequence
> 
>    UNLOCK(TLOCK) on CPU0   -> LOCK(TLOCK) on CPU1
> 
> implies RCtso and therefore the stores to A0 and A1 on CPU0 must be
> before the store to C on CPU1.
> 
> Now because the LOAD(C) on CPU2 depends on that STORE(C) the
> LOCK(c->lock) ensures that LOAD(A0) can't be reordered and because of
> that STORE(A1, 0) has completed before that.
> 
> CPU2 LOAD(C) observing VAL0 has a data dependency on the STORE(C, VAL0)
> on CPU1, which as argued above can only happen after the UNLOCK/LOCK
> sequence CPU1 observes the STORE(B).
> 
> Subsequently LOCK(c->lock) has a data dependency on LOAD(C) and the LOCK
> operation prevents that LOAD(A0) can be reordered before LOCK(c->lock).
> 
> So despite the fact that c->lock != TLOCK the UNLOCK(TLOCK)/LOCK(TLOCK)
> sequence, which implies RCtso, the following takes care of it:
> 
>     1) the data dependency between the STORE(C, VAL0) on CPU1 and the
>        c = LOAD(C) on CPU2 observing VAL0
>    
>     2) the data dependency of LOCK(c->lock) on #1
> 
>     3) due to LOCK() in #2 LOAD(A0) cannot observe the STORE(A0, 0) on
>        CPU0 without the STORE(A1, 0) on CPU0 has completed.
> 
> If #3 can happen then that would obviously cause undebuggable data
> corruption.
> 
> I hope this is understandable enough despite my brain having melted
> several times by now while writing it up.

I see.  Yes, your analysis is right.  And Frederic's latest LKML litmus 
test confirms the result.

Alan Stern
