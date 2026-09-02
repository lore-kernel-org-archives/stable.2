Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FB49B21F
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354159; cv=pass; b=RRYjiF5Z+IUr8Z2bEKevK+jZ0ndcbN0M4s0fsVNZcID81XecInzfXdGSd4MQREcZvl53CjZJWz86UJD2wIO63hNAchpp5VttUVti6PH0ebe4+6BtRhTR8jLGJFyyIUzSgJkvfHVQVsusgYPAm3bV8zsvxY2Izc8xVSWPj+oqAnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354159; c=relaxed/simple;
	bh=2IimJgpWco8Ido6/kuXcNwOq4ais6YquXn+nJDg20ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBBy3A5rPw0U+dpAxHM2J6ODmScbXf1/I/TmwsuINJgLiyzGLkvWk9kjJ6q6p8BphS8TLnX5uA/vTPY/+Zzj8nKiOcJ359KhLqxfjxa7rkqIUZ1ZlE0CYLA+DNvzwHMxJ1nr+hHadYo/1SHL+qE3AoBY6upciRu9mdhidxAKFQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnR5h1Uc; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnR5h1Uc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1271144a12.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354157; cv=none;
        d=google.com; s=arc-20260327;
        b=g5WsvbkUgHH3IOT5A7CPHGPB5s8HoFtbtRq9KSJfdfvWt0Up6dNoujJxSsQKcTFYbW
         7xv+EYWsitYDom0FN/RWQvLU1SB04Up9e1tq0b7sFnoyLh1USUSpcEL6KLFGV1cQ+NxM
         L9hVb/PLi0Qg5FNmpQqt9yXwFR/3W2WyX+EGZQW7tWFP7Oo4gUalnvC1XvZUeYYu9P6Z
         Oh/A69Oyp9VWZjunH5+A2FDHs18mLQoGbODJA2UwpmQD6WAS9cnyuyO8OKfCRMuOL3+n
         4M4PuGLLIsvYftFaLcZLjBNGAMB2fV5XjQMH+ZtLukKOUI/xXgMXXGOEszSzxBZEdbHn
         P2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tZ7hMm+JsrbyLw5rJV9QF2bd+yWe5jIr9Rjm13SbtbU=;
        fh=P+aH57dhf499efMXUoLvNXWYKKU0KLyeGtI29yo5oPA=;
        b=mdYuME5gU0KkU2Jbr9LSQrdfHhFEIeQmdYlOITySVOkxdcv+piqIjg1i1juyUo9NQS
         ddJVE6t0aLbHCJzlfpLhiVoMW30YKTQpuyRuLHn5iXNUpMKNUvAqvzqUKw8V3Ofinz6P
         ZuJuQPIS4G2odhUZNu8KgCPy4WqYFHJaRHqFGCsa61i5A/Fyha8dstgLA/10DET/yTL6
         tMFV9hsMMOazYzxtObmaltCzVm9xdPtGPN8I815rP9RCCb/Dy5LUCK1cJWZYyebQL3d+
         fP3ZI1BXBeKKIAJe4sKzsTpMB29NUqr3ukGpMMTcw4R+PkrfCGzleMQ6ICQpqIaKRclf
         wbGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788354157; x=1788958957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tZ7hMm+JsrbyLw5rJV9QF2bd+yWe5jIr9Rjm13SbtbU=;
        b=LnR5h1UcpIVClUcm+pIJQLokU7vpFi/pY0YuDLHhIQF7Ul7fHisjVXgo/QMPsN4zNA
         qvUjHvCGblWlTl+FWtWkLV2l1cODp3AeRnqhru5LUlfDB5gx/Bh0zGpJfe+dehW6+ipy
         mMst1+CnHmzauGYI+AeSaY4F1/i1fDsEoQbdXEcPrwjSpJtly1w53TuoP266cXZ15WAb
         DgdFaBxSR14MkiEHQ/sbNIvlGZOTew8vOGN8vFmi+9InhOP7+mh7ipdOBwq8cXx8mOld
         T8+Ht68DVP0pobxYKtf0yEula3Bt77QUp/vVVFR5AIUsP+zd6Fq5LssxTKHs8v5qEyCz
         lxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354157; x=1788958957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZ7hMm+JsrbyLw5rJV9QF2bd+yWe5jIr9Rjm13SbtbU=;
        b=CXG/FdzkfSaJG5LWmihAPtMZKsLl0toHwF7q5QH5HfejoipOP1fnpX97DMladRT0cO
         hXS4jr7N9//yuPXAHevW58xrScwhKsGMK3jwameLH6nEN5NnxL+vJ8IZIrjDFtGpuDxd
         oxeKveJ8y9yLGEcViCBJd4DxugzoVJT0sGKVL5f54fegyVNiVrk/mVrIh5Qm1LhO0eQp
         8CQuWcQ1Uo+EGcybBP99MjyXYXJN91sURT/iz83BpiwCjERbs3BZ5HAxqu/dpOilNg+g
         lpHJobKkyHk4c+K7xBYZogV5x49Z3tpRtGMPui1kDiGuTyrodnp2uU6Gw2WC4zKVKHnA
         Pfzw==
