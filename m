Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5D47142C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936907; cv=none; b=hpL1Cdokc4kkZT4d+0we2I1RwNrF4bI3ZuEdlilXS5+KOwp04keB2aBkEiu0HfY6xbDaDt9f9wx9wx+yuxFY45U2H2SUpOckHApumwx+mHpSB9mcKhyNpEL2GihBUF7AVfdfepK3tXd8mVn+0Tq0pzj0kcqVBMyC3e/8JODp+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936907; c=relaxed/simple;
	bh=8JBRpOeiOY+Me7oAb6fyHzfpzC6aAxs+etzsMAdQr8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUMZBGEixVGNn4rTI9Bw7wwAC4SxteLeGirUu2+QyaKxryLSDHqgO+H+tOQqHfHgEogaamxtpAiSrCenyopNQ4V+GrqIWrCW4kXNfhFYQCu1M0bb0xWyrThblPxVJULFIK3dRedtiZ/9j1eXbVmANDaygLhsoKhuOBYd1J9BqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TDKWlqkL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TDKWlqkL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6219153B;
	Wed,  5 Aug 2026 06:34:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5726C3F66F;
	Wed,  5 Aug 2026 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785936903; bh=8JBRpOeiOY+Me7oAb6fyHzfpzC6aAxs+etzsMAdQr8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDKWlqkLl4v/1chvARizg+HbWc350DWBeDrsrC+jNbNat7d+Yk440letDKcPRDiZS
	 xrkemB62DwQnG1TbYTR49CI8IvaTgkKl+NyX1DRAvWMXlZATVKPvQ+kpclZIEBIaJT
	 KZBn5UJsq4B4q+oiBU78jM0Qj0cXBuMDmxAHWKAY=
Date: Wed, 5 Aug 2026 14:34:57 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	david@kernel.org, david.laight.linux@gmail.com, james.morse@arm.com,
	ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
	ruanjinjie@huawei.com, stable@vger.kernel.org,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 14/20] arm64: percpu: Implement preemptible read/write
 ops
Message-ID: <anM8AW4N81iDqP-V@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-15-mark.rutland@arm.com>
 <00a85d9a-8727-4b89-b33b-ce2d3358355c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a85d9a-8727-4b89-b33b-ce2d3358355c@arm.com>

On Wed, Aug 05, 2026 at 10:24:04AM +0100, Ryan Roberts wrote:
> On 04/08/2026 18:04, Mark Rutland wrote:
> > ---
> FYI I'm seeing build warnings caused by this patch (with ftrace enabled - based 
> on the warnings, I'm guessing that's the key bit), using:
> 
> aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> I haven't investigated the cause.

Thanks for the heads-up.

This is an unfortunate effect of the casting in this_cpu_write_##sz
wrappers:

(1) For cases where pcp is itself a pointer, compilers warn for the
    unreachable (sz != 8) cases, unless we add a cast to unsigned long
    in all of the cases.

(2) With the cast, compilers warn about implicit truncation (as you're
    seeing here), where we've performed redundant extension in the first
    place.

To workaround that I believe we need an explicit cast somewhere, unless we can
get the compilers to realise the other cases are obviously unreachable. Two
possible workarounds:

(a) We make __percpu_write_##sz() take an unsigned long, and cast it
    down to u##sz in the asm arguments.

(b) We update this_cpu_write_{1,2,4,8} with {u8,u16,u32,u64} casts,
    applied after the unsigned long cast.

For now, (a) is the simplest, as below. I'll see if there's a better option.q

Mark.

---->8----
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index d868a88960123..dd49d14d9cd91 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -149,7 +149,7 @@ static inline unsigned long __percpu_read_##sz(void __percpu *pcp)          \
        return val;                                                             \
 }                                                                              \
                                                                                \
-static inline void __percpu_write_##sz(void __percpu *pcp, u##sz val)          \
+static inline void __percpu_write_##sz(void __percpu *pcp, unsigned long val)  \
 {                                                                              \
        u16 *gprs = &current_thread_info()->pcpu_gprs;                          \
        unsigned long off;                                                      \
@@ -161,7 +161,7 @@ static inline void __percpu_write_##sz(void __percpu *pcp, u##sz val)               \
        : [gprs] "=Qo" (*gprs),                                                 \
          [off] "=&r" (off)                                                     \
        : [pcp] "r" (pcp),                                                      \
-         [val] "r" (val)                                                       \
+         [val] "r" ((u##sz)val)                                                \
        : "memory"                                                              \
        );                                                                      \
 }
