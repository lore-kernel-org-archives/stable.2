Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D6253B42
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596126; cv=pass; b=hBjdL9aeFc1bLqd/K39lbN5RIjzltpmcLggGH9fakW61aAEIzv0MI4quaaqx/rRdgA8kv1WYXXaoxpok4SFR86l4wlC5FeumcTQjC2BIidgy8K2nilnKtOGu2D43bbGBb7HzqO5Q+Xi+cf8SZ/5JkDaETEhqT4C1VQe5R1VinWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596126; c=relaxed/simple;
	bh=Wv9b/dFSHpxedb0iwRWO+tjnufr/6VDhHuR/YLZGbtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXagD9YTGbG6pNokJZtaNZAk+4QaXCgOxN9CjPL5ZW4BPIEPgvh92mpLEzLdt1ZD1Sr9z8hZGBLJk4A1QU8ffbMuYJQWgZ7SbZ7RWCDdCBZz3PihzIYfBXf50ydxhkQ9wXYUml0cxVzeSSqnbAGUgFRehaScefkujtOqkKd/MEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NprT668N; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NprT668N"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso279430e87.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 18:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791596123; cv=none;
        d=google.com; s=arc-20260327;
        b=gztLD23f/3yCn7Yx6vM84IyE7a9jcWCKNTTq53eqp9SoGup8xevmyPD+WK/bPXJWHc
         qLCsWcoU6DvxzHzkSEnMXGLsmtqXD259qsI660ImyEK9bMiiX+rU+2rVWRfAtjJT4HH6
         7pGOlXwAMazfc91c9mJQHsUjqYTw5Wu+m4SfcaU3nrBgME3st+6vNdJPxC2w1jp4jXZb
         qr5GwQqRZYSyswqOiRkg2h9yOiHKVXKuFCWgE0zoow0Ee9aYgfBCEQL73d8dmg7ezfm4
         jFdwcQ3LC1hS0uFLD1ohNWlFVFSaWVIORDXsTAXfx0XRgx7nGMn0AtkSt/A4AxrJqKRb
         eqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zejVRKXMz791oqNwhKPCP6K/7f8h0cFo5JM43ONmEBU=;
        fh=QxhAyv25y0DUhVXt9BsO1XlfWA0eQm7dZdzVSLrUbAA=;
        b=KcLOfnruKx8FxleYACsbJUtZZ55ddTxfG9x5dfQrXvJDcuQF6evV8zlerWZgarkbyG
         /pDYY1AU8DiNT7L1qyk+Qeu69kIjRcDb7avgikxoYCTF6PC9vG6XyW+TdBqg9Q2JYISc
         BwuPlhh9ZbzpXOT+LCYkNi/OHnWxe0BWWlOgSFlyhkl8yvVhlhDtBTX1+zFtLpTuo+jw
         PKQLCkPs7isZRSOxxSzd1kzFyhesOLc+giCZCG4FXhIoB/WDaOL4BBGN5mtH4pEq9R+j
         sCzvz3QyRX+ENVAE2u4ahGFn5Pho5V1QrwLexvp+37uN+jGTWNSLm51jYC//T6vE3BnY
         F2fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791596123; x=1792200923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zejVRKXMz791oqNwhKPCP6K/7f8h0cFo5JM43ONmEBU=;
        b=NprT668N6QdFNZFeOkh3WwwbiuwV/8nOameUxhTnLJ4rCyOllRoxdNxj+7HPicUK7j
         zFJhykYZfxwLwJPbOHyW7VkYGp6BGpgNUdbucVAB/Bhga0DfAY4mza2EWnmD+ClgGNb0
         xVZ01u3lOcDFkjL8P2rnLbnNe86DkDSJjV10/WbAyDeM+Tg/K8AJZbUVq88J8Th2BJUY
         UL5St18IisUIKrAxTCB0a1nYd0Gh+xTGOKtF5L8vflNQOghjEdM0/sYZo8tdaZ8uY6Qk
         9tCN5zgJc3J+B6QfssiskdmVzOM1kplQTVDJPi3zdir+oxfXpPl6RWr5Dg9xfW1+6qfn
         r1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791596123; x=1792200923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zejVRKXMz791oqNwhKPCP6K/7f8h0cFo5JM43ONmEBU=;
        b=PjSoE8n6/JjfCQGiE/O+piuL4YgMm95bMNGJofOG9JO6SApYExZ+X02h2aeSKGyfNM
         V8uXGaF3KB1P5GCEdrRJDVTkGHQy+4aVyUSOyhL+zrRvKFNafbYQ6B0Bz0ueo0lOq1GJ
         PdUjC77f6+d66cEhVQJ5GxIvtdrxhepm2DPnmq5iaPuqQoGQPQPX0bcr6A6HNP2TbL7/
         ef5nM0g0GsbMRKDLTKAIx+qHxPHMQJd/66XjpbGfoHG5vsWyfGVmHwUolMkguAscbHmA
         Sj87z05w/OKV8xIMqivvOoJiBN+2MU+k9yxkOVbtsxe5N6dB+j9+XWEA76zipPcSiQxq
         KcCA==
X-Forwarded-Encrypted: i=1; AKwUvByVVGbZ/FcovvU8+6GZKlhuPVN2Ch8Iwc0z05xADa8zObAZSLznTFEuWwpy1gMRzxwggAj1VdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPzQTa0LZTDsPOFL07gSkJuY4jKgs9VAT8dRKIGL8fWQT/BKV9
	SG6NRDASU5EHiO4OZ/DcvhTqi+5QYXPEA1WZSuX7BuKgEWgNQeES3c5Hhf6/FIT/1iMZCMogWeX
	EmNnNb0dX04RmhECMwxLHv8Zs6mqa+gU=
