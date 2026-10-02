Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF53A6B89
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963477; cv=pass; b=dp5/OiuF83ff1I03E1PQSOBbAyraBMXNwhm2wLyYZbiOSWyOxwPEYNW1xIqeT6V9NY2x85OmzAZkqzIZ+JnwO1/b+v5eemK6uD6gufkqGRowiodtvF119yWFqM2CXZqJ3h1izaY4aFwJ9U7JNZAfW6Jl4Lkoq6m1gpkbwuNcdyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963477; c=relaxed/simple;
	bh=nZzkVN4E9BSqcDIHvzqxmjz4QVuzVLP/YMY/poyCrxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY62kXCTgz0r9YAyUqXNB4KEoN2gut6dt3kyBma2dtKWeZQPMA33Ef+flQ4VlnOJ9z8NWtqWxwxTpUY2zTHyc9y4EXVGxxcfpNPrlXixg6lNE8ERPyiVbkIbqP4Q+L6hC9nSUA1gGMRHcolD9KeCHn5ZK+nYq558ID0PXZJEAyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=fZBnIU+n; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="fZBnIU+n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a006d3fe83so722665e9.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790963471; cv=none;
        d=google.com; s=arc-20260327;
        b=It8h/eTxRuRheftXbPpuhQTEt2cd8BIlFpCBHaHkYbFQ7CC9iSSFS0Lp8spsJUjj/t
         7EVvM8bFhCEyt+h2zcQ/JSpdVp5LduHqVU0oAoq3HZjK44oT9ZgkkN15Ahhf6I8x5plN
         JWvKH7tgwu4BbI6b/EmM0MLCKESW3JgsA5dMMqhqOKyrFIxchdBtkCfmy5BJDGfNNCK7
         ZjBTvMhRmmfGGUkXCxSKAmjXwD9XXi/TCwRyKIru+nd9cr4Qvmx1vdappE1LPnix8JLs
         8+aWhfSseY+6GghYluFvHZ0xR2mPORX73SJ45D+UoqsOhENWIatmM7z7Ec1aqxCrVsi1
         kWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjRLkdydNH/3hEGomUeQ+SayV25kXcztDM+0WcU6ndM=;
        fh=UuPENXgCgqqE20GSELxEIKEjwR5tc6bPLIcdg1T2Rkc=;
        b=DWlCwnBMrGg26J8ab63btlOa/KRkFtWWHV3LgkOdatNWM0gzx6OCRyAPEOjXkq7HPN
         17907nW9po00dLpG42QJl4+DjDZRH7eyN3LjxBmFuQrX+vkH2J5QEsL+53Wvnj/A6IJZ
         4tg/JrQP0s4qQkJ97ZJumsbYjb9q/vQE6+3nJH13nAxFSbaZnbIWCuC9uNAFluHuDoSB
         ToWFzfGg65iefuqRTPMMsoiMu5GT9k0cJ2riN+t1AZ3TyD0U3zalKvy+0Ac2SYNc4GVE
         cbUTOpzghJLCfi39yDajT/+e1h+3RzhraYSycELYzKOBOWjYOtEVthx88jPWZwKP6FGS
         mgvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790963471; x=1791568271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IjRLkdydNH/3hEGomUeQ+SayV25kXcztDM+0WcU6ndM=;
        b=fZBnIU+n11krhpzVwUJTdIeMx48YQOoasgu11dWqDQSBeFutdTsb6BFXfmi5oojz6q
         kbR7VnmynxieKV/K1dL2jnNqoCJP/ILDktjVVdsQdK84JQpgkc7QbpVJWKa22WoZibfO
         uoCuzRw+QzryPoS7edqVT4vVod5Z+Fe3muAcoUfEaDJSjMX9NZSBolm5eiBa33KAywWf
         FzLBi6w/2vIV1l0MRjtmP2Dbs/E6JlVKPXw3j4+Sn+S9Sz/0PjKy4b8PcPxyXQkGDttt
         D+JIlIbqmTOU5mIyzufleCuZvvO5y6aQrQxZokF5LEhvlIUiFpgtH0BiZvwMlHeCkPxo
         pB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963471; x=1791568271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjRLkdydNH/3hEGomUeQ+SayV25kXcztDM+0WcU6ndM=;
        b=AEu6DU72B6R9ljXFDkAfeTAySTHPhthrgOISZG/ax67/jmA3F43ok/HQgeZHa1ODbQ
         bPdaziyKntos35HihyQ/tBvSFIlZXZmJGYAPND8Dt7CjCStrj/z0NUFZuxGeHOfqPSGh
         I37KFZ6K8RRL/6FJc79tLV/bIYk4/3z/5Y4CIqod6Fot43PPQC/UzubwJXA0FxQNpwm1
         dNuMNXbxismYYKKtAepkZo8yJ8YWFOZWhhcT8F7JZAcPtx7Ub9L9x5xf8ZFsP2B+ZlCa
         e8Ilt73/fdMWEF/xkWZEsRr92hteg/yUoRzXXO4wjsnVsFP3L+WcQdtQdY65s/zyv/Ae
         JwgQ==