X-Forwarded-Encrypted: i=1; AKwUvBzX9Zu90RFBG8RsP5Fr+AJ0LqUyJyGNxE4Euqd4ApPhk9wJ3eV87+G8yYyrIYwyB5JAfa/uqhY=@vger.kernel.org
X-Gm-Message-State: AFuF++nFs3pI46GVr6tqT4aL85hlud/Ra3uRxrvpmxDHsYqrvDl51ZYX
	gLJUmcweoT17darTwhrgfdmgSZ/fgqErL+8yUlS7KlvBxZLLHCeRVRaL/s2heOa0RdwnmC7Zr5M
	C5c9TXc6K7tgLbEwbcy/FzNrwEmmnz52I0Uzk+cuL
X-Gm-Gg: AYBFou0w7V68YJ8xDCib6Py3+PihzavKrmpgAILTVAvsTpnwf0EXsHHyZEINWC29/Fr
	H/WhkgilndKTpCylR8Y+aoXYp0mKB8sB6Xi5aJe98ALYnBLUSlzz8HZi6Ng3hbyk5S6cDab4L0N
	Chspr6KvO8Q6p94Vbf5I0ucPkR9xrEVg4RxkJSBVVEQ0+9B7Yf4622W0mCpLQI1VUHEps5T6vf6
	Hlv1JZ96HNbY14LBoRijQ1sYfl9dkKo5ZlsmGYznFTyB0MRXBZroNh9VUk+YDAXrY0OW8KeywBs
	CVi5orp1XMUKnFiyed3IjPm6bHps5bEqcby8sM7tBd6N3Z7cPEPGXycZplASUmmK9kwCRukAMB8
	=
X-Received: by 2002:a17:90b:562e:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-39af57ba71dmr3908216a91.3.1788354156489; Wed, 02 Sep 2026
 06:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901124013.1098560-1-xiangzao@linux.alibaba.com> <20260901124013.1098560-2-xiangzao@linux.alibaba.com>
In-Reply-To: <20260901124013.1098560-2-xiangzao@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 2 Sep 2026 15:01:59 +0200
X-Gm-Features: AcwNN1VGxJFpmL-lU0OnRAVUYxIl406whc4Ms3oZN7-dYh4VYCv_375yVerTGPI
Message-ID: <CAG_fn=UNF=BDJ1mFgMc6Tu0Xwi6c7Gu6Q6RHaugR2ii+nLM+aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] stacktrace: Provide arch_in_event_entry_text() hook
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	luto@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, akpm@linux-foundation.org, rdunlap@infradead.org, 
	elver@google.com, andreyknvl@gmail.com, gor@linux.ibm.com, 
	brads@mainlining.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:40=E2=80=AFPM Yuanhe Shu <xiangzao@linux.alibaba.c=
om> wrote:

> The first user is the FRED fix in the follow-up patch.  Both carry the
> same Fixes: tag and are Cc'ed to stable so that they are picked up as a
> pair.
>
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
Acked-by: Alexander Potapenko <glider@google.com>