X-Gm-Gg: AYBFou1zPw6uSFgqIiioe00DEKT6+aTlJev3HeU93sJIdKV+1AMQfVlaomRhXD6pW6y
	78ID5Fe92AupiRvv/5Jtl3sRps4COdF9hQtA9HZEkYyZyFFyXLhgemv0yrgPWnuV4FH61rylHNT
	Ymz09pYuC5MBZlsEcMjroZ2oK5ZsZtW0QFPtUS3AcjaZRd9DXYbw4IaJQBGnwanFzPGOWUW2m1e
	ncJf6eUtHGSa7CoZbbXMCEMY86wPYL4DiUlPxuSRTdEm9p3ctXbnUUnN9Q+wpxDV2/TyACXslIA
	p10p4rDaY7d7Y26svBze3yymwZXlhwm63y0YRh6WYBY7qpzTBDB3hYoqFxNlut1Uqg1dLWl/dmG
	FjH5+pGWPRXkZ2w6a5tq4Tb6VXUtH6jZP7eLscoUfctVK35kQ0drSRPq/pk6E20ijxEIZMVE=
X-Received: by 2002:a05:6512:3b99:b0:5bc:b67d:ad05 with SMTP id
 2adb3069b0e04-5bcde6bdbe3mr1095860e87.11.1791596122879; Fri, 09 Oct 2026
 18:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009212501.971158-1-linmag7@gmail.com> <20261009212501.971158-3-linmag7@gmail.com>
In-Reply-To: <20261009212501.971158-3-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 9 Oct 2026 21:35:05 -0400
X-Gm-Features: AclHuK9__AOLeUIrfKM5_aOsqjMFrmHUxw8TEZQfjZHjbxOf5LFd1-CxAppwYVY
Message-ID: <CAEdQ38Fdbx=pZ5=HmCU0C1=O+gAePAQEtd7w3oGSUX-gkQM4EA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alpha: do not skip TLB shootdown IPIs for
 kthread-borrowed mms
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 9, 2026 at 11:19 PM Magnus Lindholm <linmag7@gmail.com> wrote:
> Change ipi_flush_tlb_mm() and ipi_flush_icache_page() to test current->mm,
> like ipi_flush_tlb_page(). A CPU that only retains the mm lazily then
> clears its own slot through flush_tlb_other(), rather than publishing a
> new ASN on every IPI. Once these historical slots are gone, the shortcut
> is available again if mm_users remains at most one and no other CPU has
> taken or kept a context.

ipi_flush_mm_and_page() in arch/alpha/mm/tlbflush.c still tests
current->active_mm, so a lazy CPU allocates and publishes a new ASN on
every migration rendezvous. The next flush then finds that slot, sends
IPIs, and the lazy CPU clears it again. Nothing breaks, but with
compaction running the shortcut is lost after each migrated page, which
is the case this paragraph says is gone.

I think the handler can take the same test as the other three:

diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
--- a/arch/alpha/mm/tlbflush.c
+++ b/arch/alpha/mm/tlbflush.c
@@ -66,7 +66,7 @@ static void ipi_flush_mm_and_page(void *x)
        struct tlb_mm_and_addr *d = x;

        /* Part 1: mm context side (Alpha uses ASN/context as a key
mechanism). */
-       if (d->mm == current->active_mm && !asn_locked())
+       if (d->mm == current->mm && !asn_locked())
                __load_new_mm_context(d->mm);
        else
                flush_tlb_other(d->mm);

A lazy CPU then clears its slot and still does the tbi() below. Any way
back to the mm from there gets a new ASN: ev5_switch_mm() sees version
0, and kthread_use_mm() goes through the next == current path. I have
not tested that change.

The callers have the same asymmetry. flush_tlb_mm() and
flush_icache_user_page() test current->active_mm, so a kernel thread
that flushes an mm it only holds lazily publishes its own slot. That
one also takes the shortcut in that branch, so I would leave it alone,
but the changelog could say so.

> Order the slot reads after the page-table changes with smp_mb(). On the
> publishing CPU, the store in ev5_switch_mm() precedes the scheduler's
> post-switch barrier in finish_lock_switch().

The barrier there is the mb() in alpha's arch_spin_unlock(). The
scheduler does not promise a full barrier when it drops the rq lock, so
this is an alpha property, and nothing at the store says it is being
relied on. Could the changelog name it, and the store get a comment?
Something like:

                mmc = __get_new_mm_context(next_mm, cpu);
+               /*
+                * Ordered before any use of the mm by the mb() in
+                * arch_spin_unlock(), when finish_lock_switch() drops
+                * the rq lock.
+                */
                WRITE_ONCE(next_mm->context[cpu], mmc);

The rest looks right to me. I went through the window between
finish_lock_switch() and check_mmu_context(): an IPI there clears the
slot under asn_lock, a flush on another CPU can then take the shortcut,
and check_mmu_context() sees the zero and loads a new context behind
the new smp_mb(). The three points from my v2 review are addressed.

The fork numbers in the cover letter are from before the handler
change. It would be good to have them again for this version, along
with an SMP run under compaction.

With ipi_flush_mm_and_page() changed, or the changelog reworded to
match what it does:

Reviewed-by: Matt Turner <mattst88@gmail.com>