X-Gm-Message-State: AFuF++mPhOj7luqMy2KFyg/nV7cSqN2pLgz/zrhGhPbMmViSt29ckRmL
	KXqelymzZlXTVpIl/5TAHGDHhABznsIKe8SIFz1QF//DbAKwGNCNM3lofxElTfozRoZllYd2RP1
	jSN8oaeteqbsX09RK1i4YByRylhprS0xaA4YfpnJ//3pF+WudlD49y96OnA==
X-Gm-Gg: AYBFou0TnJfNoEXNJRpKcVH70vaeHQg7y41XViN0MFwauEJLDO9jg9eQ7dM/+YlRv++
	vfS5/oXx4Kdk3DMbZ0lrZwqYhnWr+ZZ/LZYBJV/7gjYH44HNsZRiCxoWOQOXEDHn+8iNgW4C4nb
	Ghd646lSw09CoB0Uz0YyDGgID0ilw7pvOS3XTA/8eTV7DB3/c669uGgP5vjKAGZWxmlFgU4lEWy
	ES9/BCvmT9N9ALabMg8KbXVFcRPsG0wr1kApHqfDTJ1xR68UBH/lWZrTElG0/bgoUyPSdHSo9RP
	8FiDBXK6I8PEDi3X/mdaDMvkcEIzJeGgqJVSTCci4ydvPLMA6zizGbbKfC/rgYLAywpmOb5Pgzg
	SxjSJrQKCAFBSPGZebedM69B1E498YdNuE9G9znMYfLdwsg==
X-Received: by 2002:a05:600c:5888:b0:49f:d742:97ea with SMTP id
 5b1f17b1804b1-4a01eab3237mr108637715e9.0.1790963470511; Fri, 02 Oct 2026
 10:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930024505.96440-1-artem@trailofbits.com> <2026-09-30-1-daily-reply-0014-lpfc-sfp-info-mbox-timeout-6-6@kernel.org>
In-Reply-To: <2026-09-30-1-daily-reply-0014-lpfc-sfp-info-mbox-timeout-6-6@kernel.org>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Fri, 2 Oct 2026 13:50:34 -0400
X-Gm-Features: AclHuK97lTiqaebg1I8sTjOuQdYcc3iS6N5jctNtVuQ2foq17QpUfDpnDgfMSbA
Message-ID: <CAP3zxaCrgUA4tAtd2nS=b5sn3xSQ3LBiRRFwsRMeCGvHrhgprg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Justin Tee <justin.tee@broadcom.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <james.bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Ely <paul.ely@broadcom.com>, jejb@linux.ibm.com, 
	martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

Thanks for catching this.

I'm working on, and will send, a v2 addressing the issues.

While working on a fix, I also found what appears to be a separate
mailbox timeout/completion ownership race in both 6.6.y and current
mainline.

I do not have proper hardware to validate certainty, and can't emulate
it in QEMU, but I do have a hardware-independent KUnit test that
reproduces one of the failing interleavings. I'll send that separately
as an RFC to the LPFC/SCSI maintainers.

To be clear, v2 will not attempt to fix this newly identified
potential race. It will remain scoped to the existing backport and the
6.6-specific problems. If the RFC is accepted upstream, I can submit
its stable backport separately.

Thanks,
Artem Dinaburg

On Thu, Oct 1, 2026 at 9:52=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > [ Backport to 6.6.y: v6.6 predates ext_buf and uses ctx_buf for the SLI=
3
> >   raw payload. Restore ctx_buf to the saved struct lpfc_dmabuf before
> >   testing LPFC_MBX_WAKE so a timed-out mailbox's late default completio=
n
> >   sees the DMA descriptor rather than payload bytes. ]
>
> This isn't safe on SLI3 HBAs. When the new 60s wait times out, ctx_buf
> is pointed back at mpsave, a 40-byte struct lpfc_dmabuf, while
> out_ext_byte_len is still 256. If the firmware completes between 60s and
> the 300s mailbox timeout, the SLI3 interrupt handler copies those 256
> bytes into the dmabuf. That is a slab overflow, and lpfc_mbuf_free() then
> runs on the corrupted virt/phys.
>
> --
> Thanks,
> Sasha
